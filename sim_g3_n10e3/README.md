# Simulation scripts
These scripts are written to perform simulations of a variety of demographic scenarios (constant population size, recent declines, ancient expansions or declines) for a population with a historical size (at 120 years before present) of 10e3 and a generation time of 3.

Scripts require a SLiM executable (written for SLiM v.3.0), Python, and msprime.

The basic workflow for performing these simulations is as follows:

1) Run `g3_n10e3_pedigreeall.sb` (executes `g3_n10e3_pedigreeall.py` on a compute node). This will generate five recent pedigrees (0-220 years before present) for each demographic scenario by running SLiM in parallel.
2) Run `g3_n10e3_treeseqall.sb` (executes `g3_n10e3_treeseqall.py` on a compute node). This will generate 25 tree sequences (corresponding to the histories of 25 independently inherited chromosomes over the past 220 years) for each pedigree generated in (1).
3) Run `g3_n10e3_recapall_*.sb` (executes `g3_n10e3_recapall_*.py`on a compute node). This will "recapitate" the tree sequences generated in (2) by extending the histories backwards to the most recent common ancestor of the simulated chromosomes. Ancient expansions or declines are simulated at this stage by using the "constant", "bottleneck", or "expansion" versions of this script.
4) Run `g3_n10e3_mutate1all.sb` (executes `g3_n10e3_mutate1all.py` on a compute node). This will add mutations to the recapitated tree sequence.
5) Run `g3_n10e3_gzvcfall.sb` (executes `g3_n10e3_gzvcfall.py` on a compute node). This will generate VCF files from the mutated tree sequence and zip those files.
