/* Copyright 2021 University of Manchester

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

// Models for the embedded FPGA fabric
// LHD1 Latch area 11.76
`timescale 1ns/1ns
module LHD1 (D, E, Q, QN);
	input D;     // global signal 1: configuration, 0: operation
	input E;
	output Q;
	output QN; 

	wire M_set_gate, M_reset_gate;
	wire S_set_gate, S_reset_gate;
	wire M_q, M_qn;
	wire S_q, S_qn;

	// master
	assign #10 M_set_gate = ~(D & E);
	assign #10 M_reset_gate = ~((~D) & E);
	assign #10 M_q = ~(M_qn & M_set_gate);
	assign #10 M_qn = ~(M_q & M_reset_gate);

	assign Q = M_q;
	assign QN = M_qn;

endmodule

module LHQD1 (D, E, Q);
	input D;// global signal 1: configuration, 0: operation
	input E;
	output Q;

	wire M_set_gate;
	wire M_reset_gate;
	wire M_q;
	wire M_qn;

// master
	assign #10 M_set_gate = ~(D & E);
	assign #10 M_reset_gate = ~((~D) & E);
	assign #10 M_q = ~(M_qn & M_set_gate);
	assign #10 M_qn = (M_q & M_reset_gate);

	assign Q = M_q;

endmodule

// (MUX4PTv4) and 1.2ns (MUX16PTv2) in worse case when all select bits=0, so I think they work fine with f=50MHz. 
// The area are HxW = 7um x 9.86um (MUX4) and 7um x 44.72um (MUX16). 
// Please note, the pins are named as IN1, IN2, ..., IN16 for inputs, S1, .., S4 for selects and OUT for output.

module MUX4PTv4 (IN1, IN2, IN3, IN4, S1, S2, O);
	input IN1;
	input IN2;
	input IN3;
	input IN4;
	input S1;
	input S2;
	output O; 
	reg O;
	wire [1:0] SEL;

	assign SEL = {S2,S1};
	always @(*) 
	begin
		case(SEL)
			2'b00:O <= IN1;
			2'b01:O <= IN2;
			2'b10:O <= IN3;
			2'b11:O <= IN4;
			default:O <= 0;
		endcase
	end

endmodule 

module MUX16PTv2 (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15, IN16, S1, S2, S3, S4, O);
	input IN1;
	input IN2;
	input IN3;
	input IN4;
	input IN5;
	input IN6;
	input IN7;
	input IN8;
	input IN9;
	input IN10;
	input IN11;
	input IN12;
	input IN13;
	input IN14;
	input IN15;
	input IN16;
	input S1;
	input S2;
	input S3;
	input S4;
	output O;
	reg O;
	wire [3:0] SEL;

	assign SEL = {S4,S3,S2,S1};
	always @(*)
	begin
		case(SEL)
			4'b0000: O <= IN1;
			4'b0001: O <= IN2;
			4'b0010: O <= IN3;
			4'b0011: O <= IN4;
			4'b0100: O <= IN5;
			4'b0101: O <= IN6;
			4'b0110: O <= IN7;
			4'b0111: O <= IN8;
			4'b1000: O <= IN9;
			4'b1001: O <= IN10;
			4'b1010: O <= IN11;
			4'b1011: O <= IN12;
			4'b1100: O <= IN13;
			4'b1101: O <= IN14;
			4'b1110: O <= IN15;
			4'b1111: O <= IN16;
			default: O <= 0;
		endcase
	end

endmodule
