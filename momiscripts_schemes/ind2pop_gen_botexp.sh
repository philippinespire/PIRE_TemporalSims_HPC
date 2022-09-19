### make ind2pops

### constant_contemp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist20_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist50_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist100_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist200_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist500_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_botexp_contemp.txt
done

### constant_2samp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_botexp_2samp.txt
done

### constant_serial

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n20t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist20_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n20_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n50t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist50_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n50_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n100t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist100_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n100_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n200t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist200_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n200_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_constant/i${it}_n500t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist500_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_constant_n500/i${it}_n500_ind2pop_botexp_serial.txt
done




### td100_l99_contemp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n20t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist20_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n20_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n50t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist50_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n50_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n100t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist100_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n100_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n200t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist200_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n200_ind2pop_botexp_contemp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n500t0120_contemp.txt /scratch/br450/SLiM_ped_g1/poplist500_contemp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n500_ind2pop_botexp_contemp.txt
done

### td100_l99_2samp

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n20t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist20_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n20_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n50t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist50_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n50_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n100t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist100_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n100_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n200t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist200_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n200_ind2pop_botexp_2samp.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n500t0120_2samp.txt /scratch/br450/SLiM_ped_g1/poplist500_2samp.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n500_ind2pop_botexp_2samp.txt
done

### td100_l99_serial

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n20t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist20_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n20_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n50t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist50_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n50_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n100t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist100_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n100_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n200t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist200_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n200_ind2pop_botexp_serial.txt
done

for it in  $(seq 1 5);
do
	paste /scratch/br450/SLiM_ped_g1/g1_n10e3_td100_l99/i${it}_n500t0120_serial.txt /scratch/br450/SLiM_ped_g1/poplist500_serial.txt > /projects/f_mlp195/brendanr/g1_n10e3_td100_l99_n500/i${it}_n500_ind2pop_botexp_serial.txt
done
