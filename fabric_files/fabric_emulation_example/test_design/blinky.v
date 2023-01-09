module top(input wire clk, input wire [27:0] io_in, output wire [27:0] io_out, io_oeb);
wire rst = io_in[0];
reg [26:0] counter;

always @ (posedge clk)
begin
    if (rst)
        begin
            counter <= 0;
        end
    else 
        begin
            counter <= counter + 1;
        end
end

assign io_oeb = 28'b1;
assign io_out = {counter, 1'b0};

endmodule