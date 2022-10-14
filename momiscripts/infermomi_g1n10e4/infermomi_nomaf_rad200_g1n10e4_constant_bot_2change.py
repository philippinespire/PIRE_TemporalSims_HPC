import momi
import multiprocessing
import numpy as np
from autograd.numpy import log 
import os

dir = "/projects/f_mlp195/brendanr/"
sim = "g1_n10e4_constant_n500"

def momi_inference(it,dat,maf):
	datadir = dir + sim + "/bottleneck_recap/vcf/"
	# read sfs into python!
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_contemp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - contemporary samples, two size changes
	model_inf_2change_t0 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_2change_t0.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_2change_t0.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_2change_t0.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_2change_t0.add_size_param("n_ancient",lower=1e1,upper=5e6)
	model_inf_2change_t0.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	model_inf_2change_t0.add_time_param("t_ancient",lower=1e3,upper=1e5)
	model_inf_2change_t0.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_2change_t0.set_size("t0", N="n_historic", t="t_decline")
	model_inf_2change_t0.set_size("t0", N="n_ancient", t="t_ancient")
	model_inf_2change_t0.optimize(method="TNC")
	#####set data
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_2samp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - 2 samples, two size changes
	model_inf_2change_t0t120 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_2change_t0t120.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_2change_t0t120.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_2change_t0t120.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_2change_t0t120.add_size_param("n_ancient",lower=1e1,upper=5e6)
	model_inf_2change_t0t120.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	model_inf_2change_t0t120.add_time_param("t_ancient",lower=1e3,upper=1e5)
	model_inf_2change_t0t120.add_leaf('t120',N="n_historic",t=120)
	model_inf_2change_t0t120.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_2change_t0t120.move_lineages('t0',"t120",t=120.01)
	model_inf_2change_t0t120.set_size("t120", N="n_ancient", t="t_ancient")
	model_inf_2change_t0t120.optimize(method="TNC")
	#####set data
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_serial_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - serial samples, two size changes
	model_inf_2change_all =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_2change_all.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_2change_all.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_2change_all.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_2change_all.add_size_param("n_ancient",lower=1e1,upper=5e6)
	model_inf_2change_all.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	model_inf_2change_all.add_time_param("t_ancient",lower=1e3,upper=1e5)
	model_inf_2change_all.add_leaf('t120',N="n_historic",t=120)
	model_inf_2change_all.add_leaf("t90",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**30),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=90)
	model_inf_2change_all.add_leaf("t60",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**60),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=60)
	model_inf_2change_all.add_leaf("t30",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**90),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=30)
	model_inf_2change_all.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_2change_all.move_lineages("t90","t120",t=120.01)
	model_inf_2change_all.move_lineages("t60","t90",t=90.01)
	model_inf_2change_all.move_lineages("t30","t60",t=60.01)
	model_inf_2change_all.move_lineages("t0","t30",t=30.01)
	model_inf_2change_all.set_size("t120", N="n_ancient", t="t_ancient")
	model_inf_2change_all.optimize(method="TNC")
	#output/compute estimates, log likelihood, and AIC
	cnh=model_inf_2change_t0.get_params().get('n_historic')
	cnc=model_inf_2change_t0.get_params().get('n_contemp')
	cna=model_inf_2change_t0.get_params().get('n_ancient')
	ctd=model_inf_2change_t0.get_params().get('t_decline')
	cta=model_inf_2change_t0.get_params().get('t_ancient')
	nparamc=len(model_inf_2change_t0.get_params())
	likc=model_inf_2change_t0.log_likelihood()
	AICc=2*nparamc-2*likc
	tnh=model_inf_2change_t0t120.get_params().get('n_historic')
	tnc=model_inf_2change_t0t120.get_params().get('n_contemp')
	tna=model_inf_2change_t0t120.get_params().get('n_ancient')
	ttd=model_inf_2change_t0t120.get_params().get('t_decline')
	tta=model_inf_2change_t0t120.get_params().get('t_ancient')
	nparamt=len(model_inf_2change_t0t120.get_params())
	likt=model_inf_2change_t0t120.log_likelihood()
	AICt=2*nparamt-2*likt
	allnh=model_inf_2change_all.get_params().get('n_historic')
	allnc=model_inf_2change_all.get_params().get('n_contemp')
	allna=model_inf_2change_all.get_params().get('n_ancient')
	alltd=model_inf_2change_all.get_params().get('t_decline')
	allta=model_inf_2change_all.get_params().get('t_ancient')
	nparamall=len(model_inf_2change_all.get_params())
	likall=model_inf_2change_all.log_likelihood()
	AICall=2*nparamall-2*likall
	#write estimates and model characteristics
	outdir=dir+"momi_out_nomaf/"
	os.makedirs(outdir,exist_ok=True)
	estimate=outdir+ sim + "_" + str(dat) + "_bot_estimates_2change.csv"
	f = open(estimate,"a")
	f.write("Model,Data,Nh,Nc,Na,Td,Ta,lnL,AIC"+"\n")
	f.write("2change,t0,"+str(cnh)+","+str(cnc)+","+str(cna)+","+str(ctd)+","+str(cta)+","+str(likc)+","+str(AICc)+"\n")
	f.write("2change,t0t120,"+str(tnh)+","+str(tnc)+","+str(tna)+","+str(ttd)+","+str(tta)+","+str(likt)+","+str(AICt)+"\n")
	f.write("2change,all,"+str(allnh)+","+str(allnc)+","+str(allna)+","+str(alltd)+","+str(allta)+","+str(likall)+","+str(AICall)+"\n")
	f.close()

#do inference in parallel
a_pool = multiprocessing.Pool(15)
its=list(range(1,6))*2
its.sort()
dats=["n200_rad10k","n200_rad50k"]*5
mafs=["nomaf"]*10
result = a_pool.starmap(momi_inference, zip(its,dats,mafs))
