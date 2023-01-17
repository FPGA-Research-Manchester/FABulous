.. _yosys:

Yosys compilation
=================

Yosys is used for logic synthesis and technology mapping of the Verilog Hardware Description Language (HDL) into a JSON (for nextpnr) or BLIF (for VPR) netlist.

Building
--------

To build you may use the Makefile wrapper in the clone repository (https://github.com/YosysHQ/yosys.git) ``make`` and ``sudo make install``

User guide
----------

FABulous is supported by upstream Yosys, using the ``synth_fabulous`` pass. First, run ``yosys``, which will open up an interactive Yosys shell. If synthesizing for the nextpnr flow, run this command: ``yosys -p "synth_fabulous -top <toplevel> -json <out.json>" <files.v>``. 

If you are synthesizing for use in the VPR flow, then run this command: ``yosys -p "synth_fabulous -top <toplevel> -blif <out.blif> -vpr" <files.v>``.

* For any clocked benchmark, a clock tile blackbox module must be instantiated in the top module for clock generation.

.. code-block:: verilog 

        wire clk;
        (* keep *) Global_Clock inst_clk (.CLK(clk));

