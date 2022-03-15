# fullerene_project
 A computational study of fullerene and ligand docking

 This project uses PatchDock, available from the Structural Bioinformatics Group at Tel-Aviv University

 This script was called on a PBS based platform using GNU parallel:
 ```
 $ parallel -j 24 ./thescript.sh ::: {1..1117} :::: {1..169}
 ```
