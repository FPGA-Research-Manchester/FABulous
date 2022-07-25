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
                inputs.append(
                    f"{self.destinationName}{openIndex}{str(i)}{closeIndex}")
            # if self.sourceName == "NULL":
            #     print(self)
            if self.sourceName != "NULL":
                outputs.append(
                    f"{self.sourceName}{openIndex}{str(i)}{closeIndex}")
        return inputs, outputs


@dataclass
class Bel():
    src: str
    prefix: str
    inputs: List[str]
    outputs: List[str]
    config: List[str]
    external: List[str]


@dataclass
class Tile():
    name: str
    portsInfo: List[Port]
    bels: List[Bel]
    matrixDir: str
    inputs: List[str]
    outputs: List[str]

    # def __repr__(self):
    #     return f"\n{self.name}\n inputPorts:{self.inputs}\n outputPorts:{self.outputs}\n bels:{self.bels}\n Matrix_dir:{self.matrixDir}\n"

    def __init__(self, name: str, ports: List[Port], bels: List[Bel], matrixDir: str):
        self.name = name
        self.portsInfo = ports
        self.bels = bels
        self.matrixDir = matrixDir
        self.inputs = []
        self.outputs = []
        for port in self.portsInfo:
            self.inputs += port.expandPortInfo(mode="AutoSwitchMatrix")[0]
            self.outputs += port.expandPortInfo(mode="AutoSwitchMatrix")[1]

        for port in self.bels:
            # IMPORTANT: the outputs of a BEL are the inputs to the switch matrix!
            self.inputs = self.inputs + port.outputs
            # IMPORTANT: the inputs to a BEL are the outputs of the switch matrix!
            self.outputs = self.outputs + port.inputs


@dataclass
class SuperTile():
    name: str
    tiles: List[Tile]


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
