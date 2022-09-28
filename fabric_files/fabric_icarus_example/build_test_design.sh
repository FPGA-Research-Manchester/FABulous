#!/usr/bin/env bash

SYNTH_TCL=../../nextpnr/fabulous/synth/synth_fabulous.tcl
DESIGN=counter

set -ex
yosys -qp "tcl $SYNTH_TCL 4 top_wrapper test_design/${DESIGN}.json" test_design/${DESIGN}.v test_design/top_wrapper.v
FAB_ROOT=../../fabric_generator nextpnr-generic --uarch fabulous --json test_design/${DESIGN}.json -o fasm=test_design/${DESIGN}_des.fasm
