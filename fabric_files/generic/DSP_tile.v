module DSP (top_N1BEG, top_N2BEG, top_N2BEGb, top_N4BEG, top_NN4BEG, top_S1END, top_S2MID, top_S2END, top_S4END, top_SS4END, top_E1BEG, top_E2BEG, top_E2BEGb, top_EE4BEG, top_E6BEG, top_E1END, top_E2MID, top_E2END, top_EE4END, top_E6END, top_W1BEG, top_W2BEG, top_W2BEGb, top_WW4BEG, top_W6BEG, top_W1END, top_W2MID, top_W2END, top_WW4END, top_W6END, bot_E1BEG, bot_E2BEG, bot_E2BEGb, bot_EE4BEG, bot_E6BEG, bot_E1END, bot_E2MID, bot_E2END, bot_EE4END, bot_E6END, bot_W1BEG, bot_W2BEG, bot_W2BEGb, bot_WW4BEG, bot_W6BEG, bot_W1END, bot_W2MID, bot_W2END, bot_WW4END, bot_W6END, bot_S1BEG, bot_S2BEG, bot_S2BEGb, bot_S4BEG, bot_SS4BEG, bot_N1END, bot_N2MID, bot_N2END, bot_N4END, bot_NN4END, UserCLK,
`ifdef EMULATION_MODE
	top_Bitstream, bot_Bitstream
`else
	top_FrameData, top_FrameData_O, bot_FrameData, bot_FrameData_O, FrameStrobe, FrameStrobe_O
`endif
	);

	parameter MaxFramesPerCol = 20;
	parameter FrameBitsPerRow = 32;
	parameter top_NoConfigBits = 406;  // NOT 100% SURE HOW THIS WILL WORK OUT
	parameter bot_NoConfigBits = 416;  // NOT 100% SURE HOW THIS WILL WORK OUT
	
	//top_NORTH
	output [3:0] top_N1BEG;	 // wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	output [7:0] top_N2BEG;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	output [7:0] top_N2BEGb;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	output [15:0] top_N4BEG;	 // wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	output [15:0] top_NN4BEG;	 // wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	// These do not exist in top wrapper		 top_bot2top[9:0];	 // wires:10 X_offset:0 Y_offset:1  source_name:bot2top destination_name:NULL  
	// These do not exist in top wrapper	input [3:0] top_N1END;	 // wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	// These do not exist in top wrapper	input [7:0] top_N2MID;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	// These do not exist in top wrapper	input [7:0] top_N2END;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	// These do not exist in top wrapper	input [15:0] top_N4END;	 // wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	// These do not exist in top wrapper	input [15:0] top_NN4END;	 // wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	
	//top_SOUTH
	// These do not exist in top wrapper		 top_S1BEG[3:0];	 // wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	// These do not exist in top wrapper		 top_S2BEG[7:0];	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	// These do not exist in top wrapper		 top_S2BEGb[7:0];	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	// These do not exist in top wrapper		 top_S4BEG[15:0];	 // wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	// These do not exist in top wrapper		 top_SS4BEG[15:0];	 // wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	input [3:0] top_S1END;	 // wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	input [7:0] top_S2MID;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	input [7:0] top_S2END;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	input [15:0] top_S4END;	 // wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	input [15:0] top_SS4END;	 // wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	// These do not exist in top wrapper		 top_top2bot[17:0];	 // wires:18 X_offset:0 Y_offset:-1  source_name:NULL destination_name:top2bot  
	
	//top_EAST
	output [3:0] top_E1BEG;	 // wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	output [7:0] top_E2BEG;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	output [7:0] top_E2BEGb;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	output [15:0] top_EE4BEG;	 // wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	output [11:0] top_E6BEG;	 // wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	input [3:0] top_E1END;	 // wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	input [7:0] top_E2MID;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	input [7:0] top_E2END;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	input [15:0] top_EE4END;	 // wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	input [11:0] top_E6END;	 // wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	
	//top_WEST
	output [3:0] top_W1BEG;	 // wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	output [7:0] top_W2BEG;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	output [7:0] top_W2BEGb;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	output [15:0] top_WW4BEG;	 // wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	output [11:0] top_W6BEG;	 // wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	input [3:0] top_W1END;	 // wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	input [7:0] top_W2MID;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	input [7:0] top_W2END;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	input [15:0] top_WW4END;	 // wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	input [11:0] top_W6END;	 // wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	
	//bot_NORTH
	// These do not exist in top wrapper	output [3:0] bot_N1BEG;	 // wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	// These do not exist in top wrapper	output [7:0] bot_N2BEG;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	// These do not exist in top wrapper	output [7:0] bot_N2BEGb;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	// These do not exist in top wrapper	output [15:0] bot_N4BEG;	 // wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	// These do not exist in top wrapper	output [15:0] bot_NN4BEG;	 // wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	// These do not exist in top wrapper	// These do not exist in top wrapper		 bot_bot2top[9:0];	 // wires:10 X_offset:0 Y_offset:1  source_name:bot2top destination_name:NULL  
	input [3:0] bot_N1END;	 // wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
	input [7:0] bot_N2MID;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
	input [7:0] bot_N2END;	 // wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
	input [15:0] bot_N4END;	 // wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
	input [15:0] bot_NN4END;	 // wires:4 X_offset:0 Y_offset:4  source_name:NN4BEG destination_name:NN4END  
	
	//bot_SOUTH
	output [3:0] bot_S1BEG;	 // wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	output [7:0] bot_S2BEG;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	output [7:0] bot_S2BEGb;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	output [15:0] bot_S4BEG;	 // wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	output [15:0] bot_SS4BEG;	 // wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	// These do not exist in top wrapper	input [3:0] bot_S1END;	 // wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
	// These do not exist in top wrapper	input [7:0] bot_S2MID;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
	// These do not exist in top wrapper	input [7:0] bot_S2END;	 // wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
	// These do not exist in top wrapper	input [15:0] bot_S4END;	 // wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	// These do not exist in top wrapper	input [15:0] bot_SS4END;	 // wires:4 X_offset:0 Y_offset:-4  source_name:SS4BEG destination_name:SS4END  
	// These do not exist in top wrapper		 bot_top2bot[17:0];	 // wires:18 X_offset:0 Y_offset:-1  source_name:NULL destination_name:top2bot  

	//   bot_EAST
	output [3:0] bot_E1BEG;	 // wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	output [7:0] bot_E2BEG;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	output [7:0] bot_E2BEGb;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	output [15:0] bot_EE4BEG;	 // wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	output [11:0] bot_E6BEG;	 // wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	input [3:0] bot_E1END;	 // wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
	input [7:0] bot_E2MID;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
	input [7:0] bot_E2END;	 // wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
	input [15:0] bot_EE4END;	 // wires:4 X_offset:4 Y_offset:0  source_name:EE4BEG destination_name:EE4END  
	input [11:0] bot_E6END;	 // wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	
	//bot_WEST
	output [3:0] bot_W1BEG;	 // wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	output [7:0] bot_W2BEG;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	output [7:0] bot_W2BEGb;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	output [15:0] bot_WW4BEG;	 // wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	output [11:0] bot_W6BEG;	 // wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	input [3:0] bot_W1END;	 // wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
	input [7:0] bot_W2MID;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
	input [7:0] bot_W2END;	 // wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
	input [15:0] bot_WW4END;	 // wires:4 X_offset:-4 Y_offset:0  source_name:WW4BEG destination_name:WW4END  
	input [11:0] bot_W6END;	 // wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	
	// Tile IO ports from BELs
	input UserCLK; // EXTERNAL // SHARED_PORT // ## the EXTERNAL keyword will send this sisgnal all the way to top and the //SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)

`ifdef EMULATION_MODE
	input [MaxFramesPerCol*FrameBitsPerRow-1:0] top_Bitstream;
	input [MaxFramesPerCol*FrameBitsPerRow-1:0] bot_Bitstream;
`else
	input [FrameBitsPerRow-1:0] top_FrameData;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [FrameBitsPerRow-1:0] top_FrameData_O;
	input [FrameBitsPerRow-1:0] bot_FrameData;   // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
	output [FrameBitsPerRow-1:0] bot_FrameData_O;
	input [MaxFramesPerCol-1:0] FrameStrobe;    // CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 
	output [MaxFramesPerCol-1:0] FrameStrobe_O;
`endif

	
	// global

	// signal declarations
	
	wire [3:0] N1BEG;
	wire [7:0] N2BEG;
	wire [7:0] N2BEGb;
	wire [15:0] N4BEG;
	wire [15:0] NN4BEG;
	wire [9:0] bot2top;
	
	wire [3:0] S1BEG;
	wire [7:0] S2BEG;
	wire [7:0] S2BEGb;
	wire [15:0] S4BEG;
	wire [15:0] SS4BEG;
	wire [17:0] top2bot;
	
	wire [MaxFramesPerCol-1:0] bot2top_FrameStrobe;
	
	DSP_top Inst_DSP_top(
	.N1END(N1BEG),		// internal
	.N2MID(N2BEG),		// internal
	.N2END(N2BEGb),		// internal
	.N4END(N4BEG),		// internal
	.NN4END(NN4BEG),	// internal
	.bot2top(bot2top),	// internal
	.E1END(top_E1END),
	.E2MID(top_E2MID),
	.E2END(top_E2END),
	.EE4END(top_EE4END),
	.E6END(top_E6END),
	.S1END(top_S1END),
	.S2MID(top_S2MID),
	.S2END(top_S2END),
	.S4END(top_S4END),
	.SS4END(top_SS4END),
	.W1END(top_W1END),
	.W2MID(top_W2MID),
	.W2END(top_W2END),
	.WW4END(top_WW4END),
	.W6END(top_W6END),
	.N1BEG(top_N1BEG),
	.N2BEG(top_N2BEG),
	.N2BEGb(top_N2BEGb),
	.N4BEG(top_N4BEG),
	.NN4BEG(top_NN4BEG),
	.E1BEG(top_E1BEG),
	.E2BEG(top_E2BEG),
	.E2BEGb(top_E2BEGb),
	.EE4BEG(top_EE4BEG),
	.E6BEG(top_E6BEG),
	.S1BEG(S1BEG),		// internal
	.S2BEG(S2BEG),		// internal
	.S2BEGb(S2BEGb),	// internal
	.S4BEG(S4BEG),		// internal
	.SS4BEG(SS4BEG),	// internal
	.top2bot(top2bot),	// internal
	.W1BEG(top_W1BEG),
	.W2BEG(top_W2BEG),
	.W2BEGb(top_W2BEGb),
	.WW4BEG(top_WW4BEG),
	.W6BEG(top_W6BEG),
`ifdef EMULATION_MODE
	.Bitstream(top_Bitstream)
`else
	.FrameData(top_FrameData),
	.FrameData_O(top_FrameData_O),
	.FrameStrobe(bot2top_FrameStrobe),
	.FrameStrobe_O(FrameStrobe_O)
`endif
	); 

	DSP_bot Inst_DSP_bot(
	.N1END(bot_N1END),
	.N2MID(bot_N2MID),
	.N2END(bot_N2END),
	.N4END(bot_N4END),
	.NN4END(bot_NN4END),
	.E1END(bot_E1END),
	.E2MID(bot_E2MID),
	.E2END(bot_E2END),
	.EE4END(bot_EE4END),
	.E6END(bot_E6END),
	.S1END(S1BEG),		// internal
	.S2MID(S2BEG),		// internal
	.S2END(S2BEGb),		// internal
	.S4END(S4BEG),		// internal
	.SS4END(SS4BEG),	// internal
	.top2bot(top2bot),	// internal
	.W1END(bot_W1END),
	.W2MID(bot_W2MID),
	.W2END(bot_W2END),
	.WW4END(bot_WW4END),
	.W6END(bot_W6END),
	.N1BEG(N1BEG),		// internal
	.N2BEG(N2BEG),		// internal
	.N2BEGb(N2BEGb),	// internal
	.N4BEG(N4BEG),		// internal
	.NN4BEG(NN4BEG),	// internal
	.bot2top(bot2top),	// internal
	.E1BEG(bot_E1BEG),
	.E2BEG(bot_E2BEG),
	.E2BEGb(bot_E2BEGb),
	.EE4BEG(bot_EE4BEG),
	.E6BEG(bot_E6BEG),
	.S1BEG(bot_S1BEG),
	.S2BEG(bot_S2BEG),
	.S2BEGb(bot_S2BEGb),
	.S4BEG(bot_S4BEG),
	.SS4BEG(bot_SS4BEG),
	.W1BEG(bot_W1BEG),
	.W2BEG(bot_W2BEG),
	.W2BEGb(bot_W2BEGb),
	.WW4BEG(bot_WW4BEG),
	.W6BEG(bot_W6BEG),
	// tile IO port which gets directly connected to top-level tile entity
	.UserCLK(UserCLK),
`ifdef EMULATION_MODE
	.Bitstream(bot_Bitstream)
`else
	.FrameData(bot_FrameData),
	.FrameData_O(bot_FrameData_O),
	.FrameStrobe(FrameStrobe),
	.FrameStrobe_O(bot2top_FrameStrobe)
`endif
	);
	
endmodule