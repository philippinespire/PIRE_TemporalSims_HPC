import momi
import multiprocessing

dir="/scratch/br450/SLiM_ped_g1/"
sim="g1_n10e3_constant/"

outdir="/projects/f_mlp195/brendanr/"
outsim="g1_n10e3_constant_n500_test/"

def allele_counts(i,c):
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n50_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_rad10k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n50_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_rad50k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n100_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_rad10k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n100_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_rad50k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n200_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n200_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n200_rad10k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n200_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n200_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n200_rad50k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n500_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n500_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n500_rad10k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n500_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n500_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n500_rad50k_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n20_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n20_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n20_wgs_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n50_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_wgs_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n100_c_nomaf.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_wgs_chr" + str(c) + "_nomaf.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n50_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_rad10k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n50_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_rad50k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n100_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_rad10k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n100_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_rad50k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n200_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n200_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n200_rad10k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n200_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n200_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n200_rad50k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad10k_n500_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n500_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed10k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n500_rad10k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_rad50k_n500_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n500_ind2pop.txt"
	bedfile = dir + sim + "i" + str(i) + "_chr_" + str(c) + "_bed50k.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n500_rad50k_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n20_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n20_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n20_wgs_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n50_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n50_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n50_wgs_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	vcffile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_chr_" + str(c) + "_wgs_n100_c_maf1.recode.vcf.gz"
	ind2popfile = outdir + outsim + "i" + str(i) + "_n100_ind2pop.txt"
	bedfile = dir + "chr_"+str(c)+"_wgs.bed"
	outfile = outdir + outsim + "constant_recap/vcf/i" + str(i) + "_n100_wgs_chr" + str(c) + "_maf1.snpAlleleCounts.gz"
	with open(ind2popfile) as f:
		ind2popdict = dict([l.split() for l in f])
	sfs=momi.SnpAlleleCounts.read_vcf(vcf_file=vcffile,ind2pop=ind2popdict,bed_file=bedfile,ancestral_alleles=False)
	sfs.dump(outfile)
	
#calculate sfs in parallel
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(allele_counts, zip(its,chrs))
