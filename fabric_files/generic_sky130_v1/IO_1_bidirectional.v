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

//Library UNISIM;
//use UNISIM.vcomponents.all;

module IO_1_bidirectional (I, T, O, Q, PAD, UserCLK, MODE, CONFin, CONFout, CLK);
	// parameter LUT_SIZE = 4;	
	// Pin0
	input I; // from fabric to external pin
	input T; // tristate control
	output O; // from external pin to fabric
	output Q; // from external pin to fabric (registered)
	inout PAD; // EXTERNAL has to ge to top-level entity not the switch matrix
	// Tile IO ports from BELs
	input UserCLK; // EXTERNAL // SHARED_PORT // ## the EXTERNAL keyword will send this signal all the way to top and the //SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	input MODE; // 1 configuration, 0 action
	input CONFin;
	output CONFout;
	input CLK;

//                        _____
//    I////-T_DRIVER////->|PAD|//+//////-> O
//              |         ////-  |
//    T////////-+                +//>FF//> Q

// I am instantiating an IOBUF primitive.
// However, it is possible to connect corresponding pins all the way to top, just by adding an "// EXTERNAL" comment (see PAD in the entity)
	reg Q;
	wire fromPad;

	assign CONFout = CONFin;

// Slice outputs
	assign O = fromPad;

	always @ (posedge UserCLK)
	begin
		Q <= fromPad;
	end

	IOBUF IOBUF_inst0 (
	.O(fromPad),// 1-bit output: Buffer output
	.I(I),// 1-bit input: Buffer input
	.IO(PAD),// 1-bit inout: Buffer inout (connect directly to top-level port)
	.T(T)// 1-bit input: 3-state enable input
	);

endmodule
