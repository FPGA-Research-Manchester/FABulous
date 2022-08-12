from fabric import Fabric, Port, Bel, Tile, SuperTile, ConfigMem
import re
from copy import deepcopy
from typing import List, Literal, Tuple
import csv

from fabric import IO, Direction, Side, MultiplexerStyle, ConfigBitMode

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
                ports.append(Port(Direction[temp[0]], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.OUTPUT, Side[temp[0]]))

                ports.append(Port(Direction[temp[0]], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[4], IO.INPUT, Side[oppositeDic[temp[0]].upper()]))
            elif temp[0] == "JUMP":
                ports.append(Port(Direction.JUMP, temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.OUTPUT, Side.ANY))
                ports.append(Port(Direction.JUMP, temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.INOUT, Side.ANY))
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
    configBitMode = ConfigBitMode.FRAME_BASED
    frameBitsPerRow = 32
    maxFramesPerCol = 20
    package = "use work.my_package.all;"
    generateDelayInSwitchMatrix = 80
    multiplexerStyle = MultiplexerStyle.CUSTOM
    superTileEnable = True

    for i in parameters:
        i = i.split(",")
        i = [j for j in i if j != ""]
        if not i:
            continue
        if i[0].startswith("ConfigBitMode"):
            if i[1] == "frame_based":
                configBitMode = ConfigBitMode.FRAME_BASED
            elif i[1] == "FlipFlopChain":
                configBitMode = ConfigBitMode.FLIPFLOP_CHAIN
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
                multiplexerStyle = MultiplexerStyle.CUSTOM
            elif i[1] == "generic":
                multiplexerStyle = MultiplexerStyle.GENERIC
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
    internal: List[Tuple[str, IO]] = []
    external: List[Tuple[str, IO]] = []
    config: List[Tuple[str, IO]] = []
    shared: List[Tuple[str, IO]] = []
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
            if result.group(2).lower() == "in":
                external.append((portName, IO.INPUT))
            elif result.group(2).lower() == "out":
                external.append((portName, IO.OUTPUT))
        elif isConfig:
            if result.group(2).lower() == "in":
                config.append((portName, IO.INPUT))
            elif result.group(2).lower() == "out":
                config.append((portName, IO.OUTPUT))
        elif isShared:
            # shared port do not have a prefix
            if result.group(2).lower() == "in":
                shared.append((result.group(1), IO.INOUT))
            elif result.group(2).lower() == "out":
                shared.append((result.group(1), IO.OUTPUT))
            elif result.group(2).lower() == "inout":
                shared.append((result.group(1), IO.INOUT))
            else:
                raise ValueError(
                    f"Invalid port type {result.group(2)} in file {filename}")
        else:
            if result.group(2).lower() == "in":
                internal.append((portName, IO.INPUT))
            elif result.group(2).lower() == "out":
                internal.append((portName, IO.OUTPUT))
            elif result.group(2).lower() == "inout":
                internal.append((portName, IO.INOUT))
            else:
                raise ValueError(
                    f"Invalid port type {result.group(2)} in file {filename}")

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


def parseConfigMem(fileName, maxFramePerCol, frameBitPerRow, globalConfigBits):
    with open(fileName) as f:
        mappingFile = list(csv.DictReader(f))

        # remove the pretty print from used_bits_mask
        for i, _ in enumerate(mappingFile):
            mappingFile[i]["used_bits_mask"] = mappingFile[i]["used_bits_mask"].replace(
                "_", "")

        # we should have as many lines as we have frames (=framePerCol)
        if len(mappingFile) != maxFramePerCol:
            raise ValueError(
                f"WARNING: the bitstream mapping file has only {len(mappingFile)} entries but MaxFramesPerCol is {maxFramePerCol}")

        # we also check used_bits_mask (is a vector that is as long as a frame and contains a '1' for a bit used and a '0' if not used (padded)
        usedBitsCounter = 0
        for entry in mappingFile:
            if entry["used_bits_mask"].count("1") > frameBitPerRow:
                raise ValueError(
                    f"bitstream mapping file {fileName} has to many 1-elements in bitmask for frame : {entry['frame_name']}")
            if len(entry["used_bits_mask"]) != frameBitPerRow:
                raise ValueError(
                    f"bitstream mapping file {fileName} has has a too long or short bitmask for frame : {entry['frame_name']}")
            usedBitsCounter += entry["used_bits_mask"].count("1")

        if usedBitsCounter != globalConfigBits:
            raise ValueError(
                f"bitstream mapping file {fileName} has a bitmask miss match; bitmask has in total {usedBitsCounter} 1-values for {globalConfigBits} bits")

        allConfigBitsOrder = []
        configMemEntry = []
        for entry in mappingFile:
            configBitsOrder = []
            entry["ConfigBits_ranges"] = entry["ConfigBits_ranges"].replace(
                " ", "").replace("\t", "")

            if ":" in entry["ConfigBits_ranges"]:
                left, right = re.split(':', entry["ConfigBits_ranges"])
                # check the order of the number, if right is smaller than left, then we swap them
                left, right = int(left), int(right)
                if right < left:
                    left, right = right, left
                    numList = list(reversed(range(left, right + 1)))
                else:
                    numList = list(range(left, right + 1))

                for i in numList:
                    if i in allConfigBitsOrder:
                        raise ValueError(
                            f"Configuration bit index {i} already allocated in {fileName}, {entry['frame_name']}")
                    configBitsOrder.append(i)

            elif ";" in entry["ConfigBits_ranges"]:
                for item in entry["ConfigBits_ranges"].split(";"):
                    if int(item) in allConfigBitsOrder:
                        raise ValueError(
                            f"Configuration bit index {item} already allocated in {fileName}, {entry['frame_name']}")
                    configBitsOrder.append(int(item))

            elif "NULL" in entry["ConfigBits_ranges"]:
                continue

            else:
                raise ValueError(
                    f"Range {entry['ConfigBits_ranges']} is not a valid format. It should be in the form [int]:[int] or [int]. If there are multiple ranges it should be separated by ';'")

            allConfigBitsOrder += configBitsOrder

            if entry["used_bits_mask"].count("1") > 0:
                configMemEntry.append(ConfigMem(frameName=entry["frame_name"],
                                                frameIndex=int(
                                                    entry["frame_index"]),
                                                bitsUsedInFrame=entry["used_bits_mask"].count(
                                                    "1"),
                                                usedBitMask=entry["used_bits_mask"],
                                                configBitRanges=configBitsOrder))

    return configMemEntry


if __name__ == '__main__':
    # result = parseFabricCSV('fabric.csv')
    # result = parseList('RegFile_switch_matrix.list')
    # result = parseFileHDL('./OutPass4_frame_config.vhdl')
    # print(result.tile)
    # print(result.tileDic["W_IO"].portsInfo)
    pass
