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
###td190_l99###
###############

simdir="/scratch/br450/SLiM_ped_g1/"
simname="g1_n10e3_td190_l99/"

outdir="/projects/f_mlp195/brendanr/"
outname="g1_n10e3_td190_l99_n500/"


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
