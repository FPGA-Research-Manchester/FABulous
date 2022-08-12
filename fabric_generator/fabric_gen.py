#!/bin/env python3
# Copyright 2021 University of Manchester
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

import re
import math
import os
import numpy
import pickle
import csv
from code_generation_VHDL import VHDLWriter
from code_generation_Verilog import VerilogWriter
from fasm import *  # Remove this line if you do not have the fasm library installed and will not be generating a bitstream
import argparse
from code_generator import codeGenerator
from typing import List, Tuple

from fabric import Fabric, Tile, Port, SuperTile, ConfigMem
from file_parser import parseFabricCSV, parseMatrix, parseConfigMem
from model_generation_npnr import *
from model_generation_vpr import *


def BootstrapSwitchMatrix(fabric: Fabric):
    for tile in fabric.tileDic:
        print(
            f"### generate csv for {tile} # filename: {tile}_switch_matrix.csv")
        with open(f"{tile}_switch_matrix.csv", "w") as f:
            writer = csv.writer(f)
            sourceName, destName = [], []
            # normal wire
            for i in fabric.tileDic[tile].portsInfo:
                if i.wireDirection != "JUMP":
                    input, output = i.expandPortInfo("AutoSwitchMatrix")
                    sourceName += input
                    destName += output
            # bel wire
            for b in fabric.tileDic[tile].bels:
                for p in b.inputs:
                    sourceName.append(f"{p}")
                for p in b.outputs:
                    destName.append(f"{p}")

            # jump wire
            for i in fabric.tileDic[tile].portsInfo:
                if i.wireDirection == "JUMP":
                    input, output = i.expandPortInfo("AutoSwitchMatrix")
                    sourceName += input
                    destName += output
            sourceName = list(dict.fromkeys(sourceName))
            destName = list(dict.fromkeys(destName))
            writer.writerow([tile] + destName)
            for p in sourceName:
                writer.writerow([p] + [0] * len(destName))


def list2CSV(InFileName, OutFileName):
    # this function is export a given list description into its equivalent CSV switch matrix description
    # format: source,destination (per line)
    # read CSV file into an array of strings

    print(f"### Adding {InFileName} to {OutFileName}")

    connectionPair = parseList(InFileName)

    with open(OutFileName, "r") as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
        file = file.split("\n")

    col = len(file[0].split(','))
    rows = len(file)

    # create a 0 zero matrix as initialization
    matrix = [[0 for _ in range(col)] for _ in range(rows)]

    # load the data from the original csv into the matrix
    for i in range(1, len(file)):
        for j in range(1, len(file[i].split(','))):
            value = file[i].split(',')[j]
            if value == "":
                continue
            matrix[i-1][j-1] = int(value)

    # get source and destination list in the csv
    destination = file[0].strip("\n").split(',')[1:]
    source = [file[i].split(",")[0] for i in range(1, len(file))]

    # set the matrix value with the provided connection pair
    for (s, d) in connectionPair:
        try:
            s_index = source.index(s)
        except ValueError:
            print(f"{s} is not in the source column of the matrix csv file")
            print()
            exit(-1)

        try:
            d_index = destination.index(d)
        except ValueError:
            print(f"{d} is not in the destination row of the matrix csv file")
            print()
            exit(-1)

        if matrix[s_index][d_index] != 0:
            print(
                f"connection ({s}, {d}) already exists in the original matrix")
        matrix[s_index][d_index] = 1

    # writing the matrix back to the given out file
    with open(OutFileName, "w") as f:
        f.write(file[0] + "\n")
        for i in range(len(source)):
            f.write(f"{source[i]},")
            for j in range(len(destination)):
                f.write(str(matrix[i][j]))
                if j != len(destination) - 1:
                    f.write(',')
                else:
                    f.write(f",#,{matrix[i].count(1)}")
            f.write('\n')
        colCount = []
        for j in range(col):
            count = 0
            for i in range(rows):
                if matrix[i][j] == 1:
                    count += 1
            # if j != col - 1:
            #     f.write(str(count) + ',')
            colCount.append(str(count))
        f.write(f"#,{','.join(colCount)}")
    print("\n")


def CSV2list(InFileName, OutFileName):
    # this function is export a given CSV switch matrix description into its equivalent list description
    # format: destination,source (per line)
    # read CSV file into an array of strings
    InFile = [i.strip('\n').split(',') for i in open(InFileName)]
    f = open(OutFileName, 'w')
    rows = len(InFile)      # get the number of tiles in vertical direction
    cols = len(InFile[0])    # get the number of tiles in horizontal direction
    # top-left should be the name
    print('#', InFile[0][0], file=f)
    # switch matrix inputs
    inputs = []
    for item in InFile[0][1:]:
        inputs.append(item)
    # beginning from the second line, write out the list
    for line in InFile[1:]:
        for i in range(1, cols):
            if line[i] != '0':
                # it is [i-1] because the beginning of the line is the destination port
                print(line[0]+','+inputs[i-1], file=f)
    f.close()
    return


