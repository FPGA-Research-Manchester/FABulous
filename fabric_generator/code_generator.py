import abc
from fabric import Fabric, Tile


class codeGenerator(abc.ABC):

    @property
    def outFileName(self):
        return self._outFileName

    @property
    def content(self):
        return self._content

    @property
    def tile(self):
        return self._tile

    def __init__(self, outFileName, tile: Tile):
        self._outFileName = outFileName
        self._content = []
        self._tile = tile

    def writeToFile(self):
        with open(self._outFileName, 'w') as f:
            f.write("\n".join(self._content))

    def _add(self, line, indentLevel=0) -> None:
        if indentLevel == 0:
            self._content.append(line)
        else:
            self._content.append(f"{' ':<{4*indentLevel}}" + line)

    def addNewLine(self):
        self._add("")

    @abc.abstractmethod
    def addComment(self, comment, onNewLine=False, end="\n", indentLevel=0) -> None:
        pass

    @abc.abstractmethod
    def addHeader(self, postPad, package='', maxFramesPerCol='', frameBitsPerRow='', ConfigBitMode='FlipFlopChain', indentLevel=0):
        pass

    @abc.abstractmethod
    def addHeaderEnd(self, postPad, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameterStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameterEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addParameter(self, name, type, value, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortScalar(self, name, io, indentLevel=0):
        pass

    @abc.abstractmethod
    def addPortVector(self, name, io, width, indentLevel=0):
        pass

    @abc.abstractmethod
    def addDesignDescriptionStart(self, postPad, indentLevel=0):
        pass

    @abc.abstractmethod
    def addDesignDescriptionEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addConstant(self, name, value, indentLevel=0):
        pass

    @abc.abstractmethod
    def addConnectionVector(self, name, width, indentLevel=0):
        pass

    @abc.abstractmethod
    def addLogicStart(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addLogicEnd(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addFlipFlopChain(self, configBitCounter):
        pass

    @abc.abstractmethod
    def addShiftRegister(self, indentLevel=0):
        pass

    @abc.abstractmethod
    def addAssign(self, left, right, indentLevel=0):
        pass

    @abc.abstractmethod
    def addAssignVector(self, left, right, widthL, widthR, indentLevel=0):
        pass

    @abc.abstractmethod
    def addMux(self, muxStyle, muxSize, tileName, portName, portList, oldConfigBitstreamPosition, configBitstreamPosition, delay):
        pass
