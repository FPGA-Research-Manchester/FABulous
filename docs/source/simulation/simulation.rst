.. SPDX-FileCopyrightText: 2023 Bea Healey <https://github.com/TaoBi22>
..
.. SPDX-License-Identifier: Apache-2.0

Simulation setup
================

A simulation example can be found under ``$FAB_ROOT/fabric_files/fabric_icarus_example/``. This has been tested using the open source Icarus Verillog simulator.

To setup the simulation enviroment, an eFPGA top module to instantiate the fabric and the `configuration module`_ are required, as in the example ``eFPGA_v2_top_sky130_sim.v``

.. code-block:: verilog
        
        module eFPGA_top (I_top, T_top, O_top, A_config_C, B_config_C, CLK, SelfWriteStrobe, SelfWriteData, Rx, ComActive, ReceiveLED, s_clk, s_data);
        ...
        Config Config_inst (...);
        //All Frame data register modules
        ...
        //All Frame select modules
        ...
        eFPGA Inst_eFPGA(
        .Tile_X0Y1_A_I_top(I_top[23]),
        .Tile_X0Y1_B_I_top(I_top[22]),
        .Tile_X0Y2_A_I_top(I_top[21]),
        .Tile_X0Y2_B_I_top(I_top[20]),
        .Tile_X0Y3_A_I_top(I_top[19]),
        .Tile_X0Y3_B_I_top(I_top[18]),
        .Tile_X0Y4_A_I_top(I_top[17]),
        .Tile_X0Y4_B_I_top(I_top[16]),
        .Tile_X0Y5_A_I_top(I_top[15]),
        .Tile_X0Y5_B_I_top(I_top[14]),
        .Tile_X0Y6_A_I_top(I_top[13]),
        .Tile_X0Y6_B_I_top(I_top[12]),
        .Tile_X0Y7_A_I_top(I_top[11]),
        .Tile_X0Y7_B_I_top(I_top[10]),
        .Tile_X0Y8_A_I_top(I_top[9]),
        .Tile_X0Y8_B_I_top(I_top[8]),
        .Tile_X0Y9_A_I_top(I_top[7]),
        .Tile_X0Y9_B_I_top(I_top[6]),
        .Tile_X0Y10_A_I_top(I_top[5]),
        .Tile_X0Y10_B_I_top(I_top[4]),
        .Tile_X0Y11_A_I_top(I_top[3]),
        .Tile_X0Y11_B_I_top(I_top[2]),
        .Tile_X0Y12_A_I_top(I_top[1]),
        .Tile_X0Y12_B_I_top(I_top[0]),
        ...
        );
        endmodule

Next, you can assign the input signals to ``O_top`` and the output signals to ``I_top`` under the ``fabulous_tb.v`` testbench. IO mappings are fixed for the top-level user design in the ``test_design/io_wrapper.v``. You will need to modify the number and position of bel mappings in this file if you have changed the height of the fabric from the default of 14 (2 IOs per tile give 28 IO total).

FABulous comes with 3 different simulation methods _`configuration module`,

#. Serial (Mode 0)

   Send configuration in through UART 

#. Parallel (Mode 1) - default in the testbench
   
   Use parallel configuration port

#. Bitbang configuration port (To be supported in the testbench)

   We have produced a quick asynchronous serial configuration port interface that is ideal for microcontroller configuration. It uses the original CPU interface that we have in our TSMC chip. The idea of the protocol is as follows:

   .. figure:: ../figs/bitbang1.*
       :alt: Bitbang description
       :align: center


   We drive s_clk and s_data. On each rising edge of s_clock, we sample data and on the falling edge, we sample control.

   Both values get shifted in a separate register. If the control register sees the bit-pattern x”FAB0” it samples the data shift register into a hold register and issues a one-cycle strobe output (active 1).

   The next figure shows the enable generation (and input sampling) for generating the enable signals for 

   * the control shift register and 
   * the data shift register.

   .. figure:: ../figs/bitbang2.*
       :alt: Bitbang schematic
       :align: center



