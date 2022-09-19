###Python/pyslim code for generating tree sequences under recent demographic decline scenarios

##Import needed packages
import subprocess
import multiprocessing

##set up needed paths
dir="/scratch/br450/SLiM_ped_g3/"

slim_template= dir + "g3_treeseq_template.slim"

##set up directory for scenario: nhistoric=10e3, tdecline=100, lambda=99
output_dir= dir + "g3_n10e3_td100_l99/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=100, lambda=99
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))

##set up directory for scenario: nhistoric=10e3, tdecline=100, lambda=95
##output_dir= dir + "g3_n10e3_td100_l95/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=100, lambda=95
##def run_ts(i,c):
##	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
##	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
##	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
##	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
##	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
##	MOF=output_dir+"i"+str(i)+"_matings.txt"
##	DOF=output_dir+"i"+str(i)+"_deaths.txt"
##	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
##	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
##	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
##a_pool = multiprocessing.Pool()
##its=list(range(1,6))*25
##its.sort()
##chrs=list(range(1,26))*5
##result = a_pool.starmap(run_ts, zip(its,chrs))




##set up directory for scenario: nhistoric=10e3, tdecline=130, lambda=99
output_dir= dir + "g3_n10e3_td130_l99/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=130, lambda=99
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))

##set up directory for scenario: nhistoric=10e3, tdecline=130, lambda=95
output_dir= dir + "g3_n10e3_td130_l95/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=130, lambda=95
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))





##set up directory for scenario: nhistoric=10e3, tdecline=160, lambda=99
output_dir= dir + "g3_n10e3_td160_l99/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=160, lambda=99
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))

##set up directory for scenario: nhistoric=10e3, tdecline=160, lambda=95
output_dir= dir + "g3_n10e3_td160_l95/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=160, lambda=95
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))




##set up directory for scenario: nhistoric=10e3, tdecline=190, lambda=99
output_dir= dir + "g3_n10e3_td190_l99/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=190, lambda=99
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))

##set up directory for scenario: nhistoric=10e3, tdecline=190, lambda=95
output_dir= dir + "g3_n10e3_td190_l95/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=190, lambda=95
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))




##set up directory for scenario: nhistoric=10e3, constant
output_dir= dir + "g3_n10e3_constant/"

##set up function for running a given demographic scenario: nhistoric=10e3, constant
def run_ts(i,c):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	TSOF=output_dir+"i"+str(i)+"_chr_"+str(c)+".trees"
	GOF=output_dir+"i"+str(i)+"_generationfile.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'","-d","treeseqfile='"+TSOF+"'","-d","generationfile='"+GOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
its=list(range(1,6))*25
its.sort()
chrs=list(range(1,26))*5
result = a_pool.starmap(run_ts, zip(its,chrs))
