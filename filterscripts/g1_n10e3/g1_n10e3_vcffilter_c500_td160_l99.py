import subprocess
import multiprocessing
import msprime
import tskit
import numpy as np
import random
import pandas
from operator import itemgetter	

#prereqs: locally install vcftools [and htslib to get tabix and bgzip commands] 

###############
###td160_l99###
###############

simdir="/scratch/br450/SLiM_ped_g1/"
simname="g1_n10e3_td160_l99/"

outdir="/projects/f_mlp195/brendanr/"
outname="g1_n10e3_td160_l99_n500/"

#need to make files with tskit IDs for individuals at each sample size
def make_indfiles(i):
	allinds=simdir+simname+"i"+str(i)+"_individuals_c500_tsk.txt"
	n500t0120_contempfile=simdir+simname+"i"+str(i)+"_n500t0120_contemp.txt"
	n200t0120_contempfile=simdir+simname+"i"+str(i)+"_n200t0120_contemp.txt"
	n100t0120_contempfile=simdir+simname+"i"+str(i)+"_n100t0120_contemp.txt"
	n50t0120_contempfile=simdir+simname+"i"+str(i)+"_n50t0120_contemp.txt"
	n20t0120_contempfile=simdir+simname+"i"+str(i)+"_n20t0120_contemp.txt"
	n500t0120_2sampfile=simdir+simname+"i"+str(i)+"_n500t0120_2samp.txt"
	n200t0120_2sampfile=simdir+simname+"i"+str(i)+"_n200t0120_2samp.txt"
	n100t0120_2sampfile=simdir+simname+"i"+str(i)+"_n100t0120_2samp.txt"
	n50t0120_2sampfile=simdir+simname+"i"+str(i)+"_n50t0120_2samp.txt"
	n20t0120_2sampfile=simdir+simname+"i"+str(i)+"_n20t0120_2samp.txt"
	n500t0120_serialfile=simdir+simname+"i"+str(i)+"_n500t0120_serial.txt"
	n200t0120_serialfile=simdir+simname+"i"+str(i)+"_n200t0120_serial.txt"
	n100t0120_serialfile=simdir+simname+"i"+str(i)+"_n100t0120_serial.txt"
	n50t0120_serialfile=simdir+simname+"i"+str(i)+"_n50t0120_serial.txt"
	n20t0120_serialfile=simdir+simname+"i"+str(i)+"_n20t0120_serial.txt"
	inds=pandas.read_csv(allinds,sep='\t')
	inds['sampling_time'] = inds.apply(lambda row: row.birth_time_ago - row.age,axis=1)
	t0inds = inds.vcf_label[inds['sampling_time'] == 0]
	t30inds = inds.vcf_label[inds['sampling_time'] == 30]
	t60inds = inds.vcf_label[inds['sampling_time'] == 60]
	t90inds = inds.vcf_label[inds['sampling_time'] == 90]
	t120inds = inds.vcf_label[inds['sampling_time'] == 120]
	with open(n500t0120_serialfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:100]) + "\n")
		indfile1.writelines("\n".join(t30inds) + "\n")
		indfile1.writelines("\n".join(t60inds) + "\n")
		indfile1.writelines("\n".join(t90inds) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n200t0120_serialfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:40]) + "\n")
		indfile1.writelines("\n".join(t30inds[0:40]) + "\n")
		indfile1.writelines("\n".join(t60inds[0:40]) + "\n")
		indfile1.writelines("\n".join(t90inds[0:40]) + "\n")
		indfile1.writelines("\n".join(t120inds[0:40]) + "\n")
	with open(n100t0120_serialfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:20]) + "\n")
		indfile1.writelines("\n".join(t30inds[0:20]) + "\n")
		indfile1.writelines("\n".join(t60inds[0:20]) + "\n")
		indfile1.writelines("\n".join(t90inds[0:20]) + "\n")
		indfile1.writelines("\n".join(t120inds[0:20]) + "\n")
	with open(n50t0120_serialfile, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile2.writelines("\n".join(t30inds[0:10]) + "\n")
		indfile2.writelines("\n".join(t60inds[0:10]) + "\n")
		indfile2.writelines("\n".join(t90inds[0:10]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:10]) + "\n")
	with open(n20t0120_serialfile, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:4]) + "\n")
		indfile3.writelines("\n".join(t30inds[0:4]) + "\n")
		indfile3.writelines("\n".join(t60inds[0:4]) + "\n")
		indfile3.writelines("\n".join(t90inds[0:4]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:4]) + "\n")	
	with open(n500t0120_2sampfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:400]) + "\n")
		indfile1.writelines("\n".join(t120inds) + "\n")
	with open(n200t0120_2sampfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:100]) + "\n")
		indfile1.writelines("\n".join(t120inds[0:100]) + "\n")
	with open(n100t0120_2sampfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:50]) + "\n")
		indfile1.writelines("\n".join(t120inds[0:50]) + "\n")
	with open(n50t0120_2sampfile, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:25]) + "\n")
		indfile2.writelines("\n".join(t120inds[0:25]) + "\n")
	with open(n20t0120_2sampfile, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:10]) + "\n")
		indfile3.writelines("\n".join(t120inds[0:10]) + "\n")		
	with open(n500t0120_contempfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds) + "\n")
	with open(n200t0120_contempfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:200]) + "\n")
	with open(n100t0120_contempfile, "w") as indfile1:
		indfile1.writelines("\n".join(t0inds[0:100]) + "\n")
	with open(n50t0120_contempfile, "w") as indfile2:
		indfile2.writelines("\n".join(t0inds[0:50]) + "\n")
	with open(n20t0120_contempfile, "w") as indfile3:
		indfile3.writelines("\n".join(t0inds[0:20]) + "\n")

