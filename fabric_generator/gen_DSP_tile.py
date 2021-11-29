import re
from array import *
import fileinput
import sys, getopt
import csv

def main(argv):
    #shared_lut_list = []
    print("DSP_tile\n")
    
    
    # try:
        # with open("verilog_output/fabric.v", 'r') as file :
            # wrapper_top_str = file.read()
    # except IOError:
        # print("verilog_output/fabric.v not accessible")

    with open("verilog_output/fabric.v", "r") as f:
        lines = f.readlines()
        
    DSP_loc = []
    top_line_list = []
    #bot_line_list = []

    for i, line in enumerate(lines):
        if 'DSP_top' in line:
            line_sep = line.split('_')
            DSP_loc.append(line_sep[2])
            top_line_list.append(i)

    print (DSP_loc)

    count = 0
    for i in top_line_list:
        for j in range(52):
            del (lines[i-52*count])
        count = count + 1

    bot_line_list = []

    for i, line in enumerate(lines):
        if 'DSP_bot' in line:
            bot_line_list.append(i)

    count = 0
    for i in bot_line_list:
        for j in range(54):
            del (lines[i-54*count])
        count = count + 1
    
    
    with open("verilog_output/fabric_DSP_tile.v", "w") as f:
        for line in lines:
            if line.strip("\n") != "endmodule":
                f.write(line)
                
    fabric_str = ""
    for loc in DSP_loc:
        loc_temp = loc.replace('X','').split('Y')
        x = int(loc_temp[0])
        y = int(loc_temp[1])
        fabric_str+='\tDSP Tile_X'+str(x)+'Y'+str(y)+'_X'+str(x)+'Y'+str(y+1)+'_DSP_tile (\n'
        fabric_str+='\t.top_E1END(Tile_X'+str(x-1)+'Y'+str(y)+'_E1BEG[3:0]),\n'
        fabric_str+='\t.top_E2MID(Tile_X'+str(x-1)+'Y'+str(y)+'_E2BEG[7:0]),\n'
        fabric_str+='\t.top_E2END(Tile_X'+str(x-1)+'Y'+str(y)+'_E2BEGb[7:0]),\n'
        fabric_str+='\t.top_EE4END(Tile_X'+str(x-1)+'Y'+str(y)+'_EE4BEG[15:0]),\n'
        fabric_str+='\t.top_E6END(Tile_X'+str(x-1)+'Y'+str(y)+'_E6BEG[11:0]),\n'
        fabric_str+='\t.top_S1END(Tile_X'+str(x)+'Y'+str(y-1)+'_S1BEG[3:0]),\n'
        fabric_str+='\t.top_S2MID(Tile_X'+str(x)+'Y'+str(y-1)+'_S2BEG[7:0]),\n'
        fabric_str+='\t.top_S2END(Tile_X'+str(x)+'Y'+str(y-1)+'_S2BEGb[7:0]),\n'
        fabric_str+='\t.top_S4END(Tile_X'+str(x)+'Y'+str(y-1)+'_S4BEG[15:0]),\n'
        fabric_str+='\t.top_SS4END(Tile_X'+str(x)+'Y'+str(y-1)+'_SS4BEG[15:0]),\n'
        fabric_str+='\t.top_W1END(Tile_X'+str(x+1)+'Y'+str(y)+'_W1BEG[3:0]),\n'
        fabric_str+='\t.top_W2MID(Tile_X'+str(x+1)+'Y'+str(y)+'_W2BEG[7:0]),\n'
        fabric_str+='\t.top_W2END(Tile_X'+str(x+1)+'Y'+str(y)+'_W2BEGb[7:0]),\n'
        fabric_str+='\t.top_WW4END(Tile_X'+str(x+1)+'Y'+str(y)+'_WW4BEG[15:0]),\n'
        fabric_str+='\t.top_W6END(Tile_X'+str(x+1)+'Y'+str(y)+'_W6BEG[11:0]),\n'
        fabric_str+='\t.top_N1BEG(Tile_X'+str(x)+'Y'+str(y)+'_N1BEG[3:0]),\n'
        fabric_str+='\t.top_N2BEG(Tile_X'+str(x)+'Y'+str(y)+'_N2BEG[7:0]),\n'
        fabric_str+='\t.top_N2BEGb(Tile_X'+str(x)+'Y'+str(y)+'_N2BEGb[7:0]),\n'
        fabric_str+='\t.top_N4BEG(Tile_X'+str(x)+'Y'+str(y)+'_N4BEG[15:0]),\n'
        fabric_str+='\t.top_NN4BEG(Tile_X'+str(x)+'Y'+str(y)+'_NN4BEG[15:0]),\n'
        fabric_str+='\t.top_E1BEG(Tile_X'+str(x)+'Y'+str(y)+'_E1BEG[3:0]),\n'
        fabric_str+='\t.top_E2BEG(Tile_X'+str(x)+'Y'+str(y)+'_E2BEG[7:0]),\n'
        fabric_str+='\t.top_E2BEGb(Tile_X'+str(x)+'Y'+str(y)+'_E2BEGb[7:0]),\n'
        fabric_str+='\t.top_EE4BEG(Tile_X'+str(x)+'Y'+str(y)+'_EE4BEG[15:0]),\n'
        fabric_str+='\t.top_E6BEG(Tile_X'+str(x)+'Y'+str(y)+'_E6BEG[11:0]),\n'
        fabric_str+='\t.top_W1BEG(Tile_X'+str(x)+'Y'+str(y)+'_W1BEG[3:0]),\n'
        fabric_str+='\t.top_W2BEG(Tile_X'+str(x)+'Y'+str(y)+'_W2BEG[7:0]),\n'
        fabric_str+='\t.top_W2BEGb(Tile_X'+str(x)+'Y'+str(y)+'_W2BEGb[7:0]),\n'
        fabric_str+='\t.top_WW4BEG(Tile_X'+str(x)+'Y'+str(y)+'_WW4BEG[15:0]),\n'
        fabric_str+='\t.top_W6BEG(Tile_X'+str(x)+'Y'+str(y)+'_W6BEG[11:0]),\n'
        fabric_str+='\t.bot_N1END(Tile_X'+str(x)+'Y'+str(y+2)+'_N1BEG[3:0]),\n'
        fabric_str+='\t.bot_N2MID(Tile_X'+str(x)+'Y'+str(y+2)+'_N2BEG[7:0]),\n'
        fabric_str+='\t.bot_N2END(Tile_X'+str(x)+'Y'+str(y+2)+'_N2BEGb[7:0]),\n'
        fabric_str+='\t.bot_N4END(Tile_X'+str(x)+'Y'+str(y+2)+'_N4BEG[15:0]),\n'
        fabric_str+='\t.bot_NN4END(Tile_X'+str(x)+'Y'+str(y+2)+'_NN4BEG[15:0]),\n'
        fabric_str+='\t.bot_E1END(Tile_X'+str(x-1)+'Y'+str(y+1)+'_E1BEG[3:0]),\n'
        fabric_str+='\t.bot_E2MID(Tile_X'+str(x-1)+'Y'+str(y+1)+'_E2BEG[7:0]),\n'
        fabric_str+='\t.bot_E2END(Tile_X'+str(x-1)+'Y'+str(y+1)+'_E2BEGb[7:0]),\n'
        fabric_str+='\t.bot_EE4END(Tile_X'+str(x-1)+'Y'+str(y+1)+'_EE4BEG[15:0]),\n'
        fabric_str+='\t.bot_E6END(Tile_X'+str(x-1)+'Y'+str(y+1)+'_E6BEG[11:0]),\n'
        fabric_str+='\t.bot_W1END(Tile_X'+str(x+1)+'Y'+str(y+1)+'_W1BEG[3:0]),\n'
        fabric_str+='\t.bot_W2MID(Tile_X'+str(x+1)+'Y'+str(y+1)+'_W2BEG[7:0]),\n'
        fabric_str+='\t.bot_W2END(Tile_X'+str(x+1)+'Y'+str(y+1)+'_W2BEGb[7:0]),\n'
        fabric_str+='\t.bot_WW4END(Tile_X'+str(x+1)+'Y'+str(y+1)+'_WW4BEG[15:0]),\n'
        fabric_str+='\t.bot_W6END(Tile_X'+str(x+1)+'Y'+str(y+1)+'_W6BEG[11:0]),\n'
        fabric_str+='\t.bot_E1BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_E1BEG[3:0]),\n'
        fabric_str+='\t.bot_E2BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_E2BEG[7:0]),\n'
        fabric_str+='\t.bot_E2BEGb(Tile_X'+str(x)+'Y'+str(y+1)+'_E2BEGb[7:0]),\n'
        fabric_str+='\t.bot_EE4BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_EE4BEG[15:0]),\n'
        fabric_str+='\t.bot_E6BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_E6BEG[11:0]),\n'
        fabric_str+='\t.bot_S1BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_S1BEG[3:0]),\n'
        fabric_str+='\t.bot_S2BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_S2BEG[7:0]),\n'
        fabric_str+='\t.bot_S2BEGb(Tile_X'+str(x)+'Y'+str(y+1)+'_S2BEGb[7:0]),\n'
        fabric_str+='\t.bot_S4BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_S4BEG[15:0]),\n'
        fabric_str+='\t.bot_SS4BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_SS4BEG[15:0]),\n'
        fabric_str+='\t.bot_W1BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_W1BEG[3:0]),\n'
        fabric_str+='\t.bot_W2BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_W2BEG[7:0]),\n'
        fabric_str+='\t.bot_W2BEGb(Tile_X'+str(x)+'Y'+str(y+1)+'_W2BEGb[7:0]),\n'
        fabric_str+='\t.bot_WW4BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_WW4BEG[15:0]),\n'
        fabric_str+='\t.bot_W6BEG(Tile_X'+str(x)+'Y'+str(y+1)+'_W6BEG[11:0]),\n'
        fabric_str+='\t.UserCLK(UserCLK),\n'
        fabric_str+='`ifdef EMULATION_MODE\n'
        fabric_str+='\t.top_Emulate_Bitstream(`Tile_X'+str(x)+'Y'+str(y)+'_Emulate_Bitstream),\n'
        fabric_str+='\t.bot_Emulate_Bitstream(`Tile_X'+str(x)+'Y'+str(y+1)+'_Emulate_Bitstream)\n'
        fabric_str+='`else\n'
        fabric_str+='\t.top_FrameData(Tile_X'+str(x-1)+'Y'+str(y)+'_FrameData_O),\n'
        fabric_str+='\t.top_FrameData_O(Tile_X'+str(x)+'Y'+str(y)+'_FrameData_O),\n'
        fabric_str+='\t.bot_FrameData(Tile_X'+str(x-1)+'Y'+str(y+1)+'_FrameData_O),\n' 
        fabric_str+='\t.bot_FrameData_O(Tile_X'+str(x)+'Y'+str(y+1)+'_FrameData_O),\n' 
        fabric_str+='\t.FrameStrobe(Tile_X'+str(x)+'Y'+str(y+2)+'_FrameStrobe_O),\n'
        fabric_str+='\t.FrameStrobe_O(Tile_X'+str(x)+'Y'+str(y)+'_FrameStrobe_O)\n'
        fabric_str+='`endif\n'
        fabric_str+='\t);\n\n'
                
    fabric_str += 'endmodule\n'
    
    with open("verilog_output/fabric_DSP_tile.v", "a") as f:
        f.write(fabric_str)
    
    print("Finish")

if __name__ == "__main__":
    main(sys.argv[1:])


#argv = "/home/ise/shared_folder/diffeq1/LC_on/netgen/synthesis/diffeq_paj_convert_synthesis.v"



#if words[i+1] == "critical":
#number1.append(words[i+3])
#elif x == "Total":
#if words[i+1] == "used":
#number2.append(words[i+5])
#print(number1)
#print(number2)