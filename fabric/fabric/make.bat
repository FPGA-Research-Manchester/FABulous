CLS

@REM STEP 1 : Generate the switch matrix as an empty CSV file containing the adjacency matrix (gets populated in Step 2)
gen%1%.py -GenTileSwitchMatrixCSV

@REM STEP 2 : populate the switch matrix (adjacency matrix) entries
REM We do this for each tile individually in order to have some control what gets updated
gen%1%.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv
gen%1%.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
gen%1%.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv
gen%1%.py -AddList2CSV N_term_single2_switch_matrix.list N_term_single2_switch_matrix.csv
gen%1%.py -AddList2CSV S_term_single2_switch_matrix.list S_term_single2_switch_matrix.csv
gen%1%.py -AddList2CSV CPU_IO_switch_matrix.list CPU_IO_switch_matrix.csv
gen%1%.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv
gen%1%.py -AddList2CSV RegFile_switch_matrix.list RegFile_switch_matrix.csv
gen%1%.py -AddList2CSV DSP_top_switch_matrix.list DSP_top_switch_matrix.csv
gen%1%.py -AddList2CSV DSP_bot_switch_matrix.list DSP_bot_switch_matrix.csv

@REM STEP 3 : generate the tile switch matrices (RTL)
gen%1%.py -GenTileSwitchMatrixVHDL

@REM STEP 4 : generate the configuration storage (RTL)
gen%1%.py -GenTileConfigMemVHDL

@REM STEP 5 : generate the actual tiles (RTL)
gen%1%.py -GenTileHDL

@REM STEP 6 : generate the entire fabric (RTL)
gen%1%.py -GenFabricHDL

GOTO END

cat "LUT4AB_switch_matrix.vhdl" |grep -A 2 "MUX-16" | sed 's/after.*//g' | tr "=&(" "," | tr -d ");<" | sed 's/ downto /,/g' >MUX16.csv
cat "LUT4AB_switch_matrix.vhdl" |grep -A 2 "MUX-16" | sed 's/after.*//g' | tr "=&(" "," | tr -d ");<" | sed 's/ downto /,/g' | grep Bits | sed 's/.*Bits,//1' > MUX16.index.csv
REM take the last file and create the following in Excel
REM 27	24		146		#	173	:	170
REM 31	28		146		#	177	:	174
REM 59	56		146		#	205	:	202
cat  MUX16.index.xls | sed 's/.*#//1' | tr -d "," | sed 's/$/,/1'

:END