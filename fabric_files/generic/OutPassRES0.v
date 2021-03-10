`include "models_pack.v"

// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

module OutPassRES0 (RES0_I0, RES0_I1, RES0_I2, RES0_I3, RES0_O0, RES0_O1, RES0_O2, RES0_O3, RES0_UserCLK, MODE, CONFin, CONFout, CLK);
	// parameter LUT_SIZE = 4);
	// Pin0
	input RES0_I0;
	input RES0_I1;
	input RES0_I2;
	input RES0_I3;
	output RES0_O0;// EXTERNAL
	output RES0_O1;// EXTERNAL
	output RES0_O2;// EXTERNAL
	output RES0_O3;// EXTERNAL
	// Tile IO ports from BELs
	input RES0_UserCLK;// EXTERNAL // the EXTERNAL keyword will send this signal all the way to top
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input MODE;// 1 configuration, 0 action
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


	always @ (posedge RES0_UserCLK)
	begin
		Q0 <= RES0_I0;
		Q1 <= RES0_I1;
		Q2 <= RES0_I2;
		Q3 <= RES0_I3;
	end

	assign RES0_O0 = c0 ? Q0 : RES0_I0;
	assign RES0_O1 = c1 ? Q1 : RES0_I1;
	assign RES0_O2 = c2 ? Q2 : RES0_I2;
	assign RES0_O3 = c3 ? Q3 : RES0_I3;

endmodule
