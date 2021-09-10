# Yosys for the FABulous VPR flow

The vpr.ys file in this directory contains a Yosys flow that will output a blif file compatible with our VPR flow. It can be run with `yosys vpr.ys` in this directory (providing Yosys is installed), and expects the name of the circuit to be circ.v and that it is  present in the directory - the name of this file can be changed in the top line of vpr.ys. It will create a file in the same directory called circ.blif (the name of which can be changed in the last line of vpr.ys), which can be used as a circuit input to VPR.