def generateConfigMem(tile: Tile, configMemCsv, writer: codeGenerator):
    # need to find a better way to handle data that is generated during the flow
    # get switch matrix configuration bits

    configBit = 0
    with open(tile.matrixDir, "r") as f:
        f = f.read()
        if configBit := re.search(r"NumberOfConfigBits: (\d+)", f):
            configBit = int(configBit.group(1))
            tile.globalConfigBits += configBit

    # we use a file to describe the exact configuration bits to frame mapping
    # the following command generates an init file with a simple enumerated default mapping (e.g. 'LUT4AB_ConfigMem.init.csv')
    # if we run this function again, but have such a file (without the .init), then that mapping will be used

    # test if we have a bitstream mapping file
    # if not, we will take the default, which was passed on from GenerateConfigMemInit
    configMemList: List[ConfigMem] = []
    if os.path.exists(configMemCsv):
        print(
            f"# found bitstream mapping file {tile.name}.csv for tile {tile.name}")
        configMemList = parseConfigMem(
            configMemCsv, MaxFramesPerCol, FrameBitsPerRow, tile.globalConfigBits)

    else:
        generateConfigMemInit(
            f"{tile.name}_ConfigMem.init.csv", tile.globalConfigBits)
        configMemList = parseConfigMem(
            f"{tile.name}_ConfigMem.init.csv", MaxFramesPerCol, FrameBitsPerRow, tile.globalConfigBits)

    # write entity
    entity = f"{tile.name}_ConfigMem"
    writer.addHeader(f"{tile.name}_ConfigMem")
    writer.addParameterStart(indentLevel=1)
    if MaxFramesPerCol != 0:
        writer.addParameter("MaxFramesPerCol", "integer",
                            MaxFramesPerCol, indentLevel=2)
    if FrameBitsPerRow != 0:
        writer.addParameter("FrameBitsPerRow", "integer",
                            FrameBitsPerRow, indentLevel=2)
    writer.addParameter("NoConfigBits", "integer",
                        tile.globalConfigBits, end=True, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)
    # the port definitions are generic
    writer.addPortVector(
        "FrameData", "in", "FrameBitsPerRow - 1", indentLevel=2)
    writer.addPortVector("FrameStrobe", "in",
                         "MaxFramesPerCol - 1", indentLevel=2)
    writer.addPortVector("ConfigBits", "out",
                         "NoConfigBits - 1", indentLevel=2)
    writer.addPortVector("ConfigBits_N", "out",
                         "NoConfigBits - 1", end=True, indentLevel=2)
    writer.addPortEnd(indentLevel=1)
    writer.addHeaderEnd(f"{tile.name}_ConfigMem")
    writer.addNewLine()
    # declare architecture
    writer.addDesignDescriptionStart(f"{tile.name}_ConfigMem")

    writer.addLogicStart()
    # instantiate latches for only the used frame bits
    for i in configMemList:
        if i.usedBitMask.count("1") > 0:
            writer.addConnectionVector(i.frameName, f"{i.bitsUsedInFrame}-1")

    writer.addNewLine()
    writer.addNewLine()
    writer.addComment("instantiate frame latches", end="")
    for i in configMemList:
        counter = 0
        for k in range(FrameBitsPerRow):
            if i.usedBitMask[k] == "1":
                writer.addInstantiation(compName="LHQD1",
                                        compInsName=f"Inst_{i.frameName}_bit{FrameBitsPerRow-1-k}",
                                        compPort=["D", "E", "Q", "QN"],
                                        signal=[f"FrameData[{FrameBitsPerRow-1-k}]",
                                                f"FrameStrobe[{i.frameIndex}]",
                                                f"ConfigBits[{i.configBitRanges[counter]}]",
                                                f"ConfigBits[{i.configBitRanges[counter]}]"])
                counter += 1

    writer.addLogicEnd()
    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def genTileSwitchMatrix(tile: Tile, csvFile: str, writer: codeGenerator) -> None:
    print(f"### Read {tile.name} csv file ###")

    # convert the matrix to a dictionary map and performs entry check
    connections = parseMatrix(csvFile, tile.name)
    globalConfigBitsCounter = 0
    for portName in connections:
        muxSize = len(connections[portName])
        if muxSize >= 2:
            globalConfigBitsCounter += int(math.ceil(math.log2(muxSize)))
    tile.globalConfigBits = globalConfigBitsCounter
    # we pass the NumberOfConfigBits as a comment in the beginning of the file.
    # This simplifies it to generate the configuration port only if needed later when building the fabric where we are only working with the VHDL files

    # VHDL header
    writer.addComment(
        f"NumberOfConfigBits: {globalConfigBitsCounter}")
    writer.addHeader(f"{tile.name}_switch_matrix")
    writer.addParameterStart(indentLevel=1)
    writer.addParameter("NoConfigBits", "integer",
                        tile.globalConfigBits, end=True, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)
    sourceName, destName = [], []
    # normal wire
    for i in tile.portsInfo:
        if i.wireDirection != "JUMP":
            input, output = i.expandPortInfo("AutoSwitchMatrix")
            sourceName += input
            destName += output
    # bel wire
    for b in tile.bels:
        for p in b.inputs:
            sourceName.append(f"{p}")
        for p in b.outputs:
            destName.append(f"{p}")

    # jump wire
    for i in tile.portsInfo:
        if i.wireDirection == "JUMP":
            input, output = i.expandPortInfo("AutoSwitchMatrix")
            sourceName += input
            destName += output
    sourceName = list(dict.fromkeys(sourceName))
    destName = list(dict.fromkeys(destName))

    for port in sourceName:
        if "GND" in port or "VCC" in port:
            continue
        writer.addPortScalar(port, "in", indentLevel=2)
    for port in destName:
        if "GND" in port or "VCC" in port:
            continue
        writer.addPortScalar(port, "out", indentLevel=2)
    writer.addComment("global", onNewLine=True)
    if tile.globalConfigBits > 0:
        if ConfigBitMode == "FlipFlopChain":
            writer.addPortScalar("MODE", "in", indentLevel=2)
            writer.addComment("global signal 1: configuration, 0: operation")
            writer.addPortScalar("CONFin", "in", indentLevel=2)
            writer.addPortScalar("CONFout", "out", indentLevel=2)
            writer.addPortScalar("CLK", "in", indentLevel=2)
        if ConfigBitMode == "frame_based":
            writer.addPortVector("ConfigBits", "in",
                                 "NoConfigBits-1", indentLevel=2)
            writer.addPortVector("ConfigBits_N", "in",
                                 "NoConfigBits-1", end=True, indentLevel=2)
    writer.addPortEnd()
    writer.addHeaderEnd(f"{tile.name}_switch_matrix")
    writer.addDesignDescriptionStart(f"{tile.name}_switch_matrix")

    # constant declaration
    # we may use the following in the switch matrix for providing '0' and '1' to a mux input:
    writer.addConstant("GND0", 0)
    writer.addConstant("GND", 0)
    writer.addConstant("VCC0", 1)
    writer.addConstant("VCC", 1)
    writer.addConstant("VDD0", 1)
    writer.addConstant("VDD", 1)
    writer.addNewLine()

    # signal declaration
    for portName in connections:
        writer.addConnectionVector(
            f"{portName}_input", f"{len(connections[portName])}-1")

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        writer.addNewLine()
        for portName in connections:
            muxSize = len(connections[portName])
            if muxSize >= 2:
                writer.addConnectionVector(
                    f"DEBUG_select_{portName}", f"{int(math.ceil(math.log2(muxSize)))}-1")
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    writer.addComment(
        "The configuration bits (if any) are just a long shift register", onNewLine=True)
    writer.addComment(
        "This shift register is padded to an even number of flops/latches", onNewLine=True)

    # we are only generate configuration bits, if we really need configurations bits
    # for example in terminating switch matrices at the fabric borders, we may just change direction without any switching
    if globalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            writer.addConnectionVector("ConfigBits", globalConfigBitsCounter)
        if ConfigBitMode == 'FlipFlopChain':
            # print('DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG ConfigBitMode == FlipFlopChain')
            # we pad to an even number of bits: (int(math.ceil(ConfigBitCounter/2.0))*2)
            writer.addConnectionVector("ConfigBits", int(
                math.ceil(globalConfigBitsCounter/2.0))*2)
            writer.addConnectionVector("ConfigBitsInput", int(
                math.ceil(globalConfigBitsCounter/2.0))*2)

    # begin architecture
    writer.addLogicStart()

    # the configuration bits shift register
    # again, we add this only if needed
    if globalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            writer.addShiftRegister(globalConfigBitsCounter)

        elif ConfigBitMode == 'FlipFlopChain':
            writer.addFlipFlopChain(globalConfigBitsCounter)
        elif ConfigBitMode == 'frame_based':
            pass
        else:
            raise ValueError(f"{ConfigBitMode} is not a valid ConfigBitMode")

    # the switch matrix implementation
    # we use the following variable to count the configuration bits of a long shift register which actually holds the switch matrix configuration
    configBitstreamPosition = 0
    for portName in connections:
        muxSize = len(connections[portName])
        writer.addComment(
            f"switch matrix multiplexer {portName} MUX-{muxSize}", onNewLine=True)
        if muxSize == 0:
            print(
                f"WARNING: input port {portName} of switch matrix in Tile {tile.name} is not used")
            writer.addComment(
                f"WARNING unused multiplexer MUX-{portName}", onNewLine=True)

        elif muxSize == 1:
            # just route through : can be used for auxiliary wires or diagonal routing (Manhattan, just go to a switch matrix when turning
            # can also be used to tap a wire. A double with a mid is nothing else as a single cascaded with another single where the second single has only one '1' to cascade from the first single
            if connections[portName][0] == '0':
                writer.addAssignScalar(portName, 0)
            elif connections[portName][0] == '1':
                writer.addAssignScalar(portName, 1)
            else:
                writer.addAssignScalar(portName, connections[portName][0])
            writer.addNewLine()
        elif muxSize >= 2:
            # this is the case for a configurable switch matrix multiplexer
            old_ConfigBitstreamPosition = configBitstreamPosition
            # math.ceil(math.log2(len(connections[k]))) tells us how many configuration bits a multiplexer takes
            configBitstreamPosition += (
                math.ceil(math.log2(len(connections[portName]))))
            # the reversed() changes the direction that we iterate over the line list.
            # Changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
            # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
            numGnd = 0
            muxComponentName = ""
            if (MultiplexerStyle == 'custom') and (muxSize == 2):
                muxComponentName = 'my_mux2'
            elif (MultiplexerStyle == 'custom') and (2 < muxSize <= 4):
                muxComponentName = 'cus_mux41_buf'
                numGnd = 4-muxSize
            elif (MultiplexerStyle == 'custom') and (4 < muxSize <= 8):
                muxComponentName = 'cus_mux81_buf'
                numGnd = 8-muxSize
            elif (MultiplexerStyle == 'custom') and (8 < muxSize <= 16):
                muxComponentName = 'cus_mux161_buf'
                numGnd = 16-muxSize

            portList, signalList = [], []
            start = 0
            for start in range(muxSize):
                portList.append(f"A{start}")
                signalList.append(f"{portName}_input[{start}]")

            for end in range(start, numGnd):
                portList.append(f"A{end}")
                signalList.append(f"GND0")

            if MultiplexerStyle == "custom":
                if muxSize == 2:
                    portList.append(f"S{portName}")
                    signalList.append(
                        f"ConfigBits[{old_ConfigBitstreamPosition}+{portName}]")
                else:
                    for i in range(int(math.ceil(math.log2(muxSize)))):
                        portList.append(f"S{i}")
                        portList.append(f"S{i}N")
                        signalList.append(
                            f"ConfigBits[{old_ConfigBitstreamPosition}+{i}]")
                        signalList.append(
                            f"ConfigBits[{old_ConfigBitstreamPosition}+{i}]")

            portList.append("X")
            signalList.append(f"{portName}")

            if (MultiplexerStyle == 'custom'):
                writer.addAssignScalar(f"{portName}_input", list(reversed(
                    connections[portName])), int(GenerateDelayInSwitchMatrix))
                writer.addInstantiation(compName=muxComponentName,
                                        compInsName=f"inst_{muxComponentName}",
                                        compPort=portList,
                                        signal=signalList)
                if muxSize != 2 and muxSize != 4 and muxSize != 8 and muxSize != 16:
                    print(
                        f"HINT: creating a MUX-{str(muxSize)} for port {portName} using MUX-{muxSize} in switch matrix for tile {tile.name}")
            else:
                # generic multiplexer
                writer.addAssignScalar(
                    portName, f"{portName}_input[ConfigBits[{configBitstreamPosition-1}:{old_ConfigBitstreamPosition}]]")

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        writer.addNewLine()
        configBitstreamPosition = 0
        for portName in connections:
            muxSize = len(connections[portName])
            if muxSize >= 2:
                old_ConfigBitstreamPosition = configBitstreamPosition
                configBitstreamPosition += int(math.ceil(math.log2(muxSize)))
                writer.addAssignVector(
                    f"DEBUG_select_{portName:<15}", "ConfigBits", configBitstreamPosition-1, old_ConfigBitstreamPosition)

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

    # just the final end of architecture

    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def generateTile(tile: Tile, writer: codeGenerator):
    allJumpWireList = []
    numberOfSwitchMatricesWithConfigPort = 0

    # We first check if we need a configuration port
    # Currently we assume that each primitive needs a configuration port
    # However, a switch matrix can have no switch matrix multiplexers
    # (e.g., when only bouncing back in border termination tiles)
    # we can detect this as each switch matrix file contains a comment -- NumberOfConfigBits
    # NumberOfConfigBits:0 tells us that the switch matrix does not have a config port
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning

    # TODO: require refactoring
    # get switch matrix configuration bits
    configBit = 0
    with open(tile.matrixDir, "r") as f:
        f = f.read()
        if configBit := re.search(r"NumberOfConfigBits: (\d+)", f):
            configBit = int(configBit.group(1))
            tile.globalConfigBits += configBit

    # GenerateVHDL_Header(file, entity, NoConfigBits=str(GlobalConfigBitsCounter))
    writer.addHeader(f"{tile.name}")
    writer.addParameterStart(indentLevel=1)
    writer.addParameter("MaxFramesPerCol", "integer",
                        MaxFramesPerCol, indentLevel=2)
    writer.addParameter("FrameBitsPerRow", "integer",
                        FrameBitsPerRow, indentLevel=2)
    writer.addParameter("NoConfigBits", "integer",
                        tile.globalConfigBits, end=True, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)

    commentTemplate = "wires:{wires} X_offset:{X_offset} Y_offset:{Y_offset} source_name:{sourceName} destination_name:{destinationName}"
    # holder for each direction of port string
    portList = [tile.getNorthSidePorts(), tile.getEastSidePorts(),
                tile.getWestSidePorts(), tile.getSouthSidePorts()]
    for l in portList:
        if not l:
            continue
        writer.addComment(l[0].sideOfTile, onNewLine=True)
        # destination port are input to the tile
        # source port are output of the tile
        for p in l:
            if p.sourceName != "NULL":
                wireSize = (abs(p.xOffset)+abs(p.yOffset)) * p.wires-1
                writer.addPortVector(p.name, p.inOut,
                                     wireSize, indentLevel=2)
                writer.addComment(str(p), indentLevel=2, onNewLine=False)

    # now we have to scan all BELs if they use external pins, because they have to be exported to the tile entity
    externalPorts = []
    for i in tile.bels:
        for p in i.externalInput:
            writer.addPortScalar(i.name, "in", indentLevel=2)
        for p in i.externalOutput:
            writer.addPortScalar(i.name, "out", indentLevel=2)
        externalPorts += i.externalInput
        externalPorts += i.externalOutput

    # if we found BELs with top-level IO ports, we just pass them through
    sharedExternalPorts = set()
    for i in tile.bels:
        sharedExternalPorts.update(i.sharedPort)

    writer.addComment("Tile IO ports from BELs", onNewLine=True, indentLevel=1)

    if not tile.withUserCLK:
        writer.addPortScalar("UserCLKo", "out", indentLevel=2)
    else:
        writer.addPortScalar("UserCLK", "in", indentLevel=2)
        writer.addPortScalar("UserCLKo", "out", indentLevel=2)

    if ConfigBitMode == "frame_based":
        if tile.globalConfigBits > 0:
            writer.addPortVector(
                "FrameData", "in", "FrameBitsPerRow -1", indentLevel=2)
            writer.addComment("CONFIG_PORT", onNewLine=False, end="")
            writer.addPortVector("FrameData_O", "out",
                                 "FrameBitsPerRow -1", indentLevel=2)
            writer.addPortVector("FrameStrobe", "in",
                                 "MaxFramesPerCol -1", indentLevel=2)
            writer.addComment("CONFIG_PORT", onNewLine=False, end="")
            writer.addPortVector("FrameStrobe_O", "out",
                                 "MaxFramesPerCol -1", end=True, indentLevel=2)
        else:
            writer.addPortVector("FrameStrobe", "in",
                                 "MaxFramesPerCol -1", indentLevel=2)
            writer.addPortVector("FrameStrobe_O", "out",
                                 "MaxFramesPerCol -1", end=True, indentLevel=2)

    elif ConfigBitMode == "FlipFlopChain":
        writer.addPortScalar("MODE", "in", indentLevel=2)
        writer.addPortScalar("CONFin", "in", indentLevel=2)
        writer.addPortScalar("CONFout", "out", indentLevel=2)
        writer.addPortScalar("CLK", "in", end=True, indentLevel=2)

    writer.addComment("global", onNewLine=True, indentLevel=1)

    writer.addPortEnd()
    writer.addHeaderEnd(f"{tile.name}")
    writer.addDesignDescriptionStart(f"{tile.name}")

    # insert CLB, I/O (or whatever BEL) component declaration
    # specified in the fabric csv file after the 'BEL' key word
    # we use this list to check if we have seen a BEL description before so we only insert one component declaration
    BEL_VHDL_riles_processed = []
    for i in tile.bels:
        if i.src not in BEL_VHDL_riles_processed:
            BEL_VHDL_riles_processed.append(i.src)
            writer.addComponentDeclarationForFile(i.src)

    # insert switch matrix component declaration
    # specified in the fabric csv file after the 'MATRIX' key word
    if os.path.exists(tile.matrixDir):
        numberOfSwitchMatricesWithConfigPort += writer.addComponentDeclarationForFile(
            tile.matrixDir)
    else:
        raise ValueError(
            f"Could not find switch matrix definition for tile type {tile.name} in function GenerateTileVHDL")

    if ConfigBitMode == 'frame_based' and tile.globalConfigBits > 0:
        writer.addComponentDeclarationForFile(f"{tile.name}_ConfigMem.vhdl")

    # VHDL signal declarations
    writer.addComment("signal declarations", onNewLine=True)
    # BEL port wires
    writer.addComment("BEL ports (e.g., slices)", onNewLine=True)
    repeatDeclaration = set()
    for bel in tile.bels:
        for i in bel.inputs + bel.outputs:
            if f"{i}" not in repeatDeclaration:
                writer.addConnectionScalar(i)
                repeatDeclaration.add(f"{bel.prefix}{i}")

    # Jump wires
    writer.addComment("Jump wires", onNewLine=True)
    for p in tile.portsInfo:
        if p.wireDirection == "JUMP":
            if p.sourceName != "NULL" and p.destinationName != "NULL" and p.inOut == "OUT":
                writer.addConnectionVector(p.name, f"{p.wires}-1")

            for k in range(p.wires):
                allJumpWireList.append(f"{p.name}( {k} )")

    # internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
    writer.addComment(
        "internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)", onNewLine=True)

    # the signal has to be number of BELs+2 bits wide (Bel_counter+1 downto 0)
    # we chain switch matrices only to the configuration port, if they really contain configuration bits
    # i.e. switch matrices have a config port which is indicated by "NumberOfConfigBits:0 is false"

    # The following conditional as intended to only generate the config_data signal if really anything is actually configured
    # however, we leave it and just use this signal as conf_data(0 downto 0) for simply touting through CONFin to CONFout
    # maybe even useful if we want to add a buffer here

    # TODO the following section is hardcoded due to variance in VHDL implementation and Verilog implementation
    if tile.globalConfigBits > 0:
        writer.addConnectionVector("ConfigBits", "NoConfigBits-1", 0)
        writer.addConnectionVector("ConfigBits_N", "NoConfigBits-1", 0)

        writer.addNewLine()
        writer.addConnectionVector("FrameData_i", "FrameBitsPerRow-1", 0)
        writer.addConnectionVector("FrameData_O_i", "FrameBitsPerRow-1", 0)
        writer.addAssignScalar("FrameData_O_i", "FrameData_i")
        writer.addNewLine()
        for i in range(FrameBitsPerRow):
            writer.addInstantiation("my_buf",
                                    f"data_inbuf_{i}",
                                    ["A", "X"],
                                    [f"frameData[{i}]", f"frameData_i[{i}]"])
        for i in range(FrameBitsPerRow):
            writer.addInstantiation("my_buf",
                                    f"data_outbuf_{i}",
                                    ["A", "X"],
                                    [f"frameData_O_i[{i}]", f"frameData_O[{i}]"])

    # strobe is always added even when config bits are 0
    writer.addNewLine()
    writer.addConnectionVector("FrameStrobe_i", "MaxFramesPerCol-1", 0)
    writer.addConnectionVector(
        "FrameStrobe_O_i", "MaxFramesPerCol-1", 0)
    writer.addAssignScalar("FrameStrobe_O_i", "FrameStrobe_i")
    writer.addNewLine()
    for i in range(MaxFramesPerCol):
        writer.addInstantiation("my_buf",
                                f"strobe_inbuf_{i}",
                                ["A", "X"],
                                [f"FrameStrobe[{i}]", f"FrameStrobe_i[{i}]"])
    for i in range(MaxFramesPerCol):
        writer.addInstantiation("my_buf",
                                f"strobe_outbuf_{i}",
                                ["A", "X"],
                                [f"FrameStrobe_O_i[{i}]", f"FrameStrobe_O[{i}]"])

    added = set()
    for port in tile.portsInfo:
        span = abs(port.xOffset) + abs(port.yOffset)
        if (port.sourceName, port.destinationName) in added:
            continue
        if span >= 2 and port.sourceName != "NULL" and port.destinationName != "NULL":
            highBoundIndex = span*port.wires - 1
            writer.addConnectionVector(
                f"{port.destinationName}_i", highBoundIndex)
            writer.addConnectionVector(
                f"{port.sourceName}_i", highBoundIndex - port.wires)
            # using scalar assignment to connect the two vectors
            writer.addAssignScalar(
                f"{port.destinationName}_i[{highBoundIndex}-{port.wires}:0]", f"{port.destinationName}_i[{highBoundIndex}:{port.wires}]")
            writer.addNewLine()
            for i in range(highBoundIndex - port.wires + 1):
                writer.addInstantiation("my_buf",
                                        f"{port.destinationName}_inbuf_{i}",
                                        ["A", "X"],
                                        [f"{port.destinationName}[{i+port.wires}]", f"{port.destinationName}_i[{i+port.wires}]"])
            for i in range(highBoundIndex - port.wires + 1):
                writer.addInstantiation("my_buf",
                                        f"{port.sourceName}_outbuf_{i}",
                                        ["A", "X"],
                                        [f"{port.sourceName}_i[{i}]",
                                            f"{port.sourceName}[{i}]"])
            added.add((port.sourceName, port.destinationName))

    if tile.withUserCLK:
        writer.addInstantiation("clk_buf",
                                f"inst_clk_buf",
                                ["A", "X"],
                                [f"UserCLK", f"UserCLKo"])

    writer.addNewLine()
    # top configuration data daisy chaining
    if ConfigBitMode == 'FlipFlopChain':
        writer.addComment(
            "top configuration data daisy chaining", onNewLine=True)
        writer.addAssignScalar("conf_data(conf_data'low)", "CONFin")
        writer.addComment("conf_data'low=0 and CONFin is from tile entity")
        writer.addAssignScalar("conf_data(conf_data'high)", "CONFout")
        writer.addComment("CONFout is from tile entity")

    # the <entity>_ConfigMem module is only parametrized through generics, so we hard code its instantiation here
    if ConfigBitMode == 'frame_based' and tile.globalConfigBits > 0:
        writer.addComment("configuration storage latches", onNewLine=True)
        writer.addInstantiation(compName=f"{tile.name}_ConfigMem",
                                compInsName=f"Inst_{tile.name}_ConfigMem",
                                compPort=["FrameData",
                                          "FrameStrobe", "ConfigBits", "ConfigBits_N"],
                                signal=["FrameData", "FrameStrobe", "COnfigBits", "ConfigBits_N"])

    # BEL component instantiations
    writer.addComment("BEL component instantiations", onNewLine=True)
    belCounter = 0
    belConfigBitsCounter = 0
    for b in tile.bels:
        writer.addBELInstantiations(
            b, belConfigBitsCounter, ConfigBitMode, belCounter)
        belConfigBitsCounter += b.configBit
        # for the next BEL (if any) for cascading configuration chain (this information is also needed for chaining the switch matrix)
        belCounter += 1

    # switch matrix component instantiation
    # important to know:
    # Each switch matrix entity is build up is a specific order:
    # 1.a) interconnect wire INPUTS (in the order defined by the fabric file,)
    # 2.a) BEL primitive INPUTS (in the order the BEL-VHDLs are listed in the fabric CSV)
    #      within each BEL, the order from the entity is maintained
    #      Note that INPUTS refers to the view of the switch matrix! Which corresponds to BEL outputs at the actual BEL
    # 3.a) JUMP wire INPUTS (in the order defined by the fabric file)
    # 1.b) interconnect wire OUTPUTS
    # 2.b) BEL primitive OUTPUTS
    #      Again: OUTPUTS refers to the view of the switch matrix which corresponds to BEL inputs at the actual BEL
    # 3.b) JUMP wire OUTPUTS
    # The switch matrix uses single bit ports (std_logic and not std_logic_vector)!!!

    switchMatrixConfigPort = 5
    portInputIndexed = []
    portOutputIndexed = []
    portTopInput = []
    portTopOutputs = []
    jumpWire = []
    sourceName, destName = [], []
    # normal wire
    for i in tile.portsInfo:
        if i.wireDirection != "JUMP":
            input, output = i.expandPortInfo("AutoSwitchMatrix")
            sourceName += input
            destName += output
    # bel wire
    for b in tile.bels:
        for p in b.inputs:
            sourceName.append(f"{p}")
        for p in b.outputs:
            destName.append(f"{p}")

    # jump wire
    for i in tile.portsInfo:
        if i.wireDirection == "JUMP":
            input, output = i.expandPortInfo("AutoSwitchMatrix")
            sourceName += input
            destName += output
    sourceName = list(dict.fromkeys(sourceName))
    destName = list(dict.fromkeys(destName))
    # get indexed version of the port of the tile
    for p in tile.portsInfo:
        if p.wireDirection != "JUMP":
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
    # removing duplicates
    portOutputIndexed = list(dict.fromkeys(portOutputIndexed))
    portTopInput = list(dict.fromkeys(portTopInput))
    jumpWire = list(dict.fromkeys(jumpWire))
    for b in tile.bels:
        belOutputs += b.outputs
        belInputs += b.inputs

    portList = [i for i in (destName + sourceName)
                if "GND" not in i and "VCC" not in i]
    signal = portOutputIndexed + belOutputs + \
        jumpWire + portTopInput + belInputs + jumpWire

    configBit = ""
    if ConfigBitMode == "FlipFlopChain":
        portList.append("MODE")
        portList.append("CONFin")
        portList.append("CONFout")
        portList.append("CLK")
        signal.append("Mode")
        signal.append(f"conf_data[{belCounter}]")
        signal.append(f"conf_data[{belCounter+1}]")
        signal.append("CLK")
    if ConfigBitMode == "frame_based":
        if tile.globalConfigBits > 0:
            portList.append("ConfigBits")
            portList.append("ConfigBits_N")
            signal.append(
                f"ConfigBits[{tile.globalConfigBits}-1:{belConfigBitsCounter}]")
            signal.append(
                f"ConfigBits_N[{tile.globalConfigBits}-1:{belConfigBitsCounter}]")

    writer.addInstantiation(compName=f"{tile.name}_SwitchMatrix",
                            compInsName=f"Inst_{tile.name}_SwitchMatrix",
                            compPort=portList,
                            signal=signal)
    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def generateSuperTile(superTile: SuperTile, writer: codeGenerator):
    # for tile in tiles:
    #     with open(tile.matrixDir, "r") as f:
    #         f = f.read()
    #         if configBit := re.search(r"-- NumberOfConfigBits: (\d+)", f):
    #             configBit = int(configBit.group(1))
    #             tile.globalConfigBits += configBit

    # GenerateVHDL_Header(file, entity, NoConfigBits=str(GlobalConfigBitsCounter))
    writer.addHeader(f"{superTile.name}")
    writer.addParameterStart(indentLevel=1)
    writer.addParameter("MaxFramesPerCol", "integer",
                        MaxFramesPerCol, indentLevel=2)
    writer.addParameter("FrameBitsPerRow", "integer",
                        FrameBitsPerRow, indentLevel=2)
    writer.addParameter("NoConfigBits", "integer", 0, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)

    portsAround = superTile.getPortsAroundTile()

    for k, v in portsAround.items():
        if not v:
            continue
        x, y = k
        for pList in v:
            writer.addComment(
                f"Tile_X{x}Y{y}_{pList[0].wireDirection}", onNewLine=True, indentLevel=1)
            for p in pList:
                if p.sourceName == "NULL" or p.destinationName == "NULL":
                    continue
                wire = (abs(p.xOffset) + abs(p.yOffset)) * p.wires - 1
                writer.addPortVector(
                    f"Tile_X{x}Y{y}_{p.name}", p.inOut, wire, indentLevel=2)
                writer.addComment(str(p), onNewLine=False)

    # add tile external bel port
    writer.addComment("Tile IO ports from BELs", onNewLine=True, indentLevel=1)
    for i in superTile.tiles:
        for b in i.bels:
            for p in b.externalInput:
                writer.addPortScalar(p, "out", indentLevel=2)
            for p in b.externalOutput:
                writer.addPortScalar(p, "in", indentLevel=2)
            for p in b.sharedPort:
                writer.addPortScalar(p[0], p[1], indentLevel=2)

    # add config port
    if ConfigBitMode == "frame_based":
        for y, row in enumerate(superTile.tileMap):
            for x, tile in enumerate(row):
                if y - 1 < 0 or superTile.tileMap[y-1][x] == None:
                    writer.addPortVector(
                        f"Tile_X{x}Y{y}_FrameStrobe_O", "out", "MaxFramePerCol-1", indentLevel=2)
                    writer.addComment("CONFIG_PORT", onNewLine=False)
                if x + 1 >= len(superTile.tileMap[y]) or superTile.tileMap[y][x+1] == None:
                    writer.addPortVector(
                        f"Tile_X{x}Y{y}_FrameData_O", "out", "FrameBitsPerRow-1", indentLevel=2)
                    writer.addComment("CONFIG_PORT", onNewLine=False)
                if y + 1 >= len(superTile.tileMap) or superTile.tileMap[y+1][x] == None:
                    writer.addPortVector(
                        f"Tile_X{x}Y{y}_FrameStrobe", "in", "MaxFramePerCol-1", indentLevel=2)
                    writer.addComment("CONFIG_PORT", onNewLine=False)
                if x - 1 < 0 or superTile.tileMap[y][x-1] == None:
                    writer.addPortVector(
                        f"Tile_X{x}Y{y}_FrameData", "in", "FrameBitsPerRow-1", indentLevel=2)
                    writer.addComment("CONFIG_PORT", onNewLine=False)

    writer.addPortEnd()
    writer.addHeaderEnd(f"{superTile.name}")
    writer.addDesignDescriptionStart(f"{superTile.name}")
    writer.addNewLine()

    BEL_VHDL_riles_processed = []
    for t in superTile.tiles:
        # This is only relevant to VHDL code generation, will not affect Verilog code genration
        writer.addComponentDeclarationForFile(f"{t.name}_tile.vhdl")

    # find all internal connections
    internalConnections = superTile.getInternalConnections()

    # declare internal connections
    writer.addComment("signal declarations", onNewLine=True)
    for i, x, y in internalConnections:
        if i:
            writer.addComment(
                f"Tile_X{x}Y{y}_{i[0].wireDirection}", onNewLine=True)
            for p in i:
                if p.inOut == "OUT":
                    wire = (abs(p.xOffset) + abs(p.yOffset)) * p.wires - 1
                    writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_{p.name}", wire, indentLevel=1)
                    writer.addComment(str(p), onNewLine=False)

    # declare internal connections for frameData and frameStrobe
    for y, row in enumerate(superTile.tileMap):
        for x, tile in enumerate(row):
            if 0 <= y - 1 < len(superTile.tileMap) and superTile.tileMap[y-1][x] != None:
                writer.addConnectionVector(
                    f"Tile_X{x}Y{y}_FrameStrobe_O", "MaxFramePerCol-1", indentLevel=1)
            if 0 <= x - 1 < len(superTile.tileMap) and superTile.tileMap[y][x-1] != None:
                writer.addConnectionVector(
                    f"Tile_X{x}Y{y}_FrameData_O", "FrameBitsPerRow-1", indentLevel=1)

    writer.addNewLine()
    # pair up the connection for tile instantiation

    for y, row in enumerate(superTile.tileMap):
        for x, tile in enumerate(row):
            northInput, southInput, eastInput, westInput = [], [], [], []
            outputSignalList = []
            if tile != None:
                # north input connection
                if 0 <= y + 1 < len(superTile.tileMap) and superTile.tileMap[y+1][x] != None:
                    for p in superTile.tileMap[y+1][x].getNorthPorts():
                        if p.sourceName != "NULL":
                            northInput.append(
                                f"Tile_X{x}Y{y+1}_{p.sourceName}")
                else:
                    for p in tile.getNorthPorts():
                        if p.destinationName != "NULL":
                            northInput.append(
                                f"Tile_X{x}Y{y}_{p.destinationName}")

                # east input connection
                if 0 <= x - 1 < len(superTile.tileMap[0]) and superTile.tileMap[y][x-1] != None:
                    for p in superTile.tileMap[y][x-1].getEastPorts():
                        if p.sourceName != "NULL":
                            eastInput.append(
                                f"Tile_X{x-1}Y{y}_{p.sourceName}")
                else:
                    for p in tile.getEastPorts():
                        if p.destinationName != "NULL":
                            eastInput.append(
                                f"Tile_X{x}Y{y}_{p.destinationName}")

                # south input connection
                if 0 <= y - 1 < len(superTile.tileMap) and superTile.tileMap[y-1][x] != None:
                    for p in superTile.tileMap[y-1][x].getSouthPorts():
                        if p.sourceName != "NULL":
                            southInput.append(
                                f"Tile_X{x}Y{y-1}_{p.sourceName}")
                else:
                    for p in tile.getSouthPorts():
                        if p.destinationName != "NULL":
                            southInput.append(
                                f"Tile_X{x}Y{y}_{p.destinationName}")

                # west input connection
                if 0 <= x + 1 < len(superTile.tileMap[0]) and superTile.tileMap[y][x+1] != None:
                    for p in superTile.tileMap[y][x+1].getWestPorts():
                        if p.sourceName != "NULL":
                            westInput.append(
                                f"Tile_X{x+1}Y{y}_{p.sourceName}")
                else:
                    for p in tile.getWestPorts():
                        if p.destinationName != "NULL":
                            westInput.append(
                                f"Tile_X{x}Y{y}_{p.destinationName}")

                for p in tile.getNorthPorts() + tile.getEastPorts() + tile.getSouthPorts() + tile.getWestPorts():
                    if p.sourceName != "NULL":
                        outputSignalList.append(
                            f"Tile_X{x}Y{y}_{p.sourceName}")

                combine = northInput + eastInput + southInput + westInput + outputSignalList

                writer.addComment(
                    "tile IO port will get directly connected to top-level tile module", onNewLine=True, indentLevel=1)
                for i in superTile.tiles:
                    for b in i.bels:
                        for p in b.externalInput:
                            combine.append(p)
                        for p in b.externalOutput:
                            combine.append(p)
                        for p in b.sharedPort:
                            combine.append(p[0])

                if ConfigBitMode == "frame_based":
                    # add connection for frameData and frameStrobe
                    if 0 <= x - 1 < len(superTile.tileMap[0]) - 1 and superTile.tileMap[y][x-1] != None:
                        combine.append(f"Tile_X{x-1}Y{y}_FrameData_O")
                    else:
                        combine.append(f"Tile_X{x}Y{y}_FrameData")

                    combine.append(f"Tile_X{x}Y{y}_FrameData_O")

                    if 0 <= y + 1 < len(superTile.tileMap) - 1 and superTile.tileMap[y+1][x] != None:
                        combine.append(
                            f"Tile_X{x}Y{y-1}_FrameStrobe_O")
                    else:
                        combine.append(f"Tile_X{x}Y{y}_FrameStrobe")

                    combine.append(f"Tile_X{x}Y{y}_FrameStrobe_O")

                ports = []
                # all the input port
                ports += [i.destinationName for i in tile.getNorthPorts()
                          if i.destinationName != "NULL"]
                ports += [i.destinationName for i in tile.getEastPorts()
                          if i.destinationName != "NULL"]
                ports += [i.destinationName for i in tile.getSouthPorts()
                          if i.destinationName != "NULL"]
                ports += [i.destinationName for i in tile.getWestPorts()
                          if i.destinationName != "NULL"]
                # all the output port
                ports += [i.sourceName for i in tile.getNorthPorts()
                          if i.sourceName != "NULL"]
                ports += [i.sourceName for i in tile.getEastPorts()
                          if i.sourceName != "NULL"]
                ports += [i.sourceName for i in tile.getSouthPorts()
                          if i.sourceName != "NULL"]
                ports += [i.sourceName for i in tile.getWestPorts()
                          if i.sourceName != "NULL"]

                for i in superTile.tiles:
                    for b in i.bels:
                        for p in b.externalInput:
                            ports.append(p)
                        for p in b.externalOutput:
                            ports.append(p)
                        for p in b.sharedPort:
                            ports.append(p[0])

                if ConfigBitMode == 'frame_based':
                    ports += ["FrameData", "FrameData_O",
                              "FrameStrobe", "FrameStrobe_O"]

                ports = list(dict.fromkeys(ports))
                combine = list(dict.fromkeys(combine))

                writer.addInstantiation(compName=tile.name,
                                        compInsName=f"Tile_X{x}Y{y}_{tile.name}",
                                        compPort=ports,
                                        signal=combine)
    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def generateFabric(fabric: Fabric, writer: codeGenerator):
    # There are of course many possibilities for generating the fabric.
    # I decided to generate a flat description as it may allow for a little easier debugging.
    # For larger fabrics, this may be an issue, but not for now.
    # We only have wires between two adjacent tiles in North, East, South, West direction.
    # So we use the output ports to generate wires.

    # we first scan all tiles if those have IOs that have to go to top
    # the order of this scan is later maintained when instantiating the actual tiles
    # header
    fabricName = "eFPGA"
    writer.addHeader(fabricName)
    writer.addParameterStart(indentLevel=1)
    writer.addParameter("MaxFramesPerCol", "integer",
                        fabric.maxFramesPerCol, indentLevel=2)
    writer.addParameter("FrameBitsPerRow", "integer",
                        fabric.frameBitsPerRow, indentLevel=2)
    writer.addParameter("NoConfigBits", "integer", 0, end=True, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)
    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile != None:
                for bel in tile.bels:
                    for i in bel.externalInput:
                        writer.addPortScalar(
                            f"Tile_X{x}Y{y}_{i}", "in", indentLevel=2)
                        writer.addComment("EXTERNAL", onNewLine=False)
                    for i in bel.externalOutput:
                        writer.addPortScalar(
                            f"Tile_X{x}Y{y}_{i}", "out", indentLevel=2)
                        writer.addComment("EXTERNAL", onNewLine=False)

    if fabric.configBitMode == "frame_based":
        writer.addPortVector(
            "FrameData", "in", f"(FrameBitsPerRow{len(fabric.tile[0])})-1", indentLevel=2)
        writer.addComment("CONFIG_PORT", onNewLine=False)
        writer.addPortVector(
            "FrameData_O", "out", f"(FrameBitsPerRow{len(fabric.tile[0])})-1", indentLevel=2)
        writer.addPortVector(
            "FrameStrobe", "in", f"(MaxFramesPerCol*{len(fabric.tile)})", indentLevel=2)
        writer.addComment("CONFIG_PORT", onNewLine=False)
        writer.addPortVector(
            "FrameStrobe_O", "out", f"(MaxFramesPerCol*{len(fabric.tile)})", end=True, indentLevel=2)

    writer.addPortScalar("UserCLK", "in", indentLevel=2)

    writer.addPortEnd()
    writer.addHeaderEnd(fabricName)
    writer.addDesignDescriptionStart(fabricName)
    writer.addNewLine()

    # TODO refactor
    for t in fabric.tileDic:
        writer.addComponentDeclarationForFile(f"{t}_tile.vhdl")

    # VHDL signal declarations
    writer.addComment("signal declarations", onNewLine=True, end="\n")

    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile != None:
                writer.addConnectionScalar(f"Tile_X{x}Y{y}_UserCLKo")

    writer.addComment("configuration signal declarations",
                      onNewLine=True, end="\n")

    if fabric.configBitMode == 'FlipFlopChain':
        tileCounter = 0
        for row in fabric.tile:
            for t in row:
                if t != None:
                    tileCounter += 1
        writer.addConnectionVector("conf_data", tileCounter)

    if fabric.configBitMode == 'frame_based':
        # FrameData       =>     Tile_Y3_FrameData,
        # FrameStrobe      =>     Tile_X1_FrameStrobe
        # MaxFramesPerCol : integer := 20;
        # FrameBitsPerRow : integer := 32;
        for y in range(1, len(fabric.tile)-1):
            writer.addConnectionVector(
                f"Tile_Y{y}_FrameData", "FrameBitsPerRow -1")

        for x in range(len(fabric.tile[0])):
            writer.addConnectionVector(
                f"Tile_X{x}_FrameStrobe", "MaxFramesPerCol - 1")

        for y in range(1, len(fabric.tile)-1):
            for x in range(len(fabric.tile[0])):
                writer.addConnectionVector(
                    f"Tile_X{x}Y{y}_FrameData_O", "FrameBitsPerRow - 1")

        for y in range(1, len(fabric.tile)):
            for x in range(len(fabric.tile[0])):
                writer.addConnectionVector(
                    f"Tile_X{x}Y{y}_FrameStrobe_O", "MaxFramesPerCol - 1")

    writer.addComment("tile-to-tile signal declarations", onNewLine=True)
    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile != None:
                for p in tile.portsInfo:
                    wireLength = (abs(p.xOffset)+abs(p.yOffset)) * p.wires-1
                    if p.sourceName == "NULL" or p.wireDirection == "JUMP":
                        continue
                    writer.addConnectionVector(
                        f"Tile_X{x}Y{y}_{p.sourceName}", wireLength)
    writer.addNewLine()
    # VHDL architecture body
    writer.addLogicStart()

    # top configuration data daisy chaining
    # this is copy and paste from tile code generation (so we can modify this here without side effects
    if fabric.configBitMode == 'FlipFlopChain':
        writer.addComment("configuration data daisy chaining", onNewLine=True)
        writer.addAssignScalar("conf_dat'low", "CONFin")
        writer.addComment("conf_data'low=0 and CONFin is from tile entity")
        writer.addAssignScalar("CONFout", "conf_data'high")
        writer.addComment("CONFout is from tile entity")

    if fabric.configBitMode == 'frame_based':
        for y in range(1, len(fabric.tile)-1):
            writer.addAssignVector(
                f"Tile_Y{y}_FrameData", "FrameData", f"FrameBitsPerRow*({y}+1)", f"FrameBitsPerRow*{y}")
        for x in range(len(fabric.tile[0])):
            writer.addAssignVector(
                f"Tile_X{x}_FrameStrobe", "FrameStrobe", f"MaxFramesPerCol*({x}+1) -1", f"MaxFramesPerCol*{x}")

    instantiatedPosition = []
    # VHDL tile instantiations
    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            northInput, southInput, eastInput, westInput = [], [], [], []
            tilePortList: List[str] = []
            tilePortsInfo: List[Tuple[List[Port], int, int]] = []
            outputSignalList = []
            tileLocationOffset: List[Tuple[int, int]] = []
            superTileLoc = []
            superTile = None
            if tile == None:
                continue

            if (x, y) in instantiatedPosition:
                continue

            # instantiate super tile when encountered
            # get all the ports of the tile. If is a super tile, we loop over the
            # tile map and find all the offset of the subtile, and all their related
            # ports.
            superTileName = ""
            for k, v in fabric.superTileDic.items():
                if tile.name in [i.name for i in v.tiles]:
                    if tile.name == "":
                        continue
                    superTile = fabric.superTileDic[k]
                    break
            if fabric.superTileEnable and superTile:
                portsAround = superTile.getPortsAroundTile()
                for (i, j) in list(portsAround.keys()):
                    tileLocationOffset.append((int(i), int(j)))
                    instantiatedPosition.append((x+int(i), y+int(j)))
                    superTileLoc.append((x+int(i), y+int(j)))

                # all input port of the tile
                for (i, j), around in portsAround.items():
                    for ports in around:
                        for port in ports:
                            if port.inOut == "IN" and port.sourceName != "NULL" and port.destinationName != "NULL":
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_{port.name}")

                # all output port of the tile
                for (i, j), around in portsAround.items():
                    for ports in around:
                        for port in ports:
                            if port.inOut == "OUT" and port.sourceName != "NULL" and port.destinationName != "NULL":
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_{port.name}")

                for t in superTile.bels:
                    for b in t.bels:
                        for p in b.externalInput:
                            tilePortList.append(p)
                        for p in b.externalOutput:
                            tilePortList.append(p)
                        for p in b.sharedPort:
                            if "UserCLK" not in p:
                                tilePortList.append(p[0])

                withUserCLK = False
                for t in superTile.tiles:
                    withUserCLK |= t.withUserCLK
                if withUserCLK:
                    tilePortList.append("UserCLK")
                else:
                    tilePortList.append("UserCLK")
                    tilePortList.append("UserCLKo")

                if fabric.configBitMode == "frame_based":
                    for j, row in enumerate(superTile.tileMap):
                        for i, _ in enumerate(row):
                            if superTile.tileMap[j][i] == None:
                                continue
                            if j - 1 < 0 or superTile.tileMap[j-1][i] == None:
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_FrameStrobe_O")
                            if i + 1 >= len(superTile.tileMap[0]) or superTile.tileMap[y][i+1] == None:
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_FrameData_O")
                            if j + 1 >= len(superTile.tileMap) or superTile.tileMap[j+1][i] == None:
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_FrameStrobe")
                            if i - 1 < 0 or superTile.tileMap[j][i-1] == None:
                                tilePortList.append(
                                    f"Tile_X{i}Y{j}_FrameData")
            else:
                instantiatedPosition.append((x, y))
                tileLocationOffset.append((0, 0))
                tilePortsInfo.append((tile.getNorthSidePorts(), 0, 0))
                tilePortsInfo.append((tile.getEastSidePorts(), 0, 0))
                tilePortsInfo.append((tile.getSouthSidePorts(), 0, 0))
                tilePortsInfo.append((tile.getWestSidePorts(), 0, 0))

                # all the input port of a single normal tile
                for port, i, j in tilePortsInfo:
                    for p in port:
                        if p.name != "NULL" and p.inOut == "IN":
                            tilePortList.append(f"{p.name}")

                # all the output port of a single normal tile
                for port, i, j in tilePortsInfo:
                    for p in port:
                        if p.name != "NULL" and p.inOut == "OUT":
                            tilePortList.append(f"{p.name}")

                for b in tile.bels:
                    for p in b.externalInput:
                        tilePortList.append(p)
                    for p in b.externalOutput:
                        tilePortList.append(p)
                    for p in b.sharedPort:
                        if "UserCLK" not in p[0]:
                            tilePortList.append(p[0])

                if superTile:
                    tilePortList.append("UserCLK")
                else:
                    tilePortList.append("UserCLK")
                    tilePortList.append("UserCLKo")

                if fabric.configBitMode == "frame_based":
                    # only add frame data port when there are config bits in the tile
                    if tile.globalConfigBits > 0:
                        tilePortList.append("FrameData")
                        tilePortList.append("FrameData_O")
                    tilePortList.append("FrameStrobe")
                    tilePortList.append("FrameStrobe_O")

            # remove all the duplicated edge tile
            tileLocationOffset = list(dict.fromkeys(tileLocationOffset))
            signal = []
            # use the offset to find all the related tile input, output signal
            # if is a normal tile then the offset is (0, 0)
            for i, j in tileLocationOffset:
                # input connection from south side of the north tile
                if 0 <= y - 1 < len(fabric.tile) and fabric.tile[y+j-1][x+i] != None and (x+i, y+j-1) not in superTileLoc:
                    for p in fabric.tile[y+j-1][x+i].getSouthSidePorts():
                        if p.inOut == "OUT":
                            signal.append(
                                f"Tile_X{x+i}Y{y+j-1}_{p.name}")
                # input connection from west side of the east tile
                if 0 <= x + 1 < len(fabric.tile[0]) and fabric.tile[y+j][x+i+1] != None and (x+i+1, y+j) not in superTileLoc:
                    for p in fabric.tile[y+j][x+i+1].getWestSidePorts():
                        if p.inOut == "OUT":
                            signal.append(
                                f"Tile_X{x+i+1}Y{y+j}_{p.name}")
                # input connection from north side of the south tile
                if 0 <= y + 1 < len(fabric.tile) and fabric.tile[y+j+1][x+i] != None and (x+i, y+j+1) not in superTileLoc:
                    for p in fabric.tile[y+j+1][x+i].getNorthSidePorts():
                        if p.inOut == "OUT":
                            signal.append(
                                f"Tile_X{x+i}Y{y+j+1}_{p.name}")

                # input connection from east side of the west tile
                if 0 <= x - 1 < len(fabric.tile[0]) and fabric.tile[y+j][x+i-1] != None and (x+i-1, y+j) not in superTileLoc:
                    for p in fabric.tile[y+j][x+i-1].getEastSidePorts():
                        if p.inOut == "OUT":
                            signal.append(
                                f"Tile_X{x+i-1}Y{y+j}_{p.name}")

            # output signal name is same as the output port name
            if superTile:
                portsAround = superTile.getPortsAroundTile()
                for (i, j), around in portsAround.items():
                    for ports in around:
                        for port in ports:
                            if port.inOut == "OUT" and port.name != "NULL":
                                outputSignalList.append(
                                    f"Tile_X{x+int(i)}Y{y+int(j)}_{port.name}")
            else:
                for ports, i, j in tilePortsInfo:
                    for p in ports:
                        if p.inOut == "OUT" and p.name != "NULL":
                            outputSignalList.append(
                                f"Tile_X{x+i}Y{y+j}_{p.name}")

            # combine = northInput + eastInput + southInput + westInput + outputSignalList
            signal += outputSignalList

            writer.addNewLine()
            writer.addComment(
                "tile IO port will get directly connected to top-level tile module", onNewLine=True, indentLevel=0)
            for (i, j) in tileLocationOffset:
                for b in fabric.tile[y+j][x+i].bels:
                    for p in b.externalInput:
                        signal.append(f"Tile_X{x}Y{y}_{p}")
                    for p in b.externalOutput:
                        signal.append(f"Tile_X{x}Y{y}_{p}")
                    for p in b.sharedPort:
                        if "UserCLK" not in p[0]:
                            signal.append(f"{p[0]}")

            if not superTile:
                # for userCLK
                if y + 1 < fabric.numberOfRows:
                    signal.append(f"Tile_X{x}Y{y+1}_UserCLKo")
                else:
                    signal.append(f"UserCLK")
                # for userCLKo
                signal.append(f"Tile_X{x}Y{y}_UserCLKo")
            else:
                if y + 1 < fabric.numberOfRows:
                    signal.append(f"Tile_X{x}Y{y+1}_UserCLKo")
                else:
                    signal.append(f"UserCLK")

            if fabric.configBitMode == "frame_based":
                for (i, j) in tileLocationOffset:
                    if tile.globalConfigBits > 0 or superTile:
                        # frameData signal
                        if x == 0:
                            signal.append(f"Tile_Y{y}_FrameData")
                        elif (x+i-1, y+j) not in superTileLoc:
                            signal.append(f"Tile_X{x+i-1}Y{y+j}_FrameData_O")
                        # frameData_O signal
                        if x == len(fabric.tile[0]) - 1:
                            signal.append(f"Tile_X{x}Y{y}_FrameData_O")
                        elif (x+i-1, y+j) not in superTileLoc:
                            signal.append(f"Tile_X{x+i}Y{y+j}_FrameData_O")

                    # frameStrobe signal
                    if y == 0:
                        signal.append(f"Tile_X{x}Y{y+1}_FrameStrobe_O")
                    elif (x+i, y+j+1) not in superTileLoc:
                        signal.append(f"Tile_X{x+i}Y{y+j+1}_FrameStrobe_O")

                    # frameStrobe_O signal
                    if y == len(fabric.tile) - 1:
                        signal.append(f"Tile_X{x}_FrameStrobe")
                    elif (x+i, y+j+1) not in superTileLoc:
                        signal.append(f"Tile_X{x+i}Y{y+j}_FrameStrobe_O")

            name = ""
            if superTile:
                name = superTile.name
            else:
                name = tile.name

            tilePortList = list(dict.fromkeys(tilePortList))
            signal = list(dict.fromkeys(signal))
            writer.addInstantiation(compName=name,
                                    compInsName=f"Tile_X{x}Y{y}_{name}",
                                    compPort=tilePortList,
                                    signal=signal)
    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def generateTopWrapper(fabric: Fabric, writer: codeGenerator):
    numberOfRows = fabric.numberOfRows - 2
    numberOfColumns = fabric.numberOfColumns
    writer.addHeader(f"{fabric.name}")
    writer.addParameterStart(indentLevel=1)
    writer.addParameter("include_eFPGA", "integer", 1, indentLevel=2)
    writer.addParameter("NumberOfRows", "integer",
                        numberOfRows, indentLevel=2)
    writer.addParameter("NumberOfCols", "integer",
                        numberOfColumns, indentLevel=2)
    writer.addParameter("FrameBitsPerRow", "integer",
                        fabric.frameBitsPerRow, indentLevel=2)
    writer.addParameter("MaxFramesPerCol", "integer",
                        fabric.maxFramesPerCol, indentLevel=2)
    writer.addParameter("desync_flag", "integer",
                        fabric.desync_flag, indentLevel=2)
    writer.addParameter("FrameSelectWidth", "integer",
                        fabric.frameSelectWidth, indentLevel=2)
    writer.addParameter("RowSelectWidth", "integer",
                        fabric.rowSelectWidth, indentLevel=2)
    writer.addParameterEnd(indentLevel=1)
    writer.addPortStart(indentLevel=1)
    writer.addPortVector("I_top", "INOUT", f"{numberOfRows*2}-1")
    writer.addPortVector("T_top", "INOUT", f"{numberOfRows*2}-1")
    writer.addPortVector("O_top", "INOUT", f"{numberOfRows*2}-1")
    writer.addPortVector("A_config_C", "INOUT", f"{numberOfRows*4}-1")
    writer.addPortVector("B_config_C", "INOUT", f"{numberOfRows*4}-1")
    writer.addPortScalar("CLK", "IN")
    writer.addPortScalar("SelfWriteStrobe", "INOUT")
    writer.addPortScalar("SelfWriteData", "INOUT")
    writer.addPortScalar("RX", "INOUT")
    writer.addPortScalar("ComActive", "INOUT")
    writer.addPortScalar("ReceiveLED", "INOUT")
    writer.addPortScalar("s_clk", "INOUT")
    writer.addPortScalar("s_data", "INOUT")
    writer.addPortEnd()
    writer.addHeaderEnd(f"{fabric.name}")
    writer.addDesignDescriptionStart(f"{fabric.name}")

    writer.addComment("BlockRAM ports", onNewLine=True)
    writer.addNewLine()
    writer.addConnectionVector("RAM2FAB_D", f"{numberOfRows*4*4}-1")
    writer.addConnectionVector("FAB2RAM_D", f"{numberOfRows*4*4}-1")
    writer.addConnectionVector("FAB2RAM_A", f"{numberOfRows*4*2}-1")
    writer.addConnectionVector("FAB2RAM_C", f"{numberOfRows*4}-1")
    writer.addConnectionVector("Config_accessC", f"{numberOfRows*4}-1")

    writer.addNewLine()
    writer.addComment("Signal declarations", onNewLine=True)
    writer.addConnectionVector(
        "FrameRegister", "(NumberOfRows*FrameBitsPerRow)-1")
    writer.addConnectionVector(
        "FrameSelect", "(MaxFramesPerCol*NumberOfCols)-1")
    writer.addConnectionVector(
        "FrameData", "(FrameBitsPerRow*(NumberOfRows+2))-1")
    writer.addConnectionVector(
        "FrameAddressRegister", "FrameBitsPerRow-1")
    writer.addConnectionScalar("LongFrameStrobe")
    writer.addConnectionVector("LocalWriteData", 31)
    writer.addConnectionScalar("LocalWriteStrobe")
    writer.addConnectionVector("RowSelect", "RowSelectWidth-1")

    writer.addNewLine()
    writer.addInstantiation(compName="Config",
                            compInsName="Config_inst",
                            compPort=["CLK", "RX", "ComActive", "ReceiveLED",
                                      "SelfWriteStrobe", "s_clk",   "s_data", "SelfWriteData",
                                      "SelfWriteStrobe", "ConfigWriteData", "ConfigWriteStrobe", "FrameAddressRegister", "LongFrameStrobe", "RowSelect"],
                            signal=["CLK", "RX", "ComActive", "ReceiveLED",
                                    "SelfWriteStrobe", "s_clk",   "s_data", "SelfWriteData",
                                    "SelfWriteStrobe", "ConfigWriteData", "ConfigWriteStrobe", "FrameAddressRegister", "LongFrameStrobe", "RowSelect"],
                            paramPort=["RowSelectWidth", "FrameBitsPerRow",
                                       "NumberOfRows", "desync_flag"],
                            paramSignal=["RowSelectWidth", "FrameBitsPerRow",
                                         "NumberOfRows", "desync_flag"])
    writer.addNewLine()
    for row in range(numberOfRows):
        writer.addInstantiation(compName=f"Frame_data_Reg_{row}",
                                compInsName=f"Frame_data_Reg_{row}_inst",
                                compPort=["FrameData_I",
                                          "FrameData_O", "RowSelect", "CLK"],
                                signal=["LocalWriteData",
                                        f"FrameRegister[{row}*FrameBitsPerRow+:FrameBitsPerRow]", "RowSelect",
                                        "CLK"],
                                paramPort=["FrameBitsPerRow",
                                           "RowSelectWidth"],
                                paramSignal=["FrameBitsPerRow", "RowSelectWidth"])
    writer.addNewLine()
    for col in range(numberOfColumns):
        writer.addInstantiation(compName=f"Frame_select_{col}",
                                compInsName=f"inst_Frame_select_{col}",
                                compPort=["FrameStrobe_I",
                                          "FrameStrobe_O", "FrameSelect", "FrameStrobe"],
                                signal=["FrameAddressRegister[MaxFramesPerCol-1:0]",
                                        f"FrameSelect[{col}*MaxFramesPerCol +: MaxFramesPerCol]",
                                        "FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-(FrameSelectWidth)]",
                                        "LongFrameStrobe"],
                                paramPort=["MaxFramesPerCol",
                                           "FrameSelectWidth"],
                                paramSignal=["MaxFramesPerCol", "FrameSelectWidth"])

    writer.addNewLine()
    portList = []
    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X0Y{i}_A_I_top")
        portList.append(f"Tile_X0Y{i}_B_I_top")

    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X0Y{i}_A_T_top")
        portList.append(f"Tile_X0Y{i}_B_T_top")

    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X0Y{i}_A_O_top")
        portList.append(f"Tile_X0Y{i}_B_O_top")

    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X0Y{i}_A_config_C_bit0")
        portList.append(f"Tile_X0Y{i}_A_config_C_bit1")
        portList.append(f"Tile_X0Y{i}_A_config_C_bit2")
        portList.append(f"Tile_X0Y{i}_A_config_C_bit3")

    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X0Y{i}_B_config_C_bit0")
        portList.append(f"Tile_X0Y{i}_B_config_C_bit1")
        portList.append(f"Tile_X0Y{i}_B_config_C_bit2")
        portList.append(f"Tile_X0Y{i}_B_config_C_bit3")

    for i in range(1, numberOfRows+1):
        for j in range(4):
            for k in range(4):
                portList.append(
                    f"Tile_X{numberOfColumns-1}Y{i}_RAM2FAB_D{j}_I{k}")

    for i in range(1, numberOfRows + 1):
        for j in range(4):
            for k in range(4):
                portList.append(
                    f"Tile_X{numberOfColumns-1}Y{i}_RAM2FAB_D{j}_O{k}")

    for i in range(1, numberOfRows + 1):
        for j in range(2):
            for k in range(4):
                portList.append(
                    f"Tile_X{numberOfColumns-1}Y{i}_RAM2FAB_A{j}_O{k}")

    for i in range(1, numberOfRows + 1):
        for j in range(4):
            portList.append(
                f"Tile_X{numberOfColumns-1}Y{i}_RAM2FAB_C_O{j}")

    for i in range(1, numberOfRows+1):
        portList.append(f"Tile_X{numberOfColumns-1}Y{i}_Config_accessC_bit0")
        portList.append(f"Tile_X{numberOfColumns-1}Y{i}_Config_accessC_bit1")
        portList.append(f"Tile_X{numberOfColumns-1}Y{i}_Config_accessC_bit2")
        portList.append(f"Tile_X{numberOfColumns-1}Y{i}_Config_accessC_bit3")

    portList.append("UserCLK")
    portList.append("FrameData")
    portList.append("FrameStrobe")

    signal = []
    signal += [f"I_top[{i}]" for i in range(numberOfRows*2-1, -1, -1)]
    signal += [f"T_top[{i}]" for i in range(numberOfRows*2-1, -1, -1)]
    signal += [f"O_top[{i}]" for i in range(numberOfRows*2-1, -1, -1)]
    signal += [f"A_config_C[{i}]" for i in range(numberOfRows*4-1, -1, -1)]
    signal += [f"B_config_C[{i}]" for i in range(numberOfRows*4-1, -1, -1)]
    signal += [f"RAM2FAB_D[{i}]" for i in range(numberOfRows*4*4-1, -1, -1)]
    signal += [f"FAB2RAM_D[{i}]" for i in range(numberOfRows*4*4-1, -1, -1)]
    signal += [f"FAB2RAM_A[{i}]" for i in range(numberOfRows*2*4-1, -1, -1)]
    signal += [f"FAB2RAM_C[{i}]" for i in range(numberOfRows*4-1, -1, -1)]
    signal += [f"Config_accessC[{i}]" for i in range(numberOfRows*4-1, -1, -1)]
    signal.append("CLK")
    signal.append("FrameData")
    signal.append("FrameSelect")
    writer.addInstantiation(compName=fabric.name,
                            compInsName=f"{fabric.name}_inst",
                            compPort=portList,
                            signal=signal)

    writer.addNewLine()
    portList = ["CLK", "rd_addr", "rd_data", "wr_addr",
                "wr_data", "C0", "C1", "C2", "C3", "C4", "C5"]
    data_cap = int((numberOfRows*4*4)/fabric.numberOfBRAMs)
    addr_cap = int((numberOfRows*4*2)/fabric.numberOfBRAMs)
    config_cap = int((numberOfRows*4)/fabric.numberOfBRAMs)
    for i in range(fabric.numberOfBRAMs-1):
        signal = ["CLK",
                  f"FAB2RAM_A[{addr_cap*i+8-1}:{addr_cap*i}]",
                  f"RAM2FAB_D[{addr_cap*i+32-1}:{addr_cap*i}]",
                  f"FAB2RAM_A[{addr_cap *i+16-1}:{addr_cap*i+8}]",
                  f"FAB2RAM_D[{data_cap*i+32-1}:{data_cap*i}]",
                  f"FAB2RAM_C[{config_cap*i}]",
                  f"FAB2RAM_C[{config_cap*i+1}]",
                  f"FAB2RAM_C[{config_cap*i+2}]",
                  f"FAB2RAM_C[{config_cap*i+3}]",
                  f"FAB2RAM_C[{config_cap*i+4}]",
                  f"FAB2RAM_C[{config_cap*i+5}]"
                  ]
        writer.addInstantiation(compName="BlockRAM_1KB",
                                compInsName=f"Inst_BlockRAM_{i}",
                                compPort=portList,
                                signal=signal)
    writer.addAssignScalar(
        "FrameData", ["32'h12345678", "FrameRegister", "32'h12345678"])
    writer.addDesignDescriptionEnd()
    writer.writeToFile()


