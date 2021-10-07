`timescale 1ns/1ps

module Frame_Select_0 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 0;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_1 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 1;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_2 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 2;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_3 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 3;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_4 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 4;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_5 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 5;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_6 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 6;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_7 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 7;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1  FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_8 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 8;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1 FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_9 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 9;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1 FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_10 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 10;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1 FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_11 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 11;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1 FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

module Frame_Select_12 (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 12;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O = #1 FrameStrobe_I;
		else
			FrameStrobe_O = #1 'd0;
	end
endmodule

