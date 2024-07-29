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
        The underlying of the command is a python subprocess call to the Yosys command line with the exact command example used in manual synthesis If some extra toggles need to be used for Yosys then the CLI synthesis is not sufficient for now. (We might add flag pass-through from the CLI in later iterations). 


Manual Synthesis
^^^^^^^^^^^^^^^^
FABulous is supported by upstream Yosys, using the ``synth_fabulous`` pass. First, run ``yosys``, which will open up an interactive Yosys shell.  

For Verilog projects:
 If synthesizing for the nextpnr flow, run this command: ``yosys -p "synth_fabulous -top <toplevel> -json <out.json>" <files.v>``.

 If you are synthesizing for the VPR flow, then run this command: ``yosys -p "synth_fabulous -top <toplevel> -blif <out.blif> -vpr" <files.v>``.

For  VHDL projects:
 If synthesizing for the nextpnr flow, run this command: ``yosys -m ghdl -p ghdl <files.vhdl> -e <top-entity>;read_verilog <top_wrapper(verilog constraint)>;synth_fabulous -top <top_wrapper> -json <out.json>``.
 
 `Note:` For VHDL projects we used the top_wrapper as verilog because ghdl doesn't interpret the attributes(`*BEL*`);

* For any clocked benchmark, a clock tile blackbox module must be instantiated in the top module for clock generation.

.. code-block:: verilog 

        wire clk;
        (* keep *) Global_Clock inst_clk (.CLK(clk));

