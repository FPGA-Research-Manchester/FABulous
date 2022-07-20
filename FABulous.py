import os
import argparse
import re
import sys
import subprocess as sp
import shutil
import docker

FABulous_root = os.getenv('FABulous_root')

if FABulous_root is None:
    print('FABulous_root is not set!')
    print('Set FABulous_root with the following command:')
    print('export FABulous_root=<path to FABulous root>')
    sys.exit()


# Create a FABulous default project that contains all the required files
def create_project(project_dir):
    if os.path.exists(project_dir):
        print('Project directory already exists!')
        sys.exit()
    else:
        os.mkdir(f"./{project_dir}")

    os.mkdir(f"./{project_dir}/.FABulous")
    os.mkdir(f"./{project_dir}/user_design")

    shutil.copytree(f"{FABulous_root}/fabric_files/FABulous_project_template/",
                    f"./{project_dir}/src")

    shutil.copytree(
        f"{FABulous_root}/fabric_generator/fabulous_top_wrapper_temp", f"{project_dir}/src/fabulous_top_wrapper_temp")

    with open(f"{project_dir}/user_design/{project_dir.split('/')[-1]}.v", "w") as f:
        f.write(f"module {project_dir.split('/')[-1]}();\n")
        f.write(f"output a;\n")
        f.write(f"assign a = 1;\n")
        f.write(f"endmodule\n")


# Generate the switch matrix of the fabric
def switch_matrix_generation(project_dir):
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv"]

    # Generate the empty switch matrix
    cmd.append("-GenTileSwitchMatrixCSV")
    cmd.append("-s")
    cmd.append(f"{project_dir}/src")
    sp.run(cmd, check=True)

    cmd.pop()
    cmd.pop()
    cmd.pop()

    # populate the the switch matrix with all the ".list" file in the src directory
    cmd.append("-AddList2CSV")
    for (root, _, files) in os.walk(f"{project_dir}/src"):
        for file in files:
            if file.endswith(".list") and not file.startswith("debug"):
                cmd.append(f"{root}/{file}")
                cmd.append(
                    f"{project_dir}/src/{file.replace('.list', '.csv')}")
                sp.run(cmd, check=True)
                cmd.pop()
                cmd.pop()


# Generate the RTL code of the fabric
def RTL_generation(project_dir, VHDL=False):
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv",
           "-s", f"{project_dir}/src"]

    if os.path.exists(f"{project_dir}/fabric_vhdl"):
        shutil.rmtree(f"{project_dir}/fabric_vhdl")
    os.makedirs(f"{project_dir}/fabric_vhdl")

    if os.path.exists(f"{project_dir}/fabric_verilog"):
        shutil.rmtree(f"{project_dir}/fabric_verilog")
    os.makedirs(f"{project_dir}/fabric_verilog")

    # Generate Switch Matrix
    cmd.append("-GenTileSwitchMatrixVHDL")
    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenTileSwitchMatrixVerilog")
    sp.run(cmd, check=True)
    cmd.pop()

    # Generate ConfigMem
    cmd.append("-GenTileConfigMemVHDL")
    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenTileConfigMemVerilog")
    sp.run(cmd, check=True)
    cmd.pop()

    # Generate Tile
    cmd.append("-GenTileHDL")
    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenTileVerilog")
    sp.run(cmd, check=True)
    cmd.pop()

    # Generate Fabric
    cmd.append("-GenFabricVHDL")
    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenFabricVerilog")
    sp.run(cmd, check=True)
    cmd.pop()

    # clean up
    for f in os.listdir(f"{project_dir}/src"):
        if f.endswith("_ConfigMem.v"):
            os.remove(f"{project_dir}/src/{f}")

    fabric_def = []
    fabric_flag = False
    with open(f"{project_dir}/src/fabric.csv") as f:
        for line in f:
            if fabric_flag:
                fabric_def.append(line)
            if line.startswith("FabricBegin"):
                fabric_flag = True
            if line.startswith("FabricEnd"):
                break

    row = len(fabric_def)
    col = len([x for x in fabric_def[0].split(",") if x != ''])

    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabulous_top_wrapper_temp/top_wrapper_generator_with_BRAM.py"]
    cmd.append(f"-r")
    cmd.append(str(row))
    cmd.append("-c")
    cmd.append(str(col))
    cmd.append("-o")
    cmd.append(f"{project_dir}/src")

    sp.run(cmd, check=True)

    # collect all the file
    for f in os.listdir(f"./{project_dir}/src"):
        if f.endswith(".vhdl"):
            shutil.copy(f"./{project_dir}/src/{f}",
                        f"{project_dir}/fabric_vhdl/{f}")
        if f.endswith(".v"):
            shutil.copy(f"./{project_dir}/src/{f}",
                        f"{project_dir}/fabric_verilog/{f}")


# Generate the model for place and route
def model_generation(project_dir, VPR=False):
    # os.chdir(project_dir)
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv",
           "-s", f"{project_dir}/src"]

    cmd.append("-o")
    cmd.append(f"{project_dir}/.FABulous")
    cmd.append("-GenNextpnrModel")

    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenVPRModel")
    cmd.append(f"{project_dir}/src/custom_info.xml")
    sp.run(cmd, check=True)


