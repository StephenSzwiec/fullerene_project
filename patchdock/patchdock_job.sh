# Created by Stephen Szwiec on 2022-11-29
# for the Rasulev Computational Chemistry Research Group at North Dakota State University
#
# This script is free software; you can redistribute it and/or modify it under the terms
# of the GNU General Public License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
# Please see https://www.gnu.org/licenses/gpl-3.0.en.html for more information.
#
# This docking script is used to read an sdf input file and dock it to a receptor
# using the AutoDock Vina program. The script will generate a directory for each
# ligand in the input file and run the docking in parallel. The script will
# generate a log file for each ligand and then perform a post-processing step
# to generate a single output file with the results of all the docking runs.
#
#!/bin/bash
#PBS -q # place whatever queue allowed by your host here, this is cluster-specific; check with `pbsnodes -a`
#PBS -N PatchDock # job name
#PBS -l select=1:mem=16GB:ncpus=32 # resources to use: 1 node, 16 GB memory, 32 CPUs
#PBS -l walltime=8:00:00 # 8 hours of queue time for this job
#PBS -W # cluster-specific, your user's group for queue manager; helpful to check `groups`
#PBS -j oe # join `-o` stdout and `-e` stderr
#PBS -M # email address to contact
#PBS -m abe # what conditions for emailing: `-a` aborted, `-b` beginning, `-e` end

## Loading all modules needed
module load perl
module load parallel

## execute script with parallel processing.
export PLACE=$SCRATCH/$USER/docking/patchdock/
cd $PLACE
parallel -j 32 $(echo $PLACE)thescript.sh ::: {1..5} ::: {1..169}


exit 0
