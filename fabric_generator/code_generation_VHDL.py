from typing import Literal, Tuple
from fabric import Fabric, Tile, Port, Bel
import os
import math
import re

from code_generator import codeGenerator
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


class VHDLWriter(codeGenerator):

    def addComment(self, comment, onNewLine=False, end="", indentLevel=0) -> None:
        if onNewLine:
            self._add("")
        if self._content:
            self._content[-1] += f"{' ':<{indentLevel*4}}" + \
                f"-- {comment}"f"{end}"
        else:
            self._add(f"{' ':<{indentLevel*4}}" +
                      f"-- {comment}"f"{end}")

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

    def addParameter(self, name, type, value, end=False, indentLevel=0):
        self._add(f"{name} : {type} := {value};", indentLevel)

    def addPortStart(self, indentLevel=0):
        self._add("Port (", indentLevel)

    def addPortEnd(self, indentLevel=0):
        self._add(");", indentLevel)

    def addPortScalar(self, name, io, end=False, indentLevel=0):
        self._add(f"{name:<10} : {io.lower()} STD_LOGIC;",
                  indentLevel=indentLevel)

    def addPortVector(self, name, io, width, end=False, indentLevel=0):
        self._add(
            f"{name:<10} : {io} STD_LOGIC_VECTOR( {width} downto 0 );", indentLevel=indentLevel)

    def addDesignDescriptionStart(self, name, indentLevel=0):
        self._add(
            f"architecture Behavioral of {name} is", indentLevel)

    def addDesignDescriptionEnd(self, indentLevel=0):
        self._add(f"end architecture Behavioral;", indentLevel)

    def addConstant(self, name, value, indentLevel=0):
        self._add(f"constant {name} : STD_LOGIC := '{value}';", indentLevel)

    def addConnectionScalar(self, name, indentLevel=0):
        self._add(f"signal {name} : STD_LOGIC;", indentLevel)

    def addConnectionVector(self, name, width, end=0, indentLevel=0):
        self._add(
            f"signal {name} : STD_LOGIC_VECTOR( { width } downto {end} );", indentLevel)

    def addLogicStart(self, indentLevel=0):
        self._add("\n"f"begin""\n", indentLevel)

    def addLogicEnd(self, indentLevel=0):
        self._add("\n"f"end""\n", indentLevel)

    def addAssignScalar(self, left, right, delay=0, indentLevel=0):
        if type(right) == list:
            self._add(f"{left} <= {' & '.join(right)};", indentLevel)
        else:
            self._add(f"{left} <= {right};", indentLevel)

    def addAssignVector(self, left, right, widthL, widthR, indentLevel=0):
        self._add(
            f"{left} <= {right}( {widthL} downto {widthR} );", indentLevel)

    def addInstantiation(self, compName, compInsName, compPort, signal, paramPort=[], paramSignal=[], indentLevel=0):
        if len(compPort) != len(signal):
            raise ValueError(
                f"Number of ports and signals do not match: {compPort} != {signal}")
        if len(paramPort) != len(paramSignal):
            raise ValueError(
                f"Number of ports and signals do not match: {paramPort} != {paramSignal}")

        self._add(f"{compInsName} : {compName}", indentLevel=indentLevel)
        if paramPort:
            self._add(f"generic map (", indentLevel=indentLevel+1)
            for i in range(len(paramPort)):
                self._add(
                    f"{paramPort[i]} => {paramSignal[i]};", indentLevel=indentLevel+2)
            self._add(f")", indentLevel=indentLevel+1)

        self._add(f"Port map(", indentLevel=indentLevel + 1)
        connectPair = []
        for i in range(len(compPort)):
            if "[" in signal[i]:
                signal[i] = signal[i].replace("[", "(").replace("]", ")")
            connectPair.append(f"{compPort[i]} => {signal[i]}")

        self._add(
            (",\n"f"{' ':<{4*(indentLevel + 2)}}").join(connectPair), indentLevel=indentLevel + 2)
        self._add(");", indentLevel=indentLevel + 1)
        self.addNewLine()

    def addGeneratorStart(self, loopName, variableName, start, end, indentLevel=0):
        self._add(
            f"{loopName}: for {variableName} in {start} to {end} generate", indentLevel=indentLevel)

    def addGeneratorEnd(self, indentLevel=0):
        self._add("end generate;", indentLevel)

    def addComponentDeclarationForFile(self, fileName):
        configPortUsed = 0  # 1 means is used
        with open(fileName, 'r') as f:
            data = f.read()

        if result := re.search(r"NumberOfConfigBits.*?(\d+)", data, flags=re.IGNORECASE):
            configPortUsed = 1
            if result.group(1) == '0':
                configPortUsed = 0

        if result := re.search(r"^entity.*?end entity.*?;",
                               data, flags=re.MULTILINE | re.DOTALL):
            result = result.group(0)
            result = result.replace("entity", "component")

        self._add(result)
        self.addNewLine()
        return configPortUsed

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
