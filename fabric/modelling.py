from array import array
import re
import sys
from contextlib import redirect_stdout
from io import StringIO
import math
import os
import numpy
import configparser
from gen import *
import pickle

sDelay = "8"
GNDRE = re.compile("GND(\d*)")
VCCRE = re.compile("VCC(\d*)")
BracketAddingRE = re.compile("(.*)(\d+)")


#This class represents individual tiles in the architecture
class Tile:
	tileType = ""
	bels = []
	wires = []
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



letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W"] #For LUT labelling


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
	#print(csvFile[1::])
	for y, row in enumerate(csvFile[1::]):
		#print(row[1:-2:])
		for x, value in enumerate(row[1::]):
			#print(value)
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
	#return ""
	if returnDict:
		return pipsdict
	return pips





def genFabricObject(fabric: list):
	#The following iterates through the tile designations on the fabric
	archFabric = Fabric(len(fabric), len(fabric[0]))

	portMap = {}
	wireMap = {}
	# for i, line in enumerate(fabric):
	# 	for j, tile in enumerate(line):
	# 		tileList = GetTileFromFile(FabricFile, tile)
	# 		portList = []
	# 		for wire in tileList:
	# 			if wire[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
	# 				if wire[1] != "NULL":
	# 					portList.append(wire[1])
	# 				if wire[4] != "NULL":
	# 					portList.append(wire[4])
	# 		portMap["I" + str(i) + "J" + str(j)] = portList

	for i, line in enumerate(fabric):
		row = []
		for j, tile in enumerate(line): 
			cTile = Tile(tile)
			wires = []
			belList = []
			tileList = GetTileFromFile(FabricFile, tile)
			portList = []
			wireTextList = []
			for wire in tileList:
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
						print("CSV File not found.") #Throw error here later

				if wire[0] == "BEL":
					try:
						ports = GetComponentPortsFromFile(wire[1])
					except:
						raise Exception(f"{wire[1]} file for BEL not found")

					if len(wire) > 2:
						prefix = wire[2]
					else:
						prefix = ""
					nports = []


					for port in ports[0]:
						nports.append(prefix + re.sub(" *\(.*\) *", "", str(port)))
					for port in ports[1]:
						nports.append(prefix + re.sub(" *\(.*\) *", "", str(port)))
					cTile.belPorts.update(nports)

					belList.append([wire[1][0:-5:], prefix, nports])

				elif wire[0] in ["NORTH", "SOUTH", "EAST", "WEST"]: 
					#Wires are added in next pass - this pass generates port lists to be used for wire generation
					if wire[1] != "NULL":
						portList.append(wire[1])
					if wire[4] != "NULL":
						portList.append(wire[4])
					wireTextList.append({"direction": wire[0], "source": wire[1], "xoffset": wire[2], "yoffset": wire[3], "destination": wire[4], "wire-count": wire[5]}) 
				elif wire[0] == "JUMP":
					if "NULL" not in wire:
						wires.append({"direction": wire[0], "source": wire[1], "xoffset": wire[2], "yoffset": wire[3], "destination": wire[4], "wire-count": wire[5]}) 
			cTile.wires = wires
			cTile.x = j
			cTile.y = archFabric.height - i -1
			cTile.bels = belList
			row.append(cTile)
			portMap[cTile] = portList
			wireMap[cTile] = wireTextList
		archFabric.tiles.append(row)


		#Add wires to model
		for row in archFabric.tiles:
			for tile in row:
				wires = []
				wireTextList = wireMap[tile]
				#Wires from tile
				for wire in wireTextList:
					destinationTile = archFabric.getTileByCoords(tile.x + int(wire["xoffset"]), tile.y + int(wire["yoffset"]))
					if not ((destinationTile == None) or ("NULL" in wire.values()) or (wire["destination"] not in portMap[destinationTile])):
						wires.append(wire)
						portMap[destinationTile].remove(wire["destination"])
						portMap[tile].remove(wire["source"])

				#Wires to tile


					sourceTile = archFabric.getTileByCoords(tile.x - int(wire["xoffset"]), tile.y - int(wire["yoffset"]))
					if (sourceTile == None) or ("NULL" in wire.values()) or (wire["source"] not in portMap[sourceTile]):
						continue
					sourceTile.wires.append(wire)
					portMap[sourceTile].remove(wire["source"])
					portMap[tile].remove(wire["destination"])

				tile.wires.extend(wires)
	archFabric.cellTypes = GetCellTypes(fabric)
	return archFabric


