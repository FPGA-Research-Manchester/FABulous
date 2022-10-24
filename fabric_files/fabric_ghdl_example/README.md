This assumes the default instructions were followed to build a 8x14 fabric in `../fabric_generator`.

Latest Yosys and `nextpnr-generic` from upstream (_not_ the old FABulous nextpnr fork) are used
to build the test design.

Run `build_test_design.sh` to create the bitstream and `run_simulation_vhdl.sh` to compare a simulation
of the fabric running the bitstream against the design.

You will need both the VHDL and Verilog version of test design. Verilog for the bitstream and VHDL for the testbench. You can do the conversion with Icarus Verilog using the `iverilog -t vhdl -g2012 -o <design>.vhdl <design>.v`. However please be noted that the conversion is not perfect. Certain features in Verilog is not supported by the conversion.