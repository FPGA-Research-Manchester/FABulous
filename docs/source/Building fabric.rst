Building fabric
===============

The user can run the flow step by step as well (see below for instructions on building HDLs):

.. figure:: figs/FABulous_flow2.*
        :width: 80%
        :align: center

#. Generate the switch matrix as an empty CSV file containing the adjacency matrix

   .. code-block:: console

        python3 fabric_gen.py -GenTileSwitchMatrixCSV

#. Populate the switch matrix (adjacency matrix) entries.

   We do this for each tile individually in order to have some control what gets updated

   .. code-block:: console

        python3 fabric_gen.py -AddList2CSV LUT4AB_switch_matrix.list LUT4AB_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV N_term_single_switch_matrix.list N_term_single_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV S_term_single_switch_matrix.list S_term_single_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV N_term_RAM_IO_switch_matrix.list N_term_RAM_IO_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV S_term_RAM_IO_switch_matrix.list S_term_RAM_IO_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV N_term_single2_switch_matrix.list N_term_single2_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV S_term_single2_switch_matrix.list S_term_single2_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV N_term_DSP_switch_matrix.list N_term_DSP_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV S_term_DSP_switch_matrix.list S_term_DSP_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV RAM_IO_switch_matrix.list RAM_IO_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV W_IO_switch_matrix.list W_IO_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV RegFile_switch_matrix.list RegFile_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV DSP_top_switch_matrix.list DSP_top_switch_matrix.csv
        python3 fabric_gen.py -AddList2CSV DSP_bot_switch_matrix.list DSP_bot_switch_matrix.csv


#. Generate the tile switch matrices (RTL).
      
   .. code-block:: console

        python3 fabric_gen.py -GenTileSwitchMatrixVHDL
        python3 fabric_gen.py -GenTileSwitchMatrixVerilog

#. Generate the configuration storage (RTL).

   .. code-block:: console

        python3 fabric_gen.py -GenTileConfigMemVHDL
        python3 fabric_gen.py -GenTileConfigMemVerilog


#. Generate the actual tiles (RTL).

   .. code-block:: console

        python3 fabric_gen.py -GenTileHDL
        python3 fabric_gen.py -GenTileVerilog

#. Generate the entire fabric (RTL).

   .. code-block:: console

        python3 fabric_gen.py -GenFabricHDL
        python3 fabric_gen.py -GenFabricVerilog

#. Generate Verilog top wrapper. (Both number of columns and rows are not including terminal blocks.)

   .. code-block:: console

        python3 fabulous_top_wrapper_temp/top_wrapper_generator_with_BRAM.py -c <number of columns> -r <number of rows>

#. Generate the nextpnr model files under ``npnroutput/``.

   .. code-block:: console

        python3 fabric_gen.py -GenNextpnrModel

#. Generate the VPR model files under ``vproutput/``.

   .. code-block:: console

        python3 fabric_gen.py -GenVPRModel

#. Generate the meta data list for FASM --> Bitstream

   .. code-block:: console

        python3 fabric_gen.py -GenBitstreamSpec npnroutput/meta_data.txt
