# RMSD Analysis Script using VMD
# This script calculates RMSD values for selected helical regions of a protein
# across a molecular dynamics trajectory.

# Load structure and trajectory files
mol new path/to/structure.psf
mol addfile path/to/structure.pdb
mol addfile path/to/trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Select full protein and alpha carbons
set all [atomselect top "protein and alpha"]

# Select specific helices by residue ID (customize as needed)
set helix [atomselect top "protein and resid 565 to 592 and alpha"]
set helix1 [atomselect top "protein and resid 597 to 624 and alpha"]
set helix2 [atomselect top "protein and resid 629 to 656 and alpha"]
set helix3 [atomselect top "protein and resid 676 to 700 and alpha"]
set helix4 [atomselect top "protein and resid 724 to 747 and alpha"]
set helix5 [atomselect top "protein and resid 758 to 782 and alpha"]
set helix6 [atomselect top "protein and resid 787 to 810 and alpha"]

# Define reference structures from frame 0
set refall [atomselect top "protein and alpha" frame 0]
set refhelix [atomselect top "protein and resid 565 to 592 and alpha" frame 0]
set refhelix1 [atomselect top "protein and resid 597 to 624 and alpha" frame 0]
set refhelix2 [atomselect top "protein and resid 629 to 656 and alpha" frame 0]
set refhelix3 [atomselect top "protein and resid 676 to 700 and alpha" frame 0]
set refhelix4 [atomselect top "protein and resid 724 to 749 and alpha" frame 0]
set refhelix5 [atomselect top "protein and resid 758 to 782 and alpha" frame 0]
set refhelix6 [atomselect top "protein and resid 787 to 810 and alpha" frame 0]

# Get the number of frames in the trajectory
set num_steps [molinfo 0 get numframes]

# Loop over all frames and compute RMSD for each helix
for {set frame 1} {$frame < $num_steps} {incr frame} {
    $all frame $frame
    $helix frame $frame
    $helix1 frame $frame
    $helix2 frame $frame
    $helix3 frame $frame
    $helix4 frame $frame
    $helix5 frame $frame
    $helix6 frame $frame

    set trans [measure fit $all $refall]
    $all move $trans

    set rmsdh [measure rmsd $helix $refhelix]
    set rmsdh1 [measure rmsd $helix1 $refhelix1]
    set rmsdh2 [measure rmsd $helix2 $refhelix2]
    set rmsdh3 [measure rmsd $helix3 $refhelix3]
    set rmsdh4 [measure rmsd $helix4 $refhelix4]
    set rmsdh5 [measure rmsd $helix5 $refhelix5]
    set rmsdh6 [measure rmsd $helix6 $refhelix6]
    set rmsdhpro [measure rmsd $all $refall]

    puts stderr "$frame $rmsdh $rmsdh1 $rmsdh2 $rmsdh3 $rmsdh4 $rmsdh5 $rmsdh6 $rmsdhpro"
}

quit
