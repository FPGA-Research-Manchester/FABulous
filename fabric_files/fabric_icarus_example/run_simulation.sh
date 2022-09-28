#!/usr/bin/env bash
set -ex
BITSTREAM=test_design/counter.bin
VERILOG=../../fabric_generator/verilog_output
MAX_BITBYTES=16384

iverilog $VERILOG/* fabulous_tb.v -s fab_tb -o fab_tb.vvp
python3 makehex.py $BITSTREAM $MAX_BITBYTES bitstream.hex
vvp fab_tb.vvp
