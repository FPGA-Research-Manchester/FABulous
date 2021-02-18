`timescale 1ps/1ps

module W_IO_ConfigMem (FrameData, FrameStrobe, ConfigBits);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 12;
	input [FrameBitsPerRow-1:0] FrameData;
	input [MaxFramesPerCol-1:0] FrameStrobe;
	output [NoConfigBits-1:0] ConfigBits;
	wire [12-1:0] frame0;

//instantiate frame latches
	LHQD1 Inst_frame0_bit27(
	.D(FrameData[27]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[3])
	);

	LHQD1 Inst_frame0_bit26(
	.D(FrameData[26]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[2])
	);

	LHQD1 Inst_frame0_bit25(
	.D(FrameData[25]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[1])
	);

	LHQD1 Inst_frame0_bit24(
	.D(FrameData[24]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[0])
	);

	LHQD1 Inst_frame0_bit19(
	.D(FrameData[19]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[9])
	);

	LHQD1 Inst_frame0_bit18(
	.D(FrameData[18]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[8])
	);

	LHQD1 Inst_frame0_bit17(
	.D(FrameData[17]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[7])
	);

	LHQD1 Inst_frame0_bit16(
	.D(FrameData[16]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[6])
	);

	LHQD1 Inst_frame0_bit9(
	.D(FrameData[9]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[5])
	);

	LHQD1 Inst_frame0_bit8(
	.D(FrameData[8]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[4])
	);

	LHQD1 Inst_frame0_bit1(
	.D(FrameData[1]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[11])
	);

	LHQD1 Inst_frame0_bit0(
	.D(FrameData[0]),
	.E(FrameStrobe[0]),
	.Q(ConfigBits[10])
	);

endmodule
