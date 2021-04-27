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

module Frame_Select (FrameStrobe_I, FrameStrobe_O, FrameSelect, FrameStrobe);
	parameter MaxFramesPerCol = 20;
	parameter FrameSelectWidth = 5;
	parameter Col = 18;
	input [MaxFramesPerCol-1:0] FrameStrobe_I;
	output reg [MaxFramesPerCol-1:0] FrameStrobe_O;
	input [FrameSelectWidth-1:0] FrameSelect;
	input FrameStrobe;

//FrameStrobe_O = 0;
	always @ (*) begin
		if (FrameStrobe && (FrameSelect==Col)) 
			FrameStrobe_O =  FrameStrobe_I;
		else
			FrameStrobe_O = 'd0;
	end
endmodule