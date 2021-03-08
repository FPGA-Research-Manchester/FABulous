//NumberOfConfigBits:12
module W_IO_switch_matrix (W1END0, W1END1, W1END2, W1END3, W2MID0, W2MID1, W2MID2, W2MID3, W2MID4, W2MID5, W2MID6, W2MID7, W2END0, W2END1, W2END2, W2END3, W2END4, W2END5, W2END6, W2END7, W6END0, W6END1, W6END2, W6END3, W6END4, W6END5, W6END6, W6END7, W6END8, W6END9, W6END10, W6END11, A_O, A_Q, B_O, B_Q, E1BEG0, E1BEG1, E1BEG2, E1BEG3, E2BEG0, E2BEG1, E2BEG2, E2BEG3, E2BEG4, E2BEG5, E2BEG6, E2BEG7, E2BEGb0, E2BEGb1, E2BEGb2, E2BEGb3, E2BEGb4, E2BEGb5, E2BEGb6, E2BEGb7, E6BEG0, E6BEG1, E6BEG2, E6BEG3, E6BEG4, E6BEG5, E6BEG6, E6BEG7, E6BEG8, E6BEG9, E6BEG10, E6BEG11, A_I, A_T, B_I, B_T, ConfigBits);
	parameter NoConfigBits = 12;
	 // switch matrix inputs
	input W1END0;
	input W1END1;
	input W1END2;
	input W1END3;
	input W2MID0;
	input W2MID1;
	input W2MID2;
	input W2MID3;
	input W2MID4;
	input W2MID5;
	input W2MID6;
	input W2MID7;
	input W2END0;
	input W2END1;
	input W2END2;
	input W2END3;
	input W2END4;
	input W2END5;
	input W2END6;
	input W2END7;
	input W6END0;
	input W6END1;
	input W6END2;
	input W6END3;
	input W6END4;
	input W6END5;
	input W6END6;
	input W6END7;
	input W6END8;
	input W6END9;
	input W6END10;
	input W6END11;
	input A_O;
	input A_Q;
	input B_O;
	input B_Q;
	output E1BEG0;
	output E1BEG1;
	output E1BEG2;
	output E1BEG3;
	output E2BEG0;
	output E2BEG1;
	output E2BEG2;
	output E2BEG3;
	output E2BEG4;
	output E2BEG5;
	output E2BEG6;
	output E2BEG7;
	output E2BEGb0;
	output E2BEGb1;
	output E2BEGb2;
	output E2BEGb3;
	output E2BEGb4;
	output E2BEGb5;
	output E2BEGb6;
	output E2BEGb7;
	output E6BEG0;
	output E6BEG1;
	output E6BEG2;
	output E6BEG3;
	output E6BEG4;
	output E6BEG5;
	output E6BEG6;
	output E6BEG7;
	output E6BEG8;
	output E6BEG9;
	output E6BEG10;
	output E6BEG11;
	output A_I;
	output A_T;
	output B_I;
	output B_T;
	//global
	input [NoConfigBits-1:0] ConfigBits;

	parameter GND0 = 1'b0;
	parameter GND = 1'b0;
	parameter VCC0 = 1'b1;
	parameter VCC = 1'b1;
	parameter VDD0 = 1'b1;
	parameter VDD = 1'b1;
	
	wire [1 -1:0]E1BEG0_input;
	wire [1 -1:0]E1BEG1_input;
	wire [1 -1:0]E1BEG2_input;
	wire [1 -1:0]E1BEG3_input;
	wire [1 -1:0]E2BEG0_input;
	wire [1 -1:0]E2BEG1_input;
	wire [1 -1:0]E2BEG2_input;
	wire [1 -1:0]E2BEG3_input;
	wire [1 -1:0]E2BEG4_input;
	wire [1 -1:0]E2BEG5_input;
	wire [1 -1:0]E2BEG6_input;
	wire [1 -1:0]E2BEG7_input;
	wire [1 -1:0]E2BEGb0_input;
	wire [1 -1:0]E2BEGb1_input;
	wire [1 -1:0]E2BEGb2_input;
	wire [1 -1:0]E2BEGb3_input;
	wire [1 -1:0]E2BEGb4_input;
	wire [1 -1:0]E2BEGb5_input;
	wire [1 -1:0]E2BEGb6_input;
	wire [1 -1:0]E2BEGb7_input;
	wire [1 -1:0]E6BEG0_input;
	wire [1 -1:0]E6BEG1_input;
	wire [1 -1:0]E6BEG2_input;
	wire [1 -1:0]E6BEG3_input;
	wire [1 -1:0]E6BEG4_input;
	wire [1 -1:0]E6BEG5_input;
	wire [1 -1:0]E6BEG6_input;
	wire [1 -1:0]E6BEG7_input;
	wire [1 -1:0]E6BEG8_input;
	wire [1 -1:0]E6BEG9_input;
	wire [1 -1:0]E6BEG10_input;
	wire [1 -1:0]E6BEG11_input;
	wire [16 -1:0]A_I_input;
	wire [4 -1:0]A_T_input;
	wire [16 -1:0]B_I_input;
	wire [4 -1:0]B_T_input;

	wire [4-1:0] DEBUG_select_A_I;
	wire [2-1:0] DEBUG_select_A_T;
	wire [4-1:0] DEBUG_select_B_I;
	wire [2-1:0] DEBUG_select_B_T;

