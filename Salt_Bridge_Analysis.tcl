# Salt Bridge Analysis Script using VMD
# This script identifies salt bridges in a protein over a trajectory using the saltbr package.

# Load structure and trajectory files
mol new path/to/structure.psf
mol addfile path/to/structure.pdb
mol addfile path/to/trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

# Load the saltbr plugin (required for salt bridge analysis)
package require saltbr 1.1

# Select all protein atoms
set sel [atomselect 0 "protein"]

# Run the salt bridge analysis across all frames
saltbr -sel $sel

# This will print salt bridge distances between residue pairs for each frame to the terminal
# You can redirect this output to a file when running from the command line

quit
