Quick start
===========
.. _setup:

Prerequisites
-------------

The following packages need to be installed for generating fabric HDLs

:Fabulous repository:

.. code-block:: console

    git clone --recurse-submodules https://github.com/FPGA-Research-Manchester/FABulous

:Python: 
 version > 3.5

:python dependencies:

.. code-block:: console

    pip3 install -r requirements.txt

The following packages need to be installed for CAD toolchain

:`Yosys <https://github.com/YosysHQ/yosys>`_:
 version > 0.10


.. note:: IN the following :term:`$FAB_ROOT` means the root directory of the Fabulous source code tree.

:nextpnr-fabulous:

.. code-block:: console

   cd $FAB_ROOT/nextpnr
   cmake . -DARCH=fabulous_v3
   make -j$(nproc)
   sudo make install

Building Fabric
---------------

.. code-block:: console

   cd $FAB_ROOT/fabric_generator
   ./create_basic_files_v3.sh
   ./run_fabv3_flow.sh

After the fabulous flow runing correctly, the RTL files can be found under ``$FAB_ROOT/fabric_generator/verilog_output`` or ``$FAB_ROOT/fabric_generator/vhdl_output``.


Generating Bitstream
--------------------

Nextpnr models can be found under ``$FAB_ROOT/fabric_generator/npnroutput``

To run nextpnr compilation
 
.. code-block:: console

   cd $FAB_ROOT/nextpnr/fabulous_v3/fab_arch/
   ./fabulous_flow.sh <benchmark_name>

Example:

.. code-block:: console

   ./fabulous_flow.sh sequential_16bit

The output <benchmark_name>_output.bin can be used in further simulation.

VPR models can be found under ``/vproutput``

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

