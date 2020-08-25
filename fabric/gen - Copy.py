from array import array
import re
import sys
from contextlib import redirect_stdout
from io import StringIO
import math

# TILE field aliases 
direction = 0
source_name = 1
X_offset = 2
Y_offset = 3
destination_name = 4
wires = 5
# columns where VHDL file is specified
VHDL_file_position=1
TileType_position=1

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
	
def GetFabric( list ):	
	templist = []
	# output = []
	marker = False
	
	for sublist in list:
		if 'FabricEnd' in sublist:
			marker = False
		if marker == True:
			templist.append(sublist)
		# we place this conditional after the append such that the 'FabricBegin' will be kicked out	
		if 'FabricBegin' in sublist:
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
	# VHDLfile = [i.strip('\n').split('Ö') for i in open(VHDL_file_name)]
	# VHDLfile = [i.strip('\n').split(' ') for i in open(VHDL_file_name)]
	# VHDLfile = [i.replace('\t', ' ').strip('\n').split(' ') for i in open(VHDL_file_name)]
	# with open(VHDL_file_name) as f:
		# VHDLfile = f.readlines()
	VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
	templist = []
	marker = False
	# for item in VHDLfile:
		# print(item)
	for line in VHDLfile:
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
	return

def GetComponentPortsFromFile( VHDL_file_name, filter ='ALL' ):
	VHDLfile = [line.rstrip('\n') for line in open(VHDL_file_name)]
	Inputs = []
	Outputs = []
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

		# if re.search('end ', line, flags=re.IGNORECASE):
		# all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
		if re.search('-- global', line, flags=re.IGNORECASE):
			FoundEntityMarker = False
			marker = False
			DoneMarker = True
			
		if (marker == True) and (DoneMarker == False) and (direction == filter or filter == 'ALL') :
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
			# print(replace(tmp_line, substitutions))
			if re.search(':in', tmp_line, flags=re.IGNORECASE):
				Inputs.append((re.sub(':in.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
			if re.search(':out', tmp_line, flags=re.IGNORECASE):
				Outputs.append((re.sub(':out.*', '', tmp_line, flags=re.IGNORECASE))+std_vector)
				
		if re.search('port', line, flags=re.IGNORECASE):
			marker = True
	return Inputs, Outputs

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
	mode = 'SwitchMatrix'
	for line in tile_description:
		if (line[direction] in ['NORTH','EAST','SOUTH','WEST']):
			# print('debug inner:'+str(line[direction])+':'+str(line[source_name])+':'+str(line[destination_name]))
			if (line[source_name] == 'NULL' or line[destination_name] == 'NULL'):
				mode = 'all'
	# I tried rewriting GetTileComponentPorts to offer an auto mode that would for each line decide between 
	# 'SwitchMatrix' and 'all' but that failed
	# TODO: auto switch matrix population
	# Inputs, Outputs = GetTileComponentPorts(tile_description, 'SwitchMatrix')
	Inputs, Outputs = GetTileComponentPorts(tile_description, mode)
	# get all >>BEL ports<<< as defined by the BELs from the VHDL files
	for line in tile_description:
		if line[0] == 'BEL':
			tmp_Inputs = []
			tmp_Outputs = []
			tmp_Inputs, tmp_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
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
			tmp_Inputs = []
			tmp_Outputs = []
			for k in range(int(line[wires])):
				Inputs.append(str(line[destination_name])+str(k))
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
	import numpy
	# tmp = array.zeros((NumberOfInputs+1,NumberOfOutputs+1)) #np.zeros(20).reshape(NumberOfInputs,NumberOfOutputs)
	# array = np.array([(1,2,3), (4,5,6)])
	tmp = numpy.asarray(result)
	# numpy.savetxt("foo.csv", tmp, delimiter=",")
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
				print('\t -- wires: ', line[wires], file=file) 
	for line in tile_description:
		if line[0] == direction:
			if line[destination_name] != 'NULL':
				print('\t\t',line[destination_name], '\t: in \tSTD_LOGIC_VECTOR( ', end='', file=file)
				print(((abs(int(line[X_offset]))+abs(int(line[Y_offset])))*int(line[wires]))-1, end='', file=file)
				print(' downto 0 );', end='', file=file) 
				print('\t -- wires: ', line[wires], file=file) 
	return

def GetTileComponentPorts( tile_description, mode):
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
			# range ((wires*distance)-1 downto 0) as connected to the tile top
			if mode in ['all','allIndexed','Top','TopIndexed']:
				ThisRange = (abs(int(line[X_offset]))+abs(int(line[Y_offset]))) * int(line[wires])
			# the following three lines are needed to get the top line[wires] that are actually the connection from a switch matrix to the routing fabric
			StartIndex = 0
			if mode in ['Top','TopIndexed']:
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
	
def GenerateVHDL_Header( file, entity ):
	#   library template
	print('library IEEE;', file=file)
	print('use IEEE.STD_LOGIC_1164.ALL;', file=file)
	print('use IEEE.NUMERIC_STD.ALL;', file=file)
	print('', file=file)
	#   entity
	print('entity ',entity,' is ', file=file)
	print('\tPort (', file=file)	
	return

def GenerateVHDL_EntityFooter ( file, entity ):
	print('\t-- global', file=file)
	print('\t\t MODE\t: in \t STD_LOGIC;\t -- global signal 1: configuration, 0: operation', file=file)
	print('\t\t CONFin\t: in \t STD_LOGIC;', file=file)
	print('\t\t CONFout\t: out \t STD_LOGIC;', file=file)
	print('\t\t CLK\t: in \t STD_LOGIC', file=file)
	print('\t);', file=file)
	print('end entity',entity,';', file=file)
	print('', file=file)
	#   architecture 
	print('architecture Behavioral of ',entity,' is ', file=file)
	print('', file=file)
	return
	
def GenerateTileVHDL( tile_description, entity, file ):	
	MatrixInputs = []
	MatrixOutputs = []
	TileInputs = []
	TileOutputs = []
	BEL_Inputs = []
	BEL_Outputs = []
	AllJumpWireList = []
	
	TileTypeMarker = False
	for line in tile_description:
		if line[0] == 'TILE':
			TileType = line[TileType_position]
			TileTypeMarker = True
	if TileTypeMarker == False:
		raise ValueError('Could not find tile type in function GenerateTileVHDL')

		# the VHDL intial header generation is shared until the Port
	GenerateVHDL_Header(file, entity)
	PrintTileComponentPort (tile_description, entity, 'NORTH', file)
	PrintTileComponentPort (tile_description, entity, 'EAST', file)
	PrintTileComponentPort (tile_description, entity, 'SOUTH', file)
	PrintTileComponentPort (tile_description, entity, 'WEST', file)
	# this is a shared text block
	GenerateVHDL_EntityFooter(file, entity)
	
	# insert CLB, I/O (or whatever BEL) component declaration 
	# specified in the fabric csv file after the 'BEL' key word
	for line in tile_description:
		if line[0] == 'BEL':
			Inputs = []
			Outputs = []
			PrintComponentDeclarationForFile(line[VHDL_file_position], file)
			# we need the BEL ports (a little later)
			Inputs, Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
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
			PrintComponentDeclarationForFile(line[VHDL_file_position], file)
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
	# tile top-level routing signals
	print('-- Tile ports (the signals to wire all tile top-level routing signals)', file=file)
	TileInputs, TileOutputs = GetTileComponentPortsVectors( tile_description, 'all' )
	for SignalVector in (TileInputs + TileOutputs):
		print('signal\t'+'sig'+re.sub('\(.*', '', SignalVector)+'\t:\tSTD_LOGIC_VECTOR'+re.sub('^.*\(', '(', SignalVector)+';', file=file)
	# Jump wires
	print('-- jump wires', file=file)
	for line in tile_description:
		if line[0] == 'JUMP':
			if (line[source_name] == '') or (line[destination_name] == ''):
				raise ValueError('Either source or destination port for JUMP wire missing in function GenerateTileVHDL')
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
	print('signal\t'+'conf_data'+'\t:\tSTD_LOGIC_VECTOR('+str(BEL_counter+1)+' downto 0);', file=file)
	
	#   architecture body
	print('\n'+'begin'+'\n', file=file)

	# Cascading of routing for wires spanning more than one tile
	print('-- Cascading of routing for wires spanning more than one tile', file=file)
	for line in tile_description:
		if line[0] in ['NORTH','EAST','SOUTH','WEST']:
			span=abs(int(line[X_offset]))+abs(int(line[Y_offset]))
			# in case a signal spans 2 ore more tiles in any direction
			if (span >= 2) and (line[source_name] != 'NULL') and (line[destination_name] != 'NULL'):
				print(line[source_name]+'('+line[source_name]+'\'high - '+str(line[wires])+' downto 0)',end='', file=file)
				print(' <= '+line[destination_name]+'('+line[destination_name]+'\'high downto '+str(line[wires])+');', file=file)
	
	# top configuration data daisy chaining
	print('-- top configuration data daisy chaining', file=file)
	print('conf_data(conf_data\'low) <= CONFin; -- conf_data\'low=0 and CONFin is from tile entity', file=file)
	print('CONFout <= conf_data(conf_data\'high); -- CONFout is from tile entity', file=file)

	# BEL component instantiations
	print('\n-- BEL component instantiations\n', file=file)
	All_BEL_Inputs = []
	All_BEL_Outputs = []
	BEL_counter = 0
	for line in tile_description:
		if line[0] == 'BEL':
			BEL_Inputs = []
			BEL_Outputs = []
			BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
			# we remember All_BEL_Inputs and All_BEL_Outputs as wee need these pins for the switch matrix
			All_BEL_Inputs = All_BEL_Inputs + BEL_Inputs
			All_BEL_Outputs = All_BEL_Outputs + BEL_Outputs
			EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
			print('Inst_'+EntityName+' : '+EntityName, file=file)
			print('\tPort Map(', file=file)
			for port in BEL_Inputs + BEL_Outputs:
				print('\t\t',port,' => ',port,',', file=file)
			print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
			print('\t\t MODE	=> Mode,  ', file=file)
			print('\t\t CONFin	=> conf_data('+str(BEL_counter)+'),  ', file=file)
			print('\t\t CONFout	=> conf_data('+str(BEL_counter+1)+'),  ', file=file)
			print('\t\t CLK => CLK );  ', file=file)
			print('', file=file)
			# for the next BEL (if any) for cascading configuration chain (this information is also needed for chaining the switch matrix)
			BEL_counter += 1

	# switch matrix component instantiation
	# important to know:
	# Each switch matrix entity is build up is a specific order:
	# 1.a) interconnect wire INPUTS (in the order defined by the fabric file,)
	# 2.a) BEL primitive INPUTS (in the order the BEL-VHDLs are listed in the fabric CSV)
	#      within each BEL, the order from the entity is maintained 
	# 3.a) JUMP wire INPUTS (in the order defined by the fabric file) 
	# 1.b) interconnect wire OUTPUTS
	# 2.b) BEL primitive OUTPUTS
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
			Inputs, Outputs = GetTileComponentPorts(tile_description, 'SwitchMatrixIndexed')
			TopInputs, TopOutputs = GetTileComponentPorts(tile_description, 'TopIndexed')
			for k in range(len(BEL_Inputs+BEL_Outputs)):
				print('\t\t',(BEL_Inputs+BEL_Outputs)[k],' => ',end='', file=file)
				# note that the BEL outputs (e.g., from the slice component) are the switch matrix inputs
				print((Inputs+All_BEL_Outputs+AllJumpWireList+TopOutputs+All_BEL_Inputs+AllJumpWireList)[k],',', file=file)
				
##########################################################################################################
# TODO: Each BEL should get an individual name 
# This would be added as a name prefix to BEL instantiations and BEL signal names and correspondingly ports at the switch matrix
# This would allow instantiating the same BEL multiple times.
# Currently we have to do this manually, no big deal, but it would mean for 2 instances of clb_slice_4xLUT4.vhdl that:
# we have to use two different files, with corresponding different entity names 
# and - except the configuration/clock interface - no port names are allowed to collide with other port names
##########################################################################################################

			print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
			print('\t\t MODE	=> Mode,  ', file=file)
			print('\t\t CONFin	=> conf_data('+str(BEL_counter)+'),  ', file=file)
			print('\t\t CONFout	=> conf_data('+str(BEL_counter+1)+'),  ', file=file)
			print('\t\t CLK => CLK );  ', file=file)
	print('\n'+'end Behavioral;'+'\n', file=file)
	return	
	
def GenTileSwitchMatrixVHDL( tile, CSV_FileName, file ):
	print('### Read ',str(tile),' csv file ###')
	CSVFile = [i.strip('\n').split(',') for i in open(CSV_FileName)]
	# sanity check if we have the right CSV file
	if tile != CSVFile[0][0]:
		raise ValueError('top left element in CSV file does not match tile type in function GenTileSwitchMatrixVHDL')
	# VHDL header
	entity = tile+'_switch_matrix'
	GenerateVHDL_Header(file, entity)
	# input ports
	print('\t\t -- switch matrix inputs', file=file)
	# CSVFile[0][1:]:   starts in the first row from the second element
	for port in CSVFile[0][1:]:
		print('\t\t ',port,'\t: in \t STD_LOGIC;', file=file)
	# output ports
	for line in CSVFile[1:]:
		print('\t\t ',line[0],'\t: out \t STD_LOGIC;', file=file)
	# this is a shared text block finishes the header and adds configuration port
	GenerateVHDL_EntityFooter(file, entity)
	
	mux_size_list = []
	ConfigBitsCounter = 0
	# signal declaration
	for line in CSVFile[1:]:
		# we first count the number of multiplexer inputs
		mux_size=0
		for port in line[1:]:
			# print('debug: ',port)
			if port != '0':
				mux_size += 1
		mux_size_list.append(mux_size)
		if mux_size >= 2:
			print('signal \t ',line[0]+'_input','\t:\t std_logic_vector(',str(mux_size),'- 1 downto 0 );', file=file) 
			# "mux_size" tells us the number of mux inputs and "int(math.ceil(math.log2(mux_size)))" the number of configuration bits
			# we count all bits needed to declare a corresponding shift register
			ConfigBitsCounter = ConfigBitsCounter + int(math.ceil(math.log2(mux_size)))
	print('\n-- The configuration bits are just a long shift register', file=file) 
	print('signal \t ConfigBits :\t unsigned( '+str(ConfigBitsCounter)+'-1 downto 0 );', file=file) 

	# begin architecture
	print('\nbegin\n', file=file)
	
	# the configuration bits shift register
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
				if port != '0':
					print(line[0],'\t <= \t', CSVFile[0][port_index],';', file=file)

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
			print(line[0]+'\t<= '+line[0]+'_input(',end='', file=file) 
			print('TO_INTEGER(ConfigBits('+str(ConfigBitstreamPosition-1)+' downto '+str(old_ConfigBitstreamPosition)+')));', file=file) 
			print(' ', file=file)
	# just the final end of architecture
	print('\n'+'end architecture Behavioral;'+'\n', file=file)
	return
	
def GenerateFabricVHDL( FabricFile, file ):
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
	entity = 'eFPGA'
	GenerateVHDL_Header(file, entity)
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
	tile_counter = 0
	for y in range(y_tiles):
		for x in range(x_tiles):
			# for the moment, we assume that all non "NULL" tiles are reconfigurable 
			# (i.e. are connected to the configuration shift register)
			if (fabric[y][x]) != 'NULL':
				tile_counter += 1
	print('signal\t'+'conf_data'+'\t:\tSTD_LOGIC_VECTOR('+str(tile_counter)+' downto 0);', file=file)

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
	print('-- top configuration data daisy chaining', file=file)
	print('conf_data(conf_data\'low) <= CONFin; -- conf_data\'low=0 and CONFin is from tile entity', file=file)
	print('CONFout <= conf_data(conf_data\'high); -- CONFout is from tile entity', file=file)

	# VHDL tile instantiations
	tile_counter = 0
	print('-- tile instantiations\n', file=file)	
	for y in range(y_tiles):
		for x in range(x_tiles):
			if (fabric[y][x]) != 'NULL':
				EntityName = GetComponentEntityNameFromFile(str(fabric[y][x])+'_tile.vhdl')
				print('Tile_X'+str(x)+'Y'+str(y)+'_'+EntityName+' : '+EntityName, file=file)
				print('\tPort Map(', file=file)
				TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')
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
				# IMPORTANT: we have to go through the following in NORTH EAST SOUTH WEST order
				# NORTH direction: get the NiBEG wires from tile y+1, because they drive NiEND
				if y < (y_tiles-1):
					if (fabric[y+1][x]) != 'NULL':
						TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y+1][x])+'_tile.vhdl', 'NORTH')	
						for port in TileOutputs:
							TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y+1)+'_'+port)
				# EAST direction: get the EiBEG wires from tile x-1, because they drive EiEND
				if x > 0:
					if (fabric[y][x-1]) != 'NULL':
						TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x-1])+'_tile.vhdl', 'EAST')	
						for port in TileOutputs:
							TileInputSignal.append('Tile_X'+str(x-1)+'Y'+str(y)+'_'+port)
				# SOUTH direction: get the SiBEG wires from tile y-1, because they drive SiEND
				if y > 0:
					if (fabric[y-1][x]) != 'NULL':
						TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y-1][x])+'_tile.vhdl', 'SOUTH')	
						for port in TileOutputs:
							TileInputSignal.append('Tile_X'+str(x)+'Y'+str(y-1)+'_'+port)
				# WEST direction: get the WiBEG wires from tile x+1, because they drive WiEND
				if x < (x_tiles-1):
					if (fabric[y][x+1]) != 'NULL':
						TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x+1])+'_tile.vhdl', 'WEST')	
						for port in TileOutputs:
							TileInputSignal.append('Tile_X'+str(x+1)+'Y'+str(y)+'_'+port)

				# the output signals are named after the output ports
				TileInputs, TileOutputs = GetComponentPortsFromFile(str(fabric[y][x])+'_tile.vhdl')	
				TileOutputSignal = []
				# as for the VHDL signal generation, we simply add a prefix like "Tile_X1Y0_" to the begin port
				for port in TileOutputs:
					TileOutputSignal.append('Tile_X'+str(x)+'Y'+str(y)+'_'+port)
				
				TileSignals = TileInputSignal+TileOutputSignal
				for port in TilePorts:
					if ('-Debug'.lower() in str(sys.argv).lower()):
						TilePortsDebugString = '\t-- ' + TilePortsDebug[(TilePorts.index(port))] 
					else:
						TilePortsDebugString = ''
					print('\t\t',port,' => ',TileSignals[(TilePorts.index(port))],','+TilePortsDebugString, file=file)	

				# The following is taken from the tile code generation.
				# I used copy&paste as the order or way how we do the bistream chaining/distribution may change differently for the tiles and the fabric
				print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
				print('\t\t MODE	=> Mode,  ', file=file)
				print('\t\t CONFin	=> conf_data('+str(tile_counter)+'),  ', file=file)
				print('\t\t CONFout	=> conf_data('+str(tile_counter+1)+'),  ', file=file)
				print('\t\t CLK => CLK );  ', file=file)
				print('', file=file)
				tile_counter += 1
	print('\n'+'end Behavioral;'+'\n', file=file)	
	return		
	
			# if re.search('std_logic_vector', tmp_line, flags=re.IGNORECASE):
				# std_vector =  (re.sub('.*std_logic_vector', '', tmp_line, flags=re.IGNORECASE))
			# tmp_line = (re.sub('STD_LOGIC.*', '', tmp_line, flags=re.IGNORECASE))	
	
	# (re.split('; |, |\*|\n',text))
	
	
	
