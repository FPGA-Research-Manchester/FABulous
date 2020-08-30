from fasm import *
import pickle
import re

def genBitstream(fasmFile: str, specFile: str, bitstreamFile: str):
	lGen = parse_fasm_filename(fasmFile)


	canonStr = fasm_tuple_to_string(lGen, True)

	canonList = list(parse_fasm_string(canonStr))

	specDict = pickle.load(open(specFile,"rb"))
	tileDict = {}

	FrameBitsPerRow = 32
	MaxFramesPerCol = 20

	#Change this so it has the actual right dimensions
	for tile in specDict["TileMap"].keys():
		bitStream = [0]*(MaxFramesPerCol*FrameBitsPerRow)
		tileDict[tile] = bitStream


	for line in canonList:
		if (line.set_feature):
			tileVals = set_feature_to_str(line.set_feature).split(".")
			tileLoc = tileVals[0]
			featureName = ".".join((tileVals[1], tileVals[2]))
			if tileLoc not in specDict["TileMap"].keys():
				raise Exception("Tile found in fasm file not found in bitstream spec")
			tileType = specDict["TileMap"][tileLoc]
			if featureName in specDict["TileSpecs"][tileType].keys():
				for bitIndex in specDict["TileSpecs"][tileType][featureName]:
					tileDict[tileLoc][bitIndex] = specDict["TileSpecs"][tileType][featureName][bitIndex]
			else:
				print(specDict["TileSpecs"][tileType].keys())
				print(tileType)
				print(tileLoc)
				print(featureName)
				raise Exception("Feature found in fasm file was not found in the bitstream spec")


	#Write output string and introduce mask

	concatenatedTileDict = {}
	outStr = ""

	coordsRE = re.compile("X(\d*)Y(\d*)")

	for tileKey in tileDict:
		coordsMatch = coordsRE.match(tileKey)
		curStr = ",".join((tileKey, specDict["TileMap"][tileKey], coordsMatch.group(1), coordsMatch.group(2)))
		bitPos = 0
		if specDict["TileMap"][tileKey] == "NULL":
			continue
		for frameIndex in range(len(specDict["FrameMap"][specDict["TileMap"][tileKey]])):
			frame = specDict["FrameMap"][specDict["TileMap"][tileKey]][frameIndex]
			for char in frame:
				curStr += ","
				if char == 0:
					curStr += "0"
				else:
					curStr += str(tileDict[tileKey][bitPos])
					bitPos += 1
		concatenatedTileDict[tileKey] = curStr
		outStr += curStr + "\n"

	print(outStr, file = open(bitstreamFile, "w"))

