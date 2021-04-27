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


module eFPGA_top (I_top, T_top, O_top, OPA, OPB, RES0, RES1, RES2, CLK, SelfWriteStrobe, SelfWriteData, Rx, ComActive, ReceiveLED, s_clk, s_data);
	// External USER ports 
	//inout [16-1:0] PAD; // these are for Dirk and go to the pad ring
	output [32-1:0] I_top; 
	output [32-1:0] T_top;
	input [32-1:0] O_top;

	input [64-1:0] OPA; // these are for Andrew	and go to the CPU
	input [64-1:0] OPB; // these are for Andrew	and go to the CPU
	output [64-1:0] RES0; // these are for Andrew	and go to the CPU
	output [64-1:0] RES1; // these are for Andrew	and go to the CPU
	output [64-1:0] RES2; // these are for Andrew	and go to the CPU
	input CLK; // This clock can go to the CPU (connects to the fabric LUT output flops

	// CPU configuration port
	input SelfWriteStrobe; // must decode address and write enable
	input [32-1:0] SelfWriteData; // configuration data write port

	// UART configuration port
	input Rx;
	output ComActive;
	output ReceiveLED;

	// BitBang configuration port
	input s_clk;
	input s_data;

	parameter include_eFPGA = 1;
	parameter NumberOfRows = 16;
	parameter NumberOfCols = 19;
	parameter FrameBitsPerRow = 32;
	parameter MaxFramesPerCol = 20;
	parameter desync_flag = 20;
	parameter FrameSelectWidth = 5;
	parameter RowSelectWidth = 5;

	// Signal declarations
	wire [(NumberOfRows*FrameBitsPerRow)-1:0] FrameRegister;

	wire [(MaxFramesPerCol*NumberOfCols)-1:0] FrameSelect;

	wire [(FrameBitsPerRow*(NumberOfRows+2))-1:0] FrameData;

	wire [FrameBitsPerRow-1:0] FrameAddressRegister;
	wire LongFrameStrobe;
	wire [31:0] LocalWriteData;
	wire LocalWriteStrobe;
	wire [RowSelectWidth-1:0] RowSelect;


Config Config_inst (
	.CLK(CLK),
	.Rx(Rx),
	.ComActive(ComActive),
	.ReceiveLED(ReceiveLED),
	.s_clk(s_clk),
	.s_data(s_data),
	.SelfWriteData(SelfWriteData),
	.SelfWriteStrobe(SelfWriteStrobe),
	
	.ConfigWriteData(LocalWriteData),
	.ConfigWriteStrobe(LocalWriteStrobe),
	
	.FrameAddressRegister(FrameAddressRegister),
	.LongFrameStrobe(LongFrameStrobe),
	.RowSelect(RowSelect)
);


	// L: if include_eFPGA = 1 generate

