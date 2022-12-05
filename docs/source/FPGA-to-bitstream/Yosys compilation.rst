.. _yosys:

Yosys compilation
=================

Yosys is used for logic synthesis and technology mapping of the Verilog Hardware Description Language (HDL) into a JSON (for nextpnr) or BLIF (for VPR) netlist.

Building
--------

To build you may use the Makefile wrapper in the cloned repository (https://github.com/YosysHQ/yosys.git) ``make`` and ``sudo make install``

User guide
----------
We have provided two methods for synthesis. The first is done using the CLI and the second is done directly by calling 
Yosys to do synthesis. The first method is provided for easy access and the second is provided for advanced users. 

CLI Synthesis
^^^^^^^^^^^^^
Assuming you have started the FABulous shell and working with a default structured project, we can run synthesis by 
calling the following command:

.. code-block:: console

        # Nextpnr backend synthesis (JSON)
        synthesis_npnr <path_to_user_design>
        
        # VPR backend synthesis (BLIF)
        synthesis_vpr <path_to_user_design>


The result of the synthesis will be located in the directory that contains the design file. For example, if the design 
file is located at ``user_design/sequential_16bit_en.v`` then the result of the synthesis will be located at 
``user/design``. For the above example, the file generated will call ``sequential_16bit_en.json`` or 
``sequential_16bit_en.blif`` depends on which command is being used. 

.. note::
        The underlying of the command is a python subprocess call to the Yosys command line with the exact command 
        example used in manual synthesis, and as a result, any modifications to the pre-defined Yosys script will be 
        applied as well. Most of the time the CLI synthesis should be sufficient for most users. If some extra toggles 
        need to be used for Yosys then the CLI synthesis is not sufficient for now. (We might add flag pass-through from the CLI in later iterations). 


Manual Synthesis
^^^^^^^^^^^^^^^^
A pre-defined Yosys TCL script is under ``$FAB_ROOT/nextpnr/fabulous/synth/synth_fabulous.tcl`` for FABulous version3. If the output file, denoted below as ``<JSON_or_BLIF_file>``, has a ``.blif`` file extension, then the output will be produced in the Berkeley Logic Interchange Format (BLIF) and will be synthesised appropriately for the VPR flow. Otherwise, the output will be produced as JSON, synthesised for the nextpnr flow.

.. code-block:: console

	yosys -qp "tcl <path/to/TCL/File>/synth_fabulous.tcl <K-LUT> <top_module> <JSON_or_BLIF_file>" <benchmark_netlist>

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

	yosys -qp "tcl ../synth/synth_fabulous.tcl 4 sequential_16bit_en sequential_16bit_en.json" sequential_16bit_en.v




