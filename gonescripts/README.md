# Scripts for running GONE on simulated data

To run GONE iteratively over different sampling schemes for a given demographic scenario, use the .sh scripts, supplying arguments for (1) the directory containing your simulation folder, (2) the simulation folder itself, and (3) the minor allele frequency used. The _bot and _exp shell scripts are used for conducting inference on simulated data generated with an ancient bottleneck or expansion (respectively). The _boot scripts perform bootstrapping on the and record the results for each bootstrap.

Note the directory structure was specific to the directory in which simulations were performed and analyzed on Rutgers' Amarel cluster - you may have to change these paths to reflect your directory structure.

You will need the indlineinfo* files to be accessible and specify the correct paths to these files.
