#!/bin/bash
perl buildParams.pl ./full/recp$1.pdb ./lig/$2.pdb 2.0 Default params-$1-$2.txt
./patch_dock.Linux params-$1-$2.txt recp-$1-$2.txt
perl transOutput.pl recp-$1-$2.txt 1 5