a_pool = multiprocessing.Pool()
result = a_pool.map(make_indfiles, range(1,6))

#make .bed files for producing rad-like data
def make_bedfiles(it,c):
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
	bedfile10k = simdir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed10k.bed"
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
	bedfile50k = simdir+simname+"i"+str(it)+"_chr_"+str(c)+"_bed50k.bed"
	with open(bedfile50k, 'w') as bedfile3:
		bedfile3.writelines('\t'.join(i) + '\n' for i in bedlistsort)
		
#make beds in parallel (total overkill but why not?)
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_bedfiles, zip(its,chrs))

def make_filteredvcfs_contemp(i,c):
	vcfgzip=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf.gz"
	vcfunzip=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf"
	indfile20=simdir+simname+"i"+str(i)+"_n20t0120_contemp.txt"
	indfile50=simdir+simname+"i"+str(i)+"_n50t0120_contemp.txt"
	indfile100=simdir+simname+"i"+str(i)+"_n100t0120_contemp.txt"
	indfile200=simdir+simname+"i"+str(i)+"_n200t0120_contemp.txt"
	indfile500=simdir+simname+"i"+str(i)+"_n500t0120_contemp.txt"
	bedfile10k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed10k.bed"
	bedfile50k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed50k.bed"
	substitute='s/^1\t/'+str(c)+'\t/g'
	vcffilter1=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_contemp_maf1"
	vcffilter2=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_contemp_maf1"
	vcffilter3=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_contemp_maf1"
	vcffilter4=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_contemp_maf1"
	vcffilter5=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_contemp_maf1"
	vcffilter6=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_contemp_maf1"
	vcffilter7=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_contemp_nomaf"
	vcffilter8=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_contemp_nomaf"
	vcffilter9=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_contemp_nomaf"
	vcffilter10=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_contemp_nomaf"
	vcffilter11=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_contemp_nomaf"
	vcffilter12=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_contemp_nomaf"
	vcffilter13=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_contemp_maf1"
	vcffilter14=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_contemp_nomaf"
	vcffilter15=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_contemp_maf1"
	vcffilter16=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_contemp_maf1"
	vcffilter17=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_contemp_maf1"
	vcffilter18=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_contemp_maf1"
	vcffilter19=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_contemp_nomaf"
	vcffilter20=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_contemp_nomaf"
	vcffilter21=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_contemp_nomaf"
	vcffilter22=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_contemp_nomaf"
	subprocess.run(["gunzip",str(vcfgzip)])
	subprocess.run(["sed", "-i", str(substitute), str(vcfunzip)])
	substitute2='s/contig=<ID=1/contig=<ID='+str(c)+'/g'
	subprocess.run(["sed", "-i", str(substitute2), str(vcfunzip)])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile20), "--recode", "--out",str(vcffilter1)])
	subprocess.run(["bgzip", str(vcffilter1)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter1)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--recode", "--out",str(vcffilter2)])
	subprocess.run(["bgzip", str(vcffilter2)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter2)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter3)])
	subprocess.run(["bgzip", str(vcffilter3)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter3)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile10k), "--recode","--out", str(vcffilter4)])
	subprocess.run(["bgzip", str(vcffilter4)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter4)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter5)])
	subprocess.run(["bgzip", str(vcffilter5)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter5)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile50k), "--recode","--out", str(vcffilter6)])
	subprocess.run(["bgzip", str(vcffilter6)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter6)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile20), "--recode", "--out",str(vcffilter7)])
	subprocess.run(["bgzip", str(vcffilter7)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter7)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--recode", "--out",str(vcffilter8)])
	subprocess.run(["bgzip", str(vcffilter8)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter8)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter9)])
	subprocess.run(["bgzip", str(vcffilter9)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter9)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter10)])
	subprocess.run(["bgzip", str(vcffilter10)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter10)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter11)])
	subprocess.run(["bgzip", str(vcffilter11)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter11)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter12)])
	subprocess.run(["bgzip", str(vcffilter12)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter12)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100), "--recode", "--out",str(vcffilter13)])
	subprocess.run(["bgzip", str(vcffilter13)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter13)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--recode", "--out",str(vcffilter14)])
	subprocess.run(["bgzip", str(vcffilter14)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter14)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter15)])
	subprocess.run(["bgzip", str(vcffilter15)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter15)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter16)])
	subprocess.run(["bgzip", str(vcffilter16)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter16)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter17)])
	subprocess.run(["bgzip", str(vcffilter17)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter17)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter18)])
	subprocess.run(["bgzip", str(vcffilter18)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter18)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter19)])
	subprocess.run(["bgzip", str(vcffilter19)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter19)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter20)])
	subprocess.run(["bgzip", str(vcffilter20)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter20)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),  "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter21)])
	subprocess.run(["bgzip", str(vcffilter21)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter21)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),"--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter22)])
	subprocess.run(["bgzip", str(vcffilter22)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter22)+".recode.vcf.gz"])
	