def genBitstreamSpec(archObject: FabricModelGen):
    specData = {"TileMap": {}, "TileSpecs": {}, "TileSpecs_No_Mask": {}, "FrameMap": {}, "FrameMapEncode": {
    }, "ArchSpecs": {"MaxFramesPerCol": MaxFramesPerCol, "FrameBitsPerRow": FrameBitsPerRow}}
    BelMap = {}
    for line in archObject.tiles:
        for tile in line:
            specData["TileMap"][tile.genTileLoc()] = tile.tileType

    # Generate mapping dicts for bel types:
    # The format here is that each BEL has a dictionary that maps a fasm feature to another dictionary that maps bits to their values
    # The lines generating the BEL maps do it slightly differently, just notating bits that should go high - this is translated further down
    # We do not worry about bitmasking here - that's handled in the generation
    # LUT4:
    LUTmap = {}
    # Futureproofing as there are two ways that INIT[0] may be referred to (FASM parser will use INIT to refer to INIT[0])
    LUTmap["INIT"] = 0
    for i in range(16):
        LUTmap["INIT[" + str(i) + "]"] = i
    LUTmap["FF"] = 16
    LUTmap["IOmux"] = 17
    LUTmap["SET_NORESET"] = 18

    BelMap["LUT4c_frame_config"] = LUTmap

    # MUX8
    MUX8map = {"c0": 0, "c1": 1}

    BelMap["MUX8LUT_frame_config"] = MUX8map

    # MULADD

    MULADDmap = {}
    MULADDmap["A_reg"] = 0
    MULADDmap["B_reg"] = 1
    MULADDmap["C_reg"] = 2

    MULADDmap["ACC"] = 3

    MULADDmap["signExtension"] = 4

    MULADDmap["ACCout"] = 5

    BelMap["MULADD"] = MULADDmap

    # IOpad
    BelMap["IO_1_bidirectional_frame_config_pass"] = {}

    Config_accessmap = {}
    Config_accessmap["C_bit0"] = 0
    Config_accessmap["C_bit1"] = 1
    Config_accessmap["C_bit2"] = 2
    Config_accessmap["C_bit3"] = 3
    BelMap["Config_access"] = Config_accessmap

    # InPass

    InPassmap = {}

    InPassmap["I0_reg"] = 0
    InPassmap["I1_reg"] = 1
    InPassmap["I2_reg"] = 2
    InPassmap["I3_reg"] = 3

    BelMap["InPass4_frame_config"] = InPassmap
    # OutPass

    OutPassmap = {}

    OutPassmap["I0_reg"] = 0
    OutPassmap["I1_reg"] = 1
    OutPassmap["I2_reg"] = 2
    OutPassmap["I3_reg"] = 3

    BelMap["OutPass4_frame_config"] = OutPassmap

    # RegFile
    RegFilemap = {}

    RegFilemap["AD_reg"] = 0
    RegFilemap["BD_reg"] = 1

    BelMap["RegFile_32x4"] = RegFilemap

    # DoneTypes = []

    # NOTE: THIS METHOD HAS BEEN CHANGED FROM A PREVIOUS IMPLEMENTATION SO PLEASE BEAR THIS IN MIND
    # To account for cascading and termination, this now creates a separate map for every tile, as opposed to every cellType
    for row in archObject.tiles:
        # curTile = getTileByType(archObject, cellType)
        for curTile in row:
            cellType = curTile.tileType
            if cellType == "NULL":
                continue

            # Add frame masks to the dictionary
            try:
                # This may need to be .init.csv, not just .csv
                configCSV = open(cellType + "_ConfigMem.csv")
            except:
                try:
                    configCSV = open(cellType + "_ConfigMem.init.csv")
                except:
                    print(
                        f"No Config Mem csv file found for {cellType}. Assuming no config memory.")
                    specData["FrameMap"][cellType] = {}
                    specData["FrameMapEncode"][cellType] = {}
                    continue
            configList = [i.strip('\n').split(',') for i in configCSV][1:]
            configList = RemoveComments(configList)
            maskDict = {}
            # Bitmap with the specific configmem.csv file
            encodeDict = [-1 for i in range(FrameBitsPerRow*MaxFramesPerCol)]
            for line in configList:
                configEncode = []
                maskDict[int(line[1])] = line[3].replace("_", "")
                for index in line[4:]:
                    if ':' in index:
                        index_temp = index.split(':')
                        index_width = int(index_temp[0])-int(index_temp[1])+1
                        for i in range(index_width):
                            configEncode.append(str(int(index_temp[0])-i))
                    else:
                        for n in index.split(";"):
                            configEncode.append(n)
                # print(configEncode)
                encode_i = 0
                for i, char in enumerate(maskDict[int(line[1])]):
                    if char != '0':
                        # encodeDict[int(line[1])][i] = configEncode[encode_i]
                        encodeDict[int(configEncode[encode_i])] = (
                            31 - i) + (32 * int(line[1]))
                        encode_i += 1
            # print(encodeDict)
            specData["FrameMap"][cellType] = maskDict
            if 'term' in cellType:
                print(f"No config memory for {cellType}.")
                specData["FrameMap"][cellType] = {}
                specData["FrameMapEncode"][cellType] = {}
                # continue
            # if specData["ArchSpecs"]["MaxFramesPerCol"] < int(line[1]) + 1:
            # 	specData["ArchSpecs"]["MaxFramesPerCol"] = int(line[1]) + 1
            # if specData["ArchSpecs"]["FrameBitsPerRow"] < int(line[2]):
            # 	specData["ArchSpecs"]["FrameBitsPerRow"] = int(line[2])
            configCSV.close()

            curBitOffset = 0
            curTileMap = {}
            curTileMap_No_Mask = {}

            # Add the bel features we made a list of earlier
            for i, belPair in enumerate(curTile.bels):
                tempOffset = 0
                name = letters[i]
                # print(belPair)
                belType = belPair[0]
                for featureKey in BelMap[belType]:
                    # We convert to the desired format like so
                    curTileMap[name + "." + featureKey] = {
                        encodeDict[BelMap[belType][featureKey] + curBitOffset]: "1"}
                    curTileMap_No_Mask[name + "." + featureKey] = {
                        (BelMap[belType][featureKey] + curBitOffset): "1"}
                    if featureKey != "INIT":
                        tempOffset += 1
                curBitOffset += tempOffset
                # if(belType == 'Config_access'):
                # print(curBitOffset)
            csvFile = [i.strip('\n').split(',')
                       for i in open(curTile.matrixFileName)]
            pipCounts = [int(row[-1]) for row in csvFile[1::]]
            csvFile = RemoveComments(csvFile)
            sinks = [line[0] for line in csvFile]
            sources = csvFile[0]
            pips = []
            pipsdict = {}
            # Config bits for switch matrix from file
            for y, row in enumerate(csvFile[1::]):
                muxList = []
                pipCount = pipCounts[y]
                for x, value in enumerate(row[1::]):
                    # Remember that x and y are offset
                    if value == "1":
                        muxList.append(".".join((sources[x+1], sinks[y+1])))
                muxList.reverse()  # Order is flipped
                for i, pip in enumerate(muxList):
                    controlWidth = int(numpy.ceil(numpy.log2(pipCount)))
                    if pipCount < 2:
                        curTileMap[pip] = {}
                        curTileMap_No_Mask[pip] = {}
                        continue
                    pip_index = pipCount-i-1
                    controlValue = f"{pip_index:0{controlWidth}b}"
                    tempOffset = 0
                    for curChar in controlValue[::-1]:
                        if pip not in curTileMap.keys():
                            curTileMap[pip] = {}
                            curTileMap_No_Mask[pip] = {}
                        curTileMap[pip][encodeDict[curBitOffset +
                                                   tempOffset]] = curChar
                        curTileMap_No_Mask[pip][curBitOffset +
                                                tempOffset] = curChar
                        tempOffset += 1
                curBitOffset += controlWidth
            # And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
            for wire in curTile.wires:
                for count in range(int(wire["wire-count"])):
                    wireName = ".".join(
                        (wire["source"] + str(count), wire["destination"] + str(count)))
                    # Tile connection wires are seen as pips by nextpnr for ease of use, so this makes sure those pips still have corresponding keys
                    curTileMap[wireName] = {}
                    curTileMap_No_Mask[wireName] = {}
            for wire in curTile.atomicWires:
                wireName = ".".join((wire["source"], wire["destination"]))
                curTileMap[wireName] = {}
                curTileMap_No_Mask[wireName] = {}

            specData["TileSpecs"][curTile.genTileLoc()] = curTileMap
            specData["TileSpecs_No_Mask"][curTile.genTileLoc()
                                          ] = curTileMap_No_Mask
    return specData

