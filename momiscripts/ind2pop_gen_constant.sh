#!/bin/bash

### contemp

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist20_contemp.txt
for i in {1..19}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist20_contemp.txt; done


echo "t0" > /scratch/br450/SLiM_ped_g1/poplist50_contemp.txt
for i in {1..49}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist50_contemp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist100_contemp.txt
for i in {1..99}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist100_contemp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist200_contemp.txt
for i in {1..199}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist200_contemp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist500_contemp.txt
for i in {1..499}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist500_contemp.txt; done

### 2samp

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt
for i in {1..9}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt; done
for i in {1..10}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt
for i in {1..24}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt; done
for i in {1..25}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt
for i in {1..49}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt; done
for i in {1..50}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt
for i in {1..99}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt; done
for i in {1..100}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt
for i in {1..399}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt; done
for i in {1..100}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt; done

### serial

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist20_serial.txt
for i in {1..3}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist20_serial.txt; done
for i in {1..4}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist20_serial.txt; done
for i in {1..4}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist20_serial.txt; done
for i in {1..4}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist20_serial.txt; done
for i in {1..4}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist20_serial.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist50_serial.txt
for i in {1..9}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist50_serial.txt; done
for i in {1..10}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist50_serial.txt; done
for i in {1..10}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist50_serial.txt; done
for i in {1..10}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist50_serial.txt; done
for i in {1..10}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist50_serial.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist100_serial.txt
for i in {1..19}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist100_serial.txt; done
for i in {1..20}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist100_serial.txt; done
for i in {1..20}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist100_serial.txt; done
for i in {1..20}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist100_serial.txt; done
for i in {1..20}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist100_serial.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist200_serial.txt
for i in {1..39}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist200_serial.txt; done
for i in {1..40}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist200_serial.txt; done
for i in {1..40}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist200_serial.txt; done
for i in {1..40}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist200_serial.txt; done
for i in {1..40}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist200_serial.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist500_serial.txt
for i in {1..99}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist500_serial.txt; done
for i in {1..100}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist500_serial.txt; done
for i in {1..100}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist500_serial.txt; done
for i in {1..100}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist500_serial.txt; done
for i in {1..100}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist500_serial.txt; done

### constant_contemp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist20_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist50_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist100_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist200_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist500_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_contemp.txt
done

### constant_2samp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_2samp.txt
done

### constant_serial

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist20_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist50_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist100_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist200_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist500_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_serial.txt
done
