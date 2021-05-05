# FABulous: an Embedded FPGA Framework
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Introdution
FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates Yosys, ABC, VPR and nextpnr as FPGA CAD tools, deals with the bitstream generation and after fabrication tests. Additionally, we will provide an emulation path for system development.

<img src="https://www.dropbox.com/s/g6wrtom681nr7tb/fabulous_ecosystem.png?raw=1" width="500"/>


## How to cite

The following paper can be used as citation for Fabulous:

Dirk Koch, Nguyen Dao, Bea Healy, Jing Yu, and Andrew Attwood. 2021. FABulous: An Embedded FPGA Framework. In <i>The 2021 ACM/SIGDA International Symposium on Field-Programmable Gate Arrays</i> (<i>FPGA '21</i>). Association for Computing Machinery, New York, NY, USA, 45–56. DOI:https://doi.org/10.1145/3431920.3439302

[link of paper]

[link of paper]:https://dl.acm.org/doi/pdf/10.1145/3431920.3439302

## Prerequisites
The following packages need to be installed for generating fabric HDLs
 - Python 3.5 or later

Install python dependancies
```
pip3 install -r requirements.txt
```

The following packages need to be installed for CAD toolchain
 - [Yosys 0.9](http://www.clifford.at/yosys/download.html)
   - copy the contents of the YosysFiles directory to `/usr/share/yosys` or `/usr/local/share/yosys`
 - nextpnr-fabulous
 

## Getting started

Fabric generator flow is run with bash script. (Examples are provided under ```/fabric_files```.)

In the first time before you run the flow, you must generate the basic files by following commands:
```
cd fabric_generator
./create_basic_files.sh
```
Then using the following command to build the entire FPGA fabric in both VHDL and Verilog:
```
./run_fab_flow.sh
```
You are now ready to emulate or synthesis with the netlists in ```/vhdl_output``` or ```/verilog_output```.

A simple example that runs to generate bitstream can be found in nextpnr-fabulous/fabulous/template.*. Usage example:
```
cd nextpnr-fabulous/fabulous/
./template.sh
python3 bit_gen.py -genBitstream template.fasm meta_data.txt template_output.bin
```

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
