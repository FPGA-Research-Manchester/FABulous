
`ifndef NO_LUT

module  \$_FF_ (input D, output Q); 
LUTFF #() _TECHMAP_REPLACE_ (.D(D), .O(Q)); 
endmodule


module \$lut (A, Y);
  parameter WIDTH = 0;
  parameter LUT = 0;

  input [WIDTH-1:0] A;
  output Y;

  generate
    if (WIDTH == 1) begin
      LUT4 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),
        .I0(A[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0));

    end else
    if (WIDTH == 2) begin
      LUT4 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),
        .I0(A[0]), .I1(A[1]), .I2(1'b0), .I3(1'b0));

    end else
    if (WIDTH == 3) begin
      LUT4 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),
        .I0(A[0]), .I1(A[1]), .I2(A[2]), .I3(1'b0));

    end else
    if (WIDTH == 4) begin
      LUT4 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]));
    end else
    //if (WIDTH == 5) begin
    //  wire T0, T1;
    //  LUT4 #(.INIT(LUT[15:0])) fpga_lut_0 (.O(T0),
    //   .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3]));
    //  LUT4 #(.INIT(LUT[31:16])) fpga_lut_1 (.O(T1),
    //    .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3])); 
    //  MUXF7 fpga_mux_0 (.O(Y), .I0(T0), .I1(T1), .S(A[4]));
	//LUT5 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),
      //  .I0(A[0]), .I1(A[1]), .I2(A[2]),
      //  .I3(A[3]), .I4(A[4]));
    //end else
    if (WIDTH == 6) begin
      wire T0, T1, T2, T3, T4, T5;
      LUT4 #(.INIT(LUT[15:0])) fpga_lut_0 (.O(T0),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]));
      LUT4 #(.INIT(LUT[31:16])) fpga_lut_1 (.O(T1),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]));
      LUT4 #(.INIT(LUT[47:32])) fpga_lut_2 (.O(T2),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]));
      LUT4 #(.INIT(LUT[63:48])) fpga_lut_3 (.O(T3),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]));

      MUXF7 fpga_mux_0 (.O(T4), .I0(T0), .I1(T1), .S(A[4]));
      MUXF7 fpga_mux_1 (.O(T5), .I0(T2), .I1(T3), .S(A[4]));
      MUXF8 fpga_mux_2 (.O(Y), .I0(T4), .I1(T5), .S(A[5]));
    end else
    if (WIDTH == 7) begin
      wire T0, T1;
      LUT6 #(.INIT(LUT[63:0])) fpga_lut_0 (.O(T0),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]), .I4(A[4]), .I5(A[5]));
      LUT6 #(.INIT(LUT[127:64])) fpga_lut_1 (.O(T1),
        .I0(A[0]), .I1(A[1]), .I2(A[2]),
        .I3(A[3]), .I4(A[4]), .I5(A[5]));
      MUXF7 fpga_mux_0 (.O(Y), .I0(T0), .I1(T1), .S(A[6]));
    //end else
    //if (WIDTH == 8) begin
    //  wire T0, T1, T2, T3, T4, T5;
    //  LUT6 #(.INIT(LUT[63:0])) fpga_lut_0 (.O(T0),
    //    .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3]), .I4(A[4]), .I5(A[5]));
    //  LUT6 #(.INIT(LUT[127:64])) fpga_lut_1 (.O(T1),
    //    .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3]), .I4(A[4]), .I5(A[5]));
    //  LUT6 #(.INIT(LUT[191:128])) fpga_lut_2 (.O(T2),
    //    .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3]), .I4(A[4]), .I5(A[5]));
    //  LUT6 #(.INIT(LUT[255:192])) fpga_lut_3 (.O(T3),
    //    .I0(A[0]), .I1(A[1]), .I2(A[2]),
    //    .I3(A[3]), .I4(A[4]), .I5(A[5]));
    //  MUXF7 fpga_mux_0 (.O(T4), .I0(T0), .I1(T1), .S(A[6]));
    //  MUXF7 fpga_mux_1 (.O(T5), .I0(T2), .I1(T3), .S(A[6]));
    //  MUXF8 fpga_mux_2 (.O(Y), .I0(T4), .I1(T5), .S(A[7]));
    end else begin
      wire _TECHMAP_FAIL_ = 1;
    end
  endgenerate
endmodule
`endif

//(* techmap_celltype = "$mul" *)
//module _80_diko_mul (A, B, Y);
//  parameter A_WIDTH = 0;
//  parameter B_WIDTH = 0;
//  parameter A_SIGNED = 0;
//  parameter B_SIGNED = 0;
//  parameter Y_WIDTH = 0;
  //parameter CONFIG = 4'b0000;
  //parameter CONFIG_WIDTH = 4;
   
//  input [A_WIDTH-1:0] A;
//  input [B_WIDTH-1:0] B;
//  output [Y_WIDTH-1:0] Y;

//generate
//  if (A_SIGNED && B_SIGNED) begin:BLOCK1
//    assign Y = $signed(A) * $signed(B);
//  end else begin:BLOCK2
//    assign Y = A * B;
//  end
//endgenerate

//endmodule


//(* techmap_celltype = "$mul" *)
//module \MULADD (A, B, Y);
//	parameter A_SIGNED = 0;
//	parameter B_SIGNED = 0;
//	parameter A_WIDTH = 0;
//	parameter B_WIDTH = 0;
//	parameter Y_WIDTH = 0;
//
//	input [A_WIDTH-1:0] A;
//	input [B_WIDTH-1:0] B;
//	output [Y_WIDTH-1:0] Y;
//	
//	MULADD #(.MODE(1) ) muladd1 (.A(A), .B(B));
//endmodule
