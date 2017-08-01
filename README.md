# Bridges Programs

This repository contains a variety of files that can be run on Bridges, Flux, or other high performance machines. 

sugar_setup.sh calls merge_align.py, which takes transporter .pdb and .psf files, merges them with a sugar's .pdb and .psf files, and aligns the sugar
as input. The end result is the sugar being correctly positioned nearby the active site. This is ideal for running future MD simulations, such as NAMD.

scaling.py works with axes.py to create a nifty binding energy graph

Also included are a topology file for lipids, and a sample .pdb and .psf for D-xylose.

# How to Align Glucose/Xylose near a Protein
1. File organization:
  \sugar_align
      top_all27_prot_lipid.inp
      4gby_glucose_autopsf.pdb
      4gby_glucose_autopsf.psf
      my_protein.pdb
      my_protein.psf
      \tcl_and_sh_files
            sugar_setup.sh
            merge_align.tcl

2. $  cd ~/path_to_program/sugar_align/tcl_and_sh_files/
   $  bash sugar_setup.sh ../<my_protein.pdb> ../<my_protein.psf
   Replace <my_protein.pdb> and <my_protein.psf> with the relevant protein files, without the brackets.

3. "Enter sugar (glucose or xylose): "
    Enter your sugar here, and program should run to completion. The output will be one .pdb and one .psf with a sugar aligned     nearby your protein.
  
