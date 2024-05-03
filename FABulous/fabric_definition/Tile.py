from dataclasses import dataclass, field
from .Port import Port
from .Bel import Bel
from .Wire import Wire
from .defines import Direction, IO, Side
from typing import Any
import os


@dataclass
class Tile:
    """
    This class is for storing the information about a tile.

    attributes:
        name (str) : The name of the tile
        portsInfo (list[Port]) : The list of ports of the tile
        matrixDir (str) : The directory of the tile matrix
        globalConfigBits (int) : The number of config bits the tile have
        withUserCLK (bool) : Whether the tile has userCLK port. Default is False.
        wirelist (list[Wire]) : The list of wires of the tile
        filePath (str) : The path of the matrix file
    """

    name: str
    portsInfo: list[Port]
    bels: list[Bel]
    matrixDir: str
    globalConfigBits: int = 0
    withUserCLK: bool = False
    wireList: list[Wire] = field(default_factory=list)
    filePath: str = "."
    partOfSuperTile = False

    def __init__(
        self,
        name: str,
        ports: list[Port],
        bels: list[Bel],
        matrixDir: str,
        userCLK: bool,
        configBit: int = 0,
    ) -> None:
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

    def getWestSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.WEST and p.name != "NULL"
        ]

    def getEastSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.EAST and p.name != "NULL"
        ]

    def getNorthSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.NORTH and p.name != "NULL"
        ]

    def getSouthSidePorts(self) -> list[Port]:
        return [
            p for p in self.portsInfo if p.sideOfTile == Side.SOUTH and p.name != "NULL"
        ]

    def getNorthPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.NORTH and p.name != "NULL" and p.inOut == io
        ]

    def getSouthPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.SOUTH and p.name != "NULL" and p.inOut == io
        ]

    def getEastPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.EAST and p.name != "NULL" and p.inOut == io
        ]

    def getWestPorts(self, io: IO) -> list[Port]:
        return [
            p
            for p in self.portsInfo
            if p.wireDirection == Direction.WEST and p.name != "NULL" and p.inOut == io
        ]

    def getTileInputNames(self) -> list[str]:
        return [
            p.destinationName
            for p in self.portsInfo
            if p.destinationName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.INPUT
        ]

    def getTileOutputNames(self) -> list[str]:
        return [
            p.sourceName
            for p in self.portsInfo
            if p.sourceName != "NULL"
            and p.wireDirection != Direction.JUMP
            and p.inOut == IO.OUTPUT
        ]
