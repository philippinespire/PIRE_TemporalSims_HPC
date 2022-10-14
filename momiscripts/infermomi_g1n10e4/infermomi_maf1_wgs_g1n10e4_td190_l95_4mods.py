import os
os.environ["OMP_NUM_THREADS"] = "1"
import momi
import multiprocessing
import numpy as np
from autograd.numpy import log 

dir = '/projects/f_mlp195/brendanr/'
sim = 'g1_n10e4_td190_l95_n500'

def momi_inference(it,dat,maf):
	datadir = dir + sim + "/constant_recap/vcf/"
	# read sfs into python!
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_contemp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - contemporary samples, constant pop size
	model_inf_cons_t0 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_cons_t0.set_data(sfs)
	#define parameters to infer
	model_inf_cons_t0.add_size_param("n_contemp",lower=1e1,upper=5e6)
	#add contemp pop
	model_inf_cons_t0.add_leaf("t0",N="n_contemp")
	#infer parameters
	model_inf_cons_t0.optimize(method="TNC")
	#####set model for inference - contemporary samples, decline
	model_inf_dec_t0 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_dec_t0.set_data(sfs)
	#define parameters to infer - model with size change and unknown time of decline
	model_inf_dec_t0.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_dec_t0.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_dec_t0.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	#add contemp pop and size change event
	model_inf_dec_t0.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_dec_t0.set_size('t0',g=0,t="t_decline")
	#infer parameters
	model_inf_dec_t0.optimize(method="TNC")
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_2samp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - t0t120, constant
	model_inf_cons_t0t120 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_cons_t0t120.set_data(sfs)
	#define parameters to infer
	model_inf_cons_t0t120.add_size_param("n_contemp",lower=1e1,upper=1e6)
	#add populations
	model_inf_cons_t0t120.add_leaf("t120",N="n_contemp",t=120)
	model_inf_cons_t0t120.add_leaf("t0",N="n_contemp")
	model_inf_cons_t0t120.move_lineages("t0","t120",t=120.01)
	#infer parameters
	model_inf_cons_t0t120.optimize(method="TNC")
	#####set model for inference - t0t120, decline
	model_inf_dec_t0t120 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_dec_t0t120.set_data(sfs)
	#define parameters to infer - model with size change and unknown time of decline
	model_inf_dec_t0t120.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_dec_t0t120.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_dec_t0t120.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	#add contemp pop and size change event
	model_inf_dec_t0t120.add_leaf('t120',N="n_historic",t=120)
	model_inf_dec_t0t120.add_leaf('t0',N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_dec_t0t120.move_lineages('t0',"t120",t=120.01)
	model_inf_dec_t0t120.set_size('t0',g=0,t="t_decline")	#infer parameters
	#infer parameters
	model_inf_dec_t0t120.optimize(method="TNC")
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_serial_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - serial, constant
	model_inf_cons_all =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_cons_all.set_data(sfs)
	#define parameters to infer
	model_inf_cons_all.add_size_param("n_contemp",lower=1e1,upper=1e6)
	#add populations
	model_inf_cons_all.add_leaf("t120",N="n_contemp",t=120)
	model_inf_cons_all.add_leaf("t90",N="n_contemp",t=90)
	model_inf_cons_all.add_leaf("t60",N="n_contemp",t=60)
	model_inf_cons_all.add_leaf("t30",N="n_contemp",t=30)
	model_inf_cons_all.add_leaf("t0",N="n_contemp")
	model_inf_cons_all.move_lineages("t90","t120",t=120.01)
	model_inf_cons_all.move_lineages("t60","t90",t=90.01)
	model_inf_cons_all.move_lineages("t30","t60",t=60.01)
	model_inf_cons_all.move_lineages("t0","t30",t=30.01)
	#infer parameters
	model_inf_cons_all.optimize(method="TNC")
	#####set model for inference - decline, all timepoints
	model_inf_dec_all =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_dec_all.set_data(sfs)
	#set params
	model_inf_dec_all.add_size_param("n_contemp",lower=1e1,upper=5e6)
	model_inf_dec_all.add_size_param("n_historic",lower=1e1,upper=5e6)
	model_inf_dec_all.add_time_param("t_decline",lower=1e1,upper=1.2e2)
	#decline
	model_inf_dec_all.add_leaf("t120",N="n_historic",t=120)
	model_inf_dec_all.add_leaf("t90",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**30),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=90)
	model_inf_dec_all.add_leaf("t60",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**60),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=60)
	model_inf_dec_all.add_leaf("t30",N=lambda params: params.n_historic*((1+(log(params.n_contemp/params.n_historic)/params.t_decline))**90),g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline,t=30)
	model_inf_dec_all.add_leaf("t0",N="n_contemp",g=lambda params: log(params.n_contemp/params.n_historic)/params.t_decline)
	model_inf_dec_all.move_lineages("t90","t120",t=120.01)
	model_inf_dec_all.move_lineages("t60","t90",t=90.01)
	model_inf_dec_all.move_lineages("t30","t60",t=60.01)
	model_inf_dec_all.move_lineages("t0","t30",t=30.01)
	#infer parameters
	model_inf_dec_all.optimize(method="TNC")	
	#############
	##2change!!##
	#############
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
	#############
	##hchange!!##
	#############
	# read sfs into python!
	sfsfile= datadir + 'i' + str(it) + '_' + str(dat) + '_contemp_' + str(maf) + '.sfs.gz'
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - contemporary samples, historic size change only
	model_inf_hchange_t0 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_hchange_t0.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_hchange_t0.add_size_param('n_contemp',lower=1e1,upper=5e6)
	model_inf_hchange_t0.add_size_param('n_ancient',lower=1e1,upper=5e6)
	model_inf_hchange_t0.add_time_param('t_ancient',lower=1e3,upper=1e5)
	model_inf_hchange_t0.add_leaf('t0',N='n_contemp')
	model_inf_hchange_t0.set_size('t0', N='n_ancient', t='t_ancient')
	model_inf_hchange_t0.optimize(method='TNC')
	#####set data
	sfsfile= datadir + 'i' + str(it) + '_' + str(dat) + '_2samp_' + str(maf) + '.sfs.gz'
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - 2 samples, two size changes
	model_inf_hchange_t0t120 =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_hchange_t0t120.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_hchange_t0t120.add_size_param('n_contemp',lower=1e1,upper=5e6)
	model_inf_hchange_t0t120.add_size_param('n_ancient',lower=1e1,upper=5e6)
	model_inf_hchange_t0t120.add_time_param('t_ancient',lower=1e3,upper=1e5)
	model_inf_hchange_t0t120.add_leaf('t120',N='n_contemp',t=120)
	model_inf_hchange_t0t120.add_leaf('t0',N='n_contemp')
	model_inf_hchange_t0t120.move_lineages('t0','t120',t=120.01)
	model_inf_hchange_t0t120.set_size('t120', N='n_ancient', t='t_ancient')
	model_inf_hchange_t0t120.optimize(method='TNC')
	#####set data
	sfsfile= datadir + 'i' + str(it) + '_' + str(dat) + '_serial_' + str(maf) + '.sfs.gz'
	sfs = momi.Sfs.load(sfsfile)
	#####set model for inference - serial samples, two size changes
	model_inf_hchange_all =  momi.DemographicModel(N_e=1e4, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_hchange_all.set_data(sfs)
	#set parameter to infer - inferring constant pop size using contemporary data only
	model_inf_hchange_all.add_size_param('n_contemp',lower=1e1,upper=5e6)
	model_inf_hchange_all.add_size_param('n_ancient',lower=1e1,upper=5e6)
	model_inf_hchange_all.add_time_param('t_ancient',lower=1e3,upper=1e5)
	model_inf_hchange_all.add_leaf('t120',N='n_contemp',t=120)
	model_inf_hchange_all.add_leaf('t90',N='n_contemp',t=90)
	model_inf_hchange_all.add_leaf('t60',N='n_contemp',t=60)
	model_inf_hchange_all.add_leaf('t30',N='n_contemp',t=30)
	model_inf_hchange_all.add_leaf('t0',N='n_contemp')
	model_inf_hchange_all.move_lineages('t90','t120',t=120.01)
	model_inf_hchange_all.move_lineages('t60','t90',t=90.01)
	model_inf_hchange_all.move_lineages('t30','t60',t=60.01)
	model_inf_hchange_all.move_lineages('t0','t30',t=30.01)
	model_inf_hchange_all.set_size('t120', N='n_ancient', t='t_ancient')
	model_inf_hchange_all.optimize(method='TNC')
	#output/compute estimates, log likelihood, and AIC
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
	tn=model_inf_cons_t0t120.get_params().get('n_contemp')
	nparam3=len(model_inf_cons_t0t120.get_params())
	lik3=model_inf_cons_t0t120.log_likelihood()
	AIC3=2*nparam3-2*lik3
	tnh=model_inf_dec_t0t120.get_params().get('n_historic')
	tnc=model_inf_dec_t0t120.get_params().get('n_contemp')
	tt=model_inf_dec_t0t120.get_params().get('t_decline')
	nparam4=len(model_inf_dec_t0t120.get_params())
	lik4=model_inf_dec_t0t120.log_likelihood()
	AIC4=2*nparam4-2*lik4
	alln=model_inf_cons_all.get_params().get('n_contemp')
	nparam5=len(model_inf_cons_all.get_params())
	lik5=model_inf_cons_all.log_likelihood()
	AIC5=2*nparam5-2*lik5
	allnh=model_inf_dec_all.get_params().get('n_historic')
	allnc=model_inf_dec_all.get_params().get('n_contemp')
	allt=model_inf_dec_all.get_params().get('t_decline')
	nparam6=len(model_inf_dec_all.get_params())
	lik6=model_inf_dec_all.log_likelihood()
	AIC6=2*nparam6-2*lik6
	#############
	##2change!!##
	#############
	#output/compute estimates, log likelihood, and AIC
	cnh2c=model_inf_2change_t0.get_params().get('n_historic')
	cnc2c=model_inf_2change_t0.get_params().get('n_contemp')
	cna2c=model_inf_2change_t0.get_params().get('n_ancient')
	ctd2c=model_inf_2change_t0.get_params().get('t_decline')
	cta2c=model_inf_2change_t0.get_params().get('t_ancient')
	nparamc2c=len(model_inf_2change_t0.get_params())
	likc2c=model_inf_2change_t0.log_likelihood()
	AICc2c=2*nparamc2c-2*likc2c
	tnh2c=model_inf_2change_t0t120.get_params().get('n_historic')
	tnc2c=model_inf_2change_t0t120.get_params().get('n_contemp')
	tna2c=model_inf_2change_t0t120.get_params().get('n_ancient')
	ttd2c=model_inf_2change_t0t120.get_params().get('t_decline')
	tta2c=model_inf_2change_t0t120.get_params().get('t_ancient')
	nparamt2c=len(model_inf_2change_t0t120.get_params())
	likt2c=model_inf_2change_t0t120.log_likelihood()
	AICt2c=2*nparamt2c-2*likt2c
	allnh2c=model_inf_2change_all.get_params().get('n_historic')
	allnc2c=model_inf_2change_all.get_params().get('n_contemp')
	allna2c=model_inf_2change_all.get_params().get('n_ancient')
	alltd2c=model_inf_2change_all.get_params().get('t_decline')
	allta2c=model_inf_2change_all.get_params().get('t_ancient')
	nparamall2c=len(model_inf_2change_all.get_params())
	likall2c=model_inf_2change_all.log_likelihood()
	AICall2c=2*nparamall2c-2*likall2c
	##############
	##historic!!##
	##############
	#output/compute estimates, log likelihood, and AIC
	cnch=model_inf_hchange_t0.get_params().get('n_contemp')
	cnah=model_inf_hchange_t0.get_params().get('n_ancient')
	ctah=model_inf_hchange_t0.get_params().get('t_ancient')
	nparamch=len(model_inf_hchange_t0.get_params())
	likch=model_inf_hchange_t0.log_likelihood()
	AICch=2*nparamch-2*likch
	tnch=model_inf_hchange_t0t120.get_params().get('n_contemp')
	tnah=model_inf_hchange_t0t120.get_params().get('n_ancient')
	ttah=model_inf_hchange_t0t120.get_params().get('t_ancient')
	nparamth=len(model_inf_hchange_t0t120.get_params())
	likth=model_inf_hchange_t0t120.log_likelihood()
	AICth=2*nparamth-2*likth
	allnch=model_inf_hchange_all.get_params().get('n_contemp')
	allnah=model_inf_hchange_all.get_params().get('n_ancient')
	alltah=model_inf_hchange_all.get_params().get('t_ancient')
	nparamallh=len(model_inf_hchange_all.get_params())
	likallh=model_inf_hchange_all.log_likelihood()
	AICallh=2*nparamallh-2*likallh
	#write estimates and model characteristics
	outdir=dir+"momi_out_maf1/"
	os.makedirs(outdir,exist_ok=True)
	estimate=outdir+ sim + "_" + str(dat) + "_estimates_4mods.csv"
	f = open(estimate,"a")
	f.write("Model,Data,it,Nh,Nc,Na,Td,Ta,lnL,AIC"+"\n")
	f.write("Constant,t0,"+str(it)+","+str(cn)+","+str(cn)+","+str(cn)+",NA,NA,"+str(lik1)+","+str(AIC1)+"\n")
	f.write("Change,t0,"+str(it)+","+str(cnh)+","+str(cnc)+","+str(cnh)+","+str(ct)+",NA,"+str(lik2)+","+str(AIC2)+"\n")
	f.write("Constant,t0t120,"+str(it)+","+str(tn)+","+str(tn)+","+str(tn)+",NA,NA,"+str(lik3)+","+str(AIC3)+"\n")
	f.write("Change,t0t120,"+str(it)+","+str(tnh)+","+str(tnc)+","+str(tnh)+","+str(tt)+",NA,"+str(lik4)+","+str(AIC4)+"\n")
	f.write("Constant,all,"+str(it)+","+str(alln)+","+str(alln)+","+str(alln)+",NA,NA,"+str(lik5)+","+str(AIC5)+"\n")
	f.write("Change,all,"+str(it)+","+str(allnh)+","+str(allnc)+","+str(allnh)+","+str(allt)+",NA,"+str(lik6)+","+str(AIC6)+"\n")
	#############
	##2change!!##
	#############
	f.write("2change,t0,"+str(it)+","+str(cnh2c)+","+str(cnc2c)+","+str(cna2c)+","+str(ctd2c)+","+str(cta2c)+","+str(likc2c)+","+str(AICc2c)+"\n")
	f.write("2change,t0t120,"+str(it)+","+str(tnh2c)+","+str(tnc2c)+","+str(tna2c)+","+str(ttd2c)+","+str(tta2c)+","+str(likt2c)+","+str(AICt2c)+"\n")
	f.write("2change,all,"+str(it)+","+str(allnh2c)+","+str(allnc2c)+","+str(allna2c)+","+str(alltd2c)+","+str(allta2c)+","+str(likall2c)+","+str(AICall2c)+"\n")
	##############
	##historic!!##
	##############
	f.write('ancient,t0,'+str(it)+","+str(cnch)+','+str(cnch)+','+str(cnah)+',NA,'+str(ctah)+','+str(likch)+','+str(AICch)+'\n')
	f.write('ancient,t0t120,'+str(it)+","+str(tnch)+','+str(tnch)+','+str(tnah)+',NA,'+str(ttah)+','+str(likth)+','+str(AICth)+'\n')
	f.write('ancient,all,'+str(it)+","+str(allnch)+','+str(allnch)+','+str(allnah)+',NA,'+str(alltah)+','+str(likallh)+','+str(AICallh)+'\n')
	f.close()

#do inference in parallel
a_pool = multiprocessing.Pool(15)
its=list(range(1,6))*3
its.sort()
dats=["n20_wgs","n50_wgs","n100_wgs"]*5
mafs=["maf1"]*15
result = a_pool.starmap(momi_inference, zip(its,dats,mafs))
