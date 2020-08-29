module blinky (
//    input  clk,
//    output led0,
//    output led1,
//    output led2,
//    output led3
inout  wow,
	input s1, s2, s3, led0, led3, clk
//input mully
//output [3:0] lump
//parameter bufwidth = 4
//output lemonout,
//input lemonin
);
 

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

reg  lemon1;
reg  lemon2;



always @(clk) begin
	lemon1 <= s1;
	lemon2 <= s2;
	if (led0 == led3) begin
		lemon1 <= lemon2;
		lemon2 <= s3;
	end
end

assign wow = lemon1;
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
