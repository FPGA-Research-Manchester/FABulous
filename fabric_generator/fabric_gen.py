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

from array import array
import re
import sys
from contextlib import redirect_stdout
from io import StringIO
import math
import os
import numpy
import configparser
import pickle
import csv
from fasm import * #Remove this line if you do not have the fasm library installed and will not be generating a bitstream
import xml.etree.ElementTree as ET

#Default parameters (will be overwritten if defined in fabric between 'ParametersBegin' and 'ParametersEnd'
#Parameters = [ 'ConfigBitMode', 'FrameBitsPerRow' ]
ConfigBitMode = 'FlipFlopChain'
FrameBitsPerRow = 32
MaxFramesPerCol = 20
Package = 'use work.my_package.all;'
GenerateDelayInSwitchMatrix = '100'	# time in ps - this is needed for simulation as a fabric configuration can result in loops crashing the simulator
MultiplexerStyle = 'custom'		# 'custom': using our hard-coded MUX-4 and MUX-16; 'generic': using standard generic RTL code
SwitchMatrixDebugSignals = True		# generate switch matrix select signals (index) which is useful to verify if bitstream matches bitstream
SuperTileEnable = True		# enable SuperTile generation

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
VHDL_file_position=1
TileType_position=1

# BEL prefix field (needed to allow multiple instantiations of the same BEL inside the same tile)
BEL_prefix=2
# MISC
All_Directions = ['NORTH', 'EAST', 'SOUTH', 'WEST']
Opposite_Directions = {"NORTH":"SOUTH", "EAST":"WEST", "SOUTH":"NORTH", "WEST":"EAST"}

# Given a fabric array description, return all uniq cell types
def GetCellTypes( list ):
    # make the fabric flat
    flat_list = []
    for sublist in list:
        for item in sublist:
            flat_list.append(item)

    output = []
    for item in flat_list:
        if item not in output:
            output.append(item)

    # we use the keyword 'NULL' for padding tiles that we don't return
    if ('NULL' in output):
        output.remove('NULL')

    return output;

# take a list and remove all items that contain a #    and remove empty lines
def RemoveComments( list ):
    output = []

    for line in list:
        templine = []
        marker = False        # we use this marker to remember if we had an '#' element before
        for item in line:
            if item.startswith('#'):
                marker = True
            if not (item.startswith('#') or marker == True):
                # marker = True
                templine.append(item)
                if item == '':
                    templine.remove('')
        if templine != []:
            output.append(templine)
    return output;

def GetFabric( list, filter = 'Fabric' ):
    templist = []
    # output = []
    marker = False

    for sublist in list:
        if filter+'End' in sublist:            # was FabricEnd
            marker = False
        if marker == True:
            templist.append(sublist)
        # we place this conditional after the append such that the 'FabricBegin' will be kicked out
        if filter+'Begin' in sublist:        # was FabricBegin
            marker = True
    return RemoveComments(templist)

def GetTileFromFile( list, TileType ):
    templist = []
    # output = []
    marker = False

    for sublist in list:
        if ('EndTILE' in sublist):
            marker = False
        if ('TILE' in sublist) and (TileType in sublist):
            marker = True
        if marker == True:
            templist.append(sublist)
        # we place this conditional after the append such that the 'FabricBegin' will be kicked out
        # if ('TILE' in sublist) and (type in sublist):
        # if ('TILE' in sublist) and (TileType in sublist):
            # marker = True
    return RemoveComments(templist)

def GetSuperTileFromFile( list ):
    templist = []
    tempdict = {}
    superTile_type = ''
    marker = False
    for sublist in list:
        if 'SuperTILE' in sublist:
            marker = True
            superTile_type = sublist[1]
            continue
        elif 'EndSuperTILE' in sublist:
            marker = False
            tempdict[superTile_type] = RemoveComments(templist)
            templist = []
            continue
        if marker == True:
            templist.append(sublist)
    return tempdict

def PrintTileComponentPort (tile_description, entity, direction, file ):
    print('\t-- ',direction, file=file)
    for line in tile_description:
        if line[0] == direction:
            print('\t\t',line[source_name], '\t: out \tSTD_LOGIC_VECTOR( ', end='', file=file)
            print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1, end='', file=file)
            print(' downto 0 );', end='', file=file)
            print('\t -- wires: ', line[wires], file=file)
    for line in tile_description:
        if line[0] == direction:
            print('\t\t',line[destination_name], '\t: in \tSTD_LOGIC_VECTOR( ', end='', file=file)
            print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1, end='', file=file)
            print(' downto 0 );', end='', file=file)
            print('\t -- wires: ', line[wires], file=file)
    return

def replace(string, substitutions):
    substrings = sorted(substitutions, key=len, reverse=True)
    regex = re.compile('|'.join(map(re.escape, substrings)))
    return regex.sub(lambda match: substitutions[match.group(0)], string)

def PrintComponentDeclarationForFile(VHDL_file_name, file ):
    ConfigPortUsed = 0 # 1 means is used
    VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
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
            print(re.sub('entity', 'component', line, flags=re.IGNORECASE), file=file)
        if re.search('^entity', line, flags=re.IGNORECASE):
            # print(str.replace('^entity', line))
            # re.sub('\$noun\$', 'the heck', 'What $noun$ is $verb$?')
            print(re.sub('entity', 'component', line, flags=re.IGNORECASE), file=file)
            marker = True
        if re.search('^end ', line, flags=re.IGNORECASE):
            marker = False
    print('', file=file)
    return ConfigPortUsed

def GetComponentPortsFromFile( VHDL_file_name, filter = 'ALL', port = 'internal', BEL_Prefix = '' ):
    VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
    Inputs = []
    Outputs = []
    ExternalPorts = []
    marker = False
    FoundEntityMarker = False
    DoneMarker = False
    direction = ''
    for line in VHDLfile:
        # the order of the if-statements are important ;
        if re.search('^entity', line, flags=re.IGNORECASE):
            FoundEntityMarker = True

        # detect the direction from comments, like "--NORTH"
        # we need this to filter for a specific direction
        # this implies of course that this information is provided in the VHDL entity
        if re.search('NORTH', line, flags=re.IGNORECASE):
            direction = 'NORTH'
        if re.search('EAST', line, flags=re.IGNORECASE):
            direction = 'EAST'
        if re.search('SOUTH', line, flags=re.IGNORECASE):
            direction = 'SOUTH'
        if re.search('WEST', line, flags=re.IGNORECASE):
            direction = 'WEST'

        # all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
        if re.search('-- global', line, flags=re.IGNORECASE):
            FoundEntityMarker = False
            marker = False
            DoneMarker = True

        if (marker == True) and (DoneMarker == False) and (direction == filter or filter == 'ALL') :
            # detect if the port has to be exported as EXTERNAL which is flagged by the comment
            if re.search('EXTERNAL', line):
                External = True
            else:
                External = False
            if re.search('CONFIG_PORT', line):
                Config = True
            else:
                Config = False
            # get rid of everything with and after the ';' that will also remove comments
            # substitutions = {';.*', '', '--.*', '', ',.*', ''}
            # tmp_line=(replace(line, substitutions))
            # tmp_line = (re.sub(';.*', '',(re.sub('--.*', '',line, flags=re.IGNORECASE)), flags=re.IGNORECASE))
            tmp_line = (re.sub(';.*', '',(re.sub('--.*', '',(re.sub(',.*', '', line, flags=re.IGNORECASE)), flags=re.IGNORECASE)), flags=re.IGNORECASE))
            std_vector = ''
            if re.search('std_logic_vector', tmp_line, flags=re.IGNORECASE):
                std_vector =  (re.sub('.*std_logic_vector', '', tmp_line, flags=re.IGNORECASE))
            tmp_line = (re.sub('STD_LOGIC.*', '', tmp_line, flags=re.IGNORECASE))

            substitutions = {" ": "", "\t": ""}
            tmp_line=(replace(tmp_line, substitutions))
            # at this point, we get clean port names, like
            # A0:in
            # A1:in
            # A2:in
            # The following is for internal fabric signal ports (e.g., a CLB/LUT)
            if (port == 'internal') and (External == False) and (Config == False):
                if re.search(':in', tmp_line, flags=re.IGNORECASE):
                    Inputs.append(BEL_Prefix+(re.sub(':in.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
                if re.search(':out', tmp_line, flags=re.IGNORECASE):
                    Outputs.append(BEL_Prefix+(re.sub(':out.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
            # The following is for ports that have to go all the way up to the top-level entity (e.g., from an I/O cell)
            if (port == 'external') and (External == True):
                # .lstrip() removes leading white spaces including ' ', '\t'
                ExternalPorts.append(BEL_Prefix+line.lstrip())

            # frame reconfiguration needs a port for writing in frame data
            if (port == 'frame_config') and (Config == True):
                # .lstrip() removes leading white spaces including ' ', '\t'
                ExternalPorts.append(BEL_Prefix+line.lstrip())

        if re.search('port', line, flags=re.IGNORECASE):
            marker = True
    if port == 'internal':             # default
        return Inputs, Outputs
    else:
        return ExternalPorts

def GetComponentPortsFromVerilog( Verilog_file_name, filter = 'ALL', port = 'internal', BEL_Prefix = '' ):
    Verilogfile = [line.rstrip('\n') for line in open(Verilog_file_name)]
    Inputs = []
    Outputs = []
    ExternalPorts = []
    marker = False
    FoundEntityMarker = False
    DoneMarker = False
    direction = ''
    for line in Verilogfile:
        # the order of the if-statements are important ;
        if re.search('^module', line, flags=re.IGNORECASE):
            FoundEntityMarker = True

        # detect the direction from comments, like "--NORTH"
        # we need this to filter for a specific direction
        # this implies of course that this information is provided in the VHDL entity
        if re.search('NORTH', line, flags=re.IGNORECASE):
            direction = 'NORTH'
        if re.search('EAST', line, flags=re.IGNORECASE):
            direction = 'EAST'
        if re.search('SOUTH', line, flags=re.IGNORECASE):
            direction = 'SOUTH'
        if re.search('WEST', line, flags=re.IGNORECASE):
            direction = 'WEST'

        # all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
        if re.search('// global', line, flags=re.IGNORECASE):
            FoundEntityMarker = False
            marker = False
            DoneMarker = True

        if (marker == True) and (DoneMarker == False) and (direction == filter or filter == 'ALL') :
            # detect if the port has to be exported as EXTERNAL which is flagged by the comment
            if re.search('EXTERNAL', line):
                External = True
            else:
                External = False
            if re.search('CONFIG_PORT', line):
                Config = True
            else:
                Config = False
            # get rid of everything with and after the ';' that will also remove comments
            # substitutions = {';.*', '', '--.*', '', ',.*', ''}
            # tmp_line=(replace(line, substitutions))
            # tmp_line = (re.sub(';.*', '',(re.sub('--.*', '',line, flags=re.IGNORECASE)), flags=re.IGNORECASE))
            tmp_line = (re.sub(';.*', '',(re.sub('//.*', '',(re.sub(',.*', '', line, flags=re.IGNORECASE)), flags=re.IGNORECASE)), flags=re.IGNORECASE))
            std_vector = ''
            if re.search('input', tmp_line, flags=re.IGNORECASE) or re.search('output', tmp_line, flags=re.IGNORECASE):
                std_vector =  (re.sub('.*std_logic_vector', '', tmp_line, flags=re.IGNORECASE))
            tmp_line = (re.sub('STD_LOGIC.*', '', tmp_line, flags=re.IGNORECASE))

            substitutions = {" ": "", "\t": ""}
            tmp_line=(replace(tmp_line, substitutions))
            # at this point, we get clean port names, like
            # A0:in
            # A1:in
            # A2:in
            # The following is for internal fabric signal ports (e.g., a CLB/LUT)
            if (port == 'internal') and (External == False) and (Config == False):
                if re.search(':in', tmp_line, flags=re.IGNORECASE) and 'integer' not in tmp_line:
                    Inputs.append(BEL_Prefix+(re.sub(':in.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
                if re.search(':out', tmp_line, flags=re.IGNORECASE):
                    Outputs.append(BEL_Prefix+(re.sub(':out.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
            # The following is for ports that have to go all the way up to the top-level entity (e.g., from an I/O cell)
            if (port == 'external') and (External == True):
                # .lstrip() removes leading white spaces including ' ', '\t'
                ExternalPorts.append(BEL_Prefix+line.lstrip())

            # frame reconfiguration needs a port for writing in frame data
            if (port == 'frame_config') and (Config == True):
                # .lstrip() removes leading white spaces including ' ', '\t'
                ExternalPorts.append(BEL_Prefix+line.lstrip())

        if re.search('port', line, flags=re.IGNORECASE):
            marker = True
    if port == 'internal':             # default
        return Inputs, Outputs
    else:
        return ExternalPorts

def GetNoConfigBitsFromFile( VHDL_file_name ):
    VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
    result='NULL'
    for line in VHDLfile:
        # the order of the if-statements is important
        # if re.search('Generic', line, flags=re.IGNORECASE) and re.search('NoConfigBits', line, flags=re.IGNORECASE):
        if re.search('integer', line, flags=re.IGNORECASE) and re.search('NoConfigBits', line, flags=re.IGNORECASE):
            result = (re.sub(' ','', (re.sub('\).*', '', (re.sub('.*=', '', line, flags=re.IGNORECASE)), flags=re.IGNORECASE))))
    return result

def GetComponentEntityNameFromFile( VHDL_file_name ):
    VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
    for line in VHDLfile:
        # the order of the if-statements is important
        if re.search('^entity', line, flags=re.IGNORECASE):
            result = (re.sub(' ','', (re.sub('entity', '', (re.sub(' is.*', '', line, flags=re.IGNORECASE)), flags=re.IGNORECASE))))
    return result

def GetComponentEntityNameFromVerilog( Verilog_file_name ):
    Verilogfile = [line.rstrip('\n') for line in open(Verilog_file_name)]
    for line in Verilogfile:
        # the order of the if-statements is important
        if re.search('^module', line, flags=re.IGNORECASE):
            result = (re.sub(' ','', (re.sub('module', '', (re.sub(' (.*', '', line, flags=re.IGNORECASE)), flags=re.IGNORECASE))))
    return result

def BootstrapSwitchMatrix( tile_description, TileType, filename ):
    Inputs = []
    Outputs = []
    result = []
    # get the >>tile ports<< that connect to the outside world (these are from the NORTH EAST SOUTH WEST entries from the csv file section
    # 'N1END0', 'N1END1' ... 'N1BEG0', 'N1BEG1', 'N1BEG2', 'N2BEG0',
    # will only be WIRES ports as the rest is eventually used for cascading
    Inputs, Outputs = GetTileComponentPorts(tile_description, mode='AutoSwitchMatrix')
    # Inputs, Outputs = GetTileComponentPorts(tile_description, mode='SwitchMatrix')
    # get all >>BEL ports<<< as defined by the BELs from the VHDL files
    for line in tile_description:
        if line[0] == 'BEL':
            tmp_Inputs = []
            tmp_Outputs = []
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            tmp_Inputs, tmp_Outputs = GetComponentPortsFromFile(line[VHDL_file_position], BEL_Prefix=BEL_prefix_string)
            # print('tmp_Inputs Inputs',tmp_Inputs)
            # IMPORTANT: the outputs of a BEL are the inputs to the switch matrix!
            Inputs = Inputs + tmp_Outputs
            # print('next Inputs',Inputs)
            # Outputs.append(tmp_Outputs)
            # IMPORTANT: the inputs to a BEL are the outputs of the switch matrix!
            Outputs = Outputs + tmp_Inputs
    # get all >>JUMP ports<<< (stop over ports that are input and output and that stay in the tile) as defined by the JUMP entries in the CSV file
    for line in tile_description:
        if line[0] == 'JUMP':
            # tmp_Inputs = []
            # tmp_Outputs = []
            for k in range(int(line[wires])):
                # the NULL check in the following allows us to have just source ports, such as GND or VCC
                if line[destination_name] != 'NULL':
                    Inputs.append(str(line[destination_name])+str(k))
                if line[source_name] != 'NULL':
                    Outputs.append(str(line[source_name])+str(k))
    # generate the matrix
    NumberOfInputs=len(Inputs)
    NumberOfOutputs=len(Outputs)
    # initialize with 0
    for output in range(NumberOfOutputs+1):
        one_line = []
        for input in range(NumberOfInputs+1):
            # one_line.append(str(output)+'_'+str(input))
            one_line.append(str(0))
        result.append(one_line)
    # annotate input and output names
    result[0][0] = TileType
    for k in range(0,NumberOfOutputs):
        result[k+1][0] = Outputs[k]
    for k in range(0,NumberOfInputs):
        result[0][k+1] = Inputs[k]
    # result     CLB,    N1END0, N1END1, N1END2, ...
    # result     N1BEG0,    0,        0,        0, ...
    # result     N1BEG1,    0,        0,        0, ...
    # I found something that writes the csv file
    # import numpy
    # tmp = array.zeros((NumberOfInputs+1,NumberOfOutputs+1)) #np.zeros(20).reshape(NumberOfInputs,NumberOfOutputs)
    # array = np.array([(1,2,3), (4,5,6)])
    tmp = numpy.asarray(result)
    if filename != '':
        numpy.savetxt(filename, tmp, fmt='%s', delimiter=",")
    return Inputs, Outputs

def PrintTileComponentPort (tile_description, entity, direction, file ):
    print('\t-- ',direction, file=file)
    for line in tile_description:
        if line[0] == direction:
            if line[source_name] != 'NULL':
                print('\t\t',line[source_name], '\t: out \tSTD_LOGIC_VECTOR( ', end='', file=file)
                print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1, end='', file=file)
                print(' downto 0 );', end='', file=file)
                print('\t -- wires:'+line[wires], end=' ', file=file)
                print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
    for line in tile_description:
        if line[0] == direction:
            if line[destination_name] != 'NULL':
                print('\t\t',line[destination_name], '\t: in \tSTD_LOGIC_VECTOR( ', end='', file=file)
                print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1, end='', file=file)
                print(' downto 0 );', end='', file=file)
                print('\t -- wires:'+line[wires], end=' ', file=file)
                print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
    return

def GetTileComponentPorts( tile_description, mode='SwitchMatrix'):
    Inputs = []
    Outputs = []
    OpenIndex = ''
    CloseIndex = ''
    if re.search('Indexed', mode, flags=re.IGNORECASE):
        OpenIndex = '('
        CloseIndex = ')'
    for line in tile_description:
        if (line[direction] == 'NORTH') or (line[direction] == 'EAST') or (line[direction] == 'SOUTH') or (line[direction] == 'WEST'):
            # range (wires-1 downto 0) as connected to the switch matrix
            if mode in ['SwitchMatrix','SwitchMatrixIndexed']:
                ThisRange = int(line[wires])
            if mode in ['AutoSwitchMatrix','AutoSwitchMatrixIndexed']:
                if line[source_name] == 'NULL' or line[destination_name] == 'NULL':
            # the following line connects all wires to the switch matrix in the case one port is NULL (typically termination)
                    ThisRange = (abs(int(line[X_offset]))+abs(int(line[Y_offset]))) * int(line[wires])
                else:
            # the following line connects all bottom wires to the switch matrix in the case begin and end ports are used
                    ThisRange = int(line[wires])
            # range ((wires*distance)-1 downto 0) as connected to the tile top
            if mode in ['all','allIndexed','Top','TopIndexed','AutoTop','AutoTopIndexed']:
                ThisRange = (abs(int(line[X_offset]))+abs(int(line[Y_offset]))) * int(line[wires])
            # the following three lines are needed to get the top line[wires] that are actually the connection from a switch matrix to the routing fabric
            StartIndex = 0
            if mode in ['Top','TopIndexed']:
                StartIndex = ((abs(int(line[X_offset]))+abs(int(line[Y_offset])))-1) * int(line[wires])
            if mode in ['AutoTop','AutoTopIndexed']:
                if line[source_name] == 'NULL' or line[destination_name] == 'NULL':
                    # in case one port is NULL, then the all the other port wires get connected to the switch matrix.
                    StartIndex = 0
                else:
                    # "normal" case as for the CLBs
                    StartIndex = ((abs(int(line[X_offset]))+abs(int(line[Y_offset])))-1) * int(line[wires])
            for i in range(StartIndex, ThisRange):
                if line[destination_name] != 'NULL':
                    Inputs.append(line[destination_name]+OpenIndex+str(i)+CloseIndex)
                if line[source_name] != 'NULL':
                    Outputs.append(line[source_name]+OpenIndex+str(i)+CloseIndex)
    return Inputs, Outputs

def GetTileComponentPortsVectors( tile_description, mode ):
    Inputs = []
    Outputs = []
    MaxIndex = 0
    for line in tile_description:
        if (line[direction] == 'NORTH') or (line[direction] == 'EAST') or (line[direction] == 'SOUTH') or (line[direction] == 'WEST'):
            # range (wires-1 downto 0) as connected to the switch matrix
            if mode in ['SwitchMatrix','SwitchMatrixIndexed']:
                MaxIndex = int(line[wires])
            # range ((wires*distance)-1 downto 0) as connected to the tile top
            if mode in ['all','allIndexed']:
                MaxIndex = (abs(int(line[X_offset]))+abs(int(line[Y_offset]))) * int(line[wires])
            if line[destination_name] != 'NULL':
                Inputs.append(str(line[destination_name]+'('+str(MaxIndex)+' downto 0)'))
            if line[source_name] != 'NULL':
                Outputs.append(str(line[source_name]+'('+str(MaxIndex)+' downto 0)'))
    return Inputs, Outputs

def GenerateVHDL_Header( file, entity, package='' , NoConfigBits='0', MaxFramesPerCol='NULL', FrameBitsPerRow='NULL'):
    #   library template
    print('library IEEE;', file=file)
    print('use IEEE.STD_LOGIC_1164.ALL;', file=file)
    print('use IEEE.NUMERIC_STD.ALL;', file=file)
    if package != '':
        print(package, file=file)
    print('', file=file)
    #   entity
    print('entity ',entity,' is ', file=file)
    print('\tGeneric ( ', file=file)
    if MaxFramesPerCol != 'NULL':
        print('\t\t\t MaxFramesPerCol : integer := '+MaxFramesPerCol+';', file=file)
    if FrameBitsPerRow != 'NULL':
        print('\t\t\t FrameBitsPerRow : integer := '+FrameBitsPerRow+';', file=file)
    print('\t\t\t NoConfigBits : integer := '+NoConfigBits+' );', file=file)
    print('\tPort (', file=file)
    return

def GenerateVHDL_EntityFooter ( file, entity, ConfigPort=True , NumberOfConfigBits = ''):
    if ConfigPort==False:
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

        file.seek(last_pos-1)           # place seek pointer to last ';' position and overwrite with a space
        print(' ', end='', file=file)
        file.seek(0, os.SEEK_END)          # go back to usual...
        # file.seek(interupt_pos)

        # file.seek(0, os.SEEK_END)                      # seek to end of file; f.seek(0, 2) is legal
        # file.seek(file.tell() - 3, os.SEEK_SET)     # go backwards 3 bytes
        # file.truncate()


        print('', file=file)
    print('\t-- global', file=file)
    if ConfigPort==True:
        if ConfigBitMode == 'FlipFlopChain':
            print('\t\t MODE\t: in \t STD_LOGIC;\t -- global signal 1: configuration, 0: operation', file=file)
            print('\t\t CONFin\t: in \t STD_LOGIC;', file=file)
            print('\t\t CONFout\t: out \t STD_LOGIC;', file=file)
            print('\t\t CLK\t: in \t STD_LOGIC', file=file)
        if ConfigBitMode == 'frame_based':
            print('\t\t ConfigBits : in \t STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )', file=file)
    print('\t);', file=file)
    print('end entity',entity,';', file=file)
    print('', file=file)
    #   architecture
    print('architecture Behavioral of ',entity,' is ', file=file)
    print('', file=file)
    return

def GenerateVHDL_Conf_Instantiation ( file, counter, close=True ):
    print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
    print('\t\t MODE    => Mode,  ', file=file)
    print('\t\t CONFin    => conf_data('+str(counter)+'),  ', file=file)
    print('\t\t CONFout    => conf_data('+str(counter+1)+'),  ', file=file)
    if close==True:
        print('\t\t CLK => CLK );  \n', file=file)
    else:
        print('\t\t CLK => CLK   ', file=file)
    return

def GenerateTileVHDL( tile_description, entity, file ):
    MatrixInputs = []
    MatrixOutputs = []
    TileInputs = []
    TileOutputs = []
    BEL_Inputs = []
    BEL_Outputs = []
    AllJumpWireList = []
    NuberOfSwitchMatricesWithConfigPort = 0

    # We first check if we need a configuration port
    # Currently we assume that each primitive needs a configuration port
    # However, a switch matrix can have no switch matrix multiplexers
    # (e.g., when only bouncing back in border termination tiles)
    # we can detect this as each switch matrix file contains a comment -- NumberOfConfigBits
    # NumberOfConfigBits:0 tells us that the switch matrix does not have a config port
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning

    TileTypeMarker = False
    for line in tile_description:
        if line[0] == 'TILE':
            TileType = line[TileType_position]
            TileTypeMarker = True
    if TileTypeMarker == False:
        raise ValueError('Could not find tile type in function GenerateTileVHDL')

    # the VHDL initial header generation is shared until the Port
    # in order to use GenerateVHDL_Header, we have to count the number of configuration bits by scanning all files for the "Generic ( NoConfigBits...
    GlobalConfigBitsCounter = 0
    if ConfigBitMode == 'frame_based':
        for line in tile_description:
            if (line[0] == 'BEL') or (line[0] == 'MATRIX'):
                if (GetNoConfigBitsFromFile(line[VHDL_file_position])) != 'NULL':
                    GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(GetNoConfigBitsFromFile(line[VHDL_file_position]))
    # GenerateVHDL_Header(file, entity, NoConfigBits=str(GlobalConfigBitsCounter))
    GenerateVHDL_Header(file, entity, package=Package, NoConfigBits=str(GlobalConfigBitsCounter), MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow))
    PrintTileComponentPort (tile_description, entity, 'NORTH', file)
    PrintTileComponentPort (tile_description, entity, 'EAST', file)
    PrintTileComponentPort (tile_description, entity, 'SOUTH', file)
    PrintTileComponentPort (tile_description, entity, 'WEST', file)
    # now we have to scan all BELs if they use external pins, because they have to be exported to the tile entity
    ExternalPorts = []
    for line in tile_description:
        if line[0] == 'BEL':
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            ExternalPorts = ExternalPorts + (GetComponentPortsFromFile(line[VHDL_file_position], port='external', BEL_Prefix = BEL_prefix_string+'BEL_prefix_string_marker'))
    # if we found BELs with top-level IO ports, we just pass them through
    SharedExternalPorts = []
    if ExternalPorts != []:
        print('\t-- Tile IO ports from BELs', file=file)
        for item in ExternalPorts:
            # if a part is flagged with the 'SHARED_PORT' comment, we declare that port only ones
            # we use the string 'BEL_prefix_string_marker' to separate the port name from the prefix
            if re.search('SHARED_PORT', item):
                # we firstly get the plain port name without comments, whitespaces, etc.
                # we place that in the SharedExternalPorts list to check if that port was declared earlier
                shared_port = re.sub(':.*', '',re.sub('.*BEL_prefix_string_marker', '', item)).strip()
                if shared_port not in SharedExternalPorts:
                    if ';' not in re.sub('.*BEL_prefix_string_marker', '', item):
                        temp_str = re.sub('.*BEL_prefix_string_marker', '', item)
                        print('\t\t'+temp_str.replace("STD_LOGIC","STD_LOGIC;"), file=file)
                    else:
                        print('\t\t',re.sub('.*BEL_prefix_string_marker', '', item), file=file)
                    SharedExternalPorts.append(shared_port)
            else:
                print('\t\t',re.sub('BEL_prefix_string_marker', '', item), file=file)
    # the rest is a shared text block
    if ConfigBitMode == 'frame_based':
        if GlobalConfigBitsCounter > 0:
            print('\t\t FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            print('\t\t FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ', file=file)
        GenerateVHDL_EntityFooter(file, entity, ConfigPort=False)
    else:
        GenerateVHDL_EntityFooter(file, entity)

    # insert CLB, I/O (or whatever BEL) component declaration
    # specified in the fabric csv file after the 'BEL' key word
    BEL_VHDL_riles_processed = []     # we use this list to check if we have seen a BEL description before so we only insert one component declaration
    for line in tile_description:
        if line[0] == 'BEL':
            Inputs = []
            Outputs = []
            if line[VHDL_file_position] not in BEL_VHDL_riles_processed:
                PrintComponentDeclarationForFile(line[VHDL_file_position], file)
            BEL_VHDL_riles_processed.append(line[VHDL_file_position])
            # we need the BEL ports (a little later) so we take them on the way
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            Inputs, Outputs = GetComponentPortsFromFile(line[VHDL_file_position], BEL_Prefix=BEL_prefix_string)
            BEL_Inputs = BEL_Inputs + Inputs
            BEL_Outputs = BEL_Outputs + Outputs
    print('', file=file)

    # insert switch matrix component declaration
    # specified in the fabric csv file after the 'MATRIX' key word
    MatrixMarker = False
    for line in tile_description:
        if line[0] == 'MATRIX':
            if MatrixMarker == True:
                raise ValueError('More than one switch matrix defined for tile '+TileType+'; exeting GenerateTileVHDL')
            NuberOfSwitchMatricesWithConfigPort = NuberOfSwitchMatricesWithConfigPort + PrintComponentDeclarationForFile(line[VHDL_file_position], file)
            # we need the switch matrix ports (a little later)
            MatrixInputs, MatrixOutputs = GetComponentPortsFromFile(line[VHDL_file_position])
            MatrixMarker = True
    print('', file=file)
    if MatrixMarker == False:
        raise ValueError('Could not find switch matrix definition for tyle type '+TileType+' in function GenerateTileVHDL')

    if ConfigBitMode == 'frame_based' and GlobalConfigBitsCounter > 0:
        PrintComponentDeclarationForFile(entity+'_ConfigMem.vhdl', file)

    # VHDL signal declarations
    print('-- signal declarations'+'\n', file=file)
    # BEL port wires
    print('-- BEL ports (e.g., slices)', file=file)
    for port in (BEL_Inputs + BEL_Outputs):
        print('signal\t'+port+'\t:STD_LOGIC;', file=file)
    # Jump wires
    print('-- jump wires', file=file)
    for line in tile_description:
        if line[0] == 'JUMP':
            if (line[source_name] == '') or (line[destination_name] == ''):
                raise ValueError('Either source or destination port for JUMP wire missing in function GenerateTileVHDL')
            # we don't add ports or a corresponding signal name, if we have a NULL driver (which we use as an exception for GND and VCC (VCC0 GND0)
            if not re.search('NULL', line[source_name], flags=re.IGNORECASE):
                print('signal\t',line[source_name], '\t:\tSTD_LOGIC_VECTOR('+str(line[wires])+' downto 0);', file=file)
            # we need the jump wires for the switch matrix component instantiation..
                for k in range(int(line[wires])):
                    AllJumpWireList.append(str(line[source_name]+'('+str(k)+')'))
    # internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
    print('-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)', file=file)
    # the signal has to be number of BELs+2 bits wide (Bel_counter+1 downto 0)
    BEL_counter = 0
    for line in tile_description:
        if line[0] == 'BEL':
            BEL_counter += 1

    # we chain switch matrices only to the configuration port, if they really contain configuration bits
    # i.e. switch matrices have a config port which is indicated by "NumberOfConfigBits:0 is false"

    # The following conditional as intended to only generate the config_data signal if really anything is actually configured
    # however, we leave it and just use this signal as conf_data(0 downto 0) for simply touting through CONFin to CONFout
    # maybe even useful if we want to add a buffer here
    # if (Bel_Counter + NuberOfSwitchMatricesWithConfigPort) > 0
    print('signal\t'+'conf_data'+'\t:\t STD_LOGIC_VECTOR('+str(BEL_counter+NuberOfSwitchMatricesWithConfigPort)+' downto 0);', file=file)
    if GlobalConfigBitsCounter > 0:
        print('signal \t ConfigBits :\t STD_LOGIC_VECTOR (NoConfigBits -1 downto 0);', file=file)

    #   architecture body
    print('\n'+'begin'+'\n', file=file)

    # Cascading of routing for wires spanning more than one tile
    print('-- Cascading of routing for wires spanning more than one tile', file=file)
    for line in tile_description:
        if line[0] in ['NORTH','EAST','SOUTH','WEST']:
            span=abs(int(line[X_offset]))+abs(int(line[Y_offset]))
            # in case a signal spans 2 ore more tiles in any direction
            if (span >= 2) and (line[source_name]!='NULL') and (line[destination_name]!='NULL'):
                print(line[source_name]+'('+line[source_name]+'\'high - '+str(line[wires])+' downto 0)',end='', file=file)
                print(' <= '+line[destination_name]+'('+line[destination_name]+'\'high downto '+str(line[wires])+');', file=file)

    # top configuration data daisy chaining
    if ConfigBitMode == 'FlipFlopChain':
        print('-- top configuration data daisy chaining', file=file)
        print('conf_data(conf_data\'low) <= CONFin; -- conf_data\'low=0 and CONFin is from tile entity', file=file)
        print('CONFout <= conf_data(conf_data\'high); -- CONFout is from tile entity', file=file)

    # the <entity>_ConfigMem module is only parametrized through generics, so we hard code its instantiation here
    if ConfigBitMode == 'frame_based' and GlobalConfigBitsCounter > 0:
        print('\n-- configuration storage latches', file=file)
        print('Inst_'+entity+'_ConfigMem : '+entity+'_ConfigMem', file=file)
        print('\tPort Map( ' , file=file)
        print('\t\t FrameData  \t =>\t FrameData, ' , file=file)
        print('\t\t FrameStrobe \t =>\t FrameStrobe, ' , file=file)
        print('\t\t ConfigBits \t =>\t ConfigBits  );' , file=file)

    # BEL component instantiations
    print('\n-- BEL component instantiations\n', file=file)
    All_BEL_Inputs = []                # the right hand signal name which gets a BEL prefix
    All_BEL_Outputs = []            # the right hand signal name which gets a BEL prefix
    left_All_BEL_Inputs = []        # the left hand port name which does not get a BEL prefix
    left_All_BEL_Outputs = []        # the left hand port name which does not get a BEL prefix
    BEL_counter = 0
    BEL_ConfigBitsCounter = 0
    for line in tile_description:
        if line[0] == 'BEL':
            BEL_Inputs = []            # the right hand signal name which gets a BEL prefix
            BEL_Outputs = []        # the right hand signal name which gets a BEL prefix
            left_BEL_Inputs = []    # the left hand port name which does not get a BEL prefix
            left_BEL_Outputs = []    # the left hand port name which does not get a BEL prefix
            ExternalPorts = []
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            # the BEL I/Os that go to the switch matrix
            BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position], BEL_Prefix=BEL_prefix_string)
            left_BEL_Inputs, left_BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
            # the BEL I/Os that go to the tile top entity
            # ExternalPorts           = GetComponentPortsFromFile(line[VHDL_file_position], port='external', BEL_Prefix=BEL_prefix_string)
            ExternalPorts           = GetComponentPortsFromFile(line[VHDL_file_position], port='external')
            # we remember All_BEL_Inputs and All_BEL_Outputs as wee need these pins for the switch matrix
            All_BEL_Inputs  = All_BEL_Inputs + BEL_Inputs
            All_BEL_Outputs = All_BEL_Outputs + BEL_Outputs
            left_All_BEL_Inputs  = left_All_BEL_Inputs  + left_BEL_Inputs
            left_All_BEL_Outputs = left_All_BEL_Outputs + left_BEL_Outputs
            EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
            print('Inst_'+BEL_prefix_string+EntityName+' : '+EntityName, file=file)
            print('\tPort Map(', file=file)

            for k in range(len(BEL_Inputs+BEL_Outputs)):
                print('\t\t',(left_BEL_Inputs+left_BEL_Outputs)[k],' => ',(BEL_Inputs+BEL_Outputs)[k],',', file=file)
            # top level I/Os (if any) just get connected directly
            if ExternalPorts != []:
                print('\t -- I/O primitive pins go to tile top level entity (not further parsed)  ', file=file)
                for item in ExternalPorts:
                    # print('DEBUG ExternalPort :',item)

                    port = re.sub('\:.*', '', item)
                    substitutions = {" ": "", "\t": ""}
                    port=(replace(port, substitutions))
                    if re.search('SHARED_PORT', item):
                        print('\t\t',port,' => '+port,',', file=file)
                    else:  # if not SHARED_PORT then add BEL_prefix_string to signal name
                        print('\t\t',port,' => '+BEL_prefix_string+port,',', file=file)

            # global configuration port
            if ConfigBitMode == 'FlipFlopChain':
                GenerateVHDL_Conf_Instantiation(file=file, counter=BEL_counter, close=True)
            if ConfigBitMode == 'frame_based':
                BEL_ConfigBits = GetNoConfigBitsFromFile(line[VHDL_file_position])
                if BEL_ConfigBits != 'NULL':
                    if int(BEL_ConfigBits) == 0:
                        last_pos = file.tell()
                        for k in range(20):
                           file.seek(last_pos -k)                # scan character by character backwards and look for ','
                           my_char = file.read(1)
                           if my_char == ',':
                               file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
                               print(' ', end='', file=file)
                               break                            # stop scan
                        file.seek(0, os.SEEK_END)          # go back to usual...
                        #print('\t\t ConfigBits => (others => \'-\') );\n', file=file)
                        print('\t\t );\n', file=file)
                    else:
                        print('\t\t ConfigBits => ConfigBits ( '+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+' -1 downto '+str(BEL_ConfigBitsCounter)+' ) );\n', file=file)
                        BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
            # for the next BEL (if any) for cascading configuration chain (this information is also needed for chaining the switch matrix)
            BEL_counter += 1

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

    print('\n-- switch matrix component instantiation\n', file=file)
    for line in tile_description:
        if line[0] == 'MATRIX':
            BEL_Inputs = []
            BEL_Outputs = []
            BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
            EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
            print('Inst_'+EntityName+' : '+EntityName, file=file)
            print('\tPort Map(', file=file)
            # for port in BEL_Inputs + BEL_Outputs:
                # print('\t\t',port,' => ',port,',', file=file)
            Inputs = []
            Outputs = []
            TopInputs = []
            TopOutputs = []
            # Inputs, Outputs = GetTileComponentPorts(tile_description, mode='SwitchMatrixIndexed')
            # changed to:  AutoSwitchMatrixIndexed
            Inputs, Outputs = GetTileComponentPorts(tile_description, mode='AutoSwitchMatrixIndexed')
            # TopInputs, TopOutputs = GetTileComponentPorts(tile_description, mode='TopIndexed')
            # changed to: AutoTopIndexed
            TopInputs, TopOutputs = GetTileComponentPorts(tile_description, mode='AutoTopIndexed')
            for k in range(len(BEL_Inputs+BEL_Outputs)):
                print('\t\t',(BEL_Inputs+BEL_Outputs)[k],' => ',end='', file=file)
                # note that the BEL outputs (e.g., from the slice component) are the switch matrix inputs
                print((Inputs+All_BEL_Outputs+AllJumpWireList+TopOutputs+All_BEL_Inputs+AllJumpWireList)[k], end='', file=file)
                if NuberOfSwitchMatricesWithConfigPort > 0:
                    print(',', file=file)
                else:
                    # stupid VHDL does not allow us to have a ',' for the last port connection, so we need the following for NuberOfSwitchMatricesWithConfigPort==0
                    if k < ((len(BEL_Inputs+BEL_Outputs)) - 1):
                        print(',', file=file)
            if NuberOfSwitchMatricesWithConfigPort > 0:
                if ConfigBitMode == 'FlipFlopChain':
                    GenerateVHDL_Conf_Instantiation(file=file, counter=BEL_counter, close=False)
                    # print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
                    # print('\t\t MODE    => Mode,  ', file=file)
                    # print('\t\t CONFin    => conf_data('+str(BEL_counter)+'),  ', file=file)
                    # print('\t\t CONFout    => conf_data('+str(BEL_counter+1)+'),  ', file=file)
                    # print('\t\t CLK => CLK   ', file=file)
                if ConfigBitMode == 'frame_based':
                    BEL_ConfigBits = GetNoConfigBitsFromFile(line[VHDL_file_position])
                    if BEL_ConfigBits != 'NULL':
                    # print('DEBUG:',BEL_ConfigBits)
                        print('\t\t ConfigBits => ConfigBits ( '+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+' -1 downto '+str(BEL_ConfigBitsCounter)+' ) ', file=file)
                        BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
            print('\t\t );  ', file=file)
    print('\n'+'end Behavioral;'+'\n', file=file)
    return

def GenerateConfigMemInit( tile_description, entity, file, GlobalConfigBitsCounter ):
    # write configuration bits to frame mapping init file (e.g. 'LUT4AB_ConfigMem.init.csv')
    # this file can be modified and saved as 'LUT4AB_ConfigMem.csv' (without the '.init')
    BitsLeftToPackInFrames = GlobalConfigBitsCounter
    initCSV = []
    one_line = []
    one_line.append('#frame_name')
    one_line.append('frame_index')
    one_line.append('bits_used_in_frame')
    one_line.append('used_bits_mask')
    one_line.append('ConfigBits_ranges')
    initCSV.append(one_line)
    for k in range(int(MaxFramesPerCol)):
        one_line = []
        # frame0, frame1, ...
        one_line.append('frame'+str(k))
        # and the index (0, 1, 2, ...), in case we need
        one_line.append(str(k))
        # size of the frame in bits
        if BitsLeftToPackInFrames >= FrameBitsPerRow:
            one_line.append(str(FrameBitsPerRow))
            # generate a string encoding a '1' for each flop used
            FrameBitsMask = ('1' * FrameBitsPerRow)
            tmp_one_line = ''
            for k in range(len(FrameBitsMask)):
                tmp_one_line = tmp_one_line + FrameBitsMask[k]
                if ((k%4)==3) and (k != (len(FrameBitsMask)-1)):    # after every 4th character add a '_'
                    tmp_one_line = tmp_one_line + '_'                # some "pretty" printing, results in '1111_1111_1...'
            one_line.append(tmp_one_line)
            one_line.append(str(BitsLeftToPackInFrames-1)+':'+str(BitsLeftToPackInFrames-FrameBitsPerRow))
            BitsLeftToPackInFrames = BitsLeftToPackInFrames - FrameBitsPerRow
        else:
            one_line.append(str(BitsLeftToPackInFrames))
            # generate a string encoding a '1' for each flop used
            # this will allow us to kick out flops in the middle (e.g. for alignment padding)
            FrameBitsMask = ('1' * BitsLeftToPackInFrames + '0' * (FrameBitsPerRow-BitsLeftToPackInFrames))
            tmp_one_line = ''
            for k in range(len(FrameBitsMask)):
                tmp_one_line = tmp_one_line + FrameBitsMask[k]
                if ((k%4)==3) and (k != (len(FrameBitsMask)-1)):    # after every 4th character add a '_'
                    tmp_one_line = tmp_one_line + '_'                # some "pretty" printing, results in '1111_1111_1...'
            one_line.append(tmp_one_line)
            if BitsLeftToPackInFrames > 0:
                one_line.append(str(BitsLeftToPackInFrames-1)+':0')
            else:
                one_line.append('# NULL')
            BitsLeftToPackInFrames = 0; # will have to be 0 if already 0 or if we just allocate the last bits
        # The mapping into frames is described as a list of index ranges applied to the ConfigBits vector
        # use '2' for a single bit; '5:0' for a downto range; multiple ranges can be specified in optional consecutive comma separated fields get concatenated)
        # default is counting top down

        # attach line to CSV
        initCSV.append(one_line)
    tmp = numpy.asarray(initCSV)
    numpy.savetxt(entity+'.init.csv', tmp, fmt='%s', delimiter=",")
    return initCSV

def GenerateConfigMemVHDL( tile_description, entity, file ):
    # count total number of configuration bits for tile
    GlobalConfigBitsCounter = 0
    for line in tile_description:
        if (line[0] == 'BEL') or (line[0] == 'MATRIX'):
            if (GetNoConfigBitsFromFile(line[VHDL_file_position])) != 'NULL':
                GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(GetNoConfigBitsFromFile(line[VHDL_file_position]))

    # we use a file to describe the exact configuration bits to frame mapping
    # the following command generates an init file with a simple enumerated default mapping (e.g. 'LUT4AB_ConfigMem.init.csv')
    # if we run this function again, but have such a file (without the .init), then that mapping will be used
    MappingFile = GenerateConfigMemInit( tile_description, entity, file, GlobalConfigBitsCounter )

    # test if we have a bitstream mapping file
    # if not, we will take the default, which was passed on from GenerateConfigMemInit
    if os.path.exists(entity+'.csv'):
        print('# found bitstream mapping file '+entity+'.csv'+' for tile '+tile_description[0][0])
        MappingFile = [i.strip('\n').split(',') for i in open(entity+'.csv')]

    # clean comments empty lines etc. in the mapping file
    MappingFile = RemoveComments(MappingFile)

    # clean the '_' symbols in the used_bits_mask field (had been introduced to allow for making that a little more readable
    for line in MappingFile:
        # TODO does not like white spaces tabs etc
        # print('DEBUG BEFORE line[used_bits_mask]:',entity ,line[frame_name] ,line[used_bits_mask])
        line[used_bits_mask] = re.sub('_', '', line[used_bits_mask])
        # print('DEBUG AFTER line[used_bits_mask]:',entity ,line[frame_name] ,line[used_bits_mask])

    # we should have as many lines as we have frames (=MaxFramesPerCol)
    if str(len(MappingFile)) != str(MaxFramesPerCol):
        print('WARNING: the bitstream mapping file has only '+str(len(MappingFile))+' entries but MaxFramesPerCol is '+str(MaxFramesPerCol))

    # we should have as many lines as we have frames (=MaxFramesPerCol)
    # we also check used_bits_mask (is a vector that is as long as a frame and contains a '1' for a bit used and a '0' if not used (padded)
    UsedBitsCounter = 0
    for line in MappingFile:
        if line[used_bits_mask].count('1') > FrameBitsPerRow:
            raise ValueError('bitstream mapping file '+entity+'.csv has to many 1-elements in bitmask for frame : '+line[frame_name])
        if (line[used_bits_mask].count('1') + line[used_bits_mask].count('0')) != FrameBitsPerRow:
            # print('DEBUG LINE: ', line)
            raise ValueError('bitstream mapping file '+entity+'.csv has a too long or short bitmask for frame : '+line[frame_name])
        # we also count the used bits over all frames
        UsedBitsCounter += line[used_bits_mask].count('1')
    if UsedBitsCounter != GlobalConfigBitsCounter:
        raise ValueError('bitstream mapping file '+entity+'.csv has a bitmask missmatch; bitmask has in total '+str(UsedBitsCounter)+' 1-values for '+str(GlobalConfigBitsCounter)+' bits')

    # write entity
    # write entity
    # write entity
    GenerateVHDL_Header(file, entity, package=Package, NoConfigBits=str(GlobalConfigBitsCounter), MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow))

    # the port definitions are generic
    print('\t\t FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );', file=file)
    print('\t\t FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );', file=file)
    print('\t\t ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )', file=file)
    print('\t\t );', file=file)
    print('end entity;\n', file=file)

    # declare architecture
    print('architecture Behavioral of '+str(entity)+' is\n', file=file)


    # one_line('frame_name')('frame_index')('bits_used_in_frame')('used_bits_mask')('ConfigBits_ranges')

    # frame signal declaration ONLY for the bits actually used
    UsedFrames = []                # keeps track about the frames that are actually used
    AllConfigBitsOrder = []        # stores a list of ConfigBits indices in exactly the order defined in the rage statements in the frames
    for line in MappingFile:
        bits_used_in_frame = line[used_bits_mask].count('1')
        if bits_used_in_frame > 0:
            print('signal '+line[frame_name]+' \t:\t STD_LOGIC_VECTOR( '+str(bits_used_in_frame)+' -1 downto 0);', file=file)
            UsedFrames.append(line[frame_index])

        # The actual ConfigBits are given as address ranges starting at position ConfigBits_ranges
        ConfigBitsOrder = []
        for RangeItem in line[ConfigBits_ranges:]:
            if ':' in RangeItem:        # we have a range
                left, right = re.split(':',RangeItem)
                left = int(left)
                right = int(right)
                if left < right:
                    step = 1
                else:
                    step = -1
                right += step # this makes the python range inclusive, otherwise the last item (which is actually right) would be missing
                for k in range(left,right,step):
                    if k in ConfigBitsOrder:
                        raise ValueError('Configuration bit index '+str(k)+' already allocated in ', entity, line[frame_name])
                    else:
                        ConfigBitsOrder.append(int(k))
            elif RangeItem.isdigit():
                if int(RangeItem) in ConfigBitsOrder:
                    raise ValueError('Configuration bit index '+str(RangeItem)+' already allocated in ', entity, line[frame_name])
                else:
                    ConfigBitsOrder.append(int(RangeItem))
            else:
                # raise ValueError('Range '+str(RangeItem)+' cannot be resolved for frame : '+line[frame_name])
                print('Range '+str(RangeItem)+' cannot be resolved for frame : '+line[frame_name])
                print('DEBUG:',line)
        if len(ConfigBitsOrder) != bits_used_in_frame:
            raise ValueError('ConfigBitsOrder definition misssmatch: number of 1s in mask do not match ConfigBits_ranges for frame : '+line[frame_name])
        AllConfigBitsOrder += ConfigBitsOrder

    # begin architecture body
    print('\nbegin\n' , file=file)

    # instantiate latches for only the used frame bits
    print('-- instantiate frame latches' , file=file)
    AllConfigBitsCounter = 0
    for frame in UsedFrames:
        used_bits = MappingFile[int(frame)][int(used_bits_mask)]
        # print('DEBUG: ',entity, used_bits,' : ',AllConfigBitsOrder)
        for k in range(FrameBitsPerRow):
            # print('DEBUG: ',entity, used_bits,' : ',k, used_bits[k],'AllConfigBitsCounter',AllConfigBitsCounter, str(AllConfigBitsOrder[AllConfigBitsCounter]))
            if used_bits[k] == '1':
                print('Inst_'+MappingFile[int(frame)][int(frame_name)]+'_bit'+str(FrameBitsPerRow-1-k)+'  : LHQD1'          , file=file)
                print('Port Map ('          , file=file)
                # The next one is a little tricky:
                # k iterates over the bit_mask left to right from k=0..(FrameBitsPerRow-1) (k=0 is the most left (=first) character
                # But that character represents the MSB inside the frame, which iterates FrameBitsPerRow-1..0
                # bit_mask[0],                    bit_mask[1],                    bit_mask[2], ...
                # FrameData[FrameBitsPerRow-1-0], FrameData[FrameBitsPerRow-1-1], FrameData[FrameBitsPerRow-1-2],
                print('\t D \t=>\t FrameData('+str(FrameBitsPerRow-1-k)+'), '      , file=file)
                print('\t E \t=>\t FrameStrobe('+str(frame)+'), '      , file=file)
                print('\t Q \t=>\t ConfigBits ('+str(AllConfigBitsOrder[AllConfigBitsCounter])+') ); \n '      , file=file)
                AllConfigBitsCounter += 1

    print('\nend architecture;\n' , file=file)

    return

def PrintCSV_FileInfo( CSV_FileName ):
    CSVFile = [i.strip('\n').split(',') for i in open(CSV_FileName)]
    print('Tile: ', str(CSVFile[0][0]), '\n')

    # print('DEBUG:',CSVFile)

    print('\nInputs: \n')
    CSVFileRows=len(CSVFile)
    # for port in CSVFile[0][1:]:
    line = CSVFile[0]
    for k in range(1,len(line)):
        PortList = []
        PortCount = 0
        for j in range(1,len(CSVFile)):
            if CSVFile[j][k] != '0':
                PortList.append(CSVFile[j][0])
                PortCount += 1
        print(line[k], ' connects to ',PortCount,' ports: ', PortList)

    print('\nOutputs: \n')
    for line in CSVFile[1:]:
        # we first count the number of multiplexer inputs
        mux_size = 0
        PortList = []
        # for port in line[1:]:
            # if port != '0':
        for k in range(1,len(line)):
            if line[k] != '0':
                mux_size += 1
                PortList.append(CSVFile[0][k])
        print(line[0],',',str(mux_size),', Source port list: ', PortList)
    return

def GenTileSwitchMatrixVHDL( tile, CSV_FileName, file ):
    print('### Read ',str(tile),' csv file ###')
    CSVFile = [i.strip('\n').split(',') for i in open(CSV_FileName)]
    # clean comments empty lines etc. in the mapping file
    CSVFile = RemoveComments(CSVFile)
    # sanity check if we have the right CSV file
    if tile != CSVFile[0][0]:
        raise ValueError('top left element in CSV file does not match tile type in function GenTileSwitchMatrixVHDL')

    # we check if all columns contain at least one entry
    # basically that a wire entering the switch matrix can also leave that switch matrix.
    # When generating the actual multiplexers, we run the same test on the rows...
    for x in range(1,len(CSVFile[0])):
        ColBitCounter = 0
        for y in range(1,len(CSVFile)):
            if CSVFile[y][x] == '1':        # column-by-column scan
                ColBitCounter += 1
        if ColBitCounter == 0:                # if we never counted, it may point to a problem
            print('WARNING: input port '+CSVFile[0][x]+' of switch matrix in Tile '+CSVFile[0][0]+' is not used (from function GenTileSwitchMatrixVHDL)')

    # we pass the NumberOfConfigBits as a comment in the beginning of the file.
    # This simplifies it to generate the configuration port only if needed later when building the fabric where we are only working with the VHDL files
    GlobalConfigBitsCounter = 0
    mux_size_list = []
    for line in CSVFile[1:]:
        # we first count the number of multiplexer inputs
        mux_size=0
        for port in line[1:]:
            if port != '0':
                mux_size += 1
        mux_size_list.append(mux_size)
        if mux_size >= 2:
            GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
    print('-- NumberOfConfigBits:'+str(GlobalConfigBitsCounter), file=file)
    # VHDL header
    entity = tile+'_switch_matrix'
    GenerateVHDL_Header(file, entity, package=Package, NoConfigBits=str(GlobalConfigBitsCounter))
    # input ports
    print('\t\t -- switch matrix inputs', file=file)
    # CSVFile[0][1:]:   starts in the first row from the second element
    for port in CSVFile[0][1:]:
        # the following conditional is used to capture GND and VDD to not sow up in the switch matrix port list
        if re.search('^GND', port, flags=re.IGNORECASE) or re.search('^VCC', port, flags=re.IGNORECASE) or re.search('^VDD', port, flags=re.IGNORECASE):
            pass # maybe needed one day
        else:
            print('\t\t ',port,'\t: in \t STD_LOGIC;', file=file)
    # output ports
    for line in CSVFile[1:]:
        print('\t\t ',line[0],'\t: out \t STD_LOGIC;', file=file)
    # this is a shared text block finishes the header and adds configuration port
    if GlobalConfigBitsCounter > 0:
        GenerateVHDL_EntityFooter(file, entity, ConfigPort=True)
    else:
        GenerateVHDL_EntityFooter(file, entity, ConfigPort=False)

    # constant declaration
    # we may use the following in the switch matrix for providing '0' and '1' to a mux input:
    print('constant GND0\t : std_logic := \'0\';', file=file)
    print('constant GND\t : std_logic := \'0\';', file=file)
    print('constant VCC0\t : std_logic := \'1\';', file=file)
    print('constant VCC\t : std_logic := \'1\';', file=file)
    print('constant VDD0\t : std_logic := \'1\';', file=file)
    print('constant VDD\t : std_logic := \'1\';', file=file)
    print('\t', file=file)

    # signal declaration
    for k in range(1,len(CSVFile),1):
        print('signal \t ',CSVFile[k][0]+'_input','\t:\t std_logic_vector(',str(mux_size_list[k-1]),'- 1 downto 0 );', file=file)

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        print('', file=file)
        for line in CSVFile[1:]:
            # we first count the number of multiplexer inputs
            mux_size=0
            for port in line[1:]:
                if port != '0':
                    mux_size += 1
            if mux_size >= 2:
                print('signal DEBUG_select_'+str(line[0])+'\t: STD_LOGIC_VECTOR ('+str(int(math.ceil(math.log2(mux_size))))+' -1 downto 0);' , file=file)
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

#    print('debug', file=file)
#
#    mux_size_list = []
#    ConfigBitsCounter = 0
#    for line in CSVFile[1:]:
#        # we first count the number of multiplexer inputs
#        mux_size=0
#        for port in line[1:]:
#            # print('debug: ',port)
#            if port != '0':
#                mux_size += 1
#        mux_size_list.append(mux_size)
#        if mux_size >= 2:
#            print('signal \t ',line[0]+'_input','\t:\t std_logic_vector(',str(mux_size),'- 1 downto 0 );', file=file)
#            # "mux_size" tells us the number of mux inputs and "int(math.ceil(math.log2(mux_size)))" the number of configuration bits
#            # we count all bits needed to declare a corresponding shift register
#            ConfigBitsCounter = ConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
    print('\n-- The configuration bits (if any) are just a long shift register', file=file)
    print('\n-- This shift register is padded to an even number of flops/latches', file=file)
    # we are only generate configuration bits, if we really need configurations bits
    # for example in terminating switch matrices at the fabric borders, we may just change direction without any switching
    if GlobalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            print('signal \t ConfigBits :\t unsigned( '+str(GlobalConfigBitsCounter)+'-1 downto 0 );', file=file)
        if ConfigBitMode == 'FlipFlopChain':
            # print('DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG ConfigBitMode == FlipFlopChain')
            # we pad to an even number of bits: (int(math.ceil(ConfigBitCounter/2.0))*2)
            print('signal \t ConfigBits :\t unsigned( '+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1 downto 0 );', file=file)
            print('signal \t ConfigBitsInput :\t unsigned( '+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1 downto 0 );', file=file)

    # begin architecture
    print('\nbegin\n', file=file)

    # the configuration bits shift register
    # again, we add this only if needed
    if GlobalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            print(                 '-- the configuration bits shift register                                    ' , file=file)
            print(                 'process(CLK)                                                                ' , file=file)
            print(                 'begin                                                                       ' , file=file)
            print( '\t'+            'if CLK\'event and CLK=\'1\' then                                        ' , file=file)
            print( '\t'+'\t'+            'if mode=\'1\' then    --configuration mode                             ' , file=file)
            print( '\t'+'\t'+'\t'+            'ConfigBits <= CONFin & ConfigBits(ConfigBits\'high downto 1);   ' , file=file)
            print( '\t'+'\t'+            'end if;                                                             ' , file=file)
            print( '\t'+            'end if;                                                                 ' , file=file)
            print(                 'end process;                                                                ' , file=file)
            print(                 'CONFout <= ConfigBits(ConfigBits\'high);                                    ' , file=file)
            print(' \n'                                                                                        , file=file)

# L:for k in 0 to 196 generate
        # inst_LHQD1a : LHQD1
        # Port Map(
        # D    => ConfigBitsInput(k*2),
        # E    => CLK,
        # Q    => ConfigBits(k*2) ) ;

        # inst_LHQD1b : LHQD1
                # Port Map(
                # D    => ConfigBitsInput((k*2)+1),
                # E    => MODE,
                # Q    => ConfigBits((k*2)+1) );
# end generate;
        if ConfigBitMode == 'FlipFlopChain':
            # print('DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG ConfigBitMode == FlipFlopChain')
            print(          'ConfigBitsInput <= ConfigBits(ConfigBitsInput\'high-1 downto 0) & CONFin; \n     ' , file=file)
            print(          '-- for k in 0 to Conf/2 generate               '                                   , file=file)
            print(          'L: for k in 0 to '+str(int(math.ceil(GlobalConfigBitsCounter/2.0))-1)+' generate ' , file=file)
            print( '\t'+          '    inst_LHQD1a : LHQD1              '                                          , file=file)
            print( '\t'+ '\t'+          'Port Map(              '                                               , file=file)
            print( '\t'+ '\t'+          'D    => ConfigBitsInput(k*2),              '                           , file=file)
            print( '\t'+ '\t'+          'E    => CLK,               '                                           , file=file)
            print( '\t'+ '\t'+          'Q    => ConfigBits(k*2) );                 '                           , file=file)
            print(          '              '                                                                    , file=file)
            print( '\t'+          '    inst_LHQD1b : LHQD1              '                                          , file=file)
            print( '\t'+ '\t'+          'Port Map(              '                                               , file=file)
            print( '\t'+ '\t'+          'D    => ConfigBitsInput((k*2)+1),'                                     , file=file)
            print( '\t'+ '\t'+          'E    => MODE,'                                                         , file=file)
            print( '\t'+ '\t'+          'Q    => ConfigBits((k*2)+1) ); '                                       , file=file)
            print(         'end generate; \n        '                                                           , file=file)
            print('CONFout <= ConfigBits(ConfigBits\'high);                                    '                , file=file)
            print(' \n'                                                                                         , file=file)

    # the switch matrix implementation
    # we use the following variable to count the configuration bits of a long shift register which actually holds the switch matrix configuration
    ConfigBitstreamPosition = 0
    for line in CSVFile[1:]:
        # we first count the number of multiplexer inputs
        mux_size=0
        for port in line[1:]:
            # print('debug: ',port)
            if port != '0':
                mux_size += 1

        print('-- switch matrix multiplexer ',line[0],'\t\tMUX-'+str(mux_size), file=file)

        if mux_size == 0:
            print('-- WARNING unused multiplexer MUX-'+str(line[0]), file=file)
            print('WARNING: unused multiplexer MUX-'+str(line[0])+' in tile '+str(CSVFile[0][0]))

        # just route through : can be used for auxiliary wires or diagonal routing (Manhattan, just go to a switch matrix when turning
        # can also be used to tap a wire. A double with a mid is nothing else as a single cascaded with another single where the second single has only one '1' to cascade from the first single
        if mux_size == 1:
            port_index = 0
            for port in line[1:]:
                port_index += 1
                if port == '1':
                    print(line[0],'\t <= \t', CSVFile[0][port_index],';', file=file)
                elif port == 'l' or port == 'L' :
                    print(line[0],'\t <= \t \'0\';', file=file)
                elif port == 'h' or port == 'H':
                    print(line[0],'\t <= \t \'1\';', file=file)
                elif port == '0':
                    pass  # we add this for the following test to throw an error is an unexpected character is used
                else:
                    raise ValueError('wrong symbol in CSV file (must be 0, 1, H, or L) when executing function GenTileSwitchMatrixVHDL')
        # this is the case for a configurable switch matrix multiplexer
        if mux_size >= 2:
            print(line[0]+'_input','\t <= ', end='', file=file)
            port_index = 0
            inputs_so_far = 0
            # the reversed() changes the direction that we iterate over the line list.
            # I changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
            # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
            # remove "len(line)-" if you remove the reversed(..)
            for port in reversed(line[1:]):
                port_index += 1
                if port != '0':
                    inputs_so_far += 1
                    # again the "len(line)-" is needed as we iterate in reverse direction over the line list.
                    # remove "len(line)-" if you remove the reversed(..)
                    print(CSVFile[0][len(line)-port_index],end='', file=file)
                    if inputs_so_far == mux_size:
                        if int(GenerateDelayInSwitchMatrix) > 0:
                            print(' after '+str(GenerateDelayInSwitchMatrix)+' ps;', file=file)
                        else:
                            print(';', file=file)
                    else:
                        print(' & ',end='', file=file)
            # int(math.ceil(math.log2(inputs_so_far))) tells us how many configuration bits a multiplexer takes
            old_ConfigBitstreamPosition = ConfigBitstreamPosition
            ConfigBitstreamPosition = ConfigBitstreamPosition +    int(math.ceil(math.log2(inputs_so_far)))

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
            if (MultiplexerStyle == 'custom') and (mux_size == 4):
                MuxComponentName = 'MUX4PTv4'
            if (MultiplexerStyle == 'custom') and (mux_size == 16):
                MuxComponentName = 'MUX16PTv2'
            if (MultiplexerStyle == 'custom') and (mux_size == 4 or mux_size == 16):
                # inst_MUX4PTv4_J_l_AB_BEG1 : MUX4PTv4
                print('inst_'+MuxComponentName+'_'+line[0]+' : '+MuxComponentName+'\n',end='', file=file)
                # Port Map(
                print('\t'+' Port Map(\n',end='', file=file)
                # IN1  => J_l_AB_BEG1_input(0),
                # IN2  => J_l_AB_BEG1_input(1), ...
                for k in range(0,mux_size):
                    print('\t'+'\t'+'IN'+str(k+1)+' \t=> '+line[0]+'_input('+str(k)+'),\n',end='', file=file)
                # S1   => ConfigBits(low_362),
                # S2   => ConfigBits(low_362 + 1, ...
                for k in range(0,(math.ceil(math.log2(mux_size)))):
                    print('\t'+'\t'+'S'+str(k+1)+' \t=> ConfigBits('+str(old_ConfigBitstreamPosition)+' + '+str(k)+'),\n',end='', file=file)
                print('\t'+'\t'+'O  \t=> '+line[0]+' );\n\n',end='', file=file)
            else:        # generic multiplexer
                if MultiplexerStyle == 'custom':
                    print('HINT: creating a MUX-'+str(mux_size)+' for port '+line[0]+' in switch matrix for tile '+CSVFile[0][0])
                # VHDL example arbitrary mux
                # J_l_AB_BEG1    <= J_l_AB_BEG1_input(TO_INTEGER(ConfigBits(363 downto 362)));
                print(line[0]+'\t<= '+line[0]+'_input(',end='', file=file)
                print('TO_INTEGER(UNSIGNED(ConfigBits('+str(ConfigBitstreamPosition-1)+' downto '+str(old_ConfigBitstreamPosition)+'))));', file=file)
                print(' ', file=file)

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        print('\n', file=file)
        ConfigBitstreamPosition = 0
        for line in CSVFile[1:]:
            # we first count the number of multiplexer inputs
            mux_size=0
            for port in line[1:]:
                if port != '0':
                    mux_size += 1
            if mux_size >= 2:
                old_ConfigBitstreamPosition = ConfigBitstreamPosition
                ConfigBitstreamPosition = ConfigBitstreamPosition +    int(math.ceil(math.log2(mux_size)))
                print('DEBUG_select_'+line[0]+'\t<= ConfigBits('+str(ConfigBitstreamPosition-1)+' downto '+str(old_ConfigBitstreamPosition)+');', file=file)
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

    # just the final end of architecture
    print('\n'+'end architecture Behavioral;'+'\n', file=file)
    return

def GenerateFabricVHDL( FabricFile, file, entity = 'eFPGA' ):
# There are of course many possibilities for generating the fabric.
# I decided to generate a flat description as it may allow for a little easier debugging.
# For larger fabrics, this may be an issue, but not for now.
# We only have wires between two adjacent tiles in North, East, South, West direction.
# So we use the output ports to generate wires.
    fabric = GetFabric(FabricFile)
    y_tiles=len(fabric)      # get the number of tiles in vertical direction
    x_tiles=len(fabric[0])   # get the number of tiles in horizontal direction
    TileTypes = GetCellTypes(fabric)
    print('### Found the following tile types:\n',TileTypes)

    # VHDL header
    # entity hard-coded TODO

    GenerateVHDL_Header(file, entity,  MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow))
    # we first scan all tiles if those have IOs that have to go to top
    # the order of this scan is later maintained when instantiating the actual tiles
    print('\t-- External IO ports exported directly from the corresponding tiles', file=file)
    ExternalPorts = []
    SharedExternalPorts = []
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                # get the top dimension index that describes the tile type (given by fabric[y][x])
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                CurrentTileExternalPorts = GetComponentPortsFromFile(fabric[y][x]+'_tile.vhdl', port='external')
                if CurrentTileExternalPorts != []:
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        if re.search('SHARED_PORT', item):
                            # for the entity, we define only the very first for all SHARED_PORTs of any name category
                            if PortName not in SharedExternalPorts:
                                print('\t\t'+PortName+'\t:\t'+PortDefinition, file=file)
                                SharedExternalPorts.append(PortName)
                            # we remember the used port name for the component instantiations to come
                            # for the instantiations, we have to keep track about all external ports
                            ExternalPorts.append(PortName)
                        else:
                            print('\t\t'+'Tile_X'+str(x)+'Y'+str(y)+'_'+PortName+'\t:\t'+PortDefinition, file=file)
                            # we remember the used port name for the component instantiations to come
                            # we are maintaining the here used Tile_XxYy prefix as a sanity check
                            # ExternalPorts = ExternalPorts + 'Tile_X'+str(x)+'Y'+str(y)+'_'+str(PortName)
                            ExternalPorts.append('Tile_X'+str(x)+'Y'+str(y)+'_'+PortName)

    if ConfigBitMode == 'frame_based':
        print('\t\t FrameData:     in  STD_LOGIC_VECTOR( (FrameBitsPerRow * '+str(y_tiles)+') -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
        print('\t\t FrameStrobe:   in  STD_LOGIC_VECTOR( (MaxFramesPerCol * '+str(x_tiles)+') -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ', file=file)
        GenerateVHDL_EntityFooter(file, entity, ConfigPort=False)
    else:
        GenerateVHDL_EntityFooter(file, entity)

    TileTypeOutputPorts = []
    for tile in TileTypes:
        PrintComponentDeclarationForFile(str(tile)+'_tile.vhdl', file)
            # we need the BEL ports (a little later)
        Inputs, Outputs = GetComponentPortsFromFile(str(tile)+'_tile.vhdl')
        TileTypeOutputPorts.append(Outputs)

    # VHDL signal declarations
    print('\n-- signal declarations\n', file=file)

    print('\n-- configuration signal declarations\n', file=file)

    if ConfigBitMode == 'FlipFlopChain':
        tile_counter = 0
        for y in range(y_tiles):
            for x in range(x_tiles):
                # for the moment, we assume that all non "NULL" tiles are reconfigurable
                # (i.e. are connected to the configuration shift register)
                if (fabric[y][x]) != 'NULL':
                    tile_counter += 1
        print('signal\t'+'conf_data'+'\t:\tSTD_LOGIC_VECTOR('+str(tile_counter)+' downto 0);', file=file)

    if ConfigBitMode == 'frame_based':
#        for y in range(y_tiles):
#            for x in range(x_tiles):
#                if (fabric[y][x]) != 'NULL':
#                    TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
#                    if TileConfigBits != 'NULL' and int(TileConfigBits) != 0:
#                        print('signal Tile_X'+str(x)+'Y'+str(y)+'_ConfigBits \t:\t std_logic_vector('+TileConfigBits+' -1 downto '+str(0)+' );', file=file)

        # FrameData       =>     Tile_Y3_FrameData,
        # FrameStrobe      =>     Tile_X1_FrameStrobe
         # MaxFramesPerCol : integer := 20;
         # FrameBitsPerRow : integer := 32;
        for y in range(y_tiles):
            print('signal Tile_Y'+str(y)+'_FrameData \t:\t std_logic_vector(FrameBitsPerRow -1 downto 0);', file=file)
        for x in range(x_tiles):
            print('signal Tile_X'+str(x)+'_FrameStrobe \t:\t std_logic_vector(MaxFramesPerCol -1 downto 0);', file=file)

    print('\n-- tile-to-tile signal declarations\n', file=file)
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                # get the top dimension index that describes the tile type (given by fabric[y][x])
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                    # line contains something like "E2BEG : std_logic_vector( 7 downto 0 )" so I use split on '('
                    SignalName, Vector = re.split('\(',line)
                    # print('DEBUG line: ', line, file=file)
                    # print('DEBUG SignalName: ', SignalName, file=file)
                    # print('DEBUG Vector: ', Vector, file=file)
                    # Vector = re.sub('--.*', '', Vector)

                    print('signal Tile_X'+str(x)+'Y'+str(y)+'_'+SignalName+'\t:\t std_logic_vector('+Vector+';', file=file)

    # VHDL architecture body
    print('\nbegin\n', file=file)

    # top configuration data daisy chaining
    # this is copy and paste from tile code generation (so we can modify this here without side effects
    if ConfigBitMode == 'FlipFlopChain':
        print('-- top configuration data daisy chaining', file=file)
        print('conf_data(conf_data\'low) <= CONFin; -- conf_data\'low=0 and CONFin is from tile entity', file=file)
        print('CONFout <= conf_data(conf_data\'high); -- CONFout is from tile entity', file=file)

    if ConfigBitMode == 'frame_based':
        for y in range(y_tiles):
            print('Tile_Y'+str(y)+'_FrameData \t<=\t FrameData((FrameBitsPerRow*('+str(y)+'+1)) -1 downto FrameBitsPerRow*'+str(y)+');', file=file)
        for x in range(x_tiles):
            print('Tile_X'+str(x)+'_FrameStrobe \t<=\t FrameStrobe((MaxFramesPerCol*('+str(x)+'+1)) -1 downto MaxFramesPerCol*'+str(x)+');', file=file)

    # VHDL tile instantiations
    tile_counter = 0
    ExternalPorts_counter = 0
    print('-- tile instantiations\n', file=file)
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                EntityName = GetComponentEntityNameFromFile(str(fabric[y][x])+'_tile.vhdl')
                print('Tile_X'+str(x)+'Y'+str(y)+'_'+EntityName+' : '+EntityName, file=file)
                print('\tPort Map(', file=file)
                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                # print('DEBUG TileInputs: ', TileInputs)
                # print('DEBUG TileOutputs: ', TileOutputs)
                TilePorts = []
                TilePortsDebug = []
                # for connecting the instance, we write the tile ports in the order all inputs and all outputs
                for port in TileInputs + TileOutputs:
                    # GetComponentPortsFromFile returns vector information that starts with "(..." and we throw that away
                    # However the vector information is still interesting for debug purpose
                    TilePorts.append(re.sub(' ','',(re.sub('\(.*', '', port, flags=re.IGNORECASE))))
                    TilePortsDebug.append(port)

                # now we get the connecting input signals in the order NORTH EAST SOUTH WEST (order is given in fabric.csv)
                # from the adjacent tiles. For example, a NorthEnd-port is connected to a SouthBeg-port on tile Y+1
                # note that fabric[y][x] has its origin [0][0] in the top left corner
                TileInputSignal = []
                TileInputSignalCountPerDirection = []
                # IMPORTANT: we have to go through the following in NORTH EAST SOUTH WEST order
                # NORTH direction: get the NiBEG wires from tile y+1, because they drive NiEND
                if y < (y_tiles-1):
                    if (fabric[y+1][x]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y+1][x])+'_tile.vhdl', filter='NORTH')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y+1)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # EAST direction: get the EiBEG wires from tile x-1, because they drive EiEND
                if x > 0:
                    if (fabric[y][x-1]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x-1])+'_tile.vhdl', filter='EAST')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x-1)+'Y'+str(y)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # SOUTH direction: get the SiBEG wires from tile y-1, because they drive SiEND
                if y > 0:
                    if (fabric[y-1][x]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y-1][x])+'_tile.vhdl', filter='SOUTH')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y-1)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # WEST direction: get the WiBEG wires from tile x+1, because they drive WiEND
                if x < (x_tiles-1):
                    if (fabric[y][x+1]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x+1])+'_tile.vhdl', filter='WEST')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x+1)+'Y'+str(y)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # at this point, TileInputSignal is carrying all the driver signals from the surrounding tiles (the BEG signals of those tiles)
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y3_N1BEG( 3 downto 0 )"
                # for element in TileInputSignal:
                    # print('DEBUG TileInputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                # the output signals are named after the output ports
                TileOutputSignal = []
                TileInputsCountPerDirection = []
                # as for the VHDL signal generation, we simply add a prefix like "Tile_X1Y0_" to the begin port
                # for port in TileOutputs:
                    # TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                if (fabric[y][x]) != 'NULL':
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='NORTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='EAST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='SOUTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='WEST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                # at this point, TileOutputSignal is carrying all the signal names that will be driven by the present tile
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y2_W1BEG( 3 downto 0 )"
                # for element in TileOutputSignal:
                    # print('DEBUG TileOutputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                # example: W6END( 11 downto 0 ), N1BEG( 3 downto 0 ), ...
                # meaning: the END-ports are the tile inputs followed by the actual tile output ports (typically BEG)
                # this is essentially the left side (the component ports) of the component instantiation

                CheckFailed = False
                # sanity check: The number of input ports has to match the TileInputSignal per direction (N,E,S,W)
                if (fabric[y][x]) != 'NULL':
                    for k in range(0,4):

                        if TileInputsCountPerDirection[k] != TileInputSignalCountPerDirection[k]:
                            print('ERROR: component input missmatch in '+str(All_Directions[k])+' direction for Tile_X'+str(x)+'Y'+str(y)+' of type '+str(fabric[y][x]))
                            CheckFailed = True
                    if CheckFailed == True:
                        print('Error in function GenerateFabricVHDL')
                        print('DEBUG:TileInputs: ',TileInputs)
                        print('DEBUG:TileInputSignal: ',TileInputSignal)
                        print('DEBUG:TileOutputs: ',TileOutputs)
                        print('DEBUG:TileOutputSignal: ',TileOutputSignal)
                        # raise ValueError('Error in function GenerateFabricVHDL')
                # the output ports are derived from the same list and should therefore match automatically

                # for element in (TileInputs+TileOutputs):
                    # print('DEBUG TileInputs+TileOutputs :'+'Tile_X'+str(x)+'Y'+str(y)+'element:', element)

                if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                    for k in range(0,len(TileInputs)):
                        PortName = re.sub('\(.*', '', TileInputs[k])
                        print('\t'+PortName+'\t=> '+TileInputSignal[k]+',',file=file)
                        # print('DEBUG_INPUT: '+PortName+'\t=> '+TileInputSignal[k]+',')
                    for k in range(0,len(TileOutputs)):
                        PortName = re.sub('\(.*', '', TileOutputs[k])
                        print('\t'+PortName+'\t=> '+TileOutputSignal[k]+',',file=file)
                        # print('DEBUG_OUTPUT: '+PortName+'\t=> '+TileOutputSignal[k]+',')

                # Check if this tile uses IO-pins that have to be connected to the top-level entity
                CurrentTileExternalPorts = GetComponentPortsFromFile(fabric[y][x]+'_tile.vhdl', port='external')
                if CurrentTileExternalPorts != []:
                    print('\t -- tile IO port which gets directly connected to top-level tile entity', file=file)
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        # ExternalPorts was populated when writing the fabric top level entity
                        print('\t\t'+PortName+' => ',ExternalPorts[ExternalPorts_counter],',', file=file)
                        ExternalPorts_counter += 1

                if ConfigBitMode == 'FlipFlopChain':
                    GenerateVHDL_Conf_Instantiation(file=file, counter=tile_counter, close=True)
                if ConfigBitMode == 'frame_based':
                    if (fabric[y][x]) != 'NULL':
                        TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
                        if TileConfigBits != 'NULL':
                            if int(TileConfigBits) == 0:

                            # print('\t\t ConfigBits => (others => \'-\') );\n', file=file)

                            # the next one is fixing the fact the the last port assignment in vhdl is not allowed to have a ','
                            # this is a bit ugly, but well, vhdl is ugly too...
                                last_pos = file.tell()
                                for k in range(20):
                                    file.seek(last_pos -k)                # scan character by character backwards and look for ','
                                    my_char = file.read(1)
                                    if my_char == ',':
                                        file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
                                        print(' ', end='', file=file)
                                        break                            # stop scan

                                file.seek(0, os.SEEK_END)          # go back to usual...

                                print('\t\t );\n', file=file)
                            else:
                                print('\t\tFrameData  \t =>\t '+'Tile_Y'+str(y)+'_FrameData, ' , file=file)
                                print('\t\tFrameStrobe \t =>\t '+'Tile_X'+str(x)+'_FrameStrobe  ); \n' , file=file)
                                #print('\t\t ConfigBits => ConfigBits ( '+str(TileConfigBits)+' -1 downto '+str(0)+' ) );\n', file=file)
                                ### BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
                tile_counter += 1
    print('\n'+'end Behavioral;'+'\n', file=file)
    return

