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

// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

module InPassOPA (OPA_I0, OPA_I1, OPA_I2, OPA_I3, OPA_O0, OPA_O1, OPA_O2, OPA_O3, OPA_UserCLK, MODE, CONFin, CONFout, CLK);
	// parameter LUT_SIZE = 4;
	// Pin0
	input OPA_I0; // EXTERNAL
	input OPA_I1; // EXTERNAL
	input OPA_I2; // EXTERNAL
	input OPA_I3; // EXTERNAL
	output OPA_O0; 
	output OPA_O1; 
	output OPA_O2; 
	output OPA_O3; 
	// Tile IO ports from BELs
	input OPA_UserCLK; // EXTERNAL // the EXTERNAL keyword will send this signal all the way to top
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input MODE; // 1 configuration, 0 action
	input CONFin;
	output CONFout;
	input CLK;

//              ______   ___
//    I////+//->|FLOP|-Q-|M|
//         |             |U|//////-> O
//         +////////////-|X|               

// I am instantiating an IOBUF primitive.
// However, it is possible to connect corresponding pins all the way to top, just by adding an "// EXTERNAL" comment (see PAD in the entity)

	wire c0, c1, c2, c3;   // configuration bits ( 0 combinatorial; 1 registered )
	reg Q0, Q1, Q2, Q3;   // FLOPs

	LHQD1 inst_LHQD1a (
	.D(CONFin),
	.E(CLK),
	.Q(c0)
	);
	LHQD1 inst_LHQD1b (
	.D(c0),
	.E(MODE),
	.Q(c1)
	); 
	LHQD1 inst_LHQD1c (
	.D(c1),
	.E(CLK),
	.Q(c2)
	);
	LHQD1 inst_LHQD1d (
	.D(c2),
	.E(MODE),
	.Q(c3)
	);
	assign CONFout = c3;


	always @ (posedge OPA_UserCLK)
	begin
		Q0 <= OPA_I0;
		Q1 <= OPA_I1;
		Q2 <= OPA_I2;
		Q3 <= OPA_I3;
	end

	assign OPA_O0 = c0 ? Q0 : OPA_I0;
	assign OPA_O1 = c1 ? Q1 : OPA_I1;
	assign OPA_O2 = c2 ? Q2 : OPA_I2;
	assign OPA_O3 = c3 ? Q3 : OPA_I3;

endmodule
