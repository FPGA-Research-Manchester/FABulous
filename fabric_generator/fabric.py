from dataclasses import dataclass, field
from typing import Literal, List, Dict


@dataclass
class Port():
    direction: Literal["NORTH", "SOUTH", "EAST", "WEST", "JUMP"]
    sourceName: str
    xOffset: int
    yOffset: int
    destinationName: str
    wires: int
    # totalWireAmount: int

    # def __init__(self, direction, sourceName, xOffset, yOffset, destinationName, wires) -> None:
    #     self.direction = direction
    #     self.sourceName = sourceName
    #     self.xOffset = xOffset
    #     self.yOffset = yOffset
    #     self.destinationName = destinationName
    #     self.wires = wires
    #     self.totalWireAmount = (
    #         (abs(self.xOffset)+abs(self.yOffset))-1) * self.wires

    def __repr__(self) -> str:
        return f"{self.sourceName}->{self.destinationName}"

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
    internalInputs = List[str]
    internalOutputs = List[str]
    jumps: List[str]
    belInputs: List[str]
    belOutputs: List[str]
    globalConfigBits: int = 0

    def __repr__(self):
        return f"\n{self.name}\n inputPorts:{self.inputs}\n outputPorts:{self.outputs}\n bels:{self.bels}\n Matrix_dir:{self.matrixDir}\n"

    def __init__(self, name: str, ports: List[Port], bels: List[Bel], matrixDir: str):
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

        # adding ports in the order of normal port, bel port, jump port
        for port in self.portsInfo:
            if port.direction != "JUMP":
                input, output = port.expandPortInfo(mode="AutoSwitchMatrix")
                self.inputs = self.inputs + input
                self.internalInputs = self.internalInputs + input
                self.outputs = self.outputs + output
                self.internalOutputs = self.internalOutputs + output

        for port in self.bels:
            self.belInputs = self.belInputs + port.inputs
            self.inputs = self.inputs + port.inputs
            self.belOutputs = self.belOutputs + port.outputs
            self.outputs = self.outputs + port.outputs

        for port in self.portsInfo:
            if port.direction == "JUMP":
                input, output = port.expandPortInfo(mode="AutoSwitchMatrix")
                self.jumps = input + output
                self.inputs = self.inputs + input
                self.outputs = self.outputs + output

        for b in self.bels:
            self.globalConfigBits += b.configBit

    def __eq__(self, __o) -> bool:
        if __o is None:
            return False
        return self.name == __o.name

    def getWestPorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.direction == "WEST"]

    def getEastPorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.direction == "EAST"]

    def getNorthPorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.direction == "NORTH"]

    def getSouthPorts(self) -> List[Port]:
        return [p for p in self.portsInfo if p.direction == "SOUTH"]

    def getTileInputNames(self) -> List[str]:
        return [p.destinationName for p in self.portsInfo if p.destinationName != "NULL" and p.direction != "JUMP"]

    def getTileOutputNames(self) -> List[str]:
        return [p.sourceName for p in self.portsInfo if p.sourceName != "NULL" and p.direction != "JUMP"]


@dataclass
class SuperTile():
    name: str
    tiles: List[Tile]
    tileMap: List


@dataclass
class Fabric():
    tile: List = field(default_factory=list)

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
