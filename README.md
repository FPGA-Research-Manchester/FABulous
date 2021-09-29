# FABulous: an Embedded FPGA Framework
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Introdution
FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates 
[SymbiFlow](https://symbiflow.github.io/) 
toolchain release packages, deals with the bitstream generation and after fabrication tests. Additionally, we will provide an emulation path for system development.

This guide describes everything you need to set up your system to develop for FABulous ecosystem.

Ways to run Symbiflow on these devices will be explained in the near future.

<img src="https://www.dropbox.com/s/g6wrtom681nr7tb/fabulous_ecosystem.png?raw=1" width="600"/>


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
 - [Yosys 0.9](https://github.com/YosysHQ/yosys)
 - nextpnr-fabulous

## Getting started
```
git clone https://github.com/FPGA-Research-Manchester/FABulous
cd FABulous
git clone -branch fabulous https://github.com/FPGA-Research-Manchester/nextpnr
cd nextpnr
cmake . -DARCH=fabulous
make -j$(nproc)
sudo make install
```

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

A simple example that runs to generate bitstream can be found in nextpnr-fabulous/fabulous/template.*

Usage example:

```
cp fabric_generator/npnroutput/{bel.txt,pips.txt,template.pcf,template.v,meta_data.txt} nextpnr/fabulous/fab_arch/
cp fabric_generator/csv_output/fabric.csv nextpnr/fabulous/fab_arch/
cd nextpnr/fabulous/
./fabulous_flow.sh sequential_16bit.v
python3 bit_gen.py -genBitstream sequential_16bit.fasm meta_data_v2.txt sequential_16bit_output.bin
```
More details on instruction of bitstream generation can check [here](https://github.com/FPGA-Research-Manchester/FABulous/tree/master/fabric_generator/bitstream_npnr)
