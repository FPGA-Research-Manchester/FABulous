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

import re
from array import *
import fileinput
import sys, getopt
import csv

def main(argv):
    NumberOfRows = 16;
    NumberOfCols = 19;
    FrameBitsPerRow = 32;
    MaxFramesPerCol = 20;
    desync_flag = 20;
    FrameSelectWidth = 5;
    RowSelectWidth = 5;

    #print("hello")
    
    try:
        opts, args = getopt.getopt(argv,"hr:c:b:f:d:",["NumberOfRows=","NumberOfCols=","FrameBitsPerRow=","MaxFramesPerCol=","desync_flag="])
    except getopt.GetoptError:
        print ('top_wrapper_generator.py -r <NumberOfRows> -c <NumberOfCols> -b <FrameBitsPerRow> -f <MaxFramesPerCol> -d <desync_flag>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('top_wrapper_generator.py -r <NumberOfRows> -c <NumberOfCols> -b <FrameBitsPerRow> -f <MaxFramesPerCol> -d <desync_flag>')
            sys.exit()
        elif opt in ("-r", "--NumberOfRows"):
            NumberOfRows = int(arg)
        elif opt in ("-c", "--NumberOfCols"):
            NumberOfCols = int(arg)
        elif opt in ("-b", "--FrameBitsPerRow"):
            FrameBitsPerRow = int(arg)
        elif opt in ("-f", "--MaxFramesPerCol"):
            MaxFramesPerCol = int(arg)
        elif opt in ("-d", "--desync_flag"):
            desync_flag = int(arg)
            
    print ('NumberOfRows is "', NumberOfRows)
    print ('NumberOfCols is "', NumberOfCols)
    print ('FrameBitsPerRow is "', FrameBitsPerRow)
    print ('MaxFramesPerCol is "', MaxFramesPerCol)
    print ('desync_flag is "', desync_flag)
    print ('FrameSelectWidth is "', FrameSelectWidth)
    print ('RowSelectWidth is "', RowSelectWidth)
    
    wrapper_top_str = ""
    config_str = ""
    configfsm_str = ""
    data_reg_modules = ""
    strobe_reg_modules = ""
    testbench_str = ""

    
    with open("./template_files/eFPGA_top_sky130_template.v", 'r') as file :
        wrapper_top_str = file.read()

    with open("./template_files/Config_template.v", 'r') as file :
        config_str = file.read()
        
    with open("./template_files/ConfigFSM_template.v", 'r') as file :
        configfsm_str = file.read()
        
    with open("./template_files/tb_bitbang_template.vhd", 'r') as file :
        testbench_str = file.read()

    wrapper_top_str = wrapper_top_str.replace("[32-1:0] I_top", '['+str(NumberOfRows*2)+'-1:0] I_top')
    wrapper_top_str = wrapper_top_str.replace("[32-1:0] T_top", '['+str(NumberOfRows*2)+'-1:0] T_top')
    wrapper_top_str = wrapper_top_str.replace("[32-1:0] O_top", '['+str(NumberOfRows*2)+'-1:0] O_top')
    wrapper_top_str = wrapper_top_str.replace("[64-1:0] OPA", '['+str(NumberOfRows*4)+'-1:0] OPA')
    wrapper_top_str = wrapper_top_str.replace("[64-1:0] OPB", '['+str(NumberOfRows*4)+'-1:0] OPB')
    wrapper_top_str = wrapper_top_str.replace("[64-1:0] RES0", '['+str(NumberOfRows*4)+'-1:0] RES0')
    wrapper_top_str = wrapper_top_str.replace("[64-1:0] RES1", '['+str(NumberOfRows*4)+'-1:0] RES1')
    wrapper_top_str = wrapper_top_str.replace("[64-1:0] RES2", '['+str(NumberOfRows*4)+'-1:0] RES2')
    

    wrapper_top_str = wrapper_top_str.replace("parameter NumberOfRows = 16", "parameter NumberOfRows = "+str(NumberOfRows))
    wrapper_top_str = wrapper_top_str.replace("parameter NumberOfCols = 19", "parameter NumberOfCols = "+str(NumberOfCols))
    

    config_str = config_str.replace("parameter RowSelectWidth = 5", "parameter RowSelectWidth = "+str(RowSelectWidth))
    config_str = config_str.replace("parameter FrameBitsPerRow = 32", "parameter FrameBitsPerRow = "+str(FrameBitsPerRow))

    
    configfsm_str = configfsm_str.replace("parameter NumberOfRows = 16", "parameter NumberOfRows = "+str(NumberOfRows))
    configfsm_str = configfsm_str.replace("parameter RowSelectWidth = 5", "parameter RowSelectWidth = "+str(RowSelectWidth))
    configfsm_str = configfsm_str.replace("parameter FrameBitsPerRow = 32", "parameter FrameBitsPerRow = "+str(FrameBitsPerRow))
    configfsm_str = configfsm_str.replace("parameter desync_flag = 20", "parameter desync_flag = "+str(desync_flag))
    
    testbench_str = testbench_str.replace(" STD_LOGIC_VECTOR (32 -1 downto 0)", " STD_LOGIC_VECTOR ("+str(NumberOfRows*2)+" -1 downto 0)")
    testbench_str = testbench_str.replace("STD_LOGIC_VECTOR (64 -1 downto 0)", "STD_LOGIC_VECTOR ("+str(NumberOfRows*4)+" -1 downto 0)")
    
    for row in range(NumberOfRows):
        data_reg_module_temp =""
        
        data_reg_name = 'Frame_Data_Reg_'+str(row)
        wrapper_top_str+='\t'+data_reg_name+' Inst_'+data_reg_name+' (\n'
        wrapper_top_str+='\t.FrameData_I(LocalWriteData),\n'
        wrapper_top_str+='\t.FrameData_O(FrameRegister['+str(row)+'*FrameBitsPerRow+:FrameBitsPerRow]),\n'
        wrapper_top_str+='\t.RowSelect(RowSelect),\n'
        wrapper_top_str+='\t.CLK(CLK)\n'
        wrapper_top_str+='\t);\n\n'

        with open("./template_files/Frame_Data_Reg_template.v", 'r') as file :
            data_reg_module_temp = file.read()
        data_reg_module_temp=data_reg_module_temp.replace("Frame_Data_Reg", data_reg_name)
        data_reg_module_temp=data_reg_module_temp.replace("parameter FrameBitsPerRow = 32", "parameter FrameBitsPerRow = "+str(FrameBitsPerRow))
        data_reg_module_temp=data_reg_module_temp.replace("parameter RowSelectWidth = 5", "parameter RowSelectWidth = "+str(RowSelectWidth))
        data_reg_module_temp=data_reg_module_temp.replace("parameter Row = 1", "parameter Row = "+str(row+1))
        data_reg_modules += data_reg_module_temp+'\n\n'
        
    for col in range(NumberOfCols):
        strobe_reg_module_temp =""
        
        strobe_reg_name = 'Frame_Select_'+str(col)
        wrapper_top_str+='\t'+strobe_reg_name+' Inst_'+strobe_reg_name+' (\n'
        wrapper_top_str+='\t.FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),\n'
        wrapper_top_str+='\t.FrameStrobe_O(FrameSelect['+str(col)+'*MaxFramesPerCol +: MaxFramesPerCol]),\n'
        wrapper_top_str+='\t.FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-(FrameSelectWidth)]),\n'
        wrapper_top_str+='\t.FrameStrobe(LongFrameStrobe)\n'
        wrapper_top_str+='\t);\n\n'
        with open("./template_files/Frame_Select_template.v", 'r') as file :
            strobe_reg_module_temp = file.read()
        strobe_reg_module_temp=strobe_reg_module_temp.replace("Frame_Select", strobe_reg_name)
        strobe_reg_module_temp=strobe_reg_module_temp.replace("parameter MaxFramesPerCol = 20", "parameter MaxFramesPerCol = "+str(MaxFramesPerCol))
        strobe_reg_module_temp=strobe_reg_module_temp.replace("parameter FrameSelectWidth = 5", "parameter FrameSelectWidth = "+str(FrameSelectWidth))
        strobe_reg_module_temp=strobe_reg_module_temp.replace("parameter Col = 18", "parameter Col = "+str(col))
        strobe_reg_modules += strobe_reg_module_temp+'\n\n'

    wrapper_top_str+='\teFPGA Inst_eFPGA(\n'
    
    I_top_str =""
    T_top_str = ""
    O_top_str = ""
    count = 0
    for i in range(NumberOfRows*2-1,-1,-2):
        count += 1
        I_top_str+='\t.Tile_X0Y'+str(count)+'_A_I_top(I_top['+str(i)+']),\n'
        I_top_str+='\t.Tile_X0Y'+str(count)+'_B_I_top(I_top['+str(i-1)+']),\n'
        
        T_top_str+='\t.Tile_X0Y'+str(count)+'_A_T_top(T_top['+str(i)+']),\n'
        T_top_str+='\t.Tile_X0Y'+str(count)+'_B_T_top(T_top['+str(i-1)+']),\n'
        
        O_top_str+='\t.Tile_X0Y'+str(count)+'_A_O_top(O_top['+str(i)+']),\n'
        O_top_str+='\t.Tile_X0Y'+str(count)+'_B_O_top(O_top['+str(i-1)+']),\n'
    
    OPA_str =""
    OPB_str = ""
    RES0_str = ""
    RES1_str = ""
    RES2_str = ""
    count = 0
    for i in range(NumberOfRows*4-1,-1,-4):
        count += 1
        OPA_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPA_I0(OPA['+str(i)+']),\n'
        OPA_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPA_I1(OPA['+str(i-1)+']),\n'
        OPA_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPA_I2(OPA['+str(i-2)+']),\n'
        OPA_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPA_I3(OPA['+str(i-3)+']),\n'
        
        OPB_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPB_I0(OPB['+str(i)+']),\n'
        OPB_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPB_I1(OPB['+str(i-1)+']),\n'
        OPB_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPB_I2(OPB['+str(i-2)+']),\n'
        OPB_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_OPB_I3(OPB['+str(i-3)+']),\n'
        
        RES0_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES0_O0(RES0['+str(i)+']),\n'
        RES0_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES0_O1(RES0['+str(i-1)+']),\n'
        RES0_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES0_O2(RES0['+str(i-2)+']),\n'
        RES0_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES0_O3(RES0['+str(i-3)+']),\n'
        
        RES1_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES1_O0(RES1['+str(i)+']),\n'
        RES1_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES1_O1(RES1['+str(i-1)+']),\n'
        RES1_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES1_O2(RES1['+str(i-2)+']),\n'
        RES1_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES1_O3(RES1['+str(i-3)+']),\n'
        
        RES2_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES2_O0(RES2['+str(i)+']),\n'
        RES2_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES2_O1(RES2['+str(i-1)+']),\n'
        RES2_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES2_O2(RES2['+str(i-2)+']),\n'
        RES2_str+='\t.Tile_X'+str(NumberOfCols-1)+'Y'+str(count)+'_RES2_O3(RES2['+str(i-3)+']),\n'
    
    wrapper_top_str+=I_top_str+'\n'
    wrapper_top_str+=T_top_str+'\n'
    wrapper_top_str+=O_top_str+'\n'
    wrapper_top_str+=OPA_str+'\n'
    wrapper_top_str+=OPB_str+'\n'
    wrapper_top_str+=RES0_str+'\n'
    wrapper_top_str+=RES1_str+'\n'
    wrapper_top_str+=RES2_str+'\n'
    
    wrapper_top_str+='\t//declarations\n'
    wrapper_top_str+='\t.UserCLK(CLK),\n'
    wrapper_top_str+='\t.FrameData(FrameData),\n'
    wrapper_top_str+='\t.FrameStrobe(FrameSelect)\n'
    wrapper_top_str+='\t);\n'
    
    wrapper_top_str+="\tassign FrameData = {32'h12345678,FrameRegister,32'h12345678};\n\n"
    wrapper_top_str+='endmodule\n\n'
    
    with open("./eFPGA_top_sky130.v", 'w') as file:
        file.write(wrapper_top_str)

    with open("./Frame_Data_Reg_Pack.v", 'w') as file:
        file.write(data_reg_modules)

    with open("./Frame_Select_Pack.v", 'w') as file:
        file.write(strobe_reg_modules)
        
    with open("./Config.v", 'w') as file:
        file.write(config_str)
        
    with open("./ConfigFSM.v", 'w') as file:
        file.write(configfsm_str)
        
    with open("./tb_bitbang.vhd", 'w') as file:
        file.write(testbench_str)
    
    #print("Finish")

if __name__ == "__main__":
    main(sys.argv[1:])

