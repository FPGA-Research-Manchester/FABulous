//NumberOfConfigBits:0
`timescale 1ps/1ps

module S_term_single2_switch_matrix (S1END0, S1END1, S1END2, S1END3, S2MID0, S2MID1, S2MID2, S2MID3, S2MID4, S2MID5, S2MID6, S2MID7, S2END0, S2END1, S2END2, S2END3, S2END4, S2END5, S2END6, S2END7, S4END0, S4END1, S4END2, S4END3, S4END4, S4END5, S4END6, S4END7, S4END8, S4END9, S4END10, S4END11, S4END12, S4END13, S4END14, S4END15, N1BEG0, N1BEG1, N1BEG2, N1BEG3, N2BEG0, N2BEG1, N2BEG2, N2BEG3, N2BEG4, N2BEG5, N2BEG6, N2BEG7, N2BEGb0, N2BEGb1, N2BEGb2, N2BEGb3, N2BEGb4, N2BEGb5, N2BEGb6, N2BEGb7, N4BEG0, N4BEG1, N4BEG2, N4BEG3, N4BEG4, N4BEG5, N4BEG6, N4BEG7, N4BEG8, N4BEG9, N4BEG10, N4BEG11, N4BEG12, N4BEG13, N4BEG14, N4BEG15);
	parameter NoConfigBits = 0;
	 // switch matrix inputs
	input S1END0;
	input S1END1;
	input S1END2;
	input S1END3;
	input S2MID0;
	input S2MID1;
	input S2MID2;
	input S2MID3;
	input S2MID4;
	input S2MID5;
	input S2MID6;
	input S2MID7;
	input S2END0;
	input S2END1;
	input S2END2;
	input S2END3;
	input S2END4;
	input S2END5;
	input S2END6;
	input S2END7;
	input S4END0;
	input S4END1;
	input S4END2;
	input S4END3;
	input S4END4;
	input S4END5;
	input S4END6;
	input S4END7;
	input S4END8;
	input S4END9;
	input S4END10;
	input S4END11;
	input S4END12;
	input S4END13;
	input S4END14;
	input S4END15;
	output N1BEG0;
	output N1BEG1;
	output N1BEG2;
	output N1BEG3;
	output N2BEG0;
	output N2BEG1;
	output N2BEG2;
	output N2BEG3;
	output N2BEG4;
	output N2BEG5;
	output N2BEG6;
	output N2BEG7;
	output N2BEGb0;
	output N2BEGb1;
	output N2BEGb2;
	output N2BEGb3;
	output N2BEGb4;
	output N2BEGb5;
	output N2BEGb6;
	output N2BEGb7;
	output N4BEG0;
	output N4BEG1;
	output N4BEG2;
	output N4BEG3;
	output N4BEG4;
	output N4BEG5;
	output N4BEG6;
	output N4BEG7;
	output N4BEG8;
	output N4BEG9;
	output N4BEG10;
	output N4BEG11;
	output N4BEG12;
	output N4BEG13;
	output N4BEG14;
	output N4BEG15;
	//global


	parameter GND0 = 1'b0;
	parameter GND = 1'b0;
	parameter VCC0 = 1'b1;
	parameter VCC = 1'b1;
	parameter VDD0 = 1'b1;
	parameter VDD = 1'b1;
	
	wire [1 -1:0]N1BEG0_input;
	wire [1 -1:0]N1BEG1_input;
	wire [1 -1:0]N1BEG2_input;
	wire [1 -1:0]N1BEG3_input;
	wire [1 -1:0]N2BEG0_input;
	wire [1 -1:0]N2BEG1_input;
	wire [1 -1:0]N2BEG2_input;
	wire [1 -1:0]N2BEG3_input;
	wire [1 -1:0]N2BEG4_input;
	wire [1 -1:0]N2BEG5_input;
	wire [1 -1:0]N2BEG6_input;
	wire [1 -1:0]N2BEG7_input;
	wire [1 -1:0]N2BEGb0_input;
	wire [1 -1:0]N2BEGb1_input;
	wire [1 -1:0]N2BEGb2_input;
	wire [1 -1:0]N2BEGb3_input;
	wire [1 -1:0]N2BEGb4_input;
	wire [1 -1:0]N2BEGb5_input;
	wire [1 -1:0]N2BEGb6_input;
	wire [1 -1:0]N2BEGb7_input;
	wire [1 -1:0]N4BEG0_input;
	wire [1 -1:0]N4BEG1_input;
	wire [1 -1:0]N4BEG2_input;
	wire [1 -1:0]N4BEG3_input;
	wire [1 -1:0]N4BEG4_input;
	wire [1 -1:0]N4BEG5_input;
	wire [1 -1:0]N4BEG6_input;
	wire [1 -1:0]N4BEG7_input;
	wire [1 -1:0]N4BEG8_input;
	wire [1 -1:0]N4BEG9_input;
	wire [1 -1:0]N4BEG10_input;
	wire [1 -1:0]N4BEG11_input;
	wire [1 -1:0]N4BEG12_input;
	wire [1 -1:0]N4BEG13_input;
	wire [1 -1:0]N4BEG14_input;
	wire [1 -1:0]N4BEG15_input;


// The configuration bits (if any) are just a long shift register

// This shift register is padded to an even number of flops/latches
// switch matrix multiplexer  N1BEG0 		MUX-1
	assign N1BEG0 = S1END3;
// switch matrix multiplexer  N1BEG1 		MUX-1
	assign N1BEG1 = S1END2;
// switch matrix multiplexer  N1BEG2 		MUX-1
	assign N1BEG2 = S1END1;
// switch matrix multiplexer  N1BEG3 		MUX-1
	assign N1BEG3 = S1END0;
// switch matrix multiplexer  N2BEG0 		MUX-1
	assign N2BEG0 = S2MID7;
// switch matrix multiplexer  N2BEG1 		MUX-1
	assign N2BEG1 = S2MID6;
// switch matrix multiplexer  N2BEG2 		MUX-1
	assign N2BEG2 = S2MID5;
// switch matrix multiplexer  N2BEG3 		MUX-1
	assign N2BEG3 = S2MID4;
// switch matrix multiplexer  N2BEG4 		MUX-1
	assign N2BEG4 = S2MID3;
// switch matrix multiplexer  N2BEG5 		MUX-1
	assign N2BEG5 = S2MID2;
// switch matrix multiplexer  N2BEG6 		MUX-1
	assign N2BEG6 = S2MID1;
// switch matrix multiplexer  N2BEG7 		MUX-1
	assign N2BEG7 = S2MID0;
// switch matrix multiplexer  N2BEGb0 		MUX-1
	assign N2BEGb0 = S2END7;
// switch matrix multiplexer  N2BEGb1 		MUX-1
	assign N2BEGb1 = S2END6;
// switch matrix multiplexer  N2BEGb2 		MUX-1
	assign N2BEGb2 = S2END5;
// switch matrix multiplexer  N2BEGb3 		MUX-1
	assign N2BEGb3 = S2END4;
// switch matrix multiplexer  N2BEGb4 		MUX-1
	assign N2BEGb4 = S2END3;
// switch matrix multiplexer  N2BEGb5 		MUX-1
	assign N2BEGb5 = S2END2;
// switch matrix multiplexer  N2BEGb6 		MUX-1
	assign N2BEGb6 = S2END1;
// switch matrix multiplexer  N2BEGb7 		MUX-1
	assign N2BEGb7 = S2END0;
// switch matrix multiplexer  N4BEG0 		MUX-1
	assign N4BEG0 = S4END15;
// switch matrix multiplexer  N4BEG1 		MUX-1
	assign N4BEG1 = S4END14;
// switch matrix multiplexer  N4BEG2 		MUX-1
	assign N4BEG2 = S4END13;
// switch matrix multiplexer  N4BEG3 		MUX-1
	assign N4BEG3 = S4END12;
// switch matrix multiplexer  N4BEG4 		MUX-1
	assign N4BEG4 = S4END11;
// switch matrix multiplexer  N4BEG5 		MUX-1
	assign N4BEG5 = S4END10;
// switch matrix multiplexer  N4BEG6 		MUX-1
	assign N4BEG6 = S4END9;
// switch matrix multiplexer  N4BEG7 		MUX-1
	assign N4BEG7 = S4END8;
// switch matrix multiplexer  N4BEG8 		MUX-1
	assign N4BEG8 = S4END7;
// switch matrix multiplexer  N4BEG9 		MUX-1
	assign N4BEG9 = S4END6;
// switch matrix multiplexer  N4BEG10 		MUX-1
	assign N4BEG10 = S4END5;
// switch matrix multiplexer  N4BEG11 		MUX-1
	assign N4BEG11 = S4END4;
// switch matrix multiplexer  N4BEG12 		MUX-1
	assign N4BEG12 = S4END3;
// switch matrix multiplexer  N4BEG13 		MUX-1
	assign N4BEG13 = S4END2;
// switch matrix multiplexer  N4BEG14 		MUX-1
	assign N4BEG14 = S4END1;
// switch matrix multiplexer  N4BEG15 		MUX-1
	assign N4BEG15 = S4END0;

endmodule
