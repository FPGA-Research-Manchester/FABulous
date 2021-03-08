module CPU_IO (E1END, E2MID, E2END, E6END, W1BEG, W2BEG, W2BEGb, W6BEG, OPA_I0, OPA_I1, OPA_I2, OPA_I3, UserCLK, OPB_I0, OPB_I1, OPB_I2, OPB_I3, RES0_O0, RES0_O1, RES0_O2, RES0_O3, RES1_O0, RES1_O1, RES1_O2, RES1_O3, RES2_O0, RES2_O1, RES2_O2, RES2_O3, FrameData, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 20;
	//  NORTH
	//  EAST
	input [3:0] E1END; //wires:4 X_offset:1 Y_offset:0  source_name:NULL destination_name:E1END  
	input [7:0] E2MID; //wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2MID  
	input [7:0] E2END; //wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2END  
	input [11:0] E6END; //wires:2 X_offset:6 Y_offset:0  source_name:NULL destination_name:E6END  
	//  SOUTH
	//  WEST
	output [3:0] W1BEG; //wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:NULL  
	output [7:0] W2BEG; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:NULL  
	output [7:0] W2BEGb; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:NULL  
	output [11:0] W6BEG; //wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:NULL  
	// Tile IO ports from BELs
	input OPA_I0;
	input OPA_I1;
	input OPA_I2;
	input OPA_I3;
	input UserCLK;
	input OPB_I0;
	input OPB_I1;
	input OPB_I2;
	input OPB_I3;
	output RES0_O0;
	output RES0_O1;
	output RES0_O2;
	output RES0_O3;
	output RES1_O0;
	output RES1_O1;
	output RES1_O2;
	output RES1_O3;
	output RES2_O0;
	output RES2_O1;
	output RES2_O2;
	output RES2_O3;
	input [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	input [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 
	//global


//signal declarations
//BEL ports (e.g., slices)
	wire RES0_I0;
	wire RES0_I1;
	wire RES0_I2;
	wire RES0_I3;
	wire RES1_I0;
	wire RES1_I1;
	wire RES1_I2;
	wire RES1_I3;
	wire RES2_I0;
	wire RES2_I1;
	wire RES2_I2;
	wire RES2_I3;
	wire OPA_O0;
	wire OPA_O1;
	wire OPA_O2;
	wire OPA_O3;
	wire OPB_O0;
	wire OPB_O1;
	wire OPB_O2;
	wire OPB_O3;
//jump wires
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
	wire [NoConfigBits-1:0] ConfigBits;

// Cascading of routing for wires spanning more than one tile

// configuration storage latches
	CPU_IO_ConfigMem Inst_CPU_IO_ConfigMem (
	.FrameData(FrameData),
	.FrameStrobe(FrameStrobe),
	.ConfigBits(ConfigBits)
	);

//BEL component instantiations
	InPass4_frame_config Inst_OPA_InPass4_frame_config (
	.O0(OPA_O0),
	.O1(OPA_O1),
	.O2(OPA_O2),
	.O3(OPA_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(OPA_I0),
	.I1(OPA_I1),
	.I2(OPA_I2),
	.I3(OPA_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[4-1:0])
	);

	InPass4_frame_config Inst_OPB_InPass4_frame_config (
	.O0(OPB_O0),
	.O1(OPB_O1),
	.O2(OPB_O2),
	.O3(OPB_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(OPB_I0),
	.I1(OPB_I1),
	.I2(OPB_I2),
	.I3(OPB_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[8-1:4])
	);

	OutPass4_frame_config Inst_RES0_OutPass4_frame_config (
	.I0(RES0_I0),
	.I1(RES0_I1),
	.I2(RES0_I2),
	.I3(RES0_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(RES0_O0),
	.O1(RES0_O1),
	.O2(RES0_O2),
	.O3(RES0_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[12-1:8])
	);

	OutPass4_frame_config Inst_RES1_OutPass4_frame_config (
	.I0(RES1_I0),
	.I1(RES1_I1),
	.I2(RES1_I2),
	.I3(RES1_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(RES1_O0),
	.O1(RES1_O1),
	.O2(RES1_O2),
	.O3(RES1_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[16-1:12])
	);

	OutPass4_frame_config Inst_RES2_OutPass4_frame_config (
	.I0(RES2_I0),
	.I1(RES2_I1),
	.I2(RES2_I2),
	.I3(RES2_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(RES2_O0),
	.O1(RES2_O1),
	.O2(RES2_O2),
	.O3(RES2_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[20-1:16])
	);


//switch matrix component instantiation
	CPU_IO_switch_matrix Inst_CPU_IO_switch_matrix (
	.E1END0(E1END[0]),
	.E1END1(E1END[1]),
	.E1END2(E1END[2]),
	.E1END3(E1END[3]),
	.E2MID0(E2MID[0]),
	.E2MID1(E2MID[1]),
	.E2MID2(E2MID[2]),
	.E2MID3(E2MID[3]),
	.E2MID4(E2MID[4]),
	.E2MID5(E2MID[5]),
	.E2MID6(E2MID[6]),
	.E2MID7(E2MID[7]),
	.E2END0(E2END[0]),
	.E2END1(E2END[1]),
	.E2END2(E2END[2]),
	.E2END3(E2END[3]),
	.E2END4(E2END[4]),
	.E2END5(E2END[5]),
	.E2END6(E2END[6]),
	.E2END7(E2END[7]),
	.E6END0(E6END[0]),
	.E6END1(E6END[1]),
	.E6END2(E6END[2]),
	.E6END3(E6END[3]),
	.E6END4(E6END[4]),
	.E6END5(E6END[5]),
	.E6END6(E6END[6]),
	.E6END7(E6END[7]),
	.E6END8(E6END[8]),
	.E6END9(E6END[9]),
	.E6END10(E6END[10]),
	.E6END11(E6END[11]),
	.OPA_O0(OPA_O0),
	.OPA_O1(OPA_O1),
	.OPA_O2(OPA_O2),
	.OPA_O3(OPA_O3),
	.OPB_O0(OPB_O0),
	.OPB_O1(OPB_O1),
	.OPB_O2(OPB_O2),
	.OPB_O3(OPB_O3),
	.W1BEG0(W1BEG[0]),
	.W1BEG1(W1BEG[1]),
	.W1BEG2(W1BEG[2]),
	.W1BEG3(W1BEG[3]),
	.W2BEG0(W2BEG[0]),
	.W2BEG1(W2BEG[1]),
	.W2BEG2(W2BEG[2]),
	.W2BEG3(W2BEG[3]),
	.W2BEG4(W2BEG[4]),
	.W2BEG5(W2BEG[5]),
	.W2BEG6(W2BEG[6]),
	.W2BEG7(W2BEG[7]),
	.W2BEGb0(W2BEGb[0]),
	.W2BEGb1(W2BEGb[1]),
	.W2BEGb2(W2BEGb[2]),
	.W2BEGb3(W2BEGb[3]),
	.W2BEGb4(W2BEGb[4]),
	.W2BEGb5(W2BEGb[5]),
	.W2BEGb6(W2BEGb[6]),
	.W2BEGb7(W2BEGb[7]),
	.W6BEG0(W6BEG[0]),
	.W6BEG1(W6BEG[1]),
	.W6BEG2(W6BEG[2]),
	.W6BEG3(W6BEG[3]),
	.W6BEG4(W6BEG[4]),
	.W6BEG5(W6BEG[5]),
	.W6BEG6(W6BEG[6]),
	.W6BEG7(W6BEG[7]),
	.W6BEG8(W6BEG[8]),
	.W6BEG9(W6BEG[9]),
	.W6BEG10(W6BEG[10]),
	.W6BEG11(W6BEG[11]),
	.RES0_I0(RES0_I0),
	.RES0_I1(RES0_I1),
	.RES0_I2(RES0_I2),
	.RES0_I3(RES0_I3),
	.RES1_I0(RES1_I0),
	.RES1_I1(RES1_I1),
	.RES1_I2(RES1_I2),
	.RES1_I3(RES1_I3),
	.RES2_I0(RES2_I0),
	.RES2_I1(RES2_I1),
	.RES2_I2(RES2_I2),
	.RES2_I3(RES2_I3)
	);

endmodule