def bit_stream_meta_data_generation(project_dir):
    # os.chdir(project_dir)
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv",
           "-s", f"{project_dir}/src"]

    cmd.append("-GenBitstreamSpec")
    cmd.append(f"{project_dir}/.FABulous/meta_data.txt")
    sp.run(cmd, check=True)


def create_project_HLS(project_dir):
    if not os.path.exists(f"{project_dir}/HLS"):
        os.makedirs(f"{project_dir}/HLS")

    with open(f"{project_dir}/HLS/config.tcl", "w") as f:
        f.write(f"source /root/legup-4.0/examples/legup.tcl\n")

    name = project_dir.split('/')[-1]
    with open(f"{project_dir}/HLS/Makefile", "w") as f:
        f.write(f"NAME = {name}\n")
        f.write(
            f"LOCAL_CONFIG = -legup-config=/root/{name}/config.tcl\n")
        f.write("LEVEL = /root/legup-4.0/examples\n")
        f.write("include /root/legup-4.0/examples/Makefile.common\n")
        f.write("include /root/legup-4.0/examples/Makefile.ancillary\n")
        f.write(f"OUTPUT_PATH=/root/{name}/generated_file\n")

    with open(f"{project_dir}/HLS/{name}.c", "w") as f:
        f.write(
            '#include <stdio.h>\nint main() {\n    printf("Hello World");\n    return 0;\n}')

    os.chmod(f"{project_dir}/HLS/config.tcl", 0o666)
    os.chmod(f"{project_dir}/HLS/Makefile", 0o666)
    os.chmod(f"{project_dir}/HLS/{name}.c", 0o666)


# Generate the verilog file using the legup HLS tool
def generate_verilog(project_dir):
    name = project_dir.split('/')[-1]
    # create folder for the generated file
    if not os.path.exists(f"{project_dir}/HLS/generated_file"):
        os.mkdir(f"{name}/generated_file")
    else:
        os.system(f"rm -rf {project_dir}/create_HLS_project/generated_file/*")

    client = docker.from_env()
    containers = client.containers.run(
        "legup:latest", f'make -C /root/{name} ', volumes=[f"{os.path.abspath(os.getcwd())}/{project_dir}/HLS/:/root/{name}"])

    print(containers.decode("utf-8"))

    # move all the generated files into a folder
    for f in os.listdir(f"{project_dir}/HLS"):
        if not f.endswith(".v") and not f.endswith(".c") and not f.endswith(".h") and not f.endswith("_labeled.c") \
                and not f.endswith(".tcl") and f != "Makefile" and os.path.isfile(f"{project_dir}/HLS/{f}"):
            shutil.move(f"{project_dir}/HLS/{f}",
                        f"{project_dir}/HLS/generated_file/")

        if f.endswith("_labeled.c"):
            shutil.move(f"{project_dir}/HLS/{f}",
                        f"{project_dir}/HLS/generated_file/")

    try:
        os.chmod(f"./{project_dir}/HLS/{name}.v", 0o666)
        with open(f"{project_dir}/HLS/{name}.v", "r") as f:
            content = f.read()
            content = re.sub(r"(if .*? \$finish; end)", r"//\1", content)
            content = re.sub(r"(@\(.*?\);)", r"//\1", content)
            content = re.sub(r"(\$write.*?;)", r"//\1", content)
            content = re.sub(r"(\$display.*?;)", r"//\1", content)
            content = re.sub(r"(\$finish;)", r"//\1", content)
            with open(f"{project_dir}/HLS/{name}.v", "w") as f:
                f.write(content)

        with open(f"{project_dir}/HLS/{name}.v", "a") as f:
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

                "(* keep *) top inst_top(.clk(clk), .reset(reset), .start(start),"
                "    .finish(finish), .waitrequest(waitrequest), .return_val(return_val));\n"
                "\n"
                "endmodule\n"
            )
            f.write("\n")
            f.write(s)
    except:
        print("Verilog file is not generated, potentialy due to the error in the C code")
        exit(-1)


# Run synthesis using Yoysy with Nextpnr json backend
def synthesis_Yosys(project_dir, top):
    cmd = ["yosys",
           "-p", f"tcl {FABulous_root}/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {top} ./{project_dir}/{top}.json",
           f"{project_dir}/{top}.v",
           "-l", f"./{project_dir}/{top}_yosys_log.txt"]
    sp.run(cmd, check=True)


# Run synthesis
def synthesis_Yosys(project_dir, top):
    cmd = ["yosys",
           "-p", f"tcl {FABulous_root}/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {top} ./{project_dir}/{top}.blif",
           f"{project_dir}/{top}.v",
           "-l", f"./{project_dir}/{top}_yosys_log.txt"]
    sp.run(cmd, check=True)