def CSV2list( InFileName, OutFileName ):
# this function is export a given CSV switch matrix description into its equivalent list description
# format: destination,source (per line)
    # read CSV file into an array of strings
    InFile = [i.strip('\n').split(',') for i in open(InFileName)]
    f=open(OutFileName,'w')
    rows=len(InFile)      # get the number of tiles in vertical direction
    cols=len(InFile[0])    # get the number of tiles in horizontal direction
    # top-left should be the name
    print('#',InFile[0][0], file=f)
    # switch matrix inputs
    inputs = []
    for item in InFile[0][1:]:
        inputs.append(item)
    # beginning from the second line, write out the list
    for line in InFile[1:]:
        for i in range(1,cols):
            if line[i] != '0':
                print(line[0]+','+inputs[i-1], file=f) # it is [i-1] because the beginning of the line is the destination port
    f.close()
    return

def takes_list(a_string, a_list):
    print('first debug (a_list):',a_list, 'string:', a_string)
    for item in a_list:
        print('hello debug:',item, 'string:', a_string)

def ExpandListPorts(port, PortList):
    # a leading '[' tells us that we have to expand the list
    if re.search('\[', port):
        if not re.search('\]', port):
            raise ValueError('\nError in function ExpandListPorts: cannot find closing ]\n')
        # port.find gives us the first occurrence index in a string
        left_index = port.find('[')
        right_index = port.find(']')
        before_left_index = port[0:left_index]
        # right_index is the position of the ']' so we need everything after that
        after_right_index = port[(right_index+1):]
        ExpandList = []
        ExpandList = re.split('\|',port[left_index+1:right_index])
        for entry in ExpandList:
            ExpandListItem = (before_left_index+entry+after_right_index)
            ExpandListPorts(ExpandListItem, PortList)

    else:
        # print('DEBUG: else, just:',port)
        PortList.append(port)
    return

def list2CSV( InFileName, OutFileName ):
# this sets connections ('1') in a CSV connection matrix (OutFileName) from a list (InFileName)
    # read input files into arrays of strings
    InFile = [i.strip('\n').split(',') for i in open(InFileName)]
    OutFile = [i.strip('\n').split(',') for i in open(OutFileName)]

    #get OutFile input ports
    OutFileInputPorts = []
    for k in range(1,len(OutFile[0])):
        OutFileInputPorts.append(OutFile[0][k])
    #get OutFile output ports
    OutFileOutputPorts = []
    for k in range(1,len(OutFile)):
        OutFileOutputPorts.append(OutFile[k][0])

    # clean up InFile (the list) and remove empty lines and comments
    InList = []
    InFileInputPorts = []
    InFileOutputPorts = []
    for line in InFile:
        items=len(line)
        if items >= 2:
            if line[0] != '' and not re.search('#', line[0], flags=re.IGNORECASE):
                substitutions = {" ": "", "\t": ""}
                # multiplexer output
                LeftItem = replace(line[0], substitutions)
                # multiplexer input
                RightItem  = replace(re.sub('#.*','' ,line[1]), substitutions)
                if RightItem != '':
                    InList.append([LeftItem, RightItem])
                    # InFileInputPorts.append(RightItem)
                    # InFileOutputPorts.append(LeftItem)
                    ExpandListPorts(RightItem, InFileInputPorts)
                    ExpandListPorts(LeftItem, InFileOutputPorts)
    UniqInFileInputPorts  = list(set(InFileInputPorts))
    UniqInFileOutputPorts = list(set(InFileOutputPorts))
    # sanity check: if all used ports in InFile are in the CSV table
    # which means all ports of UniqInFileInputPorts must exist in OutFileInputPorts
    for port in UniqInFileInputPorts:
        if port not in OutFileInputPorts:
            print('\nError: input file list uses an input port', port, ' that does not exist in the CSV table\n')
#            raise ValueError('\nError: input file list uses an input port that does not exist in the CSV table\n')
    # ... and that all ports of UniqInFileOutputPorts must exist in OutFileOutputPorts
    for port in UniqInFileOutputPorts:
        if port not in OutFileOutputPorts:
            print('\nError: input file list uses an output port', port, ' that does not exist in the CSV table\n')
#            raise ValueError('\nError: input file list uses an output port that does not exist in the CSV table\n')

    # process the InList
    for line in InList:
        # OutFileOutputPorts : switch matrix output port list (from CSV file)
        # line[0] : switch matrix output port;
        # line[1] : switch matrix input port
        # we have to add a +1 on the index because of the port name lists in the first row/column
        LeftPortList = []
        RightPortList = []
        ExpandListPorts(line[0], LeftPortList)
        ExpandListPorts(line[1], RightPortList)
        if len(LeftPortList) != len(RightPortList):
            raise ValueError('\nError in function list2CSV: left argument:\n',line[0], '\n does not match right argument:\n', line[1])
        for k in range(len(LeftPortList)):
            MuxOutputIndex = OutFileOutputPorts.index(LeftPortList[k]) + 1
            MuxInputIndex = OutFileInputPorts.index(RightPortList[k]) + 1
            if OutFile[MuxOutputIndex][MuxInputIndex] != '0':
                print('Warning: following connection exists already in CSV switch matrix: ', end='')
                print(OutFileOutputPorts[MuxOutputIndex-1]+','+OutFileInputPorts[MuxInputIndex-1])
            # set the connection in the adjacency matrix
            OutFile[MuxOutputIndex][MuxInputIndex] = '1'

    # When we parse in the CSV file, we filter out comments, starting with '#'
    # so we can use this to count the number of '1' in rows (= size of multiplexers) and columns (= fan out)
    # this provides some useful statistics without affecting the operation of the tool
    # row scan
    OutFileAnnotated = []
    for line in OutFile:
        Counter = 0
        for item in line[1:]:
            if item == '1':
                Counter += 1
        new_line = line
        new_line.append('#')
        new_line.append(str(Counter))
        OutFileAnnotated.append(new_line)
    # column scan
    new_line = []
    new_line.append('#')
    for x in range(1,len(OutFile[0])):
        Counter = 0
        for y in range(1,len(OutFile)):
            if OutFile[y][x] == '1':        # column-by-column scan
                Counter += 1
        new_line.append(str(Counter))
    OutFileAnnotated.append(new_line)

    # finally overwrite switch matrix CSV file
    # tmp = numpy.asarray(OutFile)
    # numpy.savetxt(OutFileName, tmp, fmt='%s', delimiter=",")
    tmp = numpy.asarray(OutFileAnnotated)
    numpy.savetxt(OutFileName, tmp, fmt='%s', delimiter=",")
    return

def GenTileSwitchMatrixVerilog( tile, CSV_FileName, file ):
    print('### Read '+str(tile)+' csv file ###')
    CSVFile = [i.strip('\n').split(',') for i in open(CSV_FileName)]
    # clean comments empty lines etc. in the mapping file
    CSVFile = RemoveComments(CSVFile)
    # sanity check if we have the right CSV file
    if tile != CSVFile[0][0]:
        raise ValueError('top left element in CSV file does not match tile type in function GenTileSwitchMatrixVerilog')

    # we check if all columns contain at least one entry
    # basically that a wire entering the switch matrix can also leave that switch matrix.
    # When generating the actual multiplexers, we run the same test on the rows...
    for x in range(1,len(CSVFile[0])):
        ColBitCounter = 0
        for y in range(1,len(CSVFile)):
            if CSVFile[y][x] == '1':# column-by-column scan
                ColBitCounter += 1
        if ColBitCounter == 0:# if we never counted, it may point to a problem
            print('WARNING: input port '+CSVFile[0][x]+' of switch matrix in Tile '+CSVFile[0][0]+' is not used (from function GenTileSwitchMatrixVerilog)')

    # we pass the NumberOfConfigBits as a comment in the beginning of the file.
    # This simplifies it to generate the configuration port only if needed later when building the fabric where we are only working with the Verilog files
    GlobalConfigBitsCounter = 0
    mux_size_list = []
    for line in CSVFile[1:]:
        # we first count the number of multiplexer inputs
        mux_size=0
        for port in line[1:]:
            if port != '0':
                mux_size += 1
        mux_size_list.append(mux_size)
        if mux_size >= 2:
            GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
    print('//NumberOfConfigBits:'+str(GlobalConfigBitsCounter), file=file)
    # Verilog header
    module = tile+'_switch_matrix'
    module_header_ports = ''

    ports = []
    for port in CSVFile[0][1:]:
    # the following conditional is used to capture GND and VDD to not sow up in the switch matrix port list
        if re.search('^GND', port, flags=re.IGNORECASE) or re.search('^VCC', port, flags=re.IGNORECASE) or re.search('^VDD', port, flags=re.IGNORECASE):
            pass # maybe needed one day
        else:
            ports.append(port)
    # output ports
    for line in CSVFile[1:]:
        ports.append(line[0])
    module_header_ports = ", ".join(ports)

    if GlobalConfigBitsCounter > 0:
        if ConfigBitMode == 'FlipFlopChain':
            module_header_ports += ', MODE, CONFin, CONFout, CLK'
        elif ConfigBitMode == 'frame_based':
            module_header_ports += ', ConfigBits, ConfigBits_N'
    else:
        module_header_ports += ''

    if (ConfigBitMode == 'FlipFlopChain'):
        GenerateVerilog_Header(module_header_ports, file, module, package=Package, NoConfigBits=str(GlobalConfigBitsCounter))
    else:
                GenerateVerilog_Header(module_header_ports, file, module, package='', NoConfigBits=str(GlobalConfigBitsCounter))

    # input ports
    print('\t // switch matrix inputs', file=file)
    # CSVFile[0][1:]:   starts in the first row from the second element
    for port in CSVFile[0][1:]:
        # the following conditional is used to capture GND and VDD to not sow up in the switch matrix port list
        if re.search('^GND', port, flags=re.IGNORECASE) or re.search('^VCC', port, flags=re.IGNORECASE) or re.search('^VDD', port, flags=re.IGNORECASE):
            pass # maybe needed one day
        else:
            print('\tinput '+port+';', file=file)
    # output ports
    for line in CSVFile[1:]:
        print('\toutput '+line[0]+';', file=file)
    # this is a shared text block finishes the header and adds configuration port
    if GlobalConfigBitsCounter > 0:
        GenerateVerilog_PortsFooter(file, module, ConfigPort=True)
    else:
        GenerateVerilog_PortsFooter(file, module, ConfigPort=False)

    # parameter declaration
    # we may use the following in the switch matrix for providing '0' and '1' to a mux input:
    print('\tparameter GND0 = 1\'b0;', file=file)
    print('\tparameter GND = 1\'b0;', file=file)
    print('\tparameter VCC0 = 1\'b1;', file=file)
    print('\tparameter VCC = 1\'b1;', file=file)
    print('\tparameter VDD0 = 1\'b1;', file=file)
    print('\tparameter VDD = 1\'b1;', file=file)
    print('\t', file=file)

    # signal declaration
    for k in range(1,len(CSVFile),1):
        print('\twire ['+str(mux_size_list[k-1])+'-1:0] '+CSVFile[k][0]+'_input'+';', file=file)

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        print('', file=file)
        for line in CSVFile[1:]:
            # we first count the number of multiplexer inputs
            mux_size=0
            for port in line[1:]:
                if port != '0':
                    mux_size += 1
            if mux_size >= 2:
                print('\twire ['+str(int(math.ceil(math.log2(mux_size))))+'-1:0] '+'DEBUG_select_'+str(line[0])+';', file=file)
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

#    print('debug', file=file)
#
#    mux_size_list = []
#    ConfigBitsCounter = 0
#    for line in CSVFile[1:]:
#        # we first count the number of multiplexer inputs
#        mux_size=0
#        for port in line[1:]:
#            # print('debug: ',port)
#            if port != '0':
#                mux_size += 1
#        mux_size_list.append(mux_size)
#        if mux_size >= 2:
#            print('signal \t ',line[0]+'_input','\t:\t std_logic_vector(',str(mux_size),'- 1 downto 0 );', file=file)
#            # "mux_size" tells us the number of mux inputs and "int(math.ceil(math.log2(mux_size)))" the number of configuration bits
#            # we count all bits needed to declare a corresponding shift register
#            ConfigBitsCounter = ConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
    print('\n// The configuration bits (if any) are just a long shift register', file=file)
    print('\n// This shift register is padded to an even number of flops/latches', file=file)
    # we are only generate configuration bits, if we really need configurations bits
    # for example in terminating switch matrices at the fabric borders, we may just change direction without any switching
    if GlobalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            print('\twire ['+str(GlobalConfigBitsCounter)+'-1:0]'+' ConfigBits;', file=file)
        elif ConfigBitMode == 'FlipFlopChain':
            # print('DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG ConfigBitMode == FlipFlopChain')
            # we pad to an even number of bits: (int(math.ceil(ConfigBitCounter/2.0))*2)
            print('\twire ['+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1:0]'+' ConfigBits;', file=file)
            print('\twire ['+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1:0]'+' ConfigBitsInput;', file=file)

    # the configuration bits shift register
    # again, we add this only if needed
    if GlobalConfigBitsCounter > 0:
        if ConfigBitMode == 'ff_chain':
            print('// the configuration bits shift register' , file=file)
            print('\t'+'always @ (posedge CLK)', file=file)
            print('\t'+'begin', file=file)
            print('\t'+'\t'+'if (MODE=1b\'1) begin    //configuration mode' , file=file)
            print('\t'+'\t'+'\t'+'ConfigBits <= {CONFin,ConfigBits['+str(GlobalConfigBitsCounter)+'-1:1]};' , file=file)
            print('\t'+'\t'+'end' , file=file)
            print('\t'+'end', file=file)
            print('', file=file)
            print('\tassign CONFout = ConfigBits['+str(GlobalConfigBitsCounter)+'-1];', file=file)
            print('\n', file=file)

# L:for k in 0 to 196 generate
        # inst_LHQD1a : LHQD1
        # Port Map(
        # D    => ConfigBitsInput(k*2),
        # E    => CLK,
        # Q    => ConfigBits(k*2) ) ;

        # inst_LHQD1b : LHQD1
                # Port Map(
                # D    => ConfigBitsInput((k*2)+1),
                # E    => MODE,
                # Q    => ConfigBits((k*2)+1) );
# end generate;
        elif ConfigBitMode == 'FlipFlopChain':
            print('\tgenvar k;\n', file=file)
            # print('DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG ConfigBitMode == FlipFlopChain')
            print('\tassign ConfigBitsInput = {ConfigBits['+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1-1:0],CONFin};\n', file=file)
            print('\t// for k in 0 to Conf/2 generate', file=file)
            print('\tfor (k=0; k<'+str(int(math.ceil(GlobalConfigBitsCounter/2.0))-1)+'; k=k+1) begin: L', file=file)
            print('\t\t'+'LHQD1 inst_LHQD1a(', file=file)
            print('\t\t'+'.D(ConfigBitsInput[k*2]),', file=file)
            print('\t\t'+'.E(CLK),', file=file)
            print('\t\t'+'.Q(ConfigBits[k*2])', file=file)
            print('\t\t);', file=file)
            print('', file=file)
            print('\t\t'+'LHQD1 inst_LHQD1b(', file=file)
            print('\t\t'+'.D(ConfigBitsInput[(k*2)+1]),', file=file)
            print('\t\t'+'.E(MODE),', file=file)
            print('\t\t'+'.Q(ConfigBits[(k*2)+1])', file=file)
            print('\t\t);', file=file)
            print('\tend\n', file=file)
            print('\tassign CONFout = ConfigBits['+str(int(math.ceil(GlobalConfigBitsCounter/2.0))*2)+'-1];', file=file)
            print('\n', file=file)

    # the switch matrix implementation
    # we use the following variable to count the configuration bits of a long shift register which actually holds the switch matrix configuration
    ConfigBitstreamPosition = 0
    for line in CSVFile[1:]:
        # we first count the number of multiplexer inputs
        mux_size=0
        for port in line[1:]:
            # print('debug: ',port)
            if port != '0':
                mux_size += 1

        print('// switch matrix multiplexer ',line[0],'\t\tMUX-'+str(mux_size), file=file)

        if mux_size == 0:
            print('// WARNING unused multiplexer MUX-'+str(line[0]), file=file)
            print('WARNING: unused multiplexer MUX-'+str(line[0])+' in tile '+str(CSVFile[0][0]))

        # just route through : can be used for auxiliary wires or diagonal routing (Manhattan, just go to a switch matrix when turning
        # can also be used to tap a wire. A double with a mid is nothing else as a single cascaded with another single where the second single has only one '1' to cascade from the first single
        if mux_size == 1:
            port_index = 0
            for port in line[1:]:
                port_index += 1
                if port == '1':
                    print('\tassign '+line[0]+' = '+CSVFile[0][port_index]+';', file=file)
                elif port == 'l' or port == 'L' :
                    print('\tassign '+line[0],' = 1b\'0;', file=file)
                elif port == 'h' or port == 'H':
                    print('\tassign '+line[0],' = 1b\'1;', file=file)
                elif port == '0':
                    pass  # we add this for the following test to throw an error is an unexpected character is used
                else:
                    raise ValueError('wrong symbol in CSV file (must be 0, 1, H, or L) when executing function GenTileSwitchMatrixVerilog')
        # this is the case for a configurable switch matrix multiplexer
        if mux_size >= 2:
            if int(GenerateDelayInSwitchMatrix) > 0:
                #print('\tassign #'+str(GenerateDelayInSwitchMatrix)+' '+line[0]+'_input'+' = {', end='', file=file)
                print('\tassign '+line[0]+'_input'+' = {', end='', file=file)
            else:
                print('\tassign '+line[0]+'_input'+' = {', end='', file=file)
            port_index = 0
            inputs_so_far = 0
            # the reversed() changes the direction that we iterate over the line list.
            # I changed it such that the left-most entry is located at the end of the concatenated vector for the multiplexing
            # This was done such that the index from left-to-right in the adjacency matrix corresponds with the multiplexer select input (index)
            # remove "len(line)-" if you remove the reversed(..)
            for port in reversed(line[1:]):
                port_index += 1
                if port != '0':
                    inputs_so_far += 1
                    print(CSVFile[0][len(line)-port_index],end='', file=file)
                    # again the "len(line)-" is needed as we iterate in reverse direction over the line list.
                    # remove "len(line)-" if you remove the reversed(..)
                    if inputs_so_far == mux_size:
                        print('};', file=file)
                    else:
                        print(',',end='', file=file)
            # int(math.ceil(math.log2(inputs_so_far))) tells us how many configuration bits a multiplexer takes
            old_ConfigBitstreamPosition = ConfigBitstreamPosition
            ConfigBitstreamPosition = ConfigBitstreamPosition + int(math.ceil(math.log2(inputs_so_far)))

            # we have full custom MUX-4 and MUX-16 for which we have to generate code like:
# Verilog example custom MUX4
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

            num_gnd = 0

            if (MultiplexerStyle == 'custom') and (mux_size > 2 and mux_size <= 4):
                MuxComponentName = 'cus_mux41_buf'
                num_gnd = 4-mux_size
            if (MultiplexerStyle == 'custom') and (mux_size > 8 and mux_size <= 16):
                MuxComponentName = 'cus_mux161_buf'
                num_gnd = 16-mux_size
            if (MultiplexerStyle == 'custom') and (mux_size > 4 and mux_size <= 8):
                MuxComponentName = 'cus_mux81_buf'
                num_gnd = 8-mux_size
            if (MultiplexerStyle == 'custom') and (mux_size == 2):
                MuxComponentName = 'my_mux2'
            if (MultiplexerStyle == 'custom') and (mux_size == 4 or mux_size == 16 or mux_size == 8):
                # cus_mux41
                print('\t'+MuxComponentName+' inst_'+MuxComponentName+'_'+line[0]+' ('+'\n',end='', file=file)
                # Port Map(
                # IN1  => J_l_AB_BEG1_input(0),
                # IN2  => J_l_AB_BEG1_input(1), ...
                for k in range(0,mux_size):
                    print('\t'+'.A'+str(k)+' ('+line[0]+'_input['+str(k)+']),\n',end='', file=file)
                # S1   => ConfigBits(low_362),
                # S2   => ConfigBits(low_362 + 1, ...
                for k in range(0,(math.ceil(math.log2(mux_size)))):
                    print('\t'+'.S'+str(k)+' (ConfigBits['+str(old_ConfigBitstreamPosition)+'+'+str(k)+']),\n',end='', file=file)
                    print('\t'+'.S'+str(k)+'N (ConfigBits_N['+str(old_ConfigBitstreamPosition)+'+'+str(k)+']),\n',end='', file=file)
                print('\t'+'.X ('+line[0]+')\n',end='', file=file)
                print('\t);\n', file=file)
            elif (MultiplexerStyle == 'custom') and (mux_size == 2):
                # inst_MUX4PTv4_J_l_AB_BEG1 : MUX4PTv4
                print('\t'+MuxComponentName+' inst_'+MuxComponentName+'_'+line[0]+' ('+'\n',end='', file=file)
                for k in range(0,mux_size):
                    print('\t'+'.A'+str(k)+' ('+line[0]+'_input['+str(k)+']),\n',end='', file=file)
                for k in range(0,(math.ceil(math.log2(mux_size)))):
                    print('\t'+'.S (ConfigBits['+str(old_ConfigBitstreamPosition)+'+'+str(k)+']),\n',end='', file=file)
                print('\t'+'.X ('+line[0]+')\n',end='', file=file)
                print('\t);\n', file=file)
            else:        # generic multiplexer
                if MultiplexerStyle == 'custom':
                    print('HINT: creating a MUX-'+str(mux_size)+' for port '+line[0]+' in switch matrix for tile '+CSVFile[0][0])

                    print('\t'+MuxComponentName+' inst_'+MuxComponentName+'_'+line[0]+' ('+'\n',end='', file=file)
                    for k in range(0,mux_size):
                        print('\t'+'.A'+str(k)+' ('+line[0]+'_input['+str(k)+']),\n',end='', file=file)
                    for k in range(num_gnd):
                        print('\t'+'.A'+str(k+mux_size)+' (GND0),\n',end='', file=file)
                    for k in range(0,(math.ceil(math.log2(mux_size)))):
                        print('\t'+'.S'+str(k)+' (ConfigBits['+str(old_ConfigBitstreamPosition)+'+'+str(k)+']),\n',end='', file=file)
                        print('\t'+'.S'+str(k)+'N (ConfigBits_N['+str(old_ConfigBitstreamPosition)+'+'+str(k)+']),\n',end='', file=file)
                    print('\t'+'.X ('+line[0]+')\n',end='', file=file)
                    print('\t);\n', file=file)
                else:
                    print('\tassign '+line[0]+' = '+line[0]+'_input[',end='', file=file)
                    print('ConfigBits['+str(ConfigBitstreamPosition-1)+':'+str(old_ConfigBitstreamPosition)+']];', file=file)
                    print(' ', file=file)

    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    if SwitchMatrixDebugSignals == True:
        ConfigBitstreamPosition = 0
        for line in CSVFile[1:]:
            # we first count the number of multiplexer inputs
            mux_size=0
            for port in line[1:]:
                if port != '0':
                    mux_size += 1
            if mux_size >= 2:
                old_ConfigBitstreamPosition = ConfigBitstreamPosition
                ConfigBitstreamPosition = ConfigBitstreamPosition +    int(math.ceil(math.log2(mux_size)))
                print('\tassign DEBUG_select_'+line[0]+' = ConfigBits['+str(ConfigBitstreamPosition-1)+':'+str(old_ConfigBitstreamPosition)+'];', file=file)
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###
    ### SwitchMatrixDebugSignals ### SwitchMatrixDebugSignals ###

    # just the final end of architecture
    print('\n'+'endmodule', file=file)
    return

def GenerateConfigMemVerilog( tile_description, module, file ):
    # count total number of configuration bits for tile
    GlobalConfigBitsCounter = 0
    for line in tile_description:
        if (line[0] == 'BEL') or (line[0] == 'MATRIX'):
            if (GetNoConfigBitsFromFile(line[VHDL_file_position])) != 'NULL':
                GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(GetNoConfigBitsFromFile(line[VHDL_file_position]))

    # we use a file to describe the exact configuration bits to frame mapping
    # the following command generates an init file with a simple enumerated default mapping (e.g. 'LUT4AB_ConfigMem.init.csv')
    # if we run this function again, but have such a file (without the .init), then that mapping will be used
    MappingFile = GenerateConfigMemInit( tile_description, module, file, GlobalConfigBitsCounter )

    # test if we have a bitstream mapping file
    # if not, we will take the default, which was passed on from GenerateConfigMemInit
    if os.path.exists(module+'.csv'):
        print('# found bitstream mapping file '+module+'.csv'+' for tile '+tile_description[0][0])
        MappingFile = [i.strip('\n').split(',') for i in open(module+'.csv')]

    # clean comments empty lines etc. in the mapping file
    MappingFile = RemoveComments(MappingFile)

    # clean the '_' symbols in the used_bits_mask field (had been introduced to allow for making that a little more readable
    for line in MappingFile:
        # TODO does not like white spaces tabs etc
        # print('DEBUG BEFORE line[used_bits_mask]:',module ,line[frame_name] ,line[used_bits_mask])
        line[used_bits_mask] = re.sub('_', '', line[used_bits_mask])
        # print('DEBUG AFTER line[used_bits_mask]:',module ,line[frame_name] ,line[used_bits_mask])

    # we should have as many lines as we have frames (=MaxFramesPerCol)
    if str(len(MappingFile)) != str(MaxFramesPerCol):
        print('WARNING: the bitstream mapping file has only '+str(len(MappingFile))+' entries but MaxFramesPerCol is '+str(MaxFramesPerCol))

    # we should have as many lines as we have frames (=MaxFramesPerCol)
    # we also check used_bits_mask (is a vector that is as long as a frame and contains a '1' for a bit used and a '0' if not used (padded)
    UsedBitsCounter = 0
    for line in MappingFile:
        if line[used_bits_mask].count('1') > FrameBitsPerRow:
            raise ValueError('bitstream mapping file '+module+'.csv has to many 1-elements in bitmask for frame : '+line[frame_name])
        if (line[used_bits_mask].count('1') + line[used_bits_mask].count('0')) != FrameBitsPerRow:
            # print('DEBUG LINE: ', line)
            raise ValueError('bitstream mapping file '+module+'.csv has a too long or short bitmask for frame : '+line[frame_name])
        # we also count the used bits over all frames
        UsedBitsCounter += line[used_bits_mask].count('1')
    if UsedBitsCounter != GlobalConfigBitsCounter:
        raise ValueError('bitstream mapping file '+module+'.csv has a bitmask missmatch; bitmask has in total '+str(UsedBitsCounter)+' 1-values for '+str(GlobalConfigBitsCounter)+' bits')

    # write module
    module_header_ports = 'FrameData, FrameStrobe, ConfigBits, ConfigBits_N'
    CSVFile = ''
    GenerateVerilog_Header(module_header_ports, file, module, package='', NoConfigBits=str(GlobalConfigBitsCounter), MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow))

    # the port definitions are generic
    print('\tinput [FrameBitsPerRow-1:0] FrameData;', file=file)
    print('\tinput [MaxFramesPerCol-1:0] FrameStrobe;', file=file)
    print('\toutput [NoConfigBits-1:0] ConfigBits;', file=file)
    print('\toutput [NoConfigBits-1:0] ConfigBits_N;', file=file)

    # one_line('frame_name')('frame_index')('bits_used_in_frame')('used_bits_mask')('ConfigBits_ranges')

    # frame signal declaration ONLY for the bits actually used
    UsedFrames = []                # keeps track about the frames that are actually used
    AllConfigBitsOrder = []        # stores a list of ConfigBits indices in exactly the order defined in the rage statements in the frames
    for line in MappingFile:
        bits_used_in_frame = line[used_bits_mask].count('1')
        if bits_used_in_frame > 0:
            print('\twire ['+str(bits_used_in_frame)+'-1:0] '+line[frame_name]+';', file=file)
            UsedFrames.append(line[frame_index])

        # The actual ConfigBits are given as address ranges starting at position ConfigBits_ranges
        ConfigBitsOrder = []
        for RangeItem in line[ConfigBits_ranges:]:
            if ':' in RangeItem:        # we have a range
                left, right = re.split(':',RangeItem)
                left = int(left)
                right = int(right)
                if left < right:
                    step = 1
                else:
                    step = -1
                right += step # this makes the python range inclusive, otherwise the last item (which is actually right) would be missing
                for k in range(left,right,step):
                    if k in ConfigBitsOrder:
                        raise ValueError('Configuration bit index '+str(k)+' already allocated in ', module, line[frame_name])
                    else:
                        ConfigBitsOrder.append(int(k))
            elif RangeItem.isdigit():
                if int(RangeItem) in ConfigBitsOrder:
                    raise ValueError('Configuration bit index '+str(RangeItem)+' already allocated in ', module, line[frame_name])
                else:
                    ConfigBitsOrder.append(int(RangeItem))
            else:
                # raise ValueError('Range '+str(RangeItem)+' cannot be resolved for frame : '+line[frame_name])
                print('Range '+str(RangeItem)+' cannot be resolved for frame : '+line[frame_name])
                print('DEBUG:',line)
        if len(ConfigBitsOrder) != bits_used_in_frame:
            raise ValueError('ConfigBitsOrder definition misssmatch: number of 1s in mask do not match ConfigBits_ranges for frame : '+line[frame_name])
        AllConfigBitsOrder += ConfigBitsOrder

    # instantiate latches for only the used frame bits
    print('\n//instantiate frame latches' , file=file)
    AllConfigBitsCounter = 0
    for frame in UsedFrames:
        used_bits = MappingFile[int(frame)][int(used_bits_mask)]
        # print('DEBUG: ',module, used_bits,' : ',AllConfigBitsOrder)
        for k in range(FrameBitsPerRow):
            # print('DEBUG: ',module, used_bits,' : ',k, used_bits[k],'AllConfigBitsCounter',AllConfigBitsCounter, str(AllConfigBitsOrder[AllConfigBitsCounter]))
            if used_bits[k] == '1':
                print('\tLHQD1 Inst_'+MappingFile[int(frame)][int(frame_name)]+'_bit'+str(FrameBitsPerRow-1-k)+'(', file=file)
                # The next one is a little tricky:
                # k iterates over the bit_mask left to right from k=0..(FrameBitsPerRow-1) (k=0 is the most left (=first) character
                # But that character represents the MSB inside the frame, which iterates FrameBitsPerRow-1..0
                # bit_mask[0],                    bit_mask[1],                    bit_mask[2], ...
                # FrameData[FrameBitsPerRow-1-0], FrameData[FrameBitsPerRow-1-1], FrameData[FrameBitsPerRow-1-2],
                print('\t.D(FrameData['+str(FrameBitsPerRow-1-k)+']),', file=file)
                print('\t.E(FrameStrobe['+str(frame)+']),', file=file)
                print('\t.Q(ConfigBits['+str(AllConfigBitsOrder[AllConfigBitsCounter])+']),', file=file)
                print('\t.QN(ConfigBits_N['+str(AllConfigBitsOrder[AllConfigBitsCounter])+'])', file=file)
                print('\t);\n', file=file)
                AllConfigBitsCounter += 1

    print('endmodule', file=file)

    return

