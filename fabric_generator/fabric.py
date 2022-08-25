from dataclasses import dataclass, field
from typing import Any, Literal, List, Dict, Tuple
import math
from enum import Enum
import os


class IO(Enum):
    INPUT = "INPUT"
    OUTPUT = "OUTPUT"
    INOUT = "INOUT"
    NULL = "NULL"


class Direction(Enum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    JUMP = "JUMP"


class Side(Enum):
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST = "EAST"
    WEST = "WEST"
    ANY = "ANY"


class MultiplexerStyle(Enum):
    CUSTOM = "CUSTOM"
    GENERIC = "GENERIC"


class ConfigBitMode(Enum):
    FRAME_BASED = "FRAME_BASED"
    FLIPFLOP_CHAIN = "FLIPFLOP_CHAIN"


@dataclass(frozen=True, eq=True)
class Port():
    wireDirection: Direction
    sourceName: str
    xOffset: int
    yOffset: int
    destinationName: str
    wireCount: int
    name: str
    inOut: IO
    sideOfTile: Side
    # totalWireAmount: int

    # def __init__(self, direction, sourceName, xOffset, yOffset, destinationName, wires) -> None:
    #     self.wireDirection = direction
    #     self.sourceName = sourceName
    #     self.xOffset = xOffset
    #     self.yOffset = yOffset
    #     self.destinationName = destinationName
    #     self.wires = wires

    def __repr__(self) -> str:
        return f"wires:{self.wireCount} X_offset:{self.xOffset} Y_offset:{self.yOffset} source_name:{self.sourceName} destination_name:{self.destinationName}"

    def expandPortInfo(self, mode="SwitchMatrix"):
        inputs, outputs = [], []
        thisRange = 0
        openIndex = ""
        closeIndex = ""

        if "Indexed" in mode:
            openIndex = "("
            closeIndex = ")"

        # range (wires-1 downto 0) as connected to the switch matrix
        if mode == "SwitchMatrix" or mode == "SwitchMatrixIndexed":
            thisRange = self.wireCount
        elif mode == "AutoSwitchMatrix" or mode == "AutoSwitchMatrixIndexed":
            if self.sourceName == "NULL" or self.destinationName == "NULL":
                # the following line connects all wires to the switch matrix in the case one port is NULL (typically termination)
                thisRange = (
                    abs(self.xOffset)+abs(self.yOffset)) * self.wireCount
            else:
                # the following line connects all bottom wires to the switch matrix in the case begin and end ports are used
                thisRange = self.wireCount
        # range ((wires*distance)-1 downto 0) as connected to the tile top
        elif mode in ['all', 'allIndexed', 'Top', 'TopIndexed', 'AutoTop', 'AutoTopIndexed']:
            thisRange = (
                abs(self.xOffset)+abs(self.yOffset)) * self.wireCount

        # the following three lines are needed to get the top line[wires] that are actually the connection from a switch matrix to the routing fabric
        startIndex = 0
        if mode in ['Top', 'TopIndexed']:
            startIndex = (
                (abs(self.xOffset)+abs(self.yOffset))-1) * self.wireCount

        elif mode in ['AutoTop', 'AutoTopIndexed']:
            if self.sourceName == 'NULL' or self.destinationName == 'NULL':
                # in case one port is NULL, then the all the other port wires get connected to the switch matrix.
                startIndex = 0
            else:
                # "normal" case as for the CLBs
                startIndex = (
                    (abs(self.xOffset)+abs(self.yOffset))-1) * self.wireCount
        if startIndex == thisRange:
            thisRange = 1

        for i in range(startIndex, thisRange):
            if self.destinationName != "NULL":
                outputs.append(
                    f"{self.destinationName}{openIndex}{str(i)}{closeIndex}")
            # if self.sourceName == "NULL":
            #     print(self)
            if self.sourceName != "NULL":
                inputs.append(
                    f"{self.sourceName}{openIndex}{str(i)}{closeIndex}")
        return inputs, outputs


@dataclass(frozen=True, eq=True)
class Wire():
    direction: Direction
    source: str
    xOffset: int
    yOffset: int
    destination: str
    sourceTile: str
    destinationTile: str

    def __repr__(self) -> str:
        return f"{self.source}-X{self.xOffset}Y{self.yOffset}>{self.destination}"

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Wire):
            return False
        return self.source == __o.source and self.destination == __o.destination