// The configuration bits (if any) are just a long shift register

// This shift register is padded to an even number of flops/latches
// switch matrix multiplexer  E1BEG0 		MUX-1
	assign E1BEG0 = A_O;
// switch matrix multiplexer  E1BEG1 		MUX-1
	assign E1BEG1 = A_Q;
// switch matrix multiplexer  E1BEG2 		MUX-1
	assign E1BEG2 = B_O;
// switch matrix multiplexer  E1BEG3 		MUX-1
	assign E1BEG3 = B_Q;
// switch matrix multiplexer  E2BEG0 		MUX-1
	assign E2BEG0 = W2MID7;
// switch matrix multiplexer  E2BEG1 		MUX-1
	assign E2BEG1 = W2MID6;
// switch matrix multiplexer  E2BEG2 		MUX-1
	assign E2BEG2 = W2MID5;
// switch matrix multiplexer  E2BEG3 		MUX-1
	assign E2BEG3 = W2MID4;
// switch matrix multiplexer  E2BEG4 		MUX-1
	assign E2BEG4 = W2MID3;
// switch matrix multiplexer  E2BEG5 		MUX-1
	assign E2BEG5 = W2MID2;
// switch matrix multiplexer  E2BEG6 		MUX-1
	assign E2BEG6 = W2MID1;
// switch matrix multiplexer  E2BEG7 		MUX-1
	assign E2BEG7 = W2MID0;
// switch matrix multiplexer  E2BEGb0 		MUX-1
	assign E2BEGb0 = W2END7;
// switch matrix multiplexer  E2BEGb1 		MUX-1
	assign E2BEGb1 = W2END6;
// switch matrix multiplexer  E2BEGb2 		MUX-1
	assign E2BEGb2 = W2END5;
// switch matrix multiplexer  E2BEGb3 		MUX-1
	assign E2BEGb3 = W2END4;
// switch matrix multiplexer  E2BEGb4 		MUX-1
	assign E2BEGb4 = W2END3;
// switch matrix multiplexer  E2BEGb5 		MUX-1
	assign E2BEGb5 = W2END2;
// switch matrix multiplexer  E2BEGb6 		MUX-1
	assign E2BEGb6 = W2END1;
// switch matrix multiplexer  E2BEGb7 		MUX-1
	assign E2BEGb7 = W2END0;
// switch matrix multiplexer  E6BEG0 		MUX-1
	assign E6BEG0 = A_O;
// switch matrix multiplexer  E6BEG1 		MUX-1
	assign E6BEG1 = B_O;
// switch matrix multiplexer  E6BEG2 		MUX-1
	assign E6BEG2 = A_O;
// switch matrix multiplexer  E6BEG3 		MUX-1
	assign E6BEG3 = B_O;
// switch matrix multiplexer  E6BEG4 		MUX-1
	assign E6BEG4 = A_O;
// switch matrix multiplexer  E6BEG5 		MUX-1
	assign E6BEG5 = B_O;
// switch matrix multiplexer  E6BEG6 		MUX-1
	assign E6BEG6 = A_Q;
// switch matrix multiplexer  E6BEG7 		MUX-1
	assign E6BEG7 = B_Q;
// switch matrix multiplexer  E6BEG8 		MUX-1
	assign E6BEG8 = A_Q;
// switch matrix multiplexer  E6BEG9 		MUX-1
	assign E6BEG9 = B_Q;
// switch matrix multiplexer  E6BEG10 		MUX-1
	assign E6BEG10 = A_Q;
// switch matrix multiplexer  E6BEG11 		MUX-1
	assign E6BEG11 = B_Q;
// switch matrix multiplexer  A_I 		MUX-16
	assign A_I_input = {W2END7,W2END6,W2END5,W2END4,W2END3,W2END2,W2END1,W2END0,W2MID7,W2MID6,W2MID5,W2MID4,W2MID3,W2MID2,W2MID1,W2MID0};
	assign A_I = A_I_input[ConfigBits[3:0]];
 
// switch matrix multiplexer  A_T 		MUX-4
	assign A_T_input = {VCC0,GND0,W2END0,W2MID7};
	assign A_T = A_T_input[ConfigBits[5:4]];
 
// switch matrix multiplexer  B_I 		MUX-16
	assign B_I_input = {W2END7,W2END6,W2END5,W2END4,W2END3,W2END2,W2END1,W2END0,W2MID7,W2MID6,W2MID5,W2MID4,W2MID3,W2MID2,W2MID1,W2MID0};
	assign B_I = B_I_input[ConfigBits[9:6]];
 
// switch matrix multiplexer  B_T 		MUX-4
	assign B_T_input = {VCC0,GND0,W2END0,W2MID7};
	assign B_T = B_T_input[ConfigBits[11:10]];
 
	assign DEBUG_select_A_I = ConfigBits[3:0];
	assign DEBUG_select_A_T = ConfigBits[5:4];
	assign DEBUG_select_B_I = ConfigBits[9:6];
	assign DEBUG_select_B_T = ConfigBits[11:10];

endmodule
