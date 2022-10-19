# Scripts for running Stairway Plot on simulated WGS data.

To run Stairway Plot v2 iteratively over different sampling schemes for a given demographic scenario, use the .sh scripts, supplying arguments for (1) the directory containing your simulation folder, (2) the simulation folder itself, and (3) the minor allele frequency used. The _bot and _exp shell scripts are used for conducting inference on simulated data generated with an ancient bottleneck or expansion (respectively). 

Note the directory structure was specific to the directory in which simulations were performed and analyzed on Rutgers' Amarel cluster - you may have to change these paths to reflect your directory structure.

You will also need to clone the [Stairway Plot](https://github.com/xiaoming-liu/stairway-plot-v2) and [vcf2sfs](https://github.com/shenglin-liu/vcf2sfs) repositories and have those and the getvcf__template R scripts and indpopmap* files accessible in the pathways specified by the shell scripts.
