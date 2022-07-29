ConfigBitMode = 'FlipFlopChain'
FrameBitsPerRow = 32
MaxFramesPerCol = 20
Package = 'use work.my_package.all;'
# time in ps - this is needed for simulation as a fabric configuration can result in loops crashing the simulator
GenerateDelayInSwitchMatrix = '100'
# 'custom': using our hard-coded MUX-4 and MUX-16; 'generic': using standard generic RTL code
MultiplexerStyle = 'custom'
# generate switch matrix select signals (index) which is useful to verify if bitstream matches bitstream
SwitchMatrixDebugSignals = True
SuperTileEnable = True		# enable SuperTile generation

src_dir = "./"

# TILE field aliases
direction = 0
source_name = 1
X_offset = 2
Y_offset = 3
destination_name = 4
wires = 5

# bitstream mapping aliases
frame_name = 0
frame_index = 1
bits_used_in_frame = 2
used_bits_mask = 3
ConfigBits_ranges = 4

# columns where VHDL file is specified
VHDL_file_position = 1
TileType_position = 1

# BEL prefix field (needed to allow multiple instantiations of the same BEL inside the same tile)
BEL_prefix = 2
# MISC
All_Directions = ['NORTH', 'EAST', 'SOUTH', 'WEST']
Opposite_Directions = {"NORTH": "SOUTH",
                       "EAST": "WEST", "SOUTH": "NORTH", "WEST": "EAST"}


def GenerateVerilog_Header(module_header_ports, file, module, package='', NoConfigBits='0', MaxFramesPerCol='NULL', FrameBitsPerRow='NULL', module_header_files=[]):
    print(f"module {module} ( {module_header_ports} );", file=file)
    if MaxFramesPerCol != 'NULL':
        print(f"{' ':<4}parameter MaxFramesPerCol = {MaxFramesPerCol};", file=file)
    if FrameBitsPerRow != 'NULL':
        print(f"{' ':<4}parameter FrameBitsPerRow = {FrameBitsPerRow};", file=file)
    print(f"{' ':<4}parameter NoConfigBits = {NoConfigBits};", file=file)


def GenerateVerilog_PortsFooter(file, module, ConfigPort=True, NumberOfConfigBits=''):
    print(f"{' ':<4}//global", file=file)
    if ConfigPort == False:
        print('', file=file)
    elif ConfigPort == True:
        if ConfigBitMode == 'FlipFlopChain':
            print(
                f"{' ':<4}input MODE;//global signal 1: configuration, 0: operation", file=file)
            print(f"{' ':<4}input CONFin;", file=file)
            print(f"{' ':4}output CONFout;", file=file)
            print(f"{' ':4}input CLK;", file=file)
        elif ConfigBitMode == 'frame_based':
            print(f"{' ':4}input [NoConfigBits-1:0] ConfigBits;", file=file)
            print(f"{' ': 4}input[NoConfigBits-1:0] ConfigBits_N", file=file)
    print('', file=file)


def PrintTileComponentPort_Verilog(tile_description, port_direction, file, port_prefix=''):
    if port_prefix:
        print(f"{' ':<4}// {port_prefix}_{port_direction}", file=file)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    print(
                        f"{' ':<4}output [{(abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires])-1}:0] {port_prefix}_{line[source_name]};", end="", file=file)
                    print(
                        f" //wires: {line[wires]} X_offset {line[X_offset]} Y_Offset: {line[Y_offset]} source_name: {line[source_name]}", file=file)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    print(
                        f"{' ':<4}input [{(abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires])-1}:0] {port_prefix}_{line[source_name]};", end="", file=file)
                    print(
                        f" //wires: {line[wires]} X_offset {line[X_offset]} Y_Offset: {line[Y_offset]} source_name: {line[source_name]}", file=file)

    return


def GetTileComponentPort_Verilog_Str(tile_description, port_direction, port_prefix=''):
    temp_list = []
    if port_prefix:
        temp_list.append(f"{' ':<4 }//{port_prefix}_{port_direction}")
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp = f"{' ':<4}output [{((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1}:0] {port_prefix}_{line[source_name]};"
                    str_temp += f" //wires:{line[wires]} X_offset: {line[X_offset]} \
                                    Y_offset: {line[Y_offset]} source_name: {line[source_name]} \
                                    destination_name: {line[destination_name]}"
                    temp_list.append(str_temp)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    str_temp = f"{' ': < 4}input[{(abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires])-1}:0] {port_prefix}_{line[destination_name]}; "
                    str_temp += f" //wires:{line[wires]} X_offset: {line[X_offset]} \
                                    Y_offset: {line[Y_offset]} source_name: {line[source_name]} \
                                    destination_name: {line[destination_name]}"
                    temp_list.append(str_temp)
    return temp_list


def GetTileComponentWire_Verilog_Str(tile_description, port_direction, port_prefix=''):
    temp_list = []
    if port_prefix:
        temp_list.append(f"{' ':<4}// {port_prefix}_{port_direction}")
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp = f"{' ':<4}wire [{(abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires])-1}:0] {port_prefix}_{line[source_name]};"
                    str_temp += f" //wires: {line[wires]} X_offset: {line[X_offset]} \
                                    Y_offset: {line[Y_offset]} source_name: {line[source_name]} \
                                    destination_name: {line[destination_name]}"
                    temp_list.append(str_temp)
    return temp_list


def GetTileComponentPort_Verilog(tile_description, port_direction, port_prefix=''):
    ports = []
    for line in tile_description:
        if line[0] == port_direction:
            if line[source_name] != 'NULL':
                if port_prefix:
                    ports.append(f"{port_prefix}_{line[source_name]}")
                else:
                    ports.append(line[source_name])
    for line in tile_description:
        if line[0] == Opposite_Directions[port_direction]:
            if line[destination_name] != 'NULL':
                if port_prefix:
                    ports.append(f"{port_prefix}_{line[destination_name]}")
                else:
                    ports.append(line[destination_name])
    return ports


def GenerateVerilog_Conf_Instantiation(file, counter, close=True):
    print(f"{' ':<4}//GLOBAL all primitive pins for configuration (not further parsed)", file=file)
    print(f"{' ':<4}.MODE(Mode),", file=file)
    print(f"{' ':<4}.CONFin(conf_data['+str(counter)+']),", file=file)
    print(f"{' ':<4}.CONFout(conf_data['+str(counter+1)+']),", file=file)
    if close == True:
        print(f"{' ':<4}.CLK(CLK)", file=file)
        print(f"{' ':<4});\n", file=file)
    else:
        print(f"{' ':<4}.CLK(CLK),", file=file)
    return