def genVPRModel(fabricObject: Fabric):
	raise Exception("VPR Model generation is not yet functional")
	modelStr = "<architecture>\n"

	modelStr += "<models>\n"
	for type in fabricObject.cellTypes:
		if type == "LUT4AB":
			continue
		else:
			modelStr += f"<model name=\"{type}\">\n"

			modelStr += "<input_ports>\n"
			modelStr += "<port name=\"port1\"/>\n"
			modelStr += "</input_ports>\n"

			modelStr += "<output_ports>\n"
			modelStr += "<port name=\"port2\"/>\n"
			modelStr += "</output_ports>\n"


			modelStr += "</model>\n"
	modelStr += "</models>\n"


	modelStr += "<tiles>\n"
	for cellType in fabricObject.cellTypes:
		modelStr += f"<tile name=\"{cellType}\">\n"
		modelStr += f"<equivalent_sites>\n<site pb_type=\"{cellType}\" pin_mapping=\"direct\"/>\n</equivalent_sites>\n"
		modelStr += "</tile>"
	modelStr += "</tiles>\n"

	modelStr += "<layout>\n<fixed_layout name=\"main\" "
	modelStr += f"width=\"{fabricObject.width}\" height=\"{fabricObject.height}\">\n"

	for y, line in enumerate(fabricObject.tiles):
		for x, tile in enumerate(line): #Add tiles for layout
			modelStr += f"<single type=\"{tile.tileType}\" x=\"{x}\" y=\"{fabricObject.height - y}\" priority=\"1\"/>\n"


	modelStr += "</fixed_layout>\n</layout>\n"

	switchBlocksStr = "" #This string will hold switchblock details to be added later

	modelStr += "<device>\n"
	#this string is from the example as a filler
	modelStr += """<sizing R_minW_nmos="6065.520020" R_minW_pmos="18138.500000"/>
    <area grid_logic_tile_area="14813.392"/>
    <!--area is for soft logic only-->
    <chan_width_distr>
      <x distr="uniform" peak="1.000000"/>
      <y distr="uniform" peak="1.000000"/>
    </chan_width_distr>
    <switch_block type="wilton" fs="3"/>
    <connection_block input_switch_name="ipin_cblock"/>"""
	modelStr += "</device>\n"

	#also a filler 
	modelStr += "<switchlist>\n"
	modelStr += """<switch type="mux" name="0" R="0.000000" Cin="0.000000e+00" Cout="0.000000e+00" Tdel="6.837e-11" mux_trans_size="2.630740" buf_size="27.645901"/>
    <!--switch ipin_cblock resistance set to yeild for 4x minimum drive strength buffer-->
    <switch type="mux" name="ipin_cblock" R="1516.380005" Cout="0." Cin="0.000000e+00" Tdel="7.247000e-11" mux_trans_size="1.222260" buf_size="auto"/>"""
 
	modelStr += "</switchlist>\n"

	modelStr += "<segmentlist>\n"
	#Yet another filler!
	modelStr += """<segment freq="1.000000" length="4" type="unidir" Rmetal="0.000000" Cmetal="0.000000e+00">
      <mux name="0"/>
      <sb type="pattern">1 1 1 1 1</sb>
      <cb type="pattern">1 1 1 1</cb>
    </segment>"""
	modelStr += "</segmentlist>\n"

	modelStr += "<directlist>\n"
	modelStr += "</directlist>\n"

	modelStr += "<complexblocklist>\n"
	for cellType in fabricObject.cellTypes: #Define cell types
		modelStr += f"<pb_type name=\"{cellType}\" "
		#if cellType == "LUT4AB":
		#	modelStr += "blif_model=\".name\""
		#else:
		#	modelStr += f"blif_model=\".subckt {cellType}\""
		modelStr += ">\n"

		relevantTile = getTileByType(fabricObject, cellType)

		for bel in relevantTile.bels:
			modelStr += f"<pb_type name=\"{bel}\" blif_model=\".subckt {bel}\">\n"
			modelStr += "</pb_type>\n"

		modelStr += "</pb_type>\n" 

		switchBlocksStr += "<switchblock>\n"

		switchBlocksStr += "</switchblock>\n"
	modelStr += "</complexblocklist>\n"
	


	modelStr += "</architecture>"

	return modelStr


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
				pipsStr += ",".join((tileLoc, pip[0], tileLoc, pip[1],sDelay,".".join((pip[0], pip[1])))) #Add the pips (also delay should be done here later, the 80 is a filler)
				pipsStr += "\n"

			#TODO: fix this when able to techmap to MUX8 bels.
			# if tile.tileType == "LUT4AB":
			# 	pipsStr += "Temporary mux filler:" + "\n"

				# pipsStr += ",".join((tileLoc, "AB", tileLoc, "M_AB",sDelay,"AB.M_AB"))
				# pipsStr += ",".join((tileLoc, "EF", tileLoc, "M_EF",sDelay,"EF.M_EF"))
				# pipsStr += ",".join((tileLoc, "S0", tileLoc, "sCD",sDelay,"S0.sCD"))
				# pipsStr += ",".join((tileLoc, "S1", tileLoc, "sCD",sDelay,"S1.sCD"))
				# pipsStr += ",".join((tileLoc, "S0", tileLoc, "sEF",sDelay,"S0.sEF"))
				# pipsStr += ",".join((tileLoc, "S2", tileLoc, "sEF",sDelay,"S2.sEF"))
				# pipsStr += ",".join((tileLoc, "sEF", tileLoc, "sGH",sDelay,"sEF.sGH"))
				# pipsStr += ",".join((tileLoc, "sEH", tileLoc, "sGH",sDelay,"sEH.sGH"))
				# pipsStr += ",".join((tileLoc, "S1", tileLoc, "sEH",sDelay,"S1.sEH"))
				# pipsStr += ",".join((tileLoc, "S3", tileLoc, "sEH",sDelay,"S3.sEH"))
				# pipsStr += ",".join((tileLoc, "AD", tileLoc, "M_AD",sDelay,"AD.M_AD"))
				# pipsStr += ",".join((tileLoc, "CD", tileLoc, "M_AD",sDelay,"CD.M_AD"))
				# pipsStr += ",".join((tileLoc, "AH", tileLoc, "M_AH",sDelay,"AH.M_AH"))
				# pipsStr += ",".join((tileLoc, "EH_GH", tileLoc, "M_AH",sDelay,"EH_GH.M_AH"))



				#for i in range(0, 8, 2):
					#pipsStr += ",".join((tileLoc, letters[i+1], tileLoc, f"M_{letters[i]}{letters[i+1]}",sDelay,".".join((letters[i+1], f"M_{letters[i]}{letters[i+1]}")))) + "\n"
					#pipsStr += ",".join((tileLoc, letters[i], tileLoc, f"M_{letters[i]}{letters[i+1]}",sDelay,".".join((letters[i], f"M_{letters[i]}{letters[i+1]}")))) + "\n"

			pipsStr += f"#Tile-external pips on tile {tileLoc}:\n"
			for wire in tile.wires:
				#if tile.y + int(wire["yoffset"]) > (fabricObject.height - 2) or tile.y + int(wire["yoffset"]) < 1: #These are offset by 1 because of terminator tiles - that might have to change later but this works for our specific structure
				#	desty = 2*fabricObject.height - 3 - (tile.y + int(wire["yoffset"])) #Formula derived from finding the distance over the limit then subtracting it from the right point then simplified
				#else:
				desty = tile.y + int(wire["yoffset"])

				destx = tile.x + int(wire["xoffset"])
				desttileLoc = f"X{destx}Y{desty}"
				for i in range(int(wire["wire-count"])):
					pipsStr += ",".join((tileLoc, wire["source"]+str(i), desttileLoc, wire["destination"]+str(i), sDelay, ".".join((wire["source"]+str(i), wire["destination"]+str(i)))))
					pipsStr += "\n"



			#Add BELs 
			belsStr += "#Tile_" + tileLoc + "\n" #Tile declaration as a comment


			for num, belpair in enumerate(tile.bels):
				bel = belpair[0]

				let = letters[num]
				# if bel == "LUT4c_frame_config":
				# 	cType = "LUT4"
				# 	prefix = "L" + let + "_"
				# elif bel == "IO_1_bidirectional_frame_config_pass":
				# 	prefix = let + "_"
				# else:
				# 	cType = bel
				# 	prefix = ""

				prefix = belpair[1]
				nports = belpair[2]



				if bel == "LUT4c_frame_config":
					cType = "LUT4"
				#elif bel == "IO_1_bidirectional_frame_config_pass":
				#	cType = "IOBUF"
				else:
					cType = bel
				belsStr += ",".join((tileLoc, ",".join(tile.genTileLoc(True)), let, cType, ",".join(nports))) + "\n"

				#Add template:
				if bel == "IO_1_bidirectional_frame_config_pass":
					templateStr += f"wire "
					for i, port in enumerate(nports):
						templateStr += f"Tile_{tileLoc}_{port}"
						if i < len(nports) - 1:
							templateStr += ", "
						else:
							templateStr += ";\n"

					belName = f"Tile_{tileLoc}_{let}"

					templateStr += f"(* keep *) IO_1_bidirectional_frame_config_pass {belName} (.O(Tile_{tileLoc}_{prefix}O), .Q(Tile_{tileLoc}_{prefix}Q), .I(Tile_{tileLoc}_{prefix}I), .T(Tile_{tileLoc}_{prefix}T));\n\n"

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
						#print(wire["source"] + str(i))
						#print(tile.pipMuxes.keys())
						if (wire["destination"] + str(i)) not in destTile.pipMuxes_MapSourceToSinks.keys():
							#print("Not Found")
							continue
						#print("Found")
						for pipSink in destTile.pipMuxes_MapSourceToSinks[wire["destination"] + str(i)]:
							if len(destTile.pipMuxes_MapSinkToSources[pipSink]) > 1:
								# pipSinkRE = BracketAddingRE.match(pipSink)

								# if pipSinkRE and pipSink not in destTile.belPorts:
								# 	outSink = pipSinkRE.group(1) + "[" + pipSinkRE.group(2) + "]"
								# else:
								# 	outSink = pipSink
								pairStr += ",".join((".".join((tileLoc, wire["source"] + f"[{str(i)}]")), ".".join((desttileLoc, addBrackets(pipSink, tile))))) + "\n" #TODO: add square brackets to end
								#print("Simple")
								#print(",".join((".".join((tileLoc, wire["source"] + f"[{str(i)}]")), ".".join((desttileLoc, pipSink)))) + "\n")
							else:
								finalDestination = ".".join((desttileLoc, addBrackets(pipSink, tile)))
								foundPhysicalPairs = False
								curWireTuple = (tile, wire, i)
								potentialStarts = []
								stopOffs = []
								while (not foundPhysicalPairs):
									#For each wire we're leading into, find out if the pip input is a multiplexer
									#print(curWireTuple)
									cTile = curWireTuple[0]
									#print(cTile.tileType)
									cWire = curWireTuple[1]
									cIndex = curWireTuple[2]
									#print(cWire["source"] + str(cIndex))
									#print((cTile.pipMuxes_MapSinkToSources[cWire["source"] + str(cIndex)]))

									if len(cTile.pipMuxes_MapSinkToSources[cWire["source"] + str(cIndex)]) > 1:
										for wireEnd in cTile.pipMuxes_MapSinkToSources[cWire["source"]  + str(cIndex)]:
											#print(wireEnd)
											if wireEnd in cTile.belPorts:
												continue
											cPair = archObject.getTileAndWireByWireDest(cTile.genTileLoc(), wireEnd)
											if cPair == None:
												#print(cWire["source"]  + str(cIndex))
												#print(cTile.genTileLoc(), wireEnd)
												continue
											#	continue #This means that there are no wires connected to this port, so it must be a bel output port
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
										# if curWireTuple == None:
										# 	print(cWire["source"] + str(cIndex))
										# 	print(destPort, destLoc)
								pairStr += "#Propagated route for " + finalDestination + "\n"
								for index, start in enumerate(potentialStarts):
									pairStr += start + "," + finalDestination + "\n"
								pairStr += "#Stopoffs: " + ",".join(stopOffs) + "\n"

				#Generate pairs for bels:
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

								#print(tileLoc + "." + prefix + f"I[{i}]," + tileLoc + "." + addBrackets(outPip, tile))


						#Add ffs here later

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
						# for outPort in ("I", "T"):
						# 	for inPip in tile.pipMuxes_MapSinkToSources[prefix + outPort]:
						# 		#pairStr += tileLoc + "." + prefix + inPort + tileLoc + "." + addBrackets(outPip, tile) + "\n"
						# 		pairStr += tileLoc + "." + addBrackets(inPip, tile)  + "," + tileLoc + "." + prefix + inPort + "\n"

					elif bel == "InPass4_frame_config":
						for i in range(4):
							for outPip in tile.pipMuxes_MapSourceToSinks[prefix + "O" + str(i)]:
								pairStr += tileLoc + "." + prefix + f"O{i}" + "," + tileLoc + "." + addBrackets(outPip, tile) + "\n"						

				# elif bel == "OutPass4_frame_config":
				# 	for i in range(4):
				# 		for inPip in tile.pipMuxes_MapSinkToSources[prefix + "I" + str(i)]:
				# 			pairStr += tileLoc + "." + addBrackets(inPip, tile)  + "," + tileLoc + "." + prefix + f"I{i}" + "\n"						
	templateStr += "endmodule"
	if generatePairs:
		return (pipsStr, belsStr, templateStr, constraintStr, pairStr)
	else:
		return (pipsStr, belsStr, templateStr, constraintStr)


