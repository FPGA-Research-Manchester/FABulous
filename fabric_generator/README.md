<img src="https://www.dropbox.com/s/frnugxm1kjvv947/FABulous_flow2.png?raw=1" width="500"/>


The user can run the flow step by step as well (see below for instructions on building HDLs):

### 1. Generate the switch matrix as an empty CSV file containing the adjacency matrix
```
python3 fabric_gen.py -GenTileSwitchMatrixCSV
```

### 2. Populate the switch matrix (adjacency matrix) entries
We do this for each tile individually in order to have some control what gets updated
```
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
```

### 3. Generate the tile switch matrices (RTL)
```
python3 fabric_gen.py -GenTileSwitchMatrixVHDL
```
or
```
python3 fabric_gen.py -GenTileSwitchMatrixVerilog
```

### 4. Generate the configuration storage (RTL)
```
python3 fabric_gen.py -GenTileConfigMemVHDL
```
or
```
python3 fabric_gen.py -GenTileConfigMemVerilog
```

### 5. Generate the actual tiles (RTL)
```
python3 fabric_gen.py -GenTileHDL
```
or
```
python3 fabric_gen.py -GenTileVerilog
```

### 6. Generate the entire fabric (RTL)
```
python3 fabric_gen.py -GenFabricHDL
```
or
```
python3 fabric_gen.py -GenFabricVerilog
```