#####################################################################################
# Main
#####################################################################################


def CheckExt(choices):
    class Act(argparse.Action):
        def __call__(self, parser, namespace, fname, option_string=None):
            try:
                ext = os.path.splitext(fname)[1][1:]
                if ext not in choices:
                    option_string = '({})'.format(
                        option_string) if option_string else ''
                    parser.error("file doesn't end with one of {}{}".format(
                        choices, option_string))
                else:
                    setattr(namespace, self.dest, fname)
            except:
                for e in fname:
                    ext = os.path.splitext(e)[1][1:]
                    if ext not in choices:
                        option_string = '({})'.format(
                            option_string) if option_string else ''
                        parser.error("file doesn't end with one of {}{}".format(
                            choices, option_string))
                    else:
                        setattr(namespace, self.dest, fname)
    return Act


steps = """
Steps to use this script to produce an FPGA fabric:
    1) create/modify a fabric description (see fabric.csv as an example)

    2) create BEL primitives as VHDL code. 
       Use std_logic (not std_logic_vector) ports
       Follow the example in clb_slice_4xLUT4.vhdl
       Only one entity allowed in the file!
       If you use further components, they go into extra files.
       The file name and the entity should match.
       Ensure the top-level BEL VHDL-file is in your fabric description.

    3) run the script with the -GenTileSwitchMatrixCSV switch
       This will eventually overwrite all old switch matrix csv-files!!!

    4) Edit the switch matrix adjacency (the switch matrix csv-files). 

    5) run the script with the -GenTileSwitchMatrixVHDL switch
       This will generate switch matrix VHDL files

    6) run the script with the -GenTileHDL switch
       This will generate all tile VHDL files

    Note that the only manual VHDL code is implemented in 2) the rest is autogenerated!
"""

