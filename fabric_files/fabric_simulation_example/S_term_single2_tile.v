module S_term_single2 (N1BEG, N2BEG, N2BEGb, N4BEG, NN4BEG, S1END, S2MID, S2END, S4END, SS4END, FrameData, FrameData_O, FrameStrobe, FrameStrobe_O);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 0;
	//  NORTH
	output [3:0] N1BEG; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:NULL  
	output [7:0] N2BEG; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:NULL  
	output [7:0] N2BEGb; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:NULL  
	output [15:0] N4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:NULL  
	output [15:0] NN4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NULL  
	//  EAST
	//  SOUTH
	input [3:0] S1END; //wires:4 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S1END  
	input [7:0] S2MID; //wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2MID  
	input [7:0] S2END; //wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2END  
	input [15:0] S4END; //wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:S4END  
	input [15:0] SS4END; //wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:SS4END  
	//  WEST
	input [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [FrameBitsPerRow-1:0] FrameData_O;
	input [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [MaxFramesPerCol-1:0] FrameStrobe_O;
	//global


//signal declarations
//BEL ports (e.g., slices)
//jump wires
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)

// Cascading of routing for wires spanning more than one tile
	wire [FrameBitsPerRow-1:0] FrameData_i;
	wire [FrameBitsPerRow-1:0] FrameData_O_i;
	assign FrameData_O_i = FrameData_i;

	my_buf data_inbuf_0 (
	.A(FrameData[0]),
	.X(FrameData_i[0])
	);

	my_buf data_inbuf_1 (
	.A(FrameData[1]),
	.X(FrameData_i[1])
	);

	my_buf data_inbuf_2 (
	.A(FrameData[2]),
	.X(FrameData_i[2])
	);

	my_buf data_inbuf_3 (
	.A(FrameData[3]),
	.X(FrameData_i[3])
	);

	my_buf data_inbuf_4 (
	.A(FrameData[4]),
	.X(FrameData_i[4])
	);

	my_buf data_inbuf_5 (
	.A(FrameData[5]),
	.X(FrameData_i[5])
	);

	my_buf data_inbuf_6 (
	.A(FrameData[6]),
	.X(FrameData_i[6])
	);

	my_buf data_inbuf_7 (
	.A(FrameData[7]),
	.X(FrameData_i[7])
	);

	my_buf data_inbuf_8 (
	.A(FrameData[8]),
	.X(FrameData_i[8])
	);

	my_buf data_inbuf_9 (
	.A(FrameData[9]),
	.X(FrameData_i[9])
	);

	my_buf data_inbuf_10 (
	.A(FrameData[10]),
	.X(FrameData_i[10])
	);

	my_buf data_inbuf_11 (
	.A(FrameData[11]),
	.X(FrameData_i[11])
	);

	my_buf data_inbuf_12 (
	.A(FrameData[12]),
	.X(FrameData_i[12])
	);

	my_buf data_inbuf_13 (
	.A(FrameData[13]),
	.X(FrameData_i[13])
	);

	my_buf data_inbuf_14 (
	.A(FrameData[14]),
	.X(FrameData_i[14])
	);

	my_buf data_inbuf_15 (
	.A(FrameData[15]),
	.X(FrameData_i[15])
	);

	my_buf data_inbuf_16 (
	.A(FrameData[16]),
	.X(FrameData_i[16])
	);

	my_buf data_inbuf_17 (
	.A(FrameData[17]),
	.X(FrameData_i[17])
	);

	my_buf data_inbuf_18 (
	.A(FrameData[18]),
	.X(FrameData_i[18])
	);

	my_buf data_inbuf_19 (
	.A(FrameData[19]),
	.X(FrameData_i[19])
	);

	my_buf data_inbuf_20 (
	.A(FrameData[20]),
	.X(FrameData_i[20])
	);

	my_buf data_inbuf_21 (
	.A(FrameData[21]),
	.X(FrameData_i[21])
	);

	my_buf data_inbuf_22 (
	.A(FrameData[22]),
	.X(FrameData_i[22])
	);

	my_buf data_inbuf_23 (
	.A(FrameData[23]),
	.X(FrameData_i[23])
	);

	my_buf data_inbuf_24 (
	.A(FrameData[24]),
	.X(FrameData_i[24])
	);

	my_buf data_inbuf_25 (
	.A(FrameData[25]),
	.X(FrameData_i[25])
	);

	my_buf data_inbuf_26 (
	.A(FrameData[26]),
	.X(FrameData_i[26])
	);

	my_buf data_inbuf_27 (
	.A(FrameData[27]),
	.X(FrameData_i[27])
	);

	my_buf data_inbuf_28 (
	.A(FrameData[28]),
	.X(FrameData_i[28])
	);

	my_buf data_inbuf_29 (
	.A(FrameData[29]),
	.X(FrameData_i[29])
	);

	my_buf data_inbuf_30 (
	.A(FrameData[30]),
	.X(FrameData_i[30])
	);

	my_buf data_inbuf_31 (
	.A(FrameData[31]),
	.X(FrameData_i[31])
	);

	my_buf data_outbuf_0 (
	.A(FrameData_O_i[0]),
	.X(FrameData_O[0])
	);

	my_buf data_outbuf_1 (
	.A(FrameData_O_i[1]),
	.X(FrameData_O[1])
	);

	my_buf data_outbuf_2 (
	.A(FrameData_O_i[2]),
	.X(FrameData_O[2])
	);

	my_buf data_outbuf_3 (
	.A(FrameData_O_i[3]),
	.X(FrameData_O[3])
	);

	my_buf data_outbuf_4 (
	.A(FrameData_O_i[4]),
	.X(FrameData_O[4])
	);

	my_buf data_outbuf_5 (
	.A(FrameData_O_i[5]),
	.X(FrameData_O[5])
	);

	my_buf data_outbuf_6 (
	.A(FrameData_O_i[6]),
	.X(FrameData_O[6])
	);

	my_buf data_outbuf_7 (
	.A(FrameData_O_i[7]),
	.X(FrameData_O[7])
	);

	my_buf data_outbuf_8 (
	.A(FrameData_O_i[8]),
	.X(FrameData_O[8])
	);

	my_buf data_outbuf_9 (
	.A(FrameData_O_i[9]),
	.X(FrameData_O[9])
	);

	my_buf data_outbuf_10 (
	.A(FrameData_O_i[10]),
	.X(FrameData_O[10])
	);

	my_buf data_outbuf_11 (
	.A(FrameData_O_i[11]),
	.X(FrameData_O[11])
	);

	my_buf data_outbuf_12 (
	.A(FrameData_O_i[12]),
	.X(FrameData_O[12])
	);

	my_buf data_outbuf_13 (
	.A(FrameData_O_i[13]),
	.X(FrameData_O[13])
	);

	my_buf data_outbuf_14 (
	.A(FrameData_O_i[14]),
	.X(FrameData_O[14])
	);

	my_buf data_outbuf_15 (
	.A(FrameData_O_i[15]),
	.X(FrameData_O[15])
	);

	my_buf data_outbuf_16 (
	.A(FrameData_O_i[16]),
	.X(FrameData_O[16])
	);

	my_buf data_outbuf_17 (
	.A(FrameData_O_i[17]),
	.X(FrameData_O[17])
	);

	my_buf data_outbuf_18 (
	.A(FrameData_O_i[18]),
	.X(FrameData_O[18])
	);

	my_buf data_outbuf_19 (
	.A(FrameData_O_i[19]),
	.X(FrameData_O[19])
	);

	my_buf data_outbuf_20 (
	.A(FrameData_O_i[20]),
	.X(FrameData_O[20])
	);

	my_buf data_outbuf_21 (
	.A(FrameData_O_i[21]),
	.X(FrameData_O[21])
	);

	my_buf data_outbuf_22 (
	.A(FrameData_O_i[22]),
	.X(FrameData_O[22])
	);

	my_buf data_outbuf_23 (
	.A(FrameData_O_i[23]),
	.X(FrameData_O[23])
	);

	my_buf data_outbuf_24 (
	.A(FrameData_O_i[24]),
	.X(FrameData_O[24])
	);

	my_buf data_outbuf_25 (
	.A(FrameData_O_i[25]),
	.X(FrameData_O[25])
	);

	my_buf data_outbuf_26 (
	.A(FrameData_O_i[26]),
	.X(FrameData_O[26])
	);

	my_buf data_outbuf_27 (
	.A(FrameData_O_i[27]),
	.X(FrameData_O[27])
	);

	my_buf data_outbuf_28 (
	.A(FrameData_O_i[28]),
	.X(FrameData_O[28])
	);

	my_buf data_outbuf_29 (
	.A(FrameData_O_i[29]),
	.X(FrameData_O[29])
	);

	my_buf data_outbuf_30 (
	.A(FrameData_O_i[30]),
	.X(FrameData_O[30])
	);

	my_buf data_outbuf_31 (
	.A(FrameData_O_i[31]),
	.X(FrameData_O[31])
	);

	wire [MaxFramesPerCol-1:0] FrameStrobe_i;
	wire [MaxFramesPerCol-1:0] FrameStrobe_O_i;
	assign FrameStrobe_O_i = FrameStrobe_i;

	my_buf strobe_inbuf_0 (
	.A(FrameStrobe[0]),
	.X(FrameStrobe_i[0])
	)
;
	my_buf strobe_inbuf_1 (
	.A(FrameStrobe[1]),
	.X(FrameStrobe_i[1])
	)
;
	my_buf strobe_inbuf_2 (
	.A(FrameStrobe[2]),
	.X(FrameStrobe_i[2])
	)
;
	my_buf strobe_inbuf_3 (
	.A(FrameStrobe[3]),
	.X(FrameStrobe_i[3])
	)
;
	my_buf strobe_inbuf_4 (
	.A(FrameStrobe[4]),
	.X(FrameStrobe_i[4])
	)
;
	my_buf strobe_inbuf_5 (
	.A(FrameStrobe[5]),
	.X(FrameStrobe_i[5])
	)
;
	my_buf strobe_inbuf_6 (
	.A(FrameStrobe[6]),
	.X(FrameStrobe_i[6])
	)
;
	my_buf strobe_inbuf_7 (
	.A(FrameStrobe[7]),
	.X(FrameStrobe_i[7])
	)
;
	my_buf strobe_inbuf_8 (
	.A(FrameStrobe[8]),
	.X(FrameStrobe_i[8])
	)
;
	my_buf strobe_inbuf_9 (
	.A(FrameStrobe[9]),
	.X(FrameStrobe_i[9])
	)
;
	my_buf strobe_inbuf_10 (
	.A(FrameStrobe[10]),
	.X(FrameStrobe_i[10])
	)
;
	my_buf strobe_inbuf_11 (
	.A(FrameStrobe[11]),
	.X(FrameStrobe_i[11])
	)
;
	my_buf strobe_inbuf_12 (
	.A(FrameStrobe[12]),
	.X(FrameStrobe_i[12])
	)
;
	my_buf strobe_inbuf_13 (
	.A(FrameStrobe[13]),
	.X(FrameStrobe_i[13])
	)
;
	my_buf strobe_inbuf_14 (
	.A(FrameStrobe[14]),
	.X(FrameStrobe_i[14])
	)
;
	my_buf strobe_inbuf_15 (
	.A(FrameStrobe[15]),
	.X(FrameStrobe_i[15])
	)
;
	my_buf strobe_inbuf_16 (
	.A(FrameStrobe[16]),
	.X(FrameStrobe_i[16])
	)
;
	my_buf strobe_inbuf_17 (
	.A(FrameStrobe[17]),
	.X(FrameStrobe_i[17])
	)
;
	my_buf strobe_inbuf_18 (
	.A(FrameStrobe[18]),
	.X(FrameStrobe_i[18])
	)
;
	my_buf strobe_inbuf_19 (
	.A(FrameStrobe[19]),
	.X(FrameStrobe_i[19])
	)
;
	my_buf strobe_outbuf_0 (
	.A(FrameStrobe_O_i[0]),
	.X(FrameStrobe_O[0])
	)
;
	my_buf strobe_outbuf_1 (
	.A(FrameStrobe_O_i[1]),
	.X(FrameStrobe_O[1])
	)
;
	my_buf strobe_outbuf_2 (
	.A(FrameStrobe_O_i[2]),
	.X(FrameStrobe_O[2])
	)
;
	my_buf strobe_outbuf_3 (
	.A(FrameStrobe_O_i[3]),
	.X(FrameStrobe_O[3])
	)
;
	my_buf strobe_outbuf_4 (
	.A(FrameStrobe_O_i[4]),
	.X(FrameStrobe_O[4])
	)
;
	my_buf strobe_outbuf_5 (
	.A(FrameStrobe_O_i[5]),
	.X(FrameStrobe_O[5])
	)
;
	my_buf strobe_outbuf_6 (
	.A(FrameStrobe_O_i[6]),
	.X(FrameStrobe_O[6])
	)
;
	my_buf strobe_outbuf_7 (
	.A(FrameStrobe_O_i[7]),
	.X(FrameStrobe_O[7])
	)
;
	my_buf strobe_outbuf_8 (
	.A(FrameStrobe_O_i[8]),
	.X(FrameStrobe_O[8])
	)
;
	my_buf strobe_outbuf_9 (
	.A(FrameStrobe_O_i[9]),
	.X(FrameStrobe_O[9])
	)
;
	my_buf strobe_outbuf_10 (
	.A(FrameStrobe_O_i[10]),
	.X(FrameStrobe_O[10])
	)
;
	my_buf strobe_outbuf_11 (
	.A(FrameStrobe_O_i[11]),
	.X(FrameStrobe_O[11])
	)
;
	my_buf strobe_outbuf_12 (
	.A(FrameStrobe_O_i[12]),
	.X(FrameStrobe_O[12])
	)
;
	my_buf strobe_outbuf_13 (
	.A(FrameStrobe_O_i[13]),
	.X(FrameStrobe_O[13])
	)
;
	my_buf strobe_outbuf_14 (
	.A(FrameStrobe_O_i[14]),
	.X(FrameStrobe_O[14])
	)
;
	my_buf strobe_outbuf_15 (
	.A(FrameStrobe_O_i[15]),
	.X(FrameStrobe_O[15])
	)
;
	my_buf strobe_outbuf_16 (
	.A(FrameStrobe_O_i[16]),
	.X(FrameStrobe_O[16])
	)
;
	my_buf strobe_outbuf_17 (
	.A(FrameStrobe_O_i[17]),
	.X(FrameStrobe_O[17])
	)
;
	my_buf strobe_outbuf_18 (
	.A(FrameStrobe_O_i[18]),
	.X(FrameStrobe_O[18])
	)
;
	my_buf strobe_outbuf_19 (
	.A(FrameStrobe_O_i[19]),
	.X(FrameStrobe_O[19])
	)
;

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
	.SS4END0(SS4END[0]),
	.SS4END1(SS4END[1]),
	.SS4END2(SS4END[2]),
	.SS4END3(SS4END[3]),
	.SS4END4(SS4END[4]),
	.SS4END5(SS4END[5]),
	.SS4END6(SS4END[6]),
	.SS4END7(SS4END[7]),
	.SS4END8(SS4END[8]),
	.SS4END9(SS4END[9]),
	.SS4END10(SS4END[10]),
	.SS4END11(SS4END[11]),
	.SS4END12(SS4END[12]),
	.SS4END13(SS4END[13]),
	.SS4END14(SS4END[14]),
	.SS4END15(SS4END[15]),
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
	.N4BEG15(N4BEG[15]),
	.NN4BEG0(NN4BEG[0]),
	.NN4BEG1(NN4BEG[1]),
	.NN4BEG2(NN4BEG[2]),
	.NN4BEG3(NN4BEG[3]),
	.NN4BEG4(NN4BEG[4]),
	.NN4BEG5(NN4BEG[5]),
	.NN4BEG6(NN4BEG[6]),
	.NN4BEG7(NN4BEG[7]),
	.NN4BEG8(NN4BEG[8]),
	.NN4BEG9(NN4BEG[9]),
	.NN4BEG10(NN4BEG[10]),
	.NN4BEG11(NN4BEG[11]),
	.NN4BEG12(NN4BEG[12]),
	.NN4BEG13(NN4BEG[13]),
	.NN4BEG14(NN4BEG[14]),
	.NN4BEG15(NN4BEG[15])
	);

endmodule
