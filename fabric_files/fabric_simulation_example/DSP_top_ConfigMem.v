module DSP_top_ConfigMem (FrameData, FrameStrobe, ConfigBits, ConfigBits_N);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 406;
	input [FrameBitsPerRow-1:0] FrameData;
	input [MaxFramesPerCol-1:0] FrameStrobe;
	output [NoConfigBits-1:0] ConfigBits;
	output [NoConfigBits-1:0] ConfigBits_N;
	wire [32-1:0] frame0;
	wire [32-1:0] frame1;
	wire [32-1:0] frame2;
	wire [32-1:0] frame3;
	wire [32-1:0] frame4;
	wire [32-1:0] frame5;
	wire [32-1:0] frame6;
	wire [32-1:0] frame7;
	wire [32-1:0] frame8;
	wire [32-1:0] frame9;
	wire [32-1:0] frame10;
	wire [32-1:0] frame11;
	wire [22-1:0] frame12;

//instantiate frame latches
	LHQD1 Inst_frame0_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[405]),
	.QN(ConfigBits_N[405])
	);

	LHQD1 Inst_frame0_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[404]),
	.QN(ConfigBits_N[404])
	);

	LHQD1 Inst_frame0_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[403]),
	.QN(ConfigBits_N[403])
	);

	LHQD1 Inst_frame0_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[402]),
	.QN(ConfigBits_N[402])
	);

	LHQD1 Inst_frame0_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[401]),
	.QN(ConfigBits_N[401])
	);

	LHQD1 Inst_frame0_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[400]),
	.QN(ConfigBits_N[400])
	);

	LHQD1 Inst_frame0_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[399]),
	.QN(ConfigBits_N[399])
	);

	LHQD1 Inst_frame0_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[398]),
	.QN(ConfigBits_N[398])
	);

	LHQD1 Inst_frame0_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[397]),
	.QN(ConfigBits_N[397])
	);

	LHQD1 Inst_frame0_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[396]),
	.QN(ConfigBits_N[396])
	);

	LHQD1 Inst_frame0_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[395]),
	.QN(ConfigBits_N[395])
	);

	LHQD1 Inst_frame0_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[394]),
	.QN(ConfigBits_N[394])
	);

	LHQD1 Inst_frame0_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[393]),
	.QN(ConfigBits_N[393])
	);

	LHQD1 Inst_frame0_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[392]),
	.QN(ConfigBits_N[392])
	);

	LHQD1 Inst_frame0_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[391]),
	.QN(ConfigBits_N[391])
	);

	LHQD1 Inst_frame0_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[390]),
	.QN(ConfigBits_N[390])
	);

	LHQD1 Inst_frame0_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[389]),
	.QN(ConfigBits_N[389])
	);

	LHQD1 Inst_frame0_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[388]),
	.QN(ConfigBits_N[388])
	);

	LHQD1 Inst_frame0_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[387]),
	.QN(ConfigBits_N[387])
	);

	LHQD1 Inst_frame0_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[386]),
	.QN(ConfigBits_N[386])
	);

	LHQD1 Inst_frame0_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[385]),
	.QN(ConfigBits_N[385])
	);

	LHQD1 Inst_frame0_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[384]),
	.QN(ConfigBits_N[384])
	);

	LHQD1 Inst_frame0_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[383]),
	.QN(ConfigBits_N[383])
	);

	LHQD1 Inst_frame0_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[382]),
	.QN(ConfigBits_N[382])
	);

	LHQD1 Inst_frame0_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[381]),
	.QN(ConfigBits_N[381])
	);

	LHQD1 Inst_frame0_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[380]),
	.QN(ConfigBits_N[380])
	);

	LHQD1 Inst_frame0_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[379]),
	.QN(ConfigBits_N[379])
	);

	LHQD1 Inst_frame0_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[378]),
	.QN(ConfigBits_N[378])
	);

	LHQD1 Inst_frame0_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[377]),
	.QN(ConfigBits_N[377])
	);

	LHQD1 Inst_frame0_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[376]),
	.QN(ConfigBits_N[376])
	);

	LHQD1 Inst_frame0_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[375]),
	.QN(ConfigBits_N[375])
	);

	LHQD1 Inst_frame0_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[374]),
	.QN(ConfigBits_N[374])
	);

	LHQD1 Inst_frame1_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[373]),
	.QN(ConfigBits_N[373])
	);

	LHQD1 Inst_frame1_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[372]),
	.QN(ConfigBits_N[372])
	);

	LHQD1 Inst_frame1_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[371]),
	.QN(ConfigBits_N[371])
	);

	LHQD1 Inst_frame1_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[370]),
	.QN(ConfigBits_N[370])
	);

	LHQD1 Inst_frame1_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[369]),
	.QN(ConfigBits_N[369])
	);

	LHQD1 Inst_frame1_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[368]),
	.QN(ConfigBits_N[368])
	);

	LHQD1 Inst_frame1_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[367]),
	.QN(ConfigBits_N[367])
	);

	LHQD1 Inst_frame1_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[366]),
	.QN(ConfigBits_N[366])
	);

	LHQD1 Inst_frame1_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[365]),
	.QN(ConfigBits_N[365])
	);

	LHQD1 Inst_frame1_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[364]),
	.QN(ConfigBits_N[364])
	);

	LHQD1 Inst_frame1_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[363]),
	.QN(ConfigBits_N[363])
	);

	LHQD1 Inst_frame1_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[362]),
	.QN(ConfigBits_N[362])
	);

	LHQD1 Inst_frame1_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[361]),
	.QN(ConfigBits_N[361])
	);

	LHQD1 Inst_frame1_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[360]),
	.QN(ConfigBits_N[360])
	);

	LHQD1 Inst_frame1_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[359]),
	.QN(ConfigBits_N[359])
	);

	LHQD1 Inst_frame1_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[358]),
	.QN(ConfigBits_N[358])
	);

	LHQD1 Inst_frame1_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[357]),
	.QN(ConfigBits_N[357])
	);

	LHQD1 Inst_frame1_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[356]),
	.QN(ConfigBits_N[356])
	);

	LHQD1 Inst_frame1_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[355]),
	.QN(ConfigBits_N[355])
	);

	LHQD1 Inst_frame1_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[354]),
	.QN(ConfigBits_N[354])
	);

	LHQD1 Inst_frame1_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[353]),
	.QN(ConfigBits_N[353])
	);

	LHQD1 Inst_frame1_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[352]),
	.QN(ConfigBits_N[352])
	);

	LHQD1 Inst_frame1_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[351]),
	.QN(ConfigBits_N[351])
	);

	LHQD1 Inst_frame1_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[350]),
	.QN(ConfigBits_N[350])
	);

	LHQD1 Inst_frame1_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[349]),
	.QN(ConfigBits_N[349])
	);

	LHQD1 Inst_frame1_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[348]),
	.QN(ConfigBits_N[348])
	);

	LHQD1 Inst_frame1_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[347]),
	.QN(ConfigBits_N[347])
	);

	LHQD1 Inst_frame1_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[346]),
	.QN(ConfigBits_N[346])
	);

	LHQD1 Inst_frame1_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[345]),
	.QN(ConfigBits_N[345])
	);

	LHQD1 Inst_frame1_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[344]),
	.QN(ConfigBits_N[344])
	);

	LHQD1 Inst_frame1_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[343]),
	.QN(ConfigBits_N[343])
	);

	LHQD1 Inst_frame1_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[342]),
	.QN(ConfigBits_N[342])
	);

	LHQD1 Inst_frame2_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[341]),
	.QN(ConfigBits_N[341])
	);

	LHQD1 Inst_frame2_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[340]),
	.QN(ConfigBits_N[340])
	);

	LHQD1 Inst_frame2_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[339]),
	.QN(ConfigBits_N[339])
	);

	LHQD1 Inst_frame2_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[338]),
	.QN(ConfigBits_N[338])
	);

	LHQD1 Inst_frame2_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[337]),
	.QN(ConfigBits_N[337])
	);

	LHQD1 Inst_frame2_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[336]),
	.QN(ConfigBits_N[336])
	);

	LHQD1 Inst_frame2_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[335]),
	.QN(ConfigBits_N[335])
	);

	LHQD1 Inst_frame2_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[334]),
	.QN(ConfigBits_N[334])
	);

	LHQD1 Inst_frame2_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[333]),
	.QN(ConfigBits_N[333])
	);

	LHQD1 Inst_frame2_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[332]),
	.QN(ConfigBits_N[332])
	);

	LHQD1 Inst_frame2_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[331]),
	.QN(ConfigBits_N[331])
	);

	LHQD1 Inst_frame2_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[330]),
	.QN(ConfigBits_N[330])
	);

	LHQD1 Inst_frame2_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[329]),
	.QN(ConfigBits_N[329])
	);

	LHQD1 Inst_frame2_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[328]),
	.QN(ConfigBits_N[328])
	);

	LHQD1 Inst_frame2_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[327]),
	.QN(ConfigBits_N[327])
	);

	LHQD1 Inst_frame2_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[326]),
	.QN(ConfigBits_N[326])
	);

	LHQD1 Inst_frame2_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[325]),
	.QN(ConfigBits_N[325])
	);

	LHQD1 Inst_frame2_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[324]),
	.QN(ConfigBits_N[324])
	);

	LHQD1 Inst_frame2_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[323]),
	.QN(ConfigBits_N[323])
	);

	LHQD1 Inst_frame2_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[322]),
	.QN(ConfigBits_N[322])
	);

	LHQD1 Inst_frame2_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[321]),
	.QN(ConfigBits_N[321])
	);

	LHQD1 Inst_frame2_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[320]),
	.QN(ConfigBits_N[320])
	);

	LHQD1 Inst_frame2_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[319]),
	.QN(ConfigBits_N[319])
	);

	LHQD1 Inst_frame2_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[318]),
	.QN(ConfigBits_N[318])
	);

	LHQD1 Inst_frame2_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[317]),
	.QN(ConfigBits_N[317])
	);

	LHQD1 Inst_frame2_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[316]),
	.QN(ConfigBits_N[316])
	);

	LHQD1 Inst_frame2_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[315]),
	.QN(ConfigBits_N[315])
	);

	LHQD1 Inst_frame2_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[314]),
	.QN(ConfigBits_N[314])
	);

	LHQD1 Inst_frame2_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[313]),
	.QN(ConfigBits_N[313])
	);

	LHQD1 Inst_frame2_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[312]),
	.QN(ConfigBits_N[312])
	);

	LHQD1 Inst_frame2_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[311]),
	.QN(ConfigBits_N[311])
	);

	LHQD1 Inst_frame2_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[2]),
	.Q(ConfigBits[310]),
	.QN(ConfigBits_N[310])
	);

	LHQD1 Inst_frame3_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[309]),
	.QN(ConfigBits_N[309])
	);

	LHQD1 Inst_frame3_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[308]),
	.QN(ConfigBits_N[308])
	);

	LHQD1 Inst_frame3_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[307]),
	.QN(ConfigBits_N[307])
	);

	LHQD1 Inst_frame3_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[306]),
	.QN(ConfigBits_N[306])
	);

	LHQD1 Inst_frame3_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[305]),
	.QN(ConfigBits_N[305])
	);

	LHQD1 Inst_frame3_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[304]),
	.QN(ConfigBits_N[304])
	);

	LHQD1 Inst_frame3_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[303]),
	.QN(ConfigBits_N[303])
	);

	LHQD1 Inst_frame3_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[302]),
	.QN(ConfigBits_N[302])
	);

	LHQD1 Inst_frame3_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[301]),
	.QN(ConfigBits_N[301])
	);

	LHQD1 Inst_frame3_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[300]),
	.QN(ConfigBits_N[300])
	);

	LHQD1 Inst_frame3_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[299]),
	.QN(ConfigBits_N[299])
	);

	LHQD1 Inst_frame3_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[298]),
	.QN(ConfigBits_N[298])
	);

	LHQD1 Inst_frame3_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[297]),
	.QN(ConfigBits_N[297])
	);

	LHQD1 Inst_frame3_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[296]),
	.QN(ConfigBits_N[296])
	);

	LHQD1 Inst_frame3_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[295]),
	.QN(ConfigBits_N[295])
	);

	LHQD1 Inst_frame3_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[294]),
	.QN(ConfigBits_N[294])
	);

	LHQD1 Inst_frame3_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[293]),
	.QN(ConfigBits_N[293])
	);

	LHQD1 Inst_frame3_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[292]),
	.QN(ConfigBits_N[292])
	);

	LHQD1 Inst_frame3_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[291]),
	.QN(ConfigBits_N[291])
	);

	LHQD1 Inst_frame3_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[290]),
	.QN(ConfigBits_N[290])
	);

	LHQD1 Inst_frame3_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[289]),
	.QN(ConfigBits_N[289])
	);

	LHQD1 Inst_frame3_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[288]),
	.QN(ConfigBits_N[288])
	);

	LHQD1 Inst_frame3_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[287]),
	.QN(ConfigBits_N[287])
	);

	LHQD1 Inst_frame3_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[286]),
	.QN(ConfigBits_N[286])
	);

	LHQD1 Inst_frame3_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[285]),
	.QN(ConfigBits_N[285])
	);

	LHQD1 Inst_frame3_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[284]),
	.QN(ConfigBits_N[284])
	);

	LHQD1 Inst_frame3_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[283]),
	.QN(ConfigBits_N[283])
	);

	LHQD1 Inst_frame3_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[282]),
	.QN(ConfigBits_N[282])
	);

	LHQD1 Inst_frame3_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[281]),
	.QN(ConfigBits_N[281])
	);

	LHQD1 Inst_frame3_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[280]),
	.QN(ConfigBits_N[280])
	);

	LHQD1 Inst_frame3_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[279]),
	.QN(ConfigBits_N[279])
	);

	LHQD1 Inst_frame3_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[3]),
	.Q(ConfigBits[278]),
	.QN(ConfigBits_N[278])
	);

	LHQD1 Inst_frame4_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[277]),
	.QN(ConfigBits_N[277])
	);

	LHQD1 Inst_frame4_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[276]),
	.QN(ConfigBits_N[276])
	);

	LHQD1 Inst_frame4_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[275]),
	.QN(ConfigBits_N[275])
	);

	LHQD1 Inst_frame4_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[274]),
	.QN(ConfigBits_N[274])
	);

	LHQD1 Inst_frame4_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[273]),
	.QN(ConfigBits_N[273])
	);

	LHQD1 Inst_frame4_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[272]),
	.QN(ConfigBits_N[272])
	);

	LHQD1 Inst_frame4_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[271]),
	.QN(ConfigBits_N[271])
	);

	LHQD1 Inst_frame4_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[270]),
	.QN(ConfigBits_N[270])
	);

	LHQD1 Inst_frame4_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[269]),
	.QN(ConfigBits_N[269])
	);

	LHQD1 Inst_frame4_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[268]),
	.QN(ConfigBits_N[268])
	);

	LHQD1 Inst_frame4_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[267]),
	.QN(ConfigBits_N[267])
	);

	LHQD1 Inst_frame4_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[266]),
	.QN(ConfigBits_N[266])
	);

	LHQD1 Inst_frame4_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[265]),
	.QN(ConfigBits_N[265])
	);

	LHQD1 Inst_frame4_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[264]),
	.QN(ConfigBits_N[264])
	);

	LHQD1 Inst_frame4_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[263]),
	.QN(ConfigBits_N[263])
	);

	LHQD1 Inst_frame4_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[262]),
	.QN(ConfigBits_N[262])
	);

	LHQD1 Inst_frame4_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[261]),
	.QN(ConfigBits_N[261])
	);

	LHQD1 Inst_frame4_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[260]),
	.QN(ConfigBits_N[260])
	);

	LHQD1 Inst_frame4_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[259]),
	.QN(ConfigBits_N[259])
	);

	LHQD1 Inst_frame4_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[258]),
	.QN(ConfigBits_N[258])
	);

	LHQD1 Inst_frame4_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[257]),
	.QN(ConfigBits_N[257])
	);

	LHQD1 Inst_frame4_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[256]),
	.QN(ConfigBits_N[256])
	);

	LHQD1 Inst_frame4_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[255]),
	.QN(ConfigBits_N[255])
	);

	LHQD1 Inst_frame4_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[254]),
	.QN(ConfigBits_N[254])
	);

	LHQD1 Inst_frame4_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[253]),
	.QN(ConfigBits_N[253])
	);

	LHQD1 Inst_frame4_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[252]),
	.QN(ConfigBits_N[252])
	);

	LHQD1 Inst_frame4_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[251]),
	.QN(ConfigBits_N[251])
	);

	LHQD1 Inst_frame4_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[250]),
	.QN(ConfigBits_N[250])
	);

	LHQD1 Inst_frame4_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[249]),
	.QN(ConfigBits_N[249])
	);

	LHQD1 Inst_frame4_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[248]),
	.QN(ConfigBits_N[248])
	);

	LHQD1 Inst_frame4_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[247]),
	.QN(ConfigBits_N[247])
	);

	LHQD1 Inst_frame4_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[4]),
	.Q(ConfigBits[246]),
	.QN(ConfigBits_N[246])
	);

	LHQD1 Inst_frame5_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[245]),
	.QN(ConfigBits_N[245])
	);

	LHQD1 Inst_frame5_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[244]),
	.QN(ConfigBits_N[244])
	);

	LHQD1 Inst_frame5_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[243]),
	.QN(ConfigBits_N[243])
	);

	LHQD1 Inst_frame5_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[242]),
	.QN(ConfigBits_N[242])
	);

	LHQD1 Inst_frame5_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[241]),
	.QN(ConfigBits_N[241])
	);

	LHQD1 Inst_frame5_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[240]),
	.QN(ConfigBits_N[240])
	);

	LHQD1 Inst_frame5_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[239]),
	.QN(ConfigBits_N[239])
	);

	LHQD1 Inst_frame5_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[238]),
	.QN(ConfigBits_N[238])
	);

	LHQD1 Inst_frame5_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[237]),
	.QN(ConfigBits_N[237])
	);

	LHQD1 Inst_frame5_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[236]),
	.QN(ConfigBits_N[236])
	);

	LHQD1 Inst_frame5_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[235]),
	.QN(ConfigBits_N[235])
	);

	LHQD1 Inst_frame5_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[234]),
	.QN(ConfigBits_N[234])
	);

	LHQD1 Inst_frame5_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[233]),
	.QN(ConfigBits_N[233])
	);

	LHQD1 Inst_frame5_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[232]),
	.QN(ConfigBits_N[232])
	);

	LHQD1 Inst_frame5_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[231]),
	.QN(ConfigBits_N[231])
	);

	LHQD1 Inst_frame5_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[230]),
	.QN(ConfigBits_N[230])
	);

	LHQD1 Inst_frame5_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[229]),
	.QN(ConfigBits_N[229])
	);

	LHQD1 Inst_frame5_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[228]),
	.QN(ConfigBits_N[228])
	);

	LHQD1 Inst_frame5_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[227]),
	.QN(ConfigBits_N[227])
	);

	LHQD1 Inst_frame5_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[226]),
	.QN(ConfigBits_N[226])
	);

	LHQD1 Inst_frame5_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[225]),
	.QN(ConfigBits_N[225])
	);

	LHQD1 Inst_frame5_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[224]),
	.QN(ConfigBits_N[224])
	);

	LHQD1 Inst_frame5_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[223]),
	.QN(ConfigBits_N[223])
	);

	LHQD1 Inst_frame5_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[222]),
	.QN(ConfigBits_N[222])
	);

	LHQD1 Inst_frame5_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[221]),
	.QN(ConfigBits_N[221])
	);

	LHQD1 Inst_frame5_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[220]),
	.QN(ConfigBits_N[220])
	);

	LHQD1 Inst_frame5_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[219]),
	.QN(ConfigBits_N[219])
	);

	LHQD1 Inst_frame5_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[218]),
	.QN(ConfigBits_N[218])
	);

	LHQD1 Inst_frame5_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[217]),
	.QN(ConfigBits_N[217])
	);

	LHQD1 Inst_frame5_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[216]),
	.QN(ConfigBits_N[216])
	);

	LHQD1 Inst_frame5_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[215]),
	.QN(ConfigBits_N[215])
	);

	LHQD1 Inst_frame5_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[5]),
	.Q(ConfigBits[214]),
	.QN(ConfigBits_N[214])
	);

	LHQD1 Inst_frame6_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[213]),
	.QN(ConfigBits_N[213])
	);

	LHQD1 Inst_frame6_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[212]),
	.QN(ConfigBits_N[212])
	);

	LHQD1 Inst_frame6_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[211]),
	.QN(ConfigBits_N[211])
	);

	LHQD1 Inst_frame6_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[210]),
	.QN(ConfigBits_N[210])
	);

	LHQD1 Inst_frame6_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[209]),
	.QN(ConfigBits_N[209])
	);

	LHQD1 Inst_frame6_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[208]),
	.QN(ConfigBits_N[208])
	);

	LHQD1 Inst_frame6_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[207]),
	.QN(ConfigBits_N[207])
	);

	LHQD1 Inst_frame6_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[206]),
	.QN(ConfigBits_N[206])
	);

	LHQD1 Inst_frame6_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[205]),
	.QN(ConfigBits_N[205])
	);

	LHQD1 Inst_frame6_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[204]),
	.QN(ConfigBits_N[204])
	);

	LHQD1 Inst_frame6_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[203]),
	.QN(ConfigBits_N[203])
	);

	LHQD1 Inst_frame6_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[202]),
	.QN(ConfigBits_N[202])
	);

	LHQD1 Inst_frame6_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[201]),
	.QN(ConfigBits_N[201])
	);

	LHQD1 Inst_frame6_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[200]),
	.QN(ConfigBits_N[200])
	);

	LHQD1 Inst_frame6_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[199]),
	.QN(ConfigBits_N[199])
	);

	LHQD1 Inst_frame6_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[198]),
	.QN(ConfigBits_N[198])
	);

	LHQD1 Inst_frame6_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[197]),
	.QN(ConfigBits_N[197])
	);

	LHQD1 Inst_frame6_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[196]),
	.QN(ConfigBits_N[196])
	);

	LHQD1 Inst_frame6_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[195]),
	.QN(ConfigBits_N[195])
	);

	LHQD1 Inst_frame6_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[194]),
	.QN(ConfigBits_N[194])
	);

	LHQD1 Inst_frame6_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[193]),
	.QN(ConfigBits_N[193])
	);

	LHQD1 Inst_frame6_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[192]),
	.QN(ConfigBits_N[192])
	);

	LHQD1 Inst_frame6_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[191]),
	.QN(ConfigBits_N[191])
	);

	LHQD1 Inst_frame6_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[190]),
	.QN(ConfigBits_N[190])
	);

	LHQD1 Inst_frame6_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[189]),
	.QN(ConfigBits_N[189])
	);

	LHQD1 Inst_frame6_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[188]),
	.QN(ConfigBits_N[188])
	);

	LHQD1 Inst_frame6_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[187]),
	.QN(ConfigBits_N[187])
	);

	LHQD1 Inst_frame6_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[186]),
	.QN(ConfigBits_N[186])
	);

	LHQD1 Inst_frame6_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[185]),
	.QN(ConfigBits_N[185])
	);

	LHQD1 Inst_frame6_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[184]),
	.QN(ConfigBits_N[184])
	);

	LHQD1 Inst_frame6_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[183]),
	.QN(ConfigBits_N[183])
	);

	LHQD1 Inst_frame6_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[6]),
	.Q(ConfigBits[182]),
	.QN(ConfigBits_N[182])
	);

	LHQD1 Inst_frame7_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[181]),
	.QN(ConfigBits_N[181])
	);

	LHQD1 Inst_frame7_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[180]),
	.QN(ConfigBits_N[180])
	);

	LHQD1 Inst_frame7_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[179]),
	.QN(ConfigBits_N[179])
	);

	LHQD1 Inst_frame7_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[178]),
	.QN(ConfigBits_N[178])
	);

	LHQD1 Inst_frame7_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[177]),
	.QN(ConfigBits_N[177])
	);

	LHQD1 Inst_frame7_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[176]),
	.QN(ConfigBits_N[176])
	);

	LHQD1 Inst_frame7_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[175]),
	.QN(ConfigBits_N[175])
	);

	LHQD1 Inst_frame7_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[174]),
	.QN(ConfigBits_N[174])
	);

	LHQD1 Inst_frame7_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[173]),
	.QN(ConfigBits_N[173])
	);

	LHQD1 Inst_frame7_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[172]),
	.QN(ConfigBits_N[172])
	);

	LHQD1 Inst_frame7_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[171]),
	.QN(ConfigBits_N[171])
	);

	LHQD1 Inst_frame7_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[170]),
	.QN(ConfigBits_N[170])
	);

	LHQD1 Inst_frame7_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[169]),
	.QN(ConfigBits_N[169])
	);

	LHQD1 Inst_frame7_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[168]),
	.QN(ConfigBits_N[168])
	);

	LHQD1 Inst_frame7_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[167]),
	.QN(ConfigBits_N[167])
	);

	LHQD1 Inst_frame7_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[166]),
	.QN(ConfigBits_N[166])
	);

	LHQD1 Inst_frame7_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[165]),
	.QN(ConfigBits_N[165])
	);

	LHQD1 Inst_frame7_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[164]),
	.QN(ConfigBits_N[164])
	);

	LHQD1 Inst_frame7_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[163]),
	.QN(ConfigBits_N[163])
	);

	LHQD1 Inst_frame7_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[162]),
	.QN(ConfigBits_N[162])
	);

	LHQD1 Inst_frame7_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[161]),
	.QN(ConfigBits_N[161])
	);

	LHQD1 Inst_frame7_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[160]),
	.QN(ConfigBits_N[160])
	);

	LHQD1 Inst_frame7_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[159]),
	.QN(ConfigBits_N[159])
	);

	LHQD1 Inst_frame7_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[158]),
	.QN(ConfigBits_N[158])
	);

	LHQD1 Inst_frame7_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[157]),
	.QN(ConfigBits_N[157])
	);

	LHQD1 Inst_frame7_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[156]),
	.QN(ConfigBits_N[156])
	);

	LHQD1 Inst_frame7_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[155]),
	.QN(ConfigBits_N[155])
	);

	LHQD1 Inst_frame7_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[154]),
	.QN(ConfigBits_N[154])
	);

	LHQD1 Inst_frame7_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[153]),
	.QN(ConfigBits_N[153])
	);

	LHQD1 Inst_frame7_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[152]),
	.QN(ConfigBits_N[152])
	);

	LHQD1 Inst_frame7_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[151]),
	.QN(ConfigBits_N[151])
	);

	LHQD1 Inst_frame7_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[7]),
	.Q(ConfigBits[150]),
	.QN(ConfigBits_N[150])
	);

	LHQD1 Inst_frame8_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[149]),
	.QN(ConfigBits_N[149])
	);

	LHQD1 Inst_frame8_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[148]),
	.QN(ConfigBits_N[148])
	);

	LHQD1 Inst_frame8_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[147]),
	.QN(ConfigBits_N[147])
	);

	LHQD1 Inst_frame8_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[146]),
	.QN(ConfigBits_N[146])
	);

	LHQD1 Inst_frame8_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[145]),
	.QN(ConfigBits_N[145])
	);

	LHQD1 Inst_frame8_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[144]),
	.QN(ConfigBits_N[144])
	);

	LHQD1 Inst_frame8_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[143]),
	.QN(ConfigBits_N[143])
	);

	LHQD1 Inst_frame8_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[142]),
	.QN(ConfigBits_N[142])
	);

	LHQD1 Inst_frame8_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[141]),
	.QN(ConfigBits_N[141])
	);

	LHQD1 Inst_frame8_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[140]),
	.QN(ConfigBits_N[140])
	);

	LHQD1 Inst_frame8_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[139]),
	.QN(ConfigBits_N[139])
	);

	LHQD1 Inst_frame8_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[138]),
	.QN(ConfigBits_N[138])
	);

	LHQD1 Inst_frame8_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[137]),
	.QN(ConfigBits_N[137])
	);

	LHQD1 Inst_frame8_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[136]),
	.QN(ConfigBits_N[136])
	);

	LHQD1 Inst_frame8_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[135]),
	.QN(ConfigBits_N[135])
	);

	LHQD1 Inst_frame8_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[134]),
	.QN(ConfigBits_N[134])
	);

	LHQD1 Inst_frame8_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[133]),
	.QN(ConfigBits_N[133])
	);

	LHQD1 Inst_frame8_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[132]),
	.QN(ConfigBits_N[132])
	);

	LHQD1 Inst_frame8_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[131]),
	.QN(ConfigBits_N[131])
	);

	LHQD1 Inst_frame8_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[130]),
	.QN(ConfigBits_N[130])
	);

	LHQD1 Inst_frame8_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[129]),
	.QN(ConfigBits_N[129])
	);

	LHQD1 Inst_frame8_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[128]),
	.QN(ConfigBits_N[128])
	);

	LHQD1 Inst_frame8_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[127]),
	.QN(ConfigBits_N[127])
	);

	LHQD1 Inst_frame8_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[126]),
	.QN(ConfigBits_N[126])
	);

	LHQD1 Inst_frame8_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[125]),
	.QN(ConfigBits_N[125])
	);

	LHQD1 Inst_frame8_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[124]),
	.QN(ConfigBits_N[124])
	);

	LHQD1 Inst_frame8_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[123]),
	.QN(ConfigBits_N[123])
	);

	LHQD1 Inst_frame8_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[122]),
	.QN(ConfigBits_N[122])
	);

	LHQD1 Inst_frame8_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[121]),
	.QN(ConfigBits_N[121])
	);

	LHQD1 Inst_frame8_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[120]),
	.QN(ConfigBits_N[120])
	);

	LHQD1 Inst_frame8_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[119]),
	.QN(ConfigBits_N[119])
	);

	LHQD1 Inst_frame8_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[8]),
	.Q(ConfigBits[118]),
	.QN(ConfigBits_N[118])
	);

	LHQD1 Inst_frame9_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[117]),
	.QN(ConfigBits_N[117])
	);

	LHQD1 Inst_frame9_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[116]),
	.QN(ConfigBits_N[116])
	);

	LHQD1 Inst_frame9_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[115]),
	.QN(ConfigBits_N[115])
	);

	LHQD1 Inst_frame9_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[114]),
	.QN(ConfigBits_N[114])
	);

	LHQD1 Inst_frame9_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[113]),
	.QN(ConfigBits_N[113])
	);

	LHQD1 Inst_frame9_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[112]),
	.QN(ConfigBits_N[112])
	);

	LHQD1 Inst_frame9_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[111]),
	.QN(ConfigBits_N[111])
	);

	LHQD1 Inst_frame9_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[110]),
	.QN(ConfigBits_N[110])
	);

	LHQD1 Inst_frame9_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[109]),
	.QN(ConfigBits_N[109])
	);

	LHQD1 Inst_frame9_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[108]),
	.QN(ConfigBits_N[108])
	);

	LHQD1 Inst_frame9_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[107]),
	.QN(ConfigBits_N[107])
	);

	LHQD1 Inst_frame9_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[106]),
	.QN(ConfigBits_N[106])
	);

	LHQD1 Inst_frame9_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[105]),
	.QN(ConfigBits_N[105])
	);

	LHQD1 Inst_frame9_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[104]),
	.QN(ConfigBits_N[104])
	);

	LHQD1 Inst_frame9_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[103]),
	.QN(ConfigBits_N[103])
	);

	LHQD1 Inst_frame9_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[102]),
	.QN(ConfigBits_N[102])
	);

	LHQD1 Inst_frame9_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[101]),
	.QN(ConfigBits_N[101])
	);

	LHQD1 Inst_frame9_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[100]),
	.QN(ConfigBits_N[100])
	);

	LHQD1 Inst_frame9_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[99]),
	.QN(ConfigBits_N[99])
	);

	LHQD1 Inst_frame9_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[98]),
	.QN(ConfigBits_N[98])
	);

	LHQD1 Inst_frame9_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[97]),
	.QN(ConfigBits_N[97])
	);

	LHQD1 Inst_frame9_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[96]),
	.QN(ConfigBits_N[96])
	);

	LHQD1 Inst_frame9_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[95]),
	.QN(ConfigBits_N[95])
	);

	LHQD1 Inst_frame9_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[94]),
	.QN(ConfigBits_N[94])
	);

	LHQD1 Inst_frame9_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[93]),
	.QN(ConfigBits_N[93])
	);

	LHQD1 Inst_frame9_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[92]),
	.QN(ConfigBits_N[92])
	);

	LHQD1 Inst_frame9_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[91]),
	.QN(ConfigBits_N[91])
	);

	LHQD1 Inst_frame9_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[90]),
	.QN(ConfigBits_N[90])
	);

	LHQD1 Inst_frame9_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[89]),
	.QN(ConfigBits_N[89])
	);

	LHQD1 Inst_frame9_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[88]),
	.QN(ConfigBits_N[88])
	);

	LHQD1 Inst_frame9_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[87]),
	.QN(ConfigBits_N[87])
	);

	LHQD1 Inst_frame9_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[9]),
	.Q(ConfigBits[86]),
	.QN(ConfigBits_N[86])
	);

	LHQD1 Inst_frame10_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[85]),
	.QN(ConfigBits_N[85])
	);

	LHQD1 Inst_frame10_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[84]),
	.QN(ConfigBits_N[84])
	);

	LHQD1 Inst_frame10_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[83]),
	.QN(ConfigBits_N[83])
	);

	LHQD1 Inst_frame10_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[82]),
	.QN(ConfigBits_N[82])
	);

	LHQD1 Inst_frame10_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[81]),
	.QN(ConfigBits_N[81])
	);

	LHQD1 Inst_frame10_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[80]),
	.QN(ConfigBits_N[80])
	);

	LHQD1 Inst_frame10_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[79]),
	.QN(ConfigBits_N[79])
	);

	LHQD1 Inst_frame10_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[78]),
	.QN(ConfigBits_N[78])
	);

	LHQD1 Inst_frame10_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[77]),
	.QN(ConfigBits_N[77])
	);

	LHQD1 Inst_frame10_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[76]),
	.QN(ConfigBits_N[76])
	);

	LHQD1 Inst_frame10_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[75]),
	.QN(ConfigBits_N[75])
	);

	LHQD1 Inst_frame10_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[74]),
	.QN(ConfigBits_N[74])
	);

	LHQD1 Inst_frame10_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[73]),
	.QN(ConfigBits_N[73])
	);

	LHQD1 Inst_frame10_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[72]),
	.QN(ConfigBits_N[72])
	);

	LHQD1 Inst_frame10_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[71]),
	.QN(ConfigBits_N[71])
	);

	LHQD1 Inst_frame10_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[70]),
	.QN(ConfigBits_N[70])
	);

	LHQD1 Inst_frame10_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[69]),
	.QN(ConfigBits_N[69])
	);

	LHQD1 Inst_frame10_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[68]),
	.QN(ConfigBits_N[68])
	);

	LHQD1 Inst_frame10_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[67]),
	.QN(ConfigBits_N[67])
	);

	LHQD1 Inst_frame10_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[66]),
	.QN(ConfigBits_N[66])
	);

	LHQD1 Inst_frame10_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[65]),
	.QN(ConfigBits_N[65])
	);

	LHQD1 Inst_frame10_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[64]),
	.QN(ConfigBits_N[64])
	);

	LHQD1 Inst_frame10_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[63]),
	.QN(ConfigBits_N[63])
	);

	LHQD1 Inst_frame10_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[62]),
	.QN(ConfigBits_N[62])
	);

	LHQD1 Inst_frame10_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[61]),
	.QN(ConfigBits_N[61])
	);

	LHQD1 Inst_frame10_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[60]),
	.QN(ConfigBits_N[60])
	);

	LHQD1 Inst_frame10_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[59]),
	.QN(ConfigBits_N[59])
	);

	LHQD1 Inst_frame10_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[58]),
	.QN(ConfigBits_N[58])
	);

	LHQD1 Inst_frame10_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[57]),
	.QN(ConfigBits_N[57])
	);

	LHQD1 Inst_frame10_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[56]),
	.QN(ConfigBits_N[56])
	);

	LHQD1 Inst_frame10_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[55]),
	.QN(ConfigBits_N[55])
	);

	LHQD1 Inst_frame10_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[10]),
	.Q(ConfigBits[54]),
	.QN(ConfigBits_N[54])
	);

	LHQD1 Inst_frame11_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[53]),
	.QN(ConfigBits_N[53])
	);

	LHQD1 Inst_frame11_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[52]),
	.QN(ConfigBits_N[52])
	);

	LHQD1 Inst_frame11_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[51]),
	.QN(ConfigBits_N[51])
	);

	LHQD1 Inst_frame11_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[50]),
	.QN(ConfigBits_N[50])
	);

	LHQD1 Inst_frame11_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[49]),
	.QN(ConfigBits_N[49])
	);

	LHQD1 Inst_frame11_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[48]),
	.QN(ConfigBits_N[48])
	);

	LHQD1 Inst_frame11_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[47]),
	.QN(ConfigBits_N[47])
	);

	LHQD1 Inst_frame11_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[46]),
	.QN(ConfigBits_N[46])
	);

	LHQD1 Inst_frame11_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[45]),
	.QN(ConfigBits_N[45])
	);

	LHQD1 Inst_frame11_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[44]),
	.QN(ConfigBits_N[44])
	);

	LHQD1 Inst_frame11_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[43]),
	.QN(ConfigBits_N[43])
	);

	LHQD1 Inst_frame11_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[42]),
	.QN(ConfigBits_N[42])
	);

	LHQD1 Inst_frame11_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[41]),
	.QN(ConfigBits_N[41])
	);

	LHQD1 Inst_frame11_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[40]),
	.QN(ConfigBits_N[40])
	);

	LHQD1 Inst_frame11_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[39]),
	.QN(ConfigBits_N[39])
	);

	LHQD1 Inst_frame11_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[38]),
	.QN(ConfigBits_N[38])
	);

	LHQD1 Inst_frame11_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[37]),
	.QN(ConfigBits_N[37])
	);

	LHQD1 Inst_frame11_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[36]),
	.QN(ConfigBits_N[36])
	);

	LHQD1 Inst_frame11_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[35]),
	.QN(ConfigBits_N[35])
	);

	LHQD1 Inst_frame11_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[34]),
	.QN(ConfigBits_N[34])
	);

	LHQD1 Inst_frame11_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[33]),
	.QN(ConfigBits_N[33])
	);

	LHQD1 Inst_frame11_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[32]),
	.QN(ConfigBits_N[32])
	);

	LHQD1 Inst_frame11_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[31]),
	.QN(ConfigBits_N[31])
	);

	LHQD1 Inst_frame11_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[30]),
	.QN(ConfigBits_N[30])
	);

	LHQD1 Inst_frame11_bit7(
	.D(FrameData[7]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[29]),
	.QN(ConfigBits_N[29])
	);

	LHQD1 Inst_frame11_bit6(
	.D(FrameData[6]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[28]),
	.QN(ConfigBits_N[28])
	);

	LHQD1 Inst_frame11_bit5(
	.D(FrameData[5]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[27]),
	.QN(ConfigBits_N[27])
	);

	LHQD1 Inst_frame11_bit4(
	.D(FrameData[4]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[26]),
	.QN(ConfigBits_N[26])
	);

	LHQD1 Inst_frame11_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[25]),
	.QN(ConfigBits_N[25])
	);

	LHQD1 Inst_frame11_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[24]),
	.QN(ConfigBits_N[24])
	);

	LHQD1 Inst_frame11_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[23]),
	.QN(ConfigBits_N[23])
	);

	LHQD1 Inst_frame11_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[11]),
	.Q(ConfigBits[22]),
	.QN(ConfigBits_N[22])
	);

	LHQD1 Inst_frame12_bit31(
	.D(FrameData[31]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[21]),
	.QN(ConfigBits_N[21])
	);

	LHQD1 Inst_frame12_bit30(
	.D(FrameData[30]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[20]),
	.QN(ConfigBits_N[20])
	);

	LHQD1 Inst_frame12_bit29(
	.D(FrameData[29]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[19]),
	.QN(ConfigBits_N[19])
	);

	LHQD1 Inst_frame12_bit28(
	.D(FrameData[28]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[18]),
	.QN(ConfigBits_N[18])
	);

	LHQD1 Inst_frame12_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[17]),
	.QN(ConfigBits_N[17])
	);

	LHQD1 Inst_frame12_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[16]),
	.QN(ConfigBits_N[16])
	);

	LHQD1 Inst_frame12_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[15]),
	.QN(ConfigBits_N[15])
	);

	LHQD1 Inst_frame12_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[14]),
	.QN(ConfigBits_N[14])
	);

	LHQD1 Inst_frame12_bit23(
	.D(FrameData[23]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[13]),
	.QN(ConfigBits_N[13])
	);

	LHQD1 Inst_frame12_bit22(
	.D(FrameData[22]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[12]),
	.QN(ConfigBits_N[12])
	);

	LHQD1 Inst_frame12_bit21(
	.D(FrameData[21]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[11]),
	.QN(ConfigBits_N[11])
	);

	LHQD1 Inst_frame12_bit20(
	.D(FrameData[20]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[10]),
	.QN(ConfigBits_N[10])
	);

	LHQD1 Inst_frame12_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[9]),
	.QN(ConfigBits_N[9])
	);

	LHQD1 Inst_frame12_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[8]),
	.QN(ConfigBits_N[8])
	);

	LHQD1 Inst_frame12_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[7]),
	.QN(ConfigBits_N[7])
	);

	LHQD1 Inst_frame12_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[6]),
	.QN(ConfigBits_N[6])
	);

	LHQD1 Inst_frame12_bit15(
	.D(FrameData[15]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[5]),
	.QN(ConfigBits_N[5])
	);

	LHQD1 Inst_frame12_bit14(
	.D(FrameData[14]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[4]),
	.QN(ConfigBits_N[4])
	);

	LHQD1 Inst_frame12_bit13(
	.D(FrameData[13]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[3]),
	.QN(ConfigBits_N[3])
	);

	LHQD1 Inst_frame12_bit12(
	.D(FrameData[12]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[2]),
	.QN(ConfigBits_N[2])
	);

	LHQD1 Inst_frame12_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[1]),
	.QN(ConfigBits_N[1])
	);

	LHQD1 Inst_frame12_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[12]),
	.Q(ConfigBits[0]),
	.QN(ConfigBits_N[0])
	);

endmodule