parser = argparse.ArgumentParser(description=steps)

parser.add_argument('-f', "--fabric_csv",
                    default="fabric.csv",
                    action=CheckExt({'csv'}),
                    help="Specifiy Fabric CSV file, if not specified will use the fabric.csv in the current directory")

parser.add_argument('-s', "--src",
                    default=".",
                    dest="src_dir",
                    help="Specify the source directory of the fabric design")

parser.add_argument('-o', "--out",
                    dest="out_dir",
                    help="Specify the output directory of the files. If not set will be default to be the same as source directory. This option do not affect -CSV2list and -AddList2CSV output directory")

parser.add_argument('-GenTileSwitchMatrixCSV',
                    default=False,
                    action='store_true',
                    help='generate initial switch matrix template (has to be bootstrapped first)')

parser.add_argument('-GenTileSwitchMatrixVHDL',
                    default=False,
                    action='store_true',
                    help='generate initial switch matrix VHDL code')

parser.add_argument('-GenTileSwitchMatrixVerilog',
                    default=False,
                    action='store_true',
                    help='generate all tile VHDL descriptions')

parser.add_argument('-GenTileConfigMemVHDL',
                    default=False,
                    action='store_true')

parser.add_argument('-GenTileConfigMemVerilog',
                    default=False,
                    action='store_true')

