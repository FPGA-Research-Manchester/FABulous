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


@dataclass
class Bel():
    src: str
    prefix: str


@dataclass
class Tile():
    name: str
    ports: List[Port]
    bels: List[Bel]
    matrixDir: str

    def __repr__(self):
        return f"\n{self.name}\n  Ports:{self.ports}\n  Bels:{self.bels}\n  Matrix_dir:{self.matrixDir}\n"


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
