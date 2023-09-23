from typing import List
from fabric_generator.fabric import Bel
from geometry_generator.port_geometry import PortGeometry, PortType
from csv import writer as csvWriter


class BelGeometry:
    """
    A datastruct representing the geometry of a Bel.

    Attributes:
        name                (str)               :   Name of the bel
        src                 (str)               :   File path of the bel HDL source file
        width               (int)               :   Width of the bel
        height              (int)               :   Height of the bel
        relX                (int)               :   X coordinate of the bel, relative within the tile
        relY                (int)               :   Y coordinate of the bel, relative within the tile
        internalPorts       (List[str])         :   Internal port names of the bel
        externalPorts       (List[str])         :   External port names of the bel
        internalPortGeoms   (List[PortGeometry]):   List of geometries of the internal ports of the bel
        externalPortGeoms   (List[PortGeometry]):   List of geometries of the external ports of the bel

    """
    name: str
    src: str
    width: int
    height: int
    relX: int
    relY: int
    internalPorts: List[str]
    externalPorts: List[str]
    internalPortGeoms: List[PortGeometry]
    externalPortGeoms: List[PortGeometry]


    def __init__(self):
        self.name = None
        self.src = None
        self.width = 0
        self.height = 0
        self.relX = 0
        self.relY = 0
        self.internalPorts = []
        self.externalPorts = []
        self.internalPortGeoms = []
        self.externalPortGeoms = []


    def generateGeometry(self, bel: Bel, padding: int) -> None:
        self.name = bel.name        # might need:    readableName = os.path.basename(bel.name)
        self.src = bel.src
        self.internalPorts = bel.inputs + bel.outputs
        self.externalPorts = bel.externalInput + bel.externalOutput

        internalPortsAmount = len(self.internalPorts)
        externalPortsAmount = len(self.externalPorts)
        maxAmountVerticalPorts = max(internalPortsAmount, externalPortsAmount)

        self.height = maxAmountVerticalPorts + padding
        self.width = 32     # TODO: Deduce width in a meaningful way?

        self.generatePortsGeometry(bel, padding)


    def generatePortsGeometry(self, bel: Bel, padding: int) -> None:
        internalPortX = 0
        internalPortY = padding // 2
        for port in self.internalPorts:
            portName = port
            portGeom = PortGeometry()
            portGeom.generateGeometry(
                portName, PortType.BEL,
                internalPortX, internalPortY
            )
            self.internalPortGeoms.append(portGeom)
            internalPortY += 1

        externalPortX = self.width
        externalPortY = padding // 2
        for port in self.externalPorts:
            portName = port.removeprefix(bel.prefix)
            portGeom = PortGeometry()
            portGeom.generateGeometry(
                portName, PortType.BEL,
                externalPortX, externalPortY
            )
            self.externalPortGeoms.append(portGeom)
            internalPortY += 1


    def adjustPos(self, relX: int, relY: int) -> None:
        self.relX = relX
        self.relY = relY


    def saveToCSV(self, writer: csvWriter) -> None:
        writer.writerows([
            ["BEL"],
            ["Name"]    + [self.name],
            ["Src"]     + [self.src],
            ["RelX"]    + [self.relX],
            ["RelY"]    + [self.relY],
            ["Width"]   + [self.width],
            ["Height"]  + [self.height],
            []
        ])

        for portGeom in self.internalPortGeoms:
            portGeom.saveToCSV(writer)

        for portGeom in self.externalPortGeoms:
            portGeom.saveToCSV(writer)