parser.add_argument('-GenTileVHDL',
                    default=False,
                    action='store_true')

parser.add_argument('-GenTileVerilog',
                    default=False,
                    action='store_true')

parser.add_argument('-GenFabricVHDL',
                    default=False,
                    action='store_true')

parser.add_argument('-GenFabricVerilog',
                    default=False,
                    action='store_true')

parser.add_argument('-GenFabricTopWrapperVHDL',
                    default=False,
                    action='store_true',
                    help='Generate the top wrapper for the fabric design with VHDL')

parser.add_argument('-GenFabricTopWrapperVerilog',
                    default=False,
                    action='store_true',
                    help='Generate the top wrapper for the fabric design with Verilog')

parser.add_argument('-run_all',
                    default=False,
                    action='store_true',
                    help="run -GenTileSwitchMatrixCSV, -GenTileSwitchMatrixVHDL, -GenTileVHDL in one go")

parser.add_argument('-CSV2list',
                    nargs=2,
                    metavar=('in.csv', 'out.list'),
                    action=CheckExt({'csv', 'list'}),
                    help='translate a switch matrix adjacency matrix into a list (beg_port,end_port)')

parser.add_argument('-AddList2CSV',
                    nargs=2,
                    metavar=('in.list', 'out.csv'),
                    action=CheckExt({'csv', 'list'}),
                    help='adds connctions from a list (beg_port,end_port) to a switch matrix adjacency matrix')

