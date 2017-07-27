# REQUIRES:
# 1. 2 pdb files (protein and sugar)
# 2. 2 psf files (protein and sugar - need to autogen sugar's psf)
# 3. topology file
# 4. psfgen

# Load topology file and psfgen

package require psfgen
topology top_all27_prot_lipid.inp


# Input data from user
puts "Enter the protein's psf file:"
set protein_psf [gets stdin]
puts "Enter the protein's pdb file:"
set protein_pdb [gets stdin]
puts "Enter the sugar's psf file:"
set sugar_psf [gets stdin]
puts "Enter the sugar's pdb file:"
set sugar_pdb [gets stdin]
puts "Enter the sugar residue to select:"
set sugar_res [gets stdin]
puts "Enter the final output's psf name:"
set output_psf [gets stdin]
puts "Enter the final output's pdb name:"
set output_pdb [gets stdin]

#TODO: Allow users to enter either name.pdb or name
#mol top 0
readpsf $protein_psf.psf 
coordpdb $protein_pdb.pdb 
    #step5_assembly.pdb

#mol top 1
readpsf $sugar_psf.psf 
coordpdb $sugar_pdb.pdb
    #4gby_xylose_autopsf.pdb
guesscoord


writepsf temp_psf.psf 
writepdb temp_pdb.pdb 
    #hxt36-xylose.psf

#readpsf temp_psf.psf
#coordpdb temp_pdb.pdb
mol load psf temp_psf.psf pdb temp_pdb.pdb


# selecting the transporter and its ligand, CHANGE THIS
set protein [atomselect top "all not resname $sugar_res"]
set sugar [atomselect top "resname $sugar_res"]


# move sugar to the COM of protein
set com_protein [measure center $protein weight mass]
set com_sugar [measure center $sugar weight mass]
$sugar moveby [vecinvert com_protein]


# move sugar up 50 Angstroms, CHANGE SIGN
$sugar moveby {0 0 50}

# checks if sugar is closer to 27 (extracellular) or 260 (intracellular) in z-direction, 
# and adjusts the sugar by +100A if it's on the intracellular side
set res27 [atomselect top "resid 27"]
set res260 [atomselect top "resid 260"]
set sugar_center [measure center $sugar weight mass]
set res27_center [measure center $res27 weight mass]
set res260_center [measure center $res260 weight mass]
set diff27 [expr {[lindex $sugar_center 2] - [lindex $res27_center 2]}]
set diff260 [expr {[lindex $sugar_center 2] - [lindex $res260_center 2]}]

if {abs($diff27) > abs($diff260)} {$sugar moveby {0 0 -100}}


# DOES NOT WORK
# remove conflicting water molecules
set conflict_water [atomselect top "same residue as water within 2 of resname $sugar_res"]
foreach segid [$conflict_water get segid] resid [$conflict_water get resid] {
    delatom $segid $resid
}


# Write pdb file, CHANGE OUTPUT NAME
set new_sel [atomselect top "all and not water within 3 of resname $sugar_res"]
$new_sel writepdb $output_pdb.pdb
$new_sel writepsf $output_psf.psf 
