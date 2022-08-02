from email import header
from typing import Literal
from fabric import Fabric, Tile, Port, Bel
import os
import math
import re
# Default parameters (will be overwritten if defined in fabric between 'ParametersBegin' and 'ParametersEnd'
# Parameters = [ 'ConfigBitMode', 'FrameBitsPerRow' ]
ConfigBitMode = 'frame_based'
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


class VHDLWriter():

    @property
    def outFileName(self):
        return self._outFileName

    @property
    def content(self):
        return self._content

    def __init__(self, outFileName):
        self._outFileName = outFileName
        self._content = []

    def writeToFile(self):
        with open(self._outFileName, 'w') as f:
            f.write("\n".join(self._content))

    def _add(self, line, indentLevel=0) -> None:
        if indentLevel == 0:
            self._content.append(line)
        else:
            self._content.append(f"{' ':<{4*indentLevel}}" + line)

    def addNewLine(self):
        self._add("")

    def addComment(self, comment, onNewLine=False, end="\n", indentLevel=0) -> None:
        if onNewLine:
            self._add("")
        self._add(f"{' ':<{indentLevel*4}}" + f"-- {comment}"f"{end}")

    def addHeader(self, name, package='', maxFramesPerCol='', frameBitsPerRow='', ConfigBitMode='FlipFlopChain', indentLevel=0):
        #   library template
        self._add("library IEEE;", indentLevel)
        self._add("use IEEE.STD_LOGIC_1164.ALL;", indentLevel)
        self._add("use IEEE.NUMERIC_STD.ALL", indentLevel)
        if package != "":
            self._add(package, indentLevel)
        self._add(f"entity {name} is", indentLevel)

    def addHeaderEnd(self, name, indentLevel=0):
        self._add(f"end entity {name}; ", indentLevel)

    def addParameterStart(self, indentLevel=0):
        self._add("Generic(", indentLevel)

    def addParameterEnd(self, indentLevel=0):
        self._add(");", indentLevel)

    def addParameter(self, name, type, value, indentLevel=0):
        self._add(f"{name} : {type} := {value};", indentLevel)

    def addPortStart(self, indentLevel=0):
        self._add("Port (", indentLevel)

    def addPortEnd(self, indentLevel=0):
        self._add(");", indentLevel)

    def addPortScalar(self, name, io: Literal["in", "out"], indentLevel=0):
        self._add(f"{name:<10} : {io} STD_LOGIC;", indentLevel=indentLevel)

    def addPortVector(self, name, io, width, indentLevel=0):
        self._add(
            f"{name:<10} : {io} STD_LOGIC_VECTOR( {width} downto 0 );", indentLevel=indentLevel)

    def addDesignDescriptionStart(self, name, indentLevel=0):
        self._add(
            f"architecture Behavioral of {name} is", indentLevel)

    def addDesignDescriptionEnd(self, indentLevel=0):
        self._add(f"end architecture Behavioral;", indentLevel)

    def addConstant(self, name, value, indentLevel=0):
        self._add(f"constant {name} : STD_LOGIC := '{value}';", indentLevel)

    def addConnectionVector(self, name, width, indentLevel=0):
        self._add(
            f"signal {name} : STD_LOGIC_VECTOR( { width } - 1 downto 0 );", indentLevel)

    def addConnectionScalar(self, name, indentLevel=0):
        self._add(f"signal {name} : STD_LOGIC;", indentLevel)

    def addLogicStart(self, indentLevel=0):
        self._add(f"begin", indentLevel)

    def addLogicEnd(self, indentLevel=0):
        self._add(f"end", indentLevel)

    def addFlipFlopChain(self, configBitCounter):
        template = f"""
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
        self._add(template)

    def addShiftRegister(self, indentLevel=0):
        template = """
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
        self._add(template, indentLevel)

    def addAssignScalar(self, left, right, indentLevel=0):
        self._add(f"{left} <= {right};", indentLevel)

    def addAssignVector(self, left, right, widthL, widthR, indentLevel=0):
        self._add(
            f"{left} <= {right}( {widthL} downto {widthR} );", indentLevel)

    def addMux(self, muxStyle, muxSize, tileName, portName, portList, oldConfigBitstreamPosition, configBitstreamPosition, delay):
        # we have full custom MUX-4 and MUX-16 for which we have to generate code like:
        # VHDL example custom MUX4
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
        delayTemplate = "{portName}_input <= {portList} after {delay} ps;"
        muxTemplate = """
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

        muxString = muxTemplate.format(portName=portName,
                                       muxSize=muxSize,
                                       muxComponentName=muxComponentName,
                                       inputList="\n".join(inputList),
                                       configBitsList="\n".join(
                                           configBitsList),
                                       outSignal=outSignal)
        delayString = delayTemplate.format(portName=portName,
                                           portList=" & ".join(portList),
                                           delay=delay)
        self._add(delayString)
        if (MultiplexerStyle == 'custom') and (muxSize == 4 or muxSize == 16):
            self._add(muxString)
        else:        # generic multiplexer
            if MultiplexerStyle == 'custom':
                print(
                    f"HINT: creating a MUX-{str(muxSize)} for port {portName} in switch matrix for tile {tileName}")
            self._add(f"{portName:>4} <= {portName}_input(TO_INTEGER(UNSIGNED(ConfigBits( {str(configBitstreamPosition-1)} downto {str(oldConfigBitstreamPosition)}))));""\n")

    def addLatch(self, frameName, frameBitsPerRow, frameIndex, configBit):
        latchTemplate = f"""
