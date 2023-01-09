#!/usr/bin/env bash

SYNTH_TCL=../../nextpnr/fabulous/synth/synth_fabulous.tcl
BIT_GEN=../../nextpnr/fabulous/fab_arch/bit_gen.py

if [[ -z "${DESIGN}" ]]; then
	DESIGN=shiftreg
fi

set -ex
yosys -qp "synth_fabulous -top top_wrapper -json test_design/${DESIGN}.json" test_design/${DESIGN}.v test_design/top_wrapper.v

FAB_ROOT=../../fabric_generator nextpnr-generic --uarch fabulous --json test_design/${DESIGN}.json -o fasm=test_design/${DESIGN}_des.fasm
python3 ${BIT_GEN} -genBitstream test_design/${DESIGN}_des.fasm ../../fabric_generator/npnroutput/meta_data.txt test_design/${DESIGN}.bin