def GenerateTileVerilog( tile_description, module, file ):
    MatrixInputs = []
    MatrixOutputs = []
    TileInputs = []
    TileOutputs = []
    BEL_Inputs = []
    BEL_Outputs = []
    AllJumpWireList = []
    NuberOfSwitchMatricesWithConfigPort = 0
    CLOCK_Tile = False

    # We first check if we need a configuration port
    # Currently we assume that each primitive needs a configuration port
    # However, a switch matrix can have no switch matrix multiplexers
    # (e.g., when only bouncing back in border termination tiles)
    # we can detect this as each switch matrix file contains a comment // NumberOfConfigBits
    # NumberOfConfigBits:0 tells us that the switch matrix does not have a config port
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning
    # TODO: we don't do this and always create a configuration port for each tile. This may dangle the CLK and MODE ports hanging in the air, which will throw a warning

    TileTypeMarker = False
    for line in tile_description:
        if line[0] == 'TILE':
            TileType = line[TileType_position]
            TileTypeMarker = True
    if TileTypeMarker == False:
        raise ValueError('Could not find tile type in function GenerateTileVHDL')

    # the VHDL initial header generation is shared until the Port
    # in order to use GenerateVHDL_Header, we have to count the number of configuration bits by scanning all files for the "Generic ( NoConfigBits...
    GlobalConfigBitsCounter = 0
    if ConfigBitMode == 'frame_based':
        for line in tile_description:
            if (line[0] == 'BEL') or (line[0] == 'MATRIX'):
                if (GetNoConfigBitsFromFile(line[VHDL_file_position])) != 'NULL':
                    GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(GetNoConfigBitsFromFile(line[VHDL_file_position]))
    # GenerateVerilog_Header(file, module, NoConfigBits=str(GlobalConfigBitsCounter))
    module_header_ports_list = GetTileComponentPort_Verilog(tile_description, 'NORTH')
    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'EAST'))
    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'SOUTH'))
    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'WEST'))
    module_header_ports = ', '.join(module_header_ports_list)
    ExternalPorts = []
    for line in tile_description:
        if line[0] == 'BEL':
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            ExternalPorts = ExternalPorts + (GetComponentPortsFromFile(line[VHDL_file_position], port='external', BEL_Prefix = BEL_prefix_string+'BEL_prefix_string_marker'))
    SharedExternalPorts = []
    if ExternalPorts != []:
        for item in ExternalPorts:
            if re.search('SHARED_PORT', item):
                shared_port = re.sub(':.*', '',re.sub('.*BEL_prefix_string_marker', '', item)).strip()
                if shared_port not in SharedExternalPorts:
                    bel_port = re.split(' |	',re.sub('.*BEL_prefix_string_marker', '', item))
                    if bel_port[0] == 'UserCLK':
                        CLOCK_Tile = True
                    if bel_port[2] == 'in':
                        module_header_ports += ', '+bel_port[0]
                    elif bel_port[2] == 'out':
                        module_header_ports += ', '+bel_port[0]
                    SharedExternalPorts.append(shared_port)
            else:
                bel_port = re.split(' |	',re.sub('BEL_prefix_string_marker', '', item))
                if bel_port[2] == 'in':
                    module_header_ports += ', '+bel_port[0]
                elif bel_port[2] == 'out':
                    module_header_ports += ', '+bel_port[0]
    if CLOCK_Tile:
        module_header_ports += ', UserCLKo'
    else:
        module_header_ports += ', UserCLK, UserCLKo'
    if ConfigBitMode == 'frame_based':
        if GlobalConfigBitsCounter > 0:
            #module_header_ports += ', FrameData, FrameStrobe'
            module_header_ports += ', FrameData, FrameData_O, FrameStrobe, FrameStrobe_O'
        else :
            module_header_ports += ', FrameStrobe, FrameStrobe_O'
    else:
        if ConfigBitMode == 'FlipFlopChain':
            module_header_ports += ', MODE, CONFin, CONFout, CLK'
        elif ConfigBitMode == 'frame_based':
            module_header_ports += ', ConfigBits, ConfigBits_N'

    # insert CLB, I/O (or whatever BEL) component declaration
    # specified in the fabric csv file after the 'BEL' key word
    BEL_VHDL_riles_processed = []     # we use this list to check if we have seen a BEL description before so we only insert one component declaration
    module_header_files = []
    for line in tile_description:
        if line[0] == 'BEL':
            Inputs = []
            Outputs = []
            if line[VHDL_file_position] not in BEL_VHDL_riles_processed:
                module_header_files.append(line[VHDL_file_position].replace('vhdl','v'))
            BEL_VHDL_riles_processed.append(line[VHDL_file_position])
            # we need the BEL ports (a little later) so we take them on the way
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            Inputs, Outputs = GetComponentPortsFromFile(line[VHDL_file_position], BEL_Prefix=BEL_prefix_string)
            BEL_Inputs = BEL_Inputs + Inputs
            BEL_Outputs = BEL_Outputs + Outputs
    # insert switch matrix component declaration
    # specified in the fabric csv file after the 'MATRIX' key word
    MatrixMarker = False
    for line in tile_description:
        if line[0] == 'MATRIX':
            if MatrixMarker == True:
                raise ValueError('More than one switch matrix defined for tile '+TileType+'; exeting GenerateTileVHDL')
            NuberOfSwitchMatricesWithConfigPort = NuberOfSwitchMatricesWithConfigPort + GetVerilogDeclarationForFile(line[VHDL_file_position])
            module_header_files.append(line[VHDL_file_position].replace('vhdl','v'))
            # we need the switch matrix ports (a little later)
            MatrixInputs, MatrixOutputs = GetComponentPortsFromFile(line[VHDL_file_position])
            MatrixMarker = True
    if MatrixMarker == False:
        raise ValueError('Could not find switch matrix definition for tyle type '+TileType+' in function GenerateTileVHDL')
    if ConfigBitMode == 'frame_based' and GlobalConfigBitsCounter > 0:
        module_header_files.append(module+'_ConfigMem.v')

    GenerateVerilog_Header(module_header_ports, file, module, package='', NoConfigBits=str(GlobalConfigBitsCounter), MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow), module_header_files=module_header_files)

    PrintTileComponentPort_Verilog (tile_description, 'NORTH', file)
    PrintTileComponentPort_Verilog (tile_description, 'EAST', file)
    PrintTileComponentPort_Verilog (tile_description, 'SOUTH', file)
    PrintTileComponentPort_Verilog (tile_description, 'WEST', file)
    # now we have to scan all BELs if they use external pins, because they have to be exported to the tile module
    ExternalPorts = []
    for line in tile_description:
        if line[0] == 'BEL':
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            ExternalPorts = ExternalPorts + (GetComponentPortsFromFile(line[VHDL_file_position], port='external', BEL_Prefix = BEL_prefix_string+'BEL_prefix_string_marker'))
    # if we found BELs with top-level IO ports, we just pass them through
    SharedExternalPorts = []
    
    if ExternalPorts != []:
        print('\t// Tile IO ports from BELs', file=file)
        for item in ExternalPorts:
            # if a part is flagged with the 'SHARED_PORT' comment, we declare that port only ones
            # we use the string 'BEL_prefix_string_marker' to separate the port name from the prefix
            if re.search('SHARED_PORT', item):
                # we firstly get the plain port name without comments, whitespaces, etc.
                # we place that in the SharedExternalPorts list to check if that port was declared earlier
                shared_port = re.sub(':.*', '',re.sub('.*BEL_prefix_string_marker', '', item)).strip()
                if shared_port not in SharedExternalPorts:
                    bel_port = re.split(' |	',re.sub('.*BEL_prefix_string_marker', '', item))
                    if bel_port[2] == 'in':
                        print('\tinput '+bel_port[0]+';', file=file)
                    elif bel_port[2] == 'out':
                        print('\toutput '+bel_port[0]+';', file=file)
                    SharedExternalPorts.append(shared_port)
            else:
                bel_port = re.split(' |	',re.sub('BEL_prefix_string_marker', '', item))
                if bel_port[2] == 'in':
                    print('\tinput '+bel_port[0]+';', file=file)
                elif bel_port[2] == 'out':
                    print('\toutput '+bel_port[0]+';', file=file)
    if CLOCK_Tile:
        print('\toutput UserCLKo;', file=file)
    else:
        print('\tinput UserCLK;', file=file)
        print('\toutput UserCLKo;', file=file)
    # the rest is a shared text block
    if ConfigBitMode == 'frame_based':
        if GlobalConfigBitsCounter > 0:
            #print('\tinput [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            #print('\tinput [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ', file=file)
            print('\tinput [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            print('\toutput [FrameBitsPerRow-1:0] FrameData_O;', file=file)
            print('\tinput [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            print('\toutput [MaxFramesPerCol-1:0] FrameStrobe_O;', file=file)
        else :
            # print('\tinput [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            # print('\toutput [FrameBitsPerRow-1:0] FrameData_O;', file=file)
            print('\tinput [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
            print('\toutput [MaxFramesPerCol-1:0] FrameStrobe_O;', file=file)

        GenerateVerilog_PortsFooter(file, module, ConfigPort=False)
    else:
        GenerateVerilog_PortsFooter(file, module)



    # VHDL signal declarations
    print('//signal declarations', file=file)
    # BEL port wires
    print('//BEL ports (e.g., slices)', file=file)
    for port in (BEL_Inputs + BEL_Outputs):
        print('\twire '+port+';', file=file)
    # Jump wires
    print('//jump wires', file=file)
    for line in tile_description:
        if line[0] == 'JUMP':
            if (line[source_name] == '') or (line[destination_name] == ''):
                raise ValueError('Either source or destination port for JUMP wire missing in function GenerateTileVHDL')
            # we don't add ports or a corresponding signal name, if we have a NULL driver (which we use as an exception for GND and VCC (VCC0 GND0)
            if not re.search('NULL', line[source_name], flags=re.IGNORECASE):
                print('\twire ['+str(line[wires])+'-1:0] '+line[source_name]+';', file=file)
            # we need the jump wires for the switch matrix component instantiation..
                for k in range(int(line[wires])):
                    AllJumpWireList.append(str(line[source_name]+'('+str(k)+')'))
    # internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
    print('//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)', file=file)
    # the signal has to be number of BELs+2 bits wide (Bel_counter+1 downto 0)
    BEL_counter = 0
    for line in tile_description:
        if line[0] == 'BEL':
            BEL_counter += 1

    # we chain switch matrices only to the configuration port, if they really contain configuration bits
    # i.e. switch matrices have a config port which is indicated by "NumberOfConfigBits:0 is false"

    # The following conditional as intended to only generate the config_data signal if really anything is actually configured
    # however, we leave it and just use this signal as conf_data(0 downto 0) for simply touting through CONFin to CONFout
    # maybe even useful if we want to add a buffer here
    # if (Bel_Counter + NuberOfSwitchMatricesWithConfigPort) > 0

    #print('\twire ['+str(BEL_counter+NuberOfSwitchMatricesWithConfigPort)+':0] conf_data;', file=file)
    if GlobalConfigBitsCounter > 0:
        print('\twire [NoConfigBits-1:0] ConfigBits;', file=file)
        print('\twire [NoConfigBits-1:0] ConfigBits_N;', file=file)

    # Cascading of routing for wires spanning more than one tile
        print('\n// Cascading of routing for wires spanning more than one tile', file=file)
    
        print('\twire [FrameBitsPerRow-1:0] FrameData_i;', file=file)
        print('\twire [FrameBitsPerRow-1:0] FrameData_O_i;', file=file)
    
        print('\tassign FrameData_O_i = FrameData_i;\n', file=file)
    
        for m in range(FrameBitsPerRow):
            print('\tmy_buf data_inbuf_'+str(m)+' (', file=file)
            print('\t.A(FrameData['+str(m)+']),', file=file)
            print('\t.X(FrameData_i['+str(m)+'])', file=file)
            print('\t);\n', file=file)
        
        for m in range(FrameBitsPerRow):
            #print('\tgenvar m;', file=file)
            #print('\tfor (m=0; m<FrameBitsPerRow; m=m+1) begin: data_buf', file=file)
            print('\tmy_buf data_outbuf_'+str(m)+' (', file=file)
            print('\t.A(FrameData_O_i['+str(m)+']),', file=file)
            print('\t.X(FrameData_O['+str(m)+'])', file=file)
            print('\t);\n', file=file)
            #print('\tend\n', file=file)
        
    print('\twire [MaxFramesPerCol-1:0] FrameStrobe_i;', file=file)
    print('\twire [MaxFramesPerCol-1:0] FrameStrobe_O_i;', file=file)
    
    print('\tassign FrameStrobe_O_i = FrameStrobe_i;\n', file=file)
    
    for n in range(MaxFramesPerCol):
        print('\tmy_buf strobe_inbuf_'+str(n)+' (', file=file)
        print('\t.A(FrameStrobe['+str(n)+']),', file=file)
        print('\t.X(FrameStrobe_i['+str(n)+'])', file=file)
        print('\t)\n;', file=file)
    
    for n in range(MaxFramesPerCol):
        #print('\tgenvar n;', file=file)
        #print('\tfor (n=0; n<MaxFramesPerCol; n=n+1) begin: strobe_buf', file=file)
        print('\tmy_buf strobe_outbuf_'+str(n)+' (', file=file)
        print('\t.A(FrameStrobe_O_i['+str(n)+']),', file=file)
        print('\t.X(FrameStrobe_O['+str(n)+'])', file=file)
        print('\t)\n;', file=file)
        #print('\tend\n', file=file)
    
    for line in tile_description:
        if line[0] in ['NORTH','EAST','SOUTH','WEST']:
            span=abs(int(line[X_offset]))+abs(int(line[Y_offset]))
            # in case a signal spans 2 ore more tiles in any direction
            if (span >= 2) and (line[source_name]!='NULL') and (line[destination_name]!='NULL'):
                high_bound_index = (span*int(line[wires]))-1
                print('\twire ['+str(high_bound_index)+':0] '+line[destination_name]+'_i;', file=file)
                print('\twire ['+str(high_bound_index-int(line[wires]))+':0] '+line[source_name]+'_i;', file=file)
                
                print('\tassign '+line[source_name]+'_i['+str(high_bound_index)+'-'+str(line[wires])+':0]',end='', file=file)
                print(' = '+line[destination_name]+'_i['+str(high_bound_index)+':'+str(line[wires])+'];\n', file=file)
                
                for i in range(int(high_bound_index)-int(line[wires])+1):
                #print('\tgenvar '+line[0][0]+'_index;', file=file)
                #print('\tfor ('+line[0][0]+'_index=0; '+line[0][0]+'_index<='+str(high_bound_index)+'-'+str(line[wires])+'; '+line[0][0]+'_index='+line[0][0]+'_index+1) begin: '+line[0][0]+'_buf', file=file)
                    print('\tmy_buf '+line[destination_name]+'_inbuf_'+str(i)+' (', file=file)
                    print('\t.A('+line[destination_name]+'['+str(i+int(line[wires]))+']),', file=file)
                    print('\t.X('+line[destination_name]+'_i['+str(i+int(line[wires]))+'])', file=file)
                    print('\t);\n', file=file)
                #print('\tend\n', file=file)
                
                for j in range(int(high_bound_index)-int(line[wires])+1):
                #print('\tgenvar '+line[0][0]+'_index;', file=file)
                #print('\tfor ('+line[0][0]+'_index=0; '+line[0][0]+'_index<='+str(high_bound_index)+'-'+str(line[wires])+'; '+line[0][0]+'_index='+line[0][0]+'_index+1) begin: '+line[0][0]+'_buf', file=file)
                    print('\tmy_buf '+line[source_name]+'_outbuf_'+str(j)+' (', file=file)
                    print('\t.A('+line[source_name]+'_i['+str(j)+']),', file=file)
                    print('\t.X('+line[source_name]+'['+str(j)+'])', file=file)
                    print('\t);\n', file=file)
                #print('\tend\n', file=file)

    print('\tclk_buf inst_clk_buf(.A(UserCLK), .X(UserCLKo));', file=file)
    # top configuration data daisy chaining
    if ConfigBitMode == 'FlipFlopChain':
        print('// top configuration data daisy chaining', file=file)
        print('\tassign conf_data[$low(conf_data)] = CONFin; // conf_data\'low=0 and CONFin is from tile module', file=file)
        print('\tassign CONFout = conf_data[$high(conf_data)]; // CONFout is from tile module', file=file)

    # the <module>_ConfigMem module is only parametrized through generics, so we hard code its instantiation here
    if ConfigBitMode == 'frame_based' and GlobalConfigBitsCounter > 0:
        print('\n// configuration storage latches', file=file)
        print('\t'+module+'_ConfigMem Inst_'+module+'_ConfigMem (', file=file)
        print('\t.FrameData(FrameData),', file=file)
        print('\t.FrameStrobe(FrameStrobe),', file=file)
        print('\t.ConfigBits(ConfigBits),', file=file)
        print('\t.ConfigBits_N(ConfigBits_N)', file=file)
        print('\t);', file=file)

    # BEL component instantiations
    print('\n//BEL component instantiations', file=file)
    All_BEL_Inputs = []                # the right hand signal name which gets a BEL prefix
    All_BEL_Outputs = []            # the right hand signal name which gets a BEL prefix
    left_All_BEL_Inputs = []        # the left hand port name which does not get a BEL prefix
    left_All_BEL_Outputs = []        # the left hand port name which does not get a BEL prefix
    BEL_counter = 0
    BEL_ConfigBitsCounter = 0
    for line in tile_description:
        if line[0] == 'BEL':
            BEL_Inputs = []            # the right hand signal name which gets a BEL prefix
            BEL_Outputs = []        # the right hand signal name which gets a BEL prefix
            left_BEL_Inputs = []    # the left hand port name which does not get a BEL prefix
            left_BEL_Outputs = []    # the left hand port name which does not get a BEL prefix
            ExternalPorts = []
            if len(line) >= 3:        # we use the third column to specify an optional BEL prefix
                BEL_prefix_string = line[BEL_prefix]
            else:
                BEL_prefix_string = ''
            # the BEL I/Os that go to the switch matrix
            BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position], BEL_Prefix=BEL_prefix_string)
            left_BEL_Inputs, left_BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
            # the BEL I/Os that go to the tile top module
            # ExternalPorts = GetComponentPortsFromFile(line[VHDL_file_position], port='external', BEL_Prefix=BEL_prefix_string)
            ExternalPorts = GetComponentPortsFromFile(line[VHDL_file_position], port='external')
            # we remember All_BEL_Inputs and All_BEL_Outputs as wee need these pins for the switch matrix
            All_BEL_Inputs  = All_BEL_Inputs + BEL_Inputs
            All_BEL_Outputs = All_BEL_Outputs + BEL_Outputs
            left_All_BEL_Inputs  = left_All_BEL_Inputs  + left_BEL_Inputs
            left_All_BEL_Outputs = left_All_BEL_Outputs + left_BEL_Outputs
            EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
            print('\t'+EntityName+' Inst_'+BEL_prefix_string+EntityName+' (', file=file)

            for k in range(len(BEL_Inputs+BEL_Outputs)):
                print('\t.'+(left_BEL_Inputs+left_BEL_Outputs)[k]+'('+(BEL_Inputs+BEL_Outputs)[k]+'),', file=file)
            # top level I/Os (if any) just get connected directly
            if ExternalPorts != []:
                print('\t//I/O primitive pins go to tile top level module (not further parsed)  ', file=file)
                for item in ExternalPorts:
                    # print('DEBUG ExternalPort :',item)
                    port = re.sub('\:.*', '', item)
                    substitutions = {" ": "", "\t": ""}
                    port=(replace(port, substitutions))
                    if re.search('SHARED_PORT', item):
                        print('\t.'+port+'('+port+'),', file=file)
                    else:  # if not SHARED_PORT then add BEL_prefix_string to signal name
                        print('\t.'+port+'('+BEL_prefix_string+port+'),', file=file)

            # global configuration port
            if ConfigBitMode == 'FlipFlopChain':
                GenerateVerilog_Conf_Instantiation(file=file, counter=BEL_counter, close=True)
            if ConfigBitMode == 'frame_based':
                BEL_ConfigBits = GetNoConfigBitsFromFile(line[VHDL_file_position])
                if BEL_ConfigBits != 'NULL':
                    if int(BEL_ConfigBits) == 0:
                        #print('\t.ConfigBits(0)', file=file)
                        last_pos = file.tell()
                        for k in range(20):
                            file.seek(last_pos -k)                # scan character by character backwards and look for ','
                            my_char = file.read(1)
                            if my_char == ',':
                                file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
                                print(' ', end='', file=file)
                                break                            # stop scan

                        file.seek(0, os.SEEK_END)          # go back to usual...
                        print('\t);\n', file=file)
                    else:
                        print('\t.ConfigBits(ConfigBits['+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+'-1:'+str(BEL_ConfigBitsCounter)+'])', file=file)
                        #print('\t.ConfigBits(ConfigBits_N['+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+'-1:'+str(BEL_ConfigBitsCounter)+'])', file=file)
                        print('\t);\n', file=file)
                        BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
            # for the next BEL (if any) for cascading configuration chain (this information is also needed for chaining the switch matrix)
            BEL_counter += 1

    # switch matrix component instantiation
    # important to know:
    # Each switch matrix module is build up is a specific order:
    # 1.a) interconnect wire INPUTS (in the order defined by the fabric file,)
    # 2.a) BEL primitive INPUTS (in the order the BEL-VHDLs are listed in the fabric CSV)
    #      within each BEL, the order from the module is maintained
    #      Note that INPUTS refers to the view of the switch matrix! Which corresponds to BEL outputs at the actual BEL
    # 3.a) JUMP wire INPUTS (in the order defined by the fabric file)
    # 1.b) interconnect wire OUTPUTS
    # 2.b) BEL primitive OUTPUTS
    #      Again: OUTPUTS refers to the view of the switch matrix which corresponds to BEL inputs at the actual BEL
    # 3.b) JUMP wire OUTPUTS
    # The switch matrix uses single bit ports (std_logic and not std_logic_vector)!!!

    print('\n//switch matrix component instantiation', file=file)
    for line in tile_description:
        if line[0] == 'MATRIX':
            BEL_Inputs = []
            BEL_Outputs = []
            BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
            EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
            print('\t'+EntityName+' Inst_'+EntityName+' (', file=file)
            # for port in BEL_Inputs + BEL_Outputs:
                # print('\t\t',port,' => ',port,',', file=file)
            Inputs = []
            Outputs = []
            TopInputs = []
            TopOutputs = []
            # Inputs, Outputs = GetTileComponentPorts(tile_description, mode='SwitchMatrixIndexed')
            # changed to:  AutoSwitchMatrixIndexed
            Inputs, Outputs = GetTileComponentPorts(tile_description, mode='AutoSwitchMatrixIndexed')
            # TopInputs, TopOutputs = GetTileComponentPorts(tile_description, mode='TopIndexed')
            # changed to: AutoTopIndexed
            TopInputs, TopOutputs = GetTileComponentPorts(tile_description, mode='AutoTopIndexed')
            for k in range(len(BEL_Inputs+BEL_Outputs)):
                print('\t.'+(BEL_Inputs+BEL_Outputs)[k]+'(',end='', file=file)
                # note that the BEL outputs (e.g., from the slice component) are the switch matrix inputs
                print((Inputs+All_BEL_Outputs+AllJumpWireList+TopOutputs+All_BEL_Inputs+AllJumpWireList)[k].replace('(','[').replace(')',']')+')', end='', file=file)
                if NuberOfSwitchMatricesWithConfigPort > 0:
                    print(',', file=file)
                else:
                    # stupid VHDL does not allow us to have a ',' for the last port connection, so we need the following for NuberOfSwitchMatricesWithConfigPort==0
                    if k < ((len(BEL_Inputs+BEL_Outputs)) - 1):
                        print(',', file=file)
                    else:
                        print('', file=file)
            if NuberOfSwitchMatricesWithConfigPort > 0:
                if ConfigBitMode == 'FlipFlopChain':
                    GenerateVerilog_Conf_Instantiation(file=file, counter=BEL_counter, close=False)
                    # print('\t // GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
                    # print('\t\t MODE    => Mode,  ', file=file)
                    # print('\t\t CONFin    => conf_data('+str(BEL_counter)+'),  ', file=file)
                    # print('\t\t CONFout    => conf_data('+str(BEL_counter+1)+'),  ', file=file)
                    # print('\t\t CLK => CLK   ', file=file)
                if ConfigBitMode == 'frame_based':
                    BEL_ConfigBits = GetNoConfigBitsFromFile(line[VHDL_file_position])
                    if BEL_ConfigBits != 'NULL':
                    # print('DEBUG:',BEL_ConfigBits)
                        print('\t.ConfigBits(ConfigBits['+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+'-1:'+str(BEL_ConfigBitsCounter)+']),', file=file)
                        print('\t.ConfigBits_N(ConfigBits_N['+str(BEL_ConfigBitsCounter + int(BEL_ConfigBits))+'-1:'+str(BEL_ConfigBitsCounter)+'])', file=file)
                        BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
            print('\t);', file=file)
    print('\n'+'endmodule', file=file)
    return

def GenerateSuperTileVerilog(super_tile_description, module, file):
    y_tiles=len(super_tile_description)      # get the number of tiles in vertical direction
    x_tiles=len(super_tile_description[0])   # get the number of tiles in horizontal direction
    TileTypes = GetCellTypes(super_tile_description)
    module_header_ports_list = []
    module_header_files = []
    TileTypeOutputPorts = []
    
    for tile in TileTypes:
        module_header_files.append(str(tile)+'_tile.v')
        Inputs, Outputs = GetComponentPortsFromFile(str(tile)+'_tile.vhdl')
        TileTypeOutputPorts.append(Outputs)
        
    print('\t//External IO ports exported directly from the corresponding tiles', file=file)
    ExternalPorts = []
    SharedExternalPorts = []
    port_list = []
    external_port_list = ['\t// Tile IO ports from BELs']
    wire_list = []
    module_header_ports = ''

    for y in range(y_tiles):
        for x in range(x_tiles):
            if super_tile_description[y][x] != 'NULL':
                left_edge = False
                right_edge = False
                top_edge = False
                bot_edge = False
    
                if x == 0:
                    left_edge = True
                else:
                    if super_tile_description[y][x-1] == 'NULL':
                        left_edge = True
                if x == x_tiles-1:
                    right_edge = True
                else:
                    if super_tile_description[y][x+1] == 'NULL':
                        right_edge = True
                if y == 0:
                    top_edge = True
                else:
                    if super_tile_description[y-1][x] == 'NULL':
                        top_edge = True
                if y == y_tiles-1:
                    bot_edge = True
                else:
                    if super_tile_description[y+1][x] == 'NULL':
                        bot_edge = True
                
                tile_description = GetTileFromFile(FabricFile,str(super_tile_description[y][x]))
                GlobalConfigBitsCounter = 0
                if ConfigBitMode == 'frame_based':
                    for line in tile_description:
                        if (line[0] == 'BEL') or (line[0] == 'MATRIX'):
                            if (GetNoConfigBitsFromFile(line[VHDL_file_position])) != 'NULL':
                                GlobalConfigBitsCounter = GlobalConfigBitsCounter + int(GetNoConfigBitsFromFile(line[VHDL_file_position]))
    
                port_prefix = 'Tile_X'+str(x)+'Y'+str(y)
                if top_edge: #outer connection
                    module_header_ports_list = GetTileComponentPort_Verilog(tile_description, 'NORTH', port_prefix)
                    port_list.extend(GetTileComponentPort_Verilog_Str(tile_description, 'NORTH',port_prefix))
                else: #inner connection
                    wire_list.extend(GetTileComponentWire_Verilog_Str(tile_description, 'NORTH',port_prefix))
                if right_edge:
                    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'EAST', port_prefix))
                    port_list.extend(GetTileComponentPort_Verilog_Str(tile_description, 'EAST', port_prefix))
                else:
                    wire_list.extend(GetTileComponentWire_Verilog_Str(tile_description, 'EAST',port_prefix))
                if bot_edge:
                    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'SOUTH', port_prefix))
                    port_list.extend(GetTileComponentPort_Verilog_Str(tile_description, 'SOUTH', port_prefix))
                else:
                    wire_list.extend(GetTileComponentWire_Verilog_Str(tile_description, 'SOUTH',port_prefix))
                if left_edge:
                    module_header_ports_list.extend(GetTileComponentPort_Verilog(tile_description, 'WEST', port_prefix))
                    port_list.extend(GetTileComponentPort_Verilog_Str(tile_description, 'WEST', port_prefix))
                else:
                    wire_list.extend(GetTileComponentWire_Verilog_Str(tile_description, 'WEST',port_prefix))
                    
                CurrentTileExternalPorts = GetComponentPortsFromFile(super_tile_description[y][x]+'_tile.vhdl', port='external')
                if CurrentTileExternalPorts != []:
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        PortDefinition = PortDefinition.replace('-- ','//').replace('STD_LOGIC;','').replace('STD_LOGIC','').replace('\t','')
                        if re.search('SHARED_PORT', item):
                            # for the module, we define only the very first for all SHARED_PORTs of any name category
                            if PortName not in SharedExternalPorts:
                                module_header_ports_list.append(PortName)
                                if 'in' in PortDefinition:
                                    PortDefinition = PortDefinition.replace('in','')
                                    external_port_list.append('\tinput '+PortName+';'+PortDefinition)
                                elif 'out' in PortDefinition:
                                    PortDefinition = PortDefinition.replace('out','')
                                    external_port_list.append('\toutput '+PortName+';'+PortDefinition)
                                SharedExternalPorts.append(PortName)
                            # we remember the used port name for the component instantiations to come
                            # for the instantiations, we have to keep track about all external ports
                            ExternalPorts.append(PortName)
                        else:
                            module_header_ports_list.append('Tile_X'+str(x)+'Y'+str(y)+'_'+PortName)
                            if 'in' in PortDefinition:
                                PortDefinition = PortDefinition.replace('in','')
                                external_port_list.append('\tinput '+'Tile_X'+str(x)+'Y'+str(y)+'_'+PortName+';'+PortDefinition)
                            elif 'out' in PortDefinition:
                                PortDefinition = PortDefinition.replace('out','')
                                external_port_list.append('\toutput '+'Tile_X'+str(x)+'Y'+str(y)+'_'+PortName+';'+PortDefinition)
                            # we remember the used port name for the component instantiations to come
                            # we are maintaining the here used Tile_XxYy prefix as a sanity check
                            # ExternalPorts = ExternalPorts + 'Tile_X'+str(x)+'Y'+str(y)+'_'+str(PortName)
                            ExternalPorts.append('Tile_X'+str(x)+'Y'+str(y)+'_'+PortName)
    
                if ConfigBitMode == 'frame_based': #', FrameData, FrameStrobe'
                    if top_edge: 
                        module_header_ports_list.append(port_prefix+'_'+'FrameStrobe_O')
                        external_port_list.append('\toutput [MaxFramesPerCol-1:0] '+port_prefix+'_'+'FrameStrobe_O;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')
                    else:
                        wire_list.append('\twire [MaxFramesPerCol-1:0] '+port_prefix+'_'+'FrameStrobe_O;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')
                    if bot_edge:
                        module_header_ports_list.append(port_prefix+'_'+'FrameStrobe')
                        external_port_list.append('\tinput [MaxFramesPerCol-1:0] '+port_prefix+'_'+'FrameStrobe;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')
                    if left_edge:
                        module_header_ports_list.append(port_prefix+'_'+'FrameData')
                        external_port_list.append('\tinput [FrameBitsPerRow-1:0] '+port_prefix+'_'+'FrameData;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')
                    if right_edge:
                        module_header_ports_list.append(port_prefix+'_'+'FrameData_O')
                        external_port_list.append('\toutput [FrameBitsPerRow-1:0] '+port_prefix+'_'+'FrameData_O;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')
                    else:
                        wire_list.append('\twire [FrameBitsPerRow-1:0] '+port_prefix+'_'+'FrameData_O;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ')

    module_header_ports += ', '.join(module_header_ports_list)
    GenerateVerilog_Header(module_header_ports, file, module,  MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow),module_header_files = module_header_files)
    print('',file=file)
    
    for line_print in port_list:
        print(line_print, file=file)
    for line_print in external_port_list:
        print(line_print, file=file)
    #GenerateVerilog_PortsFooter(file, module)
    print('//signal declarations', file=file)
    for line_print in wire_list:
        print(line_print, file=file)
    print('//configuration signal declarations\n', file=file)

    tile_counter = 0
    ExternalPorts_counter = 0
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (super_tile_description[y][x]) != 'NULL':
                left_edge = False
                right_edge = False
                top_edge = False
                bot_edge = False
                if x == 0:
                    left_edge = True
                else:
                    if super_tile_description[y][x-1] == 'NULL':
                        left_edge = True
                if x == x_tiles-1:
                    right_edge = True
                else:
                    if super_tile_description[y][x+1] == 'NULL':
                        right_edge = True
                if y == 0:
                    top_edge = True
                else:
                    if super_tile_description[y-1][x] == 'NULL':
                        top_edge = True
                if y == y_tiles-1:
                    bot_edge = True
                else:
                    if super_tile_description[y+1][x] == 'NULL':
                        bot_edge = True

                EntityName = GetComponentEntityNameFromFile(str(super_tile_description[y][x])+'_tile.vhdl')
                print('\t'+EntityName+' Tile_X'+str(x)+'Y'+str(y)+'_'+EntityName+' (', file=file)
                TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl')
                # print('DEBUG TileInputs: ', TileInputs)
                # print('DEBUG TileOutputs: ', TileOutputs)
                TilePorts = []
                TilePortsDebug = []
                # for connecting the instance, we write the tile ports in the order all inputs and all outputs
                for port in TileInputs + TileOutputs:
                    # GetComponentPortsFromFile returns vector information that starts with "(..." and we throw that away
                    # However the vector information is still interesting for debug purpose
                    TilePorts.append(re.sub(' ','',(re.sub('\(.*', '', port, flags=re.IGNORECASE))))
                    TilePortsDebug.append(port)

                # now we get the connecting input signals in the order NORTH EAST SOUTH WEST (order is given in fabric.csv)
                # from the adjacent tiles. For example, a NorthEnd-port is connected to a SouthBeg-port on tile Y+1
                # note that super_tile_description[y][x] has its origin [0][0] in the top left corner
                TileInputSignal = []
                TileInputSignalCountPerDirection = []
                # IMPORTANT: we have to go through the following in NORTH EAST SOUTH WEST order
                # NORTH direction: get the NiBEG wires from tile y+1, because they drive NiEND
                if bot_edge:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='NORTH')
                    for port in TileInputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    if TileInputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileInputs))
                else:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y+1][x])+'_tile.vhdl', filter='NORTH')
                    for port in TileOutputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y+1)+'_'+port)
                    if TileOutputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileOutputs))
                # EAST direction: get the EiBEG wires from tile x-1, because they drive EiEND
                if left_edge:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='EAST')
                    for port in TileInputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    if TileInputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileInputs))
                else:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x-1])+'_tile.vhdl', filter='EAST')
                    for port in TileOutputs:
                        TileInputSignal.append('Tile_X'+str(x-1)+'Y'+str(y)+'_'+port)
                    if TileOutputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileOutputs))
                # SOUTH direction: get the SiBEG wires from tile y-1, because they drive SiEND
                if top_edge:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='SOUTH')
                    for port in TileInputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    if TileInputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileInputs))
                else:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y-1][x])+'_tile.vhdl', filter='SOUTH')
                    for port in TileOutputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y-1)+'_'+port)
                    if TileOutputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileOutputs))
                # WEST direction: get the WiBEG wires from tile x+1, because they drive WiEND
                if right_edge:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='WEST')
                    for port in TileInputs:
                        TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    if TileInputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileInputs))
                else:
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x+1])+'_tile.vhdl', filter='WEST')
                    for port in TileOutputs:
                        TileInputSignal.append('Tile_X'+str(x+1)+'Y'+str(y)+'_'+port)
                    if TileOutputs == []:
                        TileInputSignalCountPerDirection.append(0)
                    else:
                        TileInputSignalCountPerDirection.append(len(TileOutputs))
                # at this point, TileInputSignal is carrying all the driver signals from the surrounding tiles (the BEG signals of those tiles)
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y3_N1BEG( 3 downto 0 )"
                # for element in TileInputSignal:
                    # print('DEBUG TileInputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                # the output signals are named after the output ports
                TileOutputSignal = []
                TileInputsCountPerDirection = []
                # as for the VHDL signal generation, we simply add a prefix like "Tile_X1Y0_" to the begin port
                # for port in TileOutputs:
                    # TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                if (super_tile_description[y][x]) != 'NULL':
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='NORTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='EAST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='SOUTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl', filter='WEST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                # at this point, TileOutputSignal is carrying all the signal names that will be driven by the present tile
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y2_W1BEG( 3 downto 0 )"
                # for element in TileOutputSignal:
                    # print('DEBUG TileOutputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                if (super_tile_description[y][x]) != 'NULL':    # looks like this conditional is redundant
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(super_tile_description[y][x])+'_tile.vhdl')
                # example: W6END( 11 downto 0 ), N1BEG( 3 downto 0 ), ...
                # meaning: the END-ports are the tile inputs followed by the actual tile output ports (typically BEG)
                # this is essentially the left side (the component ports) of the component instantiation

                CheckFailed = False
                # sanity check: The number of input ports has to match the TileInputSignal per direction (N,E,S,W)
                if (super_tile_description[y][x]) != 'NULL':
                    for k in range(0,4):
                        if TileInputsCountPerDirection[k] != TileInputSignalCountPerDirection[k]:
                            print('ERROR: component input missmatch in '+str(All_Directions[k])+' direction for Tile_X'+str(x)+'Y'+str(y)+' of type '+str(super_tile_description[y][x]))
                            CheckFailed = True
                    if CheckFailed == True:
                        print('Error in function GenerateFabricVHDL')
                        print('DEBUG:TileInputs: ',TileInputs)
                        print('DEBUG:TileInputSignal: ',TileInputSignal)
                        print('DEBUG:TileOutputs: ',TileOutputs)
                        print('DEBUG:TileOutputSignal: ',TileOutputSignal)
                        # raise ValueError('Error in function GenerateFabricVHDL')
                # the output ports are derived from the same list and should therefore match automatically

                # for element in (TileInputs+TileOutputs):
                    # print('DEBUG TileInputs+TileOutputs :'+'Tile_X'+str(x)+'Y'+str(y)+'element:', element)

                if (super_tile_description[y][x]) != 'NULL':    # looks like this conditional is redundant
                    for k in range(0,len(TileInputs)):
                        PortName = re.sub('\(.*', '', TileInputs[k])
                        print('\t.'+PortName+'('+TileInputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),',file=file)
                        # print('DEBUG_INPUT: '+PortName+'\t=> '+TileInputSignal[k]+',')
                    for k in range(0,len(TileOutputs)):
                        PortName = re.sub('\(.*', '', TileOutputs[k])
                        print('\t.'+PortName+'('+TileOutputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),',file=file)
                        # print('DEBUG_OUTPUT: '+PortName+'\t=> '+TileOutputSignal[k]+',')

                # Check if this tile uses IO-pins that have to be connected to the top-level module
                CurrentTileExternalPorts = GetComponentPortsFromFile(super_tile_description[y][x]+'_tile.vhdl', port='external')
                if CurrentTileExternalPorts != []:
                    print('\t//tile IO port which gets directly connected to top-level tile module', file=file)
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        # ExternalPorts was populated when writing the super_tile_description top level module
                        print('\t.'+PortName+'('+ExternalPorts[ExternalPorts_counter].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),', file=file)
                        ExternalPorts_counter += 1

                if ConfigBitMode == 'FlipFlopChain':
                    GenerateVHDL_Conf_Instantiation(file=file, counter=tile_counter, close=True)
                if ConfigBitMode == 'frame_based':
                    if (super_tile_description[y][x]) != 'NULL':
                        TileConfigBits = GetNoConfigBitsFromFile(str(super_tile_description[y][x])+'_tile.vhdl')
                        if TileConfigBits != 'NULL':
                            if int(TileConfigBits) == 0:
                            # print('\t\t ConfigBits => (others => \'-\') );\n', file=file)
                                # last_pos = file.tell()
                                # for k in range(20):
                                   # file.seek(last_pos -k)                # scan character by character backwards and look for ','
                                   # my_char = file.read(1)
                                   # if my_char == ',':
                                       # file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
                                       # print(' ', end='', file=file)
                                       # break                            # stop scan
                                # file.seek(0, os.SEEK_END)          # go back to usual...

                                # print('\t);\n', file=file)

                                if bot_edge:
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)' , file=file)
                                else:
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)' , file=file)
                                print('\t);\n', file=file)
                            else:
                                if left_edge:
                                    print('\t.FrameData(Tile_X'+str(x)+'Y'+str(y)+'_FrameData), ' , file=file)
                                    print('\t.FrameData_O(Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                else:
                                    print('\t.FrameData(Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData), ' , file=file)
                                    print('\t.FrameData_O(Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                if bot_edge:
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)' , file=file)
                                else:
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)' , file=file)
                                print('\t);\n', file=file)
                                #print('\t\t ConfigBits => ConfigBits ( '+str(TileConfigBits)+' -1 downto '+str(0)+' ) );\n', file=file)
                                ### BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
                tile_counter += 1
    print('\n'+'endmodule', file=file)

