from fabric import Fabric, Port, Bel, Tile, SuperTile
import re
from copy import deepcopy
from typing import List, Literal, Tuple

oppositeDic = {"NORTH": "SOUTH", "SOUTH": "NORTH",
               "EAST": "WEST", "WEST": "EAST"}


def parseFabricCSV(fileName: str) -> Fabric:
    """
    Parses a csv file and returns a Fabric object.
    """

    with open(fileName, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    # read in the csv file and part them
    if fabricDescription := re.search(
            r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL):
        fabricDescription = fabricDescription.group(1)
    else:
        raise ValueError(
            'ERROR: cannot find FabricBegin and FabricEnd in csv file')

    if parameters := re.search(
            r"ParametersBegin(.*?)ParametersEnd", file, re.MULTILINE | re.DOTALL):
        parameters = parameters.group(1)
    else:
        raise ValueError(
            'ERROR: cannot find ParametersBegin and ParametersEnd in csv file')

    tilesData = re.findall(r"TILE(.*?)EndTILE", file,
                           re.MULTILINE | re.DOTALL)

    superTile = re.findall(r"SuperTILE(.*?)EndSuperTILE",
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
        withUserCLK = False
        for item in t:
            temp = item.split(",")
            if not temp or temp[0] == "":
                continue
            if temp[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
                if temp[1] == '' or temp[4] == '':
                    raise ValueError(
                        f"Either source or destination port for JUMP wire missing in tile {t}")
                ports.append(Port(temp[0], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], "OUT", temp[0]))

                ports.append(Port(temp[0], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[4], "IN", oppositeDic[temp[0]]))
            elif temp[0] == "JUMP":
                ports.append(Port(temp[0], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], "OUT", "ANY"))
                ports.append(Port(temp[0], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], "IN", "ANY"))
            elif temp[0] == "BEL":
                internal, external, config, shared, configBit, userClk = parseFileHDL(
                    temp[1], temp[2])
                bels.append(Bel(temp[1], temp[2], internal,
                            external, config, shared, configBit))
                withUserCLK |= userClk
            elif temp[0] == "MATRIX":
                matrixDir = temp[1]
            else:
                raise ValueError(
                    f"Error: unknown tile description {temp[0]} in tile {t}")

        tileDefs.append(Tile(tileName, ports, bels, matrixDir, withUserCLK))

    fabricTiles = []
    tileDic = dict(zip(tileTypes, tileDefs))

    usedTile = set()
    for f in fabricDescription:
        fabricLineTmp = f.split(",")
        fabricLineTmp = [i for i in fabricLineTmp if i != ""]
        if not fabricLineTmp:
            continue
        fabricLine = []
        for i in fabricLineTmp:
            if i in tileDic:
                fabricLine.append(deepcopy(tileDic[i]))
                usedTile.add(i)
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

    for i in list(tileDic.keys()):
        if i not in usedTile:
            print(
                f"Tile {i} is not used in the fabric. Removing from tile dictionary.")
            del tileDic[i]

    superTileDic = {}
    # parse the super tile
    for t in superTile:
        description = t.split("\n")
        name = description[0].split(",")[1]
        tileMap = []
        tiles = []
        bels = []
        withUserCLK = False
        for i in description[1:-1]:
            line = i.split(",")
            line = [i for i in line if i != "" and i != " "]
            row = []

            if line[0] == "BEL":
                internal, external, config, shared, configBit, userClk = parseFileHDL(
                    line[1], line[2])
                bels.append(Bel(line[1], line[2], internal,
                            external, config, shared, configBit))
                withUserCLK |= userClk
                continue

            for j in line:
                if j in tileDic:
                    t = deepcopy(tileDic[j])
                    row.append(t)
                    if t not in tiles:
                        tiles.append(t)
                elif j == "Null" or j == "NULL" or j == "None":
                    row.append(None)
                else:
                    raise ValueError(
                        f"The super tile {name} contains definitions that are not tiles or Null.")
            tileMap.append(row)

        superTileDic[name] = SuperTile(name, tiles, tileMap, bels, withUserCLK)

    # parse the parameters
    height = 0
    width = 0
    configBitMode = "frame_based"
    frameBitsPerRow = 32
    maxFramesPerCol = 20
    package = "use work.my_package.all;"
    generateDelayInSwitchMatrix = 80
    multiplexerStyle = "custom"
    superTileEnable = True

    for i in parameters:
        i = i.split(",")
        i = [j for j in i if j != ""]
        if not i:
            continue
        if i[0].startswith("ConfigBitMode"):
            if i[1] == "frame_based":
                configBitMode = "frame_based"
            elif i[1] == "FlipFlopChain":
                configBitMode = "FlipFlopChain"
            else:
                raise ValueError(
                    f"Invalid config bit mode {i[1]} in parameters. Valid options are frame_based and FlipFlopChain")
        elif i[0].startswith("FrameBitsPerRow"):
            frameBitsPerRow = int(i[1])
        elif i[0].startswith("FrameBitsPerColumn"):
            maxFramesPerCol = int(i[1])
        elif i[0].startswith("Package"):
            package = i[1]
        elif i[0].startswith("GenerateDelayInSwitchMatrix"):
            generateDelayInSwitchMatrix = int(i[1])
        elif i[0].startswith("MultiplexerStyle"):
            if i[1] == "custom":
                multiplexerStyle = "custom"
            elif i[1] == "generic":
                multiplexerStyle = "generic"
            else:
                raise ValueError(
                    f"Invalid multiplexer style {i[1]} in parameters. Valid options are custom and generic")
        elif i[0].startswith("SuperTileEnable"):
            superTileEnable = i[1] == "TRUE"
        else:
            print("The parameters section contains an invalid parameter.")
            print("The following parameter is not valid:")
            print(i)
            exit(-1)
    height = len(fabricTiles)
    width = len(fabricTiles[0])

    return Fabric(tile=fabricTiles,
                  numberOfColumns=width,
                  numberOfRows=height,
                  configBitMode=configBitMode,
                  frameBitsPerRow=frameBitsPerRow,
                  maxFramesPerCol=maxFramesPerCol,
                  package=package,
                  generateDelayInSwitchMatrix=generateDelayInSwitchMatrix,
                  multiplexerStyle=multiplexerStyle,
                  numberOfBRAMs=int(height/2),
                  superTileEnable=superTileEnable,
                  tileDic=tileDic,
                  superTileDic=superTileDic)


