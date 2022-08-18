from fabric_generator.utilities import *
import xml.etree.ElementTree as ET


# Generates constraint XML for VPR flow
def genVPRModelConstraints(archObject: FabricModelGen):
    constraintString = '<vpr_constraints tool_name="vpr">\n'
    constraintString += '  <partition_list>\n'

    unnamedCount = 0
    for row in archObject.tiles:
        for tile in row:
            for num, belpair in enumerate(tile.bels):
                bel = belpair[0]
                let = letters[num]
                prefix = belpair[1]
                tileLoc = tile.genTileLoc()
                cx = tile.x + 1
                cy = tile.y + 1

                if bel == "IO_1_bidirectional_frame_config_pass":
                    # VPR names primitives after the first wire they drive
                    # So we use the wire names assigned in genVerilogTemplate
                    constraintString += f'    <partition name="Tile_{tileLoc}_{let}">\n'
                    constraintString += f'      <add_atom name_pattern="Tile_{tileLoc}_{prefix}O"/>\n'
                    constraintString += f'      <add_region x_low="{cx}" y_low="{cy}" x_high="{cx}" y_high="{cy}" subtile="{num}"/>\n'
                    constraintString += f'    </partition>\n'

                if bel == "InPass4_frame_config":
                    constraintString += f'    <partition name="Tile_{tileLoc}_{let}">\n'
                    constraintString += f'      <add_atom name_pattern="Tile_{tileLoc}_{prefix}O0"/>\n'
                    constraintString += f'      <add_region x_low="{cx}" y_low="{cy}" x_high="{cx}" y_high="{cy}" subtile="{num}"/>\n'
                    constraintString += f'    </partition>\n'

                # Frustratingly, since VPR names blocks after BELs they drive, BELs that drive no wires have auto-generated names
                # These names are, at time of writing, generated with unique_subckt_name() in vpr/src/base/read_blif.cpp
                if bel == "OutPass4_frame_config":
                    constraintString += f'    <partition name="Tile_{tileLoc}_{let}">\n'
                    # constraintString += f'      <add_atom name_pattern="Tile_{tileLoc}_{prefix}I0"/>\n'
                    constraintString += f'      <add_atom name_pattern="unnamed_subckt{unnamedCount}"/>\n'
                    unnamedCount += 1
                    constraintString += f'      <add_region x_low="{cx}" y_low="{cy}" x_high="{cx}" y_high="{cy}" subtile="{num}"/>\n'
                    constraintString += f'    </partition>\n'

    constraintString += '    </partition_list>\n'
    constraintString += '</vpr_constraints>'
    return constraintString


# Clock coordinates - these are relative to the fabric.csv fabric, and ignore the padding
clockX = 0
clockY = 0


