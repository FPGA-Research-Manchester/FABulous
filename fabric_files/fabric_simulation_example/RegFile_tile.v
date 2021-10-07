module RegFile (N1BEG, N2BEG, N2BEGb, N4BEG, NN4BEG, N1END, N2MID, N2END, N4END, NN4END, E1BEG, E2BEG, E2BEGb, EE4BEG, E6BEG, E1END, E2MID, E2END, EE4END, E6END, S1BEG, S2BEG, S2BEGb, S4BEG, SS4BEG, S1END, S2MID, S2END, S4END, SS4END, W1BEG, W2BEG, W2BEGb, WW4BEG, W6BEG, W1END, W2MID, W2END, WW4END, W6END, UserCLK, FrameData, FrameData_O, FrameStrobe, FrameStrobe_O);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 414;
	//  NORTH
	output [3:0] N1BEG; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	output [7:0] N2BEG; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	output [7:0] N2BEGb; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	output [15:0] N4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	output [15:0] NN4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	input [3:0] N1END; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	input [7:0] N2MID; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	input [7:0] N2END; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	input [15:0] N4END; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	input [15:0] NN4END; //wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	//  EAST
	output [3:0] E1BEG; //wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	output [7:0] E2BEG; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	output [7:0] E2BEGb; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	output [15:0] EE4BEG; //wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	output [11:0] E6BEG; //wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	input [3:0] E1END; //wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	input [7:0] E2MID; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	input [7:0] E2END; //wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	input [15:0] EE4END; //wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	input [11:0] E6END; //wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	//  SOUTH
	output [3:0] S1BEG; //wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	output [7:0] S2BEG; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	output [7:0] S2BEGb; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	output [15:0] S4BEG; //wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	output [15:0] SS4BEG; //wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	input [3:0] S1END; //wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	input [7:0] S2MID; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	input [7:0] S2END; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	input [15:0] S4END; //wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	input [15:0] SS4END; //wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	//  WEST
	output [3:0] W1BEG; //wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	output [7:0] W2BEG; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	output [7:0] W2BEGb; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	output [15:0] WW4BEG; //wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	output [11:0] W6BEG; //wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	input [3:0] W1END; //wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	input [7:0] W2MID; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	input [7:0] W2END; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	input [15:0] WW4END; //wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	input [11:0] W6END; //wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	// Tile IO ports from BELs
	input UserCLK;
	input [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [FrameBitsPerRow-1:0] FrameData_O;
	input [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [MaxFramesPerCol-1:0] FrameStrobe_O;
	//global


//signal declarations
//BEL ports (e.g., slices)
	wire D0;
	wire D1;
	wire D2;
	wire D3;
	wire W_ADR0;
	wire W_ADR1;
	wire W_ADR2;
	wire W_ADR3;
	wire W_ADR4;
	wire W_en;
	wire A_ADR0;
	wire A_ADR1;
	wire A_ADR2;
	wire A_ADR3;
	wire A_ADR4;
	wire B_ADR0;
	wire B_ADR1;
	wire B_ADR2;
	wire B_ADR3;
	wire B_ADR4;
	wire AD0;
	wire AD1;
	wire AD2;
	wire AD3;
	wire BD0;
	wire BD1;
	wire BD2;
	wire BD3;
//jump wires
	wire [4-1:0] J2MID_ABa_BEG;
	wire [4-1:0] J2MID_CDa_BEG;
	wire [4-1:0] J2MID_EFa_BEG;
	wire [4-1:0] J2MID_GHa_BEG;
	wire [4-1:0] J2MID_ABb_BEG;
	wire [4-1:0] J2MID_CDb_BEG;
	wire [4-1:0] J2MID_EFb_BEG;
	wire [4-1:0] J2MID_GHb_BEG;
	wire [4-1:0] J2END_AB_BEG;
	wire [4-1:0] J2END_CD_BEG;
	wire [4-1:0] J2END_EF_BEG;
	wire [4-1:0] J2END_GH_BEG;
	wire [8-1:0] JN2BEG;
	wire [8-1:0] JE2BEG;
	wire [8-1:0] JS2BEG;
	wire [8-1:0] JW2BEG;
	wire [4-1:0] J_l_AB_BEG;
	wire [4-1:0] J_l_CD_BEG;
	wire [4-1:0] J_l_EF_BEG;
	wire [4-1:0] J_l_GH_BEG;
//internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
	wire [NoConfigBits-1:0] ConfigBits;
	wire [NoConfigBits-1:0] ConfigBits_N;

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
	wire [15:0] N4END_i;
	wire [11:0] N4BEG_i;
	assign N4BEG_i[15-4:0] = N4END_i[15:4];

	my_buf N4END_inbuf_0 (
	.A(N4END[4]),
	.X(N4END_i[4])
	);

	my_buf N4END_inbuf_1 (
	.A(N4END[5]),
	.X(N4END_i[5])
	);

	my_buf N4END_inbuf_2 (
	.A(N4END[6]),
	.X(N4END_i[6])
	);

	my_buf N4END_inbuf_3 (
	.A(N4END[7]),
	.X(N4END_i[7])
	);

	my_buf N4END_inbuf_4 (
	.A(N4END[8]),
	.X(N4END_i[8])
	);

	my_buf N4END_inbuf_5 (
	.A(N4END[9]),
	.X(N4END_i[9])
	);

	my_buf N4END_inbuf_6 (
	.A(N4END[10]),
	.X(N4END_i[10])
	);

	my_buf N4END_inbuf_7 (
	.A(N4END[11]),
	.X(N4END_i[11])
	);

	my_buf N4END_inbuf_8 (
	.A(N4END[12]),
	.X(N4END_i[12])
	);

	my_buf N4END_inbuf_9 (
	.A(N4END[13]),
	.X(N4END_i[13])
	);

	my_buf N4END_inbuf_10 (
	.A(N4END[14]),
	.X(N4END_i[14])
	);

	my_buf N4END_inbuf_11 (
	.A(N4END[15]),
	.X(N4END_i[15])
	);

	my_buf N4BEG_outbuf_0 (
	.A(N4BEG_i[0]),
	.X(N4BEG[0])
	);

	my_buf N4BEG_outbuf_1 (
	.A(N4BEG_i[1]),
	.X(N4BEG[1])
	);

	my_buf N4BEG_outbuf_2 (
	.A(N4BEG_i[2]),
	.X(N4BEG[2])
	);

	my_buf N4BEG_outbuf_3 (
	.A(N4BEG_i[3]),
	.X(N4BEG[3])
	);

	my_buf N4BEG_outbuf_4 (
	.A(N4BEG_i[4]),
	.X(N4BEG[4])
	);

	my_buf N4BEG_outbuf_5 (
	.A(N4BEG_i[5]),
	.X(N4BEG[5])
	);

	my_buf N4BEG_outbuf_6 (
	.A(N4BEG_i[6]),
	.X(N4BEG[6])
	);

	my_buf N4BEG_outbuf_7 (
	.A(N4BEG_i[7]),
	.X(N4BEG[7])
	);

	my_buf N4BEG_outbuf_8 (
	.A(N4BEG_i[8]),
	.X(N4BEG[8])
	);

	my_buf N4BEG_outbuf_9 (
	.A(N4BEG_i[9]),
	.X(N4BEG[9])
	);

	my_buf N4BEG_outbuf_10 (
	.A(N4BEG_i[10]),
	.X(N4BEG[10])
	);

	my_buf N4BEG_outbuf_11 (
	.A(N4BEG_i[11]),
	.X(N4BEG[11])
	);

	wire [15:0] NN4END_i;
	wire [11:0] NN4BEG_i;
	assign NN4BEG_i[15-4:0] = NN4END_i[15:4];

	my_buf NN4END_inbuf_0 (
	.A(NN4END[4]),
	.X(NN4END_i[4])
	);

	my_buf NN4END_inbuf_1 (
	.A(NN4END[5]),
	.X(NN4END_i[5])
	);

	my_buf NN4END_inbuf_2 (
	.A(NN4END[6]),
	.X(NN4END_i[6])
	);

	my_buf NN4END_inbuf_3 (
	.A(NN4END[7]),
	.X(NN4END_i[7])
	);

	my_buf NN4END_inbuf_4 (
	.A(NN4END[8]),
	.X(NN4END_i[8])
	);

	my_buf NN4END_inbuf_5 (
	.A(NN4END[9]),
	.X(NN4END_i[9])
	);

	my_buf NN4END_inbuf_6 (
	.A(NN4END[10]),
	.X(NN4END_i[10])
	);

	my_buf NN4END_inbuf_7 (
	.A(NN4END[11]),
	.X(NN4END_i[11])
	);

	my_buf NN4END_inbuf_8 (
	.A(NN4END[12]),
	.X(NN4END_i[12])
	);

	my_buf NN4END_inbuf_9 (
	.A(NN4END[13]),
	.X(NN4END_i[13])
	);

	my_buf NN4END_inbuf_10 (
	.A(NN4END[14]),
	.X(NN4END_i[14])
	);

	my_buf NN4END_inbuf_11 (
	.A(NN4END[15]),
	.X(NN4END_i[15])
	);

	my_buf NN4BEG_outbuf_0 (
	.A(NN4BEG_i[0]),
	.X(NN4BEG[0])
	);

	my_buf NN4BEG_outbuf_1 (
	.A(NN4BEG_i[1]),
	.X(NN4BEG[1])
	);

	my_buf NN4BEG_outbuf_2 (
	.A(NN4BEG_i[2]),
	.X(NN4BEG[2])
	);

	my_buf NN4BEG_outbuf_3 (
	.A(NN4BEG_i[3]),
	.X(NN4BEG[3])
	);

	my_buf NN4BEG_outbuf_4 (
	.A(NN4BEG_i[4]),
	.X(NN4BEG[4])
	);

	my_buf NN4BEG_outbuf_5 (
	.A(NN4BEG_i[5]),
	.X(NN4BEG[5])
	);

	my_buf NN4BEG_outbuf_6 (
	.A(NN4BEG_i[6]),
	.X(NN4BEG[6])
	);

	my_buf NN4BEG_outbuf_7 (
	.A(NN4BEG_i[7]),
	.X(NN4BEG[7])
	);

	my_buf NN4BEG_outbuf_8 (
	.A(NN4BEG_i[8]),
	.X(NN4BEG[8])
	);

	my_buf NN4BEG_outbuf_9 (
	.A(NN4BEG_i[9]),
	.X(NN4BEG[9])
	);

	my_buf NN4BEG_outbuf_10 (
	.A(NN4BEG_i[10]),
	.X(NN4BEG[10])
	);

	my_buf NN4BEG_outbuf_11 (
	.A(NN4BEG_i[11]),
	.X(NN4BEG[11])
	);

	wire [15:0] EE4END_i;
	wire [11:0] EE4BEG_i;
	assign EE4BEG_i[15-4:0] = EE4END_i[15:4];

	my_buf EE4END_inbuf_0 (
	.A(EE4END[4]),
	.X(EE4END_i[4])
	);

	my_buf EE4END_inbuf_1 (
	.A(EE4END[5]),
	.X(EE4END_i[5])
	);

	my_buf EE4END_inbuf_2 (
	.A(EE4END[6]),
	.X(EE4END_i[6])
	);

	my_buf EE4END_inbuf_3 (
	.A(EE4END[7]),
	.X(EE4END_i[7])
	);

	my_buf EE4END_inbuf_4 (
	.A(EE4END[8]),
	.X(EE4END_i[8])
	);

	my_buf EE4END_inbuf_5 (
	.A(EE4END[9]),
	.X(EE4END_i[9])
	);

	my_buf EE4END_inbuf_6 (
	.A(EE4END[10]),
	.X(EE4END_i[10])
	);

	my_buf EE4END_inbuf_7 (
	.A(EE4END[11]),
	.X(EE4END_i[11])
	);

	my_buf EE4END_inbuf_8 (
	.A(EE4END[12]),
	.X(EE4END_i[12])
	);

	my_buf EE4END_inbuf_9 (
	.A(EE4END[13]),
	.X(EE4END_i[13])
	);

	my_buf EE4END_inbuf_10 (
	.A(EE4END[14]),
	.X(EE4END_i[14])
	);

	my_buf EE4END_inbuf_11 (
	.A(EE4END[15]),
	.X(EE4END_i[15])
	);

	my_buf EE4BEG_outbuf_0 (
	.A(EE4BEG_i[0]),
	.X(EE4BEG[0])
	);

	my_buf EE4BEG_outbuf_1 (
	.A(EE4BEG_i[1]),
	.X(EE4BEG[1])
	);

	my_buf EE4BEG_outbuf_2 (
	.A(EE4BEG_i[2]),
	.X(EE4BEG[2])
	);

	my_buf EE4BEG_outbuf_3 (
	.A(EE4BEG_i[3]),
	.X(EE4BEG[3])
	);

	my_buf EE4BEG_outbuf_4 (
	.A(EE4BEG_i[4]),
	.X(EE4BEG[4])
	);

	my_buf EE4BEG_outbuf_5 (
	.A(EE4BEG_i[5]),
	.X(EE4BEG[5])
	);

	my_buf EE4BEG_outbuf_6 (
	.A(EE4BEG_i[6]),
	.X(EE4BEG[6])
	);

	my_buf EE4BEG_outbuf_7 (
	.A(EE4BEG_i[7]),
	.X(EE4BEG[7])
	);

	my_buf EE4BEG_outbuf_8 (
	.A(EE4BEG_i[8]),
	.X(EE4BEG[8])
	);

	my_buf EE4BEG_outbuf_9 (
	.A(EE4BEG_i[9]),
	.X(EE4BEG[9])
	);

	my_buf EE4BEG_outbuf_10 (
	.A(EE4BEG_i[10]),
	.X(EE4BEG[10])
	);

	my_buf EE4BEG_outbuf_11 (
	.A(EE4BEG_i[11]),
	.X(EE4BEG[11])
	);

	wire [11:0] E6END_i;
	wire [9:0] E6BEG_i;
	assign E6BEG_i[11-2:0] = E6END_i[11:2];

	my_buf E6END_inbuf_0 (
	.A(E6END[2]),
	.X(E6END_i[2])
	);

	my_buf E6END_inbuf_1 (
	.A(E6END[3]),
	.X(E6END_i[3])
	);

	my_buf E6END_inbuf_2 (
	.A(E6END[4]),
	.X(E6END_i[4])
	);

	my_buf E6END_inbuf_3 (
	.A(E6END[5]),
	.X(E6END_i[5])
	);

	my_buf E6END_inbuf_4 (
	.A(E6END[6]),
	.X(E6END_i[6])
	);

	my_buf E6END_inbuf_5 (
	.A(E6END[7]),
	.X(E6END_i[7])
	);

	my_buf E6END_inbuf_6 (
	.A(E6END[8]),
	.X(E6END_i[8])
	);

	my_buf E6END_inbuf_7 (
	.A(E6END[9]),
	.X(E6END_i[9])
	);

	my_buf E6END_inbuf_8 (
	.A(E6END[10]),
	.X(E6END_i[10])
	);

	my_buf E6END_inbuf_9 (
	.A(E6END[11]),
	.X(E6END_i[11])
	);

	my_buf E6BEG_outbuf_0 (
	.A(E6BEG_i[0]),
	.X(E6BEG[0])
	);

	my_buf E6BEG_outbuf_1 (
	.A(E6BEG_i[1]),
	.X(E6BEG[1])
	);

	my_buf E6BEG_outbuf_2 (
	.A(E6BEG_i[2]),
	.X(E6BEG[2])
	);

	my_buf E6BEG_outbuf_3 (
	.A(E6BEG_i[3]),
	.X(E6BEG[3])
	);

	my_buf E6BEG_outbuf_4 (
	.A(E6BEG_i[4]),
	.X(E6BEG[4])
	);

	my_buf E6BEG_outbuf_5 (
	.A(E6BEG_i[5]),
	.X(E6BEG[5])
	);

	my_buf E6BEG_outbuf_6 (
	.A(E6BEG_i[6]),
	.X(E6BEG[6])
	);

	my_buf E6BEG_outbuf_7 (
	.A(E6BEG_i[7]),
	.X(E6BEG[7])
	);

	my_buf E6BEG_outbuf_8 (
	.A(E6BEG_i[8]),
	.X(E6BEG[8])
	);

	my_buf E6BEG_outbuf_9 (
	.A(E6BEG_i[9]),
	.X(E6BEG[9])
	);

	wire [15:0] S4END_i;
	wire [11:0] S4BEG_i;
	assign S4BEG_i[15-4:0] = S4END_i[15:4];

	my_buf S4END_inbuf_0 (
	.A(S4END[4]),
	.X(S4END_i[4])
	);

	my_buf S4END_inbuf_1 (
	.A(S4END[5]),
	.X(S4END_i[5])
	);

	my_buf S4END_inbuf_2 (
	.A(S4END[6]),
	.X(S4END_i[6])
	);

	my_buf S4END_inbuf_3 (
	.A(S4END[7]),
	.X(S4END_i[7])
	);

	my_buf S4END_inbuf_4 (
	.A(S4END[8]),
	.X(S4END_i[8])
	);

	my_buf S4END_inbuf_5 (
	.A(S4END[9]),
	.X(S4END_i[9])
	);

	my_buf S4END_inbuf_6 (
	.A(S4END[10]),
	.X(S4END_i[10])
	);

	my_buf S4END_inbuf_7 (
	.A(S4END[11]),
	.X(S4END_i[11])
	);

	my_buf S4END_inbuf_8 (
	.A(S4END[12]),
	.X(S4END_i[12])
	);

	my_buf S4END_inbuf_9 (
	.A(S4END[13]),
	.X(S4END_i[13])
	);

	my_buf S4END_inbuf_10 (
	.A(S4END[14]),
	.X(S4END_i[14])
	);

	my_buf S4END_inbuf_11 (
	.A(S4END[15]),
	.X(S4END_i[15])
	);

	my_buf S4BEG_outbuf_0 (
	.A(S4BEG_i[0]),
	.X(S4BEG[0])
	);

	my_buf S4BEG_outbuf_1 (
	.A(S4BEG_i[1]),
	.X(S4BEG[1])
	);

	my_buf S4BEG_outbuf_2 (
	.A(S4BEG_i[2]),
	.X(S4BEG[2])
	);

	my_buf S4BEG_outbuf_3 (
	.A(S4BEG_i[3]),
	.X(S4BEG[3])
	);

	my_buf S4BEG_outbuf_4 (
	.A(S4BEG_i[4]),
	.X(S4BEG[4])
	);

	my_buf S4BEG_outbuf_5 (
	.A(S4BEG_i[5]),
	.X(S4BEG[5])
	);

	my_buf S4BEG_outbuf_6 (
	.A(S4BEG_i[6]),
	.X(S4BEG[6])
	);

	my_buf S4BEG_outbuf_7 (
	.A(S4BEG_i[7]),
	.X(S4BEG[7])
	);

	my_buf S4BEG_outbuf_8 (
	.A(S4BEG_i[8]),
	.X(S4BEG[8])
	);

	my_buf S4BEG_outbuf_9 (
	.A(S4BEG_i[9]),
	.X(S4BEG[9])
	);

	my_buf S4BEG_outbuf_10 (
	.A(S4BEG_i[10]),
	.X(S4BEG[10])
	);

	my_buf S4BEG_outbuf_11 (
	.A(S4BEG_i[11]),
	.X(S4BEG[11])
	);

	wire [15:0] SS4END_i;
	wire [11:0] SS4BEG_i;
	assign SS4BEG_i[15-4:0] = SS4END_i[15:4];

	my_buf SS4END_inbuf_0 (
	.A(SS4END[4]),
	.X(SS4END_i[4])
	);

	my_buf SS4END_inbuf_1 (
	.A(SS4END[5]),
	.X(SS4END_i[5])
	);

	my_buf SS4END_inbuf_2 (
	.A(SS4END[6]),
	.X(SS4END_i[6])
	);

	my_buf SS4END_inbuf_3 (
	.A(SS4END[7]),
	.X(SS4END_i[7])
	);

	my_buf SS4END_inbuf_4 (
	.A(SS4END[8]),
	.X(SS4END_i[8])
	);

	my_buf SS4END_inbuf_5 (
	.A(SS4END[9]),
	.X(SS4END_i[9])
	);

	my_buf SS4END_inbuf_6 (
	.A(SS4END[10]),
	.X(SS4END_i[10])
	);

	my_buf SS4END_inbuf_7 (
	.A(SS4END[11]),
	.X(SS4END_i[11])
	);

	my_buf SS4END_inbuf_8 (
	.A(SS4END[12]),
	.X(SS4END_i[12])
	);

	my_buf SS4END_inbuf_9 (
	.A(SS4END[13]),
	.X(SS4END_i[13])
	);

	my_buf SS4END_inbuf_10 (
	.A(SS4END[14]),
	.X(SS4END_i[14])
	);

	my_buf SS4END_inbuf_11 (
	.A(SS4END[15]),
	.X(SS4END_i[15])
	);

	my_buf SS4BEG_outbuf_0 (
	.A(SS4BEG_i[0]),
	.X(SS4BEG[0])
	);

	my_buf SS4BEG_outbuf_1 (
	.A(SS4BEG_i[1]),
	.X(SS4BEG[1])
	);

	my_buf SS4BEG_outbuf_2 (
	.A(SS4BEG_i[2]),
	.X(SS4BEG[2])
	);

	my_buf SS4BEG_outbuf_3 (
	.A(SS4BEG_i[3]),
	.X(SS4BEG[3])
	);

	my_buf SS4BEG_outbuf_4 (
	.A(SS4BEG_i[4]),
	.X(SS4BEG[4])
	);

	my_buf SS4BEG_outbuf_5 (
	.A(SS4BEG_i[5]),
	.X(SS4BEG[5])
	);

	my_buf SS4BEG_outbuf_6 (
	.A(SS4BEG_i[6]),
	.X(SS4BEG[6])
	);

	my_buf SS4BEG_outbuf_7 (
	.A(SS4BEG_i[7]),
	.X(SS4BEG[7])
	);

	my_buf SS4BEG_outbuf_8 (
	.A(SS4BEG_i[8]),
	.X(SS4BEG[8])
	);

	my_buf SS4BEG_outbuf_9 (
	.A(SS4BEG_i[9]),
	.X(SS4BEG[9])
	);

	my_buf SS4BEG_outbuf_10 (
	.A(SS4BEG_i[10]),
	.X(SS4BEG[10])
	);

	my_buf SS4BEG_outbuf_11 (
	.A(SS4BEG_i[11]),
	.X(SS4BEG[11])
	);

	wire [15:0] WW4END_i;
	wire [11:0] WW4BEG_i;
	assign WW4BEG_i[15-4:0] = WW4END_i[15:4];

	my_buf WW4END_inbuf_0 (
	.A(WW4END[4]),
	.X(WW4END_i[4])
	);

	my_buf WW4END_inbuf_1 (
	.A(WW4END[5]),
	.X(WW4END_i[5])
	);

	my_buf WW4END_inbuf_2 (
	.A(WW4END[6]),
	.X(WW4END_i[6])
	);

	my_buf WW4END_inbuf_3 (
	.A(WW4END[7]),
	.X(WW4END_i[7])
	);

	my_buf WW4END_inbuf_4 (
	.A(WW4END[8]),
	.X(WW4END_i[8])
	);

	my_buf WW4END_inbuf_5 (
	.A(WW4END[9]),
	.X(WW4END_i[9])
	);

	my_buf WW4END_inbuf_6 (
	.A(WW4END[10]),
	.X(WW4END_i[10])
	);

	my_buf WW4END_inbuf_7 (
	.A(WW4END[11]),
	.X(WW4END_i[11])
	);

	my_buf WW4END_inbuf_8 (
	.A(WW4END[12]),
	.X(WW4END_i[12])
	);

	my_buf WW4END_inbuf_9 (
	.A(WW4END[13]),
	.X(WW4END_i[13])
	);

	my_buf WW4END_inbuf_10 (
	.A(WW4END[14]),
	.X(WW4END_i[14])
	);

	my_buf WW4END_inbuf_11 (
	.A(WW4END[15]),
	.X(WW4END_i[15])
	);

	my_buf WW4BEG_outbuf_0 (
	.A(WW4BEG_i[0]),
	.X(WW4BEG[0])
	);

	my_buf WW4BEG_outbuf_1 (
	.A(WW4BEG_i[1]),
	.X(WW4BEG[1])
	);

	my_buf WW4BEG_outbuf_2 (
	.A(WW4BEG_i[2]),
	.X(WW4BEG[2])
	);

	my_buf WW4BEG_outbuf_3 (
	.A(WW4BEG_i[3]),
	.X(WW4BEG[3])
	);

	my_buf WW4BEG_outbuf_4 (
	.A(WW4BEG_i[4]),
	.X(WW4BEG[4])
	);

	my_buf WW4BEG_outbuf_5 (
	.A(WW4BEG_i[5]),
	.X(WW4BEG[5])
	);

	my_buf WW4BEG_outbuf_6 (
	.A(WW4BEG_i[6]),
	.X(WW4BEG[6])
	);

	my_buf WW4BEG_outbuf_7 (
	.A(WW4BEG_i[7]),
	.X(WW4BEG[7])
	);

	my_buf WW4BEG_outbuf_8 (
	.A(WW4BEG_i[8]),
	.X(WW4BEG[8])
	);

	my_buf WW4BEG_outbuf_9 (
	.A(WW4BEG_i[9]),
	.X(WW4BEG[9])
	);

	my_buf WW4BEG_outbuf_10 (
	.A(WW4BEG_i[10]),
	.X(WW4BEG[10])
	);

	my_buf WW4BEG_outbuf_11 (
	.A(WW4BEG_i[11]),
	.X(WW4BEG[11])
	);

	wire [11:0] W6END_i;
	wire [9:0] W6BEG_i;
	assign W6BEG_i[11-2:0] = W6END_i[11:2];

	my_buf W6END_inbuf_0 (
	.A(W6END[2]),
	.X(W6END_i[2])
	);

	my_buf W6END_inbuf_1 (
	.A(W6END[3]),
	.X(W6END_i[3])
	);

	my_buf W6END_inbuf_2 (
	.A(W6END[4]),
	.X(W6END_i[4])
	);

	my_buf W6END_inbuf_3 (
	.A(W6END[5]),
	.X(W6END_i[5])
	);

	my_buf W6END_inbuf_4 (
	.A(W6END[6]),
	.X(W6END_i[6])
	);

	my_buf W6END_inbuf_5 (
	.A(W6END[7]),
	.X(W6END_i[7])
	);

	my_buf W6END_inbuf_6 (
	.A(W6END[8]),
	.X(W6END_i[8])
	);

	my_buf W6END_inbuf_7 (
	.A(W6END[9]),
	.X(W6END_i[9])
	);

	my_buf W6END_inbuf_8 (
	.A(W6END[10]),
	.X(W6END_i[10])
	);

	my_buf W6END_inbuf_9 (
	.A(W6END[11]),
	.X(W6END_i[11])
	);

	my_buf W6BEG_outbuf_0 (
	.A(W6BEG_i[0]),
	.X(W6BEG[0])
	);

	my_buf W6BEG_outbuf_1 (
	.A(W6BEG_i[1]),
	.X(W6BEG[1])
	);

	my_buf W6BEG_outbuf_2 (
	.A(W6BEG_i[2]),
	.X(W6BEG[2])
	);

	my_buf W6BEG_outbuf_3 (
	.A(W6BEG_i[3]),
	.X(W6BEG[3])
	);

	my_buf W6BEG_outbuf_4 (
	.A(W6BEG_i[4]),
	.X(W6BEG[4])
	);

	my_buf W6BEG_outbuf_5 (
	.A(W6BEG_i[5]),
	.X(W6BEG[5])
	);

	my_buf W6BEG_outbuf_6 (
	.A(W6BEG_i[6]),
	.X(W6BEG[6])
	);

	my_buf W6BEG_outbuf_7 (
	.A(W6BEG_i[7]),
	.X(W6BEG[7])
	);

	my_buf W6BEG_outbuf_8 (
	.A(W6BEG_i[8]),
	.X(W6BEG[8])
	);

	my_buf W6BEG_outbuf_9 (
	.A(W6BEG_i[9]),
	.X(W6BEG[9])
	);


// configuration storage latches
	RegFile_ConfigMem Inst_RegFile_ConfigMem (
	.FrameData(FrameData),
	.FrameStrobe(FrameStrobe),
	.ConfigBits(ConfigBits),
	.ConfigBits_N(ConfigBits_N)
	);

//BEL component instantiations
	RegFile_32x4 Inst_RegFile_32x4 (
	.D0(D0),
	.D1(D1),
	.D2(D2),
	.D3(D3),
	.W_ADR0(W_ADR0),
	.W_ADR1(W_ADR1),
	.W_ADR2(W_ADR2),
	.W_ADR3(W_ADR3),
	.W_ADR4(W_ADR4),
	.W_en(W_en),
	.A_ADR0(A_ADR0),
	.A_ADR1(A_ADR1),
	.A_ADR2(A_ADR2),
	.A_ADR3(A_ADR3),
	.A_ADR4(A_ADR4),
	.B_ADR0(B_ADR0),
	.B_ADR1(B_ADR1),
	.B_ADR2(B_ADR2),
	.B_ADR3(B_ADR3),
	.B_ADR4(B_ADR4),
	.AD0(AD0),
	.AD1(AD1),
	.AD2(AD2),
	.AD3(AD3),
	.BD0(BD0),
	.BD1(BD1),
	.BD2(BD2),
	.BD3(BD3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[2-1:0])
	);


//switch matrix component instantiation
	RegFile_switch_matrix Inst_RegFile_switch_matrix (
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
	.NN4END0(NN4END[0]),
	.NN4END1(NN4END[1]),
	.NN4END2(NN4END[2]),
	.NN4END3(NN4END[3]),
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
	.EE4END0(EE4END[0]),
	.EE4END1(EE4END[1]),
	.EE4END2(EE4END[2]),
	.EE4END3(EE4END[3]),
	.E6END0(E6END[0]),
	.E6END1(E6END[1]),
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
	.SS4END0(SS4END[0]),
	.SS4END1(SS4END[1]),
	.SS4END2(SS4END[2]),
	.SS4END3(SS4END[3]),
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
	.WW4END0(WW4END[0]),
	.WW4END1(WW4END[1]),
	.WW4END2(WW4END[2]),
	.WW4END3(WW4END[3]),
	.W6END0(W6END[0]),
	.W6END1(W6END[1]),
	.AD0(AD0),
	.AD1(AD1),
	.AD2(AD2),
	.AD3(AD3),
	.BD0(BD0),
	.BD1(BD1),
	.BD2(BD2),
	.BD3(BD3),
	.J2MID_ABa_END0(J2MID_ABa_BEG[0]),
	.J2MID_ABa_END1(J2MID_ABa_BEG[1]),
	.J2MID_ABa_END2(J2MID_ABa_BEG[2]),
	.J2MID_ABa_END3(J2MID_ABa_BEG[3]),
	.J2MID_CDa_END0(J2MID_CDa_BEG[0]),
	.J2MID_CDa_END1(J2MID_CDa_BEG[1]),
	.J2MID_CDa_END2(J2MID_CDa_BEG[2]),
	.J2MID_CDa_END3(J2MID_CDa_BEG[3]),
	.J2MID_EFa_END0(J2MID_EFa_BEG[0]),
	.J2MID_EFa_END1(J2MID_EFa_BEG[1]),
	.J2MID_EFa_END2(J2MID_EFa_BEG[2]),
	.J2MID_EFa_END3(J2MID_EFa_BEG[3]),
	.J2MID_GHa_END0(J2MID_GHa_BEG[0]),
	.J2MID_GHa_END1(J2MID_GHa_BEG[1]),
	.J2MID_GHa_END2(J2MID_GHa_BEG[2]),
	.J2MID_GHa_END3(J2MID_GHa_BEG[3]),
	.J2MID_ABb_END0(J2MID_ABb_BEG[0]),
	.J2MID_ABb_END1(J2MID_ABb_BEG[1]),
	.J2MID_ABb_END2(J2MID_ABb_BEG[2]),
	.J2MID_ABb_END3(J2MID_ABb_BEG[3]),
	.J2MID_CDb_END0(J2MID_CDb_BEG[0]),
	.J2MID_CDb_END1(J2MID_CDb_BEG[1]),
	.J2MID_CDb_END2(J2MID_CDb_BEG[2]),
	.J2MID_CDb_END3(J2MID_CDb_BEG[3]),
	.J2MID_EFb_END0(J2MID_EFb_BEG[0]),
	.J2MID_EFb_END1(J2MID_EFb_BEG[1]),
	.J2MID_EFb_END2(J2MID_EFb_BEG[2]),
	.J2MID_EFb_END3(J2MID_EFb_BEG[3]),
	.J2MID_GHb_END0(J2MID_GHb_BEG[0]),
	.J2MID_GHb_END1(J2MID_GHb_BEG[1]),
	.J2MID_GHb_END2(J2MID_GHb_BEG[2]),
	.J2MID_GHb_END3(J2MID_GHb_BEG[3]),
	.J2END_AB_END0(J2END_AB_BEG[0]),
	.J2END_AB_END1(J2END_AB_BEG[1]),
	.J2END_AB_END2(J2END_AB_BEG[2]),
	.J2END_AB_END3(J2END_AB_BEG[3]),
	.J2END_CD_END0(J2END_CD_BEG[0]),
	.J2END_CD_END1(J2END_CD_BEG[1]),
	.J2END_CD_END2(J2END_CD_BEG[2]),
	.J2END_CD_END3(J2END_CD_BEG[3]),
	.J2END_EF_END0(J2END_EF_BEG[0]),
	.J2END_EF_END1(J2END_EF_BEG[1]),
	.J2END_EF_END2(J2END_EF_BEG[2]),
	.J2END_EF_END3(J2END_EF_BEG[3]),
	.J2END_GH_END0(J2END_GH_BEG[0]),
	.J2END_GH_END1(J2END_GH_BEG[1]),
	.J2END_GH_END2(J2END_GH_BEG[2]),
	.J2END_GH_END3(J2END_GH_BEG[3]),
	.JN2END0(JN2BEG[0]),
	.JN2END1(JN2BEG[1]),
	.JN2END2(JN2BEG[2]),
	.JN2END3(JN2BEG[3]),
	.JN2END4(JN2BEG[4]),
	.JN2END5(JN2BEG[5]),
	.JN2END6(JN2BEG[6]),
	.JN2END7(JN2BEG[7]),
	.JE2END0(JE2BEG[0]),
	.JE2END1(JE2BEG[1]),
	.JE2END2(JE2BEG[2]),
	.JE2END3(JE2BEG[3]),
	.JE2END4(JE2BEG[4]),
	.JE2END5(JE2BEG[5]),
	.JE2END6(JE2BEG[6]),
	.JE2END7(JE2BEG[7]),
	.JS2END0(JS2BEG[0]),
	.JS2END1(JS2BEG[1]),
	.JS2END2(JS2BEG[2]),
	.JS2END3(JS2BEG[3]),
	.JS2END4(JS2BEG[4]),
	.JS2END5(JS2BEG[5]),
	.JS2END6(JS2BEG[6]),
	.JS2END7(JS2BEG[7]),
	.JW2END0(JW2BEG[0]),
	.JW2END1(JW2BEG[1]),
	.JW2END2(JW2BEG[2]),
	.JW2END3(JW2BEG[3]),
	.JW2END4(JW2BEG[4]),
	.JW2END5(JW2BEG[5]),
	.JW2END6(JW2BEG[6]),
	.JW2END7(JW2BEG[7]),
	.J_l_AB_END0(J_l_AB_BEG[0]),
	.J_l_AB_END1(J_l_AB_BEG[1]),
	.J_l_AB_END2(J_l_AB_BEG[2]),
	.J_l_AB_END3(J_l_AB_BEG[3]),
	.J_l_CD_END0(J_l_CD_BEG[0]),
	.J_l_CD_END1(J_l_CD_BEG[1]),
	.J_l_CD_END2(J_l_CD_BEG[2]),
	.J_l_CD_END3(J_l_CD_BEG[3]),
	.J_l_EF_END0(J_l_EF_BEG[0]),
	.J_l_EF_END1(J_l_EF_BEG[1]),
	.J_l_EF_END2(J_l_EF_BEG[2]),
	.J_l_EF_END3(J_l_EF_BEG[3]),
	.J_l_GH_END0(J_l_GH_BEG[0]),
	.J_l_GH_END1(J_l_GH_BEG[1]),
	.J_l_GH_END2(J_l_GH_BEG[2]),
	.J_l_GH_END3(J_l_GH_BEG[3]),
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
	.N4BEG0(N4BEG[12]),
	.N4BEG1(N4BEG[13]),
	.N4BEG2(N4BEG[14]),
	.N4BEG3(N4BEG[15]),
	.NN4BEG0(NN4BEG[12]),
	.NN4BEG1(NN4BEG[13]),
	.NN4BEG2(NN4BEG[14]),
	.NN4BEG3(NN4BEG[15]),
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
	.EE4BEG0(EE4BEG[12]),
	.EE4BEG1(EE4BEG[13]),
	.EE4BEG2(EE4BEG[14]),
	.EE4BEG3(EE4BEG[15]),
	.E6BEG0(E6BEG[10]),
	.E6BEG1(E6BEG[11]),
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
	.S4BEG0(S4BEG[12]),
	.S4BEG1(S4BEG[13]),
	.S4BEG2(S4BEG[14]),
	.S4BEG3(S4BEG[15]),
	.SS4BEG0(SS4BEG[12]),
	.SS4BEG1(SS4BEG[13]),
	.SS4BEG2(SS4BEG[14]),
	.SS4BEG3(SS4BEG[15]),
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
	.WW4BEG0(WW4BEG[12]),
	.WW4BEG1(WW4BEG[13]),
	.WW4BEG2(WW4BEG[14]),
	.WW4BEG3(WW4BEG[15]),
	.W6BEG0(W6BEG[10]),
	.W6BEG1(W6BEG[11]),
	.D0(D0),
	.D1(D1),
	.D2(D2),
	.D3(D3),
	.W_ADR0(W_ADR0),
	.W_ADR1(W_ADR1),
	.W_ADR2(W_ADR2),
	.W_ADR3(W_ADR3),
	.W_ADR4(W_ADR4),
	.W_en(W_en),
	.A_ADR0(A_ADR0),
	.A_ADR1(A_ADR1),
	.A_ADR2(A_ADR2),
	.A_ADR3(A_ADR3),
	.A_ADR4(A_ADR4),
	.B_ADR0(B_ADR0),
	.B_ADR1(B_ADR1),
	.B_ADR2(B_ADR2),
	.B_ADR3(B_ADR3),
	.B_ADR4(B_ADR4),
	.J2MID_ABa_BEG0(J2MID_ABa_BEG[0]),
	.J2MID_ABa_BEG1(J2MID_ABa_BEG[1]),
	.J2MID_ABa_BEG2(J2MID_ABa_BEG[2]),
	.J2MID_ABa_BEG3(J2MID_ABa_BEG[3]),
	.J2MID_CDa_BEG0(J2MID_CDa_BEG[0]),
	.J2MID_CDa_BEG1(J2MID_CDa_BEG[1]),
	.J2MID_CDa_BEG2(J2MID_CDa_BEG[2]),
	.J2MID_CDa_BEG3(J2MID_CDa_BEG[3]),
	.J2MID_EFa_BEG0(J2MID_EFa_BEG[0]),
	.J2MID_EFa_BEG1(J2MID_EFa_BEG[1]),
	.J2MID_EFa_BEG2(J2MID_EFa_BEG[2]),
	.J2MID_EFa_BEG3(J2MID_EFa_BEG[3]),
	.J2MID_GHa_BEG0(J2MID_GHa_BEG[0]),
	.J2MID_GHa_BEG1(J2MID_GHa_BEG[1]),
	.J2MID_GHa_BEG2(J2MID_GHa_BEG[2]),
	.J2MID_GHa_BEG3(J2MID_GHa_BEG[3]),
	.J2MID_ABb_BEG0(J2MID_ABb_BEG[0]),
	.J2MID_ABb_BEG1(J2MID_ABb_BEG[1]),
	.J2MID_ABb_BEG2(J2MID_ABb_BEG[2]),
	.J2MID_ABb_BEG3(J2MID_ABb_BEG[3]),
	.J2MID_CDb_BEG0(J2MID_CDb_BEG[0]),
	.J2MID_CDb_BEG1(J2MID_CDb_BEG[1]),
	.J2MID_CDb_BEG2(J2MID_CDb_BEG[2]),
	.J2MID_CDb_BEG3(J2MID_CDb_BEG[3]),
	.J2MID_EFb_BEG0(J2MID_EFb_BEG[0]),
	.J2MID_EFb_BEG1(J2MID_EFb_BEG[1]),
	.J2MID_EFb_BEG2(J2MID_EFb_BEG[2]),
	.J2MID_EFb_BEG3(J2MID_EFb_BEG[3]),
	.J2MID_GHb_BEG0(J2MID_GHb_BEG[0]),
	.J2MID_GHb_BEG1(J2MID_GHb_BEG[1]),
	.J2MID_GHb_BEG2(J2MID_GHb_BEG[2]),
	.J2MID_GHb_BEG3(J2MID_GHb_BEG[3]),
	.J2END_AB_BEG0(J2END_AB_BEG[0]),
	.J2END_AB_BEG1(J2END_AB_BEG[1]),
	.J2END_AB_BEG2(J2END_AB_BEG[2]),
	.J2END_AB_BEG3(J2END_AB_BEG[3]),
	.J2END_CD_BEG0(J2END_CD_BEG[0]),
	.J2END_CD_BEG1(J2END_CD_BEG[1]),
	.J2END_CD_BEG2(J2END_CD_BEG[2]),
	.J2END_CD_BEG3(J2END_CD_BEG[3]),
	.J2END_EF_BEG0(J2END_EF_BEG[0]),
	.J2END_EF_BEG1(J2END_EF_BEG[1]),
	.J2END_EF_BEG2(J2END_EF_BEG[2]),
	.J2END_EF_BEG3(J2END_EF_BEG[3]),
	.J2END_GH_BEG0(J2END_GH_BEG[0]),
	.J2END_GH_BEG1(J2END_GH_BEG[1]),
	.J2END_GH_BEG2(J2END_GH_BEG[2]),
	.J2END_GH_BEG3(J2END_GH_BEG[3]),
	.JN2BEG0(JN2BEG[0]),
	.JN2BEG1(JN2BEG[1]),
	.JN2BEG2(JN2BEG[2]),
	.JN2BEG3(JN2BEG[3]),
	.JN2BEG4(JN2BEG[4]),
	.JN2BEG5(JN2BEG[5]),
	.JN2BEG6(JN2BEG[6]),
	.JN2BEG7(JN2BEG[7]),
	.JE2BEG0(JE2BEG[0]),
	.JE2BEG1(JE2BEG[1]),
	.JE2BEG2(JE2BEG[2]),
	.JE2BEG3(JE2BEG[3]),
	.JE2BEG4(JE2BEG[4]),
	.JE2BEG5(JE2BEG[5]),
	.JE2BEG6(JE2BEG[6]),
	.JE2BEG7(JE2BEG[7]),
	.JS2BEG0(JS2BEG[0]),
	.JS2BEG1(JS2BEG[1]),
	.JS2BEG2(JS2BEG[2]),
	.JS2BEG3(JS2BEG[3]),
	.JS2BEG4(JS2BEG[4]),
	.JS2BEG5(JS2BEG[5]),
	.JS2BEG6(JS2BEG[6]),
	.JS2BEG7(JS2BEG[7]),
	.JW2BEG0(JW2BEG[0]),
	.JW2BEG1(JW2BEG[1]),
	.JW2BEG2(JW2BEG[2]),
	.JW2BEG3(JW2BEG[3]),
	.JW2BEG4(JW2BEG[4]),
	.JW2BEG5(JW2BEG[5]),
	.JW2BEG6(JW2BEG[6]),
	.JW2BEG7(JW2BEG[7]),
	.J_l_AB_BEG0(J_l_AB_BEG[0]),
	.J_l_AB_BEG1(J_l_AB_BEG[1]),
	.J_l_AB_BEG2(J_l_AB_BEG[2]),
	.J_l_AB_BEG3(J_l_AB_BEG[3]),
	.J_l_CD_BEG0(J_l_CD_BEG[0]),
	.J_l_CD_BEG1(J_l_CD_BEG[1]),
	.J_l_CD_BEG2(J_l_CD_BEG[2]),
	.J_l_CD_BEG3(J_l_CD_BEG[3]),
	.J_l_EF_BEG0(J_l_EF_BEG[0]),
	.J_l_EF_BEG1(J_l_EF_BEG[1]),
	.J_l_EF_BEG2(J_l_EF_BEG[2]),
	.J_l_EF_BEG3(J_l_EF_BEG[3]),
	.J_l_GH_BEG0(J_l_GH_BEG[0]),
	.J_l_GH_BEG1(J_l_GH_BEG[1]),
	.J_l_GH_BEG2(J_l_GH_BEG[2]),
	.J_l_GH_BEG3(J_l_GH_BEG[3]),
	.ConfigBits(ConfigBits[414-1:2]),
	.ConfigBits_N(ConfigBits_N[414-1:2])
	);

endmodule
