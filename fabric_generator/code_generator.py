import abc
from typing import List, Literal
from xmlrpc.client import Boolean
from fabric_generator.fabric import Fabric, Tile, Bel, IO, ConfigBitMode


class codeGenerator(abc.ABC):

    @property
    def outFileName(self):
        return self._outFileName

    @property
    def content(self):
        return self._content

    def __init__(self, outFileName):
        self._outFileName = outFileName
        self._content = []

    def writeToFile(self):
        if self._outFileName == "":
            print("OutFileName is not set")
            exit(-1)
        with open(self._outFileName, 'w') as f:
            f.write("\n".join(self._content))
        self._content = []

    @outFileName.setter
    def outFileName(self, outFileName):
        self._outFileName = outFileName

    def _add(self, line, indentLevel=0) -> None:
        if indentLevel == 0:
            self._content.append(line)
        else:
            self._content.append(f"{' ':<{4*indentLevel}}" + line)

    def addNewLine(self):
        self._add("")

    @abc.abstractmethod
    def addComment(self, comment, onNewLine=False, end="", indentLevel=0) -> None:
        pass

    @abc.abstractmethod
    def addHeader(self, name, package='', maxFramesPerCol='', frameBitsPerRow='', ConfigBitMode='FlipFlopChain', indentLevel=0):
        pass

    @abc.abstractmethod
    def addHeaderEnd(self, name, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameterStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameterEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameter(self, name, type, value, end=False, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortScalar(self, name, io: IO, end=False, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortVector(self, name, io: IO, msbIndex, end=False, indentLevel=0):
        pass

    @abc.abstractmethod
    def addDesignDescriptionStart(self, name, indentLevel=0):
        pass

    @abc.abstractmethod
    def addDesignDescriptionEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addConstant(self, name, value, indentLevel=0):
        pass

    @abc.abstractmethod
    def addConnectionVector(self, name, startIndex, end=0, indentLevel=0):
        pass

    @abc.abstractmethod
    def addConnectionScalar(self, name):
        pass

    @abc.abstractmethod
    def addLogicStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addLogicEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addInstantiation(self, compName: str, compInsName: str, compPort: List[str], signal: List[str], paramPort: List[str] = [], paramSignal: List[str] = [], indentLevel=0):
        pass

    @abc.abstractmethod
    def addGeneratorStart(self, loopName: str, variableName: str, start, end, indentLevel=0):
        pass

    @abc.abstractmethod
    def addGeneratorEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addComponentDeclarationForFile(self, fileName):
        pass

    @abc.abstractmethod
    def addShiftRegister(self, configBits, indentLevel=0):
        pass

    @abc.abstractmethod
    def addFlipFlopChain(self, configBits, indentLevel=0):
        pass

    @abc.abstractmethod
    def addAssignScalar(self, left, right, delay=0, indentLevel=0):
        pass

    @abc.abstractmethod
    def addAssignVector(self, left, right, widthL, widthR, indentLevel=0):
        pass

    @abc.abstractmethod
    def addBELInstantiations(self, bel: Bel, configBitCounter: int, mode: ConfigBitMode, belCounter: int = 0):
        pass

    @abc.abstractmethod
    def add_Conf_Instantiation(self, counter: int, close: bool = True):
        pass
