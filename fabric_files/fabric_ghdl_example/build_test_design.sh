#!/usr/bin/env bash

SYNTH_TCL=../../fabric_cad/synth/synth_fabulous.tcl
BIT_GEN=../../fabric_cad/bit_gen.py


DESIGN=counter

set -ex
yosys -qp "tcl $SYNTH_TCL 4 top_wrapper test_design/${DESIGN}.json" test_design/${DESIGN}.v test_design/top_wrapper.v
# yosys -qp "tcl $SYNTH_TCL 4 top_wrapper test_design/${DESIGN}.json" ../generic/IO_1_bidirectional_frame_config_pass.v test_design/${DESIGN}.v test_design/top_wrapper.v

FAB_ROOT=../../fabric_generator nextpnr-generic --uarch fabulous --json test_design/${DESIGN}.json -o fasm=test_design/${DESIGN}_des.fasm
python3 ${BIT_GEN} -genBitstream test_design/${DESIGN}_des.fasm ../../fabric_generator/npnroutput/meta_data.txt test_design/${DESIGN}.bin