parser.add_argument('-PrintCSV_FileInfo',
                    action=CheckExt({'csv'}),
                    help='prints input and oputput ports in csv switch matrix files')

parser.add_argument('-GenNextpnrModel',
                    default=False,
                    action='store_true')

parser.add_argument('-GenNextpnrModel_pair',
                    default=False,
                    action='store_true')

parser.add_argument('-GenVPRModel',
                    action=CheckExt({'xml'}),
                    metavar=('custom_info.xml'))

parser.add_argument('-debug', default=False,
                    action='store_true', help='debug mode')

parser.add_argument('-GenBitstreamSpec',
                    metavar=("meta_data.txt"),
                    help='generates a bitstream spec for fasm parsing')


args = parser.parse_args()

src_dir = args.src_dir
if args.out_dir:
    out_dir = args.out_dir
else:
    out_dir = src_dir


fabric = parseFabricCSV(args.fabric_csv)

ConfigBitMode = fabric.configBitMode
FrameBitsPerRow = fabric.frameBitsPerRow
MaxFramesPerCol = fabric.maxFramesPerCol
Package = fabric.package
# time in ps - this is needed for simulation as a fabric configuration can result in loops crashing the simulator
GenerateDelayInSwitchMatrix = fabric.generateDelayInSwitchMatrix
# 'custom': using our hard-coded MUX-4 and MUX-16; 'generic': using standard generic RTL code
MultiplexerStyle = fabric.multiplexerStyle
# generate switch matrix select signals (index) which is useful to verify if bitstream matches bitstream
SwitchMatrixDebugSignals = True
# enable SuperTile generation
SuperTileEnable = fabric.superTileEnable

