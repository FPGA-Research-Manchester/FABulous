`timescale 1ns/1ps
module tb_eFPGA_top();

parameter clk_send_period = 250;
parameter NumberOfRows = 12;
parameter NumberOfNumberOfCols = 13;
parameter FrameBitsPerRow = 32;
parameter MaxFramesPerCol = 20;
parameter mem_size = MaxFramesPerCol*NumberOfNumberOfCols*(NumberOfRows+1)+5;

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
wire tb_Rx = 1'b0;
wire tb_ReceiveLED = 1'b0;
wire tb_ComActive = 1'b0;
//BitBang configuration port
wire  tb_s_clk = 1'b0;
wire  tb_s_data = 1'b0;

integer read_file_descriptor;

wire [15:0] counter_output;
//reg [3:0] a,b;
//reg cin;
//wire cout;
//wire [3:0] sum;
//wire [4:0] full;

always begin
    tb_CLK = 1'b1;
    #10;
    tb_CLK = 1'b0;
    #10;
end

task open_file();
    begin
    $display("Opening file");
    read_file_descriptor=$fopen("D:/VituralMachine/shared_folder/fabric_test/eFAB_v2/fabric_v2_12x11_Sep10/bitstream/sequential_16bit_output_updated.bin","rb");
    //read_file_descriptor=$fopen("D:/VituralMachine/shared_folder/fabric_test/eFAB_v2/fabric_v2_12x11_Sep10/bitstream/full_adder_output.bin","rb");
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
    //a = 4'b0000;
    //b = 4'b0000;
    //cin = 1'b0;
end :tb_parallel_data

integer tb_parallel_i = 0;
integer counter=0;
//integer mem_size_val = mem_size;

always @ (posedge tb_CLK)
begin
    tb_WriteData <= 31'b0;
    tb_WriteStrobe <= 1'b0;
    if (tb_parallel_i%10==5) begin
        if (counter < mem_size) begin
            tb_WriteData <= mem [counter];
            tb_WriteStrobe <= 1'b1;
            counter <= counter + 1;
        //end else begin
            //a <= a+2;
            //b <= b+1;
            //if (b == 4'b1000) begin
                //cin <= 1'b1;
            //end
        end     
    end
    tb_parallel_i <= tb_parallel_i+1;
end

assign counter_output = {tb_I_top[12], tb_I_top[19], tb_I_top[17], tb_I_top[22], tb_I_top[20], tb_I_top[21], tb_I_top[23], tb_I_top[18], tb_I_top[14], tb_I_top[11], tb_I_top[16], tb_I_top[15], tb_I_top[10], tb_I_top[9], tb_I_top[8], tb_I_top[13]};

//assign {tb_O_top[19], tb_O_top[23], tb_O_top[14], tb_O_top[11]} = a;
//assign {tb_O_top[21], tb_O_top[22], tb_O_top[16], tb_O_top[13]} = b;
//assign tb_O_top[10] = cin;
//assign cout = tb_I_top[20];
//assign sum = {tb_I_top[18], tb_I_top[17], tb_I_top[15], tb_I_top[12]};
//assign full = {cout,sum};

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