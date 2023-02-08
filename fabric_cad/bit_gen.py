# Python 3
from array import array
import re
import sys
from contextlib import redirect_stdout
from io import StringIO
import math
import os
import numpy
import pickle
import csv
from fasm import * #Remove this line if you do not have the fasm library installed and will not be generating a bitstream
	
def replace(string, substitutions):
	substrings = sorted(substitutions, key=len, reverse=True)
	regex = re.compile('|'.join(map(re.escape, substrings)))
	return regex.sub(lambda match: substitutions[match.group(0)], string)
	
def bitstring_to_bytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder='big')

def hexstring_to_bytes(s):
    v = int(s, 0)
    b = bytearray()
    while v:
        b.append(v & 0xff)
        v >>= 8
    return bytes(b[::-1])

#CAD methods from summer vacation project 2020


#Method to generate bitstream in the output format - more detail at the end
def genBitstream(fasmFile: str, specFile: str, bitstreamFile: str):
	lGen = parse_fasm_filename(fasmFile)
	canonStr = fasm_tuple_to_string(lGen, True)
	canonList = list(parse_fasm_string(canonStr))

	specDict = pickle.load(open(specFile,"rb"))
	tileDict = {}
	tileDict_No_Mask = {}

	FrameBitsPerRow = specDict["ArchSpecs"]["FrameBitsPerRow"]
	#MaxFramesPerCol = specDict["ArchSpecs"]["FrameBitsPerRow"]
	MaxFramesPerCol = specDict["ArchSpecs"]["MaxFramesPerCol"]

	#Change this so it has the actual right dimensions, initialised as an empty bitstream
	for tile in specDict["TileMap"].keys():
		#bitStream = [0]*(MaxFramesPerCol*FrameBitsPerRow)
		tileDict[tile] = [0]*(MaxFramesPerCol*FrameBitsPerRow)
		tileDict_No_Mask[tile] = [0]*(MaxFramesPerCol*FrameBitsPerRow)

	###NOTE: SOME OF THE FOLLOWING METHODS HAVE BEEN CHANGED DUE TO A MODIFIED BITSTREAM SPEC FORMAT
	#Please bear in mind that the tilespecs are now mapped by tile loc and not by cell type

	for line in canonList:
		if 'CLK' in set_feature_to_str(line.set_feature):
			continue
		if (line.set_feature):
			tileVals = set_feature_to_str(line.set_feature).split(".")
			#print(tileVals)
			tileLoc = tileVals[0]
			featureName = ".".join((tileVals[1], tileVals[2]))
			#print(featureName)
			if tileLoc not in specDict["TileMap"].keys():
				raise Exception("Tile found in fasm file not found in bitstream spec")
			tileType = specDict["TileMap"][tileLoc]	#Set the necessary bits high 
			if featureName in specDict["TileSpecs"][tileLoc].keys():
				if specDict["TileSpecs"][tileLoc][featureName]:
					for bitIndex in specDict["TileSpecs"][tileLoc][featureName]:
						tileDict[tileLoc][bitIndex] = int(specDict["TileSpecs"][tileLoc][featureName][bitIndex])
					for bitIndex_No_Mask in specDict["TileSpecs_No_Mask"][tileLoc][featureName]:
						#print(isinstance(bitIndex_No_Mask, int))
						#print(isinstance(specDict["TileSpecs_No_Mask"][tileLoc][featureName][bitIndex_No_Mask], int))
						#if 'X1Y2' in tileLoc:
						#	print(tileDict_No_Mask[tileLoc])
						#	print(featureName)
						#	print(specDict["TileSpecs_No_Mask"][tileLoc][featureName])
						#	print(bitIndex_No_Mask)
						tileDict_No_Mask[tileLoc][bitIndex_No_Mask] = int(specDict["TileSpecs_No_Mask"][tileLoc][featureName][bitIndex_No_Mask])

			else:
				#print(specDict["TileSpecs"][tileLoc].keys())
				print(tileType)
				print(tileLoc)
				print(featureName)
				raise Exception("Feature found in fasm file was not found in the bitstream spec")


	#Write output string and introduce mask
	coordsRE = re.compile("X(\d*)Y(\d*)")
	num_columns = 0
	for tileKey in tileDict:
		coordsMatch = coordsRE.match(tileKey)
		if int(coordsMatch.group(1)) > num_columns:
		    num_columns = int(coordsMatch.group(1))
	num_columns = num_columns+1
	#concatenatedTileDict = {}
	outStr = ""
	#bitStr = "00AAFF01\n"
	#bitStr = hexstring_to_bytes("0xFAB0FAB1")
	bitStr = bytes.fromhex('00AAFF01000000010000000000000000FAB0FAB1')
	bit_array = [[b'' for x in range(20)] for y in range(num_columns)]
	bit_array_check = [['' for x in range(20)] for y in range(num_columns)]

	#default_hex = ['0','0','0','0','0','0','0','0']

	verilog_str = ''
	vhdl_str = 'library IEEE;\nuse IEEE.STD_LOGIC_1164.ALL;\n\npackage emulate_bitstream is\n'
	for tileKey in tileDict_No_Mask:
		if specDict["TileMap"][tileKey] == "NULL" or len(specDict["FrameMap"][specDict["TileMap"][tileKey]]) == 0:
			continue
		verilog_str += "//"+tileKey+", "+specDict["TileMap"][tileKey]+"\n"
		verilog_str += "`define Tile_"+tileKey+"_Emulate_Bitstream "+str(MaxFramesPerCol*FrameBitsPerRow)+"'b"

		vhdl_str += "--"+tileKey+", "+specDict["TileMap"][tileKey]+"\n"
		vhdl_str += "constant Tile_"+tileKey+"_Emulate_Bitstream : std_logic_vector("+str(MaxFramesPerCol*FrameBitsPerRow)+'-1 downto 0) := "'

		for i in range((MaxFramesPerCol*FrameBitsPerRow)-1,-1,-1):
			verilog_str += str(tileDict_No_Mask[tileKey][i])
			vhdl_str += str(tileDict_No_Mask[tileKey][i])
		verilog_str += "\n"
		vhdl_str += '";\n'
	vhdl_str += "end package emulate_bitstream;"

	for tileKey in tileDict:
		coordsMatch = coordsRE.match(tileKey)
		curStr = ",".join((tileKey, specDict["TileMap"][tileKey], coordsMatch.group(1), coordsMatch.group(2)))
		curStr += "\n"
		bitPos = 0

		if specDict["TileMap"][tileKey] == "NULL":
			continue
		#elif 'term' in specDict["TileMap"][tileKey]:
			#continue
		for frameIndex in range(len(specDict["FrameMap"][specDict["TileMap"][tileKey]])):
			#print (tileDict[tileKey]) #:FrameBitsPerRow*frameIndex
			frame_bit_row = (''.join(map(str, (tileDict[tileKey][FrameBitsPerRow*frameIndex:(FrameBitsPerRow*frameIndex)+FrameBitsPerRow]))))[::-1]
			curStr += ",".join(("frame"+str(frameIndex), str(frameIndex), str(FrameBitsPerRow), frame_bit_row))
			curStr += "\n"

			#bit_hex = hex(int(frame_bit_row,2)).replace("0x","")
			bit_hex = bitstring_to_bytes(frame_bit_row)

			#bit_hex_full = default_hex.copy()
			
			#for i in range(len(bit_hex)):
			    #bit_hex_full[8-len(bit_hex)+i] = bit_hex[i]
			    
			#bit_array[int(coordsMatch.group(1))][frameIndex] = ''.join(bit_hex_full) + "\n" + bit_array[int(coordsMatch.group(1))][frameIndex]
			#bit_array[int(coordsMatch.group(1))][frameIndex] = frame_bit_row + "\n" + bit_array[int(coordsMatch.group(1))][frameIndex]
			#print(frameIndex)
			bit_array[int(coordsMatch.group(1))][frameIndex] = bit_hex + bit_array[int(coordsMatch.group(1))][frameIndex] 
			bit_array_check[int(coordsMatch.group(1))][frameIndex] = bit_array_check[int(coordsMatch.group(1))][frameIndex] + frame_bit_row

			#frame = specDict["FrameMap"][specDict["TileMap"][tileKey]][frameIndex]
			#for char in frame:
				#curStr += ","
				#if char == '0':
					#curStr += "0"
				#else:
					#curStr += str(tileDict[tileKey][bitPos])
					#bitPos += 1
			#if tileKey == 'X3Y8':
			 #print(*specDict["FrameMap"])
			 #print(*tileDict[tileKey][0:10],sep = ",")
			 #print(*frame)
			 #print('\n')
			 #print(curStr)
			 #print('\n')

		#concatenatedTileDict[tileKey] = curStr
		outStr += curStr + "\n"
	#print(num_columns)
	for i in range(num_columns):
		for j in range(20):
		    bin_temp = "{0:b}".format(i).zfill(5)[::-1]
		    frame_select = ['0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0']
		    #bitStr += "X"+str(i)+", frame"+str(j)+"\n"

		    for k in range(-5,0,1):
		        frame_select[k] = bin_temp[k]
		    #frame_select[22+i] = '1'
		    frame_select[j] = '1'
		    #frame_select_temp = hex(int((''.join(frame_select))[::-1],2)).replace("0x","")
		    frame_select_temp = (''.join(frame_select))[::-1]
		    #bit_hex_full = default_hex.copy()
		    #for k in range(len(frame_select_temp)):
		        #bit_hex_full[8-len(frame_select_temp)+k] = frame_select_temp[k]
		    #bitStr += ''.join(bit_hex_full)+"\n"
		    #bitStr += frame_select_temp+"\n"

		    bitStr += bitstring_to_bytes(frame_select_temp)
		    bitStr += bit_array[i][j]

		    #if '1' in bit_array_check[i][j]:
		        #bitStr += bitstring_to_bytes(frame_select_temp)
		        #bitStr += bit_array[i][j]
		    #else:
		        #continue
		    		    
	#Note - format in output file is line by line:
	#Tile Loc, Tile Type, X, Y, bits...... \n 
	#Each line is one tile
	print(outStr, file = open(bitstreamFile.replace("bin","fasm"), "w+"))
	print(verilog_str, file = open(bitstreamFile.replace("bin","vh"), "w+"))
	print(vhdl_str, file = open(bitstreamFile.replace("bin","vhd"), "w+"))
	#print(bitStr, file = open(bitstreamFile, "w+"))
	#with open(bitstreamFile.replace("bit","bin"), 'bw+') as f:
	with open(bitstreamFile, 'bw+') as f:
	 f.write(bitStr)


