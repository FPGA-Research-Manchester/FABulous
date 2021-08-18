// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
// InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

module OutPass4_frame_config (I0, I1, I2, I3, O0, O1, O2, O3, UserCLK, ConfigBits);
	parameter NoConfigBits = 4;// has to be adjusted manually (we don't use an arithmetic parser for the value)
	// Pin0
	input I0;
	input I1;
	input I2;
	input I3;
	output O0;// EXTERNAL
	output O1;// EXTERNAL
	output O2;// EXTERNAL
	output O3;// EXTERNAL
	// Tile IO ports from BELs
	input UserCLK;// EXTERNAL // SHARED_PORT // ## the EXTERNAL keyword will send this signal all the way to top and the //SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input [NoConfigBits-1:0] ConfigBits;

//              ______   ______
//    I////+//->|FLOP|-Q-|1 M |
//         |             |  U |//////-> O
//         +////////////-|0 X |               

// I am instantiating an IOBUF primitive.
// However, it is possible to connect corresponding pins all the way to top, just by adding an "// EXTERNAL" comment (see PAD in the entity)

	reg Q0, Q1, Q2, Q3;   // FLOPs

	always @ (posedge UserCLK)
	begin
		Q0 <= I0;
		Q1 <= I1;
		Q2 <= I2;
		Q3 <= I3;
	end

	assign O0 = ConfigBits[0] ? Q0 : I0;
	assign O1 = ConfigBits[1] ? Q1 : I1;
	assign O2 = ConfigBits[2] ? Q2 : I2;
	assign O3 = ConfigBits[3] ? Q3 : I3;

endmodule