def genVPRModelXML(archObject: FabricModelGen, customXmlFilename, generatePairs=True):

    # STYLE NOTE: As this function uses f-strings so regularly, as a standard these f-strings should be denoted with single quotes ('...') instead of double quotes ("...")
    # This is because the XML being generated uses double quotes to denote values, so every attribute set introduces a pair of quotes to escape
    # This is doable but frustrating and leaves room for error, so as standard single quotes are recommended.

    # A variable name of the form fooString means that it is a string which will be substituted directly into the output string - otherwise fooStr is used

    specialBelDict = {}
    specialModelDict = {}
    specialInterconnectDict = {}

    # First, load in the custom XML file
    tree = ET.parse(customXmlFilename)

    # Get root XML tag
    root = tree.getroot()

    # Iterate over children
    for bel_info in root:
        # Check that the tag is valid
        if bel_info.tag != "bel_info":
            raise ValueError(
                f"Error: Unknown tag in custom XML file: {bel_info.tag}")

        bel_name = bel_info.attrib['name']

        # Check only one of each tag is present

        if len(bel_info.findall('bel_pb')) > 1:
            raise ValueError(
                "Error: Found multiple bel_pb tags within one bel_info tag in custom XML file. Please provide only one.")

        if len(bel_info.findall('bel_model')) > 1:
            raise ValueError(
                "Error: Found multiple bel_model tags within one bel_info tag in custom XML file. Please provide at most one.")

        if len(bel_info.findall('bel_interconnect')) > 1:
            raise ValueError(
                "Error: Found multiple bel_interconnect tags within one bel_info tag in custom XML file. Please provide at most one.")

        # Fetch data and store in appropriate dicts
        if bel_info.find('bel_pb'):
            for bel_pb in bel_info.find('bel_pb'):
                specialBelDict[bel_name] = ET.tostring(
                    bel_pb, encoding='unicode')
        if bel_info.find('bel_model'):
            for bel_model in bel_info.find('bel_model'):
                specialModelDict[bel_name] = ET.tostring(
                    bel_model, encoding='unicode')
        if bel_info.find('bel_interconnect'):
            for bel_interconnect in bel_info.find('bel_interconnect'):
                specialInterconnectDict[bel_name] = ET.tostring(
                    bel_interconnect, encoding='unicode')

    # Calculate clock X and Y coordinates considering variations in coordinate systems and EMPTY padding around VPR model
    newClockX = clockX + 1
    newClockY = clockY + 1

    # DEVICE INFO

    deviceString = """
  <sizing R_minW_nmos="6065.520020" R_minW_pmos="18138.500000"/>
  <area grid_logic_tile_area="14813.392"/>
  <chan_width_distr>
   <x distr="uniform" peak="1.000000"/>
   <y distr="uniform" peak="1.000000"/>
  </chan_width_distr>
  <switch_block type="universal" fs="3"/>
  <connection_block input_switch_name="ipin_cblock"/>
  <default_fc in_type="frac" in_val="1" out_type="frac" out_val="1"/>

"""  # Several of these values are fillers, as they are outside the current scope of the FABulous project
    # As we're feeding in a custom RR graph, the type of switch block shouldn't matter, so universal was just a filler - using 'custom' would require an extra tag

    # NOTE: Currently indentation is handled manually, but it's probably worth introducing a library/external function to handle this at some point

    # COMPLEX BLOCKS, MODELS & TILES

    # String to store all the different kinds of pb_types needed - first we populate it with a dummy for tiles without BELs (as they still require a subtile)
    pb_typesString = '''<pb_type name="reserved_dummy">
    <interconnect>
    </interconnect>
    <input name="UserCLK" num_pins="1"/>
    </pb_type>
    '''

    modelsString = ""  # String to store different models

    tilesString = ""  # String to store tiles

    sourceSinkMap = getFabricSourcesAndSinks(archObject)

    # List to track bels that we've already created a pb_type for (by type)
    doneBels = []
    for cellType in archObject.cellTypes:
        cTile = getTileByType(archObject, cellType)

        # Add tiles and appropriate equivalent site
        tilesString += f'  <tile name="{cellType}">\n'
        # tilesString += f'   <sub_tile name="{cellType}_sub">' #Add sub_tile declaration to meet VTR 8.1.0 requirements
        # tilesString += '    <equivalent_sites>\n'
        # tilesString += f'     <site pb_type="{cellType}" pin_mapping="direct"/>\n'
        # tilesString += '    </equivalent_sites>\n'

        # pb_typesString += f'  <pb_type name="{cellType}">\n' #Top layer block

        # Track the tile's top level inputs and outputs for the top pb_type definition
        tileInputs = []
        tileOutputs = []

        if cTile.belsWithIO == []:  # VPR requires a sub-tile tag, so if we can't create one for a BEL we make a dummy one
            tilesString += f'<sub_tile name="{cellType}_dummy" capacity="1">\n'
            tilesString += f'  <equivalent_sites>\n'
            tilesString += f'    <site pb_type="reserved_dummy" pin_mapping="direct"/>\n'
            tilesString += f'  </equivalent_sites>\n'
            tilesString += f'<input name="UserCLK" num_pins="1"/>'
            tilesString += f'</sub_tile>\n'

        hangingPortStr = ''

        # Create second layer (leaf) blocks for each bel
        for bel in cTile.belsWithIO:
            # Add the inputs and outputs of this BEL to the top level tile inputs/outputs list
            tileInputs.extend(bel[2])
            tileOutputs.extend(bel[3])

            # If the BEL has no inputs or outputs then we need another dummy as VPR (understandably) doesn't like BELs with no pins
            # We could probably just omit them from the model, but this avoids any inconsistencies between subtile number and the fabric.csv
            if bel[2] == bel[3] == []:
                tilesString += f'<sub_tile name="{bel[1]}{bel[0]}_dummy" capacity="1">\n'
                tilesString += f'  <equivalent_sites>\n'
                tilesString += f'    <site pb_type="reserved_dummy" pin_mapping="direct"/>\n'
                tilesString += f'  </equivalent_sites>\n'
                tilesString += f'<input name="UserCLK" num_pins="1"/>'
                tilesString += f'</sub_tile>\n'
                continue

            # We generate a separate subtile for each BEL instance (so that we can wire them differently)
            # Therefore we do this before the doneBels check

            # Add subtile to represent this BEL (specific instance)
            # Add sub_tile declaration to meet VTR 8.1.0 requirements
            tilesString += f'   <sub_tile name="{bel[1]}{bel[0]}" capacity="1">\n'
            tilesString += '    <equivalent_sites>\n'

            pinMappingStr = ''
            # Generate interconnect from wrapper pb_type to primitive
            # Add direct connections from top level tile to the corresponding child port
            for cInput in bel[2]:
                pinMappingStr += f'    <direct from="{bel[1]}{bel[0]}.{cInput}" to="{bel[0]}_wrapper.{removeStringPrefix(cInput, bel[1])}"/>\n'

            for cOutput in bel[3]:  # Add direct connections from child port to top level tile
                pinMappingStr += f'    <direct to="{bel[0]}_wrapper.{removeStringPrefix(cOutput, bel[1])}" from="{bel[1]}{bel[0]}.{cOutput}"/>\n'

            if bel[4]:  # If the BEL has a clock input then route it in
                pinMappingStr += f'    <direct from="{bel[1]}{bel[0]}.UserCLK" to="{bel[0]}_wrapper.UserCLK"/>\n'

            if pinMappingStr == '':  # If no connections then direct mapping so VPR doesn't insist on subchildren that clarify mapping
                tilesString += f'     <site pb_type="{bel[0]}_wrapper" pin_mapping="direct">\n'
            else:
                tilesString += f'     <site pb_type="{bel[0]}_wrapper" pin_mapping="custom">\n'
                tilesString += pinMappingStr

            tilesString += f'     </site>\n'
            tilesString += '    </equivalent_sites>\n'

            # If the BEL has an external clock connection then add this to the tile string
            if bel[4]:
                tilesString += f'    <input name="UserCLK" num_pins="1"/>\n'

            # Add ports to BEL subtile
            for cInput in bel[2]:
                tilesString += f'    <input name="{cInput}" num_pins="1"/>\n'

            for cOutput in bel[3]:
                tilesString += f'    <output name="{cOutput}" num_pins="1"/>\n'

            tilesString += f'   </sub_tile>\n'  # Close subtile tag for this BEL

            # We only want one pb_type for each kind of bel so we track which ones we have already done
            if bel[0] in doneBels:
                continue

            count = 0
            for innerBel in cTile.belsWithIO:
                if innerBel[0] == bel[0]:  # Count how many of the current bel we have
                    count += 1

            # Prepare custom passthrough interconnect from wrapper to primitive pb_type

            # Create lists of ports without prefixes for our generic modelling
            unprefixedInputs = [removeStringPrefix(
                cInput, bel[1]) for cInput in bel[2]]
            unprefixedOutputs = [removeStringPrefix(
                cOutput, bel[1]) for cOutput in bel[3]]

            # String to connect ports in primitive pb to same-named ports on top-level pb
            passthroughInterconnectStr = ''
            pbPortsStr = ''

            for cInput in unprefixedInputs:
                # Add input and outputs
                pbPortsStr += f'    <input name="{cInput}" num_pins="1"/>\n'
                passthroughInterconnectStr += f'<direct name="{bel[0]}_{cInput}_top_to_child" input="{bel[0]}_wrapper.{cInput}" output="{bel[0]}.{cInput}"/>\n'

            if bel[4]:  # If the spec of the bel has an external clock connection
                # Create an input to represent this
                pbPortsStr += f'    <input name="UserCLK" num_pins="1"/>\n'
                passthroughInterconnectStr += f'<direct name="{bel[0]}_UserCLK_top_to_child" input="{bel[0]}_wrapper.UserCLK" output="{bel[0]}.UserCLK"/>\n'

            for cOutput in unprefixedOutputs:
                # Add outputs to pb
                pbPortsStr += f'    <output name="{cOutput}" num_pins="1"/>\n'
                passthroughInterconnectStr += f'<direct name="{bel[0]}_{cOutput}_child_to_top" input="{bel[0]}.{cOutput}" output="{bel[0]}_wrapper.{cOutput}"/>\n'

            if bel[0] in specialBelDict:  # If the bel has custom pb_type XML
                # Get the custom XML string
                thisPbString = specialBelDict[bel[0]]

                customInterconnectStr = ""  # Just so it's defined if there's no custom interconnect
                if bel[0] in specialInterconnectDict:  # And if it has any custom interconnects
                    # Add them to this string to be added in at the end of the pb_type
                    customInterconnectStr = specialInterconnectDict[bel[0]]

                pb_typesString += f'   <pb_type name="{bel[0]}_wrapper">\n'
                pb_typesString += thisPbString  # Add the custom pb_type XML with the list inserted
                pb_typesString += pbPortsStr
                pb_typesString += '   <interconnect>\n'
                pb_typesString += customInterconnectStr
                pb_typesString += passthroughInterconnectStr
                pb_typesString += '   </interconnect>\n'
                pb_typesString += f'   </pb_type>\n'

                if bel[0] in specialModelDict:  # If it also has custom model XML
                    # Then add in this XML
                    modelsString += specialModelDict[bel[0]]

                # Also add in interconnect to pass signals through from the wrapper

            else:  # Otherwise we generate the pb_type and model text

                # Add inner pb_type tag opener
                pb_typesString += f'   <pb_type name="{bel[0]}_wrapper">\n'
                # Add inner pb_type tag opener
                pb_typesString += f'   <pb_type name="{bel[0]}" num_pb="1" blif_model=".subckt {bel[0]}">\n'

                modelsString += f'  <model name="{bel[0]}">\n'  # Add model tag
                modelsString += '   <input_ports>\n'  # open tag for input ports in model list

                # Generate space-separated list of all outputs for combinational sink ports
                allOutsStr = " ".join(unprefixedOutputs)

                for cInput in unprefixedInputs:
                    # Add all outputs as combinational sinks
                    modelsString += f'    <port name="{cInput}" combinational_sink_ports="{allOutsStr}"/>\n'

                if bel[4]:  # If the spec of the bel has an external clock connection
                    # Add all outputs as combinational sinks
                    modelsString += f'    <port name="UserCLK"/>\n'

                modelsString += '   </input_ports>\n'  # close input ports tag
                modelsString += '   <output_ports>\n'  # open output ports tag

                for cOutput in unprefixedOutputs:
                    modelsString += f'    <port name="{cOutput}"/>\n'

                modelsString += f'   </output_ports>\n'  # close output ports tag
                modelsString += '  </model>\n'

                # Generate delay constants - for the time being, we will assume that all inputs are combinatorially connected to all outputs

                for cInput in unprefixedInputs:
                    # Add a constant delay between every pair of input and output ports (as currently we say they are all combinationally linked)
                    for cOutput in unprefixedOutputs:
                        pb_typesString += f'    <delay_constant max="300e-12" in_port="{bel[0]}.{cInput}" out_port="{bel[0]}.{cOutput}"/>\n'

                pb_typesString += pbPortsStr
                pb_typesString += '   </pb_type>\n'  # Close inner tag
                pb_typesString += '   <interconnect>\n'
                pb_typesString += passthroughInterconnectStr
                pb_typesString += '   </interconnect>\n'
                pb_typesString += pbPortsStr
                pb_typesString += f'   </pb_type>\n'  # Close wrapper tag

            doneBels.append(bel[0])  # Make sure we don't repeat similar BELs

        # Finally, we generate an extra sub_tile to contain all hanging sinks and sources (e.g. VCC, GND)
        # TODO: convert this to an individual sub_tile and pb_type for each kind of source/sink
        # This should allow GND and VCC sources to be instantiated or potentially techmapped

        hangingSources = sourceSinkMap[cTile.genTileLoc()][0]
        hangingSinks = sourceSinkMap[cTile.genTileLoc()][1]

        # only do this if there actually are any hanging sources or sinks
        if not (len(hangingSources) == len(hangingSinks) == 0):
            # First create sub_tile
            tilesString += f'<sub_tile name="{cellType}_hanging" capacity="1">\n'
            tilesString += f'  <equivalent_sites>\n'
            tilesString += f'    <site pb_type="{cellType}_hanging" pin_mapping="direct"/>\n'
            tilesString += f'  </equivalent_sites>\n'
            for sink in hangingSinks:
                tilesString += f'<input name="{sink}" num_pins="1"/>\n'

            for source in hangingSources:
                tilesString += f'<output name="{source}" num_pins="1"/>\n'

            tilesString += f'</sub_tile>\n'

            # Now create the pb_type

            pb_typesString += f'<pb_type name="{cellType}_hanging">\n'
            pb_typesString += f'<interconnect> </interconnect>\n'

            for sink in hangingSinks:
                pb_typesString += f'<input name="{sink}" num_pins="1"/>\n'

            for source in hangingSources:
                pb_typesString += f'<output name="{source}" num_pins="1"/>\n'

            pb_typesString += f'</pb_type>\n'

        tilesString += '  </tile>\n'

    # LAYOUT

    # Add 2 for empty padding
    layoutString = f'  <fixed_layout name="FABulous" width="{archObject.width + 2}" height="{archObject.height + 2}">\n'

    # Add tag for dummy clock
    layoutString += f'      <single type="clock_primitive" priority="1" x="{newClockX}" y="{newClockY}"/>\n'
    # Tile locations are specified using <single> tags - while the typical fabric will be made up of larger blocks of tiles, this allows the most flexibility

    for line in archObject.tiles:
        for tile in line:
            if tile.tileType != "NULL":  # We do not need to specify if the tile is empty as all tiles default to EMPTY in VPR
                # Add single tag for each tile - add 1 to x and y (cancels out in y conversion) for padding
                layoutString += f'   <single type="{tile.tileType}" priority="1" x="{tile.x + 1}" y="{tile.y + 1}">\n'
                # Now add metadata for fasm generation
                layoutString += '    <metadata>\n'

                # We need different numbers of prefixes depending on the subtiles
                tileLoc = tile.genTileLoc()
                if tile.belsWithIO == []:
                    prefixList = tileLoc + ".dummy "
                else:
                    prefixList = ""
                    i = 0
                    for bel in tile.belsWithIO:
                        prefixList += tileLoc + "." + letters[i] + " "
                        i += 1
                hangingSources = sourceSinkMap[tileLoc][0]
                hangingSinks = sourceSinkMap[tileLoc][1]

                # only do this if there actually are any hanging sources or sinks
                if not (len(hangingSources) == len(hangingSinks) == 0):
                    prefixList += tileLoc + ".hanging "

                # Only metadata required is the tile name for the prefix
                layoutString += f'     <meta name="fasm_prefix"> {prefixList} </meta>\n'
                layoutString += '    </metadata>\n'
                layoutString += '   </single>\n'

    layoutString += '  </fixed_layout>\n'

    # SWITCHLIST

    # Values are fillers from templates
    switchlistString = '  <switch type="buffer" name="ipin_cblock" R="551" Cin=".77e-15" Cout="4e-15" Tdel="58e-12" buf_size="27.645901"/>\n'
    switchlistString += '  <switch type="mux" name="buffer"  R="2e-12" Cin=".77e-15" Cout="4e-15" Tdel="58e-12" mux_trans_size="2.630740" buf_size="27.645901"/>\n'

    # SEGMENTLIST - contains only a filler as it is a necessity to parse the architecture graph but we are reading a custom RR graph

    segmentlistString = """  <segment name="dummy" length="1" freq="1.000000" type="unidir" Rmetal="1e-12" Cmetal="22.5e-15">
   <sb type="pattern">0 0</sb>
   <cb type="pattern">0</cb>
   <mux name="buffer"/>
  </segment>"""

    # CLOCK SETUP

    # Generate full strings for insertion - this is just a tile with the clock primitive on it
    clockTileStr = f"""  <tile name="clock_primitive">
   <sub_tile name="clock_sub">
    <equivalent_sites>
     <site pb_type="clock_primitive" pin_mapping="direct"/>
    </equivalent_sites>
    <output name="clock_out" num_pins="1"/>
   </sub_tile>
  </tile>"""

    # This is a pb_type with a Global_Clock primitive - when programming we instantiate this as a blackbox
    clockPbStr = f""" <pb_type name="clock_primitive">
  <pb_type name="clock_input" blif_model=".subckt Global_Clock" num_pb="1">
   <output name="CLK" num_pins="1"/>
  </pb_type>
  <output name="clock_out" num_pins="1"/>
  <interconnect>
   <direct name="clock_prim_to_top" input="clock_input.CLK" output="clock_primitive.clock_out"/>
  </interconnect>
 </pb_type> """

    # OUTPUT

    outputString = f'''<architecture>

 <device>
{deviceString}
 </device>

 <layout>
{layoutString}
 </layout>

 <tiles>
{clockTileStr}
{tilesString}
 </tiles>

 <models>
  <model name="Global_Clock">
   <output_ports>
    <port name="CLK"/>
   </output_ports>
  </model>
{modelsString}
 </models>

 <complexblocklist>
{clockPbStr}
{pb_typesString}
 </complexblocklist>

 <switchlist>
{switchlistString}
 </switchlist>

 <segmentlist>
{segmentlistString}
 </segmentlist>


</architecture>'''

    return outputString