@dataclass
class Bel():
    src: str
    prefix: str
    name: str
    inputs: List[str]
    outputs: List[str]
    externalInput: List[str]
    externalOutput: List[str]
    configPort: List[str]
    sharedPort: List[Tuple[str, IO]]
    configBit: int
    belFeatureMap: Dict[str, dict] = field(default_factory=dict)
    withUserCLK: bool = False

    def __init__(self, src: str, prefix: str, internal, external, configPort, sharedPort, configBit: int, belMap: Dict[str, dict], userCLK:bool) -> None:
        self.src = src
        self.prefix = prefix
        self.name = src.split("/")[-1].split(".")[0]
        self.inputs = [p for p, io in internal if io == IO.INPUT]
        self.outputs = [p for p, io in internal if io == IO.OUTPUT]
        self.externalInput = [p for p, io in external if io == IO.INPUT]
        self.externalOutput = [p for p, io in external if io == IO.OUTPUT]
        self.configPort = configPort
        self.sharedPort = sharedPort
        self.configBit = configBit
        self.belFeatureMap = belMap
        self.withUserCLK = userCLK


@dataclass(frozen=True, eq=True)
class ConfigMem():
    frameName: str
    frameIndex: int
    bitsUsedInFrame: int
    usedBitMask: str
    configBitRanges: List[int] = field(default_factory=list)


@dataclass
class Tile():
    name: str
    portsInfo: List[Port]
    bels: List[Bel]
    matrixDir: str
    globalConfigBits: int = 0
    withUserCLK: bool = False
    wireList: List[Wire] = field(default_factory=list)
    filePath: str = "."

    # def __repr__(self):
    #     return f"\n{self.name}\n inputPorts:{self.inputs}\n outputPorts:{self.outputs}\n bels:{self.bels}\n Matrix_dir:{self.matrixDir}\n"

    def __init__(self, name: str, ports: List[Port], bels: List[Bel], matrixDir: str, userCLK: bool, configBit: int = 0) -> None:
        self.name = name
        self.portsInfo = ports
        self.bels = bels
        self.matrixDir = matrixDir
        self.withUserCLK = userCLK
        self.globalConfigBits = configBit
        self.wireList = []
        self.filePath = os.path.split(matrixDir)[0]

        for b in self.bels:
            self.globalConfigBits += b.configBit

    def __eq__(self, __o: Any) -> bool:
        if __o is None or not isinstance(__o, Tile):
            return False
        return self.name == __o.name

    def getWestSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == Side.WEST and p.name != "NULL"]

    def getEastSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == Side.EAST and p.name != "NULL"]

    def getNorthSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == Side.NORTH and p.name != "NULL"]

    def getSouthSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == Side.SOUTH and p.name != "NULL"]

    def getNorthPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == Direction.NORTH]))

    def getSouthPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == Direction.SOUTH]))

    def getEastPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == Direction.EAST]))

    def getWestPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == Direction.WEST]))

    def getTileInputNames(self) -> List[str]:
        return [p.destinationName for p in self.portsInfo if p.destinationName != "NULL" and p.wireDirection != Direction.JUMP]

    def getTileOutputNames(self) -> List[str]:
        return [p.sourceName for p in self.portsInfo if p.sourceName != "NULL" and p.wireDirection != Direction.JUMP]


