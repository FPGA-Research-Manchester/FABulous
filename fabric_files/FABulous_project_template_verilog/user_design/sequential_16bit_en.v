module sequential_16bit_en (enable, reset, counter);

input enable, reset;
output reg [15:0] counter;

wire clk;
(* keep *) Global_Clock inst_clk (.CLK(clk));

initial begin
    counter = 16'b0000000000000000;
end

always @ (posedge clk) begin
    if(enable) begin
        if(reset) begin
            counter <= 0;
        end 
        else begin
            counter <= counter + 1'b1;
        end
    end
end

//assign {Tile_X0Y1_A_I,Tile_X0Y1_B_I,Tile_X0Y2_A_I,Tile_X0Y2_B_I,Tile_X0Y3_A_I,Tile_X0Y3_B_I,Tile_X0Y4_A_I,Tile_X0Y4_B_I,Tile_X0Y5_A_I,Tile_X0Y5_B_I,Tile_X0Y6_A_I,Tile_X0Y6_B_I,Tile_X0Y7_A_I,Tile_X0Y7_B_I,Tile_X0Y8_A_I,Tile_X0Y8_B_I} = counter;

endmodule

    //and_reg <= Tile_X0Y1_A_O & Tile_X0Y2_A_O;
    //or_reg <= Tile_X0Y1_A_O | Tile_X0Y2_A_O;
    //Tile_X0Y1_A_I <= and_reg ^ or_reg;
