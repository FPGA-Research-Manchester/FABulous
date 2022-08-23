import re
from copy import deepcopy
from typing import Dict, List, Literal, Tuple, Union
import csv
import os

from fabric_generator.fabric import Fabric, Port, Bel, Tile, SuperTile, ConfigMem
from fabric_generator.fabric import IO, Direction, Side, MultiplexerStyle, ConfigBitMode

# from fabric import Fabric, Port, Bel, Tile, SuperTile, ConfigMem
# from fabric import IO, Direction, Side, MultiplexerStyle, ConfigBitMode


oppositeDic = {"NORTH": "SOUTH", "SOUTH": "NORTH",
               "EAST": "WEST", "WEST": "EAST"}


def parseFabricCSV(fileName: str) -> Fabric:
    """
    Parses a csv file and returns a Fabric object.
    """
    if not fileName.endswith(".csv"):
        raise ValueError("File must be a csv file")

    if not os.path.exists(fileName):
        raise ValueError(f"File {fileName} does not exist")

    filePath, _ = os.path.split(os.path.abspath(fileName))

    with open(fileName, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)

    # read in the csv file and part them
    if fabricDescription := re.search(
            r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL):
        fabricDescription = fabricDescription.group(1)
    else:
        raise ValueError(
            'Cannot find FabricBegin and FabricEnd in csv file')

    if parameters := re.search(
            r"ParametersBegin(.*?)ParametersEnd", file, re.MULTILINE | re.DOTALL):
        parameters = parameters.group(1)
    else:
        raise ValueError(
            'Cannot find ParametersBegin and ParametersEnd in csv file')

    tilesData = re.findall(r"TILE(.*?)EndTILE", file,
                           re.MULTILINE | re.DOTALL)

    superTile = re.findall(r"SuperTILE(.*?)EndSuperTILE",
                           file, re.MULTILINE | re.DOTALL)

    # parse the tile description
    fabricDescription = fabricDescription.split("\n")
    parameters = parameters.split("\n")
    tileTypes = []
    tileDefs = []
    commonWirePair: List[Tuple[str, str]] = []
    for t in tilesData:
        t = t.split("\n")
        tileName = t[0].split(",")[1]
        tileTypes.append(tileName)
        ports: List[Port] = []
        bels: List[Bel] = []
        matrixDir = ""
        withUserCLK = False
        configBit = 0
        for item in t:
            temp: List[str] = item.split(",")
            if not temp or temp[0] == "":
                continue
            if temp[0] in ["NORTH", "SOUTH", "EAST", "WEST"]:
                ports.append(Port(Direction[temp[0]], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.OUTPUT, Side[temp[0]]))

                ports.append(Port(Direction[temp[0]], temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[4], IO.INPUT, Side[oppositeDic[temp[0]].upper()]))
                # wireCount = (abs(int(temp[2])) +
                #              abs(int(temp[3])))*int(temp[5])
                # for i in range(wireCount):
                commonWirePair.append(
                    (f"{temp[1]}", f"{temp[4]}"))

            elif temp[0] == "JUMP":
                ports.append(Port(Direction.JUMP, temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.OUTPUT, Side.ANY))
                ports.append(Port(Direction.JUMP, temp[1], int(
                    temp[2]), int(temp[3]), temp[4], int(temp[5]), temp[1], IO.INOUT, Side.ANY))
            elif temp[0] == "BEL":
                belFilePath = os.path.join(filePath, temp[1])
                if temp[1].endswith(".vhdl"):
                    result = parseFileVHDL(belFilePath, temp[2])
                elif temp[1].endswith(".v"):
                    result = parseFileVerilog(belFilePath, temp[2])
                else:
                    raise ValueError(
                        "Invalid file type, only .vhdl and .v are supported")
                internal, external, config, shared, configBit, userClk, belMap = result
                bels.append(Bel(belFilePath, temp[2], internal,
                            external, config, shared, configBit, belMap))
                withUserCLK |= userClk
            elif temp[0] == "MATRIX":
                matrixDir = os.path.join(filePath, temp[1])
                configBit = 0
                if temp[1].endswith(".list"):
                    for _, v in parseList(matrixDir, "source").items():
                        muxSize = len(v)
                        if muxSize >= 2:
                            configBit += muxSize.bit_length()-1
                elif temp[1].endswith("_matrix.csv"):
                    for _, v in parseMatrix(matrixDir, tileName).items():
                        muxSize = len(v)
                        if muxSize >= 2:
                            configBit += muxSize.bit_length()-1
                elif temp[1].endswith(".vhdl") or temp[1].endswith(".v"):
                    with open(matrixDir, "r") as f:
                        f = f.read()
                        if configBit := re.search(r"NumberOfConfigBits: (\d+)", f):
                            configBit = int(configBit.group(1))
                        else:
                            configBit = 0
                            print(
                                f"Cannot find NumberOfConfigBits in {matrixDir} assume 0 config bits")

                else:
                    raise ValueError(
                        'Unknown file extension for matrix')
            else:
                raise ValueError(
                    f"Unknown tile description {temp[0]} in tile {t}")

        tileDefs.append(Tile(tileName, ports, bels,
                        matrixDir, withUserCLK, configBit))

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
                belFilePath = os.path.join(filePath, line[1])
                if line[0].endswith("VHDL"):
                    result = parseFileVHDL(belFilePath, line[2])
                else:
                    result = parseFileVerilog(belFilePath, line[2])
                internal, external, config, shared, configBit, userClk, belMap = result
                bels.append(Bel(belFilePath, line[2], internal,
                            external, config, shared, configBit, belMap))
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

    commonWirePair = list(dict.fromkeys(commonWirePair))
    commonWirePair = [(i, j) for (
        i, j) in commonWirePair if "NULL" not in i and "NULL" not in j]

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
                  superTileDic=superTileDic,
                  commonWirePair=commonWirePair)


