###recapitate SLiMulations with ancient expansion

import pyslim
import msprime
import tskit
import multiprocessing
import os

### number of breeders
nbreeder = 1000

###ancient scenario
scenario="expansion"

###specify input files
dir="/scratch/br450/SLiM_ped_g3/"

###scenario
simname="g3_n10e3_td100_l99/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td130_l99/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td130_l95/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td160_l99/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td160_l95/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td190_l99/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_td190_l95/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))



###scenario
simname="g3_n10e3_constant/"

###output file directory
outdir=dir+simname+scenario+"_recap/"

if not os.path.exists(outdir):
    os.makedirs(outdir)

def run_recap(i,c):
	tsname=dir+simname+"i"+str(i)+"_chr_"+str(c)+".trees"
	outfile=outdir+"i"+str(i)+"_chr_"+str(c)+"_recap.trees"
	slim_ts = pyslim.load(tsname)
	recap_constant_ts = slim_ts.recapitate(recombination_rate=1e-8, Ne=nbreeder,demographic_events=[msprime.PopulationParametersChange(time=nbreeder,initial_size=nbreeder*10)])
	recap_constant_ts.dump(outfile)

#recapitate all slimulations in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_recap, zip(its,chrs))
