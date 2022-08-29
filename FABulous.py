# Copyright 2021 University of Manchester
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

from contextlib import redirect_stdout
from fabric_generator.model_generation_vpr import genVPRModel
from fabric_generator.utilities import genFabricObject, GetFabric
import fabric_generator.model_generation_vpr as model_gen_vpr
import fabric_generator.model_generation_npnr as model_gen_npnr
from fabric_generator.code_generation_VHDL import VHDLWriter
from fabric_generator.code_generation_Verilog import VerilogWriter
import fabric_generator.code_generator as codeGen
import fabric_generator.file_parser as fileParser
from fabric_generator.fabric import Fabric, Tile
from fabric_generator.fabric_gen import FabricGenerator
import csv
from glob import glob
import os
import argparse
import pickle
import re
import sys
import subprocess as sp
import shutil
from typing import List, Literal
import docker
import cmd
import readline
import logging
import tkinter as tk
readline.set_completer_delims(' \t\n')

fabulousRoot = os.getenv('FAB_ROOT')
if fabulousRoot is None:
    print('FAB_ROOT environment variable not set!')
    print("Use 'export FAB_ROOT=<path to FABulous root>'")
    sys.exit(-1)


logger = logging.getLogger(__name__)
logging.basicConfig(
    format="[%(levelname)s]-%(asctime)s - %(message)s", level=logging.INFO)


# Create a FABulous Verilog project that contains all the required files
def create_project(project_dir, type: Literal["verilog", "vhdl"] = "verilog"):
    if os.path.exists(project_dir):
        print('Project directory already exists!')
        sys.exit()
    else:
        os.mkdir(f"./{project_dir}")

    os.mkdir(f"{project_dir}/.FABulous")

    shutil.copytree(f"{fabulousRoot}/fabric_files/FABulous_project_template_{type}/",
                    f"{project_dir}/", dirs_exist_ok=True)


class FABulous:
    fabricGenerator: FabricGenerator
    fabric: Fabric
    fileExtension: str = ".v"

    def __init__(self, writer: codeGen.codeGenerator, fabricCSV: str = ""):
        self.writer = writer
        if fabricCSV != "":
            self.fabric = fileParser.parseFabricCSV(fabricCSV)
            self.fabricGenerator = FabricGenerator(self.fabric, self.writer)

        if isinstance(self.writer, VHDLWriter):
            self.fileExtension = ".vhdl"
        # self.fabricGenerator = FabricGenerator(fabric, writer)

    def setWriterOutputFile(self, outputDir):
        logger.info(f"Output file: {outputDir}")
        self.writer.outFileName = outputDir

    def loadFabric(self, dir: str):
        if dir.endswith(".csv"):
            self.fabric = fileParser.parseFabricCSV(dir)
            self.fabricGenerator = FabricGenerator(self.fabric, self.writer)
        else:
            logger.warning("Only .csv files are supported for fabric loading")

    def bootstrapSwitchMatrix(self, tileName: str, outputDir: str):
        tile = self.fabric.getTileByName(tileName)
        self.fabricGenerator.bootstrapSwitchMatrix(tile, outputDir)

    def addList2Matrix(self, list: str, matrix: str):
        self.fabricGenerator.list2CSV(list, matrix)

    def genConfigMem(self, tileName: str, configMem: str):
        tile = self.fabric.getTileByName(tileName)
        self.fabricGenerator.generateConfigMem(tile, configMem)

    def genSwitchMatrix(self, tileName: str):
        tile = self.fabric.getTileByName(tileName)
        self.fabricGenerator.genTileSwitchMatrix(tile)

    def genTile(self, tileName: str):
        tile = self.fabric.getTileByName(tileName)
        self.fabricGenerator.generateTile(tile)

    def genSuperTile(self, tileName: str):
        tile = self.fabric.getSuperTileByName(tileName)
        self.fabricGenerator.generateSuperTile(tile)

    def genFabric(self):
        self.fabricGenerator.generateFabric()

    def genTopWrapper(self):
        self.fabricGenerator.generateTopWrapper()

    def genBitStreamSpec(self):
        specObject = self.fabricGenerator.generateBitsStreamSpec()
        return specObject

    def genModelNpnr(self):
        return model_gen_npnr.genNextpnrModel(self.fabric)

    def genModelVPR(self, customXML: str = ""):
        return model_gen_vpr.genVPRModel(self.fabric, customXML)

    def genModelVPRRoutingResource(self):
        return model_gen_vpr.genVPRRoutingResourceGraph(self.fabric)

    def genModelVPRConstrains(self):
        return model_gen_vpr.genVPRConstrainsXML(self.fabric)


