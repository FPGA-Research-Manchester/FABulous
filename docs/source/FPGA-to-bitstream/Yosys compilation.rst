.. _yosys:

Yosys compilation
=================

Yosys is used for logic synthesis and technology mapping of the Verilog Hardware Description Language (HDL) into a JSON (for nextpnr) or BLIF (for VPR) netlist.

Building
--------

To build you may use the Makefile wrapper in the clone repository (https://github.com/YosysHQ/yosys.git) ``make`` and ``sudo make install``

User guide
----------

A pre-defined Yosys TCL script is under ``$FAB_ROOT/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl`` for FABulous version3. If the output file, denoted below as ``<JSON_or_BLIF_file>``, has a ``.blif`` file extension, then output will be produced in the Berkeley Logic Interchange Format (BLIF) and will be synthesised appropriately for the VPR flow. Otherwise, output will be produced as JSON, synthesised for the nextpnr flow.

.. code-block:: console

	yosys -p "tcl <path/to/TCL/File>/synth_fabulous_dffesr.tcl <K-LUT> <top_module> <JSON_or_BLIF_file>" <benchmark_netlist>

+---------------------+-------------------------------------------------------------------+
| <K-LUT>             | Number of LUT inputs, 4 is for LUT4                               |
+---------------------+-------------------------------------------------------------------+
| <top_module>        | The name of top module in the benchmark                           |
+---------------------+-------------------------------------------------------------------+
| <JSON_file>         | User can define the name of output JSON file with ``.json`` format|
+---------------------+-------------------------------------------------------------------+
| <benchmark_netlist> | Benchmark RTL netlist in verilog format                           |
+---------------------+-------------------------------------------------------------------+

* For any clocked benchmark, a clock tile blackbox module must be instantiated in the top module for clock generation.

.. code-block:: verilog 

        wire clk;
        (* keep *) Global_Clock inst_clk (.CLK(clk));

Example
-------

The following are simple commands to synthesise the netlist ``sequential_16bit_en`` into JSON netlist.

.. code-block:: console

	yosys -p "tcl ../synth/synth_fabulous_dffesr.tcl 4 sequential_16bit_en sequential_16bit_en.json" sequential_16bit_en.v




