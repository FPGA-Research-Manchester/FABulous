//DK2_eFPGA_RISCV_top

module DK2_eFPGA_RISV_top #(
parameter XX)
   (CLK_IO,
    ... (FPGA IOs to external TSMC pads, i.e, PDUW0208SCDG)
    ... (CPU IOs to external TSMC pads, i.e, PDUW0208SCDG)
    VDD,
    VSS
);

input CLK_IO;
....
inout VDD;
inout VSS;

//Wire connections between eFPGA and CPU
Wire clk;
....

//Insert buffer if necessary
//i.e, BUFFD12BWP7T (.I(clk), .Z(clk_eFPGA));
//i.e, BUFFD12BWP7T (.I(clk), .Z(clk_cpu));

//Dirk's Block
eFPGA_top eFPGA_block(..[wires to CPU], [wires to TSMC Pads] ..]);

eFPGA_top Inst_eFPGA_top( 
	Port (
	// -- External USER ports 
	wire 	I_top	:	 out STD_LOGIC_VECTOR (16 -1 downto 0); 
		T_top	:	 out STD_LOGIC_VECTOR (16 -1 downto 0); 
		O_top	:	 in STD_LOGIC_VECTOR (16 -1 downto 0); 
		
		OPA		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		OPB		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES0	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES1	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES2	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		CLK	    : 	in		STD_LOGIC;							-- This clock can go to the CPU (connects to the fabric LUT output flops
		
	-- CPU configuration port
		WriteStrobe:	in		STD_LOGIC; -- must decode address and write enable
		WriteData:		in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- configuration data write port
		
	-- UART configuration port
		Rx:				in		STD_LOGIC; 
        ComActive:      out STD_LOGIC;
        ReceiveLED:     out STD_LOGIC
		);
end entity eFPGA_top ;


//Andrew's Block
forte_soc_top RISCV_block(..[wires to eFPGA], [wires to TSMC Pads] ..]);

//TSMC Pads
//=================
// IE:  Input enable
// C:   Output signal to core
// PE:  Pull enable
// DS:  Driving selector, DS=1 enables higher driving current
// OEN: Output enable (active low)
// PAD: Signal pin on pad side
// i.e: 
//=================

// Common pads
PDUW0208SCDG CLK_PAD (.IE(VDD), .C(clk), .PE(VSS), .DS(VSS), I.(VSS), OEN(VDD), .PAD(CLK_IO));
...
//eFPGA pads
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[0]), .PE(VDD), .DS(VDD), I.(I_top[0]), OEN(T_top[0]), .PAD(PAD[0]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[1]), .PE(VDD), .DS(VDD), I.(I_top[1]), OEN(T_top[1]), .PAD(PAD[1]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[2]), .PE(VDD), .DS(VDD), I.(I_top[2]), OEN(T_top[2]), .PAD(PAD[2]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[3]), .PE(VDD), .DS(VDD), I.(I_top[3]), OEN(T_top[3]), .PAD(PAD[3]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[4]), .PE(VDD), .DS(VDD), I.(I_top[4]), OEN(T_top[4]), .PAD(PAD[4]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[5]), .PE(VDD), .DS(VDD), I.(I_top[5]), OEN(T_top[5]), .PAD(PAD[5]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[6]), .PE(VDD), .DS(VDD), I.(I_top[6]), OEN(T_top[6]), .PAD(PAD[6]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[7]), .PE(VDD), .DS(VDD), I.(I_top[7]), OEN(T_top[7]), .PAD(PAD[7]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+0]), .PE(VDD), .DS(VDD), I.(I_top[8+0]), OEN(T_top[8+0]), .PAD(PAD[8+0]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+1]), .PE(VDD), .DS(VDD), I.(I_top[8+1]), OEN(T_top[8+1]), .PAD(PAD[8+1]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+2]), .PE(VDD), .DS(VDD), I.(I_top[8+2]), OEN(T_top[8+2]), .PAD(PAD[8+2]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+3]), .PE(VDD), .DS(VDD), I.(I_top[8+3]), OEN(T_top[8+3]), .PAD(PAD[8+3]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+4]), .PE(VDD), .DS(VDD), I.(I_top[8+4]), OEN(T_top[8+4]), .PAD(PAD[8+4]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+5]), .PE(VDD), .DS(VDD), I.(I_top[8+5]), OEN(T_top[8+5]), .PAD(PAD[8+5]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+6]), .PE(VDD), .DS(VDD), I.(I_top[8+6]), OEN(T_top[8+6]), .PAD(PAD[8+6]));
PDUW0208SCDG eFPGA_PAD1_SigName_0 (.IE(VDD), .C(O_top[8+7]), .PE(VDD), .DS(VDD), I.(I_top[8+7]), OEN(T_top[8+7]), .PAD(PAD[8+7]));
...
//CPU pads
PDUW0208SCDG CPU_PAD1_SigName (.IE(), .C(), .PE(), .DS(), I.(), OEN(), .PAD());
...



endmodule