def GenerateFabricVerilog( FabricFile, file, module = 'eFPGA' ):
# There are of course many possibilities for generating the fabric.
# I decided to generate a flat description as it may allow for a little easier debugging.
# For larger fabrics, this may be an issue, but not for now.
# We only have wires between two adjacent tiles in North, East, South, West direction.
# So we use the output ports to generate wires.
    fabric = GetFabric(FabricFile)
    y_tiles=len(fabric)      # get the number of tiles in vertical direction
    x_tiles=len(fabric[0])   # get the number of tiles in horizontal direction
    TileTypes = GetCellTypes(fabric)
    
    y_tiles=len(fabric)      # get the number of tiles in vertical direction
    x_tiles=len(fabric[0])   # get the number of tiles in horizontal direction
    TileTypes = GetCellTypes(fabric)
    
    SuperTileDict = {}
    SuperTileDict_temp = GetSuperTileFromFile(FabricFile)
    for SuperTile in SuperTileDict_temp:
        i = 0
        if any(item in SuperTileDict_temp[SuperTile][0] for item in TileTypes):
            SuperTileDict[SuperTile] = {}
            SuperTileDict[SuperTile]['tiles'] = SuperTileDict_temp[SuperTile]
            SuperTileDict[SuperTile]['head_tile'] = SuperTileDict_temp[SuperTile][0][0]
            SuperTileDict[SuperTile]['x_offset'] = 0
            while SuperTileDict_temp[SuperTile][0][i] == 'NULL':
                i += 1
                SuperTileDict[SuperTile]['head_tile'] = SuperTileDict_temp[SuperTile][0][i]
                SuperTileDict[SuperTile]['x_offset'] = i
    
    print('### Found the following tile types:\n',TileTypes)

    # VHDL header
    # module hard-coded TODO
    module_header_ports_list = []
    module_header_files = []
    TileTypeOutputPorts = []
    for tile in TileTypes:
        #PrintComponentDeclarationForFile(str(tile)+'_tile.vhdl', file)
        module_header_files.append(str(tile)+'_tile.v')
        # we need the BEL ports (a little later)
        Inputs, Outputs = GetComponentPortsFromFile(str(tile)+'_tile.vhdl')
        TileTypeOutputPorts.append(Outputs)

    # we first scan all tiles if those have IOs that have to go to top
    # the order of this scan is later maintained when instantiating the actual tiles
    print('\t//External IO ports exported directly from the corresponding tiles', file=file)
    ExternalPorts = []
    SharedExternalPorts = []
    port_list = []
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                # get the top dimension index that describes the tile type (given by fabric[y][x])
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                CurrentTileExternalPorts = GetComponentPortsFromFile(fabric[y][x]+'_tile.vhdl', port='external')
                if CurrentTileExternalPorts != []:
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        PortDefinition = PortDefinition.replace('-- ','//').replace('STD_LOGIC;','').replace('\t','')
                        if re.search('SHARED_PORT', item):
                            # for the module, we define only the very first for all SHARED_PORTs of any name category
                            if PortName not in SharedExternalPorts:
                                module_header_ports_list.append(PortName)
                                if 'in' in PortDefinition:
                                    PortDefinition = PortDefinition.replace('in','')
                                    port_list.append('\tinput '+PortName+';'+PortDefinition)
                                elif 'out' in PortDefinition:
                                    PortDefinition = PortDefinition.replace('out','')
                                    port_list.append('\toutput '+PortName+';'+PortDefinition)
                                SharedExternalPorts.append(PortName)
                            # we remember the used port name for the component instantiations to come
                            # for the instantiations, we have to keep track about all external ports
                            ExternalPorts.append(PortName)
                        else:
                            module_header_ports_list.append('Tile_X'+str(x)+'Y'+str(y)+'_'+PortName)
                            
                            if 'in' in PortDefinition:
                                PortDefinition = PortDefinition.replace('in','')
                                port_list.append('\tinput '+'Tile_X'+str(x)+'Y'+str(y)+'_'+PortName+';'+PortDefinition)
                            elif 'out' in PortDefinition:
                                PortDefinition = PortDefinition.replace('out','')
                                port_list.append('\toutput '+'Tile_X'+str(x)+'Y'+str(y)+'_'+PortName+';'+PortDefinition)
                            # we remember the used port name for the component instantiations to come
                            # we are maintaining the here used Tile_XxYy prefix as a sanity check
                            # ExternalPorts = ExternalPorts + 'Tile_X'+str(x)+'Y'+str(y)+'_'+str(PortName)
                            ExternalPorts.append('Tile_X'+str(x)+'Y'+str(y)+'_'+PortName)
    
    module_header_ports = ', '.join(module_header_ports_list)
    if ConfigBitMode == 'frame_based':
        module_header_ports += ', FrameData, FrameStrobe'
        GenerateVerilog_Header(module_header_ports, file, module,  MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow),module_header_files = module_header_files)
        for line_print in port_list:
            print(line_print, file=file)
        print('\tinput [(FrameBitsPerRow*'+str(y_tiles)+')-1:0] FrameData;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register', file=file)
        print('\tinput [(MaxFramesPerCol*'+str(x_tiles)+')-1:0] FrameStrobe;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register ', file=file)
        GenerateVerilog_PortsFooter(file, module, ConfigPort=False)
    else:
        GenerateVerilog_Header(module_header_ports, file, module,  MaxFramesPerCol=str(MaxFramesPerCol), FrameBitsPerRow=str(FrameBitsPerRow),module_header_files = module_header_files)
        for line_print in port_list:
            print(line_print, file=file)
        GenerateVerilog_PortsFooter(file, module)

    # VHDL signal declarations
    print('//signal declarations', file=file)

    for y in range(y_tiles):
        for x in range(x_tiles):
            print('\twire Tile_X'+str(x)+'Y'+str(y)+'_UserCLKo;', file=file)

    print('//configuration signal declarations\n', file=file)

    tile_counter_FFC = 0
    if ConfigBitMode == 'FlipFlopChain':
        for y in range(y_tiles):
            for x in range(x_tiles):
                # for the moment, we assume that all non "NULL" tiles are reconfigurable
                # (i.e. are connected to the configuration shift register)
                if (fabric[y][x]) != 'NULL':
                    tile_counter_FFC += 1
        print('\twire ['+str(tile_counter_FFC)+':0] conf_data;', file=file)

    if ConfigBitMode == 'frame_based':
