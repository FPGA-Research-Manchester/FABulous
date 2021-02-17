# FABulous: an Embedded FPGA Framework

## Introdution
FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

## How to cite
...
...

## Prerequisites
The following packages need to be installed for generating fabric HDLs
 - Python 3.5 or later

## Getting started

Fabric generator flow is run with bash script under ```/scripts```, using the following commands to build the entire FPGA fabric in both VHDL and Verilog:
```
cd scripts
./run_gen_flow.sh
```
<img src="https://www.dropbox.com/s/frnugxm1kjvv947/FABulous_flow2.png?raw=1" width="500"/>

The user can run the flow step by step as well (see below for instructions on building HDLs):

### Generate the switch matrix as an empty CSV file containing the adjacency matrix
```
python3 gen.py -GenTileSwitchMatrixCSV
```

### Populate the switch matrix (adjacency matrix) entries
We do this for each tile individually in order to have some control what gets updated
```
python3 gen.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv
python3 gen.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
python3 gen.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv
python3 gen.py -AddList2CSV N_term_single2_switch_matrix.list N_term_single2_switch_matrix.csv
python3 gen.py -AddList2CSV S_term_single2_switch_matrix.list S_term_single2_switch_matrix.csv
python3 gen.py -AddList2CSV CPU_IO_switch_matrix.list CPU_IO_switch_matrix.csv
python3 gen.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv
python3 gen.py -AddList2CSV RegFile_switch_matrix.list RegFile_switch_matrix.csv
python3 gen.py -AddList2CSV DSP_top_switch_matrix.list DSP_top_switch_matrix.csv
python3 gen.py -AddList2CSV DSP_bot_switch_matrix.list DSP_bot_switch_matrix.csv
```

### Generate the tile switch matrices (RTL)
```
python3 gen.py -GenTileSwitchMatrixVHDL
```
or
```
python3 gen.py -GenTileSwitchMatrixVerilog
```

### Generate the configuration storage (RTL)
```
python3 gen.py -GenTileConfigMemVHDL
```
or
```
python3 gen.py -GenTileConfigMemVerilog
```

### Generate the actual tiles (RTL)
```
python3 gen.py -GenTileHDL
```
or
```
python3 gen.py -GenTileVerilog
```

### Generate the entire fabric (RTL)
```
python3 gen.py -GenFabricHDL
```
or
```
python3 gen.py -GenFabricVerilog
```
