# PIRE_TemporalSims_HPC
Scripts for simulating recent demographic declines and running inferences on simulated data (writtenfor Rutgers' Amarel cluster)

[pardon the mess - this is a work in progress!]

The basic workflow for generating data (scripts in the n10e3 folder) is:
1) generate 5 pedigrees (= population replicates) for each scenario using SLiM (over the past 220 years)
2) generate tree sequences for 25 chromosomes for each population replicate, with the pedigree fixed for each, using SLiM
3) "recapitate" the tree sequences using pyslim and msmc - this will "finish" the tree using the coalescent
4) add mutations to the tree
5) generate VCF output files with different subsampling schemes

The momiscripts/stairscripts/gonescripts folders contain scripts for post-processing the VCF files and efficiently running inferences on them.