def parseList(fileName: str, collect: Literal["", "source", "sink"] = "") -> Union[List[Tuple[str, str]], Dict[str, List[str]]]:
    """
    Parses a list file and returns a list of tuples.
    """

    if not os.path.exists(fileName):
        raise ValueError(f"The file {fileName} does not exist.")

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
            raise ValueError(
                f"Invalid list formatting in file: {fileName} at line {i}")
        left, right = line[0], line[1]

        leftList = []
        rightList = []
        _expandListPorts(left, leftList)
        _expandListPorts(right, rightList)
        resultList += list(zip(leftList, rightList))

    result = list(dict.fromkeys(resultList))
    resultDic = {}
    if collect == "source":
        for k, v in result:
            if k not in resultDic:
                resultDic[k] = []
            resultDic[k].append(v)
        return resultDic

    if collect == "sink":
        for k, v in result:
            for i in v:
                if i not in resultDic:
                    resultDic[i] = []
                resultDic[i].append(k)
        return resultDic

    return result


def _expandListPorts(port, PortList):
    # a leading '[' tells us that we have to expand the list
    if "[" in port:
        if "]" not in port:
            raise ValueError(
                '\nError in function ExpandListPorts: cannot find closing ]\n')
        # port.find gives us the first occurrence index in a string
        left_index = port.find("[")
        right_index = port.find("]")
        before_left_index = port[0:left_index]
        # right_index is the position of the ']' so we need everything after that
        after_right_index = port[(right_index+1):]
        ExpandList = []
        ExpandList = re.split(r"\|", port[left_index+1:right_index])
        for entry in ExpandList:
            ExpandListItem = (before_left_index+entry+after_right_index)
            _expandListPorts(ExpandListItem, PortList)

    else:
        # print('DEBUG: else, just:',port)
        PortList.append(port)
    return


def parseFileVHDL(filename: str, belPrefix: str = "") -> Tuple[List[Tuple[str, IO]], List[Tuple[str, IO]], List[Tuple[str, IO]], List[Tuple[str, IO]], int, bool, Dict[str, int]]:
    internal: List[Tuple[str, IO]] = []
    external: List[Tuple[str, IO]] = []
    config: List[Tuple[str, IO]] = []
    shared: List[Tuple[str, IO]] = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False

    try:
        with open(filename, "r") as f:
            file = f.read()
    except FileNotFoundError:
        print(f"File {filename} not found.")
        exit(-1)
    except PermissionError:
        print(f"Permission denied to file {filename}.")
        exit(-1)

    belMapDic = {}
    if result := re.search(r"-- pragma FABulous belMap (.*)", file):
        result = result.group(1).split(",")
        for i in result:
            key, value = i.split("=")
            belMapDic[key.replace(" ", "")] = int(value)

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

    return internal, external, config, shared, noConfigBits, userClk, belMapDic


