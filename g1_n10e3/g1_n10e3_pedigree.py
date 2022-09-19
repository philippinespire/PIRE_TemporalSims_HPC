###Python/pyslim code for generating tree sequences under recent demographic decline scenarios

##Import needed packages
import subprocess
import multiprocessing

##set up needed paths
dir="/scratch/br450/SLiM_ped_g1/"

slim_template= dir + "g1_pedigree_template.slim"

output_dir= dir + "g1_n10e3_td300_l99/"

##set up function for running a given demographic scenario: nhistoric=10e3, tdecline=300, lambda=99
def run_sim_n10e3_td300_l99(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=1000","-d","Tdecline=300","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'",slim_template])

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim_n10e3_td300_l99, range(1,6))
