from fabric import Fabric, Tile, Port
import os
import math
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


def GenerateVHDL_Header(file, entity, package='', noConfigBits='0', maxFramesPerCol='NULL', frameBitsPerRow='NULL'):
    #   library template
    print('library IEEE;', file=file)
    print('use IEEE.STD_LOGIC_1164.ALL;', file=file)
    print('use IEEE.NUMERIC_STD.ALL;', file=file)
    if package != '':
        print(package, file=file)
    print('', file=file)
    #   entity
    print(f"entity {entity} is Generic ( ", file=file)
    if maxFramesPerCol != 'NULL':
        print(f"{' ':<12}MaxFramesPerCol : integer := {maxFramesPerCol};", file=file)
    if frameBitsPerRow != 'NULL':
        print(f"{' ':<12}FrameBitsPerRow : integer := {frameBitsPerRow};", file=file)
    print(f"{' ':<12}NoConfigBits : integer := {noConfigBits};", file=file)
    print(f"{' ':<4} (", file=file)


def PrintTileComponentPort(tile_description, entity, direction, file):
    print('\t-- ', direction, file=file)
    for line in tile_description:
        if line[0] == direction:
            if line[source_name] != 'NULL':
                print('\t\t', line[source_name],
                      '\t: out \tSTD_LOGIC_VECTOR( ', end='', file=file)
                print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))
                      * int(line[wires]))-1, end='', file=file)
                print(' downto 0 );', end='', file=file)
                print('\t -- wires:'+line[wires], end=' ', file=file)
                print('X_offset:'+line[X_offset], 'Y_offset:' +
                      line[Y_offset], ' ', end='', file=file)
                print('source_name:'+line[source_name], 'destination_name:' +
                      line[destination_name], ' \n', end='', file=file)

    for line in tile_description:
        if line[0] == direction:
            if line[destination_name] != 'NULL':
                print('\t\t', line[destination_name],
                      '\t: in \tSTD_LOGIC_VECTOR( ', end='', file=file)
                print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))
                      * int(line[wires]))-1, end='', file=file)
                print(' downto 0 );', end='', file=file)
                print('\t -- wires:'+line[wires], end=' ', file=file)
                print('X_offset:'+line[X_offset], 'Y_offset:' +
                      line[Y_offset], ' ', end='', file=file)
                print('source_name:'+line[source_name], 'destination_name:' +
                      line[destination_name], ' \n', end='', file=file)
    return


