`timescale 1ns/1ps
module tb_eFPGA_top();

parameter clk_send_period = 250;
parameter NumberOfRows = 10;
parameter NumberOfNumberOfCols = 12;
parameter FrameBitsPerRow = 32;
parameter MaxFramesPerCol = 20;
parameter mem_size = MaxFramesPerCol*NumberOfNumberOfCols*(NumberOfRows+1)+5;

parameter mode = 1; //serial: 0, parallel: 1

reg [FrameBitsPerRow-1:0] mem [mem_size-1:0];

wire [NumberOfRows*2-1:0] tb_I_top;
wire [NumberOfRows*2-1:0] tb_T_top;
wire [NumberOfRows*2-1:0] tb_O_top;
wire [NumberOfRows*4-1:0] tb_A_config_C;
wire [NumberOfRows*4-1:0] tb_B_config_C;
reg tb_CLK;

//////////////////////
// CPU configuration port
reg tb_WriteStrobe;
reg [FrameBitsPerRow-1:0] tb_WriteData;
// UART
reg tb_Rx = 1'b1;
wire tb_ReceiveLED = 1'b0;
wire tb_ComActive = 1'b0;
//BitBang configuration port
wire  tb_s_clk = 1'b0;
wire  tb_s_data = 1'b0;

integer read_file_descriptor;

reg tb_clk_send;
reg [7:0] next_byte;

//typedef enum{Word0, Word1, Word2, Word3} GetWordType;
//GetWordType GetWordState;
localparam Word0=0, Word1=1, Word2=2, Word3=3;
reg [1:0] GetWordState=Word0;

wire [15:0] counter_output;

always begin
    tb_CLK = 1'b1;
    #10;
    tb_CLK = 1'b0;
    #10;
end

always begin
    tb_clk_send = 1'b1;
    #250;
    tb_clk_send = 1'b0;
    #250;
end

task open_file();
    begin
    $display("Opening file");
    read_file_descriptor=$fopen("D:/VituralMachine/shared_folder/fabric_test/eFAB_v3/10x10/verilog_sim/bitstream/sequential_16bit_en_bram_output.bin","rb");
    end
endtask

task readBinFile2Mem ();
    integer n_Temp;
    begin
    n_Temp = $fread(mem, read_file_descriptor);
    $display("n_Temp = %0d",n_Temp);
    end
endtask

task close_file();
    begin
    $display("Closing the file");
    $fclose(read_file_descriptor);
    end
endtask

initial
begin :tb_parallel_data
    open_file;
    readBinFile2Mem;
    close_file;
    next_byte = 8'd0;
end :tb_parallel_data

if (mode) begin // parallel
	integer tb_parallel_i = 0;
	integer counter=0;
	//integer mem_size_val = mem_size;
	
	always @ (posedge tb_CLK)
	begin : L_serial
		tb_WriteData <= 31'b0;
		tb_WriteStrobe <= 1'b0;
		if (tb_parallel_i%10==5) begin
			if (counter < mem_size) begin
				tb_WriteData <= mem [counter];
				tb_WriteStrobe <= 1'b1;
				counter <= counter + 1;
			end
		end
		tb_parallel_i <= tb_parallel_i+1;
	end
end
else begin // serial
	integer tb_serial_i = 0;
	integer counter=0;
	integer byte_counter=0;
	
	always @ (posedge tb_clk_send) 
	begin : L_parallel
		if (tb_serial_i <= 19) begin
			tb_Rx <= 1'b1;
		end else if (tb_serial_i%10==0) begin
			if (counter < mem_size) begin
				tb_Rx <= 1'b0;
				case(GetWordState)
				Word0: begin
					next_byte <= mem[counter][31:24];
					GetWordState <= Word1;
				end
				Word1: begin
					next_byte <= mem[counter][23:16];
					GetWordState <= Word2;
				end
				Word2: begin
					next_byte <= mem[counter][15:8];
					GetWordState <= Word3;
				end
				Word3: begin
					next_byte <= mem[counter][7:0];
					GetWordState <= Word0;
					counter <= counter+1;
				end
				endcase
			end else begin
				next_byte <= 8'b11111111;
				tb_Rx <= 1'b1;
			end
		end else if (tb_serial_i%10==9) begin
			tb_Rx <= 1'b1;
		end else begin
			tb_Rx <= next_byte[(tb_serial_i%10)-1];
		end
		tb_serial_i <= tb_serial_i+1;
	end
end

assign counter_output = {tb_I_top[12], tb_I_top[19], tb_I_top[17], tb_I_top[22], tb_I_top[20], tb_I_top[21], tb_I_top[23], tb_I_top[18], tb_I_top[14], tb_I_top[11], tb_I_top[16], tb_I_top[15], tb_I_top[10], tb_I_top[9], tb_I_top[8], tb_I_top[13]};

	eFPGA_top eFPGA_inst(
		.I_top(tb_I_top),
		.T_top(tb_T_top),
		.O_top(tb_O_top),
		//PAD(tb_PAD),
		.A_config_C(tb_A_config_C),
		.B_config_C(tb_B_config_C),
		.CLK(tb_CLK),
		//CPU configuration port
		.SelfWriteStrobe	(tb_WriteStrobe),
		.SelfWriteData	(tb_WriteData),
		// UART
		.Rx(tb_Rx),
		.ComActive(tb_ComActive),
		.ReceiveLED(tb_ReceiveLED),
		//BitBang configuration port
		.s_clk(tb_s_clk),
		.s_data(tb_s_data)
	);

endmodule