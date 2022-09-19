dir=$1
sim=$2
maf=$3
simdir="${dir}${sim}"

data=wgs_n20
lgm=c
sampn=20
seqn=40

it=3
while [ $it -le 3 ]
do
	mkdir -p ${simdir}${data}_i${it}/stairway
	cp ${dir}${sim}constant_recap/vcf/i${it}_allchr_${data}_${lgm}_${maf}_t0.recode.vcf ${simdir}${data}_i${it}/stairway
	cp -r /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/stairway_plot_es ${simdir}${data}_i${it}/stairway
	cp /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/two-epoch_fold.blueprint ${simdir}${data}_i${it}/stairway
	cp /home/br450/indpopmap20 ${simdir}${data}_i${it}/stairway
	cp /home/br450/vcf2sfs/getvcf_template2.R ${simdir}${data}_i${it}/stairway/getvcf_i${it}_${data}_${maf}.R
	cd ${simdir}${data}_i${it}/stairway
	sed -i "s/_iteration/${it}/g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s/_numsamp/${sampn}/g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s:simdir:${sim}${data}_i${it}:g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s/filter/${maf}/g" getvcf_i${it}_${data}_${maf}.R
	Rscript getvcf_i${it}_${data}_${maf}.R
	cp two-epoch_fold.blueprint i${it}_${data}_${maf}.blueprint
	sed -i "s/two-epoch_fold/i${it}_${data}_${maf}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/nseq: 30/nseq: ${seqn}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/L: 10000000/L: 750000000/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/estimation: 15/estimation: ${sampn}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/mu: 1.2/mu: 1.0/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/generation: 24/generation: 1/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/xrange: 0.1,10000/xrange: 0.1,100/g" i${it}_${data}_${maf}.blueprint
	tail -n 1 i${it}_${data}_${maf}.sfs | awk '{ $1=""; print}' > i${it}_${data}_${maf}_foldbins.sfs
	sed -i 's/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0//g' i${it}_${data}_${maf}_foldbins.sfs
	sfs=$(cat i${it}_${data}_${maf}_foldbins.sfs)
	sed -i "7s/.*/SFS:${sfs}/g" i${it}_${data}_${maf}.blueprint
	java -cp stairway_plot_es Stairbuilder i${it}_${data}_${maf}.blueprint
	echo "#!/bin/bash
	bash i${it}_${data}_${maf}.blueprint.sh" > i${it}_${data}_${maf}_stairway.sb
	sbatch -t 24:00:00 --partition=mem --mem=15G -N 1 -c 20 i${it}_${data}_${maf}_stairway.sb
	sleep 2
	it=$(( $it + 1 ))
done

data=wgs_n50
lgm=c
sampn=50
seqn=100

it=3
while [ $it -le 3 ]
do
	mkdir -p ${simdir}${data}_i${it}/stairway
	cp ${dir}${sim}constant_recap/vcf/i${it}_allchr_${data}_${lgm}_${maf}_t0.recode.vcf ${simdir}${data}_i${it}/stairway
	cp -r /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/stairway_plot_es ${simdir}${data}_i${it}/stairway
	cp /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/two-epoch_fold.blueprint ${simdir}${data}_i${it}/stairway
	cp /home/br450/indpopmap50 ${simdir}${data}_i${it}/stairway
	cp /home/br450/vcf2sfs/getvcf_template2.R ${simdir}${data}_i${it}/stairway/getvcf_i${it}_${data}_${maf}.R
	cd ${simdir}${data}_i${it}/stairway
	sed -i "s/_iteration/${it}/g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s/_numsamp/${sampn}/g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s:simdir:${sim}${data}_i${it}:g" getvcf_i${it}_${data}_${maf}.R
	sed -i "s/filter/${maf}/g" getvcf_i${it}_${data}_${maf}.R
	Rscript getvcf_i${it}_${data}_${maf}.R
	cp two-epoch_fold.blueprint i${it}_${data}_${maf}.blueprint
	sed -i "s/two-epoch_fold/i${it}_${data}_${maf}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/nseq: 30/nseq: ${seqn}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/L: 10000000/L: 750000000/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/estimation: 15/estimation: ${sampn}/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/mu: 1.2/mu: 1.0/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/generation: 24/generation: 1/g" i${it}_${data}_${maf}.blueprint
	sed -i "s/xrange: 0.1,10000/xrange: 0.1,100/g" i${it}_${data}_${maf}.blueprint
	tail -n 1 i${it}_${data}_${maf}.sfs | awk '{ $1=""; print}' > i${it}_${data}_${maf}_foldbins.sfs
	sed -i 's/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0//g' i${it}_${data}_${maf}_foldbins.sfs
	sfs=$(cat i${it}_${data}_${maf}_foldbins.sfs)
	sed -i "7s/.*/SFS:${sfs}/g" i${it}_${data}_${maf}.blueprint
	java -cp stairway_plot_es Stairbuilder i${it}_${data}_${maf}.blueprint
	echo "#!/bin/bash
	bash i${it}_${data}_${maf}.blueprint.sh" > i${it}_${data}_${maf}_stairway.sb
	sbatch -t 24:00:00 --partition=mem --mem=15G -N 1 -c 20 i${it}_${data}_${maf}_stairway.sb
	sleep 2
	it=$(( $it + 1 ))
done
