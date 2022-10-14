import subprocess
import multiprocessing
import msprime
import tskit
import numpy as np
import random
import pandas
from operator import itemgetter	

#prereqs: locally install vcftools [and htslib to get tabix and bgzip commands] 

dir="/scratch/br450/SLiM_ped_g1/"

simname="g1_n10e3_td100_l99/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
        allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
        n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
        n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
        n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
        inds=pandas.read_csv(allinds,sep='\t')
        inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
        t0inds = inds.vcf_label[inds['sampling_time'] == 0]
        t30inds = inds.vcf_label[inds['sampling_time'] == 30]
        t60inds = inds.vcf_label[inds['sampling_time'] == 60]
        t90inds = inds.vcf_label[inds['sampling_time'] == 90]
        t120inds = inds.vcf_label[inds['sampling_time'] == 120]
        with open(n100t0120file, "w") as indfile1:
                indfile1.writelines("\n".join(t0inds) + "\n")
                indfile1.writelines("\n".join(t30inds) + "\n")
                indfile1.writelines("\n".join(t60inds) + "\n")
                indfile1.writelines("\n".join(t90inds) + "\n")
                indfile1.writelines("\n".join(t120inds) + "\n")
        with open(n25t0120file, "w") as indfile2:
                indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
                indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
                indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
                indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
                indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
        with open(n10t0120file, "w") as indfile3:
                indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
                indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
                indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
                indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
                indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
        ### make bed files - 2k loci total, 80 per chrom###
        bedlist=[[0,0,0]]*80
        bedlist[0]=[0,0,0]
        i=0
        while i < 80:
                radstart=random.randint(1,29999850)
                allstarts=[ row[1] for row in bedlist ]
                if(abs(radstart - any(allstarts)) > 1000):
                        radend=radstart+149
                        bedlist[i]=[str(c),str(radstart),str(radend)]
                else:
                        continue
                i+=1
        bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
        bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
        with open(bedfile2k, 'w') as bedfile1:
                bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
        ### make bed files - 10k loci, 400 per chrom###
        bedlist=[[0,0,0]]*400
        i=0
        while i < 400:
                radstart=random.randint(1,29999850)
                allstarts=[ row[1] for row in bedlist ]
                if(abs(radstart - any(allstarts)) > 1000):
                        radend=radstart+149
                        bedlist[i]=[str(c),str(radstart),str(radend)]
                else:
                        continue
                i+=1
        bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
        bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
        with open(bedfile10k, 'w') as bedfile2:
                bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
        ### make bed files - 50k loci, 2k per chrom###
        bedlist=[[0,0,0]]*2000
        i=0
        while i < 2000:
                radstart=random.randint(1,29999850)
                allstarts=[ row[1] for row in bedlist ]
                if(abs(radstart - any(allstarts)) > 1000):
                        radend=radstart+149
                        bedlist[i]=[str(c),str(radstart),str(radend)]
                else:
                        continue
                i+=1
        bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
        bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
        with open(bedfile50k, 'w') as bedfile3:
                bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)

#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))


simname="g1_n10e3_td100_l95/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))





simname="g1_n10e3_td130_l99/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))





simname="g1_n10e3_td130_l95/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))






simname="g1_n10e3_td160_l99/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))





simname="g1_n10e3_td160_l95/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))






simname="g1_n10e3_td190_l99/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))





simname="g1_n10e3_td190_l95/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))







simname="g1_n10e3_constant/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=dir+simname+"i"+str(i)+"_individuals_tsk.txt"
	n100t0120file=dir+simname+"i"+str(i)+"_n100t0120.txt"
	n25t0120file=dir+simname+"i"+str(i)+"_n25t0120.txt"
	n10t0120file=dir+simname+"i"+str(i)+"_n10t0120.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n100t0120file, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n25t0120file, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n10t0120file, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
	### make bed files - 2k loci total, 80 per chrom###
	bedlist=[[0,0,0]]*80
	bedlist[0]=[0,0,0]
	i=0
	while i < 80:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile2k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed2k.bed"
	with open(bedfile2k, 'w') as bedfile1:
		bedfile1.writelines('\t'.join(line) + '\n' for line in bedlistsort)
	### make bed files - 10k loci, 400 per chrom###
	bedlist=[[0,0,0]]*400
	i=0
	while i < 400:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile10k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
	with open(bedfile10k, 'w') as bedfile2:
		bedfile2.writelines('\t'.join(i) + '\n' for i in bedlistsort)
	### make bed files - 50k loci, 2k per chrom###
	bedlist=[[0,0,0]]*2000
	i=0
	while i < 2000:
		radstart=random.randint(1,29999850)
		allstarts=[ row[1] for row in bedlist ]
		if(abs(radstart - any(allstarts)) > 1000):
			radend=radstart+149
			bedlist[i]=[str(c),str(radstart),str(radend)]
		else:
			continue
		i+=1
	bedlistsort=sorted(bedlist, key=lambda x: int(x[1]))
	bedfile50k = dir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))
