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

from fabric_generator.utilities import genFabricObject, GetFabric
import fabric_generator.model_generation_vpr as model_gen_vpr
import fabric_generator.model_generation_npnr as model_gen_npnr
from fabric_generator.code_generation_VHDL import VHDLWriter
from fabric_generator.code_generation_Verilog import VerilogWriter
import fabric_generator.code_generator as codeGen
import fabric_generator.file_parser as fileParser
from fabric_generator.fabric import Fabric, Tile
from fabric_generator.fabric_gen import FabricGenerator
from contextlib import redirect_stdout
import csv
from genericpath import isdir
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
readline.set_completer_delims(' \t\n')


# Create a FABulous Verilog project that contains all the required files
def create_project(project_dir, type: Literal["verilog", "vhdl"] = "verilog"):
    if os.path.exists(project_dir):
        print('Project directory already exists!')
        sys.exit()
    else:
        os.mkdir(f"./{project_dir}")

    os.mkdir(f"./{project_dir}/.FABulous")

    shutil.copytree(f"./fabric_files/FABulous_project_template_{type}/",
                    f"./{project_dir}/", dirs_exist_ok=True)


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
        self.writer.outFileName = outputDir

    def loadFabric(self, dir: str):
        if dir.endswith(".csv"):
            self.fabric = fileParser.parseFabricCSV(dir)
            self.fabricGenerator = FabricGenerator(self.fabric, self.writer)
        else:
            print("Only .csv files are supported for fabric loading")

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


