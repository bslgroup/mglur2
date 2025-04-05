# Hydrogen Bond Analysis Script using VMD
# This script identifies unique hydrogen bonds within a selected protein segment across a trajectory.

# Load the structure and trajectory files
mol new path/to/structure.psf
mol addfile path/to/structure.pdb
mol addfile path/to/trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Load the hbonds plugin
package require hbonds 1.2

# Select atoms of interest (modify segname as needed)
set sel1 [atomselect 0 "protein and segname PROA"]

# Run hydrogen bond analysis with the following parameters:
# - distance cutoff: 4.0 Å
# - angle cutoff: 30 degrees
# - type: unique (removes redundant listings)
# - write output to file
hbonds -sel1 $sel1 \
       -dist 4.0 \
       -ang 30 \
       -type unique \
       -writefile yes \
       -detailout path/to/output/hbonds_details_PROA.dat

quit