def parseList(fileName: str) -> list:
    """
    Parses a list file and returns a list of tuples.
    """
    resultList = []
    with open(fileName, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
    file = file.split("\n")
    for i, line in enumerate(file):
        line = line.replace(" ", "").replace("\t", "").split(",")
        line = [i for i in line if i != ""]
        if not line:
            continue
        if len(line) != 2:
            print(line)
            print(
                f"Invalid list formatting in file: {fileName} at line {i}")
            exit(-1)
        left, right = line[0], line[1]

        leftList = []
        rightList = []
        expandListPorts(left, leftList)
        expandListPorts(right, rightList)
        resultList += list(zip(leftList, rightList))
    return list(set(resultList))


def expandListPorts(port, PortList):
    # a leading '[' tells us that we have to expand the list
    if "[" in port:
        if "]" not in port:
            raise ValueError(
                '\nError in function ExpandListPorts: cannot find closing ]\n')
        # port.find gives us the first occurrence index in a string
        left_index = port.find('[')
        right_index = port.find(']')
        before_left_index = port[0:left_index]
        # right_index is the position of the ']' so we need everything after that
        after_right_index = port[(right_index+1):]
        ExpandList = []
        ExpandList = re.split('\|', port[left_index+1:right_index])
        for entry in ExpandList:
            ExpandListItem = (before_left_index+entry+after_right_index)
            expandListPorts(ExpandListItem, PortList)

    else:
        # print('DEBUG: else, just:',port)
        PortList.append(port)
    return


def parseFileHDL(filename, belPrefix="", filter="ALL"):
    internal = []
    external = []
    config = []
    shared = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False

    with open(filename, "r") as f:
        file = f.read()

    portSection = ""
    if result := re.search(r"port.*?\((.*?)\);", file,
                           re.MULTILINE | re.DOTALL | re.IGNORECASE):
        portSection = result.group(1)
    else:
        raise ValueError(
            f"Could not find port section in file {filename}")

    preGlobal, postGlobal = portSection.split("-- GLOBAL")

    for line in preGlobal.split("\n"):
        if "IMPORTANT" in line:
            continue
        if "EXTERNAL" in line:
            isExternal = True
        if "CONFIG" in line:
            isConfig = True
        if "SHARED_PORT" in line:
            isShared = True

        line = re.sub(r"STD_LOGIC.*", "", line, flags=re.IGNORECASE)
        line = re.sub(r";.*", "", line, flags=re.IGNORECASE)
        line = re.sub(r"--*", "", line, flags=re.IGNORECASE)
        line = line.replace(" ", "").replace("\t", "").replace(";", "")
        result = re.search(r"(.*):(.*)", line)
        if not result:
            continue
        portName = f"{belPrefix}{result.group(1)}"

        if isExternal and not isShared:
            external.append((portName, result.group(2).lower()))
        elif isConfig:
            config.append((portName, result.group(2).lower()))
        elif isShared:
            # shared port do not have a prefix
            shared.append((result.group(1), result.group(2).lower()))
        else:
            internal.append((portName, result.group(2).lower()))

        if "UserCLK" in portName:
            userClk = True

        isExternal = False
        isConfig = False
        isShared = False

    result = re.search(
        r"NoConfigBits\s*:\s*integer\s*:=\s*(\w+)", file, re.IGNORECASE | re.DOTALL)
    if result:
        try:
            noConfigBits = int(result.group(1))
        except ValueError:
            print(f"NoConfigBits is not an integer: {result.group(1)}")
            print("Assume the number of configBits is 0")
            noConfigBits = 0
    else:
        print(f"Cannot find NoConfigBits in {filename}")
        print("Assume the number of configBits is 0")
        noConfigBits = 0

    return internal, external, config, shared, noConfigBits, userClk


# convert the matrix csv into a dictionary from destination to source
def parseMatrix(fileName, tileName):
    connectionsDic = {}
    with open(fileName, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
        file = file.split("\n")

    if file[0].split(",")[0] != tileName:
        raise ValueError(
            'ERROR: tile name (top left element) in csv file does not match tile name in tile object')

    destList = file[0].split(",")[1:]

    for i in file[1:]:
        i = i.split(",")
        portName, connections = i[0], i[1:]
        if portName == "":
            continue
        indices = [k for k, v in enumerate(connections) if v == "1"]
        connectionsDic[portName] = [destList[j] for j in indices]
    return connectionsDic


if __name__ == '__main__':
    # result = parseFabricCSV('fabric.csv')
    # result = parseList('RegFile_switch_matrix.list')
    # result = parseFileHDL('./OutPass4_frame_config.vhdl')
    # print(result.tile)
    # print(result.tileDic["W_IO"].portsInfo)
    pass
