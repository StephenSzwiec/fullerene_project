####
# Authored by Stephen Szwiec
# for Rasulev Lab, North Dakota State University
# 2022 September 06
###
# This script is designed be used by the pipeline to generate a list of all the
# most likely docking poses for a given ligand.
###
# This script takes two arguments: $1 is the name of the receptor, $2 is the name of the ligand.
###
#
# This code is licensed under the GNU General Public License v3.0
# https://www.gnu.org/licenses/gpl-3.0.en.html
####

#!/bin/bash
perl buildParamsFine.pl ./prot/$1.pdb ./nanoecdy/$2_*.pdb 1.0 drug params-$1-$2.txt
./patch_dock.Linux params-$1-$2.txt recp-$1-$2.txt
perl transOutput.pl recp-$1-$2.txt 1 5