# Run place and route
def place_and_route_Nextpnr(project_dir, top):
    if f"{top}.json" in os.listdir(os.path.join(os.getcwd(), f"./{project_dir}")):
        shutil.copy(f"{project_dir}/npnroutput/pips.txt", f".")
        shutil.copy(f"{project_dir}/npnroutput/bel.txt", f".")

        cmd = [f"{FABulous_root}/nextpnr/nextpnr-fabulous",
               "--pre-pack", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_arch.py",
               "--pre-place", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_timing.py",
               "--json", f"{project_dir}/{top}.json",
               "--router", "router2",
               "--router2-heatmap", f"{project_dir}/{top}_heatmap",
               "--post-route", f"{FABulous_root}/nextpnr/fabulous/fab_arch/bitstream_temp.py",
               "--write", f"{project_dir}/pnr_{top}.json",
               "--verbose",
               "--log", f"{project_dir}/{top}_npnr_log.txt"]

        print(" ".join(cmd))
        result = sp.run(cmd, stdout=sys.stdout, stderr=sp.STDOUT, check=True)

        shutil.move("./sequential_16bit.fasm",
                    f"./{project_dir}/{top}.fasm")

        os.remove("./bel.txt")
        os.remove("./pips.txt")
    else:
        print(
            f"Cannot find {top}.json file, which is generated by running Yosys with Nextpnr backend")
        exit(-1)


def place_and_route_VPR(project_dir, top):
    if f"{top}.blif" in os.listdir(os.path.join(os.getcwd(), f"./{project_dir}")):
        if not os.getenv('VTR_ROOT'):
            print("VTR_ROOT is not set, please set it to the VPR installation directory")
            exit(-1)

        cmd = ["$VTR_ROOT/vpr/vpr",
               f"{project_dir}/vproutput/architecture.xml",
               f"{project_dir}/{top}.blif",
               "--read_rr_graph", f"{project_dir}/vproutput/routing_resources.xml",
               "--route_chan_width", "16"]

        sp.run(cmd, check=True)

    else:
        print(
            f"Cannot find {top}.blif file, which is generated by running Yosys with blif backend")
        exit(-1)


# Generate the bitstream
def generate_bitstream(project_dir, top):
    if f"{top}.v" in os.listdir(os.path.join(os.getcwd(), f"./{project_dir}")):
        dir = "./FABulous/nextpnr/fabulous/fab_arch"
        cmd = ["python3", f"{FABulous_root}/nextpnr/fabulous/fab_arch/bit_gen.py", "-genBitstream", f"./{project_dir}/{top}.fasm",
               f"{project_dir}/npnroutput/meta_data.txt", f"./{project_dir}/{top}.bin"]
        sp.run(cmd, check=True)
    else:
        print("Haven't generated the verilog file yet")


if __name__ == "__main__":
    if sys.version_info <= (3, 5, 0):
        print("Need Python 3.5 or above to run FABulous")
        exit(-1)
    parser = argparse.ArgumentParser(
        description='The command line interface for FABulous')

    parser.add_argument(
        "project_dir", help="The directory to the project folder")

    parser.add_argument(
        '-t', '--top', help="The top module name, if not set will use the name of the project as the top module name as default")

    parser.add_argument('-c', '--create_project', action='store_true', default=False,
                        help='Create a new FABulous project')

    parser.add_argument('-cHLS', '--create_project_HLS', action='store_true', default=False,
                        help='Create a HLS project in the project folder')

    parser.add_argument('-v', '--generate_verilog', action='store_true',
                        default=False, help='Generate the verilog file')

    parser.add_argument('-rf', '--generate_fabulous_fabric', action='store_true', default=False,
                        help='Generate a FABulous fabric with both VHDL and Verilog version. This will also generate VPR and Nextpnr model and all the relating files')

    parser.add_argument('-r', '--run_fabulous_flow', action='store_true', default=False,
                        help='Execute synthesis, place and route, and bitstream generation (Defualt using Yosys + Nextpnr)')

    parser.add_argument('-s', '--synthesis', action='store_true',
                        default=False, help='Run Synthesis with YOSYS')

    parser.add_argument('-pr', '--place_and_route', action='store_true',
                        default=False, help="Run place and route")

    parser.add_argument('-b', '--bitstream', action='store_true',
                        default=False, help='Generate the bitstream')

    args = parser.parse_args()

    args.top = args.project_dir.split("/")[-1]

    if args.create_project:
        create_project(args.project_dir)

    if args.create_project_HLS:
        create_project_HLS(args.project_dir)

    if args.generate_verilog:
        generate_verilog(args.project_dir)

    if args.synthesis:
        synthesis_Yosys(args.project_dir, args.top)

    if args.place_and_route:
        place_and_route_Nextpnr(args.project_dir, args.top)

    if args.bitstream:
        generate_bitstream(args.project_dir, args.top)

    if args.generate_fabulous_fabric:
        switch_matrix_generation(args.project_dir)
        RTL_generation(args.project_dir)
        model_generation(args.project_dir)
        bit_stream_meta_data_generation(args.project_dir)

    if args.run_fabulous_flow:
        synthesis_Yosys(args.project_dir, args.top)
        place_and_route_Nextpnr(args.project_dir, args.top)
        generate_bitstream(args.project_dir, args.top)

    if len(sys.argv) == 2:
        parser.print_help()
