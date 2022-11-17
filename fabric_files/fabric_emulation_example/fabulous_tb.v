`timescale 1ps/1ps
`define CREATE_FST
module fab_emulation_tb;

    reg CLK;
    reg [27:0] O_top;
    wire [27:0] I_top, T_top;
    // Instantiate both the fabric and the reference DUT
    eFPGA_top top_i (
        .I_top(I_top),
        .T_top(T_top),
        .O_top(O_top),
        .A_config_C(), .B_config_C(),
        .CLK(CLK), .SelfWriteStrobe(1'b0), .SelfWriteData(32'b0),
        .Rx(1'b0),
        .ComActive(),
        .ReceiveLED(),
        .s_clk(1'b0),
        .s_data(1'b0)
    );

    wire [27:0] I_top_gold, T_top_gold;
    top dut_i (
        .clk(CLK),
        .io_out(I_top_gold),
        .io_oeb(T_top_gold),
        .io_in(O_top)
    );

    always #5000 CLK = (CLK === 1'b0);

    integer i;
    reg have_errors = 1'b0;
    initial begin
`ifdef CREATE_FST
        $dumpfile("fab_tb.fst");
        $dumpvars(0, fab_emulation_tb);
`endif
        repeat (100) @(posedge CLK);
        O_top = 28'b1; // reset
        repeat (5) @(posedge CLK);
        O_top = 28'b0;
        for (i = 0; i < 100; i = i + 1) begin
            @(negedge CLK);
            $display("fabric = %b gold = %b", I_top, I_top_gold);
            if (I_top != I_top_gold)
                have_errors = 1'b1;
        end

        if (have_errors)
            $fatal;
        else
            $finish;
    end

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule
