// Copyright 2021 University of Manchester
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module LUT4c_latch_config (I0, I1, I2, I3, O, Ci, Co, UserCLK, MODE, CONFin, CONFout, CLK);
	// parameter LUT_SIZE = 4);
	// IMPORTANT: this has to be in a dedicated line
	input I0; // LUT inputs
	input I1;
	input I2;
	input I3;
	output O; // LUT output (combinatorial or FF)
	input Ci; // carry chain input
	output Co; // carry chain output
	input UserCLK; // EXTERNAL // SHARED_PORT // ## the EXTERNAL keyword will send this sisgnal all the way to top and the //SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input MODE;// 1 configuration, 0 action
	input CONFin;
	output CONFout;
	input CLK;

	localparam LUT_SIZE = 4; 
	localparam N_LUT_flops = 2 ** LUT_SIZE; 

	wire [N_LUT_flops-1 : 0] LUT_values;
	wire [LUT_SIZE-1 : 0] LUT_index;
	wire LUT_out;
	reg LUT_flop;
	wire I0mux;// normal input '0', or carry input '1'
	wire c_out_mux, c_I0mux;	// extra configuration bits
	wire [16+2-1 : 0] ConfigBits;
	wire [16+2-1 : 0] ConfigBitsInput;
	genvar k;
// The lookup tables are daisy-chained to a shift register made from latches

	assign ConfigBitsInput = {ConfigBits[17-1:0],CONFin}; //ConfigBits'high = 17

	for (k=0; k<8; k=k+1) begin: L
		LHQD1 inst_LHQD1a(
		.D(ConfigBitsInput[k*2]),
		.E(CLK),
		.Q(ConfigBits[k*2])
		);                 

		LHQD1 inst_LHQD1b(
		.D(ConfigBitsInput[(k*2)+1]),
		.E(MODE),
		.Q(ConfigBits[(k*2)+1])
		); 
	end

	assign CONFout = ConfigBits[17]; //ConfigBits'high = 17

//always @ (posedge CLK) begin
//		if (mode==1'b1) begin//configuration mode
//			LUT_values <= {LUT_values[N_LUT_flops-1-1:0],CONFin};
//			c_out_mux  <= LUT_values[N_LUT_flops-1];
//			c_I0mux    <= c_out_mux;
//		end
//end

	assign LUT_values = ConfigBits[15:0];
	assign c_out_mux  = ConfigBits[16];
	assign c_I0mux    = ConfigBits[17];

//assign CONFout <= c_I0mux;

	assign I0mux = c_I0mux ? Ci : I0;
	assign LUT_index = {I3,I2,I1,I0mux};

// The LUT is just a multiplexer 
// for a first shot, I am using a 16:1
// LUT_out <= LUT_values(TO_INTEGER(LUT_index));
	MUX16PTv2 inst_MUX16PTv2_E6BEG1(
	.IN1(LUT_values[0]),
	.IN2(LUT_values[1]),
	.IN3(LUT_values[2]),
	.IN4(LUT_values[3]),
	.IN5(LUT_values[4]),
	.IN6(LUT_values[5]),
	.IN7(LUT_values[6]),
	.IN8(LUT_values[7]),
	.IN9(LUT_values[8]),
	.IN10(LUT_values[9]),
	.IN11(LUT_values[10]),
	.IN12(LUT_values[11]),
	.IN13(LUT_values[12]),
	.IN14(LUT_values[13]),
	.IN15(LUT_values[14]),
	.IN16(LUT_values[15]),
	.S1(LUT_index[0]),
	.S2(LUT_index[1]),
	.S3(LUT_index[2]),
	.S4(LUT_index[3]),
	.O(LUT_out)
	);

	assign O = c_out_mux ? LUT_flop : LUT_out;
	assign Co = (Ci & I1) | (Ci & I2) | (I1 & I2);// iCE40 like carry chain (as this is supported in Josys; would normally go for fractured LUT

	always @ (posedge UserCLK)
	begin
		LUT_flop <= LUT_out;
	end

endmodule
