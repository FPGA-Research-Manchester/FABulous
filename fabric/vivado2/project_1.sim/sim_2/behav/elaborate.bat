@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 87f8b7b1cecd4e3c9340a6f0d61fcc62 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_eFPGA_top_behav xil_defaultlib.tb_eFPGA_top -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