@ dataclass
class SuperTile():
    name: str
    tiles: List[Tile]
    tileMap: List[List[Tile]]
    bels: List[Bel] = field(default_factory=list)
    withUserCLK: bool = False

    def getPortsAroundTile(self) -> Dict[str, List[List[Port]]]:
        ports = {}
        for y, row in enumerate(self.tileMap):
            for x, tile in enumerate(row):
                if self.tileMap[y][x] == None:
                    continue
                ports[f"{x}{y}"] = []
                if y - 1 < 0 or self.tileMap[y-1][x] == None:
                    ports[f"{x}{y}"].append(tile.getNorthSidePorts())
                if x + 1 >= len(self.tileMap[y]) or self.tileMap[y][x+1] == None:
                    ports[f"{x}{y}"].append(tile.getEastSidePorts())
                if y + 1 >= len(self.tileMap) or self.tileMap[y+1][x] == None:
                    ports[f"{x}{y}"].append(tile.getSouthSidePorts())
                if x - 1 < 0 or self.tileMap[y][x-1] == None:
                    ports[f"{x}{y}"].append(tile.getWestSidePorts())
        return ports

    def getInternalConnections(self) -> List[Tuple[List[Port], int, int]]:
        internalConnections = []
        for y, row in enumerate(self.tileMap):
            for x, tile in enumerate(row):
                if 0 <= y - 1 < len(self.tileMap) and self.tileMap[y-1][x] != None:
                    internalConnections.append(
                        (tile.getNorthSidePorts(), x, y))
                if 0 <= x + 1 < len(self.tileMap[0]) and self.tileMap[y][x+1] != None:
                    internalConnections.append(
                        (tile.getEastSidePorts(), x, y))
                if 0 <= y + 1 < len(self.tileMap) and self.tileMap[y+1][x] != None:
                    internalConnections.append(
                        (tile.getSouthSidePorts(), x, y))
                if 0 <= x - 1 < len(self.tileMap[0]) and self.tileMap[y][x-1] != None:
                    internalConnections.append(
                        (tile.getWestSidePorts(), x, y))
        return internalConnections