def genBitstreamSpec(archObject: Fabric):
	specData = {"TileMap":{}, "TileSpecs":{}, "FrameMap":{}, "ArchSpecs":{"MaxFramesPerCol":0, "FrameBitsPerRow":0}}
	BelMap = {}
	for line in archObject.tiles:
		for tile in line:
			specData["TileMap"][tile.genTileLoc()] = tile.tileType

	#Generate mapping dicts for bel types:

	#LUT4:

	LUTmap = {}
	LUTmap["INIT"] = 0 #Futureproofing as there are two ways that INIT[0] may be referred to (FASM parser will use INIT to refer to INIT[0])
	for i in range(16):
		LUTmap["INIT[" + str(i) + "]"] = i
	LUTmap["FF"] = 16
	LUTmap["IOmux"] = 17

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

	BelMap["IO_1_bidirectional_frame_config_pass"] = {}




	DoneTypes = []

	for cellType in archObject.cellTypes:
		curTile = getTileByType(archObject, cellType)
		curBitOffset = 0
		curTileMap = {}
		for i, belPair in enumerate(curTile.bels):
			tempOffset = 0
			name = letters[i]
			belType = belPair[0]
			for featureKey in BelMap[belType]:
				curTileMap[name + "." +featureKey] = {BelMap[belType][featureKey] + curBitOffset: "1"}
				tempOffset += 1
			curBitOffset += tempOffset
		csvFile = [i.strip('\n').split(',') for i in open(curTile.matrixFileName)] 
		pipCounts = [int(row[-1]) for row in csvFile[1::]]
		csvFile = RemoveComments(csvFile)
		sinks = [line[0] for line in csvFile]
		sources = csvFile[0]
		pips = []
		pipsdict = {}
		for y, row in enumerate(csvFile[1::]):
			muxList = []
			pipCount = pipCounts[y]
			for x, value in enumerate(row[1::]):
				#Remember that x and y are offset 
				if value == "1":
					muxList.append(".".join((sources[x+1], sinks[y+1])))
			muxList.reverse() #Order is flipped 
			for i, pip in enumerate(muxList):
				if pipCount < 2:
					curTileMap[pip] = {}
				controlWidth = int(numpy.ceil(numpy.log2(pipCount)))
				controlValue = f"{i:0{controlWidth}b}"
				tempOffset = 0
				for curChar in controlValue:
					if pip not in curTileMap.keys():
						curTileMap[pip] = {}
					curTileMap[pip][curBitOffset + tempOffset] = curChar
					tempOffset += 1
			curBitOffset += controlWidth
		for wire in curTile.wires:
			for count in range(int(wire["wire-count"])):
				wireName = ".".join((wire["source"] + str(count), wire["destination"] + str(count)))
				curTileMap[wireName] = {} #Tile connection wires are seen as pips by nextpnr for ease of use, so this makes sure those pips still have corresponding keys
		# sinks = [line[0] for line.split(",") in SMcsvFile]
		# sources = SMcsvFile[0].split(",")
		# for line in SMcsvFile:
		# 	valArr = line.split(",")
		# 	pipCount = valArr[-1]

		# SMcsvFile.close()
		#print(cellType)
		#print(curTileMap)
		specData["TileSpecs"][cellType] = curTileMap


		#Add frame masks to the dictionary 
		try:
			configCSV = open(cellType + "_ConfigMem.csv") #This may need to be .init.csv, not just .csv
		except:
			print(f"No Config Mem csv file found for {cellType}. Assuming no config memory.")
			specData["FrameMap"][cellType] = {}
			continue
		configList = [i.strip('\n').split(',') for i in configCSV]
		configList = RemoveComments(configList)
		maskDict = {}
		for line in configList:
			maskDict[int(line[1])] = line[3].replace("_", "")
		specData["FrameMap"][cellType] = maskDict
		if specData["ArchSpecs"]["MaxFramesPerCol"] < int(line[1]) + 1:
			specData["ArchSpecs"]["MaxFramesPerCol"] = int(line[1]) + 1
		if specData["ArchSpecs"]["FrameBitsPerRow"] < int(line[2]):
			specData["ArchSpecs"]["FrameBitsPerRow"] = int(line[2])

		configCSV.close()
	#print(specData)
	return specData
	






	# confRE = re.compile("(.*) <= ConfigBits\((.*)\);")
	# bitsRE = re.compile("(\d*) downto (/d*)")

	# for line in archObject.tiles:
	# 	for tile in line:
	# 		if tile.tileType in DoneTypes:
	# 			continue
	# 		DoneTypes.append(tile.tileType)
	# 		curMap = {}
	# 		for i, bel in enumerate(tile.bels):
	# 			name = letters[i]
	# 			belFile = open(bel[0] + ".vhdl")
	# 			for line in belFile:
	# 				confResult = confRE.match(line)
	# 				if confResult:
	# 					print(line)
	# 					featureName = confResult.group(1)
	# 					featureBitString = confResult.group(2)
	# 					bitsResult = bitsRE.match(featureBitString)
	# 					if bitsResult:
	# 						print(bitsResult.groups())

	# 			belFile.close()





#print('### Read Fabric csv file ###')
FabricFile = [i.strip('\n').split(',') for i in open('fabric.csv')]
fabric = GetFabric(FabricFile)  #filter = 'Fabric' is default to get the definition between 'FabricBegin' and 'FabricEnd'

fabricObject = genFabricObject(fabric)
pipFile = open("npnroutput/pips.txt","w")
belFile = open("npnroutput/bel.txt", "w")
pairFile = open("npnroutput/wirePairs.csv", "w")
templateFile = open("npnroutput/template.v", "w")
constraintFile = open("npnroutput/template.pcf", "w")

bitstreamSpecFile = open("npnroutput/bitstreamspec.txt", "wb")

npnrModel = genNextpnrModel(fabricObject, False)

specObject = genBitstreamSpec(fabricObject)

pickle.dump(specObject, bitstreamSpecFile)



pipFile.write(npnrModel[0])
belFile.write(npnrModel[1])
templateFile.write(npnrModel[2])
constraintFile.write(npnrModel[3])
#pairFile.write(npnrModel[2])

bitstreamSpecFile.close()
pipFile.close()
belFile.close()
