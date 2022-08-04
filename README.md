# FABulous: an Embedded FPGA Framework
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Introduction
FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates 
[SymbiFlow](https://symbiflow.github.io/) 
toolchain release packages, deals with the bitstream generation and provides after-fabrication tests. Additionally, we plan to provide an emulation path for system development.

This guide describes everything you need to set up your system to use the FABulous ecosystem, and the full project documentation can be found [here](https://fabulous.readthedocs.io/en/latest/).

![FABulous Ecosystem Diagram](docs/source/figs/fabulous_ecosystem.png)

## How to cite

The following paper can be used to cite FABulous:

Dirk Koch, Nguyen Dao, Bea Healy, Jing Yu, and Andrew Attwood. 2021. FABulous: An Embedded FPGA Framework. In <i>The 2021 ACM/SIGDA International Symposium on Field-Programmable Gate Arrays</i> (<i>FPGA '21</i>). Association for Computing Machinery, New York, NY, USA, 45–56. DOI: https://doi.org/10.1145/3431920.3439302

[Link to Paper](https://dl.acm.org/doi/pdf/10.1145/3431920.3439302)

## Prerequisites
The following packages need to be installed for generating fabric HDL models:
 - Python 3.6 or later

Install python dependencies
```
pip3 install -r requirements.txt
```

The following packages need to be installed for the CAD toolchain
 - [Yosys](https://github.com/YosysHQ/yosys)
 - FABulous' nextpnr fork (covered in instructions below)
 
 A flow using VPR, the place and route tool from the [VTR project](https://github.com/verilog-to-routing/vtr-verilog-to-routing) is also available. However, this still requires Yosys, as well as the FABulous nextpnr fork, since this contains files for design synthesis.

## Getting started
```
git clone https://github.com/FPGA-Research-Manchester/FABulous
cd FABulous
git clone --branch fabulous https://github.com/FPGA-Research-Manchester/nextpnr
cd nextpnr
cmake . -DARCH=fabulous
make -j$(nproc)
sudo make install
```

The fabric generator flow can be run using bash scripts based on the examples provided under ```/fabric_files```.

Before you run the flow for the first time, you must generate the basic files using the following commands:
```
cd fabric_generator
./create_basic_files.sh ../fabric_files/generic/fabric.csv
```
Then use the following command to build the entire FPGA fabric in both VHDL and Verilog (the example has 8 columns and 14 rows):
```
./run_fab_flow.sh 8 14
```
You are now ready to emulate or synthesise with the netlists in ```/vhdl_output``` or ```/verilog_output```.

A simple example that runs to generate a bitstream can be found under ```nextpnr/fabulous/fab_arch/```

Usage example:

```
cd ../nextpnr/fabulous/fab_arch/
./fabulous_flow.sh sequential_16bit_en
python3 bit_gen.py -genBitstream sequential_16bit_en.fasm meta_data.txt sequential_16bit_en_output.bin
```
More details on bitstream generation can be found [here](https://github.com/FPGA-Research-Manchester/FABulous/tree/master/fabric_generator/bitstream_npnr).