def parseFileVerilog(filename: str, belPrefix: str = "") -> Tuple[List[Tuple[str, IO]], List[Tuple[str, IO]], List[Tuple[str, IO]], List[Tuple[str, IO]], int, bool, Dict[str, dict]]:
    internal: List[Tuple[str, IO]] = []
    external: List[Tuple[str, IO]] = []
    config: List[Tuple[str, IO]] = []
    shared: List[Tuple[str, IO]] = []
    isExternal = False
    isConfig = False
    isShared = False
    userClk = False
    noConfigBits = 0

    try:
        with open(filename, "r") as f:
            file = f.read()
    except FileNotFoundError:
        print(f"File {filename} not found.")
        exit(-1)
    except PermissionError:
        print(f"Permission denied to file {filename}.")
        exit(-1)

    belEnumsDic = {}
    if belEnums := re.findall(r"\(\*.*?FABulous,.*?BelEnum,(.*?)\*\)", file, re.DOTALL | re.MULTILINE):
        for enums in belEnums:
            enums = enums.replace("\n", "").replace(" ", "").replace("\t", "")
            enums = enums.split(",")
            enums = [i for i in enums if i != "" and i != " "]
            if enumParse := re.search(r"(.*?)\[(\d+):(\d+)\]", enums[0]):
                name = enumParse.group(1)
                start = int(enumParse.group(2))
                end = int(enumParse.group(3))
            else:
                raise ValueError(
                    f"Invalid enum {enums[0]} in file {filename}")
            belEnumsDic[name] = {}
            for i in enums[1:]:
                key, value = i.split("=")
                belEnumsDic[name][key] = {}
                bitValue = list(value)
                if start > end:
                    for j in range(start, end - 1, -1):
                        belEnumsDic[name][key][j] = bitValue.pop(0)
                else:
                    for j in range(start, end + 1):
                        belEnumsDic[name][key][j] = bitValue.pop(0)

    belMapDic = {}
    if belMap := re.search(r"\(\*.*FABulous,.*?BelMap,(.*?)\*\)", file, re.DOTALL | re.MULTILINE):
        belMap = belMap.group(1)
        belMap = belMap.replace("\n", "").replace(" ", "").replace("\t", "")
        belMap = belMap.split(",")
        belMap = [i for i in belMap if i != "" and i != " "]
        for bel in belMap:
            bel = bel.split("=")
            belMapDic[bel[0]] = {}
            if bel == ['']:
                continue
            if bel[0] in list(belEnumsDic.keys()):
                belMapDic[bel[0]] = belEnumsDic[bel[0]]
            elif ":" in bel[1]:
                start, end = bel[1].split(":")
                start, end = int(start), int(end)
                if start > end:
                    length = start - end + 1
                    for i in range(2**length-1, -1, -1):
                        belMapDic[bel[0]][i] = {}
                        bitMap = list(f"{i:0{length.bit_length()}b}")
                        for v in range(len(bitMap)-1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
                else:
                    length = end - start + 1
                    for i in range(0, 2**length):
                        belMapDic[bel[0]][i] = {}
                        bitMap = list(
                            f"{2**length-i-1:0{length.bit_length()}b}")
                        for v in range(len(bitMap)-1, -1, -1):
                            belMapDic[bel[0]][i][v] = bitMap.pop(0)
            else:
                belMapDic[bel[0]][0] = {0: '1'}

    if result := re.search(r"NoConfigBits.*?=.*?(\d+)", file, re.IGNORECASE):
        noConfigBits = int(result.group(1))
    else:
        print(f"Cannot find NoConfigBits in {filename}")
        print("Assume the number of configBits is 0")
        noConfigBits = 0

    if len(belMapDic) != noConfigBits:
        raise ValueError(
            f"NoConfigBits does not match with the BEL map in file {filename}, length of BelMap is {len(belMapDic)}, but with {noConfigBits} config bits")

    file = file.split("\n")

    for line in file:
        if result := re.search(r".*(input|output|inout).*?(\w+);", line, re.IGNORECASE):
            cleanedLine = line.replace(" ", "")
            if attribute := re.search(r"\(\*FABulous,(.*)\*\)", cleanedLine):
                if "EXTERNAL" in attribute.group(1):
                    isExternal = True

                if "CONFIG" in attribute.group(1):
                    isConfig = True

                if "SHARED_PORT" in attribute.group(1):
                    isShared = True

                if "GLOBAL" in attribute.group(1):
                    break

            portName = f"{belPrefix}{result.group(2)}"

            if isExternal and not isShared:
                external.append((portName, IO[result.group(1).upper()]))
            elif isConfig:
                config.append((portName, IO[result.group(1).upper()]))
            elif isShared:
                # shared port do not have a prefix
                shared.append((result.group(2), IO[result.group(1).upper()]))
            else:
                internal.append((portName, IO[result.group(1).upper()]))

            if "UserCLK" in portName:
                userClk = True

            isExternal = False
            isConfig = False
            isShared = False

    return internal, external, config, shared, noConfigBits, userClk, belMapDic


# convert the matrix csv into a dictionary from destination to source
def parseMatrix(fileName: str, tileName: str) -> Dict[str, List[str]]:
    connectionsDic = {}
    with open(fileName, 'r') as f:
        file = f.read()
        file = re.sub(r"#.*", "", file)
        file = file.split("\n")

    if file[0].split(",")[0] != tileName:
        print(fileName)
        print(file[0].split(","))
        print(tileName)
        raise ValueError(
            'Tile name (top left element) in csv file does not match tile name in tile object')

    destList = file[0].split(",")[1:]

    for i in file[1:]:
        i = i.split(",")
        portName, connections = i[0], i[1:]
        if portName == "":
            continue
        indices = [k for k, v in enumerate(connections) if v == "1"]
        connectionsDic[portName] = [destList[j] for j in indices]
    return connectionsDic


def parseConfigMem(fileName: str, maxFramePerCol: int, frameBitPerRow: int, globalConfigBits: int) -> List[ConfigMem]:
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
    # result1 = parseList('RegFile_switch_matrix.list', collect="source")
    # result = parseFileVerilog('./LUT4c_frame_config_dffesr.v')

    result2 = parseFileVerilog("./test.txt")
    # print(result[0])
    # print(result[1])
    # print(result[2])
    # print(result[3])

    # print(result.tileDic["W_IO"].portsInfo)
