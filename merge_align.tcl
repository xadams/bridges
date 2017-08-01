# REQUIRES:
# 1. 2 pdb files (protein and sugar)
# 2. 2 psf files (protein and sugar - need to autogen sugar's psf)
# 3. topology file
# 4. psfgen

# Load topology file and psfgen

package require psfgen

#accept the arg from sugar_setup.sh
#TODO: protein

if { ([file extension [file tail [lindex $argv 1]]] == ".pdb") &&   ([info exists [lindex $argv 2]])}   {

    set protein_pdb [lindex $argv 1]
    set protein_psf [lindex $argv 2]

} elseif { ([file extension [file tail [lindex $argv 1]]] == ".psf") &&   ([info exists [lindex $argv 2]]) } {
    
    set protein_psf [lindex $argv 1]
    set protein_pdb [lindex $argv 2]

} else {

    set protein_psf [lindex $argv 2]
    set protein_pdb [lindex $argv 1]

}

#sugar
if { ([lindex $argv 0]=="BGLC") } {
    set sugar_psf "../4gby_glucose_autopsf.psf"
    set sugar_pdb "../4gby_glucose_autopsf.pdb"
    set sugar_res "BGLC"
} else {
    set sugar_psf "../4gby_xylose_autopsf.psf"
    set sugar_pdb "../4gby_xylose_autopsf.pdb"
    set sugar_res "BXYL"
}

#mol top 0
readpsf $protein_psf
coordpdb $protein_pdb
    #step5_assembly.pdb

#mol top 1
readpsf $sugar_psf
coordpdb $sugar_pdb
    #4gby_xylose_autopsf.pdb
guesscoord


writepsf temp.psf 
writepdb temp.pdb 
    #hxt36-xylose.psf

#readpsf temp_psf.psf
#coordpdb temp_pdb.pdb
mol load psf temp.psf pdb temp.pdb


# selecting the transporter and its ligand, CHANGE THIS
set protein [atomselect top "all not resname $sugar_res"]
set sugar [atomselect top "resname $sugar_res"]


# move sugar to the COM of protein
set com_protein [measure center $protein weight mass]
set com_sugar [measure center $sugar weight mass]
$sugar moveby [vecinvert com_protein]


# move sugar up 50 Angstroms, CHANGE SIGN
$sugar moveby {0 0 30}

# checks if sugar is closer to 27 (extracellular) or 260 (intracellular) in z-direction, 
# and adjusts the sugar by +100A if it's on the intracellular side
set res27 [atomselect top "resid 27"]
set res260 [atomselect top "resid 260"]
set sugar_center [measure center $sugar weight mass]
set res27_center [measure center $res27 weight mass]
set res260_center [measure center $res260 weight mass]
set diff27 [expr {[lindex $sugar_center 2] - [lindex $res27_center 2]}]
set diff260 [expr {[lindex $sugar_center 2] - [lindex $res260_center 2]}]

if {abs($diff27) > abs($diff260)} {$sugar moveby {0 0 -60}}


# DOES NOT WORK
# remove conflicting water molecules
# set conflict_water [atomselect top "same residue as water within 3 of resname $sugar_res"]
# foreach segid [$conflict_water get segid] resid [$conflict_water get resid] {
#     delatom $segid $resid
# }


# Write pdb file, CHANGE OUTPUT NAME
set new_sel [atomselect top "all and not water within 2 of resname $sugar_res"]
$new_sel writepdb output.pdb
$new_sel writepsf output.psf

# exit in order to return the user to command line
exit
