





module LUT1(output O, input I0);
  parameter [1:0] INIT = 0;
  assign O = I0 ? INIT[1] : INIT[0];
endmodule

module LUT2(output O, input I0, I1);
  parameter [3:0] INIT = 0;
  wire [ 1: 0] s1 = I1 ? INIT[ 3: 2] : INIT[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT3(output O, input I0, I1, I2);
  parameter [7:0] INIT = 0;
  wire [ 3: 0] s2 = I2 ? INIT[ 7: 4] : INIT[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT4(output O, input I0, I1, I2, I3);
  parameter [15:0] INIT = 0;
  wire [ 7: 0] s3 = I3 ? INIT[15: 8] : INIT[ 7: 0];
  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

//module LUT5(output O, input I0, I1, I2, I3, I4);
//  parameter [31:0] INIT = 0;
//  wire [15: 0] s4 = I4 ? INIT[31:16] : INIT[15: 0];
//  wire [ 7: 0] s3 = I3 ?   s4[15: 8] :   s4[ 7: 0];
//  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
//  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
//  assign O = I0 ? s1[1] : s1[0];
//endmodule

//module LUT6(output O, input I0, I1, I2, I3, I4, I5);
//  parameter [63:0] INIT = 0;
//  wire [31: 0] s5 = I5 ? INIT[63:32] : INIT[31: 0];
//  wire [15: 0] s4 = I4 ?   s5[31:16] :   s5[15: 0];
//  wire [ 7: 0] s3 = I3 ?   s4[15: 8] :   s4[ 7: 0];
//  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
//  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
//  assign O = I0 ? s1[1] : s1[0];
//endmodule


module MUXF7(output O, input I0, I1, S);
  assign O = S ? I1 : I0;
endmodule

module MUXF8(output O, input I0, I1, S);
  assign O = S ? I1 : I0;
endmodule


module LUTFF(input D, output O);
always @ ($global_clock) begin
	O <= D;
end
endmodule

(*blackbox*)
module MUX8LUT_frame_config(
input A, B, C, D, E, F, G, H, S0, S1, S2, S3,
output M_AB, M_AD, M_AH, M_EF
);

parameter [1:0] c0 = 0;
parameter [1:0] c1 = 0;

endmodule


module MULADD (input [7:0]  A, B,
		input [19:0] C,
		output [19:0] Q,
		input clr);

  parameter [1:0] A_reg = 0;
  parameter [1:0] B_reg = 0;
  parameter [1:0] C_reg = 0;

  parameter [1:0] ACC = 0;

  parameter [1:0] signExtension = 0;

  parameter [1:0] ACCout = 0;

	assign Q = A * B;
endmodule

//module MULADD (input A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, output Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19);

//assign {Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19} = {A0, A1, A2, A3, A4, A5, A6, A7} * {B0, B1, B2, B3, B4, B5, B6, B7};

//endmodule

(* blackbox *)
module InPass4_frame_config (output O0, O1, O2, O3);

endmodule


(* blackbox *)
module OutPass4_frame_config (input I0, I1, I2, I3);

endmodule

(* blackbox *)
module IO_1_bidirectional_frame_config_pass (input T, I, output Q, O);
endmodule

module SB_CARRY (output CO, input I0, I1, CI);
	assign CO = (I0 && I1) || ((I0 || I1) && CI);
endmodule
