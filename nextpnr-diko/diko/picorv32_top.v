module top (
//	input clki, resetn,
//	output trap,
//
//	output        mem_valid,
//	output        mem_instr,
//	input         mem_ready,
//
//	output [31:0] mem_addr,
//	output [31:0] mem_wdata,
//	output [ 3:0] mem_wstrb,
//	input  [31:0] mem_rdata
);

    wire clk, resetn;
    (* keep *) LUT1 clk_out(.O(clk));
    (* keep *) LUT1 resetn_out(.O(resetn));

    wire trap, mem_valid, mem_instr, mem_ready;
    (* keep *) LUT1 trap_in(.I0(trap));
    (* keep *) LUT1 mem_valid_in(.I0(mem_valid));
    (* keep *) LUT1 mem_instr_in(.I0(mem_instr));
    (* keep *) LUT1 mem_ready_out(.O(mem_ready));

    wire [31:0] mem_addr, mem_wdata, mem_wstrb, mem_rdata;
    generate 
        genvar i;
        for (i = 0; i < 32; i++) begin
            (* keep *) LUT1 mem_addr_out(.I0(mem_addr[i]));
            (* keep *) LUT1 mem_wdata_out(.I0(mem_wdata[i]));
            (* keep *) LUT1 mem_wstrb_out(.I0(mem_wstrb[i]));
            (* keep *) LUT1 mem_rdata_in(.O(mem_rdata[i]));
        end
    endgenerate


    picorv32 #(
        .ENABLE_COUNTERS(0),
        .LATCHED_MEM_RDATA(1),
        .TWO_STAGE_SHIFT(0),
        .CATCH_MISALIGN(0),
        .CATCH_ILLINSN(0),
        .ENABLE_REGS_DUALPORT(0),
        .ENABLE_REGS_16_31(0)
    ) cpu (
        .clk      (clk     ),
        .resetn   (resetn   ),
        .trap     (trap     ),
        .mem_valid(mem_valid),
        .mem_instr(mem_instr),
        .mem_ready(mem_ready),
        .mem_addr (mem_addr ),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata)
    );
endmodule
