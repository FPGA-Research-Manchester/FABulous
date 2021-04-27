// Copyright 2021 University of Manchester
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module Frame_Data_Reg (FrameData_I, FrameData_O, RowSelect, CLK);
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