Yosys models
============

** Yosys models files, all can be found under ``$FAB_ROOT/nextpnr/fabulous/synth``

.. code-block:: console
   :emphasize-lines: 14,15

        set LUT_K 4
        if {$argc > 0} { set LUT_K [lindex $argv 0] }
        yosys read_verilog -lib [file dirname [file normalize $argv0]]/prims_ff.v
        yosys hierarchy -check -top [lindex $argv 1]
        yosys proc
        yosys flatten
        yosys tribuf -logic
        yosys deminout
        yosys synth -run coarse
        yosys memory_map
        yosys opt -full
        yosys techmap -map +/techmap.v
        yosys opt -fast
        yosys dfflegalize -cell \$_DFF_P_ 0 -cell \$_DFFE_PP_ 0 -cell \$_SDFF_PP?_ 0 -cell \$_SDFFCE_PP?P_ 0 -cell \$_DLATCH_?_ x
        yosys techmap -map [file dirname [file normalize $argv0]]/ff_map.v
        yosys opt_expr -mux_undef
        yosys simplemap
        yosys techmap -map [file dirname [file normalize $argv0]]/latches_map.v
        yosys abc -lut $LUT_K -dress
        yosys clean
        yosys techmap -D LUT_K=$LUT_K -map [file dirname [file normalize $argv0]]/cells_map_ff.v
        yosys clean
        yosys hierarchy -check
        yosys stat

        if {$argc > 1} { yosys write_json [lindex $argv 2] }

+---------------+-----------------------------------------------------------------------+
| File Name     | Description                                                           |
+===============+=======================================================================+
| prims_ff.v    | Fabric primitives definition                                          |
+---------------+-----------------------------------------------------------------------+
| ff_map.v      | Abitrary D-type Flip-flop with SET/RESET and ENABLE technology mapping|
+---------------+-----------------------------------------------------------------------+
| latches_map.v | Latches technology mapping                                            |
+---------------+-----------------------------------------------------------------------+
| cells_map_ff.v| LUT-4 technology mapping (can be modified to LUT-6)                   |
+---------------+-----------------------------------------------------------------------+

The ``synth_fabulous_dffesr.tcl`` is built for FABulous version3. Compared to the previous two versions, the new version supports **ENABLE** and **SET/RESET** functions in D-type Flip-flops (DFF) (Line 14 and 15 of TCL script). Under line 14, Yosys represents cells ``$_DFF_P_``, ``$_DFFE_PP_``, ``$_SDFF_PP?_`` and ``$_SDFFCE_PP?P_`` for DFFs (More DFF cells definitions can be found in the 
`Yosys manual <https://github.com/YosysHQ/yosys-manual-build/releases/download/manual/manual.pdf>`_
Chapter 5.2). User should also define different types of DFF in the ``ff_map.v`` for DFF technology mapping.

+----------------+-------------------------------------------------------+
| $_DFF_P_       | Positive Clock edge DFF                               |
+----------------+-------------------------------------------------------+
| $_DFFE_PP_     | Positive Clock edge, High active Enable               |
+----------------+-------------------------------------------------------+
| $_SDFF_PP?_    | Positive Clock edge, High active Set/Reset            |
+----------------+-------------------------------------------------------+
| $_SDFFCE_PP?P_ | Positive Clock edge, High active Enable and Set/Reset |
+----------------+-------------------------------------------------------+

We have made a comparison between synthesis with and without **ENABLE** and **SET/RESET** DFF on the ``Murax core`` benchmark, as shown below:

+-------------+-----+-----+-----+-----+----------+------+--------+---------+---------+----------+----------+-------------+
| Name        | LUT1| LUT2| LUT3| LUT4| LUT_total| LUTFF| LUTFF_E| LUTFF_SR| LUTFF_SS| LUTFF_ESR| LUTFF_ESS| RegFile_32x4|
+=============+=====+=====+=====+=====+==========+======+========+=========+=========+==========+==========+=============+
| Murax       | 4   | 335 | 1248| 1195| 2782     | 1361 |        |         |         |          |          | 12          |
+-------------+-----+-----+-----+-----+----------+------+--------+---------+---------+----------+----------+-------------+
| Murax_dffesr| 128 | 380 | 637 | 785 | 1930     | 233  | 841    | 86      | 7       | 174      | 20       | 12          |
+-------------+-----+-----+-----+-----+----------+------+--------+---------+---------+----------+----------+-------------+

.. code-block:: none

        Ps. 
        LUTFF    : DFF with no enable and no set/reset
        LUTFF_E  : synchronous enable
        LUTFF_SR : synchronous reset to 0
        LUTFF_SS : synchronous set to 1
        LUTFF_ESR: synchronous enable, synchronous reset to 0
        LUTFF_ESS: synchronous enable, synchronous set to 1

Around 30% LUT resources can be saved by *ENABLE* and *SET/RESET* functions added, so it is supported in version 3.

