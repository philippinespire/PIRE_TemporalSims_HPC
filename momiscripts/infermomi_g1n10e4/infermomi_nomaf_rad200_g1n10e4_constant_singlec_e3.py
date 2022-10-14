import os
os.environ["OMP_NUM_THREADS"] = "1"
import momi
import multiprocessing
import numpy as np
from autograd.numpy import log

dir="/projects/f_mlp195/brendanr/"
sim="g1_n10e4_constant_n500"

####

def momi_inference(it,dat,maf,eprop):
	datadir = dir + sim + "/constant_recap/vcf/"
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_contemp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	sfs_mod = momi.Sfs.load(sfsfile)
	nsites=round(sfs.length/sfs.n_loci)
	nind=int(sfs.sampled_n/2)
	nerrors=eprop*nind*nsites
	errordist=np.random.poisson(nerrors,100)
	for i in range(100):
		sfs_mod.freqs_matrix[0,i]=sfs_mod.freqs_matrix[0,i]+errordist[i]
	#####set model for inference - contemporary samples, constant pop size
	model_inf_cons_t0 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_cons_t0.set_data(sfs_mod)
	#define parameters to infer
	model_inf_cons_t0.add_size_param("n_contemp",lower=1e1,upper=5e6)
	#add contemp pop
	model_inf_cons_t0.add_leaf("t0",N="n_contemp")
	#infer parameters
	model_inf_cons_t0.optimize(method="TNC")
	#####set model for inference - contemporary samples, decline
	model_inf_dec_t0 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_dec_t0.set_data(sfs_mod)
	#define parameters to infer - model with size change and unknown time of decline
	model_inf_dec_t0.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_dec_t0.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_dec_t0.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	#add contemp pop and size change event
	model_inf_dec_t0.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_dec_t0.set_size('t0',g=0,t="t_decline")
	#infer parameters
	model_inf_dec_t0.optimize(method="TNC")
	#####set model for inference - contemporary samples, two size changes
	model_inf_2change_t0 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_2change_t0.set_data(sfs_mod)
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
	#####set model for inference - contemporary samples, historic size change only
	model_inf_hchange_t0 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_hchange_t0.set_data(sfs_mod)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_hchange_t0.add_size_param('n_contemp',lower=1e1,upper=5e6)
	model_inf_hchange_t0.add_size_param('n_ancient',lower=1e1,upper=5e6)
	model_inf_hchange_t0.add_time_param('t_ancient',lower=1e3,upper=1e5)
	model_inf_hchange_t0.add_leaf('t0',N='n_contemp')
	model_inf_hchange_t0.set_size('t0', N='n_ancient', t='t_ancient')
	model_inf_hchange_t0.optimize(method='TNC')
	cn=model_inf_cons_t0.get_params().get('n_contemp')
	nparam1=len(model_inf_cons_t0.get_params())
	lik1=model_inf_cons_t0.log_likelihood()
	AIC1=2*nparam1-2*lik1
	cnh=model_inf_dec_t0.get_params().get('n_historic')
	cnc=model_inf_dec_t0.get_params().get('n_contemp')
	ct=model_inf_dec_t0.get_params().get('t_decline')
	nparam2=len(model_inf_dec_t0.get_params())
	lik2=model_inf_dec_t0.log_likelihood()
	AIC2=2*nparam2-2*lik2
	cnh2c=model_inf_2change_t0.get_params().get('n_historic')
	cnc2c=model_inf_2change_t0.get_params().get('n_contemp')
	cna2c=model_inf_2change_t0.get_params().get('n_ancient')
	ctd2c=model_inf_2change_t0.get_params().get('t_decline')
	cta2c=model_inf_2change_t0.get_params().get('t_ancient')
	nparamc2c=len(model_inf_2change_t0.get_params())
	likc2c=model_inf_2change_t0.log_likelihood()
	AICc2c=2*nparamc2c-2*likc2c
	cnch=model_inf_hchange_t0.get_params().get('n_contemp')
	cnah=model_inf_hchange_t0.get_params().get('n_ancient')
	ctah=model_inf_hchange_t0.get_params().get('t_ancient')
	nparamch=len(model_inf_hchange_t0.get_params())
	likch=model_inf_hchange_t0.log_likelihood()
	AICch=2*nparamch-2*likch
	#write estimates and model characteristics
	outdir=dir+"momi_out_nomaf/"
	os.makedirs(outdir,exist_ok=True)
	estimate=outdir+ sim + "_" + str(dat) + "_singlecontemp_e" + str(eprop) + "_4mods_estimates.csv"
	f = open(estimate,"a")
	f.write("Model,Data,it,Nh,Nc,Na,Td,Ta,lnL,AIC"+"\n")
	f.write("Constant,t0,"+str(it)+","+str(cn)+","+str(cn)+","+str(cn)+",NA,NA,"+str(lik1)+","+str(AIC1)+"\n")
	f.write("Change,t0,"+str(it)+","+str(cnh)+","+str(cnc)+","+str(cnh)+","+str(ct)+",NA,"+str(lik2)+","+str(AIC2)+"\n")
	f.write("2change,t0,"+str(it)+","+str(cnh2c)+","+str(cnc2c)+","+str(cna2c)+","+str(ctd2c)+","+str(cta2c)+","+str(likc2c)+","+str(AICc2c)+"\n")
	f.write('ancient,t0,'+str(it)+","+str(cnch)+','+str(cnch)+','+str(cnah)+',NA,'+str(ctah)+','+str(likch)+','+str(AICch)+'\n')
	f.close()

#do inference in parallel
a_pool = multiprocessing.Pool(10)
its=list(range(1,6))*2
its.sort()
dats=["n200_rad10k","n200_rad50k"]*5
mafs=["nomaf"]*10
eprops=[0.001]*10
result = a_pool.starmap(momi_inference, zip(its,dats,mafs,eprops))
