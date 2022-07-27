# FABulous: an Embedded FPGA Framework

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Introduction

FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates 
[SymbiFlow](https://symbiflow.github.io/) 
toolchain release packages, deals with the bitstream generation and provides after-fabrication tests. Additionally, we plan to provide an emulation path for system development.

This guide describes everything you need to set up your system to use the FABulous ecosystem.

Ways to run Symbiflow on these devices will be explained in the near future.

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

The following packages need to be installed for CAD toolchain

- [Yosys](https://github.com/YosysHQ/yosys)
- FABulous' nextpnr fork (covered in instructions below)

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

We have provided a Python Command Line Interface (CLI) as well as a project structure for easy access of the FABulous toolchain.

To create a FABulous project you can run `python3 FABulous.py -c <name_of_project>`
This command will create a FABulous project that contains all the file for generating a basic FABulous fabric.
The `src` folder contains all the definitions of the fabric primitive as well as the fabric matrix configuration. `src/fabric.csv` is what defining the architecture of the fabric. The FABulous project folder also contains a `.FABulous` folder which contains all the metadata during the generation of the fabric

To generate a fabric with the FABulous project you can run `python3 FABulous.py -rf <name_of_project>`

And to generate a bitstream with the design `user_design/<name_of_project>.v` run `python3 FABulous.py -r <name_of_project>`.
The bitstream will be output as `<name_of_project>.bin` inside the project folder.

For further details of what the CLI can do run `python3 FABulous.py -h` to see further details.

Command to run from project creation, fabric generation, and binary generation

```
python3 FABulous.py demo -c
python3 FABulous.py demo -rf
python3 FABulous.py demo -r
```

The fabric generator flow can also be run using bash scripts based on the examples provided under `/fabric_files`.

Before you run the flow for the first time, you must generate the basic files using the following commands:

```
cd fabric_generator
./create_basic_files.sh ../fabric_files/generic/fabric.csv
```

Then use the following command to build the entire FPGA fabric in both VHDL and Verilog:

```
./run_fab_flow.sh
```

A simple example that runs to generate a bitstream can be found under ```nextpnr/fabulous/fab_arch/```

Usage example:

```
cd ../nextpnr/fabulous/fab_arch/
./fabulous_flow.sh sequential_16bit_en
python3 bit_gen.py -genBitstream sequential_16bit_en.fasm meta_data.txt sequential_16bit_en_output.bin
```

More details on bitstream generation can be found [here](https://github.com/FPGA-Research-Manchester/FABulous/tree/master/fabric_generator/bitstream_npnr).
