# Load the PSF structure file
mol new path_to_structure_file.psf

# Load the PDB file (coordinate information)
mol addfile path_to_structure_file.pdb

# Load the DCD trajectory file for analysis
mol addfile path_to_trajectory_file.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Select all atoms and alpha carbon atoms (CA) from chain PROA
set all [atomselect top "all"]
set sel [atomselect top "protein and segname PROA and name CA"]

# Set the reference structure to the first frame
set ref [atomselect top "protein and segname PROA and name CA" frame 0]

# Get the total number of frames in the trajectory
set num_steps [molinfo 0 get numframes]

# Align all frames to the reference to remove translational and rotational motion
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $all frame $frame
    $sel frame $frame
    set trans [measure fit $sel $ref]
    $all move $trans
}

# Calculate and print RMSF (Root Mean Square Fluctuation) for each Cα atom
set rmsf [measure rmsf $sel first 0 last -1]
for {set i 0} {$i < [$sel num]} {incr i} {
    puts "[expr {$i+1}] \t [lindex $rmsf $i]"
}

quit