class FABulousShell(cmd.Cmd):
    intro: str = f"""

    ______      ____        _
    |  ____/\   |  _ \      | |
    | |__ /  \  | |_) |_   _| | ___  _   _ ___
    |  __/ /\ \ |  _ <| | | | |/ _ \| | | / __|
    | | / ____ \| |_) | |_| | | (_) | |_| \__ \\
    |_|/_/    \_\____/ \__,_|_|\___/ \__,_|___/


Welcome to FABulous shell
You have started FABlous shell with following options:
{' '.join(sys.argv[1:])}

Type help or ? to list commands
The shell support tab completion for commands and files

To run the complete FABulous flow with the default project, run the following command:
    load_fabric
    run_FABulous_fabric
    run_FABulous_bitstream npnr ./user_design/sequential_16bit_en.v
    """
    prompt: str = "FABulous> "
    fabricGen: FABulous
    projectDir: str
    top: str
    allTile: List[str]
    csvFile: str
    extension: str = "v"
    fabricLoaded: bool = False
    pathToCSVFile: str = ""
    script: str = ""

    def __init__(self, fab: FABulous, projectDir: str, script: str = ""):
        super().__init__()
        self.fabricGen = fab
        self.projectDir = projectDir
        self.tiles = []
        self.superTiles = []
        self.csvFile = ""
        self.script = script
        if isinstance(self.fabricGen.writer, VHDLWriter):
            self.extension = "vhdl"
        else:
            self.extension = "v"

        if hasattr(fab, "fabric"):
            self.fabricLoaded = True

    def preloop(self) -> None:
        tcl = tk.Tcl()
        script = ""
        if self.script != "":
            with open(self.script, "r") as f:
                script = f.read()
            for fun in dir(self.__class__):
                if fun.startswith("do_"):
                    name = fun.strip("do_")
                    tcl.createcommand(name, getattr(self, fun))

        os.chdir(args.project_dir)
        tcl.eval(script)

        if "exit" in script:
            exit(0)

    def precmd(self, line: str) -> str:
        if ("gen" in line or "run" in line) and not self.fabricLoaded:
            logger.error("Fabric not loaded")
            return ""
        return line

    # override the emptyline method, so empty command will just do nothing
    def emptyline(self):
        pass

    def parse(self, line: str) -> List[str]:
        return line.split()

    def _complete_path(self, path):
        if os.path.isdir(path):
            return glob(os.path.join(path, "*"))
        else:
            return glob(path + "*")

    def _complete_tileName(self, text):
        return [t for t in self.allTile if t.startswith(text)]

    def do_exit(self, *ignore):
        "exit FABlous shell"
        logger.info("Exiting FABulous shell")
        return True

    def do_load_fabric(self, args=""):
        "load csv file and generate an internal representation of the fabric"
        args = self.parse(args)
        # if no argument is given will use the one set by set_fabric_csv
        # else use the argument
        logger.info("Loading fabric")
        if len(args) == 0:
            if self.csvFile != "" and os.path.exists(self.csvFile):
                self.fabricGen.loadFabric(self.csvFile)
            elif os.path.exists("./fabric.csv"):
                logger.info(
                    "Found fabric.csv in current directory loading that file as the definition of the fabric")
                self.fabricGen.loadFabric("./fabric.csv")
                self.csvFile = "./fabric.csv"
            else:
                logger.error(
                    "No argument is given and no csv file is set or the file does not exist")
                return
        else:
            self.fabricGen.loadFabric(args[0])
            self.csvFile = args[0]

        self.fabricLoaded = True
        self.pathToCSVFile = os.path.split(self.csvFile)[0]
        tileByPath = [f.name for f in os.scandir(
            f"{self.pathToCSVFile}/Tile/") if f.is_dir()]
        tileByFabric = list(self.fabricGen.fabric.tileDic.keys())
        superTileByFabric = list(self.fabricGen.fabric.superTileDic.keys())
        self.allTile = list(set(tileByPath) & set(
            tileByFabric + superTileByFabric))
        logger.info("Complete")

    def complete_load_fabric(self, text, *ignored):
        return self._complete_path(text)

    # TODO REMOVE once have transition the model gen to object based
    def do_set_fabric_csv(self, args):
        "set the csv file to be used for fabric generation"
        args = self.parse(args)
        self.csvFile = args[0]

    def complete_set_fabric_csv(self, text, *ignored):
        return self._complete_path(text)

    def do_gen_config_mem(self, args):
        args = self.parse(args)
        logger.info(f"Generating Config Memory for {' '.join(args)}")
        for i in args:
            logger.info(f"Generating configMem for {i}")
            self.fabricGen.setWriterOutputFile(
                f"{self.pathToCSVFile}/Tile/{i}/{i}_ConfigMem.{self.extension}")
            self.fabricGen.genConfigMem(
                i, f"{self.pathToCSVFile}/Tile/{i}/{i}_ConfigMem.csv")
        logger.info(f"Generating configMem complete")

    def complete_gen_config_mem(self, text, *ignored):
        return self._complete_tileName(text)

    def do_gen_switch_matrix(self, args):
        "generate switch matrix of the given tile"
        args = self.parse(args)
        logger.info(f"Generating switch matrix for {' '.join(args)}")
        for i in args:
            logger.info(f"Generating switch matrix for {i}")
            self.fabricGen.setWriterOutputFile(
                f"{self.pathToCSVFile}/Tile/{i}/{i}_switch_matrix.{self.extension}")
            self.fabricGen.genSwitchMatrix(i)
        logger.info("Switch matrix generation complete")

    def complete_gen_switch_matrix(self, text, *ignored):
        return self._complete_tileName(text)

    def do_gen_tile(self, args):
        "generate the given tile with the switch matrix and configuration memory"
        if not isinstance(args, list):
            args = self.parse(args)
        logger.info(f"Generating tile {' '.join(args)}")
        for t in args:
            if subTiles := [f.name for f in os.scandir(f"{self.pathToCSVFile}/Tile/{t}") if f.is_dir()]:
                logger.info(
                    f"{t} is a super tile, generating {t} with sub tiles {' '.join(subTiles)}")
                for st in subTiles:
                    # Gen switch matrix
                    logger.info(f"Generating switch matrix for tile {t}")
                    logger.info(f"Generating switch matrix for {st}")
                    self.fabricGen.setWriterOutputFile(
                        f"{self.pathToCSVFile}/Tile/{t}/{st}/{st}_switch_matrix.{self.extension}")
                    self.fabricGen.genSwitchMatrix(st)
                    logger.info(f"Generated switch matrix for {st}")

                    # Gen config mem
                    logger.info(f"Generating configMem for tile {t}")
                    logger.info(f"Generating ConfigMem for {st}")
                    self.fabricGen.setWriterOutputFile(
                        f"{self.pathToCSVFile}/Tile/{t}/{st}/{st}_ConfigMem.{self.extension}")
                    self.fabricGen.genConfigMem(
                        st, f"{self.pathToCSVFile}/Tile/{t}/{st}/{st}_ConfigMem.csv")
                    logger.info(f"Generated configMem for {st}")

                    # Gen tile
                    logger.info(f"Generating subtile for tile {t}")
                    logger.info(f"Generating subtile {st}")
                    logger.info(
                        f"Output file: {self.pathToCSVFile}/Tile/{t}/{st}/{st}_tile.{self.extension}")
                    self.fabricGen.setWriterOutputFile(
                        f"{self.pathToCSVFile}/Tile/{t}/{st}/{st}_tile.{self.extension}")
                    self.fabricGen.genTile(st)
                    logger.info(f"Generated subtile {st}")

                # Gen super tile
                logger.info(f"Generating super tile {t}")
                self.fabricGen.setWriterOutputFile(
                    f"{self.pathToCSVFile}/Tile/{t}/{t}_tile.{self.extension}")
                self.fabricGen.genSuperTile(t)
                logger.info(f"Generated super tile {t}")
                continue

            # Gen switch matrix
            self.do_gen_switch_matrix(t)

            # Gen config mem
            self.do_gen_config_mem(t)

            logger.info(f"Generating tile {t}")
            # Gen tile
            self.fabricGen.setWriterOutputFile(
                f"{self.pathToCSVFile}/Tile/{t}/{t}_tile.{self.extension}")
            self.fabricGen.genTile(t)
            logger.info(f"Generated tile {t}")

        logger.info("Tile generation complete")

    def complete_gen_tile(self, text: str, *ignored):
        return self._complete_tileName(text)

    def do_gen_all_tile(self, *ignored):
        "generate all tiles"
        logger.info("Generating all tiles")
        self.do_gen_tile(self.allTile)
        logger.info("Generated all tiles")

    def do_gen_fabric(self, *ignored):
        "generate the fabric base on the loaded fabric"
        logger.info(f"Generating fabric {self.fabricGen.fabric.name}")
        self.do_gen_all_tile()
        self.fabricGen.setWriterOutputFile(
            f"{self.pathToCSVFile}/Fabric/{self.fabricGen.fabric.name}.{self.extension}")
        self.fabricGen.genFabric()
        logger.info("Fabric generation complete")

    def do_gen_bitStream_spec(self, *ignored):
        "generate the bitstream specification of the fabric"
        logger.info("Generating bitstream specification")
        specObject = self.fabricGen.genBitStreamSpec()

        logger.info(
            f"output file: {self.pathToCSVFile}/{metaDataDir}/bitStreamSpec.bin")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/bitStreamSpec.bin", "wb") as outFile:
            pickle.dump(specObject, outFile)

        logger.info(
            f"output file: {self.pathToCSVFile}/{metaDataDir}/bitStreamSpec.csv")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/bitStreamSpec.csv", "w") as f:
            w = csv.writer(f)
            for key1 in specObject["TileSpecs"]:
                w.writerow([key1])
                for key2, val in specObject["TileSpecs"][key1].items():
                    w.writerow([key2, val])
        logger.info("Generated bitstream specification")

    def do_gen_top_wrapper(self, *ignored):
        "generate the top wrapper of the fabric"
        logger.info("Generating top wrapper")
        self.fabricGen.setWriterOutputFile(
            f"{self.pathToCSVFile}/Fabric/{self.fabricGen.fabric.name}_top.{self.extension}")
        self.fabricGen.genTopWrapper()
        logger.info("Generated top wrapper")

    def do_run_FABulous_fabric(self, *ignored):
        "generate the fabric base on the CSV file, create the bitstream specification of the fabric, top wrapper of the fabric and Nextpnr model of the fabric"
        logger.info("Running FABulous")
        self.do_gen_fabric()
        self.do_gen_bitStream_spec()
        self.do_gen_top_wrapper()
        self.do_gen_model_npnr()
        logger.info("FABulous fabric flow complete")
        return 0

    def do_gen_model_npnr(self, *ignored):
        "generate a npnr model of the fabric"
        logger.info("Generating npnr model")
        npnrModel = self.fabricGen.genModelNpnr()

        logger.info(
            f"output file: {self.pathToCSVFile}/{metaDataDir}/pips.txt")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/pips.txt", "w") as f:
            f.write(npnrModel[0])

        logger.info(f"output file: {self.pathToCSVFile}/{metaDataDir}/bel.txt")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/bel.txt", "w") as f:
            f.write(npnrModel[1])

        logger.info(
            f"output file: {self.pathToCSVFile}/{metaDataDir}/template.pcf")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/template.pcf", "w") as f:
            f.write(npnrModel[2])

        logger.info("Generated npnr model")

    # TODO updater once have transition the model gen to object based
    def do_gen_model_npnr_pair(self):
        "generate a pair npnr model of the fabric"
        logger.info("Generating pair npnr model")
        if self.csvFile:
            FabricFile = [i.strip('\n').split(',') for i in open(self.csvFile)]
            fabric = GetFabric(FabricFile)
            fabricObject = genFabricObject(fabric, FabricFile)
            pipFile = open(f"{self.pathToCSVFile}/{metaDataDir}/pips.txt", "w")
            belFile = open(f"{self.pathToCSVFile}/{metaDataDir}/bel.txt", "w")
            pairFile = open(
                f"{self.pathToCSVFile}/{metaDataDir}/wirePairs.csv", "w")
            constraintFile = open(
                f"{self.pathToCSVFile}/{metaDataDir}/template.pcf", "w")

            npnrModel = model_gen_npnr.genNextpnrModelOld(fabricObject, False)

            pipFile.write(npnrModel[0])
            belFile.write(npnrModel[1])
            constraintFile.write(npnrModel[2])
            pairFile.write(npnrModel[3])

            pipFile.close()
            belFile.close()
            constraintFile.close()
            pairFile.close()

        else:
            print("Need to call sec_fabric_csv before running model_gen_npnr_pair")
        logger.info("Generated pair npnr model")

    def do_gen_model_vpr(self, args):
        "generate a vpr model of the fabric"
        args = self.parse(args)
        if len(args) > 1:
            logger.error(f"Usage: gen_model_vpr [path_to_custom_xml]")
            return

        if len(args) == 0:
            args = ""
        else:
            args = args[0]

        logger.info("Generating vpr model")
        vprModel = self.fabricGen.genModelVPR(args)
        logger.info(
            f"Output file: {self.pathToCSVFile}/{metaDataDir}/architecture.xml")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/architecture.xml", "w") as f:
            f.write(vprModel)

        vprRoutingResource = self.fabricGen.genModelVPRRoutingResource()
        logger.info(
            f"Output file: {self.pathToCSVFile}/{metaDataDir}/routing_resource.xml")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/routing_resource.xml", "w") as f:
            f.write(vprRoutingResource)

        vprConstrain = self.fabricGen.genModelVPRConstrains()
        logger.info(
            f"Output file: {self.pathToCSVFile}/{metaDataDir}/fab_constraints.xml")
        with open(f"{self.pathToCSVFile}/{metaDataDir}/fab_constraints.xml", "w") as f:
            f.write(vprConstrain)

        logger.info("Generated vpr model")

    def complete_gen_model_vpr(self, text, *ignored):
        return self._complete_path(text)

    def do_hls_create_project(self):
        if not os.path.exists(f"./HLS"):
            os.makedirs(f"./HLS")

        with open(f"{self.projectDir}/HLS/config.tcl", "w") as f:
            f.write(f"source /root/legup-4.0/examples/legup.tcl\n")

        name = self.projectDir.split('/')[-1]
        with open(f"{self.projectDir}/HLS/Makefile", "w") as f:
            f.write(f"NAME = {name}\n")
            f.write(
                f"LOCAL_CONFIG = -legup-config=/root/{name}/config.tcl\n")
            f.write("LEVEL = /root/legup-4.0/examples\n")
            f.write("include /root/legup-4.0/examples/Makefile.common\n")
            f.write("include /root/legup-4.0/examples/Makefile.ancillary\n")
            f.write(f"OUTPUT_PATH=/root/{name}/generated_file\n")

        with open(f"./HLS/{name}.c", "w") as f:
            f.write(
                '#include <stdio.h>\nint main() {\n    printf("Hello World");\n    return 0;\n}')

        os.chmod(f"./HLS/config.tcl", 0o666)
        os.chmod(f"./HLS/Makefile", 0o666)
        os.chmod(f"./HLS/{name}.c", 0o666)

    def do_hls_generate_verilog(self):
        name = self.projectDir.split('/')[-1]
        # create folder for the generated file
        if not os.path.exists(f"./HLS/generated_file"):
            os.mkdir(f"{name}/generated_file")
        else:
            os.system(
                f"rm -rf ./create_HLS_project/generated_file/*")

        client = docker.from_env()
        containers = client.containers.run(
            "legup:latest", f'make -C /root/{name} ', volumes=[f"{os.path.abspath(os.getcwd())}/{self.projectDir}/HLS/:/root/{name}"])

        print(containers.decode("utf-8"))

        # move all the generated files into a folder
        for f in os.listdir(f"./HLS"):
            if not f.endswith(".v") and not f.endswith(".c") and not f.endswith(".h") and not f.endswith("_labeled.c") \
                    and not f.endswith(".tcl") and f != "Makefile" and os.path.isfile(f"./HLS/{f}"):
                shutil.move(f"./HLS/{f}",
                            f"./HLS/generated_file/")

            if f.endswith("_labeled.c"):
                shutil.move(f"./HLS/{f}",
                            f"./HLS/generated_file/")

        try:
            os.chmod(f"./HLS/{name}.v", 0o666)
            with open(f"./HLS/{name}.v", "r") as f:
                content = f.read()
                content = re.sub(r"(if .*? \$finish; end)", r"//\1", content)
                content = re.sub(r"(@\(.*?\);)", r"//\1", content)
                content = re.sub(r"(\$write.*?;)", r"//\1", content)
                content = re.sub(r"(\$display.*?;)", r"//\1", content)
                content = re.sub(r"(\$finish;)", r"//\1", content)
                with open(f"./HLS/{name}.v", "w") as f:
                    f.write(content)
            s = (
                f"module {name}(\n"
                "    reset,\n"
                "    start,\n"
                "    finish,\n"
                "    waitrequest,\n"
                "    return_val\n"
                ");\n"
                "input reset;\n"
                "input start;\n"
                "output wire finish;\n"
                "input waitrequest;\n"
                "output wire[31:0] return_val;\n"

                "wire clk;\n"
                "(* keep *) Global_Clock inst_clk (.CLK(clk));\n"

                "(* keep *) top inst_top(.clk(clk), .reset(reset), .start(start),\n"
                "    .finish(finish), .waitrequest(waitrequest), .return_val(return_val));\n"
                "\n"
                "endmodule\n"
            )
            with open(f"./HLS/{name}.v", "a") as f:
                f.write("\n")
                f.write(s)
        except:
            print(
                "Verilog file is not generated, potentialy due to the error in the C code")
            exit(-1)

    def do_synthesis_npnr(self, args):
        args = self.parse(args)
        if len(args) != 1:
            logger.error("Usage: synthesis_npnr <dir_to_top_module>")
            return
        logger.info(
            f"Running synthesis that targeting Nextpnr with design {args[0]}")
        path, name = os.path.split(args[0])
        name = name.split('.')[0]
        runCmd = ["yosys",
                  "-p", f"tcl {fabulousRoot}/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {name} {self.pathToCSVFile}/{path}/{name}.json",
                  f"{self.pathToCSVFile}/{args[0]}",
                  "-l", f"{self.pathToCSVFile}/{path}/{name}_yosys_log.txt"]
        sp.run(runCmd, check=True)
        logger.info("Synthesis completed")

    def complete_synthesis_npnr(self, text, *ignored):
        return self._complete_path(text)

    def do_synthesis_blif(self, args):
        logger.info(
            f"Running synthesis that targeting BLIF with design {args[0]}")
        args = self.parse(args)
        path, name = os.path.split(args[0])
        name = name.split('.')[0]
        runCmd = ["yosys",
                  "-p", f"tcl {fabulousRoot}/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {name} {self.pathToCSVFile}/{path}/{name}.blif",
                  f"{args[0]}",
                  "-l", f"{self.pathToCSVFile}/{path}/{name}_yosys_log.txt"]
        sp.run(runCmd, check=True)
        logger.info("Synthesis completed")

    def complete_synthesis_blif(self, text, *ignored):
        return self._complete_path(text)

    def do_place_and_route_npnr(self, args):
        args = self.parse(args)
        if len(args) != 1:
            logger.error("Usage: place_and_route_npnr <dir_to_top_module>")
            return
        logger.info(
            f"Running Placement and Routing with Nextpnr for design {args[0]}")
        path, name = os.path.split(args[0])
        name = name.split('.')[0]

        if not os.path.exists(f"{self.pathToCSVFile}/.FABulous/pips.txt") or not os.path.exists(f"{self.pathToCSVFile}/.FABulous/bel.txt"):
            logger.error(
                "Pips and Bel files are not found, please run model_gen_npnr first")
            return

        # TODO rewriting the fab_arch script so no need to copy file for work around
        if f"{name}.json" in os.listdir(f"{self.pathToCSVFile}/{path}"):
            shutil.copy(f"{self.pathToCSVFile}/.FABulous/pips.txt", f".")
            shutil.copy(f"{self.pathToCSVFile}/.FABulous/bel.txt", f".")
            runCmd = [f"{fabulousRoot}/nextpnr/nextpnr-fabulous",
                      "--pre-pack", f"{fabulousRoot}/nextpnr/fabulous/fab_arch/fab_arch.py",
                      "--pre-place", f"{fabulousRoot}/nextpnr/fabulous/fab_arch/fab_timing.py",
                      "--json", f"{self.pathToCSVFile}/{path}/{name}.json",
                      "--router", "router2",
                      "--router2-heatmap", f"{self.pathToCSVFile}/{path}/{name}_heatmap",
                      "--post-route", f"{fabulousRoot}/nextpnr/fabulous/fab_arch/bitstream_temp.py",
                      "--write", f"{self.pathToCSVFile}/{path}/pnr_{name}.json",
                      "--verbose",
                      "--log", f"{self.pathToCSVFile}/{path}/{name}_npnr_log.txt"]

            sp.run(runCmd, stdout=sys.stdout, stderr=sp.STDOUT, check=True)

            shutil.move("./sequential_16bit.fasm",
                        f"{self.pathToCSVFile}/{path}/{name}.fasm")

            os.remove("./bel.txt")
            os.remove("./pips.txt")
        else:
            logger.error(
                f"Cannot find {name}.json file in {path}, which is generated by running Yosys with Nextpnr backend")
            return
        logger.info("Placement and Routing completed")

    def complete_place_and_route_npnr(self, text, *ignored):
        return self._complete_path(text)

    def do_place_and_route_vpr(self, args):
        args = self.parse(args)
        if len(args) != 1:
            logger.error("Usage: place_and_route_vpr <dir_to_top_module>")
            return
        logger.info(
            f"Running Placement and Routing with vpr for design {args[0]}")
        path, name = os.path.split(args[0])
        name = name.split('.')[0]

        if os.path.exists(f"{self.pathToCSVFile}/user_design/{name}.blif"):
            if not os.getenv('VTR_ROOT'):
                logger.error(
                    "VTR_ROOT is not set, please set it to the VPR installation directory")
                exit(-1)

            vtr_root = os.getenv('VTR_ROOT')

            runCmd = [f"{vtr_root}/vpr/vpr",
                      f".FABulous/architecture.xml",
                      f"{self.pathToCSVFile}/user_design/{name}.blif",
                      "--read_rr_graph", f".FABulous/routing_resources.xml",
                      "--route_chan_width", "16"]
            sp.run(runCmd, check=True)
        else:
            logger.error(
                f"Cannot find {name}.blif file, which is generated by running Yosys with blif backend")
            return
        logger.info("Placement and Routing completed")

    def complete_place_and_route_vpr(self, text, *ignored):
        return self._complete_path(text)

    def do_gen_bitStream_binary(self, args):
        args = self.parse(args)
        if len(args) != 1:
            logger.error("Usage: gen_bitStream_binary <dir_to_top_module>")
            return
        path, name = os.path.split(args[0])
        name = name.split('.')[0]
        if not os.path.exists(f"{self.pathToCSVFile}/.FABulous/bitStreamSpec.bin"):
            logger.error(
                "Cannot find bitStreamSpec.bin file, which is generated by running gen_bitStream_spec")
            return

        if not os.path.exists(f"{self.pathToCSVFile}/{path}/{name}.fasm"):
            logger.error(
                f"Cannot find {self.pathToCSVFile}/{path}/{name}.fasm file which is generated by running place_and_route_npnr or place_and_route_vpr")
            return

        logger.info(f"Generating Bitstream for design {args[0]}")
        logger.info(f"Outputting to {path}/{name}.bin")
        name = name.split('.')[0]
        runCmd = ["python3", f"{fabulousRoot}/nextpnr/fabulous/fab_arch/bit_gen.py",
                  "-genBitstream",
                  f"{self.pathToCSVFile}/{path}/{name}.fasm",
                  f"{self.pathToCSVFile}/.FABulous/bitStreamSpec.bin",
                  f"{self.pathToCSVFile}/{path}/{name}.bin"]

        sp.run(runCmd, check=True)
        logger.info("Bitstream generated")

    def complete_gen_bitStream_binary(self, text, *ignored):
        return self._complete_path(text)

    def do_run_FABulous_bitstream(self, *args):
        if len(args) != 2:
            logger.error(
                "Usage: run_FABulous_bitstream <npnr|vpr> <dir_to_top>")
            return
        if args[0] == "vpr":
            self.do_synthesis_blif(args[1])
            self.do_place_and_route_vpr(args[1])
            self.do_gen_bitStream_binary(args[1])
        else:
            self.do_synthesis_npnr(args[1])
            self.do_place_and_route_npnr(args[1])
            self.do_gen_bitStream_binary(args[1])

    def complete_run_FABulous_bitstream(self, text, line, *ignored):
        value = ["npnr", "vpr"]
        if "npnr" not in line and "vpr" not in line:
            return [i for i in value if i.startswith(text)]
        return self._complete_path(text)

    def do_tcl(self, args):
        """Execute a TCL script. The directory in the script is relative to the project directory."""
        args = self.parse(args)
        if len(args) != 1:
            logger.error("Usage: tcl <tcl_script>")
            return
        path, name = os.path.split(args[0])
        name = name.split('.')[0]
        if not os.path.exists(args[0]):
            logger.error(
                f"Cannot find {args[0]}")
            return

        logger.info(f"Execute TCL script {args[0]}")
        tcl = tk.Tcl()
        for fun in dir(self.__class__):
            if fun.startswith("do_"):
                name = fun.strip("do_")
                tcl.createcommand(name, getattr(self, fun))

        tcl.evalfile(args[0])
        logger.info("TCL script executed")

    def complete_tcl(self, text, *ignored):
        return self._complete_path(text)


