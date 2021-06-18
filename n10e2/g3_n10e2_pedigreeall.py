###Python/pyslim code for generating tree sequences under recent demographic decline scenarios

##Import needed packages
import subprocess
import multiprocessing
import os

##set up needed common paths
dir="/scratch/br450/SLiM_ped_g3/"

slim_template= dir + "g3_pedigree_template.slim"

## set output for: nhistoric=10e2, tdecline=100, lambda=99

output_dir= dir + "g3_n10e2_td100_l99/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=100, lambda=99
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=100","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e


##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))


## set output for: nhistoric=10e2, tdecline=100, lambda=95

output_dir= dir + "g3_n10e2_td100_l95/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=100, lambda=95
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=100","-d","lambda=0.95","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))

## set output for: nhistoric=10e2, tdecline=130, lambda=99

output_dir= dir + "g3_n10e2_td130_l99/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=130, lambda=99
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=130","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))


## set output for: nhistoric=10e2, tdecline=130, lambda=95

output_dir= dir + "g3_n10e2_td130_l95/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=130, lambda=95
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=130","-d","lambda=0.95","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e


##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))

## set output for: nhistoric=10e2, tdecline=160, lambda=99

output_dir= dir + "g3_n10e2_td160_l99/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=160, lambda=99
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=160","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))


## set output for: nhistoric=10e2, tdecline=160, lambda=95

output_dir= dir + "g3_n10e2_td160_l95/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=160, lambda=95
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=160","-d","lambda=0.95","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e


##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))

## set output for: nhistoric=10e2, tdecline=190, lambda=99

output_dir= dir + "g3_n10e2_td190_l99/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=190, lambda=99
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=190","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e


##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))


## set output for: nhistoric=10e2, tdecline=190, lambda=95

output_dir= dir + "g3_n10e2_td190_l95/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, tdecline=190, lambda=95
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=190","-d","lambda=0.95","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))


## set output for: nhistoric=10e2, constant

output_dir= dir + "g3_n10e2_constant/"

if not os.path.exists(output_dir):
	os.makedirs(output_dir)

##set up function for running a given demographic scenario: nhistoric=10e2, constant
def run_sim(i):
	t0F=output_dir+"i"+str(i)+"_t0samps.txt"
	t30F=output_dir+"i"+str(i)+"_t30samps.txt"
	t60F=output_dir+"i"+str(i)+"_t60samps.txt"
	t90F=output_dir+"i"+str(i)+"_t90samps.txt"
	t120F=output_dir+"i"+str(i)+"_t120samps.txt"
	BOF=output_dir+"i"+str(i)+"_breedingsexes.txt"
	MOF=output_dir+"i"+str(i)+"_matings.txt"
	DOF=output_dir+"i"+str(i)+"_deaths.txt"
	try:
		subprocess.check_output(["/home/br450/build/slim","-m","-d","Nhistoric=100","-d","Tdecline=300","-d","lambda=0.99","-d","t0sampfile='"+t0F+"'","-d","t30sampfile='"+t30F+"'","-d","t60sampfile='"+t60F+"'","-d","t90sampfile='"+t90F+"'","-d","t120sampfile='"+t120F+"'","-d","breederfile='"+BOF+"'","-d","matingfile='"+MOF+"'","-d","deathfile='"+DOF+"'",slim_template])
	except Exception as e:
		return e

##run five iterations
a_pool = multiprocessing.Pool()
result = a_pool.map(run_sim, range(1,6))