@ dataclass
class Fabric():
    tile: List[List[Tile]] = field(default_factory=list)

    name: str = "eFPGA"
    numberOfRows: int = 15
    numberOfColumns: int = 15
    configBitMode: ConfigBitMode = ConfigBitMode.FRAME_BASED
    frameBitsPerRow: int = 32
    maxFramesPerCol: int = 20
    package: str = "use work.my_package.all"
    generateDelayInSwitchMatrix: int = 80
    multiplexerStyle: MultiplexerStyle = MultiplexerStyle.CUSTOM
    frameSelectWidth: int = 5
    rowSelectWidth: int = 5
    desync_flag: int = 20
    numberOfBRAMs: int = 10
    superTileEnable: bool = True

    tileDic: Dict[str, Tile] = field(default_factory=dict)
    superTileDic: Dict[str, SuperTile] = field(default_factory=dict)
    # wires: List[Wire] = field(default_factory=list)
    commonWirePair: List[Tuple[str, str]] = field(default_factory=list)

    def __post_init__(self) -> None:
        for row in self.tile:
            for tile in row:
                if tile == None:
                    continue
                for port in tile.portsInfo:
                    self.commonWirePair.append(
                        (port.sourceName, port.destinationName))

        self.commonWirePair = list(dict.fromkeys(self.commonWirePair))
        self.commonWirePair = [
            (i, j) for i, j in self.commonWirePair if i != "NULL" and j != "NULL"]

        for y, row in enumerate(self.tile):
            for x, tile in enumerate(row):
                if tile == None:
                    continue
                for port in tile.portsInfo:
                    if abs(port.xOffset) <= 1 and abs(port.yOffset) <= 1 and port.sourceName != "NULL" and port.destinationName != "NULL":
                        for i in range(port.wireCount):
                            tile.wireList.append(Wire(direction=port.wireDirection,
                                                      source=f"{port.sourceName}{i}",
                                                      xOffset=port.xOffset,
                                                      yOffset=port.yOffset,
                                                      destination=f"{port.destinationName}{i}",
                                                      sourceTile="",
                                                      destinationTile=""))
                    elif port.sourceName != "NULL" and port.destinationName != "NULL":
                        # clamp the xOffset to 1 or -1
                        value = min(max(port.xOffset, -1), 1)
                        cascadedI = 0
                        for i in range(port.wireCount*abs(port.xOffset)):
                            if i < port.wireCount:
                                cascadedI = i + port.wireCount * \
                                    (abs(port.xOffset)-1)
                            else:
                                cascadedI = i - port.wireCount
                                tile.wireList.append(Wire(direction=Direction.JUMP,
                                                          source=f"{port.destinationName}{i}",
                                                          xOffset=0,
                                                          yOffset=0,
                                                          destination=f"{port.sourceName}{i}",
                                                          sourceTile=f"X{x}Y{y}",
                                                          destinationTile=f"X{x}Y{y}"))
                            tile.wireList.append(Wire(direction=port.wireDirection,
                                                      source=f"{port.sourceName}{i}",
                                                      xOffset=value,
                                                      yOffset=port.yOffset,
                                                      destination=f"{port.destinationName}{cascadedI}",
                                                      sourceTile=f"X{x}Y{y}",
                                                      destinationTile=f"X{x+value}Y{y+port.yOffset}"))

                        # clamp the yOffset to 1 or -1
                        value = min(max(port.yOffset, -1), 1)
                        cascadedI = 0
                        for i in range(port.wireCount*abs(port.yOffset)):
                            if i < port.wireCount:
                                cascadedI = i + port.wireCount * \
                                    (abs(port.yOffset)-1)
                            else:
                                cascadedI = i - port.wireCount
                                tile.wireList.append(Wire(direction=Direction.JUMP,
                                                          source=f"{port.destinationName}{i}",
                                                          xOffset=0,
                                                          yOffset=0,
                                                          destination=f"{port.sourceName}{i}",
                                                          sourceTile=f"X{x}Y{y}",
                                                          destinationTile=f"X{x}Y{y}"))
                            tile.wireList.append(Wire(direction=port.wireDirection,
                                                      source=f"{port.sourceName}{i}",
                                                      xOffset=port.xOffset,
                                                      yOffset=value,
                                                      destination=f"{port.destinationName}{cascadedI}",
                                                      sourceTile=f"X{x}Y{y}",
                                                      destinationTile=f"X{x+port.xOffset}Y{y+value}"))
                    elif port.sourceName != "NULL" and port.destinationName == "NULL":
                        sourceName = port.sourceName
                        destName = ""
                        try:
                            index = [i for i, _ in self.commonWirePair].index(
                                port.sourceName)
                            sourceName = self.commonWirePair[index][0]
                            destName = self.commonWirePair[index][1]
                        except:
                            # if is not in a common pair wire we assume the source name is same as destination name
                            destName = sourceName

                        value = min(max(port.xOffset, -1), 1)
                        for i in range(port.wireCount*abs(port.xOffset)):
                            tile.wireList.append(Wire(direction=port.wireDirection,
                                                      source=f"{sourceName}{i}",
                                                      xOffset=value,
                                                      yOffset=port.yOffset,
                                                      destination=f"{destName}{i}",
                                                      sourceTile=f"X{x}Y{y}",
                                                      destinationTile=f"X{x+value}Y{y+port.yOffset}"))

                        value = min(max(port.yOffset, -1), 1)
                        for i in range(port.wireCount*abs(port.yOffset)):
                            tile.wireList.append(Wire(direction=port.wireDirection,
                                                      source=f"{sourceName}{i}",
                                                      xOffset=port.xOffset,
                                                      yOffset=value,
                                                      destination=f"{destName}{i}",
                                                      sourceTile=f"X{x}Y{y}",
                                                      destinationTile=f"X{x+port.xOffset}Y{y+value}"))
                tile.wireList = list(dict.fromkeys(tile.wireList))

    def __repr__(self) -> str:
        fabric = ""
        for i in range(self.numberOfColumns):
            for j in range(self.numberOfRows):
                if self.tile[i][j] is None:
                    fabric += "Null".ljust(15)+"\t"
                else:
                    fabric += f"{str(self.tile[i][j].name).ljust(15)}\t"
            fabric += "\n"

        fabric += f"\n"
        fabric += f"numberOfColumns: {self.numberOfColumns}\n"
        fabric += f"numberOfRows: {self.numberOfRows}\n"
        fabric += f"configBitMode: {self.configBitMode}\n"
        fabric += f"frameBitsPerRow: {self.frameBitsPerRow}\n"
        fabric += f"frameBitsPerColumn: {self.maxFramesPerCol}\n"
        fabric += f"package: {self.package}\n"
        fabric += f"generateDelayInSwitchMatrix: {self.generateDelayInSwitchMatrix}\n"
        fabric += f"multiplexerStyle: {self.multiplexerStyle}\n"
        fabric += f"superTileEnable: {self.superTileEnable}\n"
        fabric += f"tileDic: {list(self.tileDic.keys())}\n"
        return fabric

    def getTileByName(self, name: str) -> Tile:
        return self.tileDic[name]

    def getSuperTileByName(self, name: str) -> SuperTile:
        return self.superTileDic[name]