class FABulousShell(cmd.Cmd):
    intro: str = """

  ______      ____        _
 |  ____/\   |  _ \      | |
 | |__ /  \  | |_) |_   _| | ___  _   _ ___
 |  __/ /\ \ |  _ <| | | | |/ _ \| | | / __|
 | | / ____ \| |_) | |_| | | (_) | |_| \__ \\
 |_|/_/    \_\____/ \__,_|_|\___/ \__,_|___/

    Welcome to FABulous shell
    """
    prompt: str = "FABulous> "
    fabricGen: FABulous
    projectDir: str
    top: str
    allTile: List[str]
    csvFile: str
    extension: str = "v"

    def __init__(self, fab: FABulous, projectDir: str):
        super().__init__()
        self.fabricGen = fab
        self.projectDir = projectDir
        self.tiles = []
        self.superTiles = []
        self.csvFile = ""
        self.allTile = [f.name for f in os.scandir(f"./Tile") if f.is_dir()]
        if isinstance(self.fabricGen.writer, VHDLWriter):
            self.extension = "vhdl"
        else:
            self.extension = "v"

    def precmd(self, line: str) -> str:
        return line

    def parse(self, line: str) -> List[str]:
        return line.split()

    def _complete_path(self, path):
        if os.path.isdir(path):
            return glob(os.path.join(path, "*"))
        else:
            return glob(path + "*")

    def _complete_tileName(self, text):
        return [t for t in self.allTile if t.startswith(text)]

    def do_exit(self, args):
        return True

    def do_load_fabric(self, args):
        "load csv file and generate an internal representation of the fabric"
        args = self.parse(args)
        # if no argument is given will use the one set by set_fabric_csv
        # else use the argument
        if len(args) == 0:
            if self.csvFile != "" and os.path.exists(self.csvFile):
                self.fabricGen.loadFabric(self.csvFile)
            else:
                print(
                    "No argument is given and no csv file is set or the file does not exist")
        else:
            self.fabricGen.loadFabric(args[0])

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
        for i in args:
            if os.path.exists(f"./Tile/{i}/{i}_configMem.csv"):
                print(
                    f"### Found bitstream mapping file {i}_configMem.csv for tile {i}")
            else:
                print(f"### {i}_configMem.csv does not exist")
                print(f"### Generating a default configMem for {i}")

            self.fabricGen.setWriterOutputFile(
                f"./Tile/{i}_ConfigMem.{self.extension}")
            self.fabricGen.genConfigMem(i, f"./Tile/{i}/{i}_configMem.csv")

    def complete_gen_config_mem(self, text, *ignored):
        return self._complete_tileName(text)

    def do_gen_switch_matrix(self, args):
        "generate switch matrix of the given tile"
        args = self.parse(args)
        for i in args:
            self.fabricGen.setWriterOutputFile(
                f"./Tile/{i}/{i}_switch_matrix.{self.extension}")
            self.fabricGen.genSwitchMatrix(i)

    def complete_gen_switch_matrix(self, text, *ignored):
        return self._complete_tileName(text)

    def do_gen_tile(self, args):
        "generate the given tile with the switch matrix and configuration memory"
        args = self.parse(args)
        for t in args:
            if subTiles := [f.name for f in os.scandir(f"./Tile/{t}") if f.is_dir()]:
                for st in subTiles:
                    # Gen switch matrix
                    self.fabricGen.setWriterOutputFile(
                        f"./Tile/{t}/{st}/{st}_switch_matrix.{self.extension}")
                    self.fabricGen.genSwitchMatrix(st)

                    # Gen config mem
                    if os.path.exists(f"./Tile/{t}/{st}/{st}_configMem.csv"):
                        print(
                            f"# found bitstream mapping file {st}_configMem.csv for tile {st}")
                    else:
                        print(f"{st}_configMem.csv does not exist")
                        print(f"Generating a default configMem for {st}")
                    self.fabricGen.setWriterOutputFile(
                        f"./Tile/{t}/{st}/{st}_configMem.{self.extension}")
                    self.fabricGen.genConfigMem(
                        st, f"./Tile/{t}/{st}/{st}_configMem.csv")

                    # Gen tile
                    self.fabricGen.setWriterOutputFile(
                        f"./Tile/{t}/{st}/{st}_tile.{self.extension}")
                    self.fabricGen.genTile(st)

                # Gen super tile
                self.fabricGen.setWriterOutputFile(
                    f"./Tile/{t}/{t}_tile.{self.extension}")
                self.fabricGen.genSuperTile(t)
                continue

            self.fabricGen.setWriterOutputFile(
                f"./Tile/{t}/{t}_ConfigMem.{self.extension}")
            if os.path.exists(f"./Tile/{t}/{t}_ConfigMem.csv"):
                self.fabricGen.genConfigMem(
                    t, f"./Tile/{t}/{t}_ConfigMem.csv")
            else:
                print(f"{t}_ConfigMem.csv does not exist")

            self.fabricGen.setWriterOutputFile(
                f"./Tile/{t}/{t}_switch_matrix.{self.extension}")
            self.fabricGen.genSwitchMatrix(t)

            self.fabricGen.setWriterOutputFile(
                f"./Tile/{t}/{t}_tile.{self.extension}")
            self.fabricGen.genTile(t)

    def complete_gen_tile(self, text: str, *ignored):
        return self._complete_tileName(text)

    def do_gen_fabric(self, args):
        "generate the fabric base on the loaded fabric"
        args = self.parse(args)
        self.fabricGen.genFabric()

    def do_gen_bitStream_spec(self, args):
        "generate the bitstream specification of the fabric"
        args = self.parse(args)
        specObject = self.fabricGen.genBitStreamSpec()

        with open(f"{self.projectDir}/.FABulous/bitStreamSpec.bin", "wb") as outFile:
            pickle.dump(specObject, outFile)

        with open(f"{self.projectDir}/.FABulous/bitStreamSpec.csv", "w") as f:
            w = csv.writer(f)
            for key1 in specObject["TileSpecs"]:
                w.writerow([key1])
                for key2, val in specObject["TileSpecs"][key1].items():
                    w.writerow([key2, val])

    def do_run_FABulous(self, args):
        "generate the fabric base on the CSV file and create the bitstream specification of the fabric"
        args = self.parse(args)
        for tile in self.tiles:
            self.fabricGen.genConfigMem(
                tile, f"{self.projectDir}/src/{tile}_config_mem.csv")
            self.fabricGen.genSwitchMatrix(tile)
            self.fabricGen.genTile(tile)

        for tile in self.superTiles:
            self.fabricGen.genSuperTile(tile)

        self.fabricGen.genFabric()
        self.fabricGen.genTopWrapper()
        self.fabricGen.genBitStreamSpec()

    # TODO Update once have transition the model gen to object based
    def do_model_gen_npnr(self):
        "generate a npnr model of the fabric"

        if self.csvFile:
            FabricFile = [i.strip('\n').split(',') for i in open(self.csvFile)]
            fabric = GetFabric(FabricFile)
            fabricObject = genFabricObject(fabric, FabricFile)
            pipFile = open(f"{self.projectDir}/.FABulous/pips.txt", "w")
            belFile = open(f"{self.projectDir}/.FABulous/bel.txt", "w")
            constraintFile = open(
                f"{self.projectDir}/.FABulous/template.pcf", "w")

            npnrModel = model_gen_npnr.genNextpnrModel(fabricObject, False)

            pipFile.write(npnrModel[0])
            belFile.write(npnrModel[1])
            constraintFile.write(npnrModel[2])

            pipFile.close()
            belFile.close()
            constraintFile.close()

        else:
            print("Need to call sec_fabric_csv before running model_gen_npnr")

    # TODO updater once have transition the model gen to object based
    def do_gen_model_npnr_pair(self):
        "generate a pair npnr model of the fabric"
        if self.csvFile:
            FabricFile = [i.strip('\n').split(',') for i in open(self.csvFile)]
            fabric = GetFabric(FabricFile)
            fabricObject = genFabricObject(fabric, FabricFile)
            pipFile = open(f"{self.projectDir}/.FABulous/pips.txt", "w")
            belFile = open(f"{self.projectDir}/.FABulous/bel.txt", "w")
            pairFile = open(f"{self.projectDir}/.FABulous/wirePairs.csv", "w")
            constraintFile = open(
                f"{self.projectDir}/.FABulous/template.pcf", "w")

            npnrModel = model_gen_npnr.genNextpnrModel(fabricObject, False)

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

    # TODO updater once have transition the model gen to object based
    def do_gen_model_vpr(self):
        "generate a vpr model of the fabric"
        if self.csvFile:
            FabricFile = [i.strip('\n').split(',') for i in open(self.csvFile)]
            fabric = GetFabric(FabricFile)
            customXmlFilename = args.GenVPRModel

            fabricObject = genFabricObject(fabric, FabricFile)
            archFile = open(
                f"{self.projectDir}/.FABulous/architecture.xml", "w")
            rrFile = open(
                f"{self.projectDir}/.FABulous/routing_resources.xml", "w")

            archFile = open("vproutput/architecture.xml", "w")
            archXML = model_gen_vpr.genVPRModelXML(
                fabricObject, customXmlFilename, False)
            archFile.write(archXML)
            archFile.close()

            rrFile = open("vproutput/routing_resources.xml", "w")
            rrGraphXML = model_gen_vpr.genVPRModelRRGraph(fabricObject, False)
            rrFile.write(rrGraphXML)
            rrFile.close()

        else:
            print("Need to call sec_fabric_csv before running model_gen_npnr_pair")

    def do_hls_create_project(self):
        if not os.path.exists(f"{self.projectDir}/HLS"):
            os.makedirs(f"{self.projectDir}/HLS")

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

        with open(f"{self.projectDir}/HLS/{name}.c", "w") as f:
            f.write(
                '#include <stdio.h>\nint main() {\n    printf("Hello World");\n    return 0;\n}')

        os.chmod(f"{self.projectDir}/HLS/config.tcl", 0o666)
        os.chmod(f"{self.projectDir}/HLS/Makefile", 0o666)
        os.chmod(f"{self.projectDir}/HLS/{name}.c", 0o666)

    def do_hls_generate_verilog(self):
        name = self.projectDir.split('/')[-1]
        # create folder for the generated file
        if not os.path.exists(f"{self.projectDir}/HLS/generated_file"):
            os.mkdir(f"{name}/generated_file")
        else:
            os.system(
                f"rm -rf {self.projectDir}/create_HLS_project/generated_file/*")

        client = docker.from_env()
        containers = client.containers.run(
            "legup:latest", f'make -C /root/{name} ', volumes=[f"{os.path.abspath(os.getcwd())}/{self.projectDir}/HLS/:/root/{name}"])

        print(containers.decode("utf-8"))

        # move all the generated files into a folder
        for f in os.listdir(f"{self.projectDir}/HLS"):
            if not f.endswith(".v") and not f.endswith(".c") and not f.endswith(".h") and not f.endswith("_labeled.c") \
                    and not f.endswith(".tcl") and f != "Makefile" and os.path.isfile(f"{self.projectDir}/HLS/{f}"):
                shutil.move(f"{self.projectDir}/HLS/{f}",
                            f"{self.projectDir}/HLS/generated_file/")

            if f.endswith("_labeled.c"):
                shutil.move(f"{self.projectDir}/HLS/{f}",
                            f"{self.projectDir}/HLS/generated_file/")

        try:
            os.chmod(f"./{self.projectDir}/HLS/{name}.v", 0o666)
            with open(f"{self.projectDir}/HLS/{name}.v", "r") as f:
                content = f.read()
                content = re.sub(r"(if .*? \$finish; end)", r"//\1", content)
                content = re.sub(r"(@\(.*?\);)", r"//\1", content)
                content = re.sub(r"(\$write.*?;)", r"//\1", content)
                content = re.sub(r"(\$display.*?;)", r"//\1", content)
                content = re.sub(r"(\$finish;)", r"//\1", content)
                with open(f"{self.projectDir}/HLS/{name}.v", "w") as f:
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
            with open(f"{self.projectDir}/HLS/{name}.v", "a") as f:
                f.write("\n")
                f.write(s)
        except:
            print(
                "Verilog file is not generated, potentialy due to the error in the C code")
            exit(-1)

    def do_load_design(self, args):
        args = self.parse(args)
        if len(args) != 1:
            print("Usage: load_design <top>")
        else:
            self.top = args[0]

    def do_synthesis_npnr(self):
        runCmd = ["yosys",
                  "-p", f"tcl ./nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {self.top} ./{self.projectDir}/.FABulous/{self.top}.json",
                  f"{self.projectDir}/user_design/{self.top}.v",
                  "-l", f"./{self.projectDir}/{self.top}_yosys_log.txt"]
        sp.run(runCmd, check=True)

    def do_synthesis_blif(self):
        runCmd = ["yosys",
                  "-p", f"tcl ./nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {self.top} ./{self.projectDir}/.FABulous/{self.top}.blif",
                  f"{self.projectDir}/user_design/{self.top}.v",
                  "-l", f"./{self.projectDir}/{self.top}_yosys_log.txt"]
        sp.run(runCmd, check=True)

    def do_place_and_route_npnr(self):
        if f"{self.top}.json" in os.listdir(f"{self.projectDir}/.FABulous"):
            shutil.copy(f"{self.projectDir}/.FABulous/pips.txt", f".")
            shutil.copy(f"{self.projectDir}/.FABulous/bel.txt", f".")

            runCmd = [f"{FABulous_root}/nextpnr/nextpnr-fabulous",
                      "--pre-pack", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_arch.py",
                      "--pre-place", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_timing.py",
                      "--json", f"{self.projectDir}/.FABulous/{self.top}.json",
                      "--router", "router2",
                      "--router2-heatmap", f"{self.projectDir}/{self.top}_heatmap",
                      "--post-route", f"{FABulous_root}/nextpnr/fabulous/fab_arch/bitstream_temp.py",
                      "--write", f"{self.projectDir}/pnr_{self.top}.json",
                      "--verbose",
                      "--log", f"{self.projectDir}/{self.top}_npnr_log.txt"]

            print(" ".join(runCmd))
            sp.run(runCmd, stdout=sys.stdout, stderr=sp.STDOUT, check=True)

            shutil.move("./sequential_16bit.fasm",
                        f"./{self.projectDir}/{self.top}.fasm")

            os.remove("./bel.txt")
            os.remove("./pips.txt")
        else:
            print(
                f"Cannot find {self.top}.json file, which is generated by running Yosys with Nextpnr backend")

    def do_place_and_route_vpr(self):
        if f"{self.top}.blif" in os.listdir(f"{self.projectDir}/.FABulous"):
            if not os.getenv('VTR_ROOT'):
                print(
                    "VTR_ROOT is not set, please set it to the VPR installation directory")
                exit(-1)

            vtr_root = os.getenv('VTR_ROOT')

            runCmd = [f"{vtr_root}/vpr/vpr",
                      f"{self.projectDir}/.FABulous/architecture.xml",
                      f"{self.projectDir}/.FABulous/{self.top}.blif",
                      "--read_rr_graph", f"{self.projectDir}/.FABulous/routing_resources.xml",
                      "--route_chan_width", "16"]
            sp.run(runCmd, check=True)
        else:
            print(
                f"Cannot find {self.top}.blif file, which is generated by running Yosys with blif backend")

    def do_gen_bitstream(self):
        runCmd = ["python3", f"./nextpnr/fabulous/fab_arch/bit_gen.py",
                  "-genBitstream",
                  f"./{self.projectDir}/{self.top}.fasm",
                  f"{self.projectDir}/.FABulous/meta_data.txt",
                  f"./{self.projectDir}/{self.top}.bin"]

        sp.run(runCmd, check=True)
        print("Bitstream generated")


if __name__ == "__main__":
    if sys.version_info < (3, 8, 10):
        print("Need Python 3.8.10 or above to run FABulous")
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
                        default=False,
                        nargs=1,
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

    args = parser.parse_args()

    args.top = args.project_dir.split("/")[-1]

    if args.createProject:
        create_project(args.project_dir, args.writer)
        exit(0)

    if not os.path.exists(f"{args.project_dir}/.FABulous"):
        print("The directory provided is not a FABulous project")
        exit(-1)
    else:
        writer = VerilogWriter("")
        if args.writer == "vhdl":
            writer = VHDLWriter("")
        if args.writer == "verilog":
            writer = VerilogWriter("")

        os.chdir(args.project_dir)

        fabShell = FABulousShell(
            FABulous(writer, fabricCSV=args.csv), args.project_dir)

        if args.script:
            fabShell.cmdqueue.extend(args.script.splitlines())

        if args.log:
            with open(args.log, "w") as log:
                with redirect_stdout(log):
                    fabShell.cmdloop()
        else:
            fabShell.cmdloop()
