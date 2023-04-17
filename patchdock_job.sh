####
# Authored by Stephen Szwiec
# for Rasulev Lab, North Dakota State University
# 2022 September 06
###
# This script is designed to use GNU Parallel to run a PatchDock
# job on a list of PDB files. It will create an array of CPUs to
# use, and then run the jobs in parallel as vectors of the array.
###
# This code is licensed under the GNU General Public License v3.0
# https://www.gnu.org/licenses/gpl-3.0.en.html
####

#!/bin/bash
#PBS -q # queue of your choice
#PBS -N PatchDock # name of job
#PBS -l select=1:mem=16GB:ncpus=32 # resources to use for job
#PBS -l walltime=40:00:00 # real-time to wait in queue and execute
#PBS -W # GroupName here, use `groups` if uncertain
#PBS -j oe # create both `-o` STDOUT and `-e` STDERR
#PBS -M # Send to this email address
#PBS -m abe # when to email user? `abort`, `begin`, `execution`

## Loading all modules needed
module load perl
module load parallel

## execute script with parallel processing at `location` folder.
export PLACE=/mmfs1/scrath/$USER/location
cd $PLACE
# parallel execution of PatchDock across 32 CPUs for n x m matrix of PDB files
# based on the contents of `thescript.sh`
parallel -j 32 $(echo $PLACE)thescript.sh ::: {1..1117} ::: {1..545}

exit 0
