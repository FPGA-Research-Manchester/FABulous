.. _yosys:

Yosys compilation
=================

Yosys is used for logic synthesis and technology mapping of the Verilog Hardware Description Language (HDL) into a JSON (for nextpnr) or BLIF (for VPR) netlist.

Building
--------

To build you may use the Makefile wrapper in the clone repository (https://github.com/YosysHQ/yosys.git) ``make`` and ``sudo make install``

User guide
----------

FABulous is supported by upstream Yosys, using the ``synth_fabulous`` pass. First, run ``yosys``, which will open up an interactive Yosys shell. If synthesizing for the nextpnr flow, run the following commands:

.. code-block:: console

        $ read_verilog <Verilog design file>
        $ synth_fabulous
        $ write_json <output JSON file>

If you are synthesizing for use in the VPR flow, then run the following commands:

.. code-block:: console

        $ read_verilog <Verilog design file>
        $ synth_fabulous -vpr
        $ write_blif <output BLIF file>

* For any clocked benchmark, a clock tile blackbox module must be instantiated in the top module for clock generation.

.. code-block:: verilog 

        wire clk;
        (* keep *) Global_Clock inst_clk (.CLK(clk));

