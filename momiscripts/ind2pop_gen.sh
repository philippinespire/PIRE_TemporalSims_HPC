echo "t0" > /scratch/br450/SLiM_ped_g1/poplist20.txt

for i in {1..19}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist20.txt; done
for i in {1..4}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist20.txt; done
for i in {1..4}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist20.txt; done
for i in {1..4}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist20.txt; done
for i in {1..10}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist20.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist50.txt

for i in {1..49}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist50.txt; done
for i in {1..10}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist50.txt; done
for i in {1..10}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist50.txt; done
for i in {1..10}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist50.txt; done
for i in {1..25}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist50.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist100.txt

for i in {1..99}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist100.txt; done
for i in {1..20}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist100.txt; done
for i in {1..20}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist100.txt; done
for i in {1..20}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist100.txt; done
for i in {1..50}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist100.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist200.txt

for i in {1..199}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist200.txt; done
for i in {1..40}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist200.txt; done
for i in {1..40}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist200.txt; done
for i in {1..40}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist200.txt; done
for i in {1..100}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist200.txt; done

echo "t0" > /scratch/br450/SLiM_ped_g1/poplist500.txt

for i in {1..499}; do echo "t0" >> /scratch/br450/SLiM_ped_g1/poplist500.txt; done
for i in {1..100}; do echo "t30" >> /scratch/br450/SLiM_ped_g1/poplist500.txt; done
for i in {1..100}; do echo "t60" >> /scratch/br450/SLiM_ped_g1/poplist500.txt; done
for i in {1..100}; do echo "t90" >> /scratch/br450/SLiM_ped_g1/poplist500.txt; done
for i in {1..100}; do echo "t120" >> /scratch/br450/SLiM_ped_g1/poplist500.txt; done


for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td190_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l99_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td160_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l95_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td190_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l99_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td160_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l95_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td190_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l99_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td160_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l95_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td190_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l99_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td160_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l95_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td190_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l99_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td160_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e3_td190_l95_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop.txt
done

####n10e4

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td100_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td100_l99_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td130_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td130_l99_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l99_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l99/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l99_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l95/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l95_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l95/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l95_n500/i${it}_n20_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_constant/i${it}_n20t0120.txt /scratch/br450/SLiM_ped_g1/poplist20.txt > /projects/f_mlp195/brendanr/g1_n10e4_constant_n500/i${it}_n20_ind2pop.txt
done


for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td100_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td100_l99_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td130_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td130_l99_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l99_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l99/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l99_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l95/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l95_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l95/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l95_n500/i${it}_n50_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_constant/i${it}_n50t0120.txt /scratch/br450/SLiM_ped_g1/poplist50.txt > /projects/f_mlp195/brendanr/g1_n10e4_constant_n500/i${it}_n50_ind2pop.txt
done


for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td100_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td100_l99_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td130_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td130_l99_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l99_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l99/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l99_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l95/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l95_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l95/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l95_n500/i${it}_n100_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_constant/i${it}_n100t0120.txt /scratch/br450/SLiM_ped_g1/poplist100.txt > /projects/f_mlp195/brendanr/g1_n10e4_constant_n500/i${it}_n100_ind2pop.txt
done


for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td100_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td100_l99_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td130_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td130_l99_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l99_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l99/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l99_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l95/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l95_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l95/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l95_n500/i${it}_n200_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_constant/i${it}_n200t0120.txt /scratch/br450/SLiM_ped_g1/poplist200.txt > /projects/f_mlp195/brendanr/g1_n10e4_constant_n500/i${it}_n200_ind2pop.txt
done


for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td100_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td100_l99_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td130_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td130_l99_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l99_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l99/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l99_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td160_l95/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td160_l95_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_td190_l95/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_td190_l95_n500/i${it}_n500_ind2pop.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e4_constant/i${it}_n500t0120.txt /scratch/br450/SLiM_ped_g1/poplist500.txt > /projects/f_mlp195/brendanr/g1_n10e4_constant_n500/i${it}_n500_ind2pop.txt
done
