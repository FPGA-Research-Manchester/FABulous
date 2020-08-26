@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto d2a4776f45b040bf89e52f3622b2e4a6 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot config_behav xil_defaultlib.config -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
