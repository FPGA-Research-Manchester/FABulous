# Build An FPGA

To program fabric generator FPGAs using these tools, you will need:

Yosys v0.8 and prerequisites.

SymbiFlow's fasm python library.


## Setup
Copy the contents of the YosysFiles directory to yosys/share/ (where yosys is the directory that yosys has been cloned into) and remake (`sudo make install` in the yosys directory)

Move into the nextpnr-diko directory (if preferred, this directory can be moved or copied out of your repository directory) and run:
`cmake -DARCH=diko`
`sudo make install`

Run `python3 gen.py --genNextpnrModel` in the fabric directory to create the bel and pip files that will be written in the fabric/npnroutput directory. Copy these to the nextpnr/diko directory created above.

You are now ready to synthesize, place and route a circuit onto your architecture. For an example of the commands tobe used, have a look at nextpnrfiles/simple.sh, and simple.ys (which is the chain of yosys commands run by simple.sh). Edit the file names in simple.ys accordingly when copying to synthesize programs with different names, and make sure that the .json filenames in simple.sh and simple.ys are the same.

*Add bitstream information here later*

To generate a bitstream, you must also generate a bitstream spec file. This contains mapping data for the bel configuration bits, mask data and architecture metadata, and is what the program uses to generate a bitstream. You must pass this file in along with your FASM file when generating a bitstream.

## Enabling/Disabling features
To disable generic mapping of multiplier blocks to DSP blocks, comment out the `-map/diko/dsp_map.v` tag after the techmap command in your .ys file.

To disable mapping of carry chains, comment out the `-map/diko/arith_map.v` tag after the techmap command in your .ys file.

## I'm adding some new tiles! What do I need to do?

1. Add techmap files to yosys - for an example, have a look at the files in yosys/share in your yosys directory. If you're having issues, the yosys reddit is a good place to seek out help already given on your issues.

