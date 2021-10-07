module RAM_IO (N1BEG, N2BEG, N2BEGb, N4BEG, N1END, N2MID, N2END, N4END, E1END, E2MID, E2END, EE4END, E6END, S1BEG, S2BEG, S2BEGb, S4BEG, S1END, S2MID, S2END, S4END, W1BEG, W2BEG, W2BEGb, WW4BEG, W6BEG, RAM2FAB_D0_I0, RAM2FAB_D0_I1, RAM2FAB_D0_I2, RAM2FAB_D0_I3, UserCLK, RAM2FAB_D1_I0, RAM2FAB_D1_I1, RAM2FAB_D1_I2, RAM2FAB_D1_I3, RAM2FAB_D2_I0, RAM2FAB_D2_I1, RAM2FAB_D2_I2, RAM2FAB_D2_I3, RAM2FAB_D3_I0, RAM2FAB_D3_I1, RAM2FAB_D3_I2, RAM2FAB_D3_I3, FAB2RAM_D0_O0, FAB2RAM_D0_O1, FAB2RAM_D0_O2, FAB2RAM_D0_O3, FAB2RAM_D1_O0, FAB2RAM_D1_O1, FAB2RAM_D1_O2, FAB2RAM_D1_O3, FAB2RAM_D2_O0, FAB2RAM_D2_O1, FAB2RAM_D2_O2, FAB2RAM_D2_O3, FAB2RAM_D3_O0, FAB2RAM_D3_O1, FAB2RAM_D3_O2, FAB2RAM_D3_O3, FAB2RAM_A0_O0, FAB2RAM_A0_O1, FAB2RAM_A0_O2, FAB2RAM_A0_O3, FAB2RAM_A1_O0, FAB2RAM_A1_O1, FAB2RAM_A1_O2, FAB2RAM_A1_O3, FAB2RAM_C_O0, FAB2RAM_C_O1, FAB2RAM_C_O2, FAB2RAM_C_O3, Config_accessC_bit0, Config_accessC_bit1, Config_accessC_bit2, Config_accessC_bit3, FrameData, FrameData_O, FrameStrobe, FrameStrobe_O);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 328;
	//  NORTH
	output [3:0] N1BEG; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	output [7:0] N2BEG; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	output [7:0] N2BEGb; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	output [15:0] N4BEG; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	input [3:0] N1END; //wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	input [7:0] N2MID; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	input [7:0] N2END; //wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	input [15:0] N4END; //wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	//  EAST
	input [3:0] E1END; //wires:4 X_offset:1 Y_offset:0  source_name:NULL destination_name:E1END  
	input [7:0] E2MID; //wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2MID  
	input [7:0] E2END; //wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2END  
	input [15:0] EE4END; //wires:4 X_offset:4 Y_offset:0  source_name:NULL destination_name:EE4END  
	input [11:0] E6END; //wires:2 X_offset:6 Y_offset:0  source_name:NULL destination_name:E6END  
	//  SOUTH
	output [3:0] S1BEG; //wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	output [7:0] S2BEG; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	output [7:0] S2BEGb; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	output [15:0] S4BEG; //wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	input [3:0] S1END; //wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	input [7:0] S2MID; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	input [7:0] S2END; //wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	input [15:0] S4END; //wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	//  WEST
	output [3:0] W1BEG; //wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:NULL  
	output [7:0] W2BEG; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:NULL  
	output [7:0] W2BEGb; //wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:NULL  
	output [15:0] WW4BEG; //wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:NULL  
	output [11:0] W6BEG; //wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:NULL  
	// Tile IO ports from BELs
	input RAM2FAB_D0_I0;
	input RAM2FAB_D0_I1;
	input RAM2FAB_D0_I2;
	input RAM2FAB_D0_I3;
	input UserCLK;
	input RAM2FAB_D1_I0;
	input RAM2FAB_D1_I1;
	input RAM2FAB_D1_I2;
	input RAM2FAB_D1_I3;
	input RAM2FAB_D2_I0;
	input RAM2FAB_D2_I1;
	input RAM2FAB_D2_I2;
	input RAM2FAB_D2_I3;
	input RAM2FAB_D3_I0;
	input RAM2FAB_D3_I1;
	input RAM2FAB_D3_I2;
	input RAM2FAB_D3_I3;
	output FAB2RAM_D0_O0;
	output FAB2RAM_D0_O1;
	output FAB2RAM_D0_O2;
	output FAB2RAM_D0_O3;
	output FAB2RAM_D1_O0;
	output FAB2RAM_D1_O1;
	output FAB2RAM_D1_O2;
	output FAB2RAM_D1_O3;
	output FAB2RAM_D2_O0;
	output FAB2RAM_D2_O1;
	output FAB2RAM_D2_O2;
	output FAB2RAM_D2_O3;
	output FAB2RAM_D3_O0;
	output FAB2RAM_D3_O1;
	output FAB2RAM_D3_O2;
	output FAB2RAM_D3_O3;
	output FAB2RAM_A0_O0;
	output FAB2RAM_A0_O1;
	output FAB2RAM_A0_O2;
	output FAB2RAM_A0_O3;
	output FAB2RAM_A1_O0;
	output FAB2RAM_A1_O1;
	output FAB2RAM_A1_O2;
	output FAB2RAM_A1_O3;
	output FAB2RAM_C_O0;
	output FAB2RAM_C_O1;
	output FAB2RAM_C_O2;
	output FAB2RAM_C_O3;
	output Config_accessC_bit0;
	output Config_accessC_bit1;
	output Config_accessC_bit2;
	output Config_accessC_bit3;
	input [FrameBitsPerRow-1:0] FrameData; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [FrameBitsPerRow-1:0] FrameData_O;
	input [MaxFramesPerCol-1:0] FrameStrobe; //CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [MaxFramesPerCol-1:0] FrameStrobe_O;
	//global


