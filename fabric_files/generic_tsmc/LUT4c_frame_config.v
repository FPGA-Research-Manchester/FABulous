module LUT4c_frame_config (I0, I1, I2, I3, O, Ci, Co, UserCLK, ConfigBits);
	parameter NoConfigBits = 18 ; // has to be adjusted manually (we don't use an arithmetic parser for the value)
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
	input [NoConfigBits-1 : 0] ConfigBits;

	localparam LUT_SIZE = 4; 
	localparam N_LUT_flops = 2 ** LUT_SIZE; 

	wire [N_LUT_flops-1 : 0] LUT_values;
	wire [LUT_SIZE-1 : 0] LUT_index;
	wire LUT_out;
	reg LUT_flop;
	wire I0mux; // normal input '0', or carry input '1'
	wire c_out_mux, c_I0mux;	// extra configuration bits

	assign LUT_values = ConfigBits[15:0];
	assign c_out_mux  = ConfigBits[16];
	assign c_I0mux = ConfigBits[17];

//CONFout <= c_I0mux;

	assign I0mux = c_I0mux ? Ci : I0;;
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
	assign Co = (Ci & I1) | (Ci & I2) | (I1 & I2);// iCE40 like carry chain (as this is supported in Yosys; would normally go for fractured LUT

	always @ (posedge UserCLK)
	begin
		LUT_flop <= LUT_out;
	end

endmodule
