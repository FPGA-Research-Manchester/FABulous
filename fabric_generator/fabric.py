from dataclasses import dataclass, field
from typing import Literal, List, Dict


@dataclass(frozen=True, eq=True)
class Port():
    wireDirection: Literal["NORTH", "SOUTH", "EAST", "WEST", "JUMP"]
    sourceName: str
    xOffset: int
    yOffset: int
    destinationName: str
    wires: int
    name: str
    inOut: Literal["IN", "OUT", "NULL"]
    sideOfTile: Literal["NORTH", "SOUTH", "EAST", "WEST", "ANY"]
    # totalWireAmount: int

    # def __init__(self, direction, sourceName, xOffset, yOffset, destinationName, wires) -> None:
    #     self.wireDirection = direction
    #     self.sourceName = sourceName
    #     self.xOffset = xOffset
    #     self.yOffset = yOffset
    #     self.destinationName = destinationName
    #     self.wires = wires

    def __repr__(self) -> str:
        return f"wires:{self.wires} X_offset:{self.xOffset} Y_offset:{self.yOffset} source_name:{self.sourceName} destination_name:{self.destinationName}"

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
            thisRange = self.wires
        elif mode == "AutoSwitchMatrix" or mode == "AutoSwitchMatrixIndexed":
            if self.sourceName == "NULL" or self.destinationName == "NULL":
                # the following line connects all wires to the switch matrix in the case one port is NULL (typically termination)
                thisRange = (
                    abs(self.xOffset)+abs(self.yOffset)) * self.wires
            else:
                # the following line connects all bottom wires to the switch matrix in the case begin and end ports are used
                thisRange = self.wires
        # range ((wires*distance)-1 downto 0) as connected to the tile top
        elif mode in ['all', 'allIndexed', 'Top', 'TopIndexed', 'AutoTop', 'AutoTopIndexed']:
            thisRange = (
                abs(self.xOffset)+abs(self.yOffset)) * self.wires

        # the following three lines are needed to get the top line[wires] that are actually the connection from a switch matrix to the routing fabric
        startIndex = 0
        if mode in ['Top', 'TopIndexed']:
            startIndex = (
                (abs(self.xOffset)+abs(self.yOffset))-1) * self.wires

        elif mode in ['AutoTop', 'AutoTopIndexed']:
            if self.sourceName == 'NULL' or self.destinationName == 'NULL':
                # in case one port is NULL, then the all the other port wires get connected to the switch matrix.
                startIndex = 0
            else:
                # "normal" case as for the CLBs
                startIndex = (
                    (abs(self.xOffset)+abs(self.yOffset))-1) * self.wires
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
    sharedPort: List[str]
    configBit: int

    def __init__(self, src, prefix, internal, external, configPort, sharedPort, configBit):
        self.src = src
        self.prefix = prefix
        self.name = src.split("/")[-1].split(".")[0]
        self.inputs = [p for p, io in internal if io == "in"]
        self.outputs = [p for p, io in internal if io == "out"]
        self.externalInput = [p for p, io in external if io == "in"]
        self.externalOutput = [p for p, io in external if io == "out"]
        self.configPort = configPort
        self.sharedPort = sharedPort
        self.configBit = configBit


