module top(input CLK, BTN_N, output LEDR_N, LEDG_N, LED1, LED2, LED3, LED4, LED5);
    wire [27:0] O_top;
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

    assign O_top = {26'b0, ~BTN_N};
    assign {LEDR_N, LEDG_N, LED5, LED4, LED3, LED2, LED1} = I_top[27:21];

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule

module sram_1rw1r_32_256_8_sky130(
//`ifdef USE_POWER_PINS
//  vdd,
//  gnd,
//`endif
// Port 0: RW
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
// Port 1: R
    clk1,csb1,addr1,dout1
  );

  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 32 ;
  parameter ADDR_WIDTH = 8 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  // FIXME: This delay is arbitrary.
  parameter DELAY = 3 ;
//`ifdef USE_POWER_PINS
 // inout vdd;
 // inout gnd;
//`endif
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [NUM_WMASKS-1:0]   wmask0; // write mask
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;
  input  clk1; // clock
  input   csb1; // active low chip select
  input [ADDR_WIDTH-1:0]  addr1;
  output [DATA_WIDTH-1:0] dout1;
  // bram unsupported in emulation
  assign dout0 = 0;
  assign dout1 = 0;
endmodule

