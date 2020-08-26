CLS

@REM STEP 1 : Generate the switch matrix
gen.py -GenTileSwitchMatrixCSV

@REM STEP 2 : populate the switch matrix entries
gen.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv
gen.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
gen.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv
gen.py -AddList2CSV CPU_IO_switch_matrix.list CPU_IO_switch_matrix.csv
gen.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv

@REM STEP 3 : generate the tile switch matrices (RTL)
gen.py -GenTileSwitchMatrixVHDL

@REM STEP 4 : generate the actual tiles (RTL)
gen.py -GenTileHDL

@REM STEP 5 : generate the entire fabric (RTL)
gen.py -GenFabricHDL

cat LUT4AB_tile.vhdl | uniq > uniq.vhd
mv -f uniq.vhd LUT4AB_tile.vhdl

cat fabric.vhdl | uniq > uniq.vhd
mv -f uniq.vhd fabric.vhdl

REM cat fabric.vhdl   | sed 's/Tile_.*_UserCLK/UserCLK/1' > fabric_clean.vhdl
REM I am only using the first UserCLK port definition
cat fabric.vhdl     | sed 's/Tile_.*_UserCLK/UserCLK/1' | grep -m 1 -B 100 UserCLK > fabric_clean.vhdl
REM Get all the rest of the entity but kick out any additional UserCLK port definition
cat fabric.vhdl     | sed 's/Tile_.*_UserCLK/UserCLK/1' | grep -A 10000 UserCLK | grep -B 10000 "end.entity" | grep -v "UserCLK.*STD_LOGIC;" >> fabric_clean.vhdl
REM In the architecture, we replace all "Tile_.*_UserCLK" signal names with "UserCLK"
cat fabric.vhdl     | sed 's/Tile_.*_UserCLK/UserCLK/1' | grep -A 10000 "architecture.Behavioral" >> fabric_clean.vhdl
mv -f fabric_clean.vhdl fabric.vhdl
