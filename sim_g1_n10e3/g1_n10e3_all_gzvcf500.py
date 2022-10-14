### output vcf for each chromosome
import pyslim
import msprime
import tskit
import multiprocessing
import numpy as np
import pandas
import os
import gzip
import shutil

### mutation rate for mutated treeseqs
murate=1e-8

###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_constant/"
outsimname="g1_n10e3_constant_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td100l99


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td100_l99/"
outsimname="g1_n10e3_td100_l99_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td100l95


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td100_l95/"
outsimname="g1_n10e3_td100_l95_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td130l99


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td130_l99/"
outsimname="g1_n10e3_td130_l99_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td130l95


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td130_l95/"
outsimname="g1_n10e3_td130_l95_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td160l99


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td160_l99/"
outsimname="g1_n10e3_td160_l99_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td160l95


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td160_l95/"
outsimname="g1_n10e3_td160_l95_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td190l99


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td190_l99/"
outsimname="g1_n10e3_td190_l99_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))


### td190l95


###specify input files
dir="/scratch/br450/SLiM_ped_g1/"

###output to pinsky lab shared folder
outdir="/projects/f_mlp195/brendanr/"

###scenario
simname="g1_n10e3_td190_l95/"
outsimname="g1_n10e3_td190_l95_n500/"

def make_groups(i):
	###load 1 treeseq
	ex_tsname=dir+simname+"i"+str(i)+"_chr_1.trees"
	ex_ts=pyslim.load(ex_tsname)
	contempindivs = ex_ts.individuals_alive_at(0)
	temp1indivs = ex_ts.individuals_alive_at(30)
	temp2indivs = ex_ts.individuals_alive_at(60)
	temp3indivs = ex_ts.individuals_alive_at(90)
	temp4indivs = ex_ts.individuals_alive_at(120)
	groups = {'contemp' : np.random.choice(contempindivs, replace=False, size=min(500,len(contempindivs))),'temp1' : np.random.choice(temp1indivs, replace=False, size=min(100,len(temp1indivs))),'temp2' : np.random.choice(temp2indivs, replace=False, size=min(100,len(temp2indivs))),'temp3' : np.random.choice(temp3indivs, replace=False, size=min(100,len(temp3indivs))),'temp4' : np.random.choice(temp4indivs, replace=False, size=min(100,len(temp4indivs)))}
	group_order = ['contemp', 'temp1','temp2','temp3','temp4']
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	indivlist = []
	indivnames = []
	with open(indsout, "w") as indfile:
		indfile.writelines("\t".join(["vcf_label", "tskit_id", "slim_id"] + ["birth_time_ago", "age"]) + "\n")
		for group in group_order:
			for i in groups[group]:
				indivlist.append(i)
				ind = ex_ts.individual(i)
				vcf_label = f"tsk_{ind.id}"
				indivnames.append(vcf_label)
				data = [vcf_label, str(ind.id), str(ind.metadata["pedigree_id"]), str(ind.time),str(ind.metadata["age"])]
				indfile.writelines("\t".join(data) + "\n")

##run over all five demographic iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(make_groups, range(1,6))

os.makedirs(outdir+outsimname,exist_ok=True)

def make_vcf(i,c):
	indsout=dir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	inds=pandas.read_csv(indsout,sep='\t')
	indivlist=list(inds["tskit_id"])
	indivnames=list(inds["vcf_label"])
	mut_tsname=dir+simname+"constant_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"constant_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"constant_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as consvcf:
		mut_ts.write_vcf(consvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as consf_in:
		with gzip.open(zipfile, 'wb') as consf_out:
			shutil.copyfileobj(consf_in, consf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"bottleneck_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"bottleneck_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"bottleneck_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as botvcf:
		mut_ts.write_vcf(botvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as botf_in:
		with gzip.open(zipfile, 'wb') as botf_out:
			shutil.copyfileobj(botf_in, botf_out)
	os.remove(vcffile)
	mut_tsname=dir+simname+"expansion_recap/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	mut_ts = pyslim.load(mut_tsname)
	vcffile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf"
	zipfile=outdir+outsimname+"expansion_recap/vcf/"+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".vcf.gz"
	os.makedirs(outdir+outsimname+"expansion_recap/vcf/",exist_ok=True)
	with open(vcffile, "w") as expvcf:
		mut_ts.write_vcf(expvcf, individuals=indivlist, individual_names=indivnames)
	with open(vcffile, 'rb') as expf_in:
		with gzip.open(zipfile, 'wb') as expf_out:
			shutil.copyfileobj(expf_in, expf_out)
	os.remove(vcffile)
	

#generate vcf for all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_vcf, zip(its,chrs))
