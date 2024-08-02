(* FABulous, BelMap,
C_bit0=0,
C_bit1=1,
C_bit2=2,
C_bit3=3
*)
module Config_access #(parameter NoConfigBits = 4)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
	// Pin0
	(* FABulous, EXTERNAL *)output [3:0] C, // EXTERNAL
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	(* FABulous, GLOBAL *)input [NoConfigBits-1:0] ConfigBits
);
	// we just wire configuration bits to fabric top
	assign C[0] = ConfigBits[0];
    assign C[1] = ConfigBits[1];
    assign C[2] = ConfigBits[2];
    assign C[3] = ConfigBits[3];

endmodule
