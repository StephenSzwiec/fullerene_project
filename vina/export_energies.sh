#!/bin/bash
# Stephen Szwiec, 25 July 2022 for The Rasulev Computational Chemistry Research
# Group at North Dakota State University
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
# Usage: creates a spreadsheet for analysis using files created from autodock
# output within the same directory. The spreadsheet is created in the current
# directory.
# columns are: receptor, ligand, affinity (in kcal/mol)

# uncomment this line to write a header to the spreadsheet
# echo "receptor,ligand,affinity" > energies.csv
for i in $(ls ./ | grep '.log$')
do
	first=$(cut -f1 -d'-' <(echo $i) );
	second=$(cut -f1 -d'.' <(cut -f2 -d'-' <(echo $i )));
	third=$(cat $i | sed -n '27p' | sed 's/\s\s*/ /g' | cut -d$' ' -f3 -);
	paste <(echo $first) <(echo $second) <(echo $third) -d',' \
		>> energies.csv;
done
exit 0;