Inst_{frameName}_bit{frameBitsPerRow} : LHQD1
    PortMap(
        D => FrameData({frameBitsPerRow}),
        E => FrameStrobe({frameIndex}),
        Q => ConfigBits({configBit})
    );
    """
        self._add(latchTemplate)

    def addComponentDeclarationForFile(self, fileName):
        configPortUsed = 0  # 1 means is used
        with open(fileName, 'r') as f:
            data = f.read()

        if result := re.search(r"NumberOfConfigBits.*?(\d+)", data, flags=re.IGNORECASE):
            configPortUsed = 1
            if result.group(1) == '0':
                configPortUsed = 0

        if result := re.search(r"^entity.*?end entity.*?;$",
                               data, flags=re.MULTILINE | re.DOTALL):
            result = result.group(0)
            result = result.replace("entity", "component")

        self._add(result)
        return configPortUsed

    def addConfigMemInstantiation(self, name):
        self._add(f"Inst_{name}_ConfigMem : {name}_ConfigMem")
        self._add(f"Port Map( ", indentLevel=1)
        self._add(f"FrameData   => FrameData,", indentLevel=2)
        self._add(f"FrameStrobe => FrameStrobe,", indentLevel=2)
        self._add(f"ConfigBits  => ConfigBits", indentLevel=2)
        self._add(");")

    def addBELInstantiations(self, bel: Bel, configBitCounter, mode="frame_based", belCounter=0):
        belTemplate = """
Inst_{prefix}{entity} : {entity}
        Port Map(
{portList}
        -- I/O primitive pins go to tile top level entity (not further parsed)
{globalAndConfigBits}
    );
    """
        # internal port
        portList = []
        globalAndConfigBits = []
        for port in bel.inputs + bel.outputs:
            port = re.sub(rf"{bel.prefix}", "", port)
            portList.append(f"{' ':<8}{port} => {bel.prefix}{port},")

        # normal external port
        for port in bel.externalInput + bel.externalOutput:
            if port not in bel.sharedPort:
                globalAndConfigBits.append(
                    f"{' ':<8}{port} => {bel.prefix}{port}")

        # shared port
        # top level I/Os (if any) just get connected directly
        for ports in bel.sharedPort:
            globalAndConfigBits.append(f"{' ':<8}{ports[0]} => {ports[0]}")

        if mode == "frame_based":
            globalAndConfigBits.append(
                f"{' ':<8}ConfigBits => ConfigBits ( {configBitCounter+bel.configBit} - 1 downto {configBitCounter} )")
        else:
            self.add_Conf_Instantiation(belCounter, close=True)

        self._add(belTemplate.format(prefix=bel.prefix,
                                     entity=bel.src.split(
                                         "/")[-1].split(".")[0],
                                     portList='\n'.join(portList),
                                     globalAndConfigBits=',\n'.join(globalAndConfigBits)))

    def add_Conf_Instantiation(self, counter, close=True):
        confTemplate = """
        -- GLOBAL all primitive pins for configuration (not further parsed)
            MODE    => Mode,
            CONFin  => conf_data({counter}),
            CONFout => conf_data({counter2}),
            CLK     => CLK
            {end}
    """
        self._add(confTemplate.format(counter=counter,
                                      counter2=counter+1,
                                      end='' if close else ');'))

    def addSwitchMatrixInstruction(self, tile: Tile, configBitCounter, switchMatrixConfigPort, belCounter, mode='frame_based'):
        switchTemplate = """
