module N_term_single2 (N1END, N2MID, N2END, N4END, S1BEG, S2BEG, S2BEGb, S4BEG);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 0;
	//  NORTH
	input [3:0] N1END; //wires:4 X_offset:0 Y_offset:1  source_name:NULL destination_name:N1END  
	input [7:0] N2MID; //wires:8 X_offset:0 Y_offset:1  source_name:NULL destination_name:N2MID  
	input [7:0] N2END; //wires:8 X_offset:0 Y_offset:1  source_name:NULL destination_name:N2END  
	input [15:0] N4END; //wires:4 X_offset:0 Y_offset:4  source_name:NULL destination_name:N4END  
	//  EAST
	//  SOUTH
	output [3:0] S1BEG; //wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:NULL  
	output [7:0] S2BEG; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:NULL  
	output [7:0] S2BEGb; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:NULL  
	output [15:0] S4BEG; //wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:NULL  
	//  WEST
	//global


//signal declarations
//BEL ports (e.g., slices)
//jump wires
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)

// Cascading of routing for wires spanning more than one tile

//BEL component instantiations

//switch matrix component instantiation
	N_term_single2_switch_matrix Inst_N_term_single2_switch_matrix (
	.N1END0(N1END[0]),
	.N1END1(N1END[1]),
	.N1END2(N1END[2]),
	.N1END3(N1END[3]),
	.N2MID0(N2MID[0]),
	.N2MID1(N2MID[1]),
	.N2MID2(N2MID[2]),
	.N2MID3(N2MID[3]),
	.N2MID4(N2MID[4]),
	.N2MID5(N2MID[5]),
	.N2MID6(N2MID[6]),
	.N2MID7(N2MID[7]),
	.N2END0(N2END[0]),
	.N2END1(N2END[1]),
	.N2END2(N2END[2]),
	.N2END3(N2END[3]),
	.N2END4(N2END[4]),
	.N2END5(N2END[5]),
	.N2END6(N2END[6]),
	.N2END7(N2END[7]),
	.N4END0(N4END[0]),
	.N4END1(N4END[1]),
	.N4END2(N4END[2]),
	.N4END3(N4END[3]),
	.N4END4(N4END[4]),
	.N4END5(N4END[5]),
	.N4END6(N4END[6]),
	.N4END7(N4END[7]),
	.N4END8(N4END[8]),
	.N4END9(N4END[9]),
	.N4END10(N4END[10]),
	.N4END11(N4END[11]),
	.N4END12(N4END[12]),
	.N4END13(N4END[13]),
	.N4END14(N4END[14]),
	.N4END15(N4END[15]),
	.S1BEG0(S1BEG[0]),
	.S1BEG1(S1BEG[1]),
	.S1BEG2(S1BEG[2]),
	.S1BEG3(S1BEG[3]),
	.S2BEG0(S2BEG[0]),
	.S2BEG1(S2BEG[1]),
	.S2BEG2(S2BEG[2]),
	.S2BEG3(S2BEG[3]),
	.S2BEG4(S2BEG[4]),
	.S2BEG5(S2BEG[5]),
	.S2BEG6(S2BEG[6]),
	.S2BEG7(S2BEG[7]),
	.S2BEGb0(S2BEGb[0]),
	.S2BEGb1(S2BEGb[1]),
	.S2BEGb2(S2BEGb[2]),
	.S2BEGb3(S2BEGb[3]),
	.S2BEGb4(S2BEGb[4]),
	.S2BEGb5(S2BEGb[5]),
	.S2BEGb6(S2BEGb[6]),
	.S2BEGb7(S2BEGb[7]),
	.S4BEG0(S4BEG[0]),
	.S4BEG1(S4BEG[1]),
	.S4BEG2(S4BEG[2]),
	.S4BEG3(S4BEG[3]),
	.S4BEG4(S4BEG[4]),
	.S4BEG5(S4BEG[5]),
	.S4BEG6(S4BEG[6]),
	.S4BEG7(S4BEG[7]),
	.S4BEG8(S4BEG[8]),
	.S4BEG9(S4BEG[9]),
	.S4BEG10(S4BEG[10]),
	.S4BEG11(S4BEG[11]),
	.S4BEG12(S4BEG[12]),
	.S4BEG13(S4BEG[13]),
	.S4BEG14(S4BEG[14]),
	.S4BEG15(S4BEG[15])
	);

endmodule