#filter vcfs in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_filteredvcfs_contemp, zip(its,chrs))

def make_filteredvcfs_2samp(i,c):
	vcfunzip=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf"
	indfile20=simdir+simname+"i"+str(i)+"_n20t0120_2samp.txt"
	indfile50=simdir+simname+"i"+str(i)+"_n50t0120_2samp.txt"
	indfile100=simdir+simname+"i"+str(i)+"_n100t0120_2samp.txt"
	indfile200=simdir+simname+"i"+str(i)+"_n200t0120_2samp.txt"
	indfile500=simdir+simname+"i"+str(i)+"_n500t0120_2samp.txt"
	bedfile10k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed10k.bed"
	bedfile50k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed50k.bed"
	vcffilter1=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_2samp_maf1"
	vcffilter2=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_2samp_maf1"
	vcffilter3=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_2samp_maf1"
	vcffilter4=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_2samp_maf1"
	vcffilter5=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_2samp_maf1"
	vcffilter6=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_2samp_maf1"
	vcffilter7=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_2samp_nomaf"
	vcffilter8=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_2samp_nomaf"
	vcffilter9=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_2samp_nomaf"
	vcffilter10=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_2samp_nomaf"
	vcffilter11=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_2samp_nomaf"
	vcffilter12=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_2samp_nomaf"
	vcffilter13=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_2samp_maf1"
	vcffilter14=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_2samp_nomaf"
	vcffilter15=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_2samp_maf1"
	vcffilter16=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_2samp_maf1"
	vcffilter17=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_2samp_maf1"
	vcffilter18=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_2samp_maf1"
	vcffilter19=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_2samp_nomaf"
	vcffilter20=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_2samp_nomaf"
	vcffilter21=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_2samp_nomaf"
	vcffilter22=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_2samp_nomaf"
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile20), "--recode", "--out",str(vcffilter1)])
	subprocess.run(["bgzip", str(vcffilter1)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter1)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--recode", "--out",str(vcffilter2)])
	subprocess.run(["bgzip", str(vcffilter2)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter2)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter3)])
	subprocess.run(["bgzip", str(vcffilter3)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter3)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile10k), "--recode","--out", str(vcffilter4)])
	subprocess.run(["bgzip", str(vcffilter4)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter4)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter5)])
	subprocess.run(["bgzip", str(vcffilter5)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter5)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile50k), "--recode","--out", str(vcffilter6)])
	subprocess.run(["bgzip", str(vcffilter6)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter6)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile20), "--recode", "--out",str(vcffilter7)])
	subprocess.run(["bgzip", str(vcffilter7)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter7)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--recode", "--out",str(vcffilter8)])
	subprocess.run(["bgzip", str(vcffilter8)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter8)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter9)])
	subprocess.run(["bgzip", str(vcffilter9)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter9)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter10)])
	subprocess.run(["bgzip", str(vcffilter10)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter10)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter11)])
	subprocess.run(["bgzip", str(vcffilter11)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter11)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter12)])
	subprocess.run(["bgzip", str(vcffilter12)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter12)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100), "--recode", "--out",str(vcffilter13)])
	subprocess.run(["bgzip", str(vcffilter13)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter13)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--recode", "--out",str(vcffilter14)])
	subprocess.run(["bgzip", str(vcffilter14)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter14)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter15)])
	subprocess.run(["bgzip", str(vcffilter15)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter15)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter16)])
	subprocess.run(["bgzip", str(vcffilter16)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter16)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter17)])
	subprocess.run(["bgzip", str(vcffilter17)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter17)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter18)])
	subprocess.run(["bgzip", str(vcffilter18)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter18)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter19)])
	subprocess.run(["bgzip", str(vcffilter19)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter19)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter20)])
	subprocess.run(["bgzip", str(vcffilter20)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter20)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),  "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter21)])
	subprocess.run(["bgzip", str(vcffilter21)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter21)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),"--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter22)])
	subprocess.run(["bgzip", str(vcffilter22)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter22)+".recode.vcf.gz"])
	
