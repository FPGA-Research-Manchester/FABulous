from csv import writer as csvWriter
from fabric_generator.fabric import Side
from enum import Enum


class PortType(Enum):
    SWITCH_MATRIX = "PORT"
    BEL = "BEL_PORT"



class PortGeometry:
    """
    A datastruct representing the geometry of a Port

    Attributes:
        name            (str)       :   Name of the port source
        type            (PortType)  :   Type of the port
        sideOfTile      (Side)      :   Side of the tile the ports wire is on
        offset          (int)       :   Offset to the connected port
        wireDirection   (Direction) :   Direction of the ports wire
        groupId         (int)       :   Id of the port group
        groupWires      (int)       :   Amount of wires of the port group
        relX            (int)       :   X coordinate of the port, relative to its parent (bel, switch matrix)
        relY            (int)       :   Y coordinate of the port, relative to its parent (bel, switch matrix)

    """
    name: str
    type: PortType
    sideOfTile: Side
    offset: int
    groupId: int
    groupWires: int
    relX: int
    relY: int

    nextId = 1


    def __init__(self):
        self.name = None
        self.type = None
        self.sideOfTile = Side.ANY
        self.offset = 0
        self.wireDirection = None
        self.groupId = 0
        self.groupWires = 0
        self.relX = 0
        self.relY = 0


    def generateGeometry(self, 
                         name: str, 
                         type: PortType, 
                         relX: int, 
                         relY: int) -> None:
        self.name = name
        self.type = type
        self.relX = relX
        self.relY = relY


    def saveToCSV(self, writer: csvWriter) -> None:
        writer.writerows([
            [self.type.value],
            ["Name"] + [self.name],
            ["RelX"] + [self.relX],
            ["RelY"] + [self.relY],
            []
        ])
