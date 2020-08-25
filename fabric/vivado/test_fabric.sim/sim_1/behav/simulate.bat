@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim config_behav -key {Behavioral:sim_1:Functional:config} -tclbatch config.tcl -view R:/work/FORTE/FPGA/fabric/vivado/conf.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
