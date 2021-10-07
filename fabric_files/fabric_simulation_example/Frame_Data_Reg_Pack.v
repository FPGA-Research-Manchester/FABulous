module Frame_Data_Reg_0 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 1;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_1 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 2;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_2 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 3;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_3 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 4;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_4 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 5;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_5 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 6;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_6 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 7;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_7 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 8;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_8 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 9;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_9 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 10;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_10 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 11;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

module Frame_Data_Reg_11 (FrameData_I, FrameData_O, RowSelect, CLK);
	parameter FrameBitsPerRow = 32;
	parameter RowSelectWidth = 5;
	parameter Row = 12;
	input [FrameBitsPerRow-1:0] FrameData_I;
	output reg [FrameBitsPerRow-1:0] FrameData_O;
	input [RowSelectWidth-1:0] RowSelect;
	input CLK;
	
	always @ (posedge CLK) begin
		if (RowSelect==Row)
			FrameData_O <= FrameData_I;
	end//CLK
endmodule

