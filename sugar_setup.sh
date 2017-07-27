#!/usr/bin/env bash
# This program takes the pdb and psf files for a transporter and a sugar, and
# outputs a sugar-protein pdb and a psf that represents the stage directly before the binding
# of the sugar to the transporter, ready to be analyzed by MD techniques

# plot 

# help text
if [[ $1 = "help" ]]; then
    echo This script, when provided with the 2 psf and pdb files as arguments, \
        generates the sugar-protein pdb and psf complex.
    exit 
fi


/Applications/VMD\ 1.9.3.app/Contents/Resources/VMD.app/Contents/MacOS/VMD -e ~/Documents/MayesLab/Protein\ Files/hxt36/xylose/merge_align.tcl -dispdev text
