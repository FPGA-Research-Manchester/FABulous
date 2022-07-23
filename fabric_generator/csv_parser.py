from fabric import Fabric, Port, Bel, Tile, SuperTile
import re
from copy import deepcopy


def parse_csv(file_name) -> Fabric:
    """
    Parses a csv file and returns a Fabric object.
    """

    with open(file_name, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    # read in the csv file and part them
    fabricDescription = re.search(
        r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL).group(1)

    parameters = re.search(
        r"ParametersBegin(.*?)ParametersEnd", file, re.MULTILINE | re.DOTALL).group(1)

    tilesData = re.findall(r"TILE.*?EndTILE", file,
                           re.MULTILINE | re.DOTALL)

    superTile = re.findall(r"SuperTILE.*?EndSuperTILE",
                           file, re.MULTILINE | re.DOTALL)

    # parse the tile description
    fabricDescription = fabricDescription.split("\n")
    parameters = parameters.split("\n")
    tileTypes = []
    tileDefs = []
    for t in tilesData:
        t = t.split("\n")
        tileName = t[0].split(",")[1]
        tileTypes.append(tileName)
        ports = []
        bels = []
        matrixDir = ""
        for item in t:
            temp = item.split(",")
            temp = [i for i in temp if i != ""]
            if not temp:
                continue
            if temp[0] in ["NORTH", "SOUTH", "EAST", "WEST", "JUMP"]:
                ports.append(Port(temp[0], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5])))
            elif temp[0] == "BEL":
                if len(temp) == 2:
                    bels.append(Bel(temp[1], ""))
                else:
                    bels.append(Bel(temp[1], temp[2]))
            elif temp[0] == "MATRIX":
                matrixDir = temp[1]
        tileDefs.append(Tile(tileName, ports, bels, matrixDir))

    fabricTiles = []
    tileDic = dict(zip(tileTypes, tileDefs))

    for f in fabricDescription:
        fabricLineTmp = f.split(",")
        fabricLineTmp = [i for i in fabricLineTmp if i != ""]
        if not fabricLineTmp:
            continue
        fabricLine = []
        for i in fabricLineTmp:
            if i in tileDic:
                fabricLine.append(deepcopy(tileDic[i]))
            elif i == "Null" or i == "NULL" or i == "None":
                fabricLine.append(None)
            else:
                print("The fabric contains definitions that are not tiles or Null.")
                print("The following definition is not valid:")
                print(i)
                print("The available tiles are:")
                print(list(tileDic.keys()))
                exit(-1)
        fabricTiles.append(fabricLine)

    height = 0
    width = 0
    configBitMode = "frame_based"
    frameBitsPerRow = 32
    maxFramesPerCol = 20
    package = "use work.my_package.all;"
    generateDelayInSwitchMatrix = 80
    multiplexerStyle = "custom"
    superTileEnable = True

    # parse the parameters
    for i in parameters:
        i = i.split(",")
        i = [j for j in i if j != ""]
        if not i:
            continue
        if i[0].startswith("ConfigBitMode"):
            configBitMode = i[1]
        elif i[0].startswith("FrameBitsPerRow"):
            frameBitsPerRow = int(i[1])
        elif i[0].startswith("FrameBitsPerColumn"):
            maxFramesPerCol = int(i[1])
        elif i[0].startswith("Package"):
            package = i[1]
        elif i[0].startswith("GenerateDelayInSwitchMatrix"):
            generateDelayInSwitchMatrix = int(i[1])
        elif i[0].startswith("MultiplexerStyle"):
            multiplexerStyle = i[1]
        elif i[0].startswith("SuperTileEnable"):
            superTileEnable = i[1] == "TRUE"
        else:
            print("The parameters section contains an invalid parameter.")
            print("The following parameter is not valid:")
            print(i)
            exit(-1)
    height = len(fabricTiles)
    width = len(fabricTiles[0])

    return Fabric(fabricTiles, height, width, configBitMode, frameBitsPerRow, maxFramesPerCol,
                  package, generateDelayInSwitchMatrix, multiplexerStyle, superTileEnable, tileDic)


if __name__ == '__main__':
    result = parse_csv('fabric.csv')
    print(result)
