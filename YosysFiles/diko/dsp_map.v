//(* techmap_celltype = "$mul" *)
//module \MULADD (A, B, Y);
//	parameter A_SIGNED = 0;
//	parameter B_SIGNED = 0;
//	parameter A_WIDTH = 0;
//	parameter B_WIDTH = 0;
//	parameter Y_WIDTH = 0;

//	input [A_WIDTH-1:0] A;
//	input [B_WIDTH-1:0] B;
//	output [Y_WIDTH-1:0] Y;
	
//	MULADD #(.MODE(1) ) muladd1 (.A(A), .B(B));
//endmodule

module $mul (A, B, Y);
	parameter A_SIGNED = 0;
	parameter B_SIGNED = 0;
	parameter A_WIDTH = 0;
	parameter B_WIDTH = 0;
	parameter Y_WIDTH = 0;

	input [A_WIDTH-1:0] A;
	input [B_WIDTH-1:0] B;
	output [Y_WIDTH-1:0] Y;

	MULADD #() _TECHMAP_REPLACE_ (.Q(Y), .A(A), .B(B), .C(0)); 

endmodule