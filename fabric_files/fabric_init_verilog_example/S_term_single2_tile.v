module S_term_single2 (N1BEG, N2BEG, N2BEGb, N4BEG, S1END, S2MID, S2END, S4END);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 0;
	//  NORTH
	output [3:0] N1BEG; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:NULL  
	output [7:0] N2BEG; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:NULL  
	output [7:0] N2BEGb; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:NULL  
	output [15:0] N4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:NULL  
	//  EAST
	//  SOUTH
	input [3:0] S1END; //wires:4 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S1END  
	input [7:0] S2MID; //wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2MID  
	input [7:0] S2END; //wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2END  
	input [15:0] S4END; //wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:S4END  
	//  WEST
	//global


//signal declarations
//BEL ports (e.g., slices)
//jump wires
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)

// Cascading of routing for wires spanning more than one tile

//BEL component instantiations

//switch matrix component instantiation
	S_term_single2_switch_matrix Inst_S_term_single2_switch_matrix (
	.S1END0(S1END[0]),
	.S1END1(S1END[1]),
	.S1END2(S1END[2]),
	.S1END3(S1END[3]),
	.S2MID0(S2MID[0]),
	.S2MID1(S2MID[1]),
	.S2MID2(S2MID[2]),
	.S2MID3(S2MID[3]),
	.S2MID4(S2MID[4]),
	.S2MID5(S2MID[5]),
	.S2MID6(S2MID[6]),
	.S2MID7(S2MID[7]),
	.S2END0(S2END[0]),
	.S2END1(S2END[1]),
	.S2END2(S2END[2]),
	.S2END3(S2END[3]),
	.S2END4(S2END[4]),
	.S2END5(S2END[5]),
	.S2END6(S2END[6]),
	.S2END7(S2END[7]),
	.S4END0(S4END[0]),
	.S4END1(S4END[1]),
	.S4END2(S4END[2]),
	.S4END3(S4END[3]),
	.S4END4(S4END[4]),
	.S4END5(S4END[5]),
	.S4END6(S4END[6]),
	.S4END7(S4END[7]),
	.S4END8(S4END[8]),
	.S4END9(S4END[9]),
	.S4END10(S4END[10]),
	.S4END11(S4END[11]),
	.S4END12(S4END[12]),
	.S4END13(S4END[13]),
	.S4END14(S4END[14]),
	.S4END15(S4END[15]),
	.N1BEG0(N1BEG[0]),
	.N1BEG1(N1BEG[1]),
	.N1BEG2(N1BEG[2]),
	.N1BEG3(N1BEG[3]),
	.N2BEG0(N2BEG[0]),
	.N2BEG1(N2BEG[1]),
	.N2BEG2(N2BEG[2]),
	.N2BEG3(N2BEG[3]),
	.N2BEG4(N2BEG[4]),
	.N2BEG5(N2BEG[5]),
	.N2BEG6(N2BEG[6]),
	.N2BEG7(N2BEG[7]),
	.N2BEGb0(N2BEGb[0]),
	.N2BEGb1(N2BEGb[1]),
	.N2BEGb2(N2BEGb[2]),
	.N2BEGb3(N2BEGb[3]),
	.N2BEGb4(N2BEGb[4]),
	.N2BEGb5(N2BEGb[5]),
	.N2BEGb6(N2BEGb[6]),
	.N2BEGb7(N2BEGb[7]),
	.N4BEG0(N4BEG[0]),
	.N4BEG1(N4BEG[1]),
	.N4BEG2(N4BEG[2]),
	.N4BEG3(N4BEG[3]),
	.N4BEG4(N4BEG[4]),
	.N4BEG5(N4BEG[5]),
	.N4BEG6(N4BEG[6]),
	.N4BEG7(N4BEG[7]),
	.N4BEG8(N4BEG[8]),
	.N4BEG9(N4BEG[9]),
	.N4BEG10(N4BEG[10]),
	.N4BEG11(N4BEG[11]),
	.N4BEG12(N4BEG[12]),
	.N4BEG13(N4BEG[13]),
	.N4BEG14(N4BEG[14]),
	.N4BEG15(N4BEG[15])
	);

endmodule
