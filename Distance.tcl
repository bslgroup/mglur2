# COM Distance Analysis Script using VMD
# This script calculates the distance between the centers of mass (COM)
# of two protein segments (e.g., PROA and PROB) across a trajectory.

# Load structure and trajectory
mol new path/to/structure.psf
mol addfile path/to/structure.pdb
mol addfile path/to/trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Select atoms
set all [atomselect top "all"]
set PROA [atomselect top "segname PROA"]
set PROB [atomselect top "segname PROB"]
set ref  [atomselect top "protein and alpha" frame 0]
set com  [atomselect top "protein and alpha"]

# Get number of trajectory frames
set num_steps [molinfo top get numframes]

# Loop through all frames
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $all frame $frame
    $PROA frame $frame
    $PROB frame $frame
    $com frame $frame

    # Align current frame to reference
    $all move [measure fit $com $ref]

    # Measure center of mass difference vector
    set d1 [vecsub [measure center $PROA] [measure center $PROB]]

    # Calculate magnitude (Euclidean distance)
    set m1 [veclength $d1]

    # Print frame number and distance to stderr
    puts stderr "$frame $m1"
}

quit
