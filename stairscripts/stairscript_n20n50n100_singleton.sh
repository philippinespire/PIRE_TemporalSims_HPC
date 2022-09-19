dir=$1
sim=$2
maf=$3
simdir="${dir}${sim}"

data=wgs_n100
sampn=100
seqn=200

it=1

while [ $it -le 5 ]
do
	mkdir -p ${simdir}${data}_i${it}/stairway_single3
	cp ${simdir}${data}_i${it}/stairway/i${it}_wgs_n${sampn}_nomaf.blueprint ${simdir}${data}_i${it}/stairway_single3
	cp -r /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/stairway_plot_es ${simdir}${data}_i${it}/stairway_single3
	cd ${simdir}${data}_i${it}/stairway_single3
	bin1o="$(grep 'SFS:' i${it}_wgs_n${sampn}_nomaf.blueprint | cut -d" " -f2)"
	bin1m=$(($bin1o+75000000))
	sed -i "s/${bin1o}/${bin1m}/g" i${it}_wgs_n${sampn}_nomaf.blueprint
	java -cp stairway_plot_es Stairbuilder i${it}_${data}_${maf}.blueprint
	echo "#!/bin/bash
	bash i${it}_${data}_${maf}.blueprint.sh" > i${it}_${data}_${maf}_stairway.sb
	sbatch -t 24:00:00 --mem=8G -N 1 -c 20 i${it}_${data}_${maf}_stairway.sb
	sleep 2
	it=$(( $it + 1 ))
done

it=1

while [ $it -le 5 ]
do
	mkdir -p ${simdir}${data}_i${it}/stairway_single4
	cp ${simdir}${data}_i${it}/stairway/i${it}_wgs_n${sampn}_nomaf.blueprint ${simdir}${data}_i${it}/stairway_single4
	cp -r /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/stairway_plot_es ${simdir}${data}_i${it}/stairway_single4
	cd ${simdir}${data}_i${it}/stairway_single4
	bin1o="$(grep 'SFS:' i${it}_wgs_n${sampn}_nomaf.blueprint | cut -d" " -f2)"
	bin1m=$(($bin1o+7500000))
	sed -i "s/${bin1o}/${bin1m}/g" i${it}_wgs_n${sampn}_nomaf.blueprint
	java -cp stairway_plot_es Stairbuilder i${it}_${data}_${maf}.blueprint
	echo "#!/bin/bash
	bash i${it}_${data}_${maf}.blueprint.sh" > i${it}_${data}_${maf}_stairway.sb
	sbatch -t 24:00:00 --mem=8G -N 1 -c 20 i${it}_${data}_${maf}_stairway.sb
	sleep 2
	it=$(( $it + 1 ))
done

it=1

while [ $it -le 5 ]
do
	mkdir -p ${simdir}${data}_i${it}/stairway_single5
	cp ${simdir}${data}_i${it}/stairway/i${it}_wgs_n${sampn}_nomaf.blueprint ${simdir}${data}_i${it}/stairway_single5
	cp -r /home/br450/stairway-plot-v2/stairway_plot_v2.1.1/stairway_plot_es ${simdir}${data}_i${it}/stairway_single5
	cd ${simdir}${data}_i${it}/stairway_single5
	bin1o="$(grep 'SFS:' i${it}_wgs_n${sampn}_nomaf.blueprint | cut -d" " -f2)"
	bin1m=$(($bin1o+750000))
	sed -i "s/${bin1o}/${bin1m}/g" i${it}_wgs_n${sampn}_nomaf.blueprint
	java -cp stairway_plot_es Stairbuilder i${it}_${data}_${maf}.blueprint
	echo "#!/bin/bash
	bash i${it}_${data}_${maf}.blueprint.sh" > i${it}_${data}_${maf}_stairway.sb
	sbatch -t 24:00:00 --mem=8G -N 1 -c 20 i${it}_${data}_${maf}_stairway.sb
	sleep 2
	it=$(( $it + 1 ))
done
