# PIRE_TemporalSims_HPC
Scripts for simulating recent demographic declines and running inferences on simulated datasets (written for Rutgers' Amarel cluster) and plotting results with R.

This Github rep accompanies Reid & Pinsky 2022. Simulation-Based Evaluation of Methods, Data Types, and Temporal Sampling Schemes for Detecting Recent Population Declines. _Integrative and Comparative Biology_, icac144, https://doi.org/10.1093/icb/icac144.

The basic workflow used to perform the analyses described in the manuscript is as follows:

1) Perform demographic simulations and generate genotype (.vcf) files for whole simulated genomes using scripts found in the `sim_*` directories. These scripts are written to simulate population sizes (n) of either 10e3 or 10e4 using a generation time (g) of either 1 or 3.
2) Filter the VCF files to generate datasets with different sample sizes and numbers of loci using scripts in the `filterscripts` directory.
3) Perform inferences using the four methods evaluated in the manuscript (momi2, Stairway Plot, GONE, and NeEstimator) using scripts in the corresponding directories. Inferences from simulated datasets are found in the `inferences` directory.
4) Plot results using R in the scripts found in the `plotting_scripts` directory.

Additional details on running the scripts can be found in the `README.md` files within each directory.