#        for y in range(y_tiles):
#            for x in range(x_tiles):
#                if (fabric[y][x]) != 'NULL':
#                    TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
#                    if TileConfigBits != 'NULL' and int(TileConfigBits) != 0:
#                        print('signal Tile_X'+str(x)+'Y'+str(y)+'_ConfigBits \t:\t std_logic_vector('+TileConfigBits+' -1 downto '+str(0)+' );', file=file)

        # FrameData       =>     Tile_Y3_FrameData,
        # FrameStrobe      =>     Tile_X1_FrameStrobe
         # MaxFramesPerCol : integer := 20;
         # FrameBitsPerRow : integer := 32;
        for y in range(1,y_tiles-1):
            print('\twire [FrameBitsPerRow-1:0] Tile_Y'+str(y)+'_FrameData;', file=file)
        for x in range(x_tiles):
            print('\twire [MaxFramesPerCol-1:0] Tile_X'+str(x)+'_FrameStrobe;', file=file)
            
        for y in range(1,y_tiles-1):
            for x in range(x_tiles):
                print('\twire [FrameBitsPerRow-1:0] Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O;', file=file)
        for y in range(y_tiles):
            for x in range(x_tiles):
                print('\twire [MaxFramesPerCol-1:0] Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O;', file=file)

    print('\n//tile-to-tile signal declarations\n', file=file)
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                # get the top dimension index that describes the tile type (given by fabric[y][x])
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                # for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
                    # line contains something like "E2BEG : std_logic_vector( 7 downto 0 )" so I use split on '('
                    SignalName, Vector = re.split('\(',line)
                    # print('DEBUG line: ', line, file=file)
                    # print('DEBUG SignalName: ', SignalName, file=file)
                    # print('DEBUG Vector: ', Vector, file=file)
                    # Vector = re.sub('//.*', '', Vector)

                    print('\twire ['+Vector.replace(' downto ',':').replace(' )',']').replace(' ','').replace('\t','')+' Tile_X'+str(x)+'Y'+str(y)+'_'+SignalName+';', file=file)

    # top configuration data daisy chaining
    # this is copy and paste from tile code generation (so we can modify this here without side effects
    if ConfigBitMode == 'FlipFlopChain':
        print('// top configuration data daisy chaining', file=file)
        print('\tassign conf_data[0] = CONFin; // conf_data\'low=0 and CONFin is from tile module', file=file)
        print('CONFout = conf_data['+str(tile_counter_FFC)+']; // CONFout is from tile module', file=file)
    elif ConfigBitMode == 'frame_based':
        print('', file=file)
        for y in range(1,y_tiles-1):
            print('\tassign Tile_Y'+str(y)+'_FrameData = FrameData[(FrameBitsPerRow*('+str(y)+'+1))-1:FrameBitsPerRow*'+str(y)+'];', file=file)
        for x in range(x_tiles):
            print('\tassign Tile_X'+str(x)+'_FrameStrobe = FrameStrobe[(MaxFramesPerCol*('+str(x)+'+1))-1:MaxFramesPerCol*'+str(x)+'];', file=file)

    # VHDL tile instantiations
    tile_counter = 0
    ExternalPorts_counter = 0
    used_tile = []
    supertile_files = []
    print('\n//tile instantiations\n', file=file)
    for y in range(y_tiles):
        for x in range(x_tiles):
            if (fabric[y][x]) != 'NULL':
                if SuperTileEnable:
                    for superTile_type in SuperTileDict:
                        head_file = ''
                        y_supertiles=len(SuperTileDict[superTile_type]['tiles'])      # get the number of supertiles in vertical direction
                        x_supertiles=len(SuperTileDict[superTile_type]['tiles'][0])                   # get the number of supertiles in horizontal direction
                        tile_x = 0
                        tile_y = 0
                        if fabric[y][x] == SuperTileDict[superTile_type]['head_tile']:
                            tile_x = SuperTileDict[superTile_type]['x_offset']
                            head_file = 'Tile_X'+str(x)+'Y'+str(y)+'_'+superTile_type+'.temp'
                            with open(head_file, "w") as f:
                                f.write('\t'+superTile_type+' Tile_X'+str(x)+'Y'+str(y)+'_'+superTile_type+' (\n')
                            used_tile.append('Tile_X'+str(x)+'Y'+str(y)+'_'+fabric[y][x])
                            supertile_files.append(head_file)
                        else:
                            for yy in range(y_supertiles):
                                for xx in range(x_supertiles):
                                    if SuperTileDict[superTile_type]['tiles'][yy][xx] == fabric[y][x]:
                                        tile_x = xx
                                        tile_y = yy
                                        head_file = 'Tile_X'+str(x-xx+SuperTileDict[superTile_type]['x_offset'])+'Y'+str(y-yy)+'_'+superTile_type+'.temp'
                                        used_tile.append('Tile_X'+str(x)+'Y'+str(y)+'_'+fabric[y][x])
                        if 'Tile_X'+str(x)+'Y'+str(y)+'_'+fabric[y][x] not in used_tile:
                            continue
                        
                        left_edge = False
                        right_edge = False
                        top_edge = False
                        bot_edge = False
                        if tile_x == 0:
                            left_edge = True
                        else:
                            if SuperTileDict[superTile_type]['tiles'][tile_y][tile_x-1] == 'NULL':
                                left_edge = True
                        if tile_x == x_supertiles-1:
                            right_edge = True
                        else:
                            if SuperTileDict[superTile_type]['tiles'][tile_y][tile_x+1] == 'NULL':
                                right_edge = True
                        if tile_y == 0:
                            top_edge = True
                        else:
                            if SuperTileDict[superTile_type]['tiles'][tile_y-1][tile_x] == 'NULL':
                                top_edge = True
                        if tile_y == y_supertiles-1:
                            bot_edge = True
                        else:
                            if SuperTileDict[superTile_type]['tiles'][tile_y+1][tile_x] == 'NULL':
                                bot_edge = True
                        
                        port_prefix = 'Tile_X'+str(tile_x)+'Y'+str(tile_y)+'_'
                        TileInput_ports = []
                        TileOutput_ports = []
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                        # print('DEBUG TileInputs: ', TileInputs)
                        # print('DEBUG TileOutputs: ', TileOutputs)
                        TilePorts = []
                        TilePortsDebug = []
                        # for connecting the instance, we write the tile ports in the order all inputs and all outputs
                        for port in TileInputs + TileOutputs:
                            # GetComponentPortsFromFile returns vector information that starts with "(..." and we throw that away
                            # However the vector information is still interesting for debug purpose
                            TilePorts.append(re.sub(' ','',(re.sub('\(.*', '', port, flags=re.IGNORECASE))))
                            TilePortsDebug.append(port)
                        
                        # now we get the connecting input signals in the order NORTH EAST SOUTH WEST (order is given in fabric.csv)
                        # from the adjacent tiles. For example, a NorthEnd-port is connected to a SouthBeg-port on tile y+1
                        # note that fabric[y][x] has its origin [0][0] in the top left corner
                        TileInputSignal = []
                        TileInputSignalCountPerDirection = []
                        # IMPORTANT: we have to go through the following in NORTH EAST SOUTH WEST order
                        # NORTH direction: get the NiBEG wires from tile y+1, because they drive NiEND
                        if y < (y_tiles-1) and bot_edge:
                            if (fabric[y+1][x]) != 'NULL':
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y+1][x])+'_tile.vhdl', filter='NORTH')
                                for port in TileOutputs:
                                    TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y+1)+'_'+port)
                                if TileOutputs == []:
                                    TileInputSignalCountPerDirection.append(0)
                                else:
                                    TileInputSignalCountPerDirection.append(len(TileOutputs))
                            else:
                                TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(0)
                        # EAST direction: get the EiBEG wires from tile x-1, because they drive EiEND
                        if x > 0 and left_edge:
                            if (fabric[y][x-1]) != 'NULL':
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x-1])+'_tile.vhdl', filter='EAST')
                                for port in TileOutputs:
                                    TileInputSignal.append('Tile_X'+str(x-1)+'Y'+str(y)+'_'+port)
                                if TileOutputs == []:
                                    TileInputSignalCountPerDirection.append(0)
                                else:
                                    TileInputSignalCountPerDirection.append(len(TileOutputs))
                            else:
                                TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(0)
                        # SOUTH direction: get the SiBEG wires from tile y-1, because they drive SiEND
                        if y > 0 and top_edge:
                            if (fabric[y-1][x]) != 'NULL':
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y-1][x])+'_tile.vhdl', filter='SOUTH')
                                for port in TileOutputs:
                                    TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y-1)+'_'+port)
                                if TileOutputs == []:
                                    TileInputSignalCountPerDirection.append(0)
                                else:
                                    TileInputSignalCountPerDirection.append(len(TileOutputs))
                            else:
                                TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(0)
                        # WEST direction: get the WiBEG wires from tile x+1, because they drive WiEND
                        if x < (x_tiles-1) and right_edge:
                            if (fabric[y][x+1]) != 'NULL':
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x+1])+'_tile.vhdl', filter='WEST')
                                for port in TileOutputs:
                                    TileInputSignal.append('Tile_X'+str(x+1)+'Y'+str(y)+'_'+port)
                                if TileOutputs == []:
                                    TileInputSignalCountPerDirection.append(0)
                                else:
                                    TileInputSignalCountPerDirection.append(len(TileOutputs))
                            else:
                                TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(0)
                        # at this point, TileInputSignal is carrying all the driver signals from the surrounding tiles (the BEG signals of those tiles)
                        # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y3_N1BEG( 3 downto 0 )"
                        # for element in TileInputSignal:
                            # print('DEBUG TileInputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)
                        
                        # the output signals are named after the output ports
                        TileOutputSignal = []
                        TileInputsCountPerDirection = []
                        # as for the VHDL signal generation, we simply add a prefix like "Tile_X1Y0_" to the begin port
                        # for port in TileOutputs:
                            # TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                        if (fabric[y][x]) != 'NULL':
                            if bot_edge:
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='SOUTH')
                                TileOutput_ports.extend(TileOutputs)
                                for port in TileOutputs:
                                    TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='NORTH')
                                TileInputsCountPerDirection.append(len(TileInputs))
                                TileInput_ports.extend(TileInputs)
                            else:
                                TileInputsCountPerDirection.append(0)
                            if left_edge:
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='WEST')
                                TileOutput_ports.extend(TileOutputs)
                                for port in TileOutputs:
                                    TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='EAST')
                                TileInputsCountPerDirection.append(len(TileInputs))
                                TileInput_ports.extend(TileInputs)
                            else:
                                TileInputsCountPerDirection.append(0)
                            if top_edge:
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='NORTH')
                                TileOutput_ports.extend(TileOutputs)
                                for port in TileOutputs:
                                    TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='SOUTH')
                                TileInputsCountPerDirection.append(len(TileInputs))
                                TileInput_ports.extend(TileInputs)
                            else:
                                TileInputsCountPerDirection.append(0)
                            if right_edge:
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='EAST')
                                TileOutput_ports.extend(TileOutputs)
                                for port in TileOutputs:
                                    TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='WEST')
                                TileInputsCountPerDirection.append(len(TileInputs))
                                TileInput_ports.extend(TileInputs)
                            else:
                                TileInputsCountPerDirection.append(0)
                        # at this point, TileOutputSignal is carrying all the signal names that will be driven by the present tile
                        # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y2_W1BEG( 3 downto 0 )"
                        # for element in TileOutputSignal:
                            # print('DEBUG TileOutputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)
                        
                        #if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                            #TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                        # example: W6END( 11 downto 0 ), N1BEG( 3 downto 0 ), ...
                        # meaning: the END-ports are the tile inputs followed by the actual tile output ports (typically BEG)
                        # this is essentially the left side (the component ports) of the component instantiation
                        
                        CheckFailed = False
                        # sanity check: The number of input ports has to match the TileInputSignal per direction (N,E,S,W)
                        if (fabric[y][x]) != 'NULL':
                            for k in range(0,4):
                                if TileInputsCountPerDirection[k] != TileInputSignalCountPerDirection[k]:
                                    print(TileInputsCountPerDirection[k],TileInputSignalCountPerDirection[k])
                                    print('ERROR: component input missmatch in '+str(All_Directions[k])+' direction for Tile_X'+str(x)+'Y'+str(y)+' of type '+str(fabric[y][x]))
                                    CheckFailed = True
                            if CheckFailed == True:
                                print('Error in function GenerateFabricVHDL')
                                print('DEBUG:TileInputs: ',TileInput_ports)
                                print('DEBUG:TileInputSignal: ',TileInputSignal)
                                print('DEBUG:TileOutputs: ',TileOutput_ports)
                                print('DEBUG:TileOutputSignal: ',TileOutputSignal)
                                # raise ValueError('Error in function GenerateFabricVHDL')
                        # the output ports are derived from the same list and should therefore match automatically
                        
                        # for element in (TileInputs+TileOutputs):
                            # print('DEBUG TileInputs+TileOutputs :'+'Tile_X'+str(x)+'Y'+str(y)+'element:', element)
                        #print(head_file)
                        with open(head_file, "a+") as f:
                            if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                                for k in range(0,len(TileInput_ports)):
                                    PortName = re.sub('\(.*', '', TileInput_ports[k])
                                    f.write('\t.'+port_prefix+PortName+'('+TileInputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),\n')
                                    # print('DEBUG_INPUT: '+PortName+'\t=> '+TileInputSignal[k]+',')
                                for k in range(0,len(TileOutput_ports)):
                                    PortName = re.sub('\(.*', '', TileOutput_ports[k])
                                    f.write('\t.'+port_prefix+PortName+'('+TileOutputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),\n')
                                    # print('DEBUG_OUTPUT: '+PortName+'\t=> '+TileOutputSignal[k]+',')
                            
                            # Check if this tile uses IO-pins that have to be connected to the top-level module
                            CurrentTileExternalPorts = GetComponentPortsFromFile(fabric[y][x]+'_tile.vhdl', port='external')
                            if CurrentTileExternalPorts != []:
                                f.write('\t//tile IO port which gets directly connected to top-level tile module\n')
                                for item in CurrentTileExternalPorts:
                                    # we need the PortName and the PortDefinition (everything after the ':' separately
                                    PortName = re.sub('\:.*', '', item)
                                    substitutions = {" ": "", "\t": ""}
                                    PortName=(replace(PortName, substitutions))
                                    PortDefinition = re.sub('^.*\:', '', item)
                                    # ExternalPorts was populated when writing the fabric top level module
                                    f.write('\t.'+PortName+'('+ExternalPorts[ExternalPorts_counter].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),\n')
                                    ExternalPorts_counter += 1
                            
                            if ConfigBitMode == 'FlipFlopChain':
                                GenerateVHDL_Conf_Instantiation(file=f, counter=tile_counter, close=True)
                            if ConfigBitMode == 'frame_based':
                                if (fabric[y][x]) != 'NULL':
                                    TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
                                    if TileConfigBits != 'NULL':
                                        if int(TileConfigBits) == 0:
                                            #f.write('`ifndef EMULATION_MODE\n')
                                            if y == y_tiles-1:
                                                if bot_edge:
                                                    f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),\n' )
                                                if top_edge:
                                                    f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                            else:
                                                if fabric[y+1][x] == 'NULL':
                                                    if bot_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),\n' )
                                                    if top_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                                else:
                                                    if bot_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),\n' )
                                                    if top_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                            #f.write('`endif\n')
                                        else:
                                            #f.write('`ifdef EMULATION_MODE\n')
                                            #f.write('\t.'+port_prefix+'Emulate_Bitstream('+'`Tile_X'+str(x)+'Y'+str(y)+'_Emulate_Bitstream)\n')
                                            #f.write('`else\n')
                                            if x == 0: #left_edge
                                                if left_edge:
                                                    f.write('\t.'+port_prefix+'FrameData('+'Tile_Y'+str(y)+'_FrameData),\n' )
                                                if right_edge:
                                                    f.write('\t.'+port_prefix+'FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O),\n' )
                                            else:
                                                if fabric[y][x-1] == 'NULL':
                                                    if left_edge:
                                                        f.write('\t.'+port_prefix+'FrameData('+'Tile_Y'+str(y)+'_FrameData),\n' )
                                                    if right_edge:
                                                        f.write('\t.'+port_prefix+'FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O),\n' )
                                                else:
                                                    if left_edge:
                                                        f.write('\t.'+port_prefix+'FrameData('+'Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O),\n' )
                                                    if right_edge:
                                                        f.write('\t.'+port_prefix+'FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O),\n' )
                                            if y == y_tiles-1:
                                                if bot_edge:
                                                    f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),\n' )
                                                if top_edge:
                                                    f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                            else:
                                                if fabric[y+1][x] == 'NULL':
                                                    if bot_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),\n' )
                                                    if top_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                                else:
                                                    if bot_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),\n' )
                                                    if top_edge:
                                                        f.write('\t.'+port_prefix+'FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O),\n' )
                                            #f.write('`endif\n')
                            
                if 'Tile_X'+str(x)+'Y'+str(y)+'_'+fabric[y][x] in used_tile:
                    continue
                
                EntityName = GetComponentEntityNameFromFile(str(fabric[y][x])+'_tile.vhdl')
                print('\t'+EntityName+' Tile_X'+str(x)+'Y'+str(y)+'_'+EntityName+' (', file=file)
                TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                # print('DEBUG TileInputs: ', TileInputs)
                # print('DEBUG TileOutputs: ', TileOutputs)
                TilePorts = []
                TilePortsDebug = []
                # for connecting the instance, we write the tile ports in the order all inputs and all outputs
                for port in TileInputs + TileOutputs:
                    # GetComponentPortsFromFile returns vector information that starts with "(..." and we throw that away
                    # However the vector information is still interesting for debug purpose
                    TilePorts.append(re.sub(' ','',(re.sub('\(.*', '', port, flags=re.IGNORECASE))))
                    TilePortsDebug.append(port)

                # now we get the connecting input signals in the order NORTH EAST SOUTH WEST (order is given in fabric.csv)
                # from the adjacent tiles. For example, a NorthEnd-port is connected to a SouthBeg-port on tile Y+1
                # note that fabric[y][x] has its origin [0][0] in the top left corner
                TileInputSignal = []
                TileInputSignalCountPerDirection = []
                # IMPORTANT: we have to go through the following in NORTH EAST SOUTH WEST order
                # NORTH direction: get the NiBEG wires from tile y+1, because they drive NiEND
                if y < (y_tiles-1):
                    if (fabric[y+1][x]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y+1][x])+'_tile.vhdl', filter='NORTH')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y+1)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # EAST direction: get the EiBEG wires from tile x-1, because they drive EiEND
                if x > 0:
                    if (fabric[y][x-1]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x-1])+'_tile.vhdl', filter='EAST')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x-1)+'Y'+str(y)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # SOUTH direction: get the SiBEG wires from tile y-1, because they drive SiEND
                if y > 0:
                    if (fabric[y-1][x]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y-1][x])+'_tile.vhdl', filter='SOUTH')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y-1)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # WEST direction: get the WiBEG wires from tile x+1, because they drive WiEND
                if x < (x_tiles-1):
                    if (fabric[y][x+1]) != 'NULL':
                        TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x+1])+'_tile.vhdl', filter='WEST')
                        for port in TileOutputs:
                            TileInputSignal.append('Tile_X'+str(x+1)+'Y'+str(y)+'_'+port)
                        if TileOutputs == []:
                            TileInputSignalCountPerDirection.append(0)
                        else:
                            TileInputSignalCountPerDirection.append(len(TileOutputs))
                    else:
                        TileInputSignalCountPerDirection.append(0)
                else:
                    TileInputSignalCountPerDirection.append(0)
                # at this point, TileInputSignal is carrying all the driver signals from the surrounding tiles (the BEG signals of those tiles)
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y3_N1BEG( 3 downto 0 )"
                # for element in TileInputSignal:
                    # print('DEBUG TileInputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                # the output signals are named after the output ports
                TileOutputSignal = []
                TileInputsCountPerDirection = []
                # as for the VHDL signal generation, we simply add a prefix like "Tile_X1Y0_" to the begin port
                # for port in TileOutputs:
                    # TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                if (fabric[y][x]) != 'NULL':
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='NORTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='EAST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='SOUTH')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl', filter='WEST')
                    for port in TileOutputs:
                        TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
                    TileInputsCountPerDirection.append(len(TileInputs))
                # at this point, TileOutputSignal is carrying all the signal names that will be driven by the present tile
                # for example when we are on Tile_X2Y2, the first entry could be "Tile_X2Y2_W1BEG( 3 downto 0 )"
                # for element in TileOutputSignal:
                    # print('DEBUG TileOutputSignal :'+'Tile_X'+str(x)+'Y'+str(y), element)

                if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                    TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
                # example: W6END( 11 downto 0 ), N1BEG( 3 downto 0 ), ...
                # meaning: the END-ports are the tile inputs followed by the actual tile output ports (typically BEG)
                # this is essentially the left side (the component ports) of the component instantiation

                CheckFailed = False
                # sanity check: The number of input ports has to match the TileInputSignal per direction (N,E,S,W)
                if (fabric[y][x]) != 'NULL':
                    for k in range(0,4):

                        if TileInputsCountPerDirection[k] != TileInputSignalCountPerDirection[k]:
                            print('ERROR: component input missmatch in '+str(All_Directions[k])+' direction for Tile_X'+str(x)+'Y'+str(y)+' of type '+str(fabric[y][x]))
                            CheckFailed = True
                    if CheckFailed == True:
                        print('Error in function GenerateFabricVHDL')
                        print('DEBUG:TileInputs: ',TileInputs)
                        print('DEBUG:TileInputSignal: ',TileInputSignal)
                        print('DEBUG:TileOutputs: ',TileOutputs)
                        print('DEBUG:TileOutputSignal: ',TileOutputSignal)
                        # raise ValueError('Error in function GenerateFabricVHDL')
                # the output ports are derived from the same list and should therefore match automatically

                # for element in (TileInputs+TileOutputs):
                    # print('DEBUG TileInputs+TileOutputs :'+'Tile_X'+str(x)+'Y'+str(y)+'element:', element)

                if (fabric[y][x]) != 'NULL':    # looks like this conditional is redundant
                    for k in range(0,len(TileInputs)):
                        PortName = re.sub('\(.*', '', TileInputs[k])
                        print('\t.'+PortName+'('+TileInputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),',file=file)
                        # print('DEBUG_INPUT: '+PortName+'\t=> '+TileInputSignal[k]+',')
                    for k in range(0,len(TileOutputs)):
                        PortName = re.sub('\(.*', '', TileOutputs[k])
                        print('\t.'+PortName+'('+TileOutputSignal[k].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),',file=file)
                        # print('DEBUG_OUTPUT: '+PortName+'\t=> '+TileOutputSignal[k]+',')

                # Check if this tile uses IO-pins that have to be connected to the top-level module
                CurrentTileExternalPorts = GetComponentPortsFromFile(fabric[y][x]+'_tile.vhdl', port='external')
                CLOCK_Tile = False
                if CurrentTileExternalPorts != []:
                    print('\t//tile IO port which gets directly connected to top-level tile module', file=file)
                    for item in CurrentTileExternalPorts:
                        # we need the PortName and the PortDefinition (everything after the ':' separately
                        PortName = re.sub('\:.*', '', item)
                        substitutions = {" ": "", "\t": ""}
                        PortName=(replace(PortName, substitutions))
                        PortDefinition = re.sub('^.*\:', '', item)
                        # ExternalPorts was populated when writing the fabric top level module
                        if PortName == 'UserCLK' and y != y_tiles-1:
                            CLOCK_Tile = True
                            if fabric[y+1][x] != 'NULL':
                                print('\t.'+PortName+'(Tile_X'+str(x)+'Y'+str(y+1)+'_UserCLKo),', file=file)
                            else:
                                print('\t.'+PortName+'(UserCLK),', file=file)
                        else:
                            print('\t.'+PortName+'('+ExternalPorts[ExternalPorts_counter].replace('(','[').replace(')',']').replace(' downto ',':').replace(' ','').replace('\t','')+'),', file=file)
                        ExternalPorts_counter += 1
                if CLOCK_Tile:
                    print('\t.UserCLKo(Tile_X'+str(x)+'Y'+str(y)+'_UserCLKo),' , file=file)
                else:
                    if y != y_tiles-1:
                        if fabric[y+1][x] != 'NULL':
                            print('\t.UserCLK(Tile_X'+str(x)+'Y'+str(y+1)+'_UserCLKo),', file=file)
                            print('\t.UserCLKo(Tile_X'+str(x)+'Y'+str(y)+'_UserCLKo),' , file=file)
                        else:
                            print('\t.UserCLK(UserCLK),', file=file)
                            print('\t.UserCLKo(Tile_X'+str(x)+'Y'+str(y)+'_UserCLKo),' , file=file)
                    else:
                        print('\t.UserCLK(UserCLK),', file=file)
                        print('\t.UserCLKo(Tile_X'+str(x)+'Y'+str(y)+'_UserCLKo),' , file=file)

                if ConfigBitMode == 'FlipFlopChain':
                    GenerateVHDL_Conf_Instantiation(file=file, counter=tile_counter, close=True)
                if ConfigBitMode == 'frame_based':
                    if (fabric[y][x]) != 'NULL':
                        TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
                        if TileConfigBits != 'NULL':
                            if int(TileConfigBits) == 0:

                            # print('\t\t ConfigBits => (others => \'-\') );\n', file=file)

                            # the next one is fixing the fact the the last port assignment in vhdl is not allowed to have a ','
                            # this is a bit ugly, but well, vhdl is ugly too...
                                # last_pos = file.tell()
                                # for k in range(20):
                                   # file.seek(last_pos -k)                # scan character by character backwards and look for ','
                                   # my_char = file.read(1)
                                   # if my_char == ',':
                                       # file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
                                       # print(' ', end='', file=file)
                                       # break                            # stop scan

                                # file.seek(0, os.SEEK_END)          # go back to usual...

                                # print('\t);\n', file=file)
                                if y == y_tiles-1:
                                    #print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                    #print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                elif y != y_tiles-1:
                                    if fabric[y+1][x] == 'NULL':
                                        #print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        #print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    else:
                                        #print('\t.FrameData('+'Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        #print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                            else:
                                if x == 0 and y == y_tiles-1: #left_bottom_corner
                                    print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                    print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                    print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                    print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                elif x == 0 and y != y_tiles-1: #left_edge
                                    if fabric[y+1][x] == 'NULL':
                                        print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    else:
                                        print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                elif x != 0 and y == y_tiles-1: #bottom_edge
                                    if fabric[y][x-1] == 'NULL':
                                        print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    else:
                                        print('\t.FrameData('+'Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                elif x != 0 and y != y_tiles-1:
                                    if fabric[y][x-1] == 'NULL' and fabric[y+1][x] == 'NULL': 
                                        print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    elif fabric[y][x-1] == 'NULL' and fabric[y+1][x] != 'NULL':
                                        print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    elif fabric[y][x-1] != 'NULL' and fabric[y+1][x] == 'NULL':
                                        print('\t.FrameData('+'Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                        print('\t.FrameStrobe('+'Tile_X'+str(x)+'_FrameStrobe),' , file=file)
                                        print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                    else:
                                        if int(GetNoConfigBitsFromFile(str(fabric[y][x-1])+'_tile.vhdl')) == 0:
                                            print('\t.FrameData('+'Tile_Y'+str(y)+'_FrameData), ' , file=file)
                                            print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                            print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                            print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                        else :
                                            print('\t.FrameData('+'Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                            print('\t.FrameData_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O), ' , file=file)
                                            print('\t.FrameStrobe('+'Tile_X'+str(x)+'Y'+str(y+1)+'_FrameStrobe_O),' , file=file)
                                            print('\t.FrameStrobe_O('+'Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n\t);\n' , file=file)
                                #print('\t\t ConfigBits => ConfigBits ( '+str(TileConfigBits)+' -1 downto '+str(0)+' ) );\n', file=file)
                                ### BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
                tile_counter += 1
    for supertile_file in supertile_files:
        lines_seen = set() # holds lines already seen
        with open(supertile_file, "r+") as f:
            d = f.readlines()
            f.seek(0)
            for i in d:
                if i not in lines_seen:
                    print(i, end='', file=file)
                    lines_seen.add(i)
            f.truncate()
        last_pos = file.tell()
        for k in range(20):
           file.seek(last_pos -k)                # scan character by character backwards and look for ','
           my_char = file.read(1)
           if my_char == ',':
               file.seek(last_pos -k)            # place seek pointer to last ',' position and overwrite with a space
               print(' ', end='', file=file)
               break                            # stop scan
        file.seek(0, os.SEEK_END)          # go back to usual...
        print('\t);\n', file=file)
        os.remove(supertile_file)
    print('\n'+'endmodule', file=file)
    return

def GenerateVerilog_Header(module_header_ports, file, module, package='' , NoConfigBits='0', MaxFramesPerCol='NULL', FrameBitsPerRow='NULL', module_header_files=[]):
    print('module '+module+' ('+module_header_ports +');', file=file)
    if MaxFramesPerCol != 'NULL':
        print('\tparameter MaxFramesPerCol = '+MaxFramesPerCol+';', file=file)
    if FrameBitsPerRow != 'NULL':
        print('\tparameter FrameBitsPerRow = '+FrameBitsPerRow+';', file=file)
    print('\tparameter NoConfigBits = '+NoConfigBits+';', file=file)
    return

def GenerateVerilog_PortsFooter ( file, module, ConfigPort=True , NumberOfConfigBits = ''):
    print('\t//global', file=file)
    if ConfigPort==False:
        print('', file=file)
    elif ConfigPort==True:
        if ConfigBitMode == 'FlipFlopChain':
            print('\tinput MODE;//global signal 1: configuration, 0: operation', file=file)
            print('\tinput CONFin;', file=file)
            print('\toutput CONFout;', file=file)
            print('\tinput CLK;', file=file)
        elif ConfigBitMode == 'frame_based':
            print('\tinput [NoConfigBits-1:0] ConfigBits;', file=file)
            print('\tinput [NoConfigBits-1:0] ConfigBits_N;', file=file)
    print('', file=file)
    return

def PrintTileComponentPort_Verilog (tile_description, port_direction, file, port_prefix='' ):
    if port_prefix:
        print('\t// '+port_prefix+'_'+port_direction, file=file)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    print('\toutput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+port_prefix+'_'+line[source_name]+';',end='', file=file)
                    print(' //wires:'+line[wires], end=' ', file=file)
                    print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                    print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    print('\tinput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+port_prefix+'_'+line[destination_name]+';', end='', file=file)
                    print(' //wires:'+line[wires], end=' ', file=file)
                    print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                    print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
    else:
        print('\t// ',port_direction, file=file)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    print('\toutput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+line[source_name]+';',end='', file=file)
                    print(' //wires:'+line[wires], end=' ', file=file)
                    print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                    print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    print('\tinput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+line[destination_name]+';', end='', file=file)
                    print(' //wires:'+line[wires], end=' ', file=file)
                    print('X_offset:'+line[X_offset], 'Y_offset:'+line[Y_offset], ' ', end='', file=file)
                    print('source_name:'+line[source_name], 'destination_name:'+line[destination_name], ' \n', end='', file=file)
    return

def GetTileComponentPort_Verilog_Str (tile_description, port_direction, port_prefix='' ):
    temp_list = []
    if port_prefix:
        temp_list.append('\t// '+port_prefix+'_'+port_direction)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp='\toutput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+port_prefix+'_'+line[source_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    str_temp='\tinput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+port_prefix+'_'+line[destination_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+ ' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
    else:
        temp_list.append('\t// '+port_direction)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp='\toutput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+line[source_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
        for line in tile_description:
            if line[0] == Opposite_Directions[port_direction]:
                if line[destination_name] != 'NULL':
                    str_temp='\tinput ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+line[destination_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
    return temp_list

def GetTileComponentWire_Verilog_Str (tile_description, port_direction, port_prefix='' ):
    temp_list = []
    if port_prefix:
        temp_list.append('\t// '+port_prefix+'_'+port_direction)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp='\twire ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+port_prefix+'_'+line[source_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
    else:
        temp_list.append('\t// '+port_direction)
        for line in tile_description:
            if line[0] == port_direction:
                if line[source_name] != 'NULL':
                    str_temp='\twire ['+str(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1)+':0] '+line[source_name]+';'
                    str_temp+=' //wires:'+line[wires]+' '
                    str_temp+='X_offset:'+line[X_offset]+' Y_offset:'+line[Y_offset]+' '
                    str_temp+='source_name:'+line[source_name]+' destination_name:'+line[destination_name]
                    temp_list.append(str_temp)
    return temp_list

def GetTileComponentPort_Verilog (tile_description, port_direction, port_prefix=''):
    ports = []
    for line in tile_description:
        if line[0] == port_direction:
            if line[source_name] != 'NULL':
                if port_prefix:
                    ports.append(port_prefix+'_'+line[source_name])
                else:
                    ports.append(line[source_name])
    for line in tile_description:
        if line[0] == Opposite_Directions[port_direction]:
            if line[destination_name] != 'NULL':
                if port_prefix:
                    ports.append(port_prefix+'_'+line[destination_name])
                else:
                    ports.append(line[destination_name])
    return ports

def GenerateVerilog_Conf_Instantiation ( file, counter, close=True ):
    print('\t//GLOBAL all primitive pins for configuration (not further parsed)', file=file)
    print('\t.MODE(Mode),', file=file)
    print('\t.CONFin(conf_data['+str(counter)+']),', file=file)
    print('\t.CONFout(conf_data['+str(counter+1)+']),', file=file)
    if close==True:
        print('\t.CLK(CLK)', file=file)
        print('\t);\n', file=file)
    else:
        print('\t.CLK(CLK),', file=file)
    return

def GetVerilogDeclarationForFile(VHDL_file_name):
    ConfigPortUsed = 0 # 1 means is used
    VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
    templist = []
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
    #print('', file=file)
    return ConfigPortUsed

#CAD methods from summer vacation project 2020 by Bea
sDelay = "8"
GNDRE = re.compile("GND(\d*)")
VCCRE = re.compile("VCC(\d*)")
BracketAddingRE = re.compile(r"^(\S+?)(\d+)$")
num_pbRE = re.compile("num_pb(\s*)=(\s*)\"(\s*)(\d*)(\s*)\"")
letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W"] #For LUT labelling

#This class represents individual tiles in the architecture
class Tile:
    tileType = ""
    bels = []
    belsWithIO = [] #Currently the plan is to deprecate bels and replace it with this. However, this would require nextpnr model generation changes, so I won't do that until the VPR foundations are established
    #Format for belsWithIO is [bel name, prefix, inputs, outputs, whether it has a clock input]
    #Format for bels is [bel name, prefix, ports, whether it has a clock input]
    wires = [] 
    atomicWires = [] #For storing single wires (to handle cascading and termination)
    pips = []
    belPorts = set()
    matrixFileName = ""
    pipMuxes_MapSourceToSinks= []
    pipMuxes_MapSinkToSources= []
    x = -1 #Init with negative values to ease debugging
    y = -1
    
    def __init__(self, inType):
        self.tileType = inType

    def genTileLoc(self, separate = False):
        if (separate):
            return("X" + str(self.x), "Y" + str(self.y))
        return "X" + str(self.x) + "Y" + str(self.y)

#This class represents the fabric as a whole
class Fabric:
    tiles = []
    height = 0
    width = 0
    cellTypes = []
    def __init__(self, inHeight, inWidth):
        self.width = inWidth
        self.height = inHeight
    def getTileByCoords(self, x: int, y: int):
        for row in self.tiles:
            for tile in row:
                if tile.x == x and tile.y == y:
                    return tile
        return None
    def getTileByLoc(self, loc: str):
        for row in self.tiles:
            for tile in row:
                if tile.genTileLoc() == loc:
                    return tile
        return None
    def getTileAndWireByWireDest(self, loc: str, dest: str, jumps: bool = True):
        for row in self.tiles:
            for tile in row:
                for wire in tile.wires:
                    if not jumps:
                        if wire["direction"] == "JUMP":
                            continue
                    for i in range(int(wire["wire-count"])):
                        desty = tile.y + int(wire["yoffset"])
                        destx = tile.x + int(wire["xoffset"])
                        desttileLoc = f"X{destx}Y{desty}"
                        if (desttileLoc == loc) and (wire["destination"] + str(i) == dest):
                            return (tile, wire, i)
        return None

#Method to add square brackets for wire pair generation (to account for different reference styles)
def addBrackets(portIn: str, tile: Tile):
    BracketMatch = BracketAddingRE.match(portIn)
    if BracketMatch and portIn not in tile.belPorts:
        return BracketMatch.group(1) + "[" + BracketMatch.group(2) + "]"
    else:
        return portIn

#This function gets a relevant instance of a tile for a given type - this just saves adding more object attributes
def getTileByType(fabricObject: Fabric, cellType: str):
    for line in fabricObject.tiles:
        for tile in line:
            if tile.tileType == cellType:
                return tile
    return None

#This function parses the contents of a CSV with comments removed to get where potential interconnects are
#The current implementation has two potential outputs: pips is a list of pairings (designed for single PIPs), whereas pipsdict maps each source to all possible sinks (designed with multiplexers in mind)
def findPipList(csvFile: list, returnDict: bool = False, mapSourceToSinks: bool = False):
    sinks = [line[0] for line in csvFile]
    sources = csvFile[0]
    pips = []
    pipsdict = {}
    for y, row in enumerate(csvFile[1::]):
        for x, value in enumerate(row[1::]):
            #Remember that x and y are offset 
            if value == "1":
                pips.append([sources[x+1], sinks[y+1]])
                if mapSourceToSinks:
                    if sources[x+1] in pipsdict.keys():
                        pipsdict[sources[x+1]].append(sinks[y+1])
                    else:
                        pipsdict[sources[x+1]]= [sinks[y+1]]                    
                else:
                    if sinks[y+1] in pipsdict.keys():
                        pipsdict[sinks[y+1]].append(sources[x+1])
                    else:
                        pipsdict[sinks[y+1]]= [sources[x+1]]
    if returnDict:
        return pipsdict
    return pips

#Method to remove a known prefix from a string if it is present at the start - this is provided as str.removeprefix in Python 3.9 but has been implemented for compatibility
def removeStringPrefix(mainStr: str, prefix: str): 
    if mainStr[0:len(prefix)] == prefix:
        return mainStr[len(prefix):]
    else:
        return mainStr

#Method to find all 'hanging' sources and sinks in a fabric (i.e. ports with connections to pips in only one direction e.g. VCC, GND)
#Returns dict mapping tileLoc to hanging pins
def getFabricSourcesAndSinks(archObject: Fabric): 
    allFabricInputs = [] #First, build a list of all fabric inputs/outputs (bel ports and wires) with the tile address
    allFabricOutputs = []
    returnDict = {}

    for row in archObject.tiles:
        for tile in row:
            tileLoc = tile.genTileLoc()

            for bel in tile.belsWithIO:
                allFabricInputs.extend([(tileLoc + "." + cInput) for cInput in bel[2]])
                allFabricOutputs.extend([(tileLoc + "." + cOutput) for cOutput in bel[3]])

            for wire in tile.wires:
                desty = tile.y + int(wire["yoffset"]) #Calculate destination location of the wire at hand
                destx = tile.x + int(wire["xoffset"])
                desttileLoc = f"X{destx}Y{desty}"

                for i in range(int(wire["wire-count"])): #For every individual wire
                    allFabricInputs.append(tileLoc + "." + wire["source"] + str(i))
                    allFabricOutputs.append(desttileLoc + "." + wire["destination"] + str(i))

            for wire in tile.atomicWires:
                allFabricInputs.append(wire["sourceTile"] + "." + wire["source"]) #Generate location strings for the source and destination
                allFabricOutputs.append(wire["destTile"] + "." + wire["destination"])



    #Now we go through all the pips, and if a source/sink doesn't appear in the list we keep it

    for row in archObject.tiles:
        for tile in row:
            tileLoc = tile.genTileLoc()
            sourceSet = set()
            sinkSet = set()
            for pip in tile.pips:
                if (tileLoc + "." + pip[0]) not in allFabricOutputs:
                    sourceSet.add(pip[0])
                if (tileLoc + "." + pip[1]) not in allFabricInputs:
                    sinkSet.add(pip[1])
            returnDict[tileLoc] = (sourceSet, sinkSet)

    return returnDict




def genFabricObject(fabric: list):
    #The following iterates through the tile designations on the fabric
    archFabric = Fabric(len(fabric), len(fabric[0]))
    portMap = {}
    wireMap = {}
    # for i, line in enumerate(fabric):
    #     for j, tile in enumerate(line):
    #         tileList = GetTileFromFile(FabricFile, tile)
    #         portList = []
    #         for wire in tileList:
    #             if wire[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
    #                 if wire[1] != "NULL":
    #                     portList.append(wire[1])
    #                 if wire[4] != "NULL":
    #                     portList.append(wire[4])
    #         portMap["I" + str(i) + "J" + str(j)] = portList

    for i, line in enumerate(fabric):
        row = []
        for j, tile in enumerate(line): 
            cTile = Tile(tile)
            wires = []
            belList = []
            belListWithIO = []
            tileList = GetTileFromFile(FabricFile, tile)
            portList = []
            wireTextList = []
            for wire in tileList:
                #Handle tile attributes depending on their label
                if wire[0] == "MATRIX":
                    vhdlLoc = wire[1]
                    csvLoc = vhdlLoc[:-4:] + "csv"
                    cTile.matrixFileName = csvLoc
                    try:
                        csvFile = RemoveComments([i.strip('\n').split(',') for i in open(csvLoc)])
                        cTile.pips = findPipList(csvFile) 

                        cTile.pipMuxes_MapSourceToSinks = findPipList(csvFile, returnDict = True, mapSourceToSinks = True)
                        cTile.pipMuxes_MapSinkToSources = findPipList(csvFile, returnDict = True, mapSourceToSinks = False)

                    except:
                        raise Exception("CSV File not found.")

                if wire[0] == "BEL":
                    belHasClockInput = False
                    try:
                        ports = GetComponentPortsFromFile(wire[1])

                        #We also want to check whether the component has a clock input
                        externalPorts = (GetComponentPortsFromFile(wire[1], port = "external")) #Get all external (routed to top) ports
                        for port in externalPorts: 
                            PortName = re.sub('\:.*', '', port) #Get port name
                            substitutions = {" ": "", "\t": ""} #Strip
                            PortName=(replace(PortName, substitutions))
                            if PortName == "UserCLK": #And if UserCLK is in there then we have a clock input
                                belHasClockInput = True


                    except:
                        raise Exception(f"{wire[1]} file for BEL not found")

                    if len(wire) > 2:
                        prefix = wire[2]
                    else:
                        prefix = ""
                    nports = []
                    inputPorts = []
                    outputPorts = []


                    for port in ports[0]:
                        nports.append(prefix + re.sub(" *\(.*\) *", "", str(port)))
                        inputPorts.append(prefix + re.sub(" *\(.*\) *", "", str(port))) #Also add to distinct input/output lists
                    for port in ports[1]:
                        nports.append(prefix + re.sub(" *\(.*\) *", "", str(port)))
                        outputPorts.append(prefix + re.sub(" *\(.*\) *", "", str(port)))
                    cTile.belPorts.update(nports)

                    belListWithIO.append([wire[1][0:-5:], prefix, inputPorts, outputPorts, belHasClockInput])
                    belList.append([wire[1][0:-5:], prefix, nports, belHasClockInput])

                elif wire[0] in ["NORTH", "SOUTH", "EAST", "WEST"]: 
                    #Wires are added in next pass - this pass generates port lists to be used for wire generation
                    if wire[1] != "NULL":
                        portList.append(wire[1])
                    if wire[4] != "NULL":
                        portList.append(wire[4])
                    wireTextList.append({"direction": wire[0], "source": wire[1], "xoffset": wire[2], "yoffset": wire[3], "destination": wire[4], "wire-count": wire[5]}) 
                elif wire[0] == "JUMP":    #We just treat JUMPs as normal wires - however they're only on one tile so we can add them directly
                    if "NULL" not in wire:
                        wires.append({"direction": wire[0], "source": wire[1], "xoffset": wire[2], "yoffset": wire[3], "destination": wire[4], "wire-count": wire[5]}) 
            cTile.wires = wires
            cTile.x = j
            #cTile.y = archFabric.height - i -1
            cTile.y = i

            cTile.bels = belList
            cTile.belsWithIO = belListWithIO
            row.append(cTile)
            portMap[cTile] = portList
            wireMap[cTile] = wireTextList
        archFabric.tiles.append(row)

        #Add wires to model

    for row in archFabric.tiles:
        for tile in row:
            wires = []
            wireTextList = wireMap[tile]
            tempAtomicWires = []
            #Wires from tile
            for wire in wireTextList:
                destinationTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y + int(wire["yoffset"]))
                if abs(int(wire["xoffset"]))<=1 and abs(int(wire["yoffset"]))<=1 and not ("NULL" in wire.values()):
                    wires.append(wire)                 
                    portMap[destinationTile].remove(wire["destination"])
                    portMap[tile].remove(wire["source"])
                elif not ("NULL" in wire.values()): #If the wire goes off the fabric then we account for cascading by finding the last tile the wire goes through
                    if int(wire["xoffset"]) != 0:    #If we're moving in the x axis
                        if int(wire["xoffset"]) > 1:
                            cTile = archFabric.getTileByCoords(tile.x + 1, tile.y + int(wire["yoffset"]))    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["xoffset"]))):
                                if i < int(wire["wire-count"]):
                                    cascaded_i = i + int(wire["wire-count"])*(abs(int(wire["xoffset"]))-1)
                                else:
                                    cascaded_i = i - int(wire["wire-count"])
                                    tempAtomicWires.append({"direction": "JUMP", "source": wire["destination"] + str(i), "xoffset": '0', "yoffset": '0', "destination": wire["source"] + str(i), "sourceTile": tile.genTileLoc(), "destTile": tile.genTileLoc()})
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": '1', "yoffset": wire["yoffset"], "destination": wire["destination"] + str(cascaded_i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(wire["destination"])
                            portMap[tile].remove(wire["source"])
                        elif int(wire["xoffset"]) < -1:
                            cTile = archFabric.getTileByCoords(tile.x - 1, tile.y + int(wire["yoffset"]))    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["xoffset"]))):
                                if i < int(wire["wire-count"]):
                                    cascaded_i = i + int(wire["wire-count"])*(abs(int(wire["xoffset"]))-1)
                                else:
                                    cascaded_i = i - int(wire["wire-count"])
                                    tempAtomicWires.append({"direction": "JUMP", "source": wire["destination"] + str(i), "xoffset": '0', "yoffset": '0', "destination": wire["source"] + str(i), "sourceTile": tile.genTileLoc(), "destTile": tile.genTileLoc()})
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": '-1', "yoffset": wire["yoffset"], "destination": wire["destination"] + str(cascaded_i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(wire["destination"])
                            portMap[tile].remove(wire["source"])
                    elif int(wire["yoffset"]) != 0:    #If we're moving in the y axis
                        if int(wire["yoffset"]) > 1:
                            cTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y + 1)    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["yoffset"]))):
                                if i < int(wire["wire-count"]):
                                    cascaded_i = i + int(wire["wire-count"])*(abs(int(wire["yoffset"]))-1)
                                else:
                                    cascaded_i = i - int(wire["wire-count"])
                                    tempAtomicWires.append({"direction": "JUMP", "source": wire["destination"] + str(i), "xoffset": '0', "yoffset": '0', "destination": wire["source"] + str(i), "sourceTile": tile.genTileLoc(), "destTile": tile.genTileLoc()})
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": wire["xoffset"], "yoffset": '1', "destination": wire["destination"] + str(cascaded_i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(wire["destination"])
                            portMap[tile].remove(wire["source"])
                        elif int(wire["yoffset"]) < -1:
                            cTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y - 1)    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["yoffset"]))):
                                if i < int(wire["wire-count"]):
                                    cascaded_i = i + int(wire["wire-count"])*(abs(int(wire["yoffset"]))-1)
                                else:
                                    cascaded_i = i - int(wire["wire-count"])
                                    tempAtomicWires.append({"direction": "JUMP", "source": wire["destination"] + str(i), "xoffset": '0', "yoffset": '0', "destination": wire["source"] + str(i), "sourceTile": tile.genTileLoc(), "destTile": tile.genTileLoc()})
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": wire["xoffset"], "yoffset": '-1', "destination": wire["destination"] + str(cascaded_i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(wire["destination"])
                            portMap[tile].remove(wire["source"])
                elif wire["source"] != "NULL" and wire["destination"] == "NULL":
                    source_wire_name = wire["source"]
                    if source_wire_name == 'Co':
                        dest_wire_name = 'Ci'
                    elif source_wire_name[1] == '2' and source_wire_name[-1] == 'b':
                        dest_wire_name = wire["source"].replace("BEGb","END")
                    elif source_wire_name[1] == '2' and source_wire_name[-1] != 'b':
                        dest_wire_name = wire["source"].replace("BEG","MID")
                    else:
                        dest_wire_name = wire["source"].replace("BEG","END")
                    if int(wire["xoffset"]) != 0:    #If we're moving in the x axis
                        if int(wire["xoffset"]) > 0:
                            cTile = archFabric.getTileByCoords(tile.x + 1, tile.y + int(wire["yoffset"]))    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["xoffset"]))):
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": '1', "yoffset": wire["yoffset"], "destination": dest_wire_name + str(i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(dest_wire_name)
                            portMap[tile].remove(wire["source"])
                        elif int(wire["xoffset"]) < 0:
                            cTile = archFabric.getTileByCoords(tile.x - 1, tile.y + int(wire["yoffset"]))    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["xoffset"]))):
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": '-1', "yoffset": wire["yoffset"], "destination": dest_wire_name + str(i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(dest_wire_name)
                            portMap[tile].remove(wire["source"])
                    elif int(wire["yoffset"]) != 0:    #If we're moving in the y axis
                        if int(wire["yoffset"]) > 0:
                            cTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y + 1)    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["yoffset"]))):
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": wire["xoffset"], "yoffset": '1', "destination": dest_wire_name + str(i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(dest_wire_name)
                            portMap[tile].remove(wire["source"])
                        elif int(wire["yoffset"]) < 0:
                            cTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y - 1)    #destination tile
                            for i in range(int(wire["wire-count"])*abs(int(wire["yoffset"]))):
                                tempAtomicWires.append({"direction": wire["direction"], "source": wire["source"] + str(i), "xoffset": wire["xoffset"], "yoffset": '-1', "destination": dest_wire_name + str(i), "sourceTile": tile.genTileLoc(), "destTile": cTile.genTileLoc()}) #Add atomic wire names
                            portMap[cTile].remove(dest_wire_name)
                            portMap[tile].remove(wire["source"])

            tile.wires.extend(wires)
            tile.atomicWires = tempAtomicWires

    archFabric.cellTypes = GetCellTypes(fabric)

    return archFabric

