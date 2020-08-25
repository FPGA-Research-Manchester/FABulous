module blinky (
//    input  clk,
//    output led0,
//    output led1,
//    output led2,
//    output led3
//inout  wow,
//input mully
//output [3:0] lump
//parameter bufwidth = 4
//output lemonout,
//input lemonin
);
 
	parameter bufwidth = 4; 
	wire clk, multand, s1, s2, s3, s4;
    (* keep *) LUT1 clk_out(.O(clk)); 
    (* keep *) LUT1 multand_out(.O(multand));
    (* keep *) LUT1 s1_out(.O(s1));
    (* keep *) LUT1 s2_out(.O(s2));
    (* keep *) LUT1 s3_out(.O(s3));
    (* keep *) LUT1 s4_out(.O(s4));
    //(* keep *) InPass4_frame_config  mully_out (.O(mully));
  


    wire led0, led1, led2, led3;
    (* keep *) LUT1 led0_in(.I0(led0));
    (* keep *) LUT1 led1_in(.I0(led1));
    (* keep *) LUT1 led2_in(.I0(led2));
    (* keep *) LUT1 led3_in(.I0(led3));

//assign led0 = mully;

//    localparam BITS = 4;
//    parameter LOG2DELAY = 28;

//    reg [BITS+LOG2DELAY-1:0] counter = 0;
//    reg [BITS-1:0] outcnt;

//    always @(posedge clk) begin
//        counter <= counter + 1;
//        outcnt <= counter >> LOG2DELAY;
//    end
//

//assign lump = {s1, s2, s3, s4};
//

//reg lemon;

assign {led0, led1, led3, led2} = {s1, s2, clk} * {s3, s4, multand} + {clk, s2, multand};

//always @(*) begin
//	lemon <= led0 & lemonin;
//	lemon <= lemon + s1;
//	lemonout <= lemon + clk;
//end

//assign lemon = s1;

//assign lemonout = lemon & s4;
    //assign {led1, led3} = {clk, multand, s1} + {s2, s3, s4};


    //assign {led1, led2, led3, led4} = {s1, clk, s2} * {s3, s4, multand} + {s4, s3};
    //assign led1 = led0 * clk;
    //assign led0 = (s1 ? clk : multand);
    //assign led0 = clk + multand;

//  always @ (*) begin
//	case ({clk, multand, s1, s2, s3})
//		5'b00000: led0 <= 1'b0;
//		5'b10000: led0 <= 1'b1;
//		5'b11111: led0 <= 1'b1;
//		5'b10101: led0 <= 1'b0;
//		5'b01010: led0 <= 1'b1;
//		5'b01110: led0 <= 1'b1;
//		default: led0 <= 1'b0;
//	endcase

//    end

endmodule
