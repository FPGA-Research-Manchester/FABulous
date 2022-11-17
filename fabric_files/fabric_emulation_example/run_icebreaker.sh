#!/usr/bin/env bash
set -ex
DESIGN=blinky
BITSTREAM=test_design/${DESIGN}.bin
VERILOG=../../fabric_generator/verilog_output

DESIGN=${DESIGN} ./build_test_design.sh
yosys -D EMULATION_MODE -p "read_verilog test_design/${DESIGN}.vh $VERILOG/* icebreaker_emu.v; script synth_emulation_ice40.ys; write_json icebreaker_emu.json"
nextpnr-ice40 --up5k --package sg48 --pcf icebreaker_emu.pcf --json icebreaker_emu.json --asc icebreaker_emu.asc --ignore-loops
icepack icebreaker_emu.asc icebreaker_emu.bin
iceprog icebreaker_emu.bin