//signal declarations
//BEL ports (e.g., slices)
	wire FAB2RAM_D0_I0;
	wire FAB2RAM_D0_I1;
	wire FAB2RAM_D0_I2;
	wire FAB2RAM_D0_I3;
	wire FAB2RAM_D1_I0;
	wire FAB2RAM_D1_I1;
	wire FAB2RAM_D1_I2;
	wire FAB2RAM_D1_I3;
	wire FAB2RAM_D2_I0;
	wire FAB2RAM_D2_I1;
	wire FAB2RAM_D2_I2;
	wire FAB2RAM_D2_I3;
	wire FAB2RAM_D3_I0;
	wire FAB2RAM_D3_I1;
	wire FAB2RAM_D3_I2;
	wire FAB2RAM_D3_I3;
	wire FAB2RAM_A0_I0;
	wire FAB2RAM_A0_I1;
	wire FAB2RAM_A0_I2;
	wire FAB2RAM_A0_I3;
	wire FAB2RAM_A1_I0;
	wire FAB2RAM_A1_I1;
	wire FAB2RAM_A1_I2;
	wire FAB2RAM_A1_I3;
	wire FAB2RAM_C_I0;
	wire FAB2RAM_C_I1;
	wire FAB2RAM_C_I2;
	wire FAB2RAM_C_I3;
	wire RAM2FAB_D0_O0;
	wire RAM2FAB_D0_O1;
	wire RAM2FAB_D0_O2;
	wire RAM2FAB_D0_O3;
	wire RAM2FAB_D1_O0;
	wire RAM2FAB_D1_O1;
	wire RAM2FAB_D1_O2;
	wire RAM2FAB_D1_O3;
	wire RAM2FAB_D2_O0;
	wire RAM2FAB_D2_O1;
	wire RAM2FAB_D2_O2;
	wire RAM2FAB_D2_O3;
	wire RAM2FAB_D3_O0;
	wire RAM2FAB_D3_O1;
	wire RAM2FAB_D3_O2;
	wire RAM2FAB_D3_O3;
//jump wires
	wire [16-1:0] J_NS4_BEG;
	wire [8-1:0] J_NS2_BEG;
	wire [4-1:0] J_NS1_BEG;
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


// configuration storage latches
	RAM_IO_ConfigMem Inst_RAM_IO_ConfigMem (
	.FrameData(FrameData),
	.FrameStrobe(FrameStrobe),
	.ConfigBits(ConfigBits),
	.ConfigBits_N(ConfigBits_N)
	);

//BEL component instantiations
	InPass4_frame_config Inst_RAM2FAB_D0_InPass4_frame_config (
	.O0(RAM2FAB_D0_O0),
	.O1(RAM2FAB_D0_O1),
	.O2(RAM2FAB_D0_O2),
	.O3(RAM2FAB_D0_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(RAM2FAB_D0_I0),
	.I1(RAM2FAB_D0_I1),
	.I2(RAM2FAB_D0_I2),
	.I3(RAM2FAB_D0_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[4-1:0])
	);

	InPass4_frame_config Inst_RAM2FAB_D1_InPass4_frame_config (
	.O0(RAM2FAB_D1_O0),
	.O1(RAM2FAB_D1_O1),
	.O2(RAM2FAB_D1_O2),
	.O3(RAM2FAB_D1_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(RAM2FAB_D1_I0),
	.I1(RAM2FAB_D1_I1),
	.I2(RAM2FAB_D1_I2),
	.I3(RAM2FAB_D1_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[8-1:4])
	);

	InPass4_frame_config Inst_RAM2FAB_D2_InPass4_frame_config (
	.O0(RAM2FAB_D2_O0),
	.O1(RAM2FAB_D2_O1),
	.O2(RAM2FAB_D2_O2),
	.O3(RAM2FAB_D2_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(RAM2FAB_D2_I0),
	.I1(RAM2FAB_D2_I1),
	.I2(RAM2FAB_D2_I2),
	.I3(RAM2FAB_D2_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[12-1:8])
	);

	InPass4_frame_config Inst_RAM2FAB_D3_InPass4_frame_config (
	.O0(RAM2FAB_D3_O0),
	.O1(RAM2FAB_D3_O1),
	.O2(RAM2FAB_D3_O2),
	.O3(RAM2FAB_D3_O3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.I0(RAM2FAB_D3_I0),
	.I1(RAM2FAB_D3_I1),
	.I2(RAM2FAB_D3_I2),
	.I3(RAM2FAB_D3_I3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[16-1:12])
	);

	OutPass4_frame_config Inst_FAB2RAM_D0_OutPass4_frame_config (
	.I0(FAB2RAM_D0_I0),
	.I1(FAB2RAM_D0_I1),
	.I2(FAB2RAM_D0_I2),
	.I3(FAB2RAM_D0_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_D0_O0),
	.O1(FAB2RAM_D0_O1),
	.O2(FAB2RAM_D0_O2),
	.O3(FAB2RAM_D0_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[20-1:16])
	);

	OutPass4_frame_config Inst_FAB2RAM_D1_OutPass4_frame_config (
	.I0(FAB2RAM_D1_I0),
	.I1(FAB2RAM_D1_I1),
	.I2(FAB2RAM_D1_I2),
	.I3(FAB2RAM_D1_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_D1_O0),
	.O1(FAB2RAM_D1_O1),
	.O2(FAB2RAM_D1_O2),
	.O3(FAB2RAM_D1_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[24-1:20])
	);

	OutPass4_frame_config Inst_FAB2RAM_D2_OutPass4_frame_config (
	.I0(FAB2RAM_D2_I0),
	.I1(FAB2RAM_D2_I1),
	.I2(FAB2RAM_D2_I2),
	.I3(FAB2RAM_D2_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_D2_O0),
	.O1(FAB2RAM_D2_O1),
	.O2(FAB2RAM_D2_O2),
	.O3(FAB2RAM_D2_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[28-1:24])
	);

	OutPass4_frame_config Inst_FAB2RAM_D3_OutPass4_frame_config (
	.I0(FAB2RAM_D3_I0),
	.I1(FAB2RAM_D3_I1),
	.I2(FAB2RAM_D3_I2),
	.I3(FAB2RAM_D3_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_D3_O0),
	.O1(FAB2RAM_D3_O1),
	.O2(FAB2RAM_D3_O2),
	.O3(FAB2RAM_D3_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[32-1:28])
	);

	OutPass4_frame_config Inst_FAB2RAM_A0_OutPass4_frame_config (
	.I0(FAB2RAM_A0_I0),
	.I1(FAB2RAM_A0_I1),
	.I2(FAB2RAM_A0_I2),
	.I3(FAB2RAM_A0_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_A0_O0),
	.O1(FAB2RAM_A0_O1),
	.O2(FAB2RAM_A0_O2),
	.O3(FAB2RAM_A0_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[36-1:32])
	);

	OutPass4_frame_config Inst_FAB2RAM_A1_OutPass4_frame_config (
	.I0(FAB2RAM_A1_I0),
	.I1(FAB2RAM_A1_I1),
	.I2(FAB2RAM_A1_I2),
	.I3(FAB2RAM_A1_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_A1_O0),
	.O1(FAB2RAM_A1_O1),
	.O2(FAB2RAM_A1_O2),
	.O3(FAB2RAM_A1_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[40-1:36])
	);

	OutPass4_frame_config Inst_FAB2RAM_C_OutPass4_frame_config (
	.I0(FAB2RAM_C_I0),
	.I1(FAB2RAM_C_I1),
	.I2(FAB2RAM_C_I2),
	.I3(FAB2RAM_C_I3),
	//I/O primitive pins go to tile top level module (not further parsed)  
	.O0(FAB2RAM_C_O0),
	.O1(FAB2RAM_C_O1),
	.O2(FAB2RAM_C_O2),
	.O3(FAB2RAM_C_O3),
	.UserCLK(UserCLK),
	.ConfigBits(ConfigBits[44-1:40])
	);

	Config_access Inst_Config_accessConfig_access (
	//I/O primitive pins go to tile top level module (not further parsed)  
	.C_bit0(Config_accessC_bit0),
	.C_bit1(Config_accessC_bit1),
	.C_bit2(Config_accessC_bit2),
	.C_bit3(Config_accessC_bit3),
	.ConfigBits(ConfigBits[48-1:44])
	);


//switch matrix component instantiation
	RAM_IO_switch_matrix Inst_RAM_IO_switch_matrix (
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
	.EE4END4(EE4END[4]),
	.EE4END5(EE4END[5]),
	.EE4END6(EE4END[6]),
	.EE4END7(EE4END[7]),
	.EE4END8(EE4END[8]),
	.EE4END9(EE4END[9]),
	.EE4END10(EE4END[10]),
	.EE4END11(EE4END[11]),
	.EE4END12(EE4END[12]),
	.EE4END13(EE4END[13]),
	.EE4END14(EE4END[14]),
	.EE4END15(EE4END[15]),
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
	.RAM2FAB_D0_O0(RAM2FAB_D0_O0),
	.RAM2FAB_D0_O1(RAM2FAB_D0_O1),
	.RAM2FAB_D0_O2(RAM2FAB_D0_O2),
	.RAM2FAB_D0_O3(RAM2FAB_D0_O3),
	.RAM2FAB_D1_O0(RAM2FAB_D1_O0),
	.RAM2FAB_D1_O1(RAM2FAB_D1_O1),
	.RAM2FAB_D1_O2(RAM2FAB_D1_O2),
	.RAM2FAB_D1_O3(RAM2FAB_D1_O3),
	.RAM2FAB_D2_O0(RAM2FAB_D2_O0),
	.RAM2FAB_D2_O1(RAM2FAB_D2_O1),
	.RAM2FAB_D2_O2(RAM2FAB_D2_O2),
	.RAM2FAB_D2_O3(RAM2FAB_D2_O3),
	.RAM2FAB_D3_O0(RAM2FAB_D3_O0),
	.RAM2FAB_D3_O1(RAM2FAB_D3_O1),
	.RAM2FAB_D3_O2(RAM2FAB_D3_O2),
	.RAM2FAB_D3_O3(RAM2FAB_D3_O3),
	.J_NS4_END0(J_NS4_BEG[0]),
	.J_NS4_END1(J_NS4_BEG[1]),
	.J_NS4_END2(J_NS4_BEG[2]),
	.J_NS4_END3(J_NS4_BEG[3]),
	.J_NS4_END4(J_NS4_BEG[4]),
	.J_NS4_END5(J_NS4_BEG[5]),
	.J_NS4_END6(J_NS4_BEG[6]),
	.J_NS4_END7(J_NS4_BEG[7]),
	.J_NS4_END8(J_NS4_BEG[8]),
	.J_NS4_END9(J_NS4_BEG[9]),
	.J_NS4_END10(J_NS4_BEG[10]),
	.J_NS4_END11(J_NS4_BEG[11]),
	.J_NS4_END12(J_NS4_BEG[12]),
	.J_NS4_END13(J_NS4_BEG[13]),
	.J_NS4_END14(J_NS4_BEG[14]),
	.J_NS4_END15(J_NS4_BEG[15]),
	.J_NS2_END0(J_NS2_BEG[0]),
	.J_NS2_END1(J_NS2_BEG[1]),
	.J_NS2_END2(J_NS2_BEG[2]),
	.J_NS2_END3(J_NS2_BEG[3]),
	.J_NS2_END4(J_NS2_BEG[4]),
	.J_NS2_END5(J_NS2_BEG[5]),
	.J_NS2_END6(J_NS2_BEG[6]),
	.J_NS2_END7(J_NS2_BEG[7]),
	.J_NS1_END0(J_NS1_BEG[0]),
	.J_NS1_END1(J_NS1_BEG[1]),
	.J_NS1_END2(J_NS1_BEG[2]),
	.J_NS1_END3(J_NS1_BEG[3]),
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
	.WW4BEG0(WW4BEG[0]),
	.WW4BEG1(WW4BEG[1]),
	.WW4BEG2(WW4BEG[2]),
	.WW4BEG3(WW4BEG[3]),
	.WW4BEG4(WW4BEG[4]),
	.WW4BEG5(WW4BEG[5]),
	.WW4BEG6(WW4BEG[6]),
	.WW4BEG7(WW4BEG[7]),
	.WW4BEG8(WW4BEG[8]),
	.WW4BEG9(WW4BEG[9]),
	.WW4BEG10(WW4BEG[10]),
	.WW4BEG11(WW4BEG[11]),
	.WW4BEG12(WW4BEG[12]),
	.WW4BEG13(WW4BEG[13]),
	.WW4BEG14(WW4BEG[14]),
	.WW4BEG15(WW4BEG[15]),
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
	.FAB2RAM_D0_I0(FAB2RAM_D0_I0),
	.FAB2RAM_D0_I1(FAB2RAM_D0_I1),
	.FAB2RAM_D0_I2(FAB2RAM_D0_I2),
	.FAB2RAM_D0_I3(FAB2RAM_D0_I3),
	.FAB2RAM_D1_I0(FAB2RAM_D1_I0),
	.FAB2RAM_D1_I1(FAB2RAM_D1_I1),
	.FAB2RAM_D1_I2(FAB2RAM_D1_I2),
	.FAB2RAM_D1_I3(FAB2RAM_D1_I3),
	.FAB2RAM_D2_I0(FAB2RAM_D2_I0),
	.FAB2RAM_D2_I1(FAB2RAM_D2_I1),
	.FAB2RAM_D2_I2(FAB2RAM_D2_I2),
	.FAB2RAM_D2_I3(FAB2RAM_D2_I3),
	.FAB2RAM_D3_I0(FAB2RAM_D3_I0),
	.FAB2RAM_D3_I1(FAB2RAM_D3_I1),
	.FAB2RAM_D3_I2(FAB2RAM_D3_I2),
	.FAB2RAM_D3_I3(FAB2RAM_D3_I3),
	.FAB2RAM_A0_I0(FAB2RAM_A0_I0),
	.FAB2RAM_A0_I1(FAB2RAM_A0_I1),
	.FAB2RAM_A0_I2(FAB2RAM_A0_I2),
	.FAB2RAM_A0_I3(FAB2RAM_A0_I3),
	.FAB2RAM_A1_I0(FAB2RAM_A1_I0),
	.FAB2RAM_A1_I1(FAB2RAM_A1_I1),
	.FAB2RAM_A1_I2(FAB2RAM_A1_I2),
	.FAB2RAM_A1_I3(FAB2RAM_A1_I3),
	.FAB2RAM_C_I0(FAB2RAM_C_I0),
	.FAB2RAM_C_I1(FAB2RAM_C_I1),
	.FAB2RAM_C_I2(FAB2RAM_C_I2),
	.FAB2RAM_C_I3(FAB2RAM_C_I3),
	.J_NS4_BEG0(J_NS4_BEG[0]),
	.J_NS4_BEG1(J_NS4_BEG[1]),
	.J_NS4_BEG2(J_NS4_BEG[2]),
	.J_NS4_BEG3(J_NS4_BEG[3]),
	.J_NS4_BEG4(J_NS4_BEG[4]),
	.J_NS4_BEG5(J_NS4_BEG[5]),
	.J_NS4_BEG6(J_NS4_BEG[6]),
	.J_NS4_BEG7(J_NS4_BEG[7]),
	.J_NS4_BEG8(J_NS4_BEG[8]),
	.J_NS4_BEG9(J_NS4_BEG[9]),
	.J_NS4_BEG10(J_NS4_BEG[10]),
	.J_NS4_BEG11(J_NS4_BEG[11]),
	.J_NS4_BEG12(J_NS4_BEG[12]),
	.J_NS4_BEG13(J_NS4_BEG[13]),
	.J_NS4_BEG14(J_NS4_BEG[14]),
	.J_NS4_BEG15(J_NS4_BEG[15]),
	.J_NS2_BEG0(J_NS2_BEG[0]),
	.J_NS2_BEG1(J_NS2_BEG[1]),
	.J_NS2_BEG2(J_NS2_BEG[2]),
	.J_NS2_BEG3(J_NS2_BEG[3]),
	.J_NS2_BEG4(J_NS2_BEG[4]),
	.J_NS2_BEG5(J_NS2_BEG[5]),
	.J_NS2_BEG6(J_NS2_BEG[6]),
	.J_NS2_BEG7(J_NS2_BEG[7]),
	.J_NS1_BEG0(J_NS1_BEG[0]),
	.J_NS1_BEG1(J_NS1_BEG[1]),
	.J_NS1_BEG2(J_NS1_BEG[2]),
	.J_NS1_BEG3(J_NS1_BEG[3]),
	.ConfigBits(ConfigBits[328-1:48]),
	.ConfigBits_N(ConfigBits_N[328-1:48])
	);

endmodule
