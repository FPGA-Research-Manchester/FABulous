

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  eFPGA_top  is 
	Port (
	-- External USER ports 
		--PAD		:	inout	STD_LOGIC_VECTOR (16 -1 downto 0);	-- these are for Dirk and go to the pad ring
		I_top	:	 out STD_LOGIC_VECTOR (16 -1 downto 0); 
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

architecture Behavioral of  eFPGA_top  is 

constant include_eFPGA	: integer := 1;
constant 	NumberOfRows 	: integer := 8;
constant 	NumberOfCols 	: integer := 10;
constant	FrameBitsPerRow : integer := 32;
constant	MaxFramesPerCol : integer := 20;
constant    desync_flag : integer := 20;

signal FrameRegister :       std_logic_vector((NumberOfRows*FrameBitsPerRow) -1 downto 0);
signal FrameAddressRegister: std_logic_vector(FrameBitsPerRow -1 downto 0);

signal FrameSelect : std_logic_vector((MaxFramesPerCol*NumberOfCols) -1 downto 0);

signal FrameShiftState : integer range 0 to (NumberOfRows + 2);
signal SyncState : std_logic := '0';

signal FrameStrobe	:	std_logic;
signal FrameStrobe0	:	std_logic;
signal FrameStrobe1	:	std_logic;

signal  FrameData :     STD_LOGIC_VECTOR( (FrameBitsPerRow * 10) -1 downto 0 ); 


component  eFPGA  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 0 );
	Port (
	-- External IO ports exported directly from the corresponding tiles
		Tile_X0Y1_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y1_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y1_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		UserCLK	:	 in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		Tile_X0Y1_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y1_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y1_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y1_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y1_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y2_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y2_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y2_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y3_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y3_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y3_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y4_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y4_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y4_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y5_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y5_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y5_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y6_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y6_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y6_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y7_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y7_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y7_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y8_A_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_A_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_A_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_B_I_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_B_T_top	:	 out STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_B_O_top	:	 in STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X9Y8_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X9Y8_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		 FrameData:     in  STD_LOGIC_VECTOR( (FrameBitsPerRow * 10) -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( (MaxFramesPerCol * NumberOfCols) -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end component eFPGA ;

component config_UART is
  generic ( Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                   -- bin is for faster binary mode, but might not work on all machines/boards
                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
		    ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port (
        CLK:           in  std_logic;
        Rx:            in  std_logic;
        WriteData:     out std_logic_vector(31 downto 0);
        ComActive:     out std_logic;
        WriteStrobe:   out std_logic;
		Command:       out std_logic_vector(7 downto 0);
        ReceiveLED:    out std_logic);
end component config_UART;


-- Signal declarations

signal UART_WriteData   : std_logic_vector (31 downto 0);
signal Command          : std_logic_vector (7 downto 0);
signal UART_WriteStrobe : std_logic;
signal UART_ComActive   : std_logic;
signal oldComActive     : std_logic;

signal LocalWriteData   : std_logic_vector (31 downto 0);
signal LocalWriteStrobe : std_logic;


BEGIN

INST_config_UART : config_UART 
   generic map ( Mode    => "auto", -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                   -- bin is for faster binary mode, but might not work on all machines/boards
                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
                                   
		    --ComRate => 217) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
		    ComRate => 25) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
		    
        port map (
        CLK                => CLK,
        Rx                 => Rx,
        WriteData          => UART_WriteData,
        ComActive          => UART_ComActive,
        WriteStrobe        => UART_WriteStrobe,
		Command            => Command,
        ReceiveLED         => ReceiveLED
        );

-- ComActive is used to switch between parallel port or UART (UART has therefore higher priority
LocalWriteData   <= UART_WriteData   when (UART_ComActive = '1') else WriteData;
LocalWriteStrobe <= UART_WriteStrobe when (UART_ComActive = '1') else WriteStrobe;

P_ComActiveReg:process(clk)
begin
  if clk'event AND clk='1' then
     oldComActive <= UART_ComActive;
  end if;
end process;

P_FSM:process(clk)
begin
  if clk'event AND clk='1' then

    FrameStrobe <= '0';
    -- we only activate the configuration after detecting a 32-bit aligned pattern "x"FAB0_FAB1"
    -- this allows placing the com-port header into the file and we can use the same file for parallel or UART configuration
    -- this also allows us to place whatever metadata, the only point to remeber is that the pattern/file needs to be 4-byte padded in the header
	if (FrameShiftState = 0) and (LocalWriteStrobe = '1') then
	   if (SyncState = '0') and (LocalWriteData = x"FAB0_FAB1") then
            SyncState <= '1';
       elsif (SyncState = '1') and (LocalWriteData(desync_flag) = '1') then
            SyncState <= '0';
       elsif (SyncState = '1') then
		    -- this will be the frame address FADR register
            FrameAddressRegister <= LocalWriteData;
            FrameStrobe <= '0';
            FrameShiftState <= NumberOfRows  ;
	   end if;
	end if;
	if (FrameShiftState > 1) and (LocalWriteStrobe = '1') then
		-- get frame row-by-row

		FrameStrobe <= '0';
		FrameShiftState <= FrameShiftState -1 ;
	end if;
	if (FrameShiftState = 1) and (LocalWriteStrobe = '1') then
		-- get last frame ant trigger FrameStrobe
		FrameStrobe <= '1';
		FrameShiftState <= FrameShiftState -1 ;
	end if;
	
	-- at the cycle, ComActive gets activated, we reset the state machine
	if (oldComActive = '0') and (UART_ComActive = '1') then
		FrameStrobe <= '0';
		FrameShiftState <= 0;
		SyncState <= '0';
	end if;
	
  end if;--clk
end process;


L_RowRegister: for k in 0 to NumberOfRows-1 generate
	P_FrameReg:process(clk)
	begin
		if clk'event AND clk='1' then
			if (FrameShiftState = (k+1)) and (LocalWriteStrobe = '1') then
				-- get frame row-by-row
				FrameRegister(((k+1)*FrameBitsPerRow) -1 downto ((k)*FrameBitsPerRow)) <= LocalWriteData;
			end if;
		end if;--clk
	end process;
end generate;

P_StrobeREG:process(clk)
begin
  if clk'event AND clk='1' then
	FrameStrobe0 <= FrameStrobe;
	FrameStrobe1 <= FrameStrobe0;
  end if;--clk
end process;

process (FrameAddressRegister, FrameStrobe0, FrameStrobe1)
begin
-- normally setting FrameSelect to zero and then selectively setting it back should work...
FrameSelect <= (others =>'0');
	-- we activate strobe for two clock cycles to relax timing
	if FrameStrobe0='1' or FrameStrobe1='1' then
		for k in 0 to NumberOfCols-1 loop
				-- the FrameSelect MSBs select the MJA (which col)
			if FrameAddressRegister((FrameAddressRegister'high +1) - NumberOfCols + k) = '1' then
				-- the FrameSelect LSBs select the MNA (which frame within a col)
				FrameSelect(((MaxFramesPerCol)*(k+1)) -1 downto MaxFramesPerCol*k) <= FrameAddressRegister(MaxFramesPerCol-1 downto 0);
			end if;
		end loop;
	end if;
end process;



-- L: if include_eFPGA = 1 generate

Inst_eFPGA :  eFPGA 
	Port Map(

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep PAD
  Tile_X0Y1_A_I_top         =>	I_top(15 ),
  Tile_X0Y1_B_I_top         =>	I_top(14 ),
  Tile_X0Y2_A_I_top         =>	I_top(13 ),
  Tile_X0Y2_B_I_top         =>	I_top(12 ),
  Tile_X0Y3_A_I_top         =>	I_top(11 ),
  Tile_X0Y3_B_I_top         =>	I_top(10 ),
  Tile_X0Y4_A_I_top         =>	I_top(9  ),
  Tile_X0Y4_B_I_top         =>	I_top(8  ),
  Tile_X0Y5_A_I_top         =>	I_top(7  ),
  Tile_X0Y5_B_I_top         =>	I_top(6  ),
  Tile_X0Y6_A_I_top         =>	I_top(5  ),
  Tile_X0Y6_B_I_top         =>	I_top(4  ),
  Tile_X0Y7_A_I_top         =>	I_top(3  ),
  Tile_X0Y7_B_I_top         =>	I_top(2  ),
  Tile_X0Y8_A_I_top         =>	I_top(1  ),
  Tile_X0Y8_B_I_top         =>	I_top(0  ),

  Tile_X0Y1_A_T_top         =>	T_top(15 ),
  Tile_X0Y1_B_T_top         =>	T_top(14 ),
  Tile_X0Y2_A_T_top         =>	T_top(13 ),
  Tile_X0Y2_B_T_top         =>	T_top(12 ),
  Tile_X0Y3_A_T_top         =>	T_top(11 ),
  Tile_X0Y3_B_T_top         =>	T_top(10 ),
  Tile_X0Y4_A_T_top         =>	T_top(9  ),
  Tile_X0Y4_B_T_top         =>	T_top(8  ),
  Tile_X0Y5_A_T_top         =>	T_top(7  ),
  Tile_X0Y5_B_T_top         =>	T_top(6  ),
  Tile_X0Y6_A_T_top         =>	T_top(5  ),
  Tile_X0Y6_B_T_top         =>	T_top(4  ),
  Tile_X0Y7_A_T_top         =>	T_top(3  ),
  Tile_X0Y7_B_T_top         =>	T_top(2  ),
  Tile_X0Y8_A_T_top         =>	T_top(1  ),
  Tile_X0Y8_B_T_top         =>	T_top(0  ),

  Tile_X0Y1_A_O_top         =>	O_top(15 ),
  Tile_X0Y1_B_O_top         =>	O_top(14 ),
  Tile_X0Y2_A_O_top         =>	O_top(13 ),
  Tile_X0Y2_B_O_top         =>	O_top(12 ),
  Tile_X0Y3_A_O_top         =>	O_top(11 ),
  Tile_X0Y3_B_O_top         =>	O_top(10 ),
  Tile_X0Y4_A_O_top         =>	O_top(9  ),
  Tile_X0Y4_B_O_top         =>	O_top(8  ),
  Tile_X0Y5_A_O_top         =>	O_top(7  ),
  Tile_X0Y5_B_O_top         =>	O_top(6  ),
  Tile_X0Y6_A_O_top         =>	O_top(5  ),
  Tile_X0Y6_B_O_top         =>	O_top(4  ),
  Tile_X0Y7_A_O_top         =>	O_top(3  ),
  Tile_X0Y7_B_O_top         =>	O_top(2  ),
  Tile_X0Y8_A_O_top         =>	O_top(1  ),
  Tile_X0Y8_B_O_top         =>	O_top(0  ),

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep OPA
  Tile_X9Y1_OPA_I0        =>	OPA(31 ),	
  Tile_X9Y1_OPA_I1        =>	OPA(30 ),
  Tile_X9Y1_OPA_I2        =>	OPA(29 ),
  Tile_X9Y1_OPA_I3        =>	OPA(28 ),
  Tile_X9Y2_OPA_I0        =>	OPA(27 ),
  Tile_X9Y2_OPA_I1        =>	OPA(26 ),
  Tile_X9Y2_OPA_I2        =>	OPA(25 ),
  Tile_X9Y2_OPA_I3        =>	OPA(24 ),
  Tile_X9Y3_OPA_I0        =>	OPA(23 ),
  Tile_X9Y3_OPA_I1        =>	OPA(22 ),
  Tile_X9Y3_OPA_I2        =>	OPA(21 ),
  Tile_X9Y3_OPA_I3        =>	OPA(20 ),
  Tile_X9Y4_OPA_I0        =>	OPA(19 ),
  Tile_X9Y4_OPA_I1        =>	OPA(18 ),
  Tile_X9Y4_OPA_I2        =>	OPA(17 ),
  Tile_X9Y4_OPA_I3        =>	OPA(16 ),
  Tile_X9Y5_OPA_I0        =>	OPA(15 ),
  Tile_X9Y5_OPA_I1        =>	OPA(14 ),
  Tile_X9Y5_OPA_I2        =>	OPA(13 ),
  Tile_X9Y5_OPA_I3        =>	OPA(12 ),
  Tile_X9Y6_OPA_I0        =>	OPA(11 ),
  Tile_X9Y6_OPA_I1        =>	OPA(10 ),
  Tile_X9Y6_OPA_I2        =>	OPA(9  ),
  Tile_X9Y6_OPA_I3        =>	OPA(8  ),
  Tile_X9Y7_OPA_I0        =>	OPA(7  ),
  Tile_X9Y7_OPA_I1        =>	OPA(6  ),
  Tile_X9Y7_OPA_I2        =>	OPA(5  ),
  Tile_X9Y7_OPA_I3        =>	OPA(4  ),
  Tile_X9Y8_OPA_I0        =>	OPA(3  ),
  Tile_X9Y8_OPA_I1        =>	OPA(2  ),
  Tile_X9Y8_OPA_I2        =>	OPA(1  ),
  Tile_X9Y8_OPA_I3        =>	OPA(0  ),
  
-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep OPB
  Tile_X9Y1_OPB_I0        =>	OPB(31 ),
  Tile_X9Y1_OPB_I1        =>	OPB(30 ),
  Tile_X9Y1_OPB_I2        =>	OPB(29 ),
  Tile_X9Y1_OPB_I3        =>	OPB(28 ),
  Tile_X9Y2_OPB_I0        =>	OPB(27 ),
  Tile_X9Y2_OPB_I1        =>	OPB(26 ),
  Tile_X9Y2_OPB_I2        =>	OPB(25 ),
  Tile_X9Y2_OPB_I3        =>	OPB(24 ),
  Tile_X9Y3_OPB_I0        =>	OPB(23 ),
  Tile_X9Y3_OPB_I1        =>	OPB(22 ),
  Tile_X9Y3_OPB_I2        =>	OPB(21 ),
  Tile_X9Y3_OPB_I3        =>	OPB(20 ),
  Tile_X9Y4_OPB_I0        =>	OPB(19 ),
  Tile_X9Y4_OPB_I1        =>	OPB(18 ),
  Tile_X9Y4_OPB_I2        =>	OPB(17 ),
  Tile_X9Y4_OPB_I3        =>	OPB(16 ),
  Tile_X9Y5_OPB_I0        =>	OPB(15 ),
  Tile_X9Y5_OPB_I1        =>	OPB(14 ),
  Tile_X9Y5_OPB_I2        =>	OPB(13 ),
  Tile_X9Y5_OPB_I3        =>	OPB(12 ),
  Tile_X9Y6_OPB_I0        =>	OPB(11 ),
  Tile_X9Y6_OPB_I1        =>	OPB(10 ),
  Tile_X9Y6_OPB_I2        =>	OPB(9  ),
  Tile_X9Y6_OPB_I3        =>	OPB(8  ),
  Tile_X9Y7_OPB_I0        =>	OPB(7  ),
  Tile_X9Y7_OPB_I1        =>	OPB(6  ),
  Tile_X9Y7_OPB_I2        =>	OPB(5  ),
  Tile_X9Y7_OPB_I3        =>	OPB(4  ),
  Tile_X9Y8_OPB_I0        =>	OPB(3  ),
  Tile_X9Y8_OPB_I1        =>	OPB(2  ),
  Tile_X9Y8_OPB_I2        =>	OPB(1  ),
  Tile_X9Y8_OPB_I3        =>	OPB(0  ),

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep RES0
  Tile_X9Y1_RES0_O0       =>	RES0(31 ),
  Tile_X9Y1_RES0_O1       =>    RES0(30 ),
  Tile_X9Y1_RES0_O2       =>    RES0(29 ),
  Tile_X9Y1_RES0_O3       =>    RES0(28 ),
  Tile_X9Y2_RES0_O0       =>    RES0(27 ),
  Tile_X9Y2_RES0_O1       =>    RES0(26 ),
  Tile_X9Y2_RES0_O2       =>    RES0(25 ),
  Tile_X9Y2_RES0_O3       =>    RES0(24 ),
  Tile_X9Y3_RES0_O0       =>    RES0(23 ),
  Tile_X9Y3_RES0_O1       =>    RES0(22 ),
  Tile_X9Y3_RES0_O2       =>    RES0(21 ),
  Tile_X9Y3_RES0_O3       =>    RES0(20 ),
  Tile_X9Y4_RES0_O0       =>    RES0(19 ),
  Tile_X9Y4_RES0_O1       =>    RES0(18 ),
  Tile_X9Y4_RES0_O2       =>    RES0(17 ),
  Tile_X9Y4_RES0_O3       =>    RES0(16 ),
  Tile_X9Y5_RES0_O0       =>    RES0(15 ),
  Tile_X9Y5_RES0_O1       =>    RES0(14 ),
  Tile_X9Y5_RES0_O2       =>    RES0(13 ),
  Tile_X9Y5_RES0_O3       =>    RES0(12 ),
  Tile_X9Y6_RES0_O0       =>    RES0(11 ),
  Tile_X9Y6_RES0_O1       =>    RES0(10 ),
  Tile_X9Y6_RES0_O2       =>    RES0(9  ),
  Tile_X9Y6_RES0_O3       =>    RES0(8  ),
  Tile_X9Y7_RES0_O0       =>    RES0(7  ),
  Tile_X9Y7_RES0_O1       =>    RES0(6  ),
  Tile_X9Y7_RES0_O2       =>    RES0(5  ),
  Tile_X9Y7_RES0_O3       =>    RES0(4  ),
  Tile_X9Y8_RES0_O0       =>    RES0(3  ),
  Tile_X9Y8_RES0_O1       =>    RES0(2  ),
  Tile_X9Y8_RES0_O2       =>    RES0(1  ),
  Tile_X9Y8_RES0_O3       =>    RES0(0  ),

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep RES1
  Tile_X9Y1_RES1_O0       =>	RES1(31 ),
  Tile_X9Y1_RES1_O1       =>    RES1(30 ),
  Tile_X9Y1_RES1_O2       =>    RES1(29 ),
  Tile_X9Y1_RES1_O3       =>    RES1(28 ),
  Tile_X9Y2_RES1_O0       =>    RES1(27 ),
  Tile_X9Y2_RES1_O1       =>    RES1(26 ),
  Tile_X9Y2_RES1_O2       =>    RES1(25 ),
  Tile_X9Y2_RES1_O3       =>    RES1(24 ),
  Tile_X9Y3_RES1_O0       =>    RES1(23 ),
  Tile_X9Y3_RES1_O1       =>    RES1(22 ),
  Tile_X9Y3_RES1_O2       =>    RES1(21 ),
  Tile_X9Y3_RES1_O3       =>    RES1(20 ),
  Tile_X9Y4_RES1_O0       =>    RES1(19 ),
  Tile_X9Y4_RES1_O1       =>    RES1(18 ),
  Tile_X9Y4_RES1_O2       =>    RES1(17 ),
  Tile_X9Y4_RES1_O3       =>    RES1(16 ),
  Tile_X9Y5_RES1_O0       =>    RES1(15 ),
  Tile_X9Y5_RES1_O1       =>    RES1(14 ),
  Tile_X9Y5_RES1_O2       =>    RES1(13 ),
  Tile_X9Y5_RES1_O3       =>    RES1(12 ),
  Tile_X9Y6_RES1_O0       =>    RES1(11 ),
  Tile_X9Y6_RES1_O1       =>    RES1(10 ),
  Tile_X9Y6_RES1_O2       =>    RES1(9  ),
  Tile_X9Y6_RES1_O3       =>    RES1(8  ),
  Tile_X9Y7_RES1_O0       =>    RES1(7  ),
  Tile_X9Y7_RES1_O1       =>    RES1(6  ),
  Tile_X9Y7_RES1_O2       =>    RES1(5  ),
  Tile_X9Y7_RES1_O3       =>    RES1(4  ),
  Tile_X9Y8_RES1_O0       =>    RES1(3  ),
  Tile_X9Y8_RES1_O1       =>    RES1(2  ),
  Tile_X9Y8_RES1_O2       =>    RES1(1  ),
  Tile_X9Y8_RES1_O3       =>    RES1(0  ),

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep RES2
  Tile_X9Y1_RES2_O0       =>	RES2(31 ),
  Tile_X9Y1_RES2_O1       =>    RES2(30 ),
  Tile_X9Y1_RES2_O2       =>    RES2(29 ),
  Tile_X9Y1_RES2_O3       =>    RES2(28 ),
  Tile_X9Y2_RES2_O0       =>    RES2(27 ),
  Tile_X9Y2_RES2_O1       =>    RES2(26 ),
  Tile_X9Y2_RES2_O2       =>    RES2(25 ),
  Tile_X9Y2_RES2_O3       =>    RES2(24 ),
  Tile_X9Y3_RES2_O0       =>    RES2(23 ),
  Tile_X9Y3_RES2_O1       =>    RES2(22 ),
  Tile_X9Y3_RES2_O2       =>    RES2(21 ),
  Tile_X9Y3_RES2_O3       =>    RES2(20 ),
  Tile_X9Y4_RES2_O0       =>    RES2(19 ),
  Tile_X9Y4_RES2_O1       =>    RES2(18 ),
  Tile_X9Y4_RES2_O2       =>    RES2(17 ),
  Tile_X9Y4_RES2_O3       =>    RES2(16 ),
  Tile_X9Y5_RES2_O0       =>    RES2(15 ),
  Tile_X9Y5_RES2_O1       =>    RES2(14 ),
  Tile_X9Y5_RES2_O2       =>    RES2(13 ),
  Tile_X9Y5_RES2_O3       =>    RES2(12 ),
  Tile_X9Y6_RES2_O0       =>    RES2(11 ),
  Tile_X9Y6_RES2_O1       =>    RES2(10 ),
  Tile_X9Y6_RES2_O2       =>    RES2(9  ),
  Tile_X9Y6_RES2_O3       =>    RES2(8  ),
  Tile_X9Y7_RES2_O0       =>    RES2(7  ),
  Tile_X9Y7_RES2_O1       =>    RES2(6  ),
  Tile_X9Y7_RES2_O2       =>    RES2(5  ),
  Tile_X9Y7_RES2_O3       =>    RES2(4  ),
  Tile_X9Y8_RES2_O0       =>    RES2(3  ),
  Tile_X9Y8_RES2_O1       =>    RES2(2  ),
  Tile_X9Y8_RES2_O2       =>    RES2(1  ),
  Tile_X9Y8_RES2_O3       =>    RES2(0  ),

-- R:\work\FORTE\FPGA\fabric>cat eFPGA_top.vhd | grep signal | sed 's/signal//1' | sed 's/:.*/=!/g' | tr "!" ">" | grep -v OP | grep -v RES | grep -v PAD
--  declarations
  UserCLK                 =>	CLK,
  FrameData               =>	FrameData,
  FrameStrobe             =>	FrameSelect		);
  
--end generate;

FrameData <= x"12345678" & FrameRegister & x"12345678";


end Behavioral;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	