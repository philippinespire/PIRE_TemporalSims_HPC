###add mutations to SLiMulations

import pyslim
import msprime
import tskit
import multiprocessing

###mutation rate
murate=1e-8

###specify input files
dir="/scratch/br450/SLiM_ped_g3/"

###scenario
simname="g3_n10e4_td100_l99/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))


###scenario
simname="g3_n10e4_td100_l95/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))


###scenario
simname="g3_n10e4_td130_l99/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_td130_l95/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_td160_l99/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_td160_l95/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_td190_l99/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_td190_l95/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))

###scenario
simname="g3_n10e4_constant/"

def run_mutate(i,c):
	outdir=dir+simname+"bottleneck_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"expansion_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)
	outdir=dir+simname+"constant_recap/"
	tsname=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_mu"+str(int(murate*10e7))+".trees"
	recap_ts = pyslim.load(tsname)
	mut_ts = pyslim.SlimTreeSequence(msprime.mutate(recap_ts, rate=murate, keep=True))
	mut_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_mutate, zip(its,chrs))
