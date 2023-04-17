# fullerene_project: repository for a computational study of fullerene and ligand docking

### Background and Acknowledgements 
1. Patchdock:
- This project uses PatchDock, available from the Structural Bioinformatics Group at Tel-Aviv University:
    - bioinfo3d.cs.tau.ac.il/PatchDock
    - Schneidman-Duhovny D, Inbar Y, Nussinov R, Wolfson HJ. PatchDock and SymmDock: servers for rigid and symmetric docking. Nucleic Acids Res. 2005 Jul 1;33(Web Server issue):W363-7. doi: 10.1093/nar/gki481. PMID: 15980490; PMCID: PMC1160241.
2. Autodock Vina:
- This project also uses Vina, 
    - https://github.com/ccsb-scripps/AutoDock-Vina
    - J. Eberhardt, D. Santos-Martins, A. F. Tillack, and S. Forli. (2021). AutoDock Vina 1.2.0: New Docking Methods, Expanded Force Field, and Python Bindings.
3. GNU/Parallel:
- This project also uses GNU/Parallel,
    - https://www.gnu.org/software/parallel
    - O. Tange (2018): GNU Parallel 2018, March 2018, https://doi.org/10.5281/zenodo.1146014.
4. OpenBabel
- This project recommends OpenBabel for conversion of chemical formats used as input for this docking
    - For more information: https://openbabel.org/wiki/Main_Page 
    - N M O'Boyle, M Banck, C A James, C Morley, T Vandermeersch, and G R Hutchison. "Open Babel: An open chemical toolbox." J. Cheminf. (2011), 3, 33. DOI:10.1186/1758-2946-3-33
4. Center for Computationally Assisted Science and Technology (CCAST) Acknowledgement 
    - This work used resources of the Center for Computationally Assisted Science and Technology (CCAST) at North Dakota State University, which were made possible in part by NSF MRI Award No. 2019077
    - A warm thanks to the administrators of this system, who make this work possible. 
    - These scripts originate as a process improvement for using the Thunder Prime high performance computing cluster hosted by CCAST, a PBS-based batch-queueing system.
5. Description of this repository:
    - A series of parallel computing wrappers for Patchdock and Vina, which are computational docking software. 
    - It provides a workflow for the study of intramolecular forces between nanoparticles and receptor proteins.
    - Generates an automated high-throughput docking as two vectorized processes. 
    - It is free software under the GNU GPLv3 License. Please see LICENSE for more details.
    - It does not include any of the above-mentioned projects' software.
    - It uses integer-numbered ligand and receptor structures in Protein Data Bank (.pdb) format for the first step [Patchdock run], and structures in Autodock PDB (.pdbqt) for the second step [Autodock Vina run]. 

### Software Design and Implementation 
1. Workflow 
    - PBS queueing used on target system to dock MxN numbered proteins with ligands
    - GNU/Parallel for vectorizes code across a series of CPU cores:
        - First, a low-resolution docking run is performed with PatchDock with one core per process, and produces the five-most probable receptor-ligand configuration based on a geometrically-based scoring parameter.
        - Then, a `spreadsheet` creation script is invoked to output the most-likely scoring and location of ligand-receptor interaction.
        - A high-resolution docking is performed with AutoDock Vina with four cores per process, using the output of the Patchdock job to target a specific binding site for study.
        - Finally, this is also output using a corresponding script.
2. Step-by-Step use via shell commands for a GNU/Linux system:
    1. Installation Notes:
         1. The system needs both Perl and Parallel as modules. 
         2. Patchdock and Autodock Vina are free for academic use, and can be found using the links in the introduction. The contents of these releases can be placed into their respective folder. 
         3. These scripts were designed for use on the Thunder Prime cluster, but have been redacted in places with comments to demonstrate script function.
         4. For each folder, place input files as positive-integer numbered .pdb/.pdbqt files into:
             - `dia` : contains files for protein receptors 
             - `lig` : contains files for ligands
             - A minimum example would contain:
                 - docking/patchdock/dia/1.pdb
                 - docking/patchdock/lig/1.pdb
                 - docking/vina/dia/1.pdbqt
                 - docking/vina/lig/1.pdbqt
    2. Use: run the following in order within a `docking` project folder containing both `patchdock` and `vina` folders.
            
            ```
             $ cd patchdock 
             
             $ chmod u+x ./*.sh` # make scripts executable by user
             
             $ qsub patchdock_job.sh # submit first PBS job and await execution 
             
             $ ./spreadsheet.sh #  after job completion, export information 
             
             $ mv ./spreadsheet.sh ../vina/ && cd ../vina
             
             $ qsub vina_job.sh # submit second PBS job and await execution
             
             $ ./export_energies.sh # output energies.csv, which gives final docking as Kcal/mol scoring at selected site
             ```
