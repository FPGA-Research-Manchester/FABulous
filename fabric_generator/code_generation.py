# Default parameters (will be overwritten if defined in fabric between 'ParametersBegin' and 'ParametersEnd'
#Parameters = [ 'ConfigBitMode', 'FrameBitsPerRow' ]
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


def GenerateVHDL_EntityFooter(file, entity, ConfigPort=True, NumberOfConfigBits=''):
    if ConfigPort == False:
        # stupid VHDL doesn't allow us to finish the last port signal declaration with a ';',
        # so we pragmatically delete that if we have no config port
        # TODO - move this into a function, but only if we have a regression suite in place
        # TODO - move this into a function, but only if we have a regression suite in place
        # TODO - move this into a function, but only if we have a regression suite in place
        file.seek(0)                      # seek to beginning of the file
        last_pos = 0                    # we use this variable to find the position of last ';'
        while True:
            my_char = file.read(1)
            if not my_char:
                break
            else:
                if my_char == ';':        # scan character by character and look for ';'
                    last_pos = file.tell()

        # place seek pointer to last ';' position and overwrite with a space
        file.seek(last_pos-1)
        print(' ', end='', file=file)
        file.seek(0, os.SEEK_END)          # go back to usual...
        # file.seek(interupt_pos)

        # file.seek(0, os.SEEK_END)                      # seek to end of file; f.seek(0, 2) is legal
        # file.seek(file.tell() - 3, os.SEEK_SET)     # go backwards 3 bytes
        # file.truncate()

        print('', file=file)
    print('\t-- global', file=file)
    if ConfigPort == True:
        if ConfigBitMode == 'FlipFlopChain':
            print(
                '\t\t MODE\t: in \t STD_LOGIC;\t -- global signal 1: configuration, 0: operation', file=file)
            print('\t\t CONFin\t: in \t STD_LOGIC;', file=file)
            print('\t\t CONFout\t: out \t STD_LOGIC;', file=file)
            print('\t\t CLK\t: in \t STD_LOGIC', file=file)
        if ConfigBitMode == 'frame_based':
            print(
                '\t\t ConfigBits : in \t STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )', file=file)
    print('\t);', file=file)
    print('end entity', entity, ';', file=file)
    print('', file=file)
    #   architecture
    print('architecture Behavioral of ', entity, ' is ', file=file)
    print('', file=file)
    return


def GenerateVHDL_Conf_Instantiation(file, counter, close=True):
    print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
    print('\t\t MODE    => Mode,  ', file=file)
    print('\t\t CONFin    => conf_data('+str(counter)+'),  ', file=file)
    print('\t\t CONFout    => conf_data('+str(counter+1)+'),  ', file=file)
    if close == True:
        print('\t\t CLK => CLK );  \n', file=file)
    else:
        print('\t\t CLK => CLK   ', file=file)
    return


def GenerateVHDL_Header(file, entity, package='', NoConfigBits='0', MaxFramesPerCol='NULL', FrameBitsPerRow='NULL'):
    #   library template
    print('library IEEE;', file=file)
    print('use IEEE.STD_LOGIC_1164.ALL;', file=file)
    print('use IEEE.NUMERIC_STD.ALL;', file=file)
    if package != '':
        print(package, file=file)
    print('', file=file)
    #   entity
    print('entity ', entity, ' is ', file=file)
    print('\tGeneric ( ', file=file)
    if MaxFramesPerCol != 'NULL':
        print('\t\t\t MaxFramesPerCol : integer := ' +
              MaxFramesPerCol+';', file=file)
    if FrameBitsPerRow != 'NULL':
        print('\t\t\t FrameBitsPerRow : integer := ' +
              FrameBitsPerRow+';', file=file)
    print('\t\t\t NoConfigBits : integer := '+NoConfigBits+' );', file=file)
    print('\tPort (', file=file)
    return