-- switch matrix component instantiation
Inst_{tileName}_switch_matrix : {tileName}_switch_matrix
    Port Map(
{portMapList}
{configBit}
    );
"""
        portInputIndexed = []
        portOutputIndexed = []
        portTopInput = []
        portTopOutputs = []
        jumpWire = []
        # get indexed version of the port of the tile
        for p in tile.portsInfo:
            if p.direction != "JUMP":
                input, output = p.expandPortInfo(
                    mode="AutoSwitchMatrixIndexed")
                portInputIndexed += input
                portOutputIndexed += output
                input, output = p.expandPortInfo(mode="AutoTopIndexed")
                portTopInput += input
                portTopOutputs += output
            else:
                input, output = p.expandPortInfo(
                    mode="AutoSwitchMatrixIndexed")
                input = [i for i in input if "GND" not in i and "VCC" not in i]
                jumpWire += input

        belOutputs = []
        belInputs = []

        for b in tile.bels:
            belOutputs += b.outputs
            belInputs += b.inputs
        inoutPair = zip([i for i in (tile.outputs + tile.inputs) if "GND" not in i and "VCC" not in i],
                        (portOutputIndexed + belOutputs + jumpWire + portTopInput + belInputs + jumpWire))
        portMapList = []
        for i, o in inoutPair:
            portMapList.append(f"{' ':<8}{i:<8} => {o}")

        configBit = ""
        if switchMatrixConfigPort > 0:
            if mode == "FlipFlopChain":
                self._add(switchTemplate.format(tileName=tile.name,
                                                portMapList=",\n".join(
                                                    portMapList),
                                                configBit=""))
                self.add_Conf_Instantiation(counter=belCounter, close=True)
            if mode == "frame_based":
                if tile.globalConfigBits > 0:
                    configBit = f"{' ':<8}ConfigBits => ConfigBits ( {tile.globalConfigBits} - 1 downto {configBitCounter} )"
                    self._add(switchTemplate.format(tileName=tile.name,
                                                    portMapList=",\n".join(
                                                        portMapList)+",",
                                                    configBit=configBit))
                else:
                    self._add(switchTemplate.format(tileName=tile.name,
                                                    portMapList=",\n".join(
                                                        portMapList),
                                                    configBit=configBit))


def GenerateVHDL_Header(file, entity, package='', noConfigBits='0', maxFramesPerCol='', frameBitsPerRow=''):
    #   library template
    headerTemplate = """
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
{package}
entity {entity} is
    Generic (
        {maxFramesPerCol}
        {frameBitsPerRow}
        NoConfigBits : integer := {noConfigBits}
    );
