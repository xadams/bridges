# Bridges Programs

This repository contains a variety of files that can be run on Bridges, Flux, or other high performance machines. 

sugar_setup.sh calls merge_align.py, which takes transporter .pdb and .psf files, merges them with a sugar's .pdb and .psf files, and aligns the sugar
as input. The end result is the sugar being correctly positioned nearby the active site. This is ideal for running future MD simulations, such as NAMD.

scaling.py works with axes.py to create a nifty binding energy graph

Also included are a topology file for lipids, and a sample .pdb and .psf for D-xylose.