@dataclass
class Tile():
    name: str
    portsInfo: List[Port]
    bels: List[Bel]
    matrixDir: str
    inputs: List[str]
    outputs: List[str]
    internalInputs: List[str]
    internalOutputs: List[str]
    jumps: List[str]
    belInputs: List[str]
    belOutputs: List[str]
    globalConfigBits: int = 0
    withUserCLK: bool = False

    def __repr__(self):
        return f"\n{self.name}\n inputPorts:{self.inputs}\n outputPorts:{self.outputs}\n bels:{self.bels}\n Matrix_dir:{self.matrixDir}\n"

    def __init__(self, name: str, ports: List[Port], bels: List[Bel], matrixDir: str, userCLK: bool) -> None:
        self.name = name
        self.portsInfo = ports
        self.bels = bels
        self.matrixDir = matrixDir
        self.inputs = []
        self.outputs = []
        self.internalInputs = []
        self.internalOutputs = []
        self.belInputs = []
        self.belOutputs = []
        self.jumps = []
        self.withUserCLK = userCLK

        # adding ports in the order of normal port, bel port, jump port
        for port in self.portsInfo:
            if port.wireDirection != "JUMP":
                input, output = port.expandPortInfo(mode="AutoSwitchMatrix")
                self.inputs = list(dict.fromkeys(self.inputs + input))
                self.internalInputs = self.internalInputs + input
                self.outputs = list(dict.fromkeys(self.outputs + output))
                self.internalOutputs = self.internalOutputs + output

        for port in self.bels:
            self.belInputs = self.belInputs + port.inputs
            self.inputs = self.inputs + port.inputs
            self.belOutputs = self.belOutputs + port.outputs
            self.outputs = self.outputs + port.outputs

        for port in self.portsInfo:
            if port.wireDirection == "JUMP":
                input, output = port.expandPortInfo(mode="AutoSwitchMatrix")
                self.jumps = list(dict.fromkeys(input + output))
                self.inputs = list(dict.fromkeys(self.inputs + input))
                self.outputs = list(dict.fromkeys(self.outputs + output))
        for b in self.bels:
            self.globalConfigBits += b.configBit

    def __eq__(self, __o) -> bool:
        if __o is None:
            return False
        return self.name == __o.name

    def getWestSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == "WEST" and p.name != "NULL"]

    def getEastSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == "EAST" and p.name != "NULL"]

    def getNorthSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == "NORTH" and p.name != "NULL"]

    def getSouthSidePorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.sideOfTile == "SOUTH" and p.name != "NULL"]

    def getNorthPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == "NORTH"]))

    def getSouthPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == "SOUTH"]))

    def getEastPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == "EAST"]))

    def getWestPorts(self) -> List[Port]:
        return list(dict.fromkeys([p for p in self.portsInfo if p.wireDirection == "WEST"]))

    def getTileInputNames(self) -> List[str]:
        return [p.destinationName for p in self.portsInfo if p.destinationName != "NULL" and p.wireDirection != "JUMP"]

    def getTileOutputNames(self) -> List[str]:
        return [p.sourceName for p in self.portsInfo if p.sourceName != "NULL" and p.wireDirection != "JUMP"]


@dataclass
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

    def getInternalConnections(self):
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


@dataclass
class Fabric():
    tile: List[List[Tile]] = field(default_factory=list)

    height: int = 15
    width: int = 15
    configBitMode: Literal["FlipFlopChain", "frame_based"] = "frame_based"
    frameBitsPerRow: int = 32
    maxFramesPerCol: int = 20
    package: str = "use work.my_package.all"
    generateDelayInSwitchMatrix: int = 80
    multiplexerStyle: Literal["custom", "generic"] = "custom"
    superTileEnable: bool = True

    tileDic: Dict = field(default_factory=dict)
    superTileDic: Dict = field(default_factory=dict)

    def __repr__(self):
        fabric = ""
        for i in range(self.height):
            for j in range(self.width):
                if self.tile[i][j] is None:
                    fabric += "Null".ljust(15)+"\t"
                else:
                    fabric += f"{str(self.tile[i][j].name).ljust(15)}\t"
            fabric += "\n"

        fabric += f"\n"
        fabric += f"height: {self.height}\n"
        fabric += f"width: {self.width}\n"
        fabric += f"configBitMode: {self.configBitMode}\n"
        fabric += f"frameBitsPerRow: {self.frameBitsPerRow}\n"
        fabric += f"frameBitsPerColumn: {self.maxFramesPerCol}\n"
        fabric += f"package: {self.package}\n"
        fabric += f"generateDelayInSwitchMatrix: {self.generateDelayInSwitchMatrix}\n"
        fabric += f"multiplexerStyle: {self.multiplexerStyle}\n"
        fabric += f"superTileEnable: {self.superTileEnable}\n"
        fabric += f"tileDic: {list(self.tileDic.keys())}\n"
        return fabric
