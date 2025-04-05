# Angle Analysis Using Inertia Tensors - VMD Script
# This script calculates angles between protein segments (PROA, PROB, etc.) and membrane 
# using the direction of principal inertia axes from a molecular dynamics trajectory.

# Load structure and trajectory
mol new path/to/structure.psf
mol addfile path/to/structure.pdb
mol addfile path/to/trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Atom selections
set all [atomselect top "protein"]
set mem [atomselect top "segname MEMB"]
set PROA_backbone [atomselect top "protein and segname PROA and backbone"]
set PROB_backbone [atomselect top "protein and segname PROB and backbone"]
set full_backbone [atomselect top "protein and backbone"]
set ref_all [atomselect top "protein" frame 0]
set ref_mem [atomselect top "segname MEMB" frame 0]
set ref_PROA_backbone [atomselect top "protein and segname PROA and backbone" frame 0]

# Number of frames
set num_steps [molinfo 0 get numframes]

# Loop over each frame
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $all frame $frame
    $mem frame $frame
    $PROA_backbone frame $frame
    $PROB_backbone frame $frame
    $full_backbone frame $frame

    # Fit and align for consistency
    $all move [measure fit $all $ref_all]
    $all move [measure fit $PROA_backbone $ref_PROA_backbone]

    # Angle between PROA and PROB
    set vec1 [lindex [measure inertia $PROA_backbone] 1 2]
    set vec2 [lindex [measure inertia $PROB_backbone] 1 2]
    set angle1 [expr 180 * acos([vecdot $vec1 $vec2]) / acos(-1)]
    if {$angle1 > 90} { set angle1 [expr 180 - $angle1] }

    # Angle between PROA and membrane
    $all move [measure fit $mem $ref_mem]
    set vec_mem [lindex [measure inertia $mem] 1 2]
    set angle2 [expr 180 * acos([vecdot $vec1 $vec_mem]) / acos(-1)]
    if {$angle2 > 90} { set angle2 [expr 180 - $angle2] }

    # Angle between PROB and membrane
    set vec3 [lindex [measure inertia $PROB_backbone] 1 2]
    set angle3 [expr 180 * acos([vecdot $vec3 $vec_mem]) / acos(-1)]
    if {$angle3 > 90} { set angle3 [expr 180 - $angle3] }

    # Angle between entire protein and membrane
    set vec4 [lindex [measure inertia $full_backbone] 1 2]
    set angle4 [expr 180 * acos([vecdot $vec4 $vec_mem]) / acos(-1)]
    if {$angle4 > 90} { set angle4 [expr 180 - $angle4] }

    # Print results
    puts stderr "$frame $angle1 $angle2 $angle3 $angle4"
}

quit