#	print('\n-- BEL component instantiations\n', file=file)
#	All_BEL_Inputs = []
#	All_BEL_Outputs = []
#	BEL_counter = 0
#	for line in tile_description:
#		if line[0] == 'BEL':
#			BEL_Inputs = []
#			BEL_Outputs = []
#			BEL_Inputs, BEL_Outputs = GetComponentPortsFromFile(line[VHDL_file_position])
#			# we remember All_BEL_Inputs and All_BEL_Outputs as wee need these pins for the switch matrix
#			All_BEL_Inputs = All_BEL_Inputs + BEL_Inputs
#			All_BEL_Outputs = All_BEL_Outputs + BEL_Outputs
#			EntityName = GetComponentEntityNameFromFile(line[VHDL_file_position])
#			print('Inst_'+EntityName+' : '+EntityName, file=file)
#			print('\tPort Map(', file=file)
#			for port in BEL_Inputs + BEL_Outputs:
#				print('\t\t',port,' => ',port,',', file=file)
#			print('\t -- GLOBAL all primitive pins for configuration (not further parsed)  ', file=file)
#			print('\t\t MODE	=> Mode,  ', file=file)
#			print('\t\t CONFin	=> conf_data('+str(BEL_counter)+'),  ', file=file)
#			print('\t\t CONFout	=> conf_data('+str(BEL_counter+1)+'),  ', file=file)
#			print('\t\t CLK => CLK );  ', file=file)
#			print('', file=file)
#			# for the next BEL (if any) for cascading configuration chain (this information is also needed for chaining the switch matrix)
#			BEL_counter += 1
#	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
#####################################################################################
# Main
#####################################################################################

# read fabric description as a csv file (Excel uses tabs '\t' instead of ',')
print('### Read Fabric csv file ###')
FabricFile = [i.strip('\n').split(',') for i in open('fabric.csv')]
fabric = GetFabric(FabricFile)
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

if ('-help'.lower() in str(sys.argv).lower()) or ('-h' in str(sys.argv).lower()):
	print('')	
	print('Options/Switches')	
	print('  -GenTileSwitchMatrixCSV    - Generate initial switch matrix template (has to be bootstrapped first)')	
	print('  -GenTileSwitchMatrixVHDL   - Generate initial switch matrix VHDL code')	
	print('  -GenTileHDL                - Generate all tile VHDL descriptions')	
	print('  -run_all                   - run the 3 previous steps in one go (more for debug)')	
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
	


