#!/usr/bin/env bash
set -ex
DESIGN=shiftreg
BITSTREAM=test_design/${DESIGN}.bin
VERILOG=../../fabric_generator/verilog_output
MAX_BITBYTES=16384

iverilog -D EMULATION_MODE -s fab_emulation_tb -o fab_tb.vvp test_design/${DESIGN}.vh $VERILOG/* test_design/${DESIGN}.v fabulous_tb.v 
vvp fab_tb.vvp -fst
