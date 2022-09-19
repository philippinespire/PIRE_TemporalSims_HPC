import os
os.environ["OMP_NUM_THREADS"] = "1"
import momi
import multiprocessing
import numpy as np
from autograd.numpy import log

dir="/projects/f_mlp195/brendanr/"
sim="g1_n10e4_td100_l99_n500"

####

def momi_inference(it,dat,maf,eprop):
	datadir = dir + sim + "/constant_recap/vcf/"
	sfsfile= datadir + "i" + str(it) + "_" + str(dat) + "_2samp_" + str(maf) + ".sfs.gz"
	sfs = momi.Sfs.load(sfsfile)
	sfs_mod = momi.Sfs.load(sfsfile)
	nsites=round(sfs.length/sfs.n_loci)
	nind=int(sfs.sampled_n[1]/2)
	nerrors=eprop*nind*nsites
	errordist=np.random.poisson(nerrors,100)
	for i in range(100):
		sfs_mod.freqs_matrix[0,i]=sfs_mod.freqs_matrix[0,i]+errordist[i]
	#####set model for inference - t0t120, constant
	model_inf_cons_t0t120 =  momi.DemographicModel(N_e=1e3, gen_time=1, muts_per_gen=1e-8)
	#add data to model
	model_inf_cons_t0t120.set_data(sfs_mod)
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
	model_inf_dec_t0t120.set_data(sfs_mod)
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
	#output/compute estimates, log likelihood, and AIC
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
	#write estimates and model characteristics
	outdir=dir+"momi_out_nomaf/"
	os.makedirs(outdir,exist_ok=True)
	estimate=outdir+ sim + "_" + str(dat) + "_single2samp_e" + str(eprop) + "_estimates.csv"
	f = open(estimate,"a")
	f.write("Model,Data,Nh,Nc,T,lnL,AIC"+"\n")
	f.write("Constant,t0t120,"+str(tn)+","+str(tn)+",NA,"+str(lik3)+","+str(AIC3)+"\n")
	f.write("Change,t0t120,"+str(tnh)+","+str(tnc)+","+str(tt)+","+str(lik4)+","+str(AIC4)+"\n")
	f.close()

#do inference in parallel
a_pool = multiprocessing.Pool(10)
its=list(range(1,6))*2
its.sort()
dats=["n200_rad10k","n200_rad50k"]*5
mafs=["nomaf"]*10
eprops=[0.00001]*10
result = a_pool.starmap(momi_inference, zip(its,dats,mafs,eprops))
