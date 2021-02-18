`timescale 1ps/1ps

module N_term_single2_ConfigMem (FrameData, FrameStrobe, ConfigBits);
	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter NoConfigBits = 0;
	input [FrameBitsPerRow-1:0] FrameData;
	input [MaxFramesPerCol-1:0] FrameStrobe;
	output [NoConfigBits-1:0] ConfigBits;

//instantiate frame latches
endmodule