if __name__ == "__main__":
    if sys.version_info < (3, 9, 0):
        print("Need Python 3.9 or above to run FABulous")
        exit(-1)
    parser = argparse.ArgumentParser(
        description='The command line interface for FABulous')

    parser.add_argument(
        "project_dir", help="The directory to the project folder")

    parser.add_argument('-c', '--createProject',
                        default=False,
                        action='store_true',
                        help='Create a new project')

    parser.add_argument('-csv',
                        default="",
                        nargs=1,
                        help="Log all the output from the terminal")

    parser.add_argument('-s', '--script',
                        default="",
                        help="Run FABulous with a FABulous script")

    parser.add_argument('-log',
                        default=False,
                        nargs='?',
                        const="FABulous.log",
                        help="Log all the output from the terminal")

    parser.add_argument('-w', '--writer',
                        default="verilog",
                        nargs=1,
                        choices=['verilog', 'vhdl'],
                        help="Set the type of HDL code generated by the tool. Currently support Verilog and VHDL (Default using Verilog)")

    parser.add_argument('-md', '--metaDataDir',
                        default=".FABulous",
                        nargs=1,
                        help="Set the output directory for the meta data files eg. pip.txt, bel.txt")

    args = parser.parse_args()

    args.top = args.project_dir.split("/")[-1]
    metaDataDir = ".FABulous"

    if args.createProject:
        create_project(args.project_dir, args.writer)
        exit(0)

    if not os.path.exists(f"{args.project_dir}/.FABulous"):
        print("The directory provided is not a FABulous project as it does not have a .FABulous folder")
        exit(-1)
    else:
        writer = VerilogWriter("")
        if args.writer == "vhdl":
            writer = VHDLWriter("")
        if args.writer == "verilog":
            writer = VerilogWriter("")

        fabShell = FABulousShell(
            FABulous(writer, fabricCSV=args.csv), args.project_dir, args.script)

        if args.metaDataDir:
            metaDataDir = args.metaDataDir

        if args.log:
            with open(args.log, "w") as log:
                with redirect_stdout(log):
                    fabShell.cmdloop()
        else:
            fabShell.cmdloop()
