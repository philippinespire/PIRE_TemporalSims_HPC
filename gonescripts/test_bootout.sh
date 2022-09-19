dir=$1
sim=$2
maf=$3

simdir="${dir}${sim}"

echo "sim it data NeChi NeClo NeHhi NeHlo" > ${sim}_bootout

it=1

boot=1

while [ $it -le 5 ]
do 
	while [ $boot -le 40 ]
	do
		data=wgs_n20
		bootout=${simdir}/${data}_i${it}/GONE/boot_${boot}/Output_Ne_boot_${boot}_pedmap
		grep -m 1 "^1" ${bootout} | awk '{print $2}' >> tempNeC
		grep -m 1 "^120" ${bootout} | awk '{print $2}' >> tempNeH
		boot=$(( $boot+1 ))
	done
	NeClo=$(sort -g tempNeC | head -n 1)
	NeChi=$(sort -g tempNeC | tail -n 1)
	NeHlo=$(sort -g tempNeH | head -n 1)
	NeHhi=$(sort -g tempNeH | tail -n 1)
	echo ${sim} ${it} ${data} ${NeChi} ${NeClo} ${NeHhi} ${NeHlo} >> ${sim}_bootout
	rm tempNeC
	rm tempNeH
	boot=1
	it=$(( $it+1 ))
done

it=1

boot=1

while [ $it -le 5 ]
do 
	while [ $boot -le 40 ]
	do
		data=wgs_n50
		bootout=${simdir}/${data}_i${it}/GONE/boot_${boot}/Output_Ne_boot_${boot}_pedmap
		grep -m 1 "^1" ${bootout} | awk '{print $2}' >> tempNeC
		grep -m 1 "^120" ${bootout} | awk '{print $2}' >> tempNeH
		boot=$(( $boot+1 ))
	done
	NeClo=$(sort -g tempNeC | head -n 1)
	NeChi=$(sort -g tempNeC | tail -n 1)
	NeHlo=$(sort -g tempNeH | head -n 1)
	NeHhi=$(sort -g tempNeH | tail -n 1)
	echo ${sim} ${it} ${data} ${NeChi} ${NeClo} ${NeHhi} ${NeHlo} >> ${sim}_bootout
	rm tempNeC
	rm tempNeH
	boot=1
	it=$(( $it+1 ))
done

it=1

boot=1

while [ $it -le 5 ]
do 
	while [ $boot -le 40 ]
	do
		data=wgs_n100
		bootout=${simdir}/${data}_i${it}/GONE/boot_${boot}/Output_Ne_boot_${boot}_pedmap
		grep -m 1 "^1" ${bootout} | awk '{print $2}' >> tempNeC
		grep -m 1 "^120" ${bootout} | awk '{print $2}' >> tempNeH
		boot=$(( $boot+1 ))
	done
	NeClo=$(sort -g tempNeC | head -n 1)
	NeChi=$(sort -g tempNeC | tail -n 1)
	NeHlo=$(sort -g tempNeH | head -n 1)
	NeHhi=$(sort -g tempNeH | tail -n 1)
	echo ${sim} ${it} ${data} ${NeChi} ${NeClo} ${NeHhi} ${NeHlo} >> ${sim}_bootout
	rm tempNeC
	rm tempNeH
	boot=1
	it=$(( $it+1 ))
done
