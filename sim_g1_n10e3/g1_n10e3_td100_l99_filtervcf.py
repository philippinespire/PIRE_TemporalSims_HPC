import subprocess
import multiprocessing

dir="/scratch/br450/SLiM_ped_g1/"

simname="g1_n10e3_td100_l99"

def make_filteredvcfs(i,c):
	vcfgz=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf.gz"
	vcfunzip=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_mu1.vcf"
	indfile10=dir+simname+"/i"+str(i)+"_n10t0120.txt"
	indfile25=dir+simname+"/i"+str(i)+"_n25t0120.txt"
	bedfile2k = dir+simname+"/i"+str(i)+"_chr_"+str(c)+"_bed2k.bed"
	bedfile10k = dir+simname+"/i"+str(i)+"_chr_"+str(c)+"_bed10k.bed"
	bedfile50k = dir+simname+"/i"+str(i)+"_chr_"+str(c)+"_bed50k.bed"
	vcffilter1=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n10_c"
	vcffilter2=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_wgs_n25_c"
	vcffilter3=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad2k_n25_c"
	vcffilter4=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad2k_n100_c"
	vcffilter5=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n25_c"
	vcffilter6=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad10k_n100_c"
	vcffilter7=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n25_c"
	vcffilter8=dir+simname+"/constant_recap/vcf/i"+str(i)+"_chr_"+str(c)+"_rad50k_n100_c"
	subprocess.run(['gunzip',vcfgz])
	subprocess.run(['sed','-i','s/ID=1/ID='+str(c)+'/g',vcfunzip])
	subprocess.run(['sed','-i','/^[0-9]/s/./' + str(c) +'/',vcfunzip])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile10), "--recode", "--out",str(vcffilter1)])
	subprocess.run(["bgzip", str(vcffilter1)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter1)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile25), "--recode", "--out",str(vcffilter2)])
	subprocess.run(["bgzip", str(vcffilter2)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter2)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile25), "--bed", str(bedfile2k), "--recode", "--out", str(vcffilter3)])
	subprocess.run(["bgzip", str(vcffilter3)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter3)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--bed", str(bedfile2k), "--recode","--out", str(vcffilter4)])
	subprocess.run(["bgzip", str(vcffilter4)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter4)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile25), "--bed", str(bedfile10k), "--recode", "--out", str(vcffilter5)])
	subprocess.run(["bgzip", str(vcffilter5)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter5)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--bed", str(bedfile10k), "--recode","--out", str(vcffilter6)])
	subprocess.run(["bgzip", str(vcffilter6)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter6)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--keep", str(indfile25), "--bed", str(bedfile50k), "--recode", "--out", str(vcffilter7)])
	subprocess.run(["bgzip", str(vcffilter7)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter7)+".recode.vcf.gz"])
	subprocess.run(["vcftools", "--vcf", str(vcfunzip), "--maf", "0.01", "--bed", str(bedfile50k), "--recode","--out", str(vcffilter8)])
	subprocess.run(["bgzip", str(vcffilter8)+".recode.vcf"])
	subprocess.run(["tabix", "-p", "vcf", str(vcffilter8)+".recode.vcf.gz"])
	subprocess.run(["bgzip", str(vcfunzip)])
	
#filter vcfs in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(make_filteredvcfs, zip(its,chrs))