def genVPRModelRRGraph(archObject: FabricModelGen, generatePairs=True):
    # Calculate clock X and Y coordinates considering variations in coordinate systems and EMPTY padding around VPR model
    newClockX = clockX + 1
    newClockY = clockY + 1

    # BLOCKS

    blocksString = ''  # Initialise string for block types
    curId = 0  # Increment id from 0 as we work through
    blockIdMap = {}  # Dictionary to record IDs for different tile types when generating grid
    ptcMap = {}  # Dict to map tiles to individual dicts that map pin name to PTC
    # Get sources and sinks for fabric - more info in method
    sourceSinkMap = getFabricSourcesAndSinks(archObject)

    # First, handle tiles not defined in architecture:

    blocksString += f"""  <block_type id="{curId}" name="EMPTY" width="1" height="1">
  </block_type>\n"""
    blockIdMap["EMPTY"] = curId
    curId += 1  # Add empty tile to block type spec and increment id by 1

    # And add clock tile (as this is a dummy to represent deeper FABulous functionality, so will not be in our csv files)

    blocksString += f'  <block_type id="{curId}" name="clock_primitive" width="1" height="1">\n'

    ptc = 0

    blocksString += f'   <pin_class type="OUTPUT">\n'
    # Add output tag for each tile
    blocksString += f'    <pin ptc="{ptc}">clock_primitive.clock_out[0]</pin>\n'
    blocksString += f'   </pin_class>\n'
    ptc += 1

    blocksString += '</block_type>\n'
    # Store that the clock_primitive block has this ID
    blockIdMap["clock_primitive"] = curId
    curId += 1

    for cellType in archObject.cellTypes:
        tilePtcMap = {}  # Dict to map each pin on this tile to its ptc
        # Generate block type tile for each type of tile - we assume 1x1 tiles here
        blocksString += f'  <block_type id="{curId}" name="{cellType}" width="1" height="1">\n'

        cTile = getTileByType(archObject, cellType)  # Fetch tile of this type

        # Following sections are deliberately ordered (based on comparison with VPR's generated RR graph)
        # as the PTC numbers have to match those that VPR would generate for its own RR graph
        # Pattern should be one subtile at a time, all subtile inputs then all subtile outputs (in order of declaration in architecture)

        ptc = 0

        if cTile.belsWithIO == []:  # If no BELs then we need UserCLK as a dummy pin
            blocksString += f'   <pin_class type="INPUT">\n'  # Generate the tags
            blocksString += f'    <pin ptc="{ptc}">{cellType}.UserCLK[0]</pin>\n'
            blocksString += f'   </pin_class>\n'
            ptc += 1

        for bel in cTile.belsWithIO:  # For each bel on the tile
            # If the BEL has clock input OR no inputs/outputs then we add UserCLK (latter case as VPR needs at least one pin)
            if bel[4] or (bel[2] == bel[3] == []):
                blocksString += f'   <pin_class type="INPUT">\n'  # Generate the tags
                blocksString += f'    <pin ptc="{ptc}">{cellType}.UserCLK[0]</pin>\n'
                blocksString += f'   </pin_class>\n'
                ptc += 1  # And increment the ptc

            for cInput in bel[2]:  # Take each input and output
                blocksString += f'   <pin_class type="INPUT">\n'  # Generate the tags
                blocksString += f'    <pin ptc="{ptc}">{cellType}.{cInput}[0]</pin>\n'
                blocksString += f'   </pin_class>\n'
                tilePtcMap[cInput] = ptc  # Note the ptc in the tile's ptc map
                ptc += 1  # And increment the ptc

            for cOutput in bel[3]:
                blocksString += f'   <pin_class type="OUTPUT">\n'  # Same as above
                blocksString += f'    <pin ptc="{ptc}">{cellType}.{cOutput}[0]</pin>\n'
                blocksString += f'   </pin_class>\n'
                tilePtcMap[cOutput] = ptc
                ptc += 1

        for sink in sourceSinkMap[cTile.genTileLoc()][1]:
            blocksString += f'   <pin_class type="INPUT">\n'  # Generate the tags
            blocksString += f'    <pin ptc="{ptc}">{cellType}.{sink}[0]</pin>\n'
            blocksString += f'   </pin_class>\n'
            tilePtcMap[sink] = ptc  # Note the ptc in the tile's ptc map
            ptc += 1  # And increment the ptc

        for source in sourceSinkMap[cTile.genTileLoc()][0]:
            blocksString += f'   <pin_class type="OUTPUT">\n'  # Same as above
            blocksString += f'    <pin ptc="{ptc}">{cellType}.{source}[0]</pin>\n'
            blocksString += f'   </pin_class>\n'
            tilePtcMap[source] = ptc
            ptc += 1

        blocksString += '  </block_type>\n'

        # Create copy of ptc map for this tile and add to larger dict (passing by reference would have undesired effects)
        ptcMap[cellType] = dict(tilePtcMap)

        # Populate our map of type name to ID as we need the ID for generating the grid
        blockIdMap[cellType] = curId
        curId += 1

    # NODES

    nodesString = ''
    curNodeId = 0  # Start indexing nodes at 0 and increment each time a node is added

    sourceToWireIDMap = {}  # Dictionary to map a wire source to the relevant wire ID
    destToWireIDMap = {}  # Dictionary to map a wire destination to the relevant wire ID

    max_width = 1  # Initialise value to find maximum channel width for channels tag - start as 1 as you can't have a thinner wire!

    srcToOpinStr = ''
    IpinToSinkStr = ''
    clockPtc = 0
    clockLoc = f'X{clockX}Y{clockY}'

    # Add node for clock out
    nodesString += f'  <!-- Clock output: clock_primitive.clock_out -->\n'

    # Generate tag for each node
    nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n'
    # Add loc tag
    nodesString += f'   <loc xlow="{newClockX}" ylow="{newClockY}" xhigh="{newClockX}" yhigh="{newClockY}" ptc="0"/>\n'
    nodesString += '  </node>\n'  # Close node tag

    curNodeId += 1  # Increment id so all nodes have different ids

    # Generate tag for each node
    nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n'
    # Add loc tag
    nodesString += f'   <loc xlow="{newClockX}" ylow="{newClockY}" xhigh="{newClockX}" yhigh="{newClockY}" ptc="0" side="BOTTOM"/>\n'
    nodesString += '  </node>\n'  # Close node tag
    srcToOpinStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'
    # Add to dest map as equivalent to a wire destination
    destToWireIDMap[clockLoc + "." + "clock_out"] = curNodeId
    curNodeId += 1
    clockPtc += 1

    # Looks like VPR can only handle node PTCs up to (2^15-1), so not sufficient to just give every wire a different PTC
    # Context: wires can't overlap another wire with the same PTC
    # Exhaustive search here might take a while, so instead vertical and horizontal wires have a different set of PTCs
    # Each column and row has its own current PTC so that there's no repetition in one column or row
    # Horizontal wires take and increment their row's PTC num
    # Vertical wires take and increment their column's PTC num
    # Column PTCs start at 2^14 so that there's no overlap between column and row PTCs

    # These are just indexed by tile.x and tile.y - not exactly the same as the coordinates in the
    # VPR description but it's a one-to-one mapping and all we need is no overlap so it's fine and simple
    rowPtcArr = [0] * archObject.height
    colPtcArr = [2**14] * archObject.width

    # These are just used as bound checks to make sure the fabric isn't still too big
    rowMaxPtc = 2**14 - 1
    colMaxPtc = 2**15 - 1

    for row in archObject.tiles:
        for tile in row:
            tileLoc = tile.genTileLoc()
            # Generate clock nodes:

            # First, clock output:
            if tile.tileType != "NULL":
                # Add clock inputs for every tile:

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="0" side="BOTTOM"/>\n'
                nodesString += '  </node>\n'  # Close node tag
                # Add to dest map as equivalent to a wire destination
                sourceToWireIDMap[tileLoc + ".UserCLK"] = curNodeId
                curNodeId += 1

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="0"/>\n'
                nodesString += '  </node>\n'  # Close node tag
                IpinToSinkStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'
                curNodeId += 1

            for wire in tile.wires:
                # We want to find the length of the wire based on the x and y offset - either it's a jump, or in theory goes off in only one direction - let's find which
                if wire["yoffset"] != "0" and wire["xoffset"] != "0":
                    # Stop if there are diagonal wires just in case they get put in a fabric
                    raise Exception(
                        "Diagonal wires not currently supported for VPR routing resource model")
                # Then we check which one isn't zero and take that as the length
                if wire["yoffset"] != "0":
                    nodeType = "CHANY"  # Set node type as vertical channel if wire is vertical
                elif wire["xoffset"] != "0":
                    nodeType = "CHANX"  # Set as horizontal if moving along X
                else:  # If we get to here then both offsets are zero and so this must be a jump wire
                    nodeType = "CHANY"  # default to CHANY - as offsets are zero it does not matter

                # Calculate destination location of the wire at hand
                desty = tile.y + int(wire["yoffset"])
                destx = tile.x + int(wire["xoffset"])
                desttileLoc = f"X{destx}Y{desty}"

                # Check wire direction and set appropriate valuesz
                if (nodeType == "CHANX" and int(wire["xoffset"]) > 0) or (nodeType == "CHANY" and int(wire["yoffset"]) > 0):
                    direction = "INC_DIR"
                    yLow = tile.y
                    xLow = tile.x
                    yHigh = desty
                    xHigh = destx
                else:
                    direction = "DEC_DIR"
                    yHigh = tile.y
                    xHigh = tile.x
                    yLow = desty
                    xLow = destx

                # For every individual wire
                for i in range(int(wire["wire-count"])):
                    # Generate location strings for the source and destination
                    wireSource = tileLoc + "." + wire["source"]
                    wireDest = desttileLoc + "." + wire["destination"]

                    if nodeType == "CHANY":
                        wirePtc = colPtcArr[tile.x]
                        colPtcArr[tile.x] += 1
                        if wirePtc > colMaxPtc:
                            raise ValueError(
                                "Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")
                    else:  # i.e. if nodeType == "CHANX"
                        wirePtc = rowPtcArr[tile.y]
                        rowPtcArr[tile.y] += 1
                        if wirePtc > rowMaxPtc:
                            raise ValueError(
                                "Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")

                    # Coordinates until now have been relative to the fabric - only account for padding when formatting actual string
                    # Comment destination for clarity
                    nodesString += f'  <!-- Wire: {wireSource+str(i)} -> {wireDest+str(i)} -->\n'
                    # Generate tag for each node
                    nodesString += f'  <node id="{curNodeId}" type="{nodeType}" capacity="1" direction="{direction}">\n'
                    nodesString += '   <segment segment_id="0"/>\n'
                    # Add loc tag with the information we just calculated
                    nodesString += f'   <loc xlow="{xLow + 1}" ylow="{yLow + 1}" xhigh="{xHigh + 1}" yhigh="{yHigh + 1}" ptc="{wirePtc}"/>\n'

                    nodesString += '  </node>\n'  # Close node tag

                    sourceToWireIDMap[wireSource+str(i)] = curNodeId
                    destToWireIDMap[wireDest+str(i)] = curNodeId

                    curNodeId += 1  # Increment id so all nodes have different ids
                # If our current width is greater than the previous max, take the new one
                max_width = max(max_width, int(wire["wire-count"]))

            # Generate nodes for atomic wires
            for wire in tile.atomicWires:
                # We want to find the length of the wire based on the x and y offset - either it's a jump, or in theory goes off in only one direction - let's find which
                if wire["yoffset"] != "0" and wire["xoffset"] != "0":
                    print(wire["yoffset"], wire["xoffset"])
                    # Stop if there are diagonal wires just in case they get put in a fabric
                    raise Exception(
                        "Diagonal wires not currently supported for VPR routing resource model")
                # Then we check which one isn't zero and take that as the length
                if wire["yoffset"] != "0":
                    nodeType = "CHANY"  # Set node type as vertical channel if wire is vertical
                elif wire["xoffset"] != "0":
                    nodeType = "CHANX"  # Set as horizontal if moving along X

                # Generate location strings for the source and destination
                wireSource = wire["sourceTile"] + "." + wire["source"]
                wireDest = wire["destTile"] + "." + wire["destination"]

                destTile = archObject.getTileByLoc(wire["destTile"])

                if (nodeType == "CHANX" and int(wire["xoffset"]) > 0) or (nodeType == "CHANY" and int(wire["yoffset"]) > 0):
                    direction = "INC_DIR"
                    yLow = tile.y
                    xLow = tile.x
                    yHigh = destTile.y
                    xHigh = destTile.x
                else:
                    direction = "DEC_DIR"
                    yHigh = tile.y
                    xHigh = tile.x
                    yLow = destTile.y
                    xLow = destTile.x

                if nodeType == "CHANY":
                    wirePtc = colPtcArr[tile.x]
                    colPtcArr[tile.x] += 1
                    if wirePtc > colMaxPtc:
                        raise ValueError(
                            "Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")
                else:  # i.e. if nodeType == "CHANX"
                    wirePtc = rowPtcArr[tile.y]
                    rowPtcArr[tile.y] += 1
                    if wirePtc > rowMaxPtc:
                        raise ValueError(
                            "Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")

                # Comment destination for clarity
                nodesString += f'  <!-- Atomic Wire: {wireSource} -> {wireDest} -->\n'
                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="{nodeType}" capacity="1" direction="{direction}">\n'

                # Add loc tag with the information we just calculated
                nodesString += f'   <loc xlow="{xLow + 1}" ylow="{yLow + 1}" xhigh="{xHigh + 1}" yhigh="{yHigh + 1}" ptc="{wirePtc}"/>\n'
                nodesString += '   <segment segment_id="0"/>\n'

                nodesString += f'  </node>\n'  # Close node tag

                sourceToWireIDMap[wireSource] = curNodeId
                destToWireIDMap[wireDest] = curNodeId

                curNodeId += 1  # Increment id so all nodes have different ids

            # Generate nodes for bel ports
            for bel in tile.belsWithIO:
                for cInput in bel[2]:
                    if tile.tileType in ptcMap and cInput in ptcMap[tile.tileType]:
                        thisPtc = ptcMap[tile.tileType][cInput]
                    else:
                        raise Exception(
                            "Could not find pin ptc in block_type designation for RR Graph generation.")
                    nodesString += f'  <!-- BEL input: {cInput} -->\n'
                    # Generate tag for each node
                    nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n'
                    # Add loc tag - same high and low vals as no movement between tiles
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n'
                    nodesString += '  </node>\n'  # Close node tag

                    # Add to source map as it is the equivalent of a wire source
                    sourceToWireIDMap[tileLoc + "." + cInput] = curNodeId

                    curNodeId += 1  # Increment id so all nodes have different ids

                    # Generate tag for each node
                    nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n'
                    # Add loc tag - same high and low vals as no movement between tiles
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n'
                    nodesString += '  </node>\n'  # Close node tag
                    IpinToSinkStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'

                    curNodeId += 1  # Increment id so all nodes have different ids

                for cOutput in bel[3]:
                    if tile.tileType in ptcMap and cOutput in ptcMap[tile.tileType]:
                        thisPtc = ptcMap[tile.tileType][cOutput]
                    else:
                        raise Exception(
                            "Could not find pin ptc in block_type designation for RR Graph generation.")
                    nodesString += f'  <!-- BEL output: {cOutput} -->\n'

                    # Generate tag for each node
                    nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n'
                    # Add loc tag
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n'
                    nodesString += '  </node>\n'  # Close node tag
                    # Add to dest map as equivalent to a wire destination
                    destToWireIDMap[tileLoc + "." + cOutput] = curNodeId
                    curNodeId += 1  # Increment id so all nodes have different ids

                    # Generate tag for each node
                    nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n'
                    # Add loc tag
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n'
                    nodesString += '  </node>\n'  # Close node tag
                    srcToOpinStr += f'  <edge src_node="{curNodeId}" sink_node="{curNodeId - 1}" switch_id="1"/>\n'
                    curNodeId += 1  # Increment id so all nodes have different ids

            for source in sourceSinkMap[tile.genTileLoc()][0]:
                thisPtc = ptcMap[tile.tileType][source]

                nodesString += f'  <!-- Source: {tile.genTileLoc()}.{source} -->\n'

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n'
                nodesString += '  </node>\n'  # Close node tag

                curNodeId += 1  # Increment id so all nodes have different ids

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n'
                nodesString += '  </node>\n'  # Close node tag
                srcToOpinStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'
                # Add to dest map as equivalent to a wire destination
                destToWireIDMap[tileLoc + "." + source] = curNodeId

                curNodeId += 1

            for sink in sourceSinkMap[tile.genTileLoc()][1]:
                thisPtc = ptcMap[tile.tileType][sink]

                nodesString += f'  <!-- Sink: {tile.genTileLoc()}.{sink} -->\n'

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n'
                nodesString += '  </node>\n'  # Close node tag
                curNodeId += 1  # Increment id so all nodes have different ids

                # Generate tag for each node
                nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n'
                # Add loc tag
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n'
                nodesString += '  </node>\n'  # Close node tag

                IpinToSinkStr += f'  <edge src_node="{curNodeId}" sink_node="{curNodeId - 1}" switch_id="1"/>\n'

                # Add to dest map as equivalent to a wire destination
                sourceToWireIDMap[tileLoc + "." + sink] = curNodeId
                curNodeId += 1  # Increment id so all nodes have different ids

    # EDGES

    # Initialise list of edges with edges connecting OPINs and IPINs to their corresponding SINKs and SOURCEs
    edgeStr = srcToOpinStr + IpinToSinkStr

    # Create edges for all pips in fabric

    for row in archObject.tiles:
        for tile in row:
            if tile.tileType != "NULL":  # If the tile isn't NULL then create an edge for the clock primitive connection
                tileLoc = tile.genTileLoc()
                edgeStr += f'  <edge src_node="{destToWireIDMap[clockLoc + "." + "clock_out"]}" sink_node="{sourceToWireIDMap[tileLoc + ".UserCLK"]}" switch_id="1"/>\n'

            for pip in tile.pips:  # Find source and sink name
                src_name = tileLoc + "." + pip[0]
                sink_name = tileLoc + "." + pip[1]

                # And create node
                edgeStr += f'  <edge src_node="{destToWireIDMap[src_name]}" sink_node="{sourceToWireIDMap[sink_name]}" switch_id="1">\n'
                # Generate metadata tag that tells us which switch matrix connection to activate
                edgeStr += '   <metadata>\n'
                edgeStr += f'    <meta name="fasm_features">{".".join([tileLoc, pip[0], pip[1]])}</meta>\n'
                edgeStr += '   </metadata>\n'
                edgeStr += '  </edge>\n'

    # CHANNELS

    max_width = max(rowPtcArr + colPtcArr)

    # Use the max width generated before for this tag
    channelString = f'  <channel chan_width_max="{max_width}" x_min="0" y_min="0" x_max="{archObject.width + 1}" y_max="{archObject.height + 1}"/>\n'

    # Generate x_list tag and y_list tag for every channel - use the upper bound max_width for simplicity
    # Not a bug that this uses height for the x_list and width for the y_list - see VtR's RR graph file format docs
    for i in range(archObject.height + 2):
        channelString += f'  <x_list index ="{i}" info="{max_width}"/>\n'

    for i in range(archObject.width + 2):
        channelString += f'  <y_list index ="{i}" info="{max_width}"/>\n'

    # GRID

    gridString = ''

    for row in archObject.tiles[::-1]:
        for tile in row:
            if tile.x == clockX and tile.y == clockY:  # We add the clock tile at the end so ignore it for now
                continue
            if tile.tileType == "NULL":  # The method that generates cellTypes ignores NULL, so it was never in our map - we'll just use EMPTY instead as we did for the main XML model
                gridString += f'  <grid_loc x="{tile.x + 1}" y="{tile.y + 1}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
                continue
            gridString += f'  <grid_loc x="{tile.x + 1}" y="{tile.y + 1}" block_type_id="{blockIdMap[tile.tileType]}" width_offset="0" height_offset="0"/>\n'

    # Create padding of EMPTY tiles around chip
    gridString += '  <!-- EMPTY padding around chip -->\n'

    for i in range(archObject.height + 2):  # Add vertical padding
        if newClockX != 0 or newClockY != i:  # Make sure that this isn't the clock tile as we add this at the end
            gridString += f'  <grid_loc x="0" y="{i}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
        if newClockX != archObject.width + 1 or newClockY != i:  # Check not clock tile
            gridString += f'  <grid_loc x="{archObject.width + 1}" y="{i}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'

    for i in range(1, archObject.width + 1):  # Add horizontal padding
        if newClockX != i or newClockY != 0:  # Check not clock tile
            gridString += f'  <grid_loc x="{i}" y="0" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
        if newClockX != i or newClockY != archObject.height + 1:  # Check not clock tile
            gridString += f'  <grid_loc x="{i}" y="{archObject.height + 1}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'

    # Finally, add clock tile loc
    gridString += f'  <grid_loc x="{newClockX}" y="{newClockY}" block_type_id="{blockIdMap["clock_primitive"]}" width_offset="0" height_offset="0"/>\n'

    # SWITCHES

    # Largely filler info - again, FABulous does not deal with this level of hardware detail currently

    switchesString = '''        <switch id="0" type="mux" name="__vpr_delayless_switch__">
            <timing R="0" Cin="0" Cout="0" Tdel="0"/>
            <sizing mux_trans_size="0" buf_size="0"/>
        </switch>
        <switch id="1" type="mux" name="buffer">
            <timing R="1.99999999e-12" Cin="7.70000012e-16" Cout="4.00000001e-15" Tdel="5.80000006e-11"/>
            <sizing mux_trans_size="2.63073993" buf_size="27.6459007"/>
        </switch>\n'''

    # OUTPUT

    outputString = f'''
<rr_graph tool_name="vpr" tool_version="82a3c72" tool_comment="Based on FABulous output">

 <channels>
{channelString}
 </channels>

 <switches>
{switchesString}
 </switches>

 <segments>
  <segment id="0" name="dummy">
   <timing R_per_meter="9.99999996e-13" C_per_meter="2.25000005e-14"/>
  </segment>
 </segments>

 <block_types>
{blocksString}
 </block_types>

 <grid>
{gridString}
 </grid>

 <rr_nodes>
{nodesString}
 </rr_nodes>

 <rr_edges>
{edgeStr}
 </rr_edges>

</rr_graph>
'''  # Same point as in main XML generation applies here regarding outsourcing indentation

    print(f'Max Width: {max_width}')
    return outputString