def generateTileComponentPort(tile: Tile, file, configBitMode="frame_based", globalConfigBitsCounter=1):
    portTemplate = "{portName:<8}:{inout:<8}STD_LOGIC_VECTOR( {wireLength} downto 0 );".rjust(
        8)
    commentTemplate = "-- wires:{wires} X_offset:{X_offset} Y_offset:{Y_offset} source_name:{sourceName} destination_name:{destinationName}".rjust(
        4)

    wireLength = (abs(p.xOffset)+abs(p.yOffset)) * p.wires-1

    # holder for each direction of port string
    n, e, s, w = [], [], [], []

    # generate normal out port
    for p in tile.portsInfo:
        if p.sourceName == "NULL":
            a = portTemplate.format(portName=p.sourceName, inout="out",
                                    wireLength=wireLength)
            b = commentTemplate.format(wires=p.wires, X_offset=p.X_offset, Y_offset=p.Y_offset,
                                       sourceName=p.sourceName, destinationName=p.destinationName)
            result = a + b
            if p.direction == "NORTH":
                n.append(result)
            elif p.direction == "EAST":
                e.append(result)
            elif p.direction == "SOUTH":
                s.append(result)
            elif p.direction == "WEST":
                w.append(result)

    # generate normal in port
    for p in tile.portsInfo:
        if p.destinationName != "NULL":
            a = portTemplate.format(portName=p.destinationName, inout="in",
                                    wireLength=wireLength)
            b = commentTemplate.format(wires=p.wires, X_offset=p.X_offset, Y_offset=p.Y_offset,
                                       sourceName=p.sourceName, destinationName=p.destinationName)

            result = a + b
            if p.direction == "NORTH":
                n.append(result)
            elif p.direction == "EAST":
                e.append(result)
            elif p.direction == "SOUTH":
                s.append(result)
            elif p.direction == "WEST":
                w.append(result)

    print("\t-- NORTH\n"+"\n".join(n), file=file)
    print("\t-- EAST\n"+"\n".join(e), file=file)
    print("\t-- SOUTH\n"+"\n".join(s), file=file)
    print("\t-- WEST\n"+"\n".join(w), file=file)

    belPortTemplate = "\t\t{portName:<8}:{inout:<8}STD_LOGIC"
    belPortHolder = []
    addedExternalPort = set()
    print('\t-- Tile IO ports from BELs', file=file)
    for b in tile.bels:
        for p in b.externalInput:
            if p not in addedExternalPort:
                belPortHolder.append(
                    belPortTemplate.format(portName=p, inout="in"))
                addedExternalPort.add(p)
        for p in b.externalOutput:
            if p not in addedExternalPort:
                belPortHolder.append(
                    belPortTemplate.format(portName=p, inout="out"))
                addedExternalPort.add(p)

    if configBitMode == 'frame_based':
        print(";\n".join(belPortHolder) + ";", file=file)
        if globalConfigBitsCounter > 0:
            print('\t\t FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            print('\t\t FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ', file=file)
    else:
        print(";\n".join(belPortHolder), file=file)
    return


def GenerateVHDL_EntityFooter(file, entity, ConfigPort=True, NumberOfConfigBits=''):
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


def generateShiftRegister(file):
    template = \
        """
-- the configuration bits shift register
process(CLK)
begin
    if CLK'event and CLK='1' then
        if mode='1' then    --configuration mode
            ConfigBits <= CONFin & ConfigBits(ConfigBits'high downto 1);
        end if;
    end if;
end process;
CONFout <= ConfigBits(ConfigBits'high);

"""
    print(template, file=file)


def generateFlipFlopChain(file, configBitCounter):
    template = \
        f"""
ConfigBitsInput <= ConfigBits(ConfigBitsInput'high-1 downto 0) & CONFin;
-- for k in 0 to Conf/2 generate
L: for k in 0 to {int(math.ceil(configBitCounter/2.0))-1} generate
        inst_LHQD1a : LHQD1
        Port Map(
            D    => ConfigBitsInput(k*2),
            E    => CLK,
            Q    => ConfigBits(k*2) );
        inst_LHQD1b : LHQD1
        Port Map(
            D    => ConfigBitsInput((k*2)+1),
            E    => MODE,
            Q    => ConfigBits((k*2)+1) );
end generate;
CONFout <= ConfigBits(ConfigBits'high);

"""
    print(template, file=file)


def generateMux(file, muxStyle, muxSize, tileName, portName, portList, oldConfigBitstreamPosition, configBitstreamPosition, delay):
    # we have full custom MUX-4 and MUX-16 for which we have to generate code like:
    # VHDL example custom MUX4
    # inst_MUX4PTv4_J_l_AB_BEG1 : MUX4PTv4
    # Port Map(
    # IN1  => J_l_AB_BEG1_input(0),
    # IN2  => J_l_AB_BEG1_input(1),
    # IN3  => J_l_AB_BEG1_input(2),
    # IN4  => J_l_AB_BEG1_input(3),
    # S1   => ConfigBits(low_362),
    # S2   => ConfigBits(low_362 + 1,
    # O    => J_l_AB_BEG1 );
    # CUSTOM Multiplexers for switch matrix
    # CUSTOM Multiplexers for switch matrix
    # CUSTOM Multiplexers for switch matrix

    # -- switch matrix multiplexer  N1BEG0 		MUX-4
    # N1BEG0_input <= J_l_CD_END1 & JW2END3 & J2MID_CDb_END3 & LC_O after 80 ps
    # inst_MUX4PTv4_N1BEG0: MUX4PTv4
    # Port Map(
    #     IN1   =>  N1BEG0_input(0),
    #     IN2   =>  N1BEG0_input(1),
    #     IN3   =>  N1BEG0_input(2),
    #     IN4   =>  N1BEG0_input(3),
    #     S1    =>  ConfigBits(0 + 0),
    #     S2    =>  ConfigBits(0 + 1),
    #     O     =>  N1BEG0);

    muxTemplate = \
        """
{portName}_input <= {portList} after {delay};
inst_{muxComponentName}_{portName} : {muxComponentName}
    Port Map(
{inputList}
{configBitsList}
{outSignal}
    );
"""

    muxComponentName = 'MUX4PTv4'
    if (muxStyle == 'custom') and (muxSize == 4):
        muxComponentName = 'MUX4PTv4'
    if (muxStyle == 'custom') and (muxSize == 16):
        muxComponentName = 'MUX16PTv2'

    inputList, configBitsList, outSignal = [], [], ""

    for k in range(0, muxSize):
        inputList.append(f"{' ':<8}IN{k+1:<3} => {portName}_input({k}),")

    for k in range(0, (math.ceil(math.log2(muxSize)))):
        configBitsList.append(
            f"{' ':<8}S{k+1:<4} => ConfigBits({oldConfigBitstreamPosition} + {k}),")

    outSignal = f"{' ':<8}O{' ':<4} => {portName}"

    outString = muxTemplate.format(portName=portName,
                                   muxSize=muxSize,
                                   muxComponentName=muxComponentName,
                                   portList=' & '.join(portList),
                                   delay=delay,
                                   inputList="\n".join(inputList),
                                   configBitsList="\n".join(configBitsList),
                                   outSignal=outSignal)

    if (MultiplexerStyle == 'custom') and (muxSize == 4 or muxSize == 16):
        print(outString, file=file)
    else:        # generic multiplexer
        if MultiplexerStyle == 'custom':
            print(
                f"HINT: creating a MUX-{str(muxSize)} for port {portName} in switch matrix for tile {tileName}")
        print(outString, file=file)
        print(
            f"{' ':<4}{portName:>4} <= {portName}_input(TO_INTEGER(UNSIGNED(ConfigBits( {str(configBitstreamPosition-1)} downto {str(oldConfigBitstreamPosition)}))));", file=file)

    print("\n", file=file)
