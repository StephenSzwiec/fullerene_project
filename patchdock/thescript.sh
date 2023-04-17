#!/bin/bash
perl buildParamsFine.pl ./dia/$1.pdb ./lig/$2.pdb 1.0 drug params-$1-$2.txt
./patch_dock.Linux params-$1-$2.txt recp-$1-$2.txt
perl transOutput.pl recp-$1-$2.txt 1 5
