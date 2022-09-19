dir=$1
sim=$2
maf=$3

simdir="${dir}${sim}"

it=4

boot=1

while [ $it -le 4 ]
do 
	while [ $boot -le 40 ]
	do
		data=wgs_n100
		lgm=c
		itdir=${simdir}/${data}_i${it}/GONE
		cd ${itdir}
		mkdir boot_${boot}
		awk '{print $1, $4, $4}' i${it}_allchr_${data}_${lgm}_nomaf.map > boot_${boot}/allsnps.bed
		shuf -n 50000 boot_${boot}/allsnps.bed > boot_${boot}/rand50k.bed
		seq 1 50000 > boot_${boot}/set
		paste boot_${boot}/rand50k.bed boot_${boot}/set > boot_${boot}/rand50k.range
		/home/br450/plink_linux_x86_64_20201019/plink -ped i${it}_allchr_${data}_${lgm}_nomaf.ped --map i${it}_allchr_${data}_${lgm}_nomaf.map --make-bed --extract 'range' boot_${boot}/rand50k.range --out boot_${boot}/boot_${boot}
		/home/br450/plink_linux_x86_64_20201019/plink --bfile boot_${boot}/boot_${boot} --recode --tab --out boot_${boot}/boot_${boot}_pedmap
		cp -r /home/br450/GONE/Linux/* boot_${boot}
		cd boot_${boot}
		chmod +r+x PROGRAMMES/*
		goneinput=boot_${boot}_pedmap
		echo "#!/bin/bash
		bash script_GONE.sh ${goneinput}" > gone_${data}_${lgm}_${maf}_i${it}_b${boot}.sb
		sbatch -t 24:00:00 --mem=5G -N 1 -c 20 gone_${data}_${lgm}_${maf}_i${it}_b${boot}.sb
		sleep 2
		cd ${itdir}
		boot=$(( $boot+1 ))
	done
	boot=1
	it=$(( $it+1 ))
done
