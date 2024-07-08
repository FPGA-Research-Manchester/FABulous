#!/bin/bash

DEFINED_OPTION=$1
DESIGN=$2
PROJECT=$3
mkdir -p $PROJECT/ghdl_simul_files
OUTPUTdir=$PROJECT/ghdl_simul_files
FLAG="--std=08 -O2 --workdir=$OUTPUTdir -fexplicit"
eFLAG="--std=08 -O2"
GHDL=ghdl
VHDL=$PROJECT/Tile
FABRIC=$PROJECT/Fabric
ulimit -s unlimited

echo "Crrent working directory: $(pwd)"
echo "Script is located at: $(dirname "$(readlink -f "$0")")"

$GHDL -a $FLAG $FABRIC/my_lib.vhdl
cd $PROJECT/ghdl_simul_files
echo "Current working directory: $(pwd)"
$GHDL -e $eFLAG LHQD1 
$GHDL -e $eFLAG MUX4PTv4 
$GHDL -e $eFLAG MUX16PTv2
$GHDL -e $eFLAG cus_mux161
$GHDL -e $eFLAG cus_mux41
$GHDL -e $eFLAG cus_mux161_buf
$GHDL -e $eFLAG cus_mux41_buf
$GHDL -e $eFLAG cus_mux81
$GHDL -e $eFLAG my_mux2
$GHDL -e $eFLAG cus_mux81_buf
$GHDL -e $eFLAG my_buf
$GHDL -e $eFLAG clk_buf
cd ../../
echo "Current working directory: $(pwd)"

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


$GHDL -a $FLAG $VHDL/DSP/DSP_top/DSP_top.vhdl \
                $VHDL/DSP/DSP_bot/DSP_bot.vhdl \
                $VHDL/DSP/DSP.vhdl


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


$GHDL -a $FLAG $FABRIC/config_UART.vhdl 
$GHDL -a $FLAG $FABRIC/bitbang.vhdl
$GHDL -a $FLAG $FABRIC/ConfigFSM.vhdl 
$GHDL -a $FLAG $FABRIC/eFPGA_Config.vhdl 
$GHDL -a $FLAG $FABRIC/Frame_Data_Reg.vhdl 
$GHDL -a $FLAG $FABRIC/Frame_Select.vhdl 
$GHDL -a $FLAG $FABRIC/BlockRAM_1KB.vhdl
$GHDL -a $FLAG $FABRIC/eFPGA.vhdl
$GHDL -a $FLAG $FABRIC/eFPGA_top.vhdl 

$GHDL -a $FLAG $PROJECT/user_design/${DESIGN}.vhdl 
$GHDL -a $FLAG $PROJECT/Test/${DESIGN}_tb.vhdl

cd $PROJECT/ghdl_simul_files
$GHDL -e $eFLAG "-fexplicit" ${DESIGN}_tb 
$GHDL -r $eFLAG ${DESIGN}_tb --stats --ieee-asserts=disable --${DEFINED_OPTION}=../Test/${DESIGN}_tb.${DEFINED_OPTION}
cd ../../
rm -rf $PROJECT/ghdl_simul_files