"""
    if maxFramesPerCol != '':
        maxFramesPerCol = f"MaxFramesPerCol : integer := {maxFramesPerCol};"
    else:
        maxFramesPerCol = f"-- NOT SET MaxFramesPerCol : integer := {maxFramesPerCol};"

    if frameBitsPerRow != '':
        frameBitsPerRow = f"FrameBitsPerRow : integer := {frameBitsPerRow};"
    else:
        frameBitsPerRow = f"-- NOT SET FrameBitsPerRow : integer := {frameBitsPerRow};"
    print(headerTemplate.format(package=package,
                                entity=entity,
                                noConfigBits=noConfigBits,
                                maxFramesPerCol=maxFramesPerCol,
                                frameBitsPerRow=frameBitsPerRow), file=file)


def PrintTileComponentPort(tile_description, entity, direction, file):
    print(f"{' ':<4}-- ", direction, file=file)
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


def PrintComponentDeclarationForFile(VHDL_file_name, file):
    ConfigPortUsed = 0  # 1 means is used
    VHDLfile = [line.rstrip('\n')
                for line in open(f"{src_dir}/{VHDL_file_name}")]
    templist = []
    marker = False
    # for item in VHDLfile:
    # print(item)
    for line in VHDLfile:
        # NumberOfConfigBits:0 means no configuration port
        if re.search('NumberOfConfigBits', line, flags=re.IGNORECASE):
            # NumberOfConfigBits appears, so we may have a config port
            ConfigPortUsed = 1
            # but only if the following is not true
            if re.search('NumberOfConfigBits:0', line, flags=re.IGNORECASE):
                ConfigPortUsed = 0
        if marker == True:
            print(re.sub('entity', 'component', line,
                  flags=re.IGNORECASE), file=file)
        if re.search('^entity', line, flags=re.IGNORECASE):
            # print(str.replace('^entity', line))
            # re.sub('\$noun\$', 'the heck', 'What $noun$ is $verb$?')
            print(re.sub('entity', 'component', line,
                  flags=re.IGNORECASE), file=file)
            marker = True
        if re.search('^end ', line, flags=re.IGNORECASE):
            marker = False
    print('', file=file)
    return ConfigPortUsed


def generateComponentDeclarationForFile(VHDL_file_name, file):
    configPortUsed = 0  # 1 means is used
    with open(VHDL_file_name, 'r') as f:
        data = f.read()

    if result := re.search(r"NumberOfConfigBits.*?(\d+)", data, flags=re.IGNORECASE):
        configPortUsed = 1
        if result.group(1) == '0':
            configPortUsed = 0

    if result := re.search(r"^entity.*?end entity.*?;$",
                           data, flags=re.MULTILINE | re.DOTALL):
        result = result.group(0)
        result = result.replace("entity", "component")
    print(result, file=file)
    print('', file=file)
    return configPortUsed


def generateTileComponentPort(tile: Tile, file, configBitMode="frame_based", globalConfigBitsCounter=1):
    commentTemplate = "-- wires:{wires} X_offset:{X_offset} Y_offset:{Y_offset} source_name:{sourceName} destination_name:{destinationName}"
    portTemplate = f"{' ':<8}""{portName:<8}:{inout:<8}STD_LOGIC_VECTOR( {wireLength} downto 0 );""\t"

    print(f"{' ':<4} Port (", file=file)

    # holder for each direction of port string
    n, e, s, w = [], [], [], []

    # generate normal out port
    for p in tile.portsInfo:
        if p.sourceName != "NULL":
            wireLength = (abs(p.xOffset)+abs(p.yOffset)) * p.wires-1
            a = portTemplate.format(portName=p.sourceName, inout="out",
                                    wireLength=wireLength)
            b = commentTemplate.format(wires=p.wires, X_offset=p.xOffset, Y_offset=p.yOffset,
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
            wireLength = (abs(p.xOffset)+abs(p.yOffset)) * p.wires-1
            a = portTemplate.format(portName=p.destinationName, inout="in",
                                    wireLength=wireLength)
            b = commentTemplate.format(wires=p.wires, X_offset=p.xOffset, Y_offset=p.yOffset,
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

    print("\t\t-- NORTH\n"+"\n".join(n), file=file)
    print("\t\t-- EAST\n"+"\n".join(e), file=file)
    print("\t\t-- SOUTH\n"+"\n".join(s), file=file)
    print("\t\t-- WEST\n"+"\n".join(w), file=file)

    # belPortTemplate = "\t\t{portName:<8}:{inout:<8}STD_LOGIC"
    # belPortHolder = []
    # addedExternalPort = set()
    # print('\t-- Tile IO ports from BELs', file=file)
    # for b in tile.bels:
    #     for p in b.externalInput:
    #         if p not in addedExternalPort:
    #             belPortHolder.append(
    #                 belPortTemplate.format(portName=p, inout="in"))
    #             addedExternalPort.add(p)
    #     for p in b.externalOutput:
    #         if p not in addedExternalPort:
    #             belPortHolder.append(
    #                 belPortTemplate.format(portName=p, inout="out"))
    #             addedExternalPort.add(p)
