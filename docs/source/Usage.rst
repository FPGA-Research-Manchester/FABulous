Quick start
===========
.. _setup:

Prerequisites
-------------

The following packages need to be installed for generating fabric HDLs

:FABulous repository:

.. code-block:: console

    git clone --recurse-submodules https://github.com/FPGA-Research-Manchester/FABulous

:Python: 
 version > 3.5

:python dependencies:

.. code-block:: console

    pip3 install -r requirements.txt

The following packages need to be installed for the CAD toolchain

:`Yosys <https://github.com/YosysHQ/yosys>`_:
 version > 0.10


.. note:: In the following, :term:`$FAB_ROOT` means the root directory of the Fabulous source code tree.

:nextpnr-fabulous:

.. code-block:: console

   cd $FAB_ROOT/nextpnr
   cmake . -DARCH=fabulous
   make -j$(nproc)
   sudo make install

Building Fabric
---------------


.. code-block:: console

   cd $FAB_ROOT/fabric_generator
   #<csv file> -- the user-defined csv file to generate the fabric. Ex. ./create_basic_files.sh ../fabric_files/generic/fabric.csv
   ./create_basic_files.sh <csv file> 
   #Both <number of columns> and <number of rows> are not including the terminal blocks. Ex. ./run_fab_flow.sh 8 14
   ./run_fab_flow.sh <number of columns> <number of rows>

After the fabulous flow has run successfully, the RTL files can be found under ``$FAB_ROOT/fabric_generator/verilog_output`` or ``$FAB_ROOT/fabric_generator/vhdl_output``.


Generating Bitstream
--------------------

Nextpnr models can be found under ``$FAB_ROOT/fabric_generator/npnroutput``

To run nextpnr compilation
 
.. code-block:: console

   cd $FAB_ROOT/nextpnr/fabulous/fab_arch/
   ./fabulous_flow.sh <benchmark_name>

Example:

.. code-block:: console

   ./fabulous_flow.sh sequential_16bit_en

The output <benchmark_name>_output.bin can be used in further simulation.

VPR models can be found under ``$FAB_ROOT/fabric_generator/vproutput``

Build options
-------------

Users can choose the script to run to generate different models under ``$FAB_ROOT/fabric_generator``.

+------------------------------+------------------------------------------------------------------------------------------------+
| run_fab_flow.sh              | Run FABulous flow and generate both Nexpnr and VPR model files (**default**)                   |
+------------------------------+------------------------------------------------------------------------------------------------+
| run_fab_flow_nextpnr.sh      | Run FABulous flow and generate Nexpnr model files                                              |
+------------------------------+------------------------------------------------------------------------------------------------+
| run_fab_flow_nextpnr_pair.sh | Run FABulous flow , generate Nexpnr model files and ``wirePairs.csv`` for timing model purposes|
+------------------------------+------------------------------------------------------------------------------------------------+
| run_fab_flow_vpr.sh          | Run FABulous flow and generate VPR model files                                                 |
+------------------------------+------------------------------------------------------------------------------------------------+

Running in a Docker container
-----------------------------

Within the FABulous repo we provide a Dockerfile that allows users to run the FABulous flow within a Docker container, installing all requirements automatically.

:Setting up the Docker environment:

To set up the Docker environment, navigate to the FABulous root directory and run:

.. code-block:: console

     docker build -t fabulous .

:Running the Docker environment:

To run the Docker environment, stay in the FABulous root directory (this is vital as the command mounts the current directory as the container's filesystem) and run:

.. code-block:: console

     docker run -it -v $PWD:/workspace fabulous

This will bring up an interactive bash environment within the Docker container, within which you can use FABulous as if hosted natively on your machine. When you are finished using FABulous, simply type ``exit``, and all changes made will have been made to your copy of the FABulous repository.

