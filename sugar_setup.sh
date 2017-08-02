#!/usr/bin/env bash
# This program takes the pdb and psf files for a transporter and a sugar, and
# outputs a sugar-protein pdb and a psf that represents the stage directly before the binding
# of the sugar to the transporter, ready to be analyzed by MD techniques

# plot 

# help text
if [[ $1 = "help" ]]; then
    echo This script, when provided with the both a psf and pdb file as arguments, \
        generates the sugar-protein pdb and psf complex.
    exit 
fi

# if no arguments are given, stop the program here instead of crashing in VMD
filename=$(basename $0)
if [ -z $1 ]
    echo "No arguments given. Type '$filename help' for detailed instructions."
    exit
fi

#pick glucose or xylose, residue is either BGLC or BXYL
echo -n "Enter sugar (glucose or xylose): "
read name
short="${name:0:1}"

# quickly identify whether the sugar to be added is glucose or xylose
if [ $short = "g" ] ; then
    sugar_res="BGLC"
elif [ $short = "G" ] ; then
    sugar_res="BGLC"
else
    sugar_res="BXYL"
fi


# if one argument is provided, assume the standard psf file
if [ -z "$2" ]; then
#call VMD without a display window and build a pdb from the inputs
    /Applications/VMD\ 1.9.3.app/Contents/Resources/VMD.app/Contents/MacOS/VMD -e \
    ~/tcl_bin/sugar_setup/tcl/merge_align.tcl -dispdev text ../step5_assembly.xplor_ext.psf \
    $1 -args $sugar_res $1 ../step5_assembly.xplor_ext.psf
elif [ -f $2 ]
    then
        #call VMD without a display window and build a pdb from the inputs
        /Applications/VMD\ 1.9.3.app/Contents/Resources/VMD.app/Contents/MacOS/VMD -e \
        ~/tcl_bin/sugar_setup/tcl/merge_align.tcl -dispdev text $1 $2 -args $sugar_res $1 $2
else
    echo "Hey buddy, $2 doesn't exist"
    exit
fi
rm temp.pdb temp.psf
