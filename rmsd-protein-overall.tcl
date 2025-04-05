mol new /../../../...psf
mol addfile /../../../...pdb
mol addfile /../../../...dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all


set all [atomselect top "protein and alpha"]
set helix [atomselect top "protein and resid 565 to 592 and alpha"]
set helix1 [atomselect top "protein and resid 597 to 624 and alpha"]
set helix2 [atomselect top "protein and resid 629 to 656 and alpha"]
set helix3 [atomselect top "protein and resid 676 to 700 and alpha"]
set helix4 [atomselect top "protein and resid 724 to 747 and alpha"]
set helix5 [atomselect top "protein and resid 758 to 782 and alpha"]
set helix6 [atomselect top "protein and resid 782 to 810 and alpha"]

#ciregion
set refall [atomselect top "protein and alpha" frame 0]
set refhelix [atomselect top "protein and resid 568 to 592 and alpha" frame 0]
set refhelix1 [atomselect top "protein and resid 597 to 624 and alpha" frame 0]
set refhelix2 [atomselect top "protein and resid 629 to 656 and alpha" frame 0]
set refhelix3 [atomselect top "protein and resid 676 to 700 and alpha" frame 0]
set refhelix4 [atomselect top "protein and resid 724 to 747 and alpha" frame 0]
set refhelix5 [atomselect top "protein and resid 758 to 782 and alpha" frame 0]
set refhelix6 [atomselect top "protein and resid 782 to 810 and alpha" frame 0]



#set all [atomselect top "all"]

set num_steps [molinfo 0 get numframes]
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
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh1 [measure rmsd $helix1 $refhelix1]
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh2 [measure rmsd $helix2 $refhelix2]
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh3 [measure rmsd $helix3 $refhelix3]
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh4 [measure rmsd $helix4 $refhelix4]
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh5 [measure rmsd $helix5 $refhelix5]
    #
    set trans [measure fit $all $refall]
    $all move $trans
    set rmsdh6 [measure rmsd $helix6 $refhelix6]
    #
    
    set trans [measure fit $all  $refall]
    $all move $trans
    set rmsdhpro [measure rmsd $all $refall]
    #
     puts stderr "$frame $rmsdh $rmsdh1 $rmsdh2 $rmsdh3 $rmsdh4 $rmsdh5 $rmsdh6 $rmsdhpro" 
}
quit