#filter vcfs in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_filteredvcfs_2samp, zip(its,chrs))

def make_filteredvcfs_serial(i,c):
	vcfunzip=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf"
	indfile20=simdir+simname+"i"+str(i)+"_n20t0120_serial.txt"
	indfile50=simdir+simname+"i"+str(i)+"_n50t0120_serial.txt"
	indfile100=simdir+simname+"i"+str(i)+"_n100t0120_serial.txt"
	indfile200=simdir+simname+"i"+str(i)+"_n200t0120_serial.txt"
	indfile500=simdir+simname+"i"+str(i)+"_n500t0120_serial.txt"
	bedfile10k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed10k.bed"
	bedfile50k = simdir+simname+"i"+str(i)+"_chr_"+str(c)+"_bed50k.bed"
	vcffilter1=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_serial_maf1"
	vcffilter2=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_serial_maf1"
	vcffilter3=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_serial_maf1"
	vcffilter4=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_serial_maf1"
	vcffilter5=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_serial_maf1"
	vcffilter6=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_serial_maf1"
	vcffilter7=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n20_serial_nomaf"
	vcffilter8=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n50_serial_nomaf"
	vcffilter9=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n50_serial_nomaf"
	vcffilter10=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_serial_nomaf"
	vcffilter11=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n50_serial_nomaf"
	vcffilter12=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_serial_nomaf"
	vcffilter13=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_serial_maf1"
	vcffilter14=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n100_serial_nomaf"
	vcffilter15=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_serial_maf1"
	vcffilter16=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_serial_maf1"
	vcffilter17=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_serial_maf1"
	vcffilter18=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_serial_maf1"
	vcffilter19=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n200_serial_nomaf"
	vcffilter20=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n500_serial_nomaf"
	vcffilter21=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n200_serial_nomaf"
	vcffilter22=outdir+outname+"constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n500_serial_nomaf"
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile20), "--recode", "--out",str(vcffilter1)])
	subprocess.run(["bgzip", str(vcffilter1)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter1)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--recode", "--out",str(vcffilter2)])
	subprocess.run(["bgzip", str(vcffilter2)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter2)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter3)])
	subprocess.run(["bgzip", str(vcffilter3)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter3)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile10k), "--recode","--out", str(vcffilter4)])
	subprocess.run(["bgzip", str(vcffilter4)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter4)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter5)])
	subprocess.run(["bgzip", str(vcffilter5)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter5)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100),"--bed", str(bedfile50k), "--recode","--out", str(vcffilter6)])
	subprocess.run(["bgzip", str(vcffilter6)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter6)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile20), "--recode", "--out",str(vcffilter7)])
	subprocess.run(["bgzip", str(vcffilter7)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter7)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--recode", "--out",str(vcffilter8)])
	subprocess.run(["bgzip", str(vcffilter8)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter8)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter9)])
	subprocess.run(["bgzip", str(vcffilter9)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter9)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter10)])
	subprocess.run(["bgzip", str(vcffilter10)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter10)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile50), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter11)])
	subprocess.run(["bgzip", str(vcffilter11)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter11)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter12)])
	subprocess.run(["bgzip", str(vcffilter12)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter12)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile100), "--recode", "--out",str(vcffilter13)])
	subprocess.run(["bgzip", str(vcffilter13)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter13)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile100), "--recode", "--out",str(vcffilter14)])
	subprocess.run(["bgzip", str(vcffilter14)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter14)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter15)])
	subprocess.run(["bgzip", str(vcffilter15)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter15)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter16)])
	subprocess.run(["bgzip", str(vcffilter16)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter16)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter17)])
	subprocess.run(["bgzip", str(vcffilter17)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter17)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter18)])
	subprocess.run(["bgzip", str(vcffilter18)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter18)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile200), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter19)])
	subprocess.run(["bgzip", str(vcffilter19)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter19)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--keep", str(indfile500), "--bed", str(bedfile10k), "--recode","--out", str(vcffilter20)])
	subprocess.run(["bgzip", str(vcffilter20)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter20)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),  "--keep", str(indfile200), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter21)])
	subprocess.run(["bgzip", str(vcffilter21)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter21)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip),"--keep", str(indfile500), "--bed", str(bedfile50k), "--recode","--out", str(vcffilter22)])
	subprocess.run(["bgzip", str(vcffilter22)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter22)+".recode.vcf.gz"])
	
#filter vcfs in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_filteredvcfs_serial, zip(its,chrs))
