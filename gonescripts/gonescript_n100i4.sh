dir=$1
sim=$2
maf=$3
simdir="${dir}${sim}"

cd ${simdir}

indlineinfo="${simdir}indlineinfo_gone"
indline100="${simdir}indline100_gone"
indline50="${simdir}indline50_gone"
indline20="${simdir}indline20_gone"
indkeep100="${simdir}indkeep100_gone"
indkeep50="${simdir}indkeep50_gone"
indkeep20="${simdir}indkeep20_gone"

indlinefields="#CHROM POS ID REF ALT QUAL FILTER INFO FORMAT "

echo ${indlinefields} | tr " " "\n" > ${indlineinfo}
for i in {1..100}; do echo ""time0_ind"${i}" >> ${indlineinfo}; done
cat ${indlineinfo} | tr "\n" "\t" > ${indline100}
truncate -s-1 ${indline100}
echo "" >> ${indline100}

for i in {1..100}; do echo ""time0_ind"${i}" >> ${indkeep100}; done

echo ${indlinefields} | tr " " "\n" > ${indlineinfo}
for i in {1..50}; do echo ""time0_ind"${i}" >> ${indlineinfo}; done
cat ${indlineinfo} | tr "\n" "\t" > ${indline50}
truncate -s-1 ${indline50}
echo "" >> ${indline50}

for i in {1..50}; do echo ""time0_ind"${i}" >> ${indkeep50}; done

echo ${indlinefields} | tr " " "\n" > ${indlineinfo}
for i in {1..20}; do echo ""time0_ind"${i}" >> ${indlineinfo}; done
cat ${indlineinfo} | tr "\n" "\t" > ${indline20}
truncate -s-1 ${indline20}
echo "" >> ${indline20}

for i in {1..20}; do echo ""time0_ind"${i}" >> ${indkeep20}; done

it=4

data=wgs_n100
lgm=c
first=${dir}${sim}constant_recap/vcf/i${it}_chr_1_${data}_contemp_${maf}.recode.vcf.gz
outfile=${dir}${sim}constant_recap/vcf/i${it}_allchr_${data}_contemp_${maf}.recode.vcf
vcfdir=${dir}${sim}constant_recap/vcf/
outt0=${dir}${sim}constant_recap/vcf/i${it}_allchr_${data}_${lgm}_${maf}_t0
outplink=${dir}${sim}${data}_i${it}/GONE/i${it}_allchr_${data}_${lgm}_${maf}
goneinput=i${it}_allchr_${data}_${lgm}_${maf}
mkdir -p ${dir}${sim}${data}_i${it}/GONE
cp -r /home/br450/GONE/Linux/* ${dir}${sim}${data}_i${it}/GONE
zcat < ${first} | grep '^##fileformat' > ${outfile}
zcat < ${first} | grep '^##source' >> ${outfile}
zcat < ${first} | grep '^##FILTER' >> ${outfile}
for chr in {1..25}
do
	chrfile=${dir}${sim}constant_recap/vcf/i${it}_chr_${chr}_${data}_contemp_${maf}.recode.vcf.gz
	zcat < ${chrfile} | grep '^##contig' >> ${outfile}
done
zcat < ${first} | grep '^##FORMAT' >> ${outfile}
cat ${indline100} >> ${outfile}
for chr in {1..25}
do
	chrfile=${dir}${sim}constant_recap/vcf/i${it}_chr_${chr}_${data}_contemp_${maf}.recode.vcf.gz
	zcat < ${chrfile} |  tail -n +7 >> ${outfile}
done
gzip ${outfile}
vcftools --gzvcf ${outfile}.gz --keep ${indkeep100} --recode --out ${outt0}
/home/br450/plink_linux_x86_64_20201019/plink --vcf ${outt0}.recode.vcf --recode --out ${outplink}
sed -i 's/0 0 0 -9 /flarg /g' ${outplink}.ped
sed -i 's/ 0 / A /g' ${outplink}.ped
sed -i 's/ 0 / A /g' ${outplink}.ped
sed -i 's/ 0/ A/g' ${outplink}.ped
sed -i 's/ 1 / T /g' ${outplink}.ped
sed -i 's/ 1 / T /g' ${outplink}.ped
sed -i 's/ 1/ T/g' ${outplink}.ped
sed -i 's/flarg /0 0 0 -9 /g' ${outplink}.ped
cd ${dir}${sim}${data}_i${it}/GONE
chmod +r+x PROGRAMMES/*
echo "#!/bin/bash
bash script_GONE.sh ${goneinput}" > gone_${data}_${lgm}_${maf}_i${it}.sb
sbatch -t 24:00:00 --mem=5G -N 1 -c 20 gone_${data}_${lgm}_${maf}_i${it}.sb
sleep 2