src_dir = "./"


# The original plan was to do something super generic where tiles can be arbitrarily defined.
# However, that would have let into a heterogeneous/flat FPGA fabric as each tile may have different sets of wires to route.
# If we say that a wire is defined by/in its source cell then that implies how many wires get routed through adjacent neighbouring tiles.
# To keep things simple, we left this all out and the wiring between tiles is the same (for the first shot)

if args.GenTileSwitchMatrixCSV or args.run_all:
    print('### Generate initial switch matrix template (has to be bootstrapped first)')
    BootstrapSwitchMatrix(fabric)


if args.GenTileSwitchMatrixVHDL or args.run_all:
    print('### Generate initial switch matrix VHDL code')
    for tile in fabric.tileDic:
        print(
            f'### generate VHDL for tile {tile} # filename: {out_dir}/{str(tile)}_switch_matrix.vhdl)')
        writer = VHDLWriter(f"{out_dir}/{str(tile)}_switch_matrix.vhdl")
        genTileSwitchMatrix(
            fabric.tileDic[tile], f"{src_dir}/{str(tile)}_switch_matrix.csv", writer)

if args.GenTileSwitchMatrixVerilog or args.run_all:
    print('### Generate initial switch matrix Verilog code')
    for tile in fabric.tileDic:
        print(
            f"### generate Verilog for tile {tile} # filename: {out_dir}/{str(tile)}_switch_matrix.v")
        writer = VerilogWriter(f"{out_dir}/{str(tile)}_switch_matrix.v")
        genTileSwitchMatrix(
            fabric.tileDic[tile], f"{src_dir}/{str(tile)}_switch_matrix.csv", writer)


if args.GenTileConfigMemVHDL or args.run_all:
    print('### Generate all tile HDL descriptions')
    for tile in fabric.tileDic:
        print(
            f"### generate configuration bitstream storage VHDL for tile {tile} # filename: {out_dir}/{str(tile)}_ConfigMem.vhdl")
        writer = VHDLWriter(f"{out_dir}/{str(tile)}_ConfigMem.vhdl")
        generateConfigMem(
            fabric.tileDic[tile], f"{src_dir}/{str(tile)}_ConfigMem.csv", writer)

if args.GenTileConfigMemVerilog or args.run_all:
    for tile in fabric.tileDic:
        print(
            f"### generate configuration bitstream storage Verilog for tile {tile} # filename: {out_dir}/{str(tile)}_ConfigMem.v')")
        writer = VerilogWriter(f"{out_dir}/{str(tile)}_ConfigMem.v")
        generateConfigMem(
            fabric.tileDic[tile], f"{src_dir}/{str(tile)}_ConfigMem.csv", writer)

if args.GenTileVHDL or args.run_all:
    print('### Generate all tile HDL descriptions')
    for tile in fabric.tileDic:
        print(
            f"### generate VHDL for tile {tile} # filename:', {out_dir}/{str(tile)}_tile.vhdl")
        writer = VHDLWriter(f"{out_dir}/{str(tile)}_tile.vhdl")
        generateTile(fabric.tileDic[tile], writer)

    if SuperTileEnable:
        for superTile in fabric.superTileDic:
            print(
                f"### generate VHDL for SuperTile {superTile} # filename: {out_dir}/{superTile}_tile.vhdl")
            writer = VHDLWriter(f"{out_dir}/{str(superTile)}_tile.vhdl")
            generateSuperTile(fabric.superTileDic[superTile], writer)

if args.GenTileVerilog or args.run_all:
    for tile in fabric.tileDic:
        print(
            f"### generate Verilog for tile {tile} # filename: {out_dir}/{str(tile)}_tile.v")
        writer = VerilogWriter(f"{out_dir}/{str(tile)}_tile.v")
        generateTile(fabric.tileDic[tile], writer)

    if SuperTileEnable:
        for superTile in fabric.superTileDic:
            print(
                f"### generate Verilog for SuperTile {superTile} # filename: {out_dir}/{superTile}_tile.v")
            writer = VerilogWriter(f"{out_dir}/{str(superTile)}_tile.v")
            generateSuperTile(fabric.superTileDic[superTile], writer)

if args.GenFabricVHDL or args.run_all:
    print('### Generate the Fabric VHDL descriptions ')
    writer = VHDLWriter(f"{out_dir}/fabric.vhdl")
    generateFabric(fabric, writer)

if args.GenFabricVerilog or args.run_all:
    print('### Generate the Fabric Verilog descriptions')
    writer = VerilogWriter(f"{out_dir}/fabric.v")
    generateFabric(fabric, writer)

if args.GenFabricTopWrapperVerilog or args.run_all:
    print("### Generate the Fabric Top Wrapper")
    writer = VerilogWriter(f"{out_dir}/{fabric.name}_top.v")
    generateTopWrapper(fabric, writer)

if args.GenFabricTopWrapperVHDL or args.run_all:
    print("### Generate the Fabric Top Wrapper")
    writer = VHDLWriter(f"{out_dir}/{fabric.name}_top.vhdl")
    generateTopWrapper(fabric, writer)

if args.CSV2list:
    InFileName, OutFileName = args.CSV2list
    CSV2list(InFileName, OutFileName)

if args.AddList2CSV:
    InFileName, OutFileName = args.AddList2CSV
    list2CSV(InFileName, OutFileName)

if args.PrintCSV_FileInfo:
    PrintCSV_FileInfo(args.PrintCSV_FileInfo)

if args.GenNextpnrModel:
    # read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
    print('### Read Fabric csv file ###')
    try:
        FabricFile = [i.strip('\n').split(',') for i in open(args.fabric_csv)]
        # filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'
        fabric = GetFabric(FabricFile)
    except IOError:
        print("Could not open fabric.csv file")
        exit(-1)

    fabricObject = genFabricObject(fabric, FabricFile)
    pipFile = open("npnroutput/pips.txt", "w")
    belFile = open("npnroutput/bel.txt", "w")
    #pairFile = open("npnroutput/wirePairs.csv", "w")
    constraintFile = open("npnroutput/template.pcf", "w")

    npnrModel = genNextpnrModel(fabricObject, False)

    pipFile.write(npnrModel[0])
    belFile.write(npnrModel[1])
    constraintFile.write(npnrModel[2])

    pipFile.close()
    belFile.close()
    constraintFile.close()

    with open("npnroutput/template.v", "w") as templateFile:
        templateFile.write(genVerilogTemplate(fabricObject))


if args.GenNextpnrModel_pair:
    # read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
    print('### Read Fabric csv file ###')
    try:
        FabricFile = [i.strip('\n').split(',') for i in open(args.fabric_csv)]
        # filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'
        fabric = GetFabric(FabricFile)
    except IOError:
        print("Could not open fabric.csv file")
        exit(-1)

    fabricObject = genFabricObject(fabric, FabricFile)
    pipFile = open("npnroutput/pips.txt", "w")
    belFile = open("npnroutput/bel.txt", "w")
    pairFile = open("npnroutput/wirePairs.csv", "w")
    constraintFile = open("npnroutput/template.pcf", "w")

    npnrModel = genNextpnrModel(fabricObject)

    pipFile.write(npnrModel[0])
    belFile.write(npnrModel[1])
    constraintFile.write(npnrModel[2])
    pairFile.write(npnrModel[3])

    pipFile.close()
    belFile.close()
    constraintFile.close()
    pairFile.close()

    with open("npnroutput/template.v", "w") as templateFile:
        templateFile.write(genVerilogTemplate(fabricObject))

if args.GenVPRModel:
    # read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
    print('### Read Fabric csv file ###')
    try:
        FabricFile = [i.strip('\n').split(',') for i in open(args.fabric_csv)]
        # filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'
        fabric = GetFabric(FabricFile)
    except IOError:
        print("Could not open fabric.csv file")
        exit(-1)

    customXmlFilename = args.GenVPRModel
    fabricObject = genFabricObject(fabric, FabricFile)
    archFile = open(f"{out_dir}/architecture.xml", "w")
    rrFile = open(f"{out_dir}/routing_resources.xml", "w")

    archFile = open("vproutput/architecture.xml", "w")
    archXML = genVPRModelXML(fabricObject, customXmlFilename, False)
    archFile.write(archXML)
    archFile.close()

    rrFile = open("vproutput/routing_resources.xml", "w")
    rrGraphXML = genVPRModelRRGraph(fabricObject, False)
    rrFile.write(rrGraphXML)
    rrFile.close()

    if args.debug:
        with open("vproutput/template.v", "w") as templateFile:
            templateFile.write(genVerilogTemplate(fabricObject))

        with open("vproutput/fab_constraints.xml", "w") as constraintFile:
            constraintFile.write(genVPRModelConstraints(fabricObject))
        print(archXML)
        print(rrGraphXML)


if args.GenBitstreamSpec:
    # read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
    print('### Read Fabric csv file ###')
    try:
        FabricFile = [i.strip('\n').split(',') for i in open(args.fabric_csv)]
        # filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'
        fabric = GetFabric(FabricFile)
    except IOError:
        print("Could not open fabric.csv file")
        exit(-1)

    OutFileName = args.GenBitstreamSpec
    fabricObject = genFabricObject(fabric, FabricFile)
    bitstreamSpecFile = open(OutFileName, "wb")
    specObject = genBitstreamSpec(fabricObject)
    pickle.dump(specObject, bitstreamSpecFile)
    bitstreamSpecFile.close()
    w = csv.writer(open(OutFileName.replace("txt", "csv"), "w"))
    for key1 in specObject["TileSpecs"]:
        w.writerow([key1])
        for key2, val in specObject["TileSpecs"][key1].items():
            w.writerow([key2, val])
