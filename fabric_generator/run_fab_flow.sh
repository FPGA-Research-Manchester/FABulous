#REM STEP 1 : Generate the switch matrix as an empty CSV file containing the adjacency matrix (gets populated in Step 2)
python3 fabric_gen.py -GenTileSwitchMatrixCSV
#REM STEP 2 : populate the switch matrix (adjacency matrix) entries
#REM We do this for each tile individually in order to have some control what gets updated
python3 fabric_gen.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV N_term_single2_switch_matrix.list N_term_single2_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV S_term_single2_switch_matrix.list S_term_single2_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV CPU_IO_switch_matrix.list CPU_IO_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV RegFile_switch_matrix.list RegFile_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV DSP_top_switch_matrix.list DSP_top_switch_matrix.csv
python3 fabric_gen.py -AddList2CSV DSP_bot_switch_matrix.list DSP_bot_switch_matrix.csv
#REM STEP 3 : generate the tile switch matrices (RTL)
python3 fabric_gen.py -GenTileSwitchMatrixVHDL
python3 fabric_gen.py -GenTileSwitchMatrixVerilog
#REM STEP 4 : generate the configuration storage (RTL)
python3 fabric_gen.py -GenTileConfigMemVHDL
python3 fabric_gen.py -GenTileConfigMemVerilog
#REM STEP 5 : generate the actual tiles (RTL)
python3 fabric_gen.py -GenTileHDL
python3 fabric_gen.py -GenTileVerilog
#REM STEP 6 : generate the entire fabric (RTL)
python3 fabric_gen.py -GenFabricHDL
python3 fabric_gen.py -GenFabricVerilog
#GOTO END

if [ -d "./verilog_files" ]; then
  # Take action if $DIR exists. #
  mv -f *.v ./verilog_output
else
  mkdir verilog_output
  mv -f *.v ./verilog_output
fi

if [ -d "./vhdl_files" ]; then
  # Take action if $DIR exists. #
  mv -f *.vhdl ./vhdl_output
else
  mkdir vhdl_output
  mv -f *.vhdl ./vhdl_output
fi

if [ -d "./list_files" ]; then
  # Take action if $DIR exists. #
  mv -f *.list ./list_files
else
  mkdir list_files
  mv -f *.list ./list_files
fi


if [ -d "./csv_files" ]; then
  # Take action if $DIR exists. #
  mv -f *.csv ./csv_output
else
  mkdir csv_output
  mv -f *.csv ./csv_output
fi
