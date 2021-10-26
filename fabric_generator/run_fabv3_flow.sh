#REM STEP 1 : Generate the switch matrix as an empty CSV file containing the adjacency matrix (gets populated in Step 2)
python3 fabric_gen_v3.py -GenTileSwitchMatrixCSV

#REM STEP 2 : populate the switch matrix (adjacency matrix) entries
#REM We do this for each tile individually in order to have some control what gets updated
python3 fabric_gen_v3.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV N_term_RAM_IO_switch_matrix.list N_term_RAM_IO_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV S_term_RAM_IO_switch_matrix.list S_term_RAM_IO_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV N_term_single2_switch_matrix.list N_term_single2_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV S_term_single2_switch_matrix.list S_term_single2_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV N_term_DSP_switch_matrix.list N_term_DSP_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV S_term_DSP_switch_matrix.list S_term_DSP_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV RAM_IO_switch_matrix.list RAM_IO_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV RegFile_switch_matrix.list RegFile_switch_matrix.csv

python3 fabric_gen_v3.py -AddList2CSV DSP_top_switch_matrix.list DSP_top_switch_matrix.csv
python3 fabric_gen_v3.py -AddList2CSV DSP_bot_switch_matrix.list DSP_bot_switch_matrix.csv

#REM STEP 3 : generate the tile switch matrices (RTL)
python3 fabric_gen_v3.py -GenTileSwitchMatrixVHDL
python3 fabric_gen_v3.py -GenTileSwitchMatrixVerilog

#REM STEP 4 : generate the configuration storage (RTL)
python3 fabric_gen_v3.py -GenTileConfigMemVHDL
python3 fabric_gen_v3.py -GenTileConfigMemVerilog

#REM STEP 5 : generate the actual tiles (RTL)
python3 fabric_gen_v3.py -GenTileHDL
python3 fabric_gen_v3.py -GenTileVerilog

#REM STEP 6 : generate the entire fabric (RTL)
#python3 fabric_gen_v3.py -GenFabricHDL
python3 fabric_gen_v3.py -GenFabricVerilog

#REM STEP 7 : generate the nextpnr model
python3 fabric_gen_v3.py -GenNextpnrModel
python3 fabric_gen_v3.py -GenBitstreamSpec npnroutput/meta_data_v3.txt
#GOTO END

mkdir -p verilog_output
mv -f *.v ./verilog_output

mkdir -p vhdl_output
mv -f *.vhdl ./vhdl_output

mkdir -p list_files
mv -f *.list ./list_files

mkdir -p csv_output
mv -f *.csv ./csv_output
