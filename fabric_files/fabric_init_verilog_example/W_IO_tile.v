module W_IO (E1BEG, E2BEG, E2BEGb, E6BEG, W1END, W2MID, W2END, W6END, A_I_top, A_T_top, A_O_top, UserCLK, B_I_top, B_T_top, B_O_top, FrameData, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 12;
	//  NORTH
	//  EAST
	output [3:0] E1BEG; //wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:NULL  
	output [7:0] E2BEG; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:NULL  
	output [7:0] E2BEGb; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:NULL  
	output [11:0] E6BEG; //wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:NULL  
	//  SOUTH
	//  WEST
	input [3:0] W1END; //wires:4 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W1END  
	input [7:0] W2MID; //wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2MID  
	input [7:0] W2END; //wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2END  
	input [11:0] W6END; //wires:2 X_offset:-6 Y_offset:0  source_name:NULL destination_name:W6END  
	// Tile IO ports from BELs
	output A_I_top;
	output A_T_top;
	input A_O_top;
	input UserCLK;
	output B_I_top;
	output B_T_top;
	input B_O_top;
	input [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	input [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 
	//global


//signal declarations
//BEL ports (e.g., slices)
	wire A_I;
	wire A_T;
	wire B_I;
	wire B_T;
	wire A_O;
	wire A_Q;
	wire B_O;
	wire B_Q;
//jump wires
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
	wire [NoConfigBits-1:0] ConfigBits;

// Cascading of routing for wires spanning more than one tile

// configuration storage latches
	W_IO_ConfigMem Inst_W_IO_ConfigMem (
	.FrameData(FrameData),
	.FrameStrobe(FrameStrobe),
	.ConfigBits(ConfigBits)
	);

//BEL component instantiations
	IO_1_bidirectional_frame_config_pass Inst_A_IO_1_bidirectional_frame_config_pass (
	.I(A_I),
	.T(A_T),
	.O(A_O),
	.Q(A_Q),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I_top(A_I_top),
	.T_top(A_T_top),
	.O_top(A_O_top),
	.UserCLK(UserCLK),
	.ConfigBits(0)
	);

	IO_1_bidirectional_frame_config_pass Inst_B_IO_1_bidirectional_frame_config_pass (
	.I(B_I),
	.T(B_T),
	.O(B_O),
	.Q(B_Q),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I_top(B_I_top),
	.T_top(B_T_top),
	.O_top(B_O_top),
	.UserCLK(UserCLK),
	.ConfigBits(0)
	);


//switch matrix component instantiation
	W_IO_switch_matrix Inst_W_IO_switch_matrix (
	.W1END0(W1END[0]),
	.W1END1(W1END[1]),
	.W1END2(W1END[2]),
	.W1END3(W1END[3]),
	.W2MID0(W2MID[0]),
	.W2MID1(W2MID[1]),
	.W2MID2(W2MID[2]),
	.W2MID3(W2MID[3]),
	.W2MID4(W2MID[4]),
	.W2MID5(W2MID[5]),
	.W2MID6(W2MID[6]),
	.W2MID7(W2MID[7]),
	.W2END0(W2END[0]),
	.W2END1(W2END[1]),
	.W2END2(W2END[2]),
	.W2END3(W2END[3]),
	.W2END4(W2END[4]),
	.W2END5(W2END[5]),
	.W2END6(W2END[6]),
	.W2END7(W2END[7]),
	.W6END0(W6END[0]),
	.W6END1(W6END[1]),
	.W6END2(W6END[2]),
	.W6END3(W6END[3]),
	.W6END4(W6END[4]),
	.W6END5(W6END[5]),
	.W6END6(W6END[6]),
	.W6END7(W6END[7]),
	.W6END8(W6END[8]),
	.W6END9(W6END[9]),
	.W6END10(W6END[10]),
	.W6END11(W6END[11]),
	.A_O(A_O),
	.A_Q(A_Q),
	.B_O(B_O),
	.B_Q(B_Q),
	.E1BEG0(E1BEG[0]),
	.E1BEG1(E1BEG[1]),
	.E1BEG2(E1BEG[2]),
	.E1BEG3(E1BEG[3]),
	.E2BEG0(E2BEG[0]),
	.E2BEG1(E2BEG[1]),
	.E2BEG2(E2BEG[2]),
	.E2BEG3(E2BEG[3]),
	.E2BEG4(E2BEG[4]),
	.E2BEG5(E2BEG[5]),
	.E2BEG6(E2BEG[6]),
	.E2BEG7(E2BEG[7]),
	.E2BEGb0(E2BEGb[0]),
	.E2BEGb1(E2BEGb[1]),
	.E2BEGb2(E2BEGb[2]),
	.E2BEGb3(E2BEGb[3]),
	.E2BEGb4(E2BEGb[4]),
	.E2BEGb5(E2BEGb[5]),
	.E2BEGb6(E2BEGb[6]),
	.E2BEGb7(E2BEGb[7]),
	.E6BEG0(E6BEG[0]),
	.E6BEG1(E6BEG[1]),
	.E6BEG2(E6BEG[2]),
	.E6BEG3(E6BEG[3]),
	.E6BEG4(E6BEG[4]),
	.E6BEG5(E6BEG[5]),
	.E6BEG6(E6BEG[6]),
	.E6BEG7(E6BEG[7]),
	.E6BEG8(E6BEG[8]),
	.E6BEG9(E6BEG[9]),
	.E6BEG10(E6BEG[10]),
	.E6BEG11(E6BEG[11]),
	.A_I(A_I),
	.A_T(A_T),
	.B_I(B_I),
	.B_T(B_T),
	.ConfigBits(ConfigBits[12-1:0])
	);

endmodule
