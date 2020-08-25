@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim tb_eFPGA_top_behav -key {Behavioral:sim_2:Functional:tb_eFPGA_top} -tclbatch tb_eFPGA_top.tcl -view R:/work/FORTE/FPGA/fabric/vivado2/tb_eFPGA_top_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
