import os
import argparse
import sys
import subprocess as sp
import shutil

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

    # os.mkdir(f"./{project_dir}/meta_data/VPR")
    # os.mkdir(f"./{project_dir}/meta_data/Nextpnr")
    # os.mkdir(f"./{project_dir}/user_design")

    shutil.copytree(f"{FABulous_root}/fabric_files/generic/",
                    f"./{project_dir}/src")

    shutil.copytree(
        f"{FABulous_root}/fabric_generator/fabulous_top_wrapper_temp", f"{project_dir}/src/fabulous_top_wrapper_temp")


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
    for f in os.listdir(f"{project_dir}/src"):
        if f.endswith(".list") and not f.startswith("debug"):
            cmd.append(f"{project_dir}/src/{f}")
            cmd.append(f"{project_dir}/src/{f.replace('.list', '.csv')}")
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

    sp.run(cmd, check=True)


# Generate the model for place and route
def model_generation(project_dir, VPR=False):
    # os.chdir(project_dir)
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv"]

    if os.path.exists("vproutput"):
        shutil.rmtree("vproutput")
    os.makedirs("vproutput")

    if os.path.exists("npnroutput"):
        shutil.rmtree("npnroutput")
    os.makedirs("npnroutput")

    cmd.append("-GenNextpnrModel")
    sp.run(cmd, check=True)
    cmd.pop()

    cmd.append("-GenVPRModel")
    cmd.append(f"./custom_info.xml")
    sp.run(cmd, check=True)

    cmd.pop()
    cmd.pop()

    shutil.copytree("npnroutput/", "../npnroutput", dirs_exist_ok=True)
    shutil.copytree("vproutput/", "../vproutput", dirs_exist_ok=True)


def bit_stream_meta_data_generation(project_dir):
    # os.chdir(project_dir)
    cmd = ["python3",
           f"{FABulous_root}/fabric_generator/fabric_gen.py",
           "-f", f"{project_dir}/src/fabric.csv"]
    cmd.append("-GenBitstreamSpec")
    cmd.append(f"../npnroutput/meta_data.txt")

    sp.run(cmd, check=True)

    for f in os.listdir("."):
        if f.endswith(".vhdl"):
            shutil.copy(f"./{f}", f"../fabric_vhdl/{f}")
        if f.endswith(".v"):
            shutil.copy(f"./{f}", f"../fabric_verilog/{f}")


# Run synthesis
def synthesis(project_dir, top):
    if f"{top}.v" in os.listdir(os.path.join(os.getcwd(), f"./{project_dir}")):
        cmd = ["yosys", "-p",
               f"tcl {FABulous_root}/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {top} ./{project_dir}/{top}.json",
               f"{project_dir}/{top}.v", "-l", f"./{project_dir}/{top}_yosys_log.txt"]
        # cmd = ["yosys", "-p",
        #        f"tcl ./FABulous/nextpnr/fabulous/synth/synth_fabulous_dffesr.tcl 4 {name} ./{out_dir}/{name}.blif",
        #        f"./{out_dir}/{name}.v", "-l", f"./{out_dir}/{name}_yosys_log.txt"]
        sp.run(cmd)
    else:
        print("Haven't generated the verilog file yet")


# Run place and route
def place_and_route(project_dir, top):
    if f"{top}.json" in os.listdir(os.path.join(os.getcwd(), f"./{project_dir}")):
        shutil.copy(f"{project_dir}/npnroutput/pips.txt", f".")
        shutil.copy(f"{project_dir}/npnroutput/bel.txt", f".")

        cmd = [f"{FABulous_root}/nextpnr/nextpnr-fabulous",
               "--pre-pack", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_arch.py",
               "--pre-place", f"{FABulous_root}/nextpnr/fabulous/fab_arch/fab_timing.py",
               "--json", f"{project_dir}/{top}.json",
               "--router", "router2",
               "--router2-heatmap", f"{project_dir}/{top}_heatmap",
               "--post-route", f"{FABulous_root}/nextpnr/fabulous/fab_arch/bitstream.py",
               "--write", f"pnr_{top}.json",
               "--verbose",
               "--log", f"{project_dir}/{top}_npnr_log.txt"]

        print(" ".join(cmd))
        result = sp.run(cmd, stdout=sys.stdout, stderr=sp.STDOUT, check=True)

        shutil.move("./sequential_16bit_en.fasm",
                    f"./{project_dir}/{top}.fasm")

        os.remove("./bel.txt")
        os.remove("./pips.txt")
    else:
        print("Haven't completed synthesis yet")


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
    parser = argparse.ArgumentParser(description='')

    parser.add_argument(
        "project_dir", help="The directory to the project folder")

    parser.add_argument(
        '-t', '--top', help="The top module name, if not set will use the name of the project as the top module name")

    parser.add_argument('-c', '--create_project', action='store_true', default=False,
                        help='Create a new FABulous project')

    parser.add_argument('-rf', '--generate_fabulous_fabric', action='store_true', default=False,
                        help='Generate a FABulous fabric')

    parser.add_argument('-r', '--run_fabulous_flow', action='store_true', default=False,
                        help='Execute synthesis, place and route, and bitstream generation')

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

    if args.synthesis:
        synthesis(args.project_dir, args.top)

    if args.place_and_route:
        place_and_route(args.project_dir, args.top)

    if args.bitstream:
        generate_bitstream(args.project_dir, args.top)

    if args.generate_fabulous_fabric:
        # os.chdir(f"{args.project_dir}/src")
        switch_matrix_generation(args.project_dir)
        RTL_generation(args.project_dir)
        # model_generation(args.project_dir)
        # bit_stream_meta_data_generation(args.project_dir)

    if args.run_fabulous_flow:
        synthesis(args.project_dir, args.top)
        place_and_route(args.project_dir, args.top)
        generate_bitstream(args.project_dir, args.top)

    if len(sys.argv) == 2:
        parser.print_help()
