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

The user can run the flow step by step as well:
