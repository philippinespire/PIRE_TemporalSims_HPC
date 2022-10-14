import momi
import multiprocessing
import numpy as np
from autograd.numpy import log 
import os

dir = "/projects/f_mlp195/brendanr/"

sim = "g1_n10e3_td190_l95_n500"

def momi_inference(it,dat,maf):
	datadir = dir + sim + "/constant_recap/vcf/"
	os.makedirs(dir+sim+"/momi2_bootstraps/", exist_ok=True)
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
	#bootstrapping
	n_bootstraps = 10
	# make copies of the original models to avoid changing them
	model_inf_cons_t0_copy = model_inf_cons_t0.copy()
	model_inf_dec_t0_copy = model_inf_dec_t0.copy()
	model_inf_cons_t0t120_copy = model_inf_cons_t0t120.copy()
	model_inf_dec_t0t120_copy = model_inf_dec_t0t120.copy()
	model_inf_cons_all_copy = model_inf_cons_all.copy()
	model_inf_dec_all_copy = model_inf_dec_all.copy()
	bootstrap_cons_t0 = []
	bootstrap_dec_t0 = []
	bootstrap_cons_t0t120 = []
	bootstrap_dec_t0t120 = []
	bootstrap_cons_all = []
	bootstrap_dec_all = []
	for i in range(n_bootstraps):
		# resample the data
		resampled_sfs = sfs.resample()
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for constant + contemp")
		# tell model to use the new dataset
		model_inf_cons_t0_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_cons_t0_copy.set_params(randomize=True)
		model_inf_cons_t0_copy.optimize()
		# append results
		bootstrap_cons_t0.append(model_inf_cons_t0_copy.get_params())
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for change + contemp")
		# tell model to use the new dataset
		model_inf_dec_t0_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_dec_t0_copy.set_params(randomize=True)
		model_inf_dec_t0_copy.optimize()
		# append results
		bootstrap_dec_t0.append(model_inf_dec_t0_copy.get_params())
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for constant + t0t120")
		# tell model to use the new dataset
		model_inf_cons_t0t120_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_cons_t0t120_copy.set_params(randomize=True)
		model_inf_cons_t0t120_copy.optimize()
		# append results
		bootstrap_cons_t0t120.append(model_inf_cons_t0t120_copy.get_params())
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for change + t0t120")
		# tell model to use the new dataset
		model_inf_dec_t0t120_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_dec_t0t120_copy.set_params(randomize=True)
		model_inf_dec_t0t120_copy.optimize()
		# append results
		bootstrap_dec_t0t120.append(model_inf_dec_t0t120_copy.get_params())
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for constant + all")
		# tell model to use the new dataset
		model_inf_cons_all_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_cons_all_copy.set_params(randomize=True)
		model_inf_cons_all_copy.optimize()
		# append results
		bootstrap_cons_all.append(model_inf_cons_all_copy.get_params())
		print(f"Fitting {i+1}-th bootstrap out of {n_bootstraps} for change + all")
		# tell model to use the new dataset
		model_inf_dec_all_copy.set_data(resampled_sfs)
		# choose new random parameters for submodel, optimize
		model_inf_dec_all_copy.set_params(randomize=True)
		model_inf_dec_all_copy.optimize()
		# append results
		bootstrap_dec_all.append(model_inf_dec_all_copy.get_params())
	#write bootstrap results
	boot=dir+ sim + "/momi2_bootstraps/" + str(dat) + "_" + str(maf) + "_bootstraps.csv"
	f = open(boot,"a")
	f.write("Model,Data,Param,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10"+"\n")
	f.write("Constant,t0,Nconstant")
	for i in range(len(bootstrap_cons_t0)):
		f.write(',')
		f.write(str(bootstrap_cons_t0[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,t0,Nhistoric")
	for i in range(len(bootstrap_dec_t0)):
		f.write(',')
		f.write(str(bootstrap_dec_t0[i].get('n_historic')))
	f.write('\n')
	f.write("Change,t0,Ncontemporary")
	for i in range(len(bootstrap_dec_t0)):
		f.write(',')
		f.write(str(bootstrap_dec_t0[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,t0,Tbottleneck")
	for i in range(len(bootstrap_dec_t0)):
		f.write(',')
		f.write(str(bootstrap_dec_t0[i].get('t_decline')))
	f.write('\n')
	f.write("Constant,t0t120,Nconstant")
	for i in range(len(bootstrap_cons_t0t120)):
		f.write(',')
		f.write(str(bootstrap_cons_t0t120[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,t0t120,Nhistoric")
	for i in range(len(bootstrap_dec_t0t120)):
		f.write(',')
		f.write(str(bootstrap_dec_t0t120[i].get('n_historic')))
	f.write('\n')
	f.write("Change,t0t120,Ncontemporary")
	for i in range(len(bootstrap_dec_t0t120)):
		f.write(',')
		f.write(str(bootstrap_dec_t0t120[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,t0t120,Tbottleneck")
	for i in range(len(bootstrap_dec_t0t120)):
		f.write(',')
		f.write(str(bootstrap_dec_t0t120[i].get('t_decline')))
	f.write('\n')
	f.write("Constant,all,Nconstant")
	for i in range(len(bootstrap_cons_all)):
		f.write(',')
		f.write(str(bootstrap_cons_all[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,all,Nhistoric")
	for i in range(len(bootstrap_dec_all)):
		f.write(',')
		f.write(str(bootstrap_dec_all[i].get('n_historic')))
	f.write('\n')
	f.write("Change,all,Ncontemporary")
	for i in range(len(bootstrap_dec_all)):
		f.write(',')
		f.write(str(bootstrap_dec_all[i].get('n_contemp')))
	f.write('\n')
	f.write("Change,all,Tbottleneck")
	for i in range(len(bootstrap_dec_all)):
		f.write(',')
		f.write(str(bootstrap_dec_all[i].get('t_decline')))
	f.close()

#do bootstraps in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))
its.sort()
dats=["n50_wgs"]*5
mafs=["nomaf"]*5
result = a_pool.starmap(momi_inference, zip(its,dats,mafs))
