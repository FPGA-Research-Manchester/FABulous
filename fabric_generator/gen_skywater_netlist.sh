#!/bin/bash
set -ex
/usr/bin/time -v ./clean.sh
/usr/bin/time -v ./create_basic_files.sh
/usr/bin/time -v cp $1 ./fabric.csv
/usr/bin/time -v ./run_fab_flow.sh
/usr/bin/time -v rm verilog_output/N_term_DSP_ConfigMem.v
/usr/bin/time -v rm verilog_output/N_term_RAM_IO_ConfigMem.v
/usr/bin/time -v rm verilog_output/N_term_single_ConfigMem.v
/usr/bin/time -v rm verilog_output/N_term_single2_ConfigMem.v
/usr/bin/time -v rm verilog_output/S_term_DSP_ConfigMem.v
/usr/bin/time -v rm verilog_output/S_term_RAM_IO_ConfigMem.v
/usr/bin/time -v rm verilog_output/S_term_single_ConfigMem.v
/usr/bin/time -v rm verilog_output/S_term_single2_ConfigMem.v

/usr/bin/time -v python3 gen_DSP_tile.py

/usr/bin/time -v rm verilog_output/fabric.v

/usr/bin/time -v python3 fabulous_top_wrapper/top_wrapper_generator_with_BRAM.py -c $2 -r $3

/usr/bin/time -v rm verilog_output/tb_bitbang.vhd