#!/usr/bin/env bash
set -ex
DESIGN=counter
BITSTREAM=test_design/${DESIGN}.bin
VHDL=../../fabric_generator/vhdl_output
FLAG=--std=08
# GHDL=./ghdl-macos-12-llvm/bin/ghdl
GHDL=ghdl


MAX_BITBYTES=16384

python3 makehex.py $BITSTREAM $MAX_BITBYTES bitstream.hex

$GHDL -a $FLAG $VHDL/my_lib.vhdl
$GHDL -e $FLAG LHD1 
$GHDL -e $FLAG LHQD1 
$GHDL -e $FLAG MUX4PTv4 
$GHDL -e $FLAG MUX16PTv2

$GHDL -a $FLAG $VHDL/LUT4AB_switch_matrix.vhdl \
              $VHDL/LUT4AB_ConfigMem.vhdl \
              $VHDL/LUT4c_frame_config.vhdl \
              $VHDL/MUX8LUT_frame_config.vhdl \
              $VHDL/LUT4AB_tile.vhdl

$GHDL -a $FLAG $VHDL/RAM_IO_switch_matrix.vhdl \
              $VHDL/RAM_IO_ConfigMem.vhdl \
              $VHDL/InPass4_frame_config.vhdl \
              $VHDL/OutPass4_frame_config.vhdl \
              $VHDL/RAM_IO_tile.vhdl

$GHDL -a $FLAG $VHDL/RegFile_switch_matrix.vhdl \
              $VHDL/RegFile_ConfigMem.vhdl \
              $VHDL/RegFile_32x4.vhdl \
              $VHDL/RegFile_tile.vhdl

$GHDL -a $FLAG $VHDL/W_IO_switch_matrix.vhdl \
              $VHDL/W_IO_ConfigMem.vhdl \
              $VHDL/IO_1_bidirectional_frame_config_pass.vhdl \
              $VHDL/Config_access.vhdl \
              $VHDL/W_IO_tile.vhdl

$GHDL -a $FLAG $VHDL/DSP_top_switch_matrix.vhdl \
              $VHDL/DSP_top_ConfigMem.vhdl \
              $VHDL/DSP_top_tile.vhdl

$GHDL -a $FLAG $VHDL/DSP_bot_switch_matrix.vhdl \
              $VHDL/DSP_bot_ConfigMem.vhdl \
              $VHDL/MULADD.vhdl \
              $VHDL/DSP_bot_tile.vhdl

$GHDL -a $FLAG $VHDL/N_term_DSP_switch_matrix.vhdl \
              $VHDL/N_term_DSP_ConfigMem.vhdl \
              $VHDL/N_term_DSP_tile.vhdl

$GHDL -a $FLAG $VHDL/S_term_DSP_switch_matrix.vhdl \
              $VHDL/S_term_DSP_ConfigMem.vhdl \
              $VHDL/S_term_DSP_tile.vhdl

$GHDL -a $FLAG $VHDL/N_term_RAM_IO_switch_matrix.vhdl \
              $VHDL/N_term_RAM_IO_ConfigMem.vhdl \
              $VHDL/N_term_RAM_IO_tile.vhdl

$GHDL -a $FLAG $VHDL/S_term_RAM_IO_switch_matrix.vhdl \
              $VHDL/S_term_RAM_IO_ConfigMem.vhdl \
              $VHDL/S_term_RAM_IO_tile.vhdl

$GHDL -a $FLAG $VHDL/N_term_single_switch_matrix.vhdl \
              $VHDL/N_term_single_ConfigMem.vhdl \
              $VHDL/N_term_single_tile.vhdl

$GHDL -a $FLAG $VHDL/S_term_single_switch_matrix.vhdl \
              $VHDL/S_term_single_ConfigMem.vhdl \
              $VHDL/S_term_single_tile.vhdl

$GHDL -a $FLAG $VHDL/N_term_single2_switch_matrix.vhdl \
              $VHDL/N_term_single2_ConfigMem.vhdl \
              $VHDL/N_term_single2_tile.vhdl

$GHDL -a $FLAG $VHDL/S_term_single2_switch_matrix.vhdl \
              $VHDL/S_term_single2_ConfigMem.vhdl \
              $VHDL/S_term_single2_tile.vhdl


$GHDL -a $FLAG $VHDL/eFPGA_top.vhdl \
              $VHDL/config_UART.vhdl\
              $VHDL/bitbang.vhdl\
              $VHDL/Config.vhdl \
              $VHDL/ConfigFSM.vhdl \
              $VHDL/Frame_Data_Reg.vhdl \
              $VHDL/Frame_Select.vhdl \
              $VHDL/fabric.vhdl

$GHDL -a $FLAG $VHDL/eFPGA_top.vhdl ./test_design/counter.vhdl ./fabulous_tb.vhdl
$GHDL -e $FLAG fab_tb
$GHDL -r $FLAG fab_tb --assert-level=error --ieee-asserts=disable 


# with traces. The wave_filter is a file that contains the signals to be traced
# $GHDL -r $FLAG fab_tb --assert-level=error --ieee-asserts=disable --vcd=trace.vcd --read-wave-opt=wave_filter
