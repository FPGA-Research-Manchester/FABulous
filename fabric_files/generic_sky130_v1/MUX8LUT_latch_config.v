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

module MUX8LUT_latch_config (A, B, C, D, E, F, G, H, S0, S1, S2, S3, M_AB, M_AD, M_AH, M_EF, MODE, CONFin, CONFout, CLK);
    // Generic (LUT_SIZE : integer := 4);	
   // IMPORTANT: this has to be in a dedicated line
	input A; // MUX inputs
	input B;
	input C;
	input D;
	input E; 
	input F;
	input G;
	input H;
	input S0;
	input S1;
	input S2;
	input S3;
	output M_AB;
	output M_AD;
	output M_AH;
	output M_EF;
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input MODE;// 1 configuration, 0 action
	input CONFin;
	output CONFout;
	input CLK;

	wire AB, CD, EF, GH;
	wire sCD, sEF, sGH, sEH;
	wire AD, EH, AH;
	wire EH_GH;

	wire c0, c1;// configuration bits
// configuration bits
//always @ (posedge clk)
//begin
//	if (MODE==1'b1) begin // configuration mode
//		c0  <= CONFin;
//		c1  <= c0;
//	end
//end

	LHQD1 inst_LHQD1a(
	.D(CONFin),
	.E(CLK),
	.Q(c0)
	);

	LHQD1 inst_LHQD1b(
	.D(c0),
	.E(MODE),
	.Q(c1)
	);

	assign CONFout = c1;

// see figure (column-wise left-to-right)
	assign AB = S0 ? B : A;
	assign CD = sCD ? D : C;
	assign EF = sEF ? F : E;
	assign GH = sGH ? H : G;


	assign sCD = c0 ? S0 : S1;
	assign sEF = c1 ? S0 : S2;
	assign sGH = c0 ? sEF : sEH;
	assign sEH = c1 ? S1 : S3;

	assign AD = S1 ? CD : AB;
	assign EH = sEH ? GH : EF;

	assign AH = S3 ? EH : AD;

	assign EH_GH = c0 ? EH : GH;

	assign M_AB = AB;
	assign M_AD = c0 ? AD : CD;
	assign M_AH = c1 ? AH : EH_GH;
	assign M_EF = EF;

endmodule
