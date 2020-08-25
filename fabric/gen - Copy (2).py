# Python 3
from array import array
import re
import sys
from contextlib import redirect_stdout
from io import StringIO
import math
import os
import numpy
import configparser

# Default parameters (will be overwritten if defined in fabric between 'ParametersBegin' and 'ParametersEnd'
#Parameters = [ 'ConfigBitMode', 'FrameBitsPerRow' ]
ConfigBitMode = 'FlipFlopChain'
FrameBitsPerRow = '32'
MaxFramesPerCol = '20'
Package = 'use work.my_package.all;'

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

# take a list and remove all items that contain a #	and remove empty lines
def RemoveComments( list ):
	output = []
	
	for sublist in list:
		templist = []
		marker = False		# we use this marker to remember if we had an '#' element before
		for item in sublist:
			if item.startswith('#'):
				marker = True
			if not (item.startswith('#') or marker == True):
				# marker = True
				templist.append(item)
				if item == '':
					templist.remove('')
		if templist != []:
			output.append(templist)	
	return output;
	
def GetFabric( list, filter = 'Fabric' ):	
	templist = []
	# output = []
	marker = False
	
	for sublist in list:
		if filter+'End' in sublist:			# was FabricEnd
			marker = False
		if marker == True:
			templist.append(sublist)
		# we place this conditional after the append such that the 'FabricBegin' will be kicked out	
		if filter+'Begin' in sublist:		# was FabricBegin
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
		# the order of the if-statements are important
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
				ExternalPort = True
			else:
				ExternalPort = False
			# get rid of everything with and after the ';' that will also remove comments
			tmp_line = (re.sub(';.*', '',line, flags=re.IGNORECASE))
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
			if (port == 'internal') and (ExternalPort == False):
				if re.search(':in', tmp_line, flags=re.IGNORECASE):
					Inputs.append(BEL_Prefix+(re.sub(':in.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
				if re.search(':out', tmp_line, flags=re.IGNORECASE):
					Outputs.append(BEL_Prefix+(re.sub(':out.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
			# The following is for ports that have to go all the way up to the top-level entity (e.g., from an I/O cell)
			if (port == 'external') and (ExternalPort == True):
				# .lstrip() removes leading white spaces including ' ', '\t'
				ExternalPorts.append(BEL_Prefix+line.lstrip())
			
		if re.search('port', line, flags=re.IGNORECASE):
			marker = True
	if port == 'internal':			 # default
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
			if len(line) >= 3:		# we use the third column to specify an optional BEL prefix
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
	# result 	CLB,	N1END0, N1END1, N1END2, ...
	# result 	N1BEG0,	0,		0,		0, ...
	# result 	N1BEG1,	0,		0,		0, ...
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
	# stupid VHDL doesn't allow us to finish the last port signal declaration with a ';', so we pragmatically delete that if we have no config port
	if ConfigPort==False:
		# TODO: Test if this works correctly under Linux; there maybe an issue with DOS/Linux text file encoding...
		# TODO: Test if this works correctly under Linux; there maybe an issue with DOS/Linux text file encoding...
		# TODO: Test if this works correctly under Linux; there maybe an issue with DOS/Linux text file encoding...
		file.seek(0, os.SEEK_END)              		# seek to end of file; f.seek(0, 2) is legal
		file.seek(file.tell() - 3, os.SEEK_SET) 	# go backwards 3 bytes
		file.truncate()
		print('', file=file)
	print('\t-- global', file=file)
	if ConfigPort==True:
		if ConfigBitMode == 'FlipFlopChain':
			print('\t\t MODE\t: in \t STD_LOGIC;\t -- global signal 1: configuration, 0: operation', file=file)
			print('\t\t CONFin\t: in \t STD_LOGIC;', file=file)
			print('\t\t CONFout\t: out \t STD_LOGIC;', file=file)
			print('\t\t CLK\t: in \t STD_LOGIC', file=file)
		if ConfigBitMode == 'frame_based':
			# print('\t\t ConfigBits : in \t STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )', file=file)
			print('\t\t FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );', file=file)
			print('\t\t FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 )', file=file)
					 
	print('\t);', file=file)
	print('end entity',entity,';', file=file)
	print('', file=file)
	#   architecture 
	print('architecture Behavioral of ',entity,' is ', file=file)
	print('', file=file)
	return
	
def GenerateVHDL_Conf_Instantiation ( file, counter, close=True ):
	print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
	print('\t\t MODE	=> Mode,  ', file=file)
	print('\t\t CONFin	=> conf_data('+str(counter)+'),  ', file=file)
	print('\t\t CONFout	=> conf_data('+str(counter+1)+'),  ', file=file)
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
			if len(line) >= 3:		# we use the third column to specify an optional BEL prefix
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
					print('\t\t',re.sub('.*BEL_prefix_string_marker', '', item), file=file)
					SharedExternalPorts.append(shared_port)
			else:
				print('\t\t',re.sub('BEL_prefix_string_marker', '', item), file=file)
	# the rest is a shared text block
	GenerateVHDL_EntityFooter(file, entity)
	
	# insert CLB, I/O (or whatever BEL) component declaration 
	# specified in the fabric csv file after the 'BEL' key word
	BEL_VHDL_riles_processed = []	 # we use this list to check if we have seen a BEL description before so we only insert one component declaration
	for line in tile_description:
		if line[0] == 'BEL':
			Inputs = []
			Outputs = []
			if line[VHDL_file_position] not in BEL_VHDL_riles_processed:
				PrintComponentDeclarationForFile(line[VHDL_file_position], file)
			BEL_VHDL_riles_processed.append(line[VHDL_file_position])
			# we need the BEL ports (a little later) so we take them on the way
			if len(line) >= 3:		# we use the third column to specify an optional BEL prefix
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
	print('signal\t'+'conf_data'+'\t:\tSTD_LOGIC_VECTOR('+str(BEL_counter+NuberOfSwitchMatricesWithConfigPort)+' downto 0);', file=file)
	
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

	# BEL component instantiations
	print('\n-- BEL component instantiations\n', file=file)
	All_BEL_Inputs = []				# the right hand signal name which gets a BEL prefix
	All_BEL_Outputs = []			# the right hand signal name which gets a BEL prefix
	left_All_BEL_Inputs = []		# the left hand port name which does not get a BEL prefix
	left_All_BEL_Outputs = []		# the left hand port name which does not get a BEL prefix
	BEL_counter = 0
	BEL_ConfigBitsCounter = 0
	for line in tile_description:
		if line[0] == 'BEL':
			BEL_Inputs = []			# the right hand signal name which gets a BEL prefix
			BEL_Outputs = []		# the right hand signal name which gets a BEL prefix
			left_BEL_Inputs = []	# the left hand port name which does not get a BEL prefix
			left_BEL_Outputs = []	# the left hand port name which does not get a BEL prefix
			ExternalPorts = []
			if len(line) >= 3:		# we use the third column to specify an optional BEL prefix
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
						print('\t\t ConfigBits => (others => \'-\') );\n', file=file)
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
					# print('\t\t MODE	=> Mode,  ', file=file)
					# print('\t\t CONFin	=> conf_data('+str(BEL_counter)+'),  ', file=file)
					# print('\t\t CONFout	=> conf_data('+str(BEL_counter+1)+'),  ', file=file)
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
			one_line.append('1' * FrameBitsPerRow)
			one_line.append(str(BitsLeftToPackInFrames-1)+':'+str(BitsLeftToPackInFrames-FrameBitsPerRow))
			BitsLeftToPackInFrames = BitsLeftToPackInFrames - FrameBitsPerRow
		else:
			one_line.append(str(BitsLeftToPackInFrames))
			# generate a string encoding a '1' for each flop used 
			# this will allow us to kick out flops in the middle (e.g. for alignment padding)
			one_line.append('1' * BitsLeftToPackInFrames + '0' * (FrameBitsPerRow-BitsLeftToPackInFrames))
			if BitsLeftToPackInFrames > 0:
				one_line.append(str(BitsLeftToPackInFrames-1)+':0')
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
	UsedFrames = []				# keeps track about the frames that are actually used
	AllConfigBitsOrder = []		# stores a list of ConfigBits indices in exactly the order defined in the rage statements in the frames
	for line in MappingFile:
		bits_used_in_frame = line[used_bits_mask].count('1')
		if bits_used_in_frame > 0:
			print('signal '+line[frame_name]+' \t:\t STD_LOGIC_VECTOR( '+str(bits_used_in_frame)+' -1 downto 0);', file=file)
			UsedFrames.append(line[frame_index])
		
		# The actual ConfigBits are given as address ranges starting at position ConfigBits_ranges
		ConfigBitsOrder = []
		for RangeItem in line[ConfigBits_ranges:]:
			if ':' in RangeItem:		# we have a range
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
				raise ValueError('Range '+str(RangeItem)+' cannot be resolved for frame : '+line[frame_name])
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
		for k in range(FrameBitsPerRow):
			if used_bits[k] == '1':
				print('Inst_'+MappingFile[int(frame)][int(frame_name)]+'_bit'+str(k)+'  : LHQD1'          , file=file)
				print('Port Map ('          , file=file)
				print('\t D \t=>\t FrameData('+str(k)+'), '      , file=file)
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
	# sanity check if we have the right CSV file
	if tile != CSVFile[0][0]:
		raise ValueError('top left element in CSV file does not match tile type in function GenTileSwitchMatrixVHDL')
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

#	print('debug', file=file)
#
#	mux_size_list = []
#	ConfigBitsCounter = 0
#	for line in CSVFile[1:]:
#		# we first count the number of multiplexer inputs
#		mux_size=0
#		for port in line[1:]:
#			# print('debug: ',port)
#			if port != '0':
#				mux_size += 1
#		mux_size_list.append(mux_size)
#		if mux_size >= 2:
#			print('signal \t ',line[0]+'_input','\t:\t std_logic_vector(',str(mux_size),'- 1 downto 0 );', file=file) 
#			# "mux_size" tells us the number of mux inputs and "int(math.ceil(math.log2(mux_size)))" the number of configuration bits
#			# we count all bits needed to declare a corresponding shift register
#			ConfigBitsCounter = ConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
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
			print( 				'-- the configuration bits shift register                                    ' , file=file)
			print( 				'process(CLK)                                                                ' , file=file)
			print( 				'begin                                                                       ' , file=file)
			print( '\t'+			'if CLK\'event and CLK=\'1\' then                                        ' , file=file)
			print( '\t'+'\t'+			'if mode=\'1\' then	--configuration mode                             ' , file=file)
			print( '\t'+'\t'+'\t'+			'ConfigBits <= CONFin & ConfigBits(ConfigBits\'high downto 1);   ' , file=file)
			print( '\t'+'\t'+			'end if;                                                             ' , file=file)
			print( '\t'+			'end if;                                                                 ' , file=file)
			print( 				'end process;                                                                ' , file=file)
			print( 				'CONFout <= ConfigBits(ConfigBits\'high);                                    ' , file=file)
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
			print( '\t'+          '	inst_LHQD1a : LHQD1              '                                          , file=file)
			print( '\t'+ '\t'+          'Port Map(              '                                               , file=file)
			print( '\t'+ '\t'+          'D    => ConfigBitsInput(k*2),              '                           , file=file)
			print( '\t'+ '\t'+          'E    => CLK,               '                                           , file=file)
			print( '\t'+ '\t'+          'Q    => ConfigBits(k*2) );                 '                           , file=file)
			print(          '              '                                                                    , file=file)
			print( '\t'+          '	inst_LHQD1b : LHQD1              '                                          , file=file)
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
						print(';', file=file)
					else:
						print(' & ',end='', file=file)					
			# int(math.ceil(math.log2(inputs_so_far))) tells us how many configuration bits a multiplexer takes
			old_ConfigBitstreamPosition = ConfigBitstreamPosition
			ConfigBitstreamPosition = ConfigBitstreamPosition +	int(math.ceil(math.log2(inputs_so_far)))

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
			if mux_size == 4:
				MuxComponentName = 'MUX4PTv4'
			if mux_size == 16:
				MuxComponentName = 'MUX16PTv2'
			if mux_size == 4 or mux_size == 16:			
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
			else:		# generic multiplexer
				# VHDL example arbitrary mux
				# J_l_AB_BEG1	<= J_l_AB_BEG1_input(TO_INTEGER(ConfigBits(363 downto 362)));
				print(line[0]+'\t<= '+line[0]+'_input(',end='', file=file) 
				print('TO_INTEGER(UNSIGNED(ConfigBits('+str(ConfigBitstreamPosition-1)+' downto '+str(old_ConfigBitstreamPosition)+'))));', file=file) 
				print(' ', file=file)
			
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
	
	GenerateVHDL_Header(file, entity)
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
		for y in range(y_tiles):
			for x in range(x_tiles):
				if (fabric[y][x]) != 'NULL':
					TileConfigBits = GetNoConfigBitsFromFile(str(fabric[y][x])+'_tile.vhdl')
					if TileConfigBits != 'NULL' and int(TileConfigBits) != 0:
						print('signal Tile_X'+str(x)+'Y'+str(y)+'_ConfigBits \t:\t std_logic_vector('+TileConfigBits+' -1 downto '+str(0)+' );', file=file)
	
	print('\n-- tile-to-tile signal declarations\n', file=file)
	for y in range(y_tiles):
		for x in range(x_tiles):
			if (fabric[y][x]) != 'NULL':
				# get the top dimension index that describes the tile type (given by fabric[y][x])
				for line in TileTypeOutputPorts[TileTypes.index(fabric[y][x])]:
					# line contains something like "E2BEG : std_logic_vector( 7 downto 0 )" so I use split on '('
					SignalName, Vector = re.split('\(',line) 
					print('signal Tile_X'+str(x)+'Y'+str(y)+'_'+SignalName+'\t:\t std_logic_vector('+Vector+';', file=file)

	# VHDL architecture body
	print('\nbegin\n', file=file)	
	
	# top configuration data daisy chaining
	# this is copy and paste from tile code generation (so we can modify this here without side effects
	if ConfigBitMode == 'FlipFlopChain':
		print('-- top configuration data daisy chaining', file=file)
		print('conf_data(conf_data\'low) <= CONFin; -- conf_data\'low=0 and CONFin is from tile entity', file=file)
		print('CONFout <= conf_data(conf_data\'high); -- CONFout is from tile entity', file=file)

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

				if (fabric[y][x]) != 'NULL':	# looks like this conditional is redundant 
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
				
				if (fabric[y][x]) != 'NULL':	# looks like this conditional is redundant 
					for k in range(0,len(TileInputs)):
						PortName = re.sub('\(.*', '', TileInputs[k])
						print('\t'+PortName+'\t=> '+TileInputSignal[k]+',',file=file)
						# print('DEBUG_INPUT: '+PortName+'\t=> '+TileInputSignal[k]+',')
					for k in range(0,len(TileOutputs)):
						PortName = re.sub('\(.*', '', TileOutputs[k])
						print('\t'+PortName+'\t=> '+TileOutputSignal[k]+',',file=file)
						# print('DEBUG_OUTPUT: '+PortName+'\t=> '+TileOutputSignal[k]+',')

#				TileSignals = TileInputSignal+TileOutputSignal
#				for port in TilePorts:
#					if ('-Debug'.lower() in str(sys.argv).lower()):
#						TilePortsDebugString = '\t-- ' + TilePortsDebug[(TilePorts.index(port))] 
#					else:
#						TilePortsDebugString = ''
#					print('\t\t',port,' => ',TileSignals[(TilePorts.index(port))],','+TilePortsDebugString, file=file)	
				
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
								print('\t\t ConfigBits => (others => \'-\') );\n', file=file)
							else:
								print('\t\t ConfigBits => ConfigBits ( '+str(TileConfigBits)+' -1 downto '+str(0)+' ) );\n', file=file)
								# BEL_ConfigBitsCounter = BEL_ConfigBitsCounter + int(BEL_ConfigBits)
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
#			raise ValueError('\nError: input file list uses an input port that does not exist in the CSV table\n')
	# ... and that all ports of UniqInFileOutputPorts must exist in OutFileOutputPorts
	for port in UniqInFileOutputPorts:
		if port not in OutFileOutputPorts:
			print('\nError: input file list uses an output port', port, ' that does not exist in the CSV table\n')
#			raise ValueError('\nError: input file list uses an output port that does not exist in the CSV table\n')
		
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
	# finally overwrite switch matrix CSV file
	tmp = numpy.asarray(OutFile)
	numpy.savetxt(OutFileName, tmp, fmt='%s', delimiter=",")
	return
	
	
	
	
	
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
	else:
		raise ValueError('\nError: unknown parameter "'+item[0]+'" in fabric csv at section ParametersBegin\n')

	
### # from StackOverflow  config.get("set", "var_name") 
### #ConfigBitMode	frame_based
### # config.get("frame_based", "ConfigBitMode")
### config = ConfigParser.ConfigParser()
### config.read("fabric.ini")
### var_a = config.get("myvars", "var_a")
### var_b = config.get("myvars", "var_b")
### var_c = config.get("myvars", "var_c")
print('DEBUG Parameters: ',ConfigBitMode, FrameBitsPerRow)

TileTypes = GetCellTypes(fabric)



# The original plan was to do something super generic where tiles can be arbitrarily defined.
# However, that would have let into a heterogeneous/flat FPGA fabric as each tile may have different sets of wires to route.
# If we say that a wire is defined by/in its source cell then that implies how many wires get routed through adjacent neighbouring tiles.
# To keep things simple, we left this all out and the wiring between tiles is the same (for the first shot)

print('### Script command arguments are:\n' , str(sys.argv))


if ('-GenTileSwitchMatrixCSV'.lower() in str(sys.argv).lower()) or ('-run_all'.lower() in str(sys.argv).lower()):
	print('### Generate initial switch matrix template (has to be bootstrapped first)')	
	for tile in TileTypes:
		print('### generate csv for tile ', tile, ' # filename:', (str(tile)+'_switch_matrix.csv'))	
		TileFileHandler = open(str(tile)+'_switch_matrix.csv','w')
		TileInformation = GetTileFromFile(FabricFile,str(tile))
		BootstrapSwitchMatrix(TileInformation,str(tile),(str(tile)+'_switch_matrix.csv'))
		TileFileHandler.close()
		
if ('-GenTileSwitchMatrixVHDL'.lower() in str(sys.argv).lower()) or ('-run_all'.lower() in str(sys.argv).lower()):
	print('### Generate initial switch matrix VHDL code')	
	for tile in TileTypes:
		print('### generate VHDL for tile ', tile, ' # filename:', (str(tile)+'_switch_matrix.vhdl'))	
		TileFileHandler = open(str(tile)+'_switch_matrix.vhdl','w')
		GenTileSwitchMatrixVHDL(tile,(str(tile)+'_switch_matrix.csv'),TileFileHandler)
		TileFileHandler.close()		

if ('-GenTileConfigMemVHDL'.lower() in str(sys.argv).lower()) or ('-run_all'.lower() in str(sys.argv).lower()):
	print('### Generate all tile HDL descriptions')	
	for tile in TileTypes:
		print('### generate configuration bitstream storage VHDL for tile ', tile, ' # filename:', (str(tile)+'_ConfigMem.vhdl'))	
		# TileDescription = GetTileFromFile(FabricFile,str(tile))
		# TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
		# I tried various "from StringIO import StringIO" all not working - gave up
		TileFileHandler = open(str(tile)+'_ConfigMem.vhdl','w')
		TileInformation = GetTileFromFile(FabricFile,str(tile))
		GenerateConfigMemVHDL(TileInformation,str(tile)+'_ConfigMem',TileFileHandler)
		TileFileHandler.close()

if ('-GenTileHDL'.lower() in str(sys.argv).lower()) or ('-run_all'.lower() in str(sys.argv).lower()):
	print('### Generate all tile HDL descriptions')	
	for tile in TileTypes:
		print('### generate VHDL for tile ', tile, ' # filename:', (str(tile)+'_tile.vhdl'))	
		# TileDescription = GetTileFromFile(FabricFile,str(tile))
		# TileVHDL_list = GenerateTileVHDL_list(FabricFile,str(tile))
		# I tried various "from StringIO import StringIO" all not working - gave up
		TileFileHandler = open(str(tile)+'_tile.vhdl','w')
		TileInformation = GetTileFromFile(FabricFile,str(tile))
		GenerateTileVHDL(TileInformation,str(tile),TileFileHandler)
		TileFileHandler.close()

if ('-GenFabricHDL'.lower() in str(sys.argv).lower()) or ('-run_all'.lower() in str(sys.argv).lower()):
	print('### Generate the Fabric VHDL descriptions')	
	FileHandler = open('fabric.vhdl','w')
	GenerateFabricVHDL(FabricFile,FileHandler)
	FileHandler.close()

if ('-CSV2list'.lower() in str(sys.argv).lower()) or ('-AddList2CSV'.lower() in str(sys.argv).lower()):
	arguments = re.split(' ',str(sys.argv))
	# index was not working...
	i = 0
	for item in arguments:
		# print('debug',item)
		if re.search('-CSV2list', arguments[i], flags=re.IGNORECASE) or re.search('-AddList2CSV', arguments[i], flags=re.IGNORECASE):
			break
		i += 1
	if arguments[i+2] == '':
		raise ValueError('\nError: -CSV2list and -AddList2CSV expect two file names\n')
	# stupid python adds quotes ' ' around the file name and a ',' -- bizarre 
	substitutions = {",": "", "\'": "", "\]": "", "\[": ""}
	# InFileName  = (replace(arguments[i+1], substitutions))
	# don't ask me why I have to delete the stupid '['...; but at least works now
	InFileName  = re.sub('\]','',re.sub('\'','',(replace(arguments[i+1], substitutions))))
	OutFileName = re.sub('\]','',re.sub('\'','',(replace(arguments[i+2], substitutions))))
	if ('-CSV2list'.lower() in str(sys.argv).lower()):
		CSV2list(InFileName, OutFileName)
	if ('-AddList2CSV'.lower() in str(sys.argv).lower()):
		list2CSV(InFileName, OutFileName)

if ('-PrintCSV_FileInfo'.lower() in str(sys.argv).lower()) :
	arguments = re.split(' ',str(sys.argv))
	# index was not working...
	i = 0
	for item in arguments:
		# print('debug',item)
		if re.search('-PrintCSV_FileInfo', arguments[i], flags=re.IGNORECASE):
			break
		i += 1
	if arguments[i+1] == '':
		raise ValueError('\nError: -PrintCSV_FileInfo expect a file name\n')
	# stupid python adds quotes ' ' around the file name and a ',' -- bizarre 
	substitutions = {",": "", "\'": "", "\]": "", "\[": ""}
	# InFileName  = (replace(arguments[i+1], substitutions))
	# don't ask me why I have to delete the stupid '['...; but at least works now
	InFileName  = re.sub('\]','',re.sub('\'','',(replace(arguments[i+1], substitutions))))
	if ('-PrintCSV_FileInfo'.lower() in str(sys.argv).lower()):
		PrintCSV_FileInfo(InFileName)



if ('-help'.lower() in str(sys.argv).lower()) or ('-h' in str(sys.argv).lower()):
	print('')	
	print('Options/Switches')	
	print('  -GenTileSwitchMatrixCSV    - generate initial switch matrix template (has to be bootstrapped first)')	
	print('  -GenTileSwitchMatrixVHDL   - generate initial switch matrix VHDL code')	
	print('  -GenTileHDL                - generate all tile VHDL descriptions')	
	print('  -run_all                   - run the 3 previous steps in one go (more for debug)')	
	print('  -CSV2list in.csv out.list  - translate a switch matrix adjacency matrix into a list (beg_port,end_port)')	
	print('  -AddList2CSV in.list out.csv  - adds connctions from a list (beg_port,end_port) to a switch matrix adjacency matrix')	
	print('  -PrintCSV_FileInfo foo.csv - prints input and oputput ports in csv switch matrix files')	
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
	