def genNextpnrModel(archObject: Fabric, generatePairs = True):
    pipsStr = "" 
    belsStr = f"# BEL descriptions: bottom left corner Tile_X0Y0, top right {archObject.tiles[0][archObject.width - 1].genTileLoc()}\n" 
    pairStr = ""
    templateStr = "module template ();\n"
    constraintStr = ""
    for line in archObject.tiles:
        for tile in line:
            #Add PIPs
            #Pips within the tile
            tileLoc = tile.genTileLoc() #Get the tile location string
            pipsStr += f"#Tile-internal pips on tile {tileLoc}:\n"
            for pip in tile.pips:
                pipsStr += ",".join((tileLoc, pip[0], tileLoc, pip[1],sDelay,".".join((pip[0], pip[1])))) #Add the pips (also delay should be done here later, sDelay is a filler)
                pipsStr += "\n"

            #Wires between tiles
            pipsStr += f"#Tile-external pips on tile {tileLoc}:\n"
            for wire in tile.wires:
                desty = tile.y + int(wire["yoffset"])
                destx = tile.x + int(wire["xoffset"])
                desttileLoc = f"X{destx}Y{desty}"
                for i in range(int(wire["wire-count"])):
                    pipsStr += ",".join((tileLoc, wire["source"]+str(i), desttileLoc, wire["destination"]+str(i), sDelay, ".".join((wire["source"]+str(i), wire["destination"]+str(i)))))
                    pipsStr += "\n"
            for wire in tile.atomicWires:    #Very simple - just add wires using values directly from the atomic wire structure
                desttileLoc = wire["destTile"]
                pipsStr += ",".join((tileLoc, wire["source"], desttileLoc, wire["destination"], sDelay, ".".join((wire["source"], wire["destination"]))))
                pipsStr += "\n"
            #Add BELs 
            belsStr += "#Tile_" + tileLoc + "\n" #Tile declaration as a comment
            for num, belpair in enumerate(tile.bels):
                bel = belpair[0]
                let = letters[num]
                # if bel == "LUT4c_frame_config":
                #     cType = "LUT4"
                #     prefix = "L" + let + "_"
                # elif bel == "IO_1_bidirectional_frame_config_pass":
                #     prefix = let + "_"
                # else:
                #     cType = bel
                #     prefix = ""
                prefix = belpair[1]
                nports = belpair[2]
                if bel == "LUT4c_frame_config":
                    cType = "FABULOUS_LC"         #"LUT4"
                #elif bel == "IO_1_bidirectional_frame_config_pass":
                #    cType = "IOBUF"
                else:
                    cType = bel
                belsStr += ",".join((tileLoc, ",".join(tile.genTileLoc(True)), let, cType, ",".join(nports))) + "\n"
                #Add template - this just adds to a file to instantiate all IO as a primitive:
                if bel == "IO_1_bidirectional_frame_config_pass":
                    templateStr += f"wire "
                    for i, port in enumerate(nports):
                        templateStr += f"Tile_{tileLoc}_{port}"
                        if i < len(nports) - 1:
                            templateStr += ", "
                        else:
                            templateStr += ";\n"
                    belName = f"Tile_{tileLoc}_{let}"
                    templateStr += f"(* keep *) IO_1_bidirectional_frame_config_pass {belName} (.O(Tile_{tileLoc}_{prefix}O), .Q(Tile_{tileLoc}_{prefix}Q), .I(Tile_{tileLoc}_{prefix}I));\n\n"
                    constraintStr += f"set_io {belName} {tileLoc}.{let}\n"
                if bel == "InPass4_frame_config":
                    templateStr += f"wire "
                    for i, port in enumerate(nports):
                        templateStr += f"Tile_{tileLoc}_{port}"
                        if i < len(nports) - 1:
                            templateStr += ", "
                        else:
                            templateStr += ";\n"
                    belName = f"Tile_{tileLoc}_{let}"
                    templateStr += f"(* keep *) InPass4_frame_config {belName} (.O0(Tile_{tileLoc}_{prefix}O0), .O1(Tile_{tileLoc}_{prefix}O1), .O2(Tile_{tileLoc}_{prefix}O2), .O3(Tile_{tileLoc}_{prefix}O3));\n\n"
                    constraintStr += f"set_io {belName} {tileLoc}.{let}\n"
                if bel == "OutPass4_frame_config":
                    templateStr += f"wire "
                    for i, port in enumerate(nports):
                        templateStr += f"Tile_{tileLoc}_{port}"
                        if i < len(nports) - 1:
                            templateStr += ", "
                        else:
                            templateStr += ";\n"
                    belName = f"Tile_{tileLoc}_{let}"
                    templateStr += f"(* keep *) OutPass4_frame_config {belName} (.I0(Tile_{tileLoc}_{prefix}I0), .I1(Tile_{tileLoc}_{prefix}I1), .I2(Tile_{tileLoc}_{prefix}I2), .I3(Tile_{tileLoc}_{prefix}I3));\n\n"
                    constraintStr += f"set_io {belName} {tileLoc}.{let}\n"                
            if generatePairs:
                #Generate wire beginning to wire beginning pairs for timing analysis
                print("Generating pairs for: " + tile.genTileLoc())
                pairStr += "#" + tileLoc + "\n"
                for wire in tile.wires:
                    for i in range(int(wire["wire-count"])):
                        desty = tile.y + int(wire["yoffset"])
                        destx = tile.x + int(wire["xoffset"]) 
                        destTile = archObject.getTileByCoords(destx, desty)
                        desttileLoc = f"X{destx}Y{desty}"
                        if (wire["destination"] + str(i)) not in destTile.pipMuxes_MapSourceToSinks.keys():
                            continue
                        for pipSink in destTile.pipMuxes_MapSourceToSinks[wire["destination"] + str(i)]:
                            #If there is a multiplexer here, then we can simply add this pair
                            if len(destTile.pipMuxes_MapSinkToSources[pipSink]) > 1:
                                pairStr += ",".join((".".join((tileLoc, wire["source"] + f"[{str(i)}]")), ".".join((desttileLoc, addBrackets(pipSink, tile))))) + "\n" #TODO: add square brackets to end
                            #otherwise, there is no physical pair in the ASIC netlist, so we must propagate back until we hit a multiplexer
                            else:
                                finalDestination = ".".join((desttileLoc, addBrackets(pipSink, tile)))
                                foundPhysicalPairs = False
                                curWireTuple = (tile, wire, i)
                                potentialStarts = []
                                stopOffs = []
                                while (not foundPhysicalPairs):
                                    cTile = curWireTuple[0]
                                    cWire = curWireTuple[1]
                                    cIndex = curWireTuple[2]
                                    if len(cTile.pipMuxes_MapSinkToSources[cWire["source"] + str(cIndex)]) > 1:
                                        for wireEnd in cTile.pipMuxes_MapSinkToSources[cWire["source"]  + str(cIndex)]:
                                            if wireEnd in cTile.belPorts:
                                                continue
                                            cPair = archObject.getTileAndWireByWireDest(cTile.genTileLoc(), wireEnd)
                                            if cPair == None:
                                                continue
                                            potentialStarts.append(cPair[0].genTileLoc() + "." + cPair[1]["source"] + "[" + str(cPair[2]) + "]")
                                        foundPhysicalPairs = True
                                    else:
                                        destPort = cTile.pipMuxes_MapSinkToSources[cWire["source"] + str(cIndex)][0]
                                        destLoc = cTile.genTileLoc()
                                        if destPort in cTile.belPorts:
                                            foundPhysicalPairs = True #This means it's connected to a BEL
                                            continue
                                        if GNDRE.match(destPort) or VCCRE.match(destPort):
                                            foundPhysicalPairs = True
                                            continue
                                        stopOffs.append(destLoc + "." + destPort)
                                        curWireTuple = archObject.getTileAndWireByWireDest(destLoc, destPort)
                                pairStr += "#Propagated route for " + finalDestination + "\n"
                                for index, start in enumerate(potentialStarts):
                                    pairStr += start + "," + finalDestination + "\n"
                                pairStr += "#Stopoffs: " + ",".join(stopOffs) + "\n"

                #Generate pairs for bels:
                pairStr += "#Atomic wire pairs\n"
                for wire in tile.atomicWires:
                    pairStr += wire["sourceTile"] + "." + addBrackets(wire["source"], tile) + "," + wire["destTile"] + "." + addBrackets(wire["destination"], tile) + "\n"
                for num, belpair in enumerate(tile.bels):
                    pairStr += "#Bel pairs" + "\n"
                    bel = belpair[0]
                    let = letters[num]
                    prefix = belpair[1]
                    nports = belpair[2]
                    if bel == "LUT4c_frame_config":
                        for i in range(4):
                            pairStr += tileLoc + "." + prefix + f"D[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                        for outPip in tile.pipMuxes_MapSourceToSinks[prefix + "O"]:
                            for i in range(4):
                                pairStr += tileLoc + "." + prefix + f"I[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + "." + prefix + f"Q[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                    elif bel == "MUX8LUT_frame_config":
                        for outPip in tile.pipMuxes_MapSourceToSinks["M_AB"]:
                                pairStr += tileLoc + ".A," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".B," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S0," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                        for outPip in tile.pipMuxes_MapSourceToSinks["M_AD"]:
                                pairStr += tileLoc + ".A," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".B," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".C," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".D," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S0," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S1," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                        for outPip in tile.pipMuxes_MapSourceToSinks["M_AH"]:
                                pairStr += tileLoc + ".A," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".B," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".C," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".D," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".E," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".F," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".G," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".H," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S0," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S1," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S2," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S3," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                        for outPip in tile.pipMuxes_MapSourceToSinks["M_EF"]:
                                pairStr += tileLoc + ".E," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".F," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S0," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                pairStr += tileLoc + ".S2," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                    elif bel == "MULADD":
                        for i in range(20):
                            for outPip in tile.pipMuxes_MapSourceToSinks[f"Q{i}"]:
                                for i in range(8):
                                    pairStr += tileLoc + f".A[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                for i in range(8):
                                    pairStr += tileLoc + f".B[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                for i in range(20):
                                    pairStr += tileLoc + f".C[{i}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                    elif bel == "RegFile_32x4":
                        for i in range(4):
                            for outPip in tile.pipMuxes_MapSourceToSinks[f"AD{i}"]:
                                    pairStr += tileLoc + ".W_en," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                    for j in range(4):
                                        pairStr += tileLoc + f".D[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                        pairStr += tileLoc + f".W_ADR[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                        pairStr += tileLoc + f".A_ADR[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                            for outPip in tile.pipMuxes_MapSourceToSinks[f"BD{i}"]:
                                    pairStr += tileLoc + ".W_en," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                    for j in range(4):
                                        pairStr += tileLoc + f".D[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                        pairStr += tileLoc + f".W_ADR[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                                        pairStr += tileLoc + f".B_ADR[{j}]," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                    elif bel == "IO_1_bidirectional_frame_config_pass":
                        #inPorts go into the fabric, outPorts go out
                        for inPort in ("O", "Q"):
                            for outPip in tile.pipMuxes_MapSourceToSinks[prefix + inPort]:
                                pairStr += tileLoc + "." + prefix + inPort + "," + tileLoc + "." + addBrackets(outPip, tile) + "\n"
                        #Outputs are covered by the wire code, as pips will link to them
                    elif bel == "InPass4_frame_config":
                        for i in range(4):
                            for outPip in tile.pipMuxes_MapSourceToSinks[prefix + "O" + str(i)]:
                                pairStr += tileLoc + "." + prefix + f"O{i}" + "," + tileLoc + "." + addBrackets(outPip, tile) + "\n"                        
                    elif bel == "OutPass4_frame_config":
                        for i in range(4):
                            for inPip in tile.pipMuxes_MapSinkToSources[prefix + "I" + str(i)]:
                                pairStr += tileLoc + "." + addBrackets(inPip, tile)  + "," + tileLoc + "." + prefix + f"I{i}" + "\n"                        
    templateStr += "endmodule"
    if generatePairs:
        return (pipsStr, belsStr, templateStr, constraintStr, pairStr)
    else:
        return (pipsStr, belsStr, templateStr, constraintStr)



#Clock coordinates - these are relative to the fabric.csv fabric, and ignore the padding
clockX = 0
clockY = 0

def genVPRModelXML(archObject: Fabric, customXmlFilename, generatePairs = True):

    ### STYLE NOTE: As this function uses f-strings so regularly, as a standard these f-strings should be denoted with single quotes ('...') instead of double quotes ("...")
    ### This is because the XML being generated uses double quotes to denote values, so every attribute set introduces a pair of quotes to escape
    ### This is doable but frustrating and leaves room for error, so as standard single quotes are recommended. 

    ### A variable name of the form fooString means that it is a string which will be substituted directly into the output string - otherwise fooStr is used 

    specialBelDict = {}
    specialModelDict = {} 
    specialInterconnectDict = {}

    #First, load in the custom XML file
    tree = ET.parse(customXmlFilename)

    #Get root XML tag
    root = tree.getroot()

    #Iterate over children
    for bel_info in root:
        #Check that the tag is valid
        if bel_info.tag != "bel_info":
            raise ValueError(f"Error: Unknown tag in custom XML file: {bel_info.tag}")

        bel_name = bel_info.attrib['name']

        #Check only one of each tag is present

        if len(bel_info.findall('bel_pb')) > 1:
            raise ValueError("Error: Found multiple bel_pb tags within one bel_info tag in custom XML file. Please provide only one.")

        if len(bel_info.findall('bel_model')) > 1:
            raise ValueError("Error: Found multiple bel_model tags within one bel_info tag in custom XML file. Please provide at most one.")

        if len(bel_info.findall('bel_interconnect')) > 1:
            raise ValueError("Error: Found multiple bel_interconnect tags within one bel_info tag in custom XML file. Please provide at most one.")

        #Fetch data and store in appropriate dicts
        if bel_info.find('bel_pb'):
            for bel_pb in bel_info.find('bel_pb'):
                specialBelDict[bel_name] = ET.tostring(bel_pb, encoding='unicode')
        if bel_info.find('bel_model'):
            for bel_model in bel_info.find('bel_model'):
                specialModelDict[bel_name] = ET.tostring(bel_model, encoding='unicode')
        if bel_info.find('bel_interconnect'):
            for bel_interconnect in bel_info.find('bel_interconnect'):
                specialInterconnectDict[bel_name] = ET.tostring(bel_interconnect, encoding='unicode')

    #Calculate clock X and Y coordinates considering variations in coordinate systems and EMPTY padding around VPR model
    newClockX = clockX + 1
    newClockY = clockY + 1


    ### DEVICE INFO

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

""" # Several of these values are fillers, as they are outside the current scope of the FABulous project
    # As we're feeding in a custom RR graph, the type of switch block shouldn't matter, so universal was just a filler - using 'custom' would require an extra tag

    #NOTE: Currently indentation is handled manually, but it's probably worth introducing a library/external function to handle this at some point
 

    ### COMPLEX BLOCKS, MODELS & TILES


    #String to store all the different kinds of pb_types needed - first we populate it with a dummy for tiles without BELs (as they still require a subtile)
    pb_typesString = '''<pb_type name="reserved_dummy">
    <interconnect>
    </interconnect>
    <input name="dummy_pin" num_pins="1"/>
    </pb_type>
    '''


    modelsString = "" #String to store different models

    tilesString = "" #String to store tiles

    #sourceSinkMap = getFabricSourcesAndSinks(archObject)
    
    doneBels = [] # List to track bels that we've already created a pb_type for (by type)
    for cellType in archObject.cellTypes: 
        cTile = getTileByType(archObject, cellType)

        tilesString += f'  <tile name="{cellType}">\n' #Add tiles and appropriate equivalent site
        # tilesString += f'   <sub_tile name="{cellType}_sub">' #Add sub_tile declaration to meet VTR 8.1.0 requirements
        # tilesString += '    <equivalent_sites>\n'
        # tilesString += f'     <site pb_type="{cellType}" pin_mapping="direct"/>\n'
        # tilesString += '    </equivalent_sites>\n'

        # pb_typesString += f'  <pb_type name="{cellType}">\n' #Top layer block

        tileInputs = [] #Track the tile's top level inputs and outputs for the top pb_type definition
        tileOutputs = [] 

        customInterconnectStr = "" #Create empty string to store custom interconnect XML

        if cTile.belsWithIO == []: #VPR requires a sub-tile tag, so if we can't create one for a BEL we make a dummy one
            tilesString += f'<sub_tile name="{cellType}_dummy" capacity="1">\n'
            tilesString += f'  <equivalent_sites>\n'
            tilesString += f'    <site pb_type="reserved_dummy" pin_mapping="direct"/>\n'
            tilesString += f'  </equivalent_sites>\n'
            tilesString += f'<input name="dummy_pin" num_pins="1"/>'
            tilesString += f'</sub_tile>\n'



        for bel in cTile.belsWithIO: #Create second layer (leaf) blocks for each bel
            tileInputs.extend(bel[2]) #Add the inputs and outputs of this BEL to the top level tile inputs/outputs list
            tileOutputs.extend(bel[3])

            if bel[2] == bel[3] == []:
                tilesString += f'<sub_tile name="{bel[1]}{bel[0]}_dummy" capacity="1">\n'
                tilesString += f'  <equivalent_sites>\n'
                tilesString += f'    <site pb_type="reserved_dummy" pin_mapping="direct"/>\n'
                tilesString += f'  </equivalent_sites>\n'
                tilesString += f'<input name="dummy_pin" num_pins="1"/>'
                tilesString += f'</sub_tile>\n'
                continue


            #We generate a separate subtile for each BEL instance (so that we can wire them differently)
            #Therefore we do this before the doneBels check

            # Add subtile to represent this BEL (specific instance)
            tilesString += f'   <sub_tile name="{bel[1]}{bel[0]}" capacity="1">\n' #Add sub_tile declaration to meet VTR 8.1.0 requirements
            tilesString += '    <equivalent_sites>\n'

            pinMappingStr = ''
            #Generate interconnect from wrapper pb_type to primitive
            for cInput in bel[2]:  #Add direct connections from top level tile to the corresponding child port
                pinMappingStr += f'    <direct from="{bel[1]}{bel[0]}.{cInput}" to="{bel[0]}_wrapper.{removeStringPrefix(cInput, bel[1])}"/>\n'


            for cOutput in bel[3]: #Add direct connections from child port to top level tile
                pinMappingStr += f'    <direct to="{bel[0]}_wrapper.{removeStringPrefix(cOutput, bel[1])}" from="{bel[1]}{bel[0]}.{cOutput}"/>\n'

            #TODO: FIX THIS WHEN FIXING CUSTOM XML
            if bel[4]:# and bel[0] not in specialBelDict: #If the BEL has a clock input then route it in - we don't do this for custom XML so the user is not restricted in terms of clock port presence or naming
                pinMappingStr += f'    <direct from="{bel[1]}{bel[0]}.UserCLK" to="{bel[0]}_wrapper.UserCLK"/>\n'

            if pinMappingStr == '': #If no connections then direct mapping so VPR doesn't insist on subchildren that clarify mapping
                tilesString += f'     <site pb_type="{bel[0]}_wrapper" pin_mapping="direct">\n'
            else:
                tilesString += f'     <site pb_type="{bel[0]}_wrapper" pin_mapping="custom">\n'           
                tilesString += pinMappingStr

            tilesString += f'     </site>\n'
            tilesString += '    </equivalent_sites>\n'

            #If the BEL has an external clock connection then add this to the tile string
            if bel[4]:
                tilesString += f'    <input name="UserCLK" num_pins="1"/>\n'


            #Add ports to BEL subtile
            for cInput in bel[2]:
                tilesString += f'    <input name="{cInput}" num_pins="1"/>\n'

            for cOutput in bel[3]:
                tilesString += f'    <output name="{cOutput}" num_pins="1"/>\n'

            tilesString += f'   </sub_tile>\n' #Close subtile tag for this BEL


            if bel[0] in doneBels: #We only want one pb_type for each kind of bel so we track which ones we have already done
                continue


            count = 0
            prefixList = []
            for innerBel in cTile.belsWithIO:
                if innerBel[0] == bel[0]: #Count how many of the current bel we have
                    count += 1
                    prefixList.append(innerBel[1]) #Add the prefix of this bel to our list of prefixes


            #Prepare custom passthrough interconnect from wrapper to primitive pb_type

            unprefixedInputs = [removeStringPrefix(cInput, bel[1]) for cInput in bel[2]] #Create lists of ports without prefixes for our generic modelling
            unprefixedOutputs = [removeStringPrefix(cOutput, bel[1]) for cOutput in bel[3]]

            passthroughInterconnectStr = '' #String to connect ports in primitive pb to same-named ports on top-level pb
            pbPortsStr = ''


            for cInput in unprefixedInputs:
                pbPortsStr += f'    <input name="{cInput}" num_pins="1"/>\n' #Add input and outputs
                passthroughInterconnectStr += f'<direct name="{bel[0]}_{cInput}_top_to_child" input="{bel[0]}_wrapper.{cInput}" output="{bel[0]}.{cInput}"/>\n'

            if bel[4]: #If the spec of the bel has an external clock connection
                pbPortsStr += f'    <input name="UserCLK" num_pins="1"/>\n' #Create an input to represent this
                passthroughInterconnectStr += f'<direct name="{bel[0]}_UserCLK_top_to_child" input="{bel[0]}_wrapper.UserCLK" output="{bel[0]}.UserCLK"/>\n'

            for cOutput in unprefixedOutputs:
                pbPortsStr += f'    <output name="{cOutput}" num_pins="1"/>\n' #Add outputs to pb
                passthroughInterconnectStr += f'<direct name="{bel[0]}_{cOutput}_child_to_top" input="{bel[0]}.{cOutput}" output="{bel[0]}_wrapper.{cOutput}"/>\n'



            if bel[0] in specialBelDict: #If the bel has custom pb_type XML
                thisPbString = specialBelDict[bel[0]] #Get the custom XML string
                pbSearch = num_pbRE.search(thisPbString) #And fetch the num_pb value (with regex)
                if pbSearch: #If there is a num_pb value specified
                    try:
                        fasm_prefix_count = int(pbSearch.group(4)) #Convert it to an int
                    except:
                        raise ValueError("Non-integer num_pb specified in custom XML") #Or if that's not possible raise an exception
                else:
                    fasm_prefix_count = 1 #Default in case of no num_pb specification is 1

                fasm_prefix_list = ""

                for i in range(fasm_prefix_count):
                    fasm_prefix_list += letters[i] + " " # Get a space separated list of the first <num_pb> letters

                pb_typesString += f'   <pb_type name="{bel[0]}_wrapper">\n'
                pb_typesString += thisPbString.format(fasm_prefix_list = fasm_prefix_list) #Add the custom pb_type XML with the list inserted
                pb_typesString += pbPortsStr
                pb_typesString += '   <interconnect>\n'
                pb_typesString += customInterconnectStr
                pb_typesString += passthroughInterconnectStr
                pb_typesString += '   </interconnect>\n'
                pb_typesString += f'   </pb_type>\n'

                if bel[0] in specialModelDict: #If it also has custom model XML
                    modelsString += specialModelDict[bel[0]] #Then add in this XML

                if bel[0] in specialInterconnectDict: #And if it has any custom interconnects
                    customInterconnectStr += specialInterconnectDict[bel[0]] #Add them to this string to be added in at the end of the pb_type

                # Also add in interconnect to pass signals through from the wrapper

            else: #Otherwise we generate the pb_type and model text

                pb_typesString += f'   <pb_type name="{bel[0]}_wrapper">\n' #Add inner pb_type tag opener
                pb_typesString += f'   <pb_type name="{bel[0]}" num_pb="1" blif_model=".subckt {bel[0]}">\n' #Add inner pb_type tag opener

                modelsString += f'  <model name="{bel[0]}">\n' #Add model tag
                modelsString += '   <input_ports>\n' #open tag for input ports in model list





                allOutsStr = " ".join(unprefixedOutputs) #Generate space-separated list of all outputs for combinational sink ports



                for cInput in unprefixedInputs:
                    modelsString += f'    <port name="{cInput}" combinational_sink_ports="{allOutsStr}"/>\n' #Add all outputs as combinational sinks

                if bel[4]: #If the spec of the bel has an external clock connection
                    modelsString += f'    <port name="UserCLK"/>\n' #Add all outputs as combinational sinks


                modelsString += '   </input_ports>\n' #close input ports tag
                modelsString += '   <output_ports>\n' #open output ports tag


                for cOutput in unprefixedOutputs:
                    modelsString += f'    <port name="{cOutput}"/>\n'


                modelsString += f'   </output_ports>\n' #close output ports tag
                modelsString += '  </model>\n'

                #Add metadata using prefixes gathered earlier
                prefixStr = " ".join(prefixList) #Str instead of string used for variable name as it is not to be injected directly into output

                if prefixStr != "": 
                    pb_typesString += '    <metadata>\n' #Add metadata tag to represent FASM prefix for genfasm tool
                    pb_typesString += f'     <meta name="fasm_prefix">{prefixStr}</meta>\n'
                    pb_typesString += '    </metadata>\n'


                #Generate delay constants - for the time being, we will assume that all inputs are combinatorially connected to all outputs

                for cInput in unprefixedInputs:
                    for cOutput in unprefixedOutputs: #Add a constant delay between every pair of input and output ports (as currently we say they are all combinationally linked)
                        pb_typesString += f'    <delay_constant max="300e-12" in_port="{bel[0]}.{cInput}" out_port="{bel[0]}.{cOutput}"/>\n'


                pb_typesString += pbPortsStr
                pb_typesString += '   </pb_type>\n' #Close inner tag
                pb_typesString += '   <interconnect>\n'
                pb_typesString += passthroughInterconnectStr
                pb_typesString += '   </interconnect>\n'
                pb_typesString += pbPortsStr
                pb_typesString += f'   </pb_type>\n' #Close wrapper tag

            doneBels.append(bel[0]) #Make sure we don't repeat similar BELs



        pinlocationsAndInputsStr = ''

        pinlocationsAndInputsStr += '   <pinlocations pattern="custom">\n' #Custom pinlocations allow us to set all pins to the bottom of the tile - this just makes RR graph accuracy easier
        
        # totalList = f'{cellType}_sub.UserCLK' #Add UserCLK to the list of pins
        # for cPin in (tileInputs + tileOutputs + list(sourceSinkMap[cTile.genTileLoc()][0]) + list(sourceSinkMap[cTile.genTileLoc()][1])): #List all pins 
        #     totalList += f' {cellType}_sub.{cPin}' #And add them to the pinlocation list

        # pinlocationsAndInputsStr += f'    <loc side ="bottom"> {totalList} </loc>\n' #Set all to bottom of tile

        # pinlocationsAndInputsStr += '   </pinlocations>\n'


        # pb_typesString += '   <interconnect>\n' #We now need interconnect to link every bel to the top pb_type

        # belCountDict = {} #Use dict to track how many of each bel we have seen
        # belIndexList = [] #Shows what index the bel at the relevant index has

        # for bel in cTile.belsWithIO:
        #     if bel[0] in belCountDict: #If we've already seen one of the bel
        #         i = belCountDict[bel[0]] #Then our index is the number we've already seen (indexing starts at 0)
        #         belCountDict[bel[0]] = i + 1 #And we increment our seen count by 1
        #     else:
        #         i = 0
        #         belCountDict[bel[0]] = 1 #Otherwise we set our seen count to 1 and set i to 0

        #     belIndexList.append(i) #Update list to map current bel to its index

        #     for cInput in bel[2]:  #Add direct connections from top level tile to the corresponding child port
        #         pb_typesString += f'    <direct name="{cTile.tileType}_{cInput}_top_to_child" input="{cellType}.{cInput}" output="{bel[0]}[{i}].{removeStringPrefix(cInput, bel[1])}"/>\n'


        #     for cOutput in bel[3]: #Add direct connections from child port to top level tile
        #         pb_typesString += f'    <direct name="{cTile.tileType}_{cOutput}_child_to_top" input="{bel[0]}[{i}].{removeStringPrefix(cOutput, bel[1])}" output="{cellType}.{cOutput}"/>\n'

        #     if bel[4] and bel[0] not in specialBelDict: #If the BEL has a clock input then route it in - we don't do this for custom XML so the user is not restricted in terms of clock port presence or naming
        #         pb_typesString += f'    <direct name="{cTile.tileType}_{bel[0]}_{i}_clock_in" input="{cellType}.UserCLK" output="{bel[0]}[{i}].UserCLK"/>\n'

        # TODO: REFACTOR THIS
        # for pip in cTile.pips: 
        #     if (pip[0] in tileOutputs) and (pip[1] in tileInputs): #If we have a pip connecting a bel output to a bel input we add it as a direct connection
        #         for i, bel in enumerate(cTile.belsWithIO): 
        #             if pip[0] in bel[3]: #If the pip's source is the same as the bel's output then we note it as the source of the pip
        #                 sourceBel = bel #Note which bel it is
        #                 sourceIndex = belIndexList[i] #And what index it has (in terms of its own type e.g. LUT4[2])
        #             if pip[1] in bel[2]: #And if the pip's sink is the same as the bel's input then we note it as the sink
        #                 sinkBel = bel #Note the same again
        #                 sinkIndex = belIndexList[i]
        #         sourceStr = f'{sourceBel[0]}[{sourceIndex}].{removeStringPrefix(pip[0], sourceBel[1])}' #Generate the source
        #         sinkStr = f'{sinkBel[0]}[{sinkIndex}].{removeStringPrefix(pip[1], sinkBel[1])}' #And sink port names
        #         pb_typesString += f'    <direct name="{pip[0]}_{pip[1]}_pip" input="{sourceStr}" output="{sinkStr}"/>\n' #And add the direct tag
 

        # pb_typesString += customInterconnectStr
        # pb_typesString += '   </interconnect>\n'

        # tilesString += f'   <input name="UserCLK" num_pins="1"/>\n'
        # pb_typesString += f'   <input name="UserCLK" num_pins="1"/>\n'


        # #Now we add tile and top-level pb_type inputs and outputs
        # for cInput in tileInputs:
        #     pb_typesString += f'   <input name="{cInput}" num_pins="1"/>\n' #Add top level inputs and outputs
        #     pinlocationsAndInputsStr += f'   <input name="{cInput}" num_pins="1"/>\n'


        # for cOutput in tileOutputs:
        #     pb_typesString += f'   <output name="{cOutput}" num_pins="1"/>\n'
        #     pinlocationsAndInputsStr += f'   <output name="{cOutput}" num_pins="1"/>\n'


        # for source in sourceSinkMap[cTile.genTileLoc()][0]:
        #     pb_typesString += f'   <output name="{source}" num_pins="1"/>\n' #Add top level inputs and outputs
        #     pinlocationsAndInputsStr += f'   <output name="{source}" num_pins="1"/>\n'            

        # for sink in sourceSinkMap[cTile.genTileLoc()][1]:
        #     pb_typesString += f'   <input name="{sink}" num_pins="1"/>\n' #Add top level inputs and outputs
        #     pinlocationsAndInputsStr += f'   <input name="{sink}" num_pins="1"/>\n'    

        # #And close final tile & pb_type string
        # pb_typesString += f'  </pb_type>\n'
        # tilesString += pinlocationsAndInputsStr + '</sub_tile>\n' 
        tilesString += '  </tile>\n'



    ### LAYOUT


    layoutString = f'  <fixed_layout name="FABulous" width="{archObject.width + 2}" height="{archObject.height + 2}">\n' #Add 2 for empty padding

    layoutString += f'      <single type="clock_primitive" priority="1" x="{newClockX}" y="{newClockY}"/>\n' #Add tag for dummy clock
    #Tile locations are specified using <single> tags - while the typical fabric will be made up of larger blocks of tiles, this allows the most flexibility

    for line in archObject.tiles:
        for tile in line:
            if tile.tileType != "NULL": #We do not need to specify if the tile is empty as all tiles default to EMPTY in VPR
                layoutString += f'   <single type="{tile.tileType}" priority="1" x="{tile.x + 1}" y="{tile.y + 1}">\n' #Add single tag for each tile - add 1 to x and y (cancels out in y conversion) for padding
                #Now add metadata for fasm generation
                layoutString += '    <metadata>\n' 
                layoutString += f'     <meta name="fasm_prefix"> {tile.genTileLoc()} </meta>\n' #Only metadata required is the tile name for the prefix
                layoutString += '    </metadata>\n'
                layoutString += '   </single>\n'

    layoutString += '  </fixed_layout>\n'


    ### SWITCHLIST


    switchlistString = '  <switch type="buffer" name="ipin_cblock" R="551" Cin=".77e-15" Cout="4e-15" Tdel="58e-12" buf_size="27.645901"/>\n' #Values are fillers from templates
    switchlistString += '  <switch type="mux" name="buffer"  R="2e-12" Cin=".77e-15" Cout="4e-15" Tdel="58e-12" mux_trans_size="2.630740" buf_size="27.645901"/>\n'


    ### SEGMENTLIST - contains only a filler as it is a necessity to parse the architecture graph but we are reading a custom RR graph


    segmentlistString = """  <segment name="dummy" length="1" freq="1.000000" type="unidir" Rmetal="1e-12" Cmetal="22.5e-15">
   <sb type="pattern">0 0</sb>
   <cb type="pattern">0</cb>
   <mux name="buffer"/>
  </segment>"""

    ### CLOCK SETUP

    #Generate full strings for insertion - this is just a tile with the clock primitive on it
    clockTileStr = f"""  <tile name="clock_primitive">
   <sub_tile name="clock_sub">
    <equivalent_sites>
     <site pb_type="clock_primitive" pin_mapping="direct"/>
    </equivalent_sites>
    <output name="clock_out" num_pins="1"/>
   </sub_tile>
  </tile>"""

    #This is a pb_type with a Global_Clock primitive - when programming we instantiate this as a blackbox
    clockPbStr = f""" <pb_type name="clock_primitive">
  <pb_type name="clock_input" blif_model=".subckt Global_Clock" num_pb="1">
   <output name="CLK" num_pins="1"/>
  </pb_type>
  <output name="clock_out" num_pins="1"/>
  <interconnect>
   <direct name="clock_prim_to_top" input="clock_input.CLK" output="clock_primitive.clock_out"/>
  </interconnect>
 </pb_type> """


    ### OUTPUT


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

def genVPRModelRRGraph(archObject: Fabric, generatePairs = True):

    #Calculate clock X and Y coordinates considering variations in coordinate systems and EMPTY padding around VPR model
    newClockX = clockX + 1
    newClockY = clockY + 1
    

    ### BLOCKS


    blocksString = '' #Initialise string for block types
    curId = 0 #Increment id from 0 as we work through
    blockIdMap = {} #Dictionary to record IDs for different tile types when generating grid
    ptcMap = {} #Dict to map tiles to individual dicts that map pin name to PTC
    sourceSinkMap = getFabricSourcesAndSinks(archObject) # Get sources and sinks for fabric - more info in method

    #First, handle tiles not defined in architecture:

    blocksString += f"""  <block_type id="{curId}" name="EMPTY" width="1" height="1">
  </block_type>\n"""
    blockIdMap["EMPTY"] = curId
    curId += 1 #Add empty tile to block type spec and increment id by 1

    #And add clock tile (as this is a dummy to represent deeper FABulous functionality, so will not be in our csv files)

    blocksString += f'  <block_type id="{curId}" name="clock_primitive" width="1" height="1">\n'

    ptc = 0

    blocksString += f'   <pin_class type="OUTPUT">\n'
    blocksString += f'    <pin ptc="{ptc}">clock_primitive.clock_out[0]</pin>\n' #Add output tag for each tile
    blocksString += f'   </pin_class>\n'
    ptc += 1

    blocksString += '</block_type>\n'
    blockIdMap["clock_primitive"] = curId #Store that the clock_primitive block has this ID
    curId += 1

    for cellType in archObject.cellTypes:
        tilePtcMap = {} #Dict to map each pin on this tile to its ptc
        blocksString += f'  <block_type id="{curId}" name="{cellType}" width="1" height="1">\n' #Generate block type tile for each type of tile - we assume 1x1 tiles here
        
        cTile = getTileByType(archObject, cellType) #Fetch tile of this type
        
        ptc = 0

        blocksString += f'   <pin_class type="INPUT">\n' #Generate the tags 
        blocksString += f'    <pin ptc="{ptc}">{cellType}.UserCLK[0]</pin>\n'
        blocksString += f'   </pin_class>\n'

        ptc += 1        

        blockInputString = "" #String to hold all input declarations
        blockOutputString = "" #String to hold all output declarations

        for bel in cTile.belsWithIO: #For each bel on the tile
            for cInput in bel[2]: #Take each input and output
                blockInputString += f'   <pin_class type="INPUT">\n' #Generate the tags 
                blockInputString += f'    <pin ptc="{ptc}">{cellType}.{cInput}[0]</pin>\n'
                blockInputString += f'   </pin_class>\n'
                tilePtcMap[cInput] = ptc #Note the ptc in the tile's ptc map
                ptc += 1 #And increment the ptc

        for sink in sourceSinkMap[cTile.genTileLoc()][1]:
            blockInputString += f'   <pin_class type="INPUT">\n' #Generate the tags 
            blockInputString += f'    <pin ptc="{ptc}">{cellType}.{sink}[0]</pin>\n'
            blockInputString += f'   </pin_class>\n'
            tilePtcMap[sink] = ptc #Note the ptc in the tile's ptc map
            ptc += 1 #And increment the ptc 

        for bel in cTile.belsWithIO: 
            for cOutput in bel[3]:
                blockOutputString += f'   <pin_class type="OUTPUT">\n' #Same as above
                blockOutputString += f'    <pin ptc="{ptc}">{cellType}.{cOutput}[0]</pin>\n'
                blockOutputString += f'   </pin_class>\n'
                tilePtcMap[cOutput] = ptc
                ptc += 1

        for source in sourceSinkMap[cTile.genTileLoc()][0]:
            blockOutputString += f'   <pin_class type="OUTPUT">\n' #Same as above
            blockOutputString += f'    <pin ptc="{ptc}">{cellType}.{source}[0]</pin>\n'
            blockOutputString += f'   </pin_class>\n'
            tilePtcMap[source] = ptc
            ptc += 1     

      

        blocksString += blockInputString
        blocksString += blockOutputString

        blocksString += '  </block_type>\n'

        ptcMap[cellType] = dict(tilePtcMap) #Create copy of ptc map for this tile and add to larger dict (passing by reference would have undesired effects)

        blockIdMap[cellType] = curId #Populate our map of type name to ID as we need the ID for generating the grid
        curId += 1



    ### NODES



    nodesString = ''
    curNodeId = 0 #Start indexing nodes at 0 and increment each time a node is added

    sourceToWireIDMap = {} #Dictionary to map a wire source to the relevant wire ID
    destToWireIDMap = {} #Dictionary to map a wire destination to the relevant wire ID

    max_width = 1 #Initialise value to find maximum channel width for channels tag - start as 1 as you can't have a thinner wire!

    srcToOpinStr = ''
    IpinToSinkStr = ''
    clockPtc = 0
    clockLoc = f'X{clockX}Y{clockY}'

    # Add node for clock out
    nodesString += f'  <!-- Clock output: clock_primitive.clock_out -->\n'

    nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n' #Generate tag for each node
    nodesString += f'   <loc xlow="{newClockX}" ylow="{newClockY}" xhigh="{newClockX}" yhigh="{newClockY}" ptc="0"/>\n' #Add loc tag
    nodesString += '  </node>\n' #Close node tag

    curNodeId += 1 #Increment id so all nodes have different ids

    nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n' #Generate tag for each node
    nodesString += f'   <loc xlow="{newClockX}" ylow="{newClockY}" xhigh="{newClockX}" yhigh="{newClockY}" ptc="0" side="BOTTOM"/>\n' #Add loc tag
    nodesString += '  </node>\n' #Close node tag
    srcToOpinStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'
    destToWireIDMap[clockLoc + "." + "clock_out"] = curNodeId #Add to dest map as equivalent to a wire destination
    curNodeId += 1      
    clockPtc += 1

    #Looks like VPR can only handle node PTCs up to (2^15-1), so not sufficient to just give every wire a different PTC
    #Context: wires can't overlap another wire with the same PTC
    #Exhaustive search here might take a while, so instead vertical and horizontal wires have a different set of PTCs
    #Each column and row has its own current PTC so that there's no repetition in one column or row
    #Horizontal wires take and increment their row's PTC num
    #Vertical wires take and increment their column's PTC num
    #Column PTCs start at 2^14 so that there's no overlap between column and row PTCs

    #These are just indexed by tile.x and tile.y - not exactly the same as the coordinates in the
    #VPR description but it's a one-to-one mapping and all we need is no overlap so it's fine and simple
    rowPtcArr = [0] * archObject.height
    colPtcArr = [2**14] * archObject.width

    #These are just used as bound checks to make sure the fabric isn't still too big
    rowMaxPtc = 2**14 - 1
    colMaxPtc = 2**15 - 1

    for row in archObject.tiles:
        for tile in row:
            tileLoc = tile.genTileLoc()
            #Generate clock nodes:

            #First, clock output:
            if tile.tileType != "NULL":
                #Add clock inputs for every tile:

                nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="0" side="BOTTOM"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag            
                sourceToWireIDMap[tileLoc + ".UserCLK"] = curNodeId #Add to dest map as equivalent to a wire destination
                curNodeId += 1      

                nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="0"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag  
                IpinToSinkStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'          
                curNodeId += 1    

            for wire in tile.wires:
                if wire["yoffset"] != "0" and wire["xoffset"] != "0": #We want to find the length of the wire based on the x and y offset - either it's a jump, or in theory goes off in only one direction - let's find which
                    raise Exception("Diagonal wires not currently supported for VPR routing resource model") #Stop if there are diagonal wires just in case they get put in a fabric
                if wire["yoffset"] != "0": #Then we check which one isn't zero and take that as the length
                    nodeType = "CHANY" #Set node type as vertical channel if wire is vertical
                elif wire["xoffset"] != "0":
                    nodeType = "CHANX" #Set as horizontal if moving along X
                else: #If we get to here then both offsets are zero and so this must be a jump wire
                    nodeType = "CHANY" # default to CHANY - as offsets are zero it does not matter


                desty = tile.y + int(wire["yoffset"]) #Calculate destination location of the wire at hand
                destx = tile.x + int(wire["xoffset"])
                desttileLoc = f"X{destx}Y{desty}"

                if (nodeType == "CHANX" and int(wire["xoffset"]) > 0) or (nodeType == "CHANY" and int(wire["yoffset"]) > 0): #Check wire direction and set appropriate valuesz
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

                for i in range(int(wire["wire-count"])): #For every individual wire
                    wireSource = tileLoc + "." + wire["source"] #Generate location strings for the source and destination
                    wireDest = desttileLoc + "." + wire["destination"]

                    if nodeType == "CHANY":
                        wirePtc = colPtcArr[tile.x]
                        colPtcArr[tile.x] += 1
                        if wirePtc > colMaxPtc:
                            raise ValueError("Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")
                    else: #i.e. if nodeType == "CHANX"
                        wirePtc = rowPtcArr[tile.y]
                        rowPtcArr[tile.y] += 1
                        if wirePtc > rowMaxPtc:
                            raise ValueError("Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")


                    #Coordinates until now have been relative to the fabric - only account for padding when formatting actual string
                    nodesString += f'  <!-- Wire: {wireSource+str(i)} -> {wireDest+str(i)} -->\n' #Comment destination for clarity
                    nodesString += f'  <node id="{curNodeId}" type="{nodeType}" capacity="1" direction="{direction}">\n' #Generate tag for each node
                    nodesString += '   <segment segment_id="0"/>\n'
                    nodesString += f'   <loc xlow="{xLow + 1}" ylow="{yLow + 1}" xhigh="{xHigh + 1}" yhigh="{yHigh + 1}" ptc="{wirePtc}"/>\n' #Add loc tag with the information we just calculated

                    nodesString += '  </node>\n' #Close node tag

                    sourceToWireIDMap[wireSource+str(i)] = curNodeId
                    destToWireIDMap[wireDest+str(i)] = curNodeId

                    curNodeId += 1 #Increment id so all nodes have different ids
                max_width = max(max_width, int(wire["wire-count"])) #If our current width is greater than the previous max, take the new one


            # Generate nodes for atomic wires
            for wire in tile.atomicWires:
                if wire["yoffset"] != "0" and wire["xoffset"] != "0": #We want to find the length of the wire based on the x and y offset - either it's a jump, or in theory goes off in only one direction - let's find which
                    print(wire["yoffset"], wire["xoffset"])
                    raise Exception("Diagonal wires not currently supported for VPR routing resource model") #Stop if there are diagonal wires just in case they get put in a fabric
                if wire["yoffset"] != "0": #Then we check which one isn't zero and take that as the length
                    nodeType = "CHANY" #Set node type as vertical channel if wire is vertical
                elif wire["xoffset"] != "0":
                    nodeType = "CHANX" #Set as horizontal if moving along X

                wireSource = wire["sourceTile"] + "." + wire["source"] #Generate location strings for the source and destination
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
                        raise ValueError("Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")
                else: #i.e. if nodeType == "CHANX"
                    wirePtc = rowPtcArr[tile.y]
                    rowPtcArr[tile.y] += 1
                    if wirePtc > rowMaxPtc:
                        raise ValueError("Channel PTC value too high - FABulous' VPR flow may not currently be able to support this many overlapping wires.")


                nodesString += f'  <!-- Atomic Wire: {wireSource} -> {wireDest} -->\n' #Comment destination for clarity
                nodesString += f'  <node id="{curNodeId}" type="{nodeType}" capacity="1" direction="{direction}">\n' #Generate tag for each node

                nodesString += f'   <loc xlow="{xLow + 1}" ylow="{yLow + 1}" xhigh="{xHigh + 1}" yhigh="{yHigh + 1}" ptc="{wirePtc}"/>\n' #Add loc tag with the information we just calculated
                nodesString += '   <segment segment_id="0"/>\n'

                nodesString += f'  </node>\n' #Close node tag

                sourceToWireIDMap[wireSource] = curNodeId
                destToWireIDMap[wireDest] = curNodeId

                curNodeId += 1 #Increment id so all nodes have different ids

            # Generate nodes for bel ports
            for bel in tile.belsWithIO: 
                for cInput in bel[2]:
                    if tile.tileType in ptcMap and cInput in ptcMap[tile.tileType]:
                        thisPtc = ptcMap[tile.tileType][cInput]
                    else:
                        raise Exception("Could not find pin ptc in block_type designation for RR Graph generation.")
                    nodesString += f'  <!-- BEL input: {cInput} -->\n'
                    nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n' #Generate tag for each node
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n' #Add loc tag - same high and low vals as no movement between tiles
                    nodesString += '  </node>\n' #Close node tag

                    sourceToWireIDMap[tileLoc + "." + cInput] = curNodeId #Add to source map as it is the equivalent of a wire source

                    curNodeId += 1 #Increment id so all nodes have different ids

                    nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n' #Generate tag for each node
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n' #Add loc tag - same high and low vals as no movement between tiles
                    nodesString += '  </node>\n' #Close node tag
                    IpinToSinkStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'          

                    curNodeId += 1 #Increment id so all nodes have different ids

                for cOutput in bel[3]:
                    if tile.tileType in ptcMap and cOutput in ptcMap[tile.tileType]:
                        thisPtc = ptcMap[tile.tileType][cOutput]
                    else:
                        raise Exception("Could not find pin ptc in block_type designation for RR Graph generation.")
                    nodesString += f'  <!-- BEL output: {cOutput} -->\n'

                    nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n' #Generate tag for each node
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n' #Add loc tag
                    nodesString += '  </node>\n' #Close node tag
                    destToWireIDMap[tileLoc + "." + cOutput] = curNodeId #Add to dest map as equivalent to a wire destination                    
                    curNodeId += 1 #Increment id so all nodes have different ids

                    nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n' #Generate tag for each node
                    nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n' #Add loc tag
                    nodesString += '  </node>\n' #Close node tag
                    srcToOpinStr += f'  <edge src_node="{curNodeId}" sink_node="{curNodeId - 1}" switch_id="1"/>\n'
                    curNodeId += 1 #Increment id so all nodes have different ids

            for source in sourceSinkMap[tile.genTileLoc()][0]:
                thisPtc = ptcMap[tile.tileType][source]


                nodesString += f'  <!-- Source: {tile.genTileLoc()}.{source} -->\n'

                nodesString += f'  <node id="{curNodeId}" type="SOURCE" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag

                curNodeId += 1 #Increment id so all nodes have different ids

                nodesString += f'  <node id="{curNodeId}" type="OPIN" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag
                srcToOpinStr += f'  <edge src_node="{curNodeId - 1}" sink_node="{curNodeId}" switch_id="1"/>\n'
                destToWireIDMap[tileLoc + "." + source] = curNodeId #Add to dest map as equivalent to a wire destination

                curNodeId += 1

            for sink in sourceSinkMap[tile.genTileLoc()][1]:
                thisPtc = ptcMap[tile.tileType][sink]


                nodesString += f'  <!-- Sink: {tile.genTileLoc()}.{sink} -->\n'

                nodesString += f'  <node id="{curNodeId}" type="SINK" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag
                curNodeId += 1 #Increment id so all nodes have different ids                


                nodesString += f'  <node id="{curNodeId}" type="IPIN" capacity="1">\n' #Generate tag for each node
                nodesString += f'   <loc xlow="{tile.x + 1}" ylow="{tile.y + 1}" xhigh="{tile.x + 1}" yhigh="{tile.y + 1}" ptc="{thisPtc}" side="BOTTOM"/>\n' #Add loc tag
                nodesString += '  </node>\n' #Close node tag

                IpinToSinkStr += f'  <edge src_node="{curNodeId}" sink_node="{curNodeId - 1}" switch_id="1"/>\n'          

                sourceToWireIDMap[tileLoc + "." + sink] = curNodeId #Add to dest map as equivalent to a wire destination
                curNodeId += 1 #Increment id so all nodes have different ids                

    ### EDGES


    edgeStr = srcToOpinStr + IpinToSinkStr #Initialise list of edges with edges connecting OPINs and IPINs to their corresponding SINKs and SOURCEs

    #Create edges for all pips in fabric

    for row in archObject.tiles:
        for tile in row:
            if tile.tileType != "NULL": #If the tile isn't NULL then create an edge for the clock primitive connection
                tileLoc = tile.genTileLoc()
                edgeStr += f'  <edge src_node="{destToWireIDMap[clockLoc + "." + "clock_out"]}" sink_node="{sourceToWireIDMap[tileLoc + ".UserCLK"]}" switch_id="1"/>\n'


            for pip in tile.pips: # Find source and sink name
                src_name = tileLoc + "." + pip[0]
                sink_name = tileLoc + "." + pip[1]

                edgeStr += f'  <edge src_node="{destToWireIDMap[src_name]}" sink_node="{sourceToWireIDMap[sink_name]}" switch_id="1">\n' #And create node
                edgeStr += '   <metadata>\n' #Generate metadata tag that tells us which switch matrix connection to activate
                edgeStr += f'    <meta name="fasm_features">{".".join([tileLoc, pip[0], pip[1]])}</meta>\n'
                edgeStr += '   </metadata>\n'
                edgeStr += '  </edge>\n'



    ### CHANNELS

    max_width = max(rowPtcArr + colPtcArr)

    #Use the max width generated before for this tag
    channelString = f'  <channel chan_width_max="{max_width}" x_min="0" y_min="0" x_max="{archObject.width + 1}" y_max="{archObject.height + 1}"/>\n'
    
    #Generate x_list tag and y_list tag for every channel - use the upper bound max_width for simplicity
    #Not a bug that this uses height for the x_list and width for the y_list - see VtR's RR graph file format docs
    for i in range(archObject.height + 2):
        channelString += f'  <x_list index ="{i}" info="{max_width}"/>\n'

    for i in range(archObject.width + 2):
        channelString += f'  <y_list index ="{i}" info="{max_width}"/>\n'




    ### GRID

    gridString = ''

    for row in archObject.tiles[::-1]:
        for tile in row:
            if tile.x == clockX and tile.y == clockY: #We add the clock tile at the end so ignore it for now
                continue      
            if tile.tileType == "NULL": #The method that generates cellTypes ignores NULL, so it was never in our map - we'll just use EMPTY instead as we did for the main XML model
                gridString += f'  <grid_loc x="{tile.x + 1}" y="{tile.y + 1}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
                continue
            gridString += f'  <grid_loc x="{tile.x + 1}" y="{tile.y + 1}" block_type_id="{blockIdMap[tile.tileType]}" width_offset="0" height_offset="0"/>\n'

    # Create padding of EMPTY tiles around chip
    gridString += '  <!-- EMPTY padding around chip -->\n'

    for i in range(archObject.height + 2): #Add vertical padding
        if newClockX != 0 or newClockY != i: #Make sure that this isn't the clock tile as we add this at the end
            gridString += f'  <grid_loc x="0" y="{i}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
        if newClockX != archObject.width + 1 or newClockY != i: #Check not clock tile
            gridString += f'  <grid_loc x="{archObject.width + 1}" y="{i}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'

    for i in range(1, archObject.width + 1): #Add horizontal padding
        if newClockX != i or newClockY != 0: #Check not clock tile
            gridString += f'  <grid_loc x="{i}" y="0" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'
        if newClockX != i or newClockY != archObject.height + 1: #Check not clock tile      
            gridString += f'  <grid_loc x="{i}" y="{archObject.height + 1}" block_type_id="{blockIdMap["EMPTY"]}" width_offset="0" height_offset="0"/>\n'

    #Finally, add clock tile loc
    gridString += f'  <grid_loc x="{newClockX}" y="{newClockY}" block_type_id="{blockIdMap["clock_primitive"]}" width_offset="0" height_offset="0"/>\n'


    ### SWITCHES


    # Largely filler info - again, FABulous does not deal with this level of hardware detail currently

    switchesString = '''        <switch id="0" type="mux" name="__vpr_delayless_switch__">
            <timing R="0" Cin="0" Cout="0" Tdel="0"/>
            <sizing mux_trans_size="0" buf_size="0"/>
        </switch>
        <switch id="1" type="mux" name="buffer">
            <timing R="1.99999999e-12" Cin="7.70000012e-16" Cout="4.00000001e-15" Tdel="5.80000006e-11"/>
            <sizing mux_trans_size="2.63073993" buf_size="27.6459007"/>
        </switch>\n'''


    ### OUTPUT    


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
''' #Same point as in main XML generation applies here regarding outsourcing indentation

    print(f'Max Width: {max_width}')
    return outputString


def genBitstreamSpec(archObject: Fabric):
	specData = {"TileMap":{}, "TileSpecs":{}, "TileSpecs_No_Mask":{}, "FrameMap":{}, "FrameMapEncode":{}, "ArchSpecs":{"MaxFramesPerCol":MaxFramesPerCol, "FrameBitsPerRow":FrameBitsPerRow}}
	BelMap = {}
	for line in archObject.tiles:
		for tile in line:
			specData["TileMap"][tile.genTileLoc()] = tile.tileType

	#Generate mapping dicts for bel types: 
	#The format here is that each BEL has a dictionary that maps a fasm feature to another dictionary that maps bits to their values
	#The lines generating the BEL maps do it slightly differently, just notating bits that should go high - this is translated further down
	#We do not worry about bitmasking here - that's handled in the generation

	#LUT4:

	LUTmap = {}
	LUTmap["INIT"] = 0 #Futureproofing as there are two ways that INIT[0] may be referred to (FASM parser will use INIT to refer to INIT[0])
	for i in range(16):
		LUTmap["INIT[" + str(i) + "]"] = i
	LUTmap["FF"] = 16
	LUTmap["IOmux"] = 17
	LUTmap["SET_NORESET"] = 18

	BelMap["LUT4c_frame_config"] = LUTmap

	#MUX8

	MUX8map = {"c0":0, "c1":1}

	BelMap["MUX8LUT_frame_config"] = MUX8map

	#MULADD 

	MULADDmap = {}
	MULADDmap["A_reg"] = 0
	MULADDmap["B_reg"] = 1
	MULADDmap["C_reg"] = 2

	MULADDmap["ACC"] = 3

	MULADDmap["signExtension"] = 4

	MULADDmap["ACCout"] = 5

	BelMap["MULADD"] = MULADDmap

    #IOpad
	BelMap["IO_1_bidirectional_frame_config_pass"] = {}

	Config_accessmap = {}
	Config_accessmap["C_bit0"] = 0
	Config_accessmap["C_bit1"] = 1
	Config_accessmap["C_bit2"] = 2
	Config_accessmap["C_bit3"] = 3
	BelMap["Config_access"] = Config_accessmap

	#InPass

	InPassmap = {}

	InPassmap["I0_reg"] = 0
	InPassmap["I1_reg"] = 1
	InPassmap["I2_reg"] = 2
	InPassmap["I3_reg"] = 3

	BelMap["InPass4_frame_config"] = InPassmap
	#OutPass

	OutPassmap = {}

	OutPassmap["I0_reg"] = 0
	OutPassmap["I1_reg"] = 1
	OutPassmap["I2_reg"] = 2
	OutPassmap["I3_reg"] = 3

	BelMap["OutPass4_frame_config"] = OutPassmap


	#RegFile
	RegFilemap = {}

	RegFilemap["AD_reg"] = 0
	RegFilemap["BD_reg"] = 1

	BelMap["RegFile_32x4"] = RegFilemap

	#DoneTypes = []


	###NOTE: THIS METHOD HAS BEEN CHANGED FROM A PREVIOUS IMPLEMENTATION SO PLEASE BEAR THIS IN MIND
	#To account for cascading and termination, this now creates a separate map for every tile, as opposed to every cellType
	for row in archObject.tiles:
		#curTile = getTileByType(archObject, cellType)
		for curTile in row:
			cellType = curTile.tileType
			if cellType == "NULL":
				continue


			#Add frame masks to the dictionary 
			try:
				configCSV = open(cellType + "_ConfigMem.csv") #This may need to be .init.csv, not just .csv
			except:
			    try:
			        configCSV = open(cellType + "_ConfigMem.init.csv")
			    except:
			        print(f"No Config Mem csv file found for {cellType}. Assuming no config memory.")
			        specData["FrameMap"][cellType] = {}
			        specData["FrameMapEncode"][cellType] = {}
			        continue
			configList = [i.strip('\n').split(',') for i in configCSV]
			configList = RemoveComments(configList)
			maskDict = {}
			encodeDict = [-1 for i in range(FrameBitsPerRow*MaxFramesPerCol)]  #Bitmap with the specific configmem.csv file
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
				        configEncode.append(index)
				#print(configEncode)
				encode_i = 0
				for i,char in enumerate(maskDict[int(line[1])]):
				    if char != '0':
				        #encodeDict[int(line[1])][i] = configEncode[encode_i]
				        encodeDict[int(configEncode[encode_i])] = (31 - i) + ( 32 * int(line[1]))
				        encode_i += 1
			#print(encodeDict)
			specData["FrameMap"][cellType] = maskDict
			if 'term' in cellType:
				print(f"No config memory for {cellType}.")
				specData["FrameMap"][cellType] = {}
				specData["FrameMapEncode"][cellType] = {}
				#continue
			# if specData["ArchSpecs"]["MaxFramesPerCol"] < int(line[1]) + 1:
			# 	specData["ArchSpecs"]["MaxFramesPerCol"] = int(line[1]) + 1
			# if specData["ArchSpecs"]["FrameBitsPerRow"] < int(line[2]):
			# 	specData["ArchSpecs"]["FrameBitsPerRow"] = int(line[2])
			configCSV.close()

			curBitOffset = 0
			curTileMap = {}
			curTileMap_No_Mask = {}

			for i, belPair in enumerate(curTile.bels):	#Add the bel features we made a list of earlier
				tempOffset = 0
				name = letters[i]
				#print(belPair)
				belType = belPair[0]
				for featureKey in BelMap[belType]:
					curTileMap[name + "." +featureKey] = {encodeDict[BelMap[belType][featureKey] + curBitOffset]: "1"}	#We convert to the desired format like so
					curTileMap_No_Mask[name + "." +featureKey] = {(BelMap[belType][featureKey] + curBitOffset): "1"}
					if featureKey != "INIT":
					    tempOffset += 1
				curBitOffset += tempOffset
				#if(belType == 'Config_access'):
				    #print(curBitOffset)
			csvFile = [i.strip('\n').split(',') for i in open(curTile.matrixFileName)] 
			pipCounts = [int(row[-1]) for row in csvFile[1::]]
			csvFile = RemoveComments(csvFile)
			sinks = [line[0] for line in csvFile]
			sources = csvFile[0]
			pips = []
			pipsdict = {}
			for y, row in enumerate(csvFile[1::]): #Config bits for switch matrix from file
				muxList = []
				pipCount = pipCounts[y]
				for x, value in enumerate(row[1::]):
					#Remember that x and y are offset 
					if value == "1":
						muxList.append(".".join((sources[x+1], sinks[y+1])))
				muxList.reverse() #Order is flipped 
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
						curTileMap[pip][encodeDict[curBitOffset + tempOffset]] = curChar
						curTileMap_No_Mask[pip][curBitOffset + tempOffset] = curChar
						tempOffset += 1
				curBitOffset += controlWidth
			for wire in curTile.wires: #And now we add empty config bit mappings for immutable connections (i.e. wires), as nextpnr sees these the same as normal pips
				for count in range(int(wire["wire-count"])):
					wireName = ".".join((wire["source"] + str(count), wire["destination"] + str(count)))
					curTileMap[wireName] = {} #Tile connection wires are seen as pips by nextpnr for ease of use, so this makes sure those pips still have corresponding keys
					curTileMap_No_Mask[wireName] = {}
			for wire in curTile.atomicWires:
				wireName = ".".join((wire["source"], wire["destination"]))
				curTileMap[wireName] = {}
				curTileMap_No_Mask[wireName] = {}

			specData["TileSpecs"][curTile.genTileLoc()] = curTileMap
			specData["TileSpecs_No_Mask"][curTile.genTileLoc()] = curTileMap_No_Mask

	return specData

#####################################################################################
# Main
#####################################################################################

# read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
print('### Read Fabric csv file ###')
FabricFile = [i.strip('\n').split(',') for i in open('fabric.csv')]
fabric = GetFabric(FabricFile)  #filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'

# the next isn't very elegant, but it works...
# I wanted to store parameters in our fabric csv between a block 'ParametersBegin' and ParametersEnd'
ParametersFromFile = GetFabric(FabricFile, filter = 'Parameters')
for item in ParametersFromFile:
    # if the first element is the variable name, then overwrite the variable state with the second element, otherwise it would leave the default
    if 'ConfigBitMode' == item[0]:
         ConfigBitMode = item[1]
    elif 'FrameBitsPerRow' == item[0]:
         FrameBitsPerRow = int(item[1])
    elif 'Package' == item[0]:
         Package = int(item[1])
    elif 'MaxFramesPerCol' == item[0]:
         MaxFramesPerCol = int(item[1])
    elif 'GenerateDelayInSwitchMatrix' == item[0]:
         GenerateDelayInSwitchMatrix = int(item[1])
    elif 'MultiplexerStyle' == item[0]:
         MultiplexerStyle = item[1]
    elif 'SuperTileEnable' == item[0]:
        if item[1] == "TRUE":
            SuperTileEnable = True
        elif item[1] == "FALSE":
            SuperTileEnable = False
    else:
        raise ValueError('\nError: unknown parameter "'+item[0]+'" in fabric csv at section ParametersBegin\n')

### # from StackOverflow  config.get("set", "var_name")
### #ConfigBitMode    frame_based
### # config.get("frame_based", "ConfigBitMode")
### config = ConfigParser.ConfigParser()
### config.read("fabric.ini")
### var_a = config.get("myvars", "var_a")
### var_b = config.get("myvars", "var_b")
### var_c = config.get("myvars", "var_c")
print('DEBUG Parameters: ', ConfigBitMode, FrameBitsPerRow)

TileTypes = GetCellTypes(fabric)

# The original plan was to do something super generic where tiles can be arbitrarily defined.
# However, that would have let into a heterogeneous/flat FPGA fabric as each tile may have different sets of wires to route.
# If we say that a wire is defined by/in its source cell then that implies how many wires get routed through adjacent neighbouring tiles.
# To keep things simple, we left this all out and the wiring between tiles is the same (for the first shot)

print('### Script command arguments are:\n' , str(sys.argv))

#Strip arguments
caseProcessedArguments = list(map(lambda x: x.strip(), sys.argv))
processedArguments = list(map(lambda x: x.lower(), caseProcessedArguments))
flagRE = re.compile("-\S*")

if ('-GenTileSwitchMatrixCSV'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate initial switch matrix template (has to be bootstrapped first)')
    for tile in TileTypes:
        print('### generate csv for tile ', tile, ' # filename:', (str(tile)+'_switch_matrix.csv'))
        TileFileHandler = open(str(tile)+'_switch_matrix.csv','w')
        TileInformation = GetTileFromFile(FabricFile,str(tile))
        BootstrapSwitchMatrix(TileInformation,str(tile),(str(tile)+'_switch_matrix.csv'))
        TileFileHandler.close()

if ('-GenTileSwitchMatrixVHDL'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate initial switch matrix VHDL code')
    for tile in TileTypes:
        print('### generate VHDL for tile ', tile, ' # filename:', (str(tile)+'_switch_matrix.vhdl'))
        TileFileHandler = open(str(tile)+'_switch_matrix.vhdl','w+')
        GenTileSwitchMatrixVHDL(tile,(str(tile)+'_switch_matrix.csv'),TileFileHandler)
        TileFileHandler.close()

if ('-GenTileSwitchMatrixVerilog'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate initial switch matrix Verilog code')
    for tile in TileTypes:
        print('### generate Verilog for tile ', tile, ' # filename:', (str(tile)+'_switch_matrix.v'))
        TileFileHandler = open(str(tile)+'_switch_matrix.v','w+')
        GenTileSwitchMatrixVerilog(tile,(str(tile)+'_switch_matrix.csv'),TileFileHandler)
        TileFileHandler.close()

if ('-GenTileConfigMemVHDL'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate all tile HDL descriptions')
    for tile in TileTypes:
        print('### generate configuration bitstream storage VHDL for tile ', tile, ' # filename:', (str(tile)+'_ConfigMem.vhdl'))
        # TileDescription = GetTileFromFile(FabricFile,str(tile))
        # TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
        # I tried various "from StringIO import StringIO" all not working - gave up
        TileFileHandler = open(str(tile)+'_ConfigMem.vhdl','w+')
        TileInformation = GetTileFromFile(FabricFile,str(tile))
        GenerateConfigMemVHDL(TileInformation,str(tile)+'_ConfigMem',TileFileHandler)
        TileFileHandler.close()

if ('-GenTileConfigMemVerilog'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    #print('### Generate all tile HDL descriptions')
    for tile in TileTypes:
        print('### generate configuration bitstream storage Verilog for tile ', tile, ' # filename:', (str(tile)+'_ConfigMem.v'))
        # TileDescription = GetTileFromFile(FabricFile,str(tile))
        # TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
        # I tried various "from StringIO import StringIO" all not working - gave up
        TileFileHandler = open(str(tile)+'_ConfigMem.v','w+')
        TileInformation = GetTileFromFile(FabricFile,str(tile))
        GenerateConfigMemVerilog(TileInformation,str(tile)+'_ConfigMem',TileFileHandler)
        TileFileHandler.close()

if ('-GenTileHDL'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate all tile HDL descriptions')
    for tile in TileTypes:
        print('### generate VHDL for tile ', tile, ' # filename:', (str(tile)+'_tile.vhdl'))
        # TileDescription = GetTileFromFile(FabricFile,str(tile))
        # TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
        # I tried various "from StringIO import StringIO" all not working - gave up
        TileFileHandler = open(str(tile)+'_tile.vhdl','w+')
        TileInformation = GetTileFromFile(FabricFile,str(tile))
        GenerateTileVHDL(TileInformation,str(tile),TileFileHandler)
        TileFileHandler.close()

if ('-GenTileVerilog'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    #print('### Generate all tile Verilog descriptions')
    for tile in TileTypes:
        print('### generate Verilog for tile ', tile, ' # filename:', (str(tile)+'_tile.v'))
        # TileDescription = GetTileFromFile(FabricFile,str(tile))
        # TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
        # I tried various "from StringIO import StringIO" all not working - gave up
        TileFileHandler = open(str(tile)+'_tile.v','w+')
        TileInformation = GetTileFromFile(FabricFile,str(tile))
        GenerateTileVerilog(TileInformation,str(tile),TileFileHandler)
        TileFileHandler.close()
    if SuperTileEnable:
        SuperTileDict = GetSuperTileFromFile(FabricFile)
        for SuperTile in SuperTileDict:
            if any(item in SuperTileDict[SuperTile][0] for item in TileTypes):
                print('### generate Verilog for SuperTile ', SuperTile, ' # filename:', (str(SuperTile)+'_tile.v'))
                TileFileHandler = open(str(SuperTile)+'_tile.v','w+')
                GenerateSuperTileVerilog(SuperTileDict[SuperTile],str(SuperTile),TileFileHandler)
                TileFileHandler.close()

if ('-GenFabricHDL'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate the Fabric VHDL descriptions')
    FileHandler = open('fabric.vhdl','w+')
    GenerateFabricVHDL(FabricFile,FileHandler)
    FileHandler.close()

if ('-GenFabricVerilog'.lower() in processedArguments) or ('-run_all'.lower() in processedArguments):
    print('### Generate the Fabric Verilog descriptions')
    FileHandler = open('fabric.v','w+')
    fabric_top = GenerateFabricVerilog(FabricFile,FileHandler)
    FileHandler.close()
    #w = open('eFPGA_top.v', "w+")
    #w.write(fabric_top)
    #w.close()

if ('-CSV2list'.lower() in processedArguments) or ('-AddList2CSV'.lower() in processedArguments):
    if ('-CSV2list'.lower() in processedArguments):
        argIndex = processedArguments.index('-CSV2list'.lower())
    else:
        argIndex = processedArguments.index('-AddList2CSV'.lower())

    if len(processedArguments) <= argIndex + 2:
        raise ValueError('\nError: -CSV2list and -AddList2CSV expect input and output file names but not enough arguments were provided.\n')
    elif (flagRE.match(caseProcessedArguments[argIndex + 1]) or flagRE.match(caseProcessedArguments[argIndex + 2])):
        raise ValueError(f'\nError: -CSV2list and -AddList2CSV expect input and output file names but instead found a flag: {caseProcessedArguments[argIndex + 1]}, {caseProcessedArguments[argIndex + 2]}.\n')        

    InFileName  = caseProcessedArguments[argIndex + 1]
    OutFileName  = caseProcessedArguments[argIndex + 2]

    if ('-CSV2list'.lower() in str(sys.argv).lower()):
        CSV2list(InFileName, OutFileName)
    if ('-AddList2CSV'.lower() in str(sys.argv).lower()):
        list2CSV(InFileName, OutFileName)

if ('-PrintCSV_FileInfo'.lower() in processedArguments):
    argIndex = processedArguments.index('-PrintCSV_FileInfo'.lower())
    if len(processedArguments) <= argIndex + 1:
        raise ValueError('\nError: -PrintCSV_FileInfo expects an input file name but not enough arguments were provided.\n')
    elif (flagRE.match(caseProcessedArguments[argIndex + 1])):
        raise ValueError(f'\nError: -PrintCSV_FileInfo expects an input file name but instead found a flag: {caseProcessedArguments[argIndex + 1]}.\n')        

    InFileName  = caseProcessedArguments[argIndex + 1]
    if ('-PrintCSV_FileInfo'.lower() in processedArguments):
        PrintCSV_FileInfo(InFileName)

if ('-GenNextpnrModel'.lower() in processedArguments) :
    fabricObject = genFabricObject(fabric)
    pipFile = open("npnroutput/pips.txt","w")
    belFile = open("npnroutput/bel.txt", "w")
    #pairFile = open("npnroutput/wirePairs.csv", "w")
    templateFile = open("npnroutput/template.v", "w")
    constraintFile = open("npnroutput/template.pcf", "w")

    npnrModel = genNextpnrModel(fabricObject, False)

    pipFile.write(npnrModel[0])
    belFile.write(npnrModel[1])
    templateFile.write(npnrModel[2])
    constraintFile.write(npnrModel[3])
    #pairFile.write(npnrModel[4])

    pipFile.close()
    belFile.close()
    templateFile.close()
    constraintFile.close()
    #pairFile.close()

if ('-GenNextpnrModel_pair'.lower() in processedArguments) :
    fabricObject = genFabricObject(fabric)
    pipFile = open("npnroutput/pips.txt","w")
    belFile = open("npnroutput/bel.txt", "w")
    pairFile = open("npnroutput/wirePairs.csv", "w")
    templateFile = open("npnroutput/template.v", "w")
    constraintFile = open("npnroutput/template.pcf", "w")

    npnrModel = genNextpnrModel(fabricObject)

    pipFile.write(npnrModel[0])
    belFile.write(npnrModel[1])
    templateFile.write(npnrModel[2])
    constraintFile.write(npnrModel[3])
    pairFile.write(npnrModel[4])

    pipFile.close()
    belFile.close()
    templateFile.close()
    constraintFile.close()
    pairFile.close()

if ('-GenVPRModel'.lower() in processedArguments):
    argIndex = processedArguments.index('-GenVPRModel'.lower())
    if len(processedArguments) <= argIndex + 1:
        raise ValueError('\nError: -GenVPRModel expects a custom XML file name but not enough arguments were provided.\n')
    elif (flagRE.match(caseProcessedArguments[argIndex + 1])):
        raise ValueError(f'\nError: -GenVPRModel expects a custom XML file name but instead found a flag: {caseProcessedArguments[argIndex + 1]}.\n')        

    customXmlFilename = caseProcessedArguments[argIndex + 1]

    fabricObject = genFabricObject(fabric)
    archFile = open("vproutput/architecture.xml","w")
    rrFile = open("vproutput/routing_resources.xml","w")

    archXML = genVPRModelXML(fabricObject, customXmlFilename, False)
    rrGraphXML = genVPRModelRRGraph(fabricObject, False)

    archFile.write(archXML)
    rrFile.write(rrGraphXML)

    archFile.close()
    rrFile.close()

    if ('-debug'.lower() in str(sys.argv).lower()) : 
        print(archXML)
        print(rrGraphXML)


if ('-GenBitstreamSpec'.lower() in processedArguments) :
    argIndex = processedArguments.index('-GenBitstreamSpec'.lower())
    if len(processedArguments) <= argIndex + 1:
        raise ValueError('\nError: -genBitstreamSpec expects an output file name but not enough arguments were provided.\n')
    elif (flagRE.match(caseProcessedArguments[argIndex + 1])):
        raise ValueError(f'\nError: -genBitstreamSpec expects an output file name but instead found a flag: {caseProcessedArguments[argIndex + 1]}.\n')        

    OutFileName  = caseProcessedArguments[argIndex + 1]

    fabricObject = genFabricObject(fabric)
    specObject = genBitstreamSpec(fabricObject)
    w = csv.writer(open(OutFileName.replace("txt","csv"), "w"))
    for key1 in specObject["TileSpecs"]:
        w.writerow([key1])
        for key2, val in specObject["TileSpecs"][key1].items():
            w.writerow([key2,val])

if ('-help'.lower() in processedArguments) or ('-h' in processedArguments):
    print('')
    print('Options/Switches')
    print('  -GenTileSwitchMatrixCSV    - generate initial switch matrix template (has to be bootstrapped first)')
    print('  -GenTileSwitchMatrixVHDL   - generate initial switch matrix VHDL code')
    print('  -GenTileHDL                - generate all tile VHDL descriptions')
    print('  -run_all                   - run the 3 previous steps in one go (more for debug)')
    print('  -CSV2list in.csv out.list  - translate a switch matrix adjacency matrix into a list (beg_port,end_port)')
    print('  -AddList2CSV in.list out.csv  - adds connctions from a list (beg_port,end_port) to a switch matrix adjacency matrix')
    print('  -PrintCSV_FileInfo foo.csv - prints input and oputput ports in csv switch matrix files')
    print('  -genNextpnrModel - generates a model for nextpnr in the npnroutput directory')
    print('  -genNextpnrModel_pair - generates a model for nextpnr in the npnroutput directory and wirePairs')
    print('  -genBitstreamSpec meta_data.txt - generates a bitstream spec for fasm parsing ')
    print('  -genBitstream template.fasm meta_data.txt bitstream.txt - generates a bitstream - the first file is the fasm file, the second is the bitstream spec and the third is the fasm file to write to')

    print('')
    print('Steps to use this script to produce an FPGA fabric:')
    print('  1) create/modify a fabric description (see fabric.csv as an example)')
    print('  2) create BEL primitives as VHDL code. ')
    print('     Use std_logic (not std_logic_vector) ports')
    print('     Follow the example in clb_slice_4xLUT4.vhdl')
    print('     Only one entity allowed in the file!')
    print('     If you use further components, they go into extra files.')
    print('     The file name and the entity should match.')
    print('     Ensure the top-level BEL VHDL-file is in your fabric description.')
    print('  3) run the script with the -GenTileSwitchMatrixCSV switch ')
    print('     This will eventually overwrite all old switch matrix csv-files!!!')
    print('  4) Edit the switch matrix adjacency (the switch matrix csv-files).')
    print('  5) run the script with the -GenTileSwitchMatrixVHDL switch ')
    print('     This will generate switch matrix VHDL files')
    print('  6) run the script with the -GenTileHDL switch ')
    print('     This will generate all tile VHDL files')
    print('  Note that the only manual VHDL code is implemented in 2) the rest is autogenerated!')

CLB = GetTileFromFile(FabricFile,'CLB')

# Inputs, Outputs = GetComponentPortsFromFile('clb_slice_4xLUT4.vhdl')
# print('GetComponentPortsFromFile Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPorts(CLB, 'SwitchMatrix')
# print('GetTileComponentPorts SwitchMatrix Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPorts(CLB, 'SwitchMatrixIndexed')
# print('GetTileComponentPorts SwitchMatrixIndexed Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPorts(CLB, 'all')
# print('GetTileComponentPorts all Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPorts(CLB, 'allIndexed')
# print('GetTileComponentPorts all Inputs:\n',Inputs,'\nOutputs\n',Outputs)

# print('####################################################################################')

# Inputs, Outputs = GetTileComponentPortsVectors(CLB, 'SwitchMatrix')
# print('GetTileComponentPorts SwitchMatrix Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPortsVectors(CLB, 'SwitchMatrixIndexed')
# print('GetTileComponentPorts SwitchMatrixIndexed Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPortsVectors(CLB, 'all')
# print('GetTileComponentPorts all Inputs:\n',Inputs,'\nOutputs\n',Outputs)
# Inputs, Outputs = GetTileComponentPortsVectors(CLB, 'allIndexed')
# print('GetTileComponentPorts all Inputs:\n',Inputs,'\nOutputs\n',Outputs)

# for i in range(1,10):
    # print('test',i,' log ',int(math.ceil(math.log2(i))))


# print('CLB tile: \n')
# for item in CLB:
    # print(item,'\n')

# CellTypes = GetCellTypes(fabric)
# print('myout: ',CellTypes)

# print('x_tiles ',x_tiles,' y_tiles ',y_tiles)

# print('fabric: \n')
# for item in fabric:
    # print(item,'\n')