#This class represents individual tiles in the architecture
class Tile:
	tileType = ""
	bels = []
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
				if tile.genTileLoc == loc:
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
	
#####################################################################################
# Main
#####################################################################################

#Strip arguments
caseProcessedArguments = list(map(lambda x: x.strip(), sys.argv))
processedArguments = list(map(lambda x: x.lower(), caseProcessedArguments))
flagRE = re.compile("-\S*")

if ('-genBitstream'.lower() in str(sys.argv).lower()):
	argIndex = processedArguments.index('-genBitstream'.lower())
	
	if len(processedArguments) <= argIndex + 3:
		raise ValueError('\nError: -genBitstream expect three file names - the fasm file, the spec file and the output file')
	elif (flagRE.match(caseProcessedArguments[argIndex + 1])
		or flagRE.match(caseProcessedArguments[argIndex + 2]) 
		or flagRE.match(caseProcessedArguments[argIndex + 3])):
		raise ValueError('\nError: -genBitstream expect three file names, but found a flag in the arguments:'
			f' {caseProcessedArguments[argIndex + 1]}, {caseProcessedArguments[argIndex + 2]}, {caseProcessedArguments[argIndex + 3]}\n')

	FasmFileName  = caseProcessedArguments[argIndex + 1]
	SpecFileName  = caseProcessedArguments[argIndex + 2]
	OutFileName  = caseProcessedArguments[argIndex + 3]

	genBitstream(FasmFileName, SpecFileName, OutFileName)



if ('-help'.lower() in str(sys.argv).lower()) or ('-h' in str(sys.argv).lower()):
	print('')	
	print('Options/Switches')	
	print('	 -genBitstream foo.fasm spec.txt bitstream.txt - generates a bitstream - the first file is the fasm file, the second is the bitstream spec and the third is the fasm file to write to')
	


