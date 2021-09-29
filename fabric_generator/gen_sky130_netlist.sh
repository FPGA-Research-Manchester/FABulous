#!/bin/bash
set -ex
/usr/bin/time -v ./clean.sh
/usr/bin/time -v ./create_basic_files_with_DSP.sh
/usr/bin/time -v cp $1 ./fabric.csv
/usr/bin/time -v ./run_fab_flow_with_DSP.sh
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
#/usr/bin/time -v yosys ${2}.ys -l ${2}_log.txt
#/usr/bin/time -v nextpnr-fabulous --json ${2}.json --pcf template.pcf --fasm ${2}.fasm  --freq 200 --verbose --debug --log ${2}_npnr_log.txt
#/usr/bin/time -v nextpnr-fabulous --json ${2}.json --pcf template.pcf --fasm ${2}.fasm --no-tmdriv --verbose --save ${2}_project --log ${2}_npnr_log.txt
#/usr/bin/time -v python3 bit_gen.py -genBitstream ${2}.fasm meta_data_tsmc.txt ${2}_tsmc_output.bin
