#import __init__, output
from fasm import *
import pickle

lGen = parse_fasm_filename("../nextpnr-diko/diko/simple.fasm")


canonStr = fasm_tuple_to_string(lGen, True)

canonList = list(parse_fasm_string(canonStr))

specDict = pickle.load(open("../fabric/bitstreamspec.txt","rb"))
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


#Concatenate bits and introduce mask:

concatenatedTileDict = {}

for tileKey in tileDict:
	curStr = ""
	bitPos = 0
	if specDict["TileMap"][tileKey] == "NULL":
		continue
	for frameIndex in range(len(specDict["FrameMap"][specDict["TileMap"][tileKey]])):
		#print(specDict["TileMap"][tileKey])
		#print(frameIndex)
		#print(specDict["FrameMap"][specDict["TileMap"][tileKey]])
		frame = specDict["FrameMap"][specDict["TileMap"][tileKey]][frameIndex]

		for char in frame:
			if char == 0:
				curStr += "0"
			else:
				curStr += str(tileDict[tileKey][bitPos])
				bitPos += 1
	concatenatedTileDict[tileKey] = curStr

print(concatenatedTileDict)



#for line in canonList:
#	print(line)



# for line in tList:
#	if (line.set_feature):
#		print(set_feature_to_str(line.set_feature))

# for i in range(10):
# 	print(tList[i])