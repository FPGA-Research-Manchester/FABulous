from re import S
from typing import Literal
from fabric import Tile
import math
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


class VerilogWriter():
    @property
    def outFileName(self):
        return self._outFileName

    @property
    def content(self):
        return self._content

    def __init__(self, outFileName) -> None:
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
        self._add(f"{' ':<{indentLevel*4}}" + f"// {comment}"f"{end}")

    def addHeader(self, name, package='', maxFramesPerCol='', frameBitsPerRow='', ConfigBitMode='FlipFlopChain', indentLevel=0):
        self._add(f"module {name}", indentLevel)

    def addHeaderEnd(self, name, indentLevel=0):
        pass

    def addParameterStart(self, indentLevel=0):
        self._add(f"#(", indentLevel)

    def addParameterEnd(self, indentLevel=0):
        self._add(")", indentLevel)

    def addParameter(self, name, type, value, indentLevel=0):
        self._add(f"parameter {name}={value},", indentLevel)

    def addPortStart(self, indentLevel=0):
        self._add(f"(", indentLevel)

    def addPortEnd(self, indentLevel=0):
        self._add(");", indentLevel)

    def addPortScalar(self, name, io: Literal["in", "out"], indentLevel=0):
        t = ""
        if io == "in":
            t = "input"
        if io == "out":
            t = "output"
        self._add(f"{t} {name},", indentLevel)

    def addPortVector(self, name, io: Literal["in", "out"], width, indentLevel=0):
        t = ""
        if io == "in":
            t = "input"
        if io == "out":
            t = "output"
        self._add(f"{t} [{width}:0] {name},", indentLevel)

    def addDesignDescriptionStart(self, indentLevel=0):
        pass

    def addDesignDescriptionEnd(self, indentLevel=0):
        self._add("endModule", indentLevel)

    def addConstant(self, name, value, indentLevel=0):
        self._add(f"parameter {name} = {value};", indentLevel)

    def addConnectionVector(self, name, width, indentLevel=0):
        self._add(
            f"wire[{width}-1:0] {name};", indentLevel)

    def addConnectionScalar(self, name):
        self._add(f"wire {name};")

    def addLogicStart(self, indentLevel=0):
        pass

    def addLogicEnd(self, indentLevel=0):
        pass

    def addShiftRegister(self, configBits, indentLevel=0):
        template = f"""
// the configuration bits shift register
    always @ (posedge CLK)
        begin
            if (MODE=1b'1) begin    //configuration mode
                ConfigBits <= {{CONFin,ConfigBits[{configBits}-1:1]}};
            end
        end
    assign CONFout = ConfigBits[{configBits}-1];

        """
        self._add(template, indentLevel)

    def addFlipFlopChain(self, configBits, indentLevel=0):
        cfgBit = int(math.ceil(configBits/2.0))*2
        template = f"""
    genvar k;
    assign ConfigBitsInput = {{ConfigBits[{cfgBit}-1-1:0], CONFin;}}
    // for k in 0 to Conf/2 generate
    for (k=0; k < {cfgBit-1}; k = k + 1) begin: L
        LHQD1 inst_LHQD1a(
            .D(ConfigBitsInput[k*2]),
            .E(CLK),
            .Q(ConfigBits[k*2])
        );
        LHQD1 inst_LHQD1b(
            .D(ConfigBitsInput[(k*2)+1]),
            .E(MODE),
            .Q(ConfigBits[(k*2)+1])
        );
    end
    assign CONFout = ConfigBits[{cfgBit}-1];
"""
        self._add(template, indentLevel)

    def addAssignScalar(self, left, right, indentLevel=0):
        self._add(f"assign {left} = {right};", indentLevel)

    def addAssignVector(self, left, right, widthL, widthR, indentLevel=0):
        self._add(
            f"assign {left} = {right}[{widthL}:{widthR}];", indentLevel)

    def addMux(self, muxStyle, muxSize, tileName, portName, portList, oldConfigBitstreamPosition, configBitstreamPosition, delay):
        # we have full custom MUX-4 and MUX-16 for which we have to generate code like:
        # // switch matrix multiplexer  N1BEG0 		MUX-4
        # 	assign N1BEG0_input = {J_l_CD_END1,JW2END3,J2MID_CDb_END3,LC_O};
        # 	cus_mux41_buf inst_cus_mux41_buf_N1BEG0 (
        # 	    .A0 (N1BEG0_input[0]),
        # 	    .A1 (N1BEG0_input[1]),
        # 	    .A2 (N1BEG0_input[2]),
        # 	    .A3 (N1BEG0_input[3]),
        # 	    .S0 (ConfigBits[0+0]),
        # 	    .S0N (ConfigBits_N[0+0]),
        # 	    .S1 (ConfigBits[0+1]),
        # 	    .S1N (ConfigBits_N[0+1]),
        # 	    .X (N1BEG0)
        # 	);

        delayTemplate = "assign {portName}_input = {{{portList}}};"
        muxTemplate = """
{muxComponentName} inst_{muxComponentName} (
{inputList}
{configBitsList}
{outSignal}
);
    """
        numGnd = 0
        muxComponentName = ""
        if (muxStyle == 'custom') and (muxSize == 2):
            muxComponentName = 'my_mux2'
        if (muxStyle == 'custom') and (2 < muxSize <= 4):
            muxComponentName = 'cus_mux41_buf'
            numGnd = 4-muxSize
        if (muxStyle == 'custom') and (4 < muxSize <= 8):
            muxComponentName = 'cus_mux81_buf'
            numGnd = 8-muxSize
        if (muxStyle == 'custom') and (8 < muxSize <= 16):
            muxComponentName = 'cus_mux161_buf'
            numGnd = 16-muxSize

        inputList, configBitsList, outSignal = [], [], ""

        start = 0
        for start in range(muxSize):
            inputList.append(f"{' ':<4}.A{start}({portName}_input[{start}]),")

        for end in range(start, numGnd):
            inputList.append(f"{' ':<4}.A{end}(GND0)")

        if muxStyle == "custom":
            if muxSize == 2:
                for k in range(0, (math.ceil(math.log2(muxSize)))):
                    configBitsList.append(
                        f"{' ':<4}.S{k}(ConfigBits[{oldConfigBitstreamPosition}+{k}]),")

            else:
                for i in range(int(math.ceil(math.log2(muxSize)))):
                    configBitsList.append(
                        f"{' ':<4}.S{i}(ConfigBits[{oldConfigBitstreamPosition}+{i}]),")
                    configBitsList.append(
                        f"{' ':<4}.S{i}N(ConfigBits[{oldConfigBitstreamPosition}+{i}]),")

        outSignal = f"{' ':<4}.X({portName})"

        delayString = delayTemplate.format(portName=portName,
                                           portList=", ".join(portList),
                                           delay=delay)
        muxString = muxTemplate.format(portName=portName,
                                       muxSize=muxSize,
                                       muxComponentName=muxComponentName,
                                       inputList="\n".join(inputList),
                                       configBitsList="\n".join(
                                           configBitsList),
                                       outSignal=outSignal)
        self._add(delayString)
        if (MultiplexerStyle == 'custom'):
            self._add(muxString)
            if muxSize != 2 and muxSize != 4 and muxSize != 8 and muxSize != 16:
                print(
                    f"HINT: creating a MUX-{str(muxSize)} for port {portName} using MUX-{muxSize} in switch matrix for tile {tileName}")
        else:
            # generic multiplexer
            self._add(
                f"assign {portName} = {portName}_input[ConfigBits[{configBitstreamPosition-1}:{oldConfigBitstreamPosition}]];")

        self.addNewLine()

    def addLatch(self, frameName, frameBitsPerRow, frameIndex, configBit):
        latchTemplate = """
LHQD1 Inst_{frameName}_bit{frameBitsPerRow} (
    .D(FrameData[{frameBitsPerRow}]),
    .E(FrameStrobe[{frame}]),
    .Q(ConfigBits[{configBit}]),
    .QN(ConfigBits[{configBit}])
);
    """
        self._add(latchTemplate.format(frameName=frameName,
                                       frameBitsPerRow=frameBitsPerRow,
                                       frame=frameIndex,
                                       configBit=configBit))


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
