This assumes the default instructions were followed to build a 8x14 fabric in `../fabric_generator`.

Latest Yosys and `nextpnr-generic` from upstream (_not_ the old FABulous nextpnr fork) are used
to build the test design.

Run `build_test_design.sh` to create the bitstream and `run_simulation.sh` to compare a simulation
of the fabric in bitstream emulation mode (where the configuration logic is bypassed and muxes are
hardwired with Verilog parameters).


Run `run_icebreaker.sh` to run the fabric in emulation mode on ice40-based icebreaker hardware (due
to the size of intermediate fabric representations in Yosys about 12GB of free RAM is needed).
