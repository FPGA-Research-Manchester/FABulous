module blinky (
//    input  clk,
//    output led0,
//    output led1,
//    output led2,
//    output led3
);
    wire clk, multand;
    (* keep *) LUT1 clk_out(.O(clk)); 
    (* keep *) LUT1 multand_out(.O(multand));
    (* keep *) LUT1 s1_out(.O(s1));

    wire led0, led1, led2, led3;
    (* keep *) LUT1 led0_in(.I0(led0));
    (* keep *) LUT1 led1_in(.I0(led1));
    (* keep *) LUT1 led2_in(.I0(led2));
    (* keep *) LUT1 led3_in(.I0(led3));

    localparam BITS = 4;
    parameter LOG2DELAY = 28;

//    reg [BITS+LOG2DELAY-1:0] counter = 0;
//    reg [BITS-1:0] outcnt;

//    always @(posedge clk) begin
//        counter <= counter + 1;
//        outcnt <= counter >> LOG2DELAY;
//    end
//

    //assign led0 = clk*multand+clk;
    //assign led1 = led0 * clk;
    //assign led0 = (s1 ? clk : multand);
    assign led0 = clk + multand;
endmodule