2. Add the bel information to pack.cc, cells.cc and arch.cc in the nextpnrfiles directory - pack.cc will need an implementation of a packing function for any new bels, and this function must be added to the Arch::pack() function in the same file. arch.cc has a getPortTimingClass method that you will need to add a case for for your bel so that nextpnr can perform timing analysis on your new bel, and otherwise should only need to be edited if you have multiple bels on one tile or a prefix before the bel port names - you will have to edit the getBelPinWire method so that the port names can be mapped to the ports on specific bels. This will likely also require some modifications to the ChipInfo definition at the start of the file - changing the z value of a bel is the easiest way to distinguish it from other bels on the tile so you can access the distinct port names (Look at what I've done for LUT4 bels for an example). cells.cc will require modification of the create\_diko\_cell function so that it has a case for creating your new bel and adds the necessary ports.

3. If you have some cumbersome bel VHDL file names and you would like to change them or shorten them when creating your bel file, add a case to the genNextpnrModel function in in gen.py - this is found towards the end, where you can see assignment of the cType variable - simply catch this case and assign cType to your new, shorter name. Make sure this doesn't share a name with an existing bel!

4. If you have a lot of bels on your tile, you may need to have a look at the letters variable in gen.py - this is used to name the bels, but is only populated up to a certain point, so you may have to extend it.

5. For bitstream generation you will need to add to the BelMap dict found in the genBitStream function. You should add the names of your new bels as keys to the dict, and as values you should add another dictionary that maps the feature name (as will be represented in the FASM output) to the index of the configuration bit that enables it. This index should be relevant only to the config bits of the bel itself, as given in the bel VHDL - sequencing of bel configurations and application of masks is performed at a later stage.


## Constraints for the placement of IO/bels

Constraints for your architecture can be put in place using a .pcf file - there will be an example in simple.pcf in the nextpnrfiles directory. To constrain IO, use the `set_io cell bel` command, where cell is the name of the io cell you wish to constrain in your verilog code and bel is the bel name of the bel you wish to constrain this IO element to. Using this tool the bel name takes the format X0Y0.name - i.e. the coordinates of the bel and the name it is assigned in the bel.txt file - this will normally just be a capital letter indexing the bel alphabetically based on the order they were added to your .csv fabric file: the first bel on tile X1Y2 would be called X1Y2.A, the second X1Y2.B and so on. It is important to note that the cell type that IO can be mapped to corresponds directly to the nature of the pin type i.e. inout pins are packed to W\_IO tiles, as the bels on these tiles are IO buffers, and input and output pins are packed to CPU\_IO tiles, as these tiles have separate input and output buffers. Constraints will **not** override this, as yosys is responsible for mapping the verilog constructs to cell types, and nextpnr (which accepts the .pcf file format) has no part in this process. 

To constrain a cell to a specific bel, use the COMP command, followed by the cell name and then `LOCATE = (site name)`. Note that this will only work if the cell is being packed to that type of bel anyway.

For information about general I/O constraints in nextpnr, nextpnr/docs/constraints.md may be useful.

## Primitive instantiation
As described in more detail in the yosys documentation, the (\*keep\*) attribute can be used to instantiate a component and clarify that yosys should not try to optimise it away. This is done in the format `(* keep *) COMPONENT_TYPE COMPONENT_NAME(.PORT_NAME1(WIRE_NAME1), .PORT_NAME2(WIRE_NAME2), ...);`

## I want to maintain, edit or adjust this tool! How does it work?

The following describes only the flow of this project's CAD tools, and not the fabric generation itself.

1. The `genFabricObject` function takes in the main input CSV file containing a tile layout, descriptions of the wires' tiles and bels and the locations of switch matrix files. It converts this into one unified `Fabric` object, which carries the information the tool will need for model generation (including a 2D list of `Tile` objects). 

2. The `genNextpnrModel` function creates the files needed for the nextpnr parser to place and route onto your specific architecture. This consists of two files, pips.txt and bel.txt. pips.txt contains all switch matrix pips as well as all wires between tiles - these are separated by comments that distinguish between tile-internal pips (switch matrix multiplexer interconnects) and tile-external pips (inter-tile wires). 

3. If bitstream generation is necessary, the `genBitstreamSpec` function creates the bitstream specification file. This file is created using python's pickle library, and contains a dictionary containing a dict mapping tiles to their types, a dict containing the bitstream layout for the different tiles, a dict containing the frame mask for each tile and some other information about the architecture. This data is explained in more detail in step 6.

4. Mapping from verilog to cells is performed by yosys. More detail about the yosys process can be found by exploring the files referenced in the template simple.ys file provided, but to briefly summarise, cells\_sim.v describes the available cells, cells\_map.v describes handles mapping of luts, arith\_map.v handles carry chain mapping (*not yet working*), and dsp\_map.v handles mapping of multiplier cells to DSP blocks. These files can be commented out according to what is desired/required for the project at hand. The yosys stage outputs a .json file containing a techmapped netlist.

5. Placing and routing onto the architecture is handled by nextpnr. Nextpnr takes in the bel.txt and pip.txt files created earlier, and uses these to generate an abstract model of the architecture, which it then uses for placement and routing. Primitive instantiation and constraints are also handled during this stage. At the end of this stage, nextpnr outputs a .fasm file, of which each line represents a feature to enable or a value to set.

6. Finally, the genBitstream function creates bitstream output. This uses the bitstream spec we generated in step 3. Before generation, the fasm input is processed - this involves use of the fasm library, mainly to break up the LUT init values into individual features, which limits how complicated the generation stage must be.  The bitstream generation process is relatively simple thanks to the nature of the spec, and takes place on a feature by feature basis. For each feature, the TileMap dict in the spec is used to determine what kind of tile the relevant tile is. This allows access to the correct dict in TileSpecs, which maps feature names to a dict of bit addresses and their corresponding values. This means that to perform the necessary bitstream changes for a given feature, we can simply use the feature name to access a series of bits that need changing and their required value, and we can iterate through this to perform the necessary changes. This process is performed for each feature, and outputs a list that corresponds to the bitstream, however has not yet been adjusted for the frame masks. The frame mask is applied next in what is again a relatively simple process - the code effectively iterates through the characters of the mask, and where a character is 1 the next bit of the list is concatenated to the current output - if a character is 0 we know we do not care about this bit and so we simply put in a 0. 
 
