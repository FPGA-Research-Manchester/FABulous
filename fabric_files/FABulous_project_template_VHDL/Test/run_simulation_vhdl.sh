#!/usr/bin/env bash
set -ex
DESIGN=counter
BITSTREAM=test_design/${DESIGN}.bin
VHDL=../Tile
FLAG=--std=08
# GHDL=./ghdl-macos-12-llvm/bin/ghdl
GHDL=ghdl


MAX_BITBYTES=16384

python3 makehex.py $BITSTREAM $MAX_BITBYTES bitstream.hex

$GHDL -a $FLAG ../Fabric/my_lib.vhdl
$GHDL -e $FLAG LHD1 
$GHDL -e $FLAG LHQD1 
$GHDL -e $FLAG MUX4PTv4 
$GHDL -e $FLAG MUX16PTv2

$GHDL -a $FLAG $VHDL/LUT4AB/LUT4AB_switch_matrix.vhdl \
              $VHDL/LUT4AB/LUT4AB_ConfigMem.vhdl \
              $VHDL/LUT4AB/LUT4c_frame_config.vhdl \
              $VHDL/LUT4AB/MUX8LUT_frame_config.vhdl \
              $VHDL/LUT4AB/LUT4AB.vhdl

$GHDL -a $FLAG $VHDL/RAM_IO/RAM_IO_switch_matrix.vhdl \
              $VHDL/RAM_IO/RAM_IO_ConfigMem.vhdl \
              $VHDL/RAM_IO/InPass4_frame_config.vhdl \
              $VHDL/RAM_IO/OutPass4_frame_config.vhdl \
              $VHDL/RAM_IO/RAM_IO.vhdl

$GHDL -a $FLAG $VHDL/RegFile/RegFile_switch_matrix.vhdl \
              $VHDL/RegFile/RegFile_ConfigMem.vhdl \
              $VHDL/RegFile/RegFile_32x4.vhdl \
              $VHDL/RegFile/RegFile.vhdl

$GHDL -a $FLAG $VHDL/W_IO/W_IO_switch_matrix.vhdl \
              $VHDL/W_IO/W_IO_ConfigMem.vhdl \
              $VHDL/W_IO/IO_1_bidirectional_frame_config_pass.vhdl \
              $VHDL/W_IO/Config_access.vhdl \
              $VHDL/W_IO/W_IO.vhdl

$GHDL -a $FLAG $VHDL/DSP/DSP_top/DSP_top_switch_matrix.vhdl \
              $VHDL/DSP/DSP_top/DSP_top_ConfigMem.vhdl \
              $VHDL/DSP/DSP_top/DSP_top.vhdl

$GHDL -a $FLAG $VHDL/DSP/DSP_bot/DSP_bot_switch_matrix.vhdl \
              $VHDL/DSP/DSP_bot/DSP_bot_ConfigMem.vhdl \
              $VHDL/DSP/DSP_bot/MULADD.vhdl \
              $VHDL/DSP/DSP_bot/DSP_bot.vhdl

$GHDL -a $FLAG $VHDL/N_term_DSP/N_term_DSP_switch_matrix.vhdl \
              $VHDL/N_term_DSP/N_term_DSP_ConfigMem.vhdl \
              $VHDL/N_term_DSP/N_term_DSP.vhdl

$GHDL -a $FLAG $VHDL/S_term_DSP/S_term_DSP_switch_matrix.vhdl \
              $VHDL/S_term_DSP/S_term_DSP_ConfigMem.vhdl \
              $VHDL/S_term_DSP/S_term_DSP.vhdl

$GHDL -a $FLAG $VHDL/N_term_RAM_IO/N_term_RAM_IO_switch_matrix.vhdl \
              $VHDL/N_term_RAM_IO/N_term_RAM_IO_ConfigMem.vhdl \
              $VHDL/N_term_RAM_IO/N_term_RAM_IO.vhdl

$GHDL -a $FLAG $VHDL/S_term_RAM_IO/S_term_RAM_IO_switch_matrix.vhdl \
              $VHDL/S_term_RAM_IO/S_term_RAM_IO_ConfigMem.vhdl \
              $VHDL/S_term_RAM_IO/S_term_RAM_IO.vhdl

$GHDL -a $FLAG $VHDL/N_term_single/N_term_single_switch_matrix.vhdl \
              $VHDL/N_term_single/N_term_single_ConfigMem.vhdl \
              $VHDL/N_term_single/N_term_single.vhdl

$GHDL -a $FLAG $VHDL/S_term_single/S_term_single_switch_matrix.vhdl \
              $VHDL/S_term_single/S_term_single_ConfigMem.vhdl \
              $VHDL/S_term_single/S_term_single.vhdl

$GHDL -a $FLAG $VHDL/N_term_single2/N_term_single2_switch_matrix.vhdl \
              $VHDL/N_term_single2/N_term_single2_ConfigMem.vhdl \
              $VHDL/N_term_single2/N_term_single2.vhdl

$GHDL -a $FLAG $VHDL/S_term_single2/S_term_single2_switch_matrix.vhdl \
              $VHDL/S_term_single2/S_term_single2_ConfigMem.vhdl \
              $VHDL/S_term_single2/S_term_single2.vhdl


$GHDL -a $FLAG ../Fabric/eFPGA_top.vhdl \
              ../Fabric/config_UART.vhdl\
              ../Fabric/bitbang.vhdl\
              ../Fabric/Config.vhdl \
              ../Fabric/ConfigFSM.vhdl \
              ../Fabric/Frame_Data_Reg.vhdl \
              ../Fabric/Frame_Select.vhdl \
              ../Fabric/fabric.vhdl

$GHDL -a $FLAG ../Fabric/eFPGA_top.vhdl ./test_design/counter.vhdl ./fabulous_tb.vhdl
$GHDL -e $FLAG fab_tb
$GHDL -r $FLAG fab_tb --assert-level=error --ieee-asserts=disable 


# with traces. The wave_filter is a file that contains the signals to be traced
# $GHDL -r $FLAG fab_tb --assert-level=error --ieee-asserts=disable --vcd=trace.vcd --read-wave-opt=wave_filter
