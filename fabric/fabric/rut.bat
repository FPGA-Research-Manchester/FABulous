@cls
set script=gen.py
REM set script=gen_almost
@ECHO .
@ECHO  +++ Test switch matrix CSV generation +++
%script% -GenTileSwitchMatrixCSV > log.tst
@fc "r:\work\FORTE\FPGA\fabric\CLB_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\CLB_switch_matrix.csv" >> log.tst && Echo CLB_switch_matrix.csv OK || echo CLB_switch_matrix.csv ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\N_term_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\N_term_switch_matrix.csv" >> log.tst || echo N_term_switch_matrix.csv ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\E_term_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\E_term_switch_matrix.csv" >> log.tst || echo E_term_switch_matrix.csv ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\S_term_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\S_term_switch_matrix.csv" >> log.tst || echo S_term_switch_matrix.csv ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\W_term_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\W_term_switch_matrix.csv" >> log.tst || echo W_term_switch_matrix.csv ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\IO_switch_matrix.csv" "r:\work\FORTE\FPGA\fabric\regression\IO_switch_matrix.csv" >> log.tst || echo IO_switch_matrix.csv ************ failed ************

@ECHO .
@ECHO  +++ test switch matrix VHDL generation
@REM The previous step creates empty switch matrix dscriptions (csv-files) so we need some test data:
@cp -f "r:\work\FORTE\FPGA\fabric\regression\CLB_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\CLB_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\IO_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\IO_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\E_term_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\E_term_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\N_term_IO_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\N_term_IO_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\N_term_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\N_term_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\S_term_IO_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\S_term_IO_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\S_term_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\S_term_switch_matrix.csv"
@cp -f "r:\work\FORTE\FPGA\fabric\regression\W_term_switch_matrix.tst" "r:\work\FORTE\FPGA\fabric\W_term_switch_matrix.csv"
%script% -GenTileSwitchMatrixVHDL >> log.tst
@fc "r:\work\FORTE\FPGA\fabric\CLB_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\CLB_switch_matrix.vhdl" >> log.tst && Echo CLB_switch_matrix.vhdl OK || echo CLB_switch_matrix.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\N_term_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\N_term_switch_matrix.vhdl" >> log.tst || echo N_term_switch_matrix.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\E_term_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\E_term_switch_matrix.vhdl" >> log.tst || echo E_term_switch_matrix.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\S_term_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\S_term_switch_matrix.vhdl" >> log.tst || echo S_term_switch_matrix.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\W_term_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\W_term_switch_matrix.vhdl" >> log.tst || echo W_term_switch_matrix.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\IO_switch_matrix.vhdl" "r:\work\FORTE\FPGA\fabric\regression\IO_switch_matrix.vhdl" >> log.tst || echo IO_switch_matrix.vhdl ************ failed ************

@ECHO .
@ECHO  +++ test tile VHDL generation
%script% -GenTileHDL >> log.tst
@fc "r:\work\FORTE\FPGA\fabric\CLB_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\CLB_tile.vhdl" >> log.tst && echo CLB_tile.vhdl OK || echo CLB_tile.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\N_term_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\N_term_tile.vhdl" >> log.tst || echo N_term_tile.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\E_term_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\E_term_tile.vhdl" >> log.tst || echo E_term_tile.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\S_term_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\S_term_tile.vhdl" >> log.tst || echo S_term_tile.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\W_term_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\W_term_tile.vhdl" >> log.tst || echo W_term_tile.vhdl ************ failed ************
@fc "r:\work\FORTE\FPGA\fabric\IO_tile.vhdl" "r:\work\FORTE\FPGA\fabric\regression\IO_tile.vhdl" >> log.tst || echo IO_tile.vhdl ************ failed ************

%script% %1 %2 %3