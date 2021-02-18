`timescale 1ps/1ps

module CPU_IO_ConfigMem (FrameData, FrameStrobe, ConfigBits);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 20;
	input [FrameBitsPerRow-1:0] FrameData;
	input [MaxFramesPerCol-1:0] FrameStrobe;
	output [NoConfigBits-1:0] ConfigBits;
	wire [8-1:0] frame0;
	wire [12-1:0] frame1;

//instantiate frame latches
	LHQD1 Inst_frame0_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[3])
	);

	LHQD1 Inst_frame0_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[2])
	);

	LHQD1 Inst_frame0_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[1])
	);

	LHQD1 Inst_frame0_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[0])
	);

	LHQD1 Inst_frame0_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[7])
	);

	LHQD1 Inst_frame0_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[6])
	);

	LHQD1 Inst_frame0_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[5])
	);

	LHQD1 Inst_frame0_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[4])
	);

	LHQD1 Inst_frame1_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[19])
	);

	LHQD1 Inst_frame1_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[18])
	);

	LHQD1 Inst_frame1_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[17])
	);

	LHQD1 Inst_frame1_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[16])
	);

	LHQD1 Inst_frame1_bit11(
	.D(FrameData[11]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[15])
	);

	LHQD1 Inst_frame1_bit10(
	.D(FrameData[10]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[14])
	);

	LHQD1 Inst_frame1_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[13])
	);

	LHQD1 Inst_frame1_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[12])
	);

	LHQD1 Inst_frame1_bit3(
	.D(FrameData[3]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[11])
	);

	LHQD1 Inst_frame1_bit2(
	.D(FrameData[2]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[10])
	);

	LHQD1 Inst_frame1_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[9])
	);

	LHQD1 Inst_frame1_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[1]),
	.Q(ConfigBits[8])
	);

endmodule
