library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  eFPGA  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 0 );
	Port (
	-- External IO ports exported directly from the corresponding tiles
		Tile_X0Y1_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		UserCLK	:	 in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		Tile_X0Y1_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y1_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y1_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y2_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y2_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y2_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y2_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y3_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y3_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y3_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y3_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y4_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y4_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y4_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y4_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y5_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y5_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y5_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y5_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y6_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y6_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y6_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y6_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y7_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y7_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y7_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y7_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X0Y8_A_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X0Y8_B_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		Tile_X7Y8_OPA_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPA_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPA_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPA_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPB_I0	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPB_I1	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPB_I2	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_OPB_I3	:	 in	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES0_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES0_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES0_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES0_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES1_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES1_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES1_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES1_O3	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES2_O0	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES2_O1	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES2_O2	:	 out	STD_LOGIC; -- EXTERNAL
		Tile_X7Y8_RES2_O3	:	 out	STD_LOGIC; -- EXTERNAL
		 FrameData:     in  STD_LOGIC_VECTOR( (FrameBitsPerRow * 10) -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( (MaxFramesPerCol * 8) -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end entity eFPGA ;

architecture Behavioral of  eFPGA  is 

component  N_term_single  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 0 );
	Port (
	--  NORTH
		 N1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:NULL destination_name:N1END  
		 N2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:NULL destination_name:N2MID  
		 N2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:NULL destination_name:N2END  
		 N4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:NULL destination_name:N4END  
		 Ci 	: in 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:NULL destination_name:Ci  
	--  EAST
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:NULL  
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:NULL  
		 S2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:NULL  
		 S4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 ) 	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:NULL  
	--  WEST

	-- global
	);
end component N_term_single ;

component  W_IO  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 12 );
	Port (
	--  NORTH
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:NULL  
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:NULL  
		 E2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:NULL  
		 E6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:NULL  
	--  SOUTH
	--  WEST
		 W1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W1END  
		 W2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2MID  
		 W2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2END  
		 W6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:NULL destination_name:W6END  
	-- Tile IO ports from BELs
		 A_PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
		 UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		 B_PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end component W_IO ;

component  LUT4AB  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 538 );
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
		 Co 	: out 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:Co destination_name:Ci  
		 N1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
		 Ci 	: in 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:Co destination_name:Ci  
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
		 E2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
		 E6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
		 E6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
		 S2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
		 S4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
		 S1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
		 S2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
		 S4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
		 W2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
		 W6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
		 W1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
		 W2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
		 W6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	-- Tile IO ports from BELs
		 UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this sisgnal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end component LUT4AB ;

component  CPU_IO  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 20 );
	Port (
	--  NORTH
	--  EAST
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:NULL destination_name:E1END  
		 E2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2MID  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2END  
		 E6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:NULL destination_name:E6END  
	--  SOUTH
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:NULL  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:NULL  
		 W2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:NULL  
		 W6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:NULL  
	-- Tile IO ports from BELs
		 OPA_I0	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I1	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I2	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I3	: in	STD_LOGIC; -- EXTERNAL
		 UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		 OPB_I0	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I1	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I2	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I3	: in	STD_LOGIC; -- EXTERNAL
		 RES0_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O3	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O3	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O3	: out	STD_LOGIC; -- EXTERNAL
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end component CPU_IO ;

component  S_term_single  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 0 );
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:NULL  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:NULL  
		 N2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:NULL  
		 N4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:NULL  
		 Co 	: out 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:Co destination_name:NULL  
	--  EAST
	--  SOUTH
		 S1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S1END  
		 S2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2MID  
		 S2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2END  
		 S4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 ) 	 -- wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:S4END  
	--  WEST

	-- global
	);
end component S_term_single ;


-- signal declarations


-- configuration signal declarations

signal Tile_Y0_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y1_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y2_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y3_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y4_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y5_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y6_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y7_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y8_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_Y9_FrameData 	:	 std_logic_vector(FrameBitsPerRow -1 downto 0);
signal Tile_X0_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X1_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X2_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X3_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X4_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X5_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X6_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);
signal Tile_X7_FrameStrobe 	:	 std_logic_vector(MaxFramesPerCol -1 downto 0);

-- tile-to-tile signal declarations

signal Tile_X1Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X2Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X3Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X4Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X5Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X6Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y0_S4BEG	:	 std_logic_vector( 15 downto 0 ) 	 ;
signal Tile_X0Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y1_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y1_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y1_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y1_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y1_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y1_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y1_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y1_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y1_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y1_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y1_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y2_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y2_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y2_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y2_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y2_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y2_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y2_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y2_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y2_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y4_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y4_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y4_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y4_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y4_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y4_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y4_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y4_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y5_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y5_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y5_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y5_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y5_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y5_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y5_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y5_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y5_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y5_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y5_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y6_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y6_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y6_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y6_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y6_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y6_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y6_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y6_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y6_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y6_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y6_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y7_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y7_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y7_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y7_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y7_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y7_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y7_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y7_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y7_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y7_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y7_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X0Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X0Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X0Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X1Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X2Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X3Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X4Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X5Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y8_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y8_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y8_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y8_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y8_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y8_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y8_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X7Y8_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y8_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y8_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y8_W6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X1Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X1Y9_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X2Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y9_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X3Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y9_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X4Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y9_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y9_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y9_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y9_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y9_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y9_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y9_Co	:	 std_logic_vector( 0 downto 0 );

begin

Tile_Y0_FrameData 	<=	 FrameData((FrameBitsPerRow*(0+1)) -1 downto FrameBitsPerRow*0);
Tile_Y1_FrameData 	<=	 FrameData((FrameBitsPerRow*(1+1)) -1 downto FrameBitsPerRow*1);
Tile_Y2_FrameData 	<=	 FrameData((FrameBitsPerRow*(2+1)) -1 downto FrameBitsPerRow*2);
Tile_Y3_FrameData 	<=	 FrameData((FrameBitsPerRow*(3+1)) -1 downto FrameBitsPerRow*3);
Tile_Y4_FrameData 	<=	 FrameData((FrameBitsPerRow*(4+1)) -1 downto FrameBitsPerRow*4);
Tile_Y5_FrameData 	<=	 FrameData((FrameBitsPerRow*(5+1)) -1 downto FrameBitsPerRow*5);
Tile_Y6_FrameData 	<=	 FrameData((FrameBitsPerRow*(6+1)) -1 downto FrameBitsPerRow*6);
Tile_Y7_FrameData 	<=	 FrameData((FrameBitsPerRow*(7+1)) -1 downto FrameBitsPerRow*7);
Tile_Y8_FrameData 	<=	 FrameData((FrameBitsPerRow*(8+1)) -1 downto FrameBitsPerRow*8);
Tile_Y9_FrameData 	<=	 FrameData((FrameBitsPerRow*(9+1)) -1 downto FrameBitsPerRow*9);
Tile_X0_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(0+1)) -1 downto MaxFramesPerCol*0);
Tile_X1_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(1+1)) -1 downto MaxFramesPerCol*1);
Tile_X2_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(2+1)) -1 downto MaxFramesPerCol*2);
Tile_X3_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(3+1)) -1 downto MaxFramesPerCol*3);
Tile_X4_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(4+1)) -1 downto MaxFramesPerCol*4);
Tile_X5_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(5+1)) -1 downto MaxFramesPerCol*5);
Tile_X6_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(6+1)) -1 downto MaxFramesPerCol*6);
Tile_X7_FrameStrobe 	<=	 FrameStrobe((MaxFramesPerCol*(7+1)) -1 downto MaxFramesPerCol*7);
-- tile instantiations

Tile_X1Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X1Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X1Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X2Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X2Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X2Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X3Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X3Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X3Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X4Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X4Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X4Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X5Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X5Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X5Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X6Y0_N_term_single : N_term_single
	Port Map(
	N1END	=> Tile_X6Y1_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y1_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y1_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y1_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y1_Co( 0 downto 0 ),
	S1BEG	=> Tile_X6Y0_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y0_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y0_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y0_S4BEG( 15 downto 0 ) 	  
		 );

Tile_X0Y1_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y1_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y1_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y1_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y1_B_PAD ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X2Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X3Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X4Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X5Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X6Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y1_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y2_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y2_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y2_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y2_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y2_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y1_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y0_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y0_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y0_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y0_S4BEG( 15 downto 0 ) 	 ,
	W1END	=> Tile_X7Y1_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y1_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y1_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y1_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y1_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y1_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y1_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y1_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y1_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y1_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y1_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y1_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y1_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y1_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y1_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y1_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y1_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y1_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y1_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y1_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y1_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y1_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y1_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y1_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y1_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y1_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y1_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y1_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y1_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y1_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y1_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y1_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y1_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y1_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y1_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y1_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y1_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y1_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y1_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y1_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y1_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y1_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y1_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y1_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y1_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y1_RES2_O3 ,
		FrameData  	 =>	 Tile_Y1_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y2_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y2_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y2_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y2_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y2_B_PAD ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y2_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y3_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y3_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y3_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y3_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y3_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y2_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y1_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y1_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y1_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y1_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y2_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y2_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y2_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y2_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y2_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y2_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y2_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y2_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y2_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y2_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y2_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y2_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y2_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y2_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y2_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y2_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y2_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y2_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y2_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y2_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y2_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y2_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y2_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y2_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y2_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y2_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y2_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y2_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y2_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y2_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y2_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y2_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y2_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y2_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y2_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y2_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y2_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y2_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y2_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y2_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y2_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y2_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y2_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y2_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y2_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y2_RES2_O3 ,
		FrameData  	 =>	 Tile_Y2_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y3_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y3_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y3_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y3_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y3_B_PAD ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y3_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y3_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y3_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y3_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y3_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y3_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y3_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y3_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y3_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y3_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y3_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y3_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y3_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y3_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y3_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y3_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y3_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y3_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y3_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y3_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y3_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y3_RES2_O3 ,
		FrameData  	 =>	 Tile_Y3_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y4_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y4_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y4_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y4_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y4_B_PAD ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y4_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y5_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y5_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y5_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y5_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y5_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y4_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y3_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y3_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y3_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y3_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y4_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y4_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y4_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y4_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y4_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y4_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y4_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y4_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y4_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y4_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y4_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y4_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y4_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y4_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y4_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y4_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y4_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y4_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y4_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y4_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y4_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y4_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y4_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y4_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y4_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y4_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y4_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y4_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y4_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y4_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y4_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y4_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y4_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y4_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y4_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y4_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y4_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y4_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y4_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y4_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y4_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y4_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y4_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y4_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y4_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y4_RES2_O3 ,
		FrameData  	 =>	 Tile_Y4_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y5_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y5_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y5_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y5_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y5_B_PAD ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y5_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y6_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y6_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y6_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y6_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y6_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y5_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y4_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y4_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y4_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y4_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y5_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y5_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y5_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y5_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y5_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y5_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y5_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y5_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y5_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y5_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y5_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y5_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y5_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y5_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y5_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y5_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y5_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y5_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y5_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y5_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y5_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y5_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y5_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y5_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y5_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y5_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y5_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y5_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y5_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y5_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y5_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y5_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y5_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y5_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y5_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y5_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y5_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y5_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y5_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y5_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y5_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y5_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y5_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y5_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y5_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y5_RES2_O3 ,
		FrameData  	 =>	 Tile_Y5_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y6_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y6_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y6_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y6_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y6_B_PAD ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y6_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y7_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y7_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y7_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y7_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y7_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y6_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y5_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y5_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y5_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y5_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y6_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y6_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y6_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y6_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y6_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y6_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y6_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y6_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y6_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y6_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y6_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y6_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y6_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y6_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y6_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y6_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y6_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y6_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y6_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y6_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y6_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y6_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y6_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y6_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y6_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y6_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y6_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y6_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y6_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y6_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y6_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y6_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y6_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y6_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y6_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y6_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y6_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y6_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y6_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y6_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y6_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y6_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y6_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y6_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y6_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y6_RES2_O3 ,
		FrameData  	 =>	 Tile_Y6_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y7_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y7_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y7_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y7_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y7_B_PAD ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y7_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y8_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y8_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y8_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y8_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y8_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y7_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y6_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y6_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y6_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y6_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y7_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y7_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y7_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y7_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y7_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y7_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y7_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y7_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y7_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y7_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y7_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y7_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y7_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y7_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y7_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y7_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y7_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y7_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y7_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y7_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y7_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y7_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y7_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y7_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y7_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y7_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y7_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y7_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y7_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y7_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y7_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y7_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y7_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y7_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y7_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y7_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y7_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y7_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y7_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y7_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y7_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y7_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y7_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y7_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y7_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y7_RES2_O3 ,
		FrameData  	 =>	 Tile_Y7_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X0Y8_W_IO : W_IO
	Port Map(
	W1END	=> Tile_X1Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X1Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X1Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X1Y8_W6BEG( 11 downto 0 ),
	E1BEG	=> Tile_X0Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X0Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X0Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X0Y8_E6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		A_PAD =>  Tile_X0Y8_A_PAD ,
		UserCLK =>  UserCLK ,
		B_PAD =>  Tile_X0Y8_B_PAD ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X0_FrameStrobe  ); 

Tile_X1Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X1Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X1Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X1Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X1Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X1Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X0Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X0Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X0Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X0Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X1Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X2Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X2Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X2Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X2Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X1Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X1Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X1Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X1Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X1Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X1Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X1Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X1Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X1Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X1Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X1Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X1Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X1Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X1_FrameStrobe  ); 

Tile_X2Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X2Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X2Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X2Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X2Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X2Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X1Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X1Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X1Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X1Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X2Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X3Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X3Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X3Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X3Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X2Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X2Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X2Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X2Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X2Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X2Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X2Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X2Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X2Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X2Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X2Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X2Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X2Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X2_FrameStrobe  ); 

Tile_X3Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X3Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X3Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X3Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X3Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X3Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X2Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X2Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X2Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X2Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X3Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X4Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X4Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X4Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X4Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X3Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X3Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X3Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X3Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X3Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X3Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X3Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X3Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X3Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X3Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X3Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X3Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X3Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X3_FrameStrobe  ); 

Tile_X4Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X4Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X4Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X4Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X4Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X4Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X3Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X3Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X3Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X3Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X4Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X5Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X5Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X5Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X5Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X4Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X4Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X4Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X4Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X4Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X4Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X4Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X4Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X4Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X4Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X4Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X4Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X4Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X4_FrameStrobe  ); 

Tile_X5Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X5Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X5Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X5Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X5Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X5Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X4Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X4Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X4Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X4Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X5Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X6Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X6Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X6Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X6Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X5Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X5Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X5Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X5Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X5Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X5Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X5Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X5Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X5Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X5Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X5Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X5Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X5Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X5_FrameStrobe  ); 

Tile_X6Y8_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y9_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y9_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y9_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y9_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y9_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y8_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y7_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y7_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y7_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y7_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y8_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y8_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y8_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y8_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y8_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y8_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y8_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y8_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y8_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y8_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y8_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y8_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y8_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y8_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y8_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y8_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y8_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  UserCLK ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X6_FrameStrobe  ); 

Tile_X7Y8_CPU_IO : CPU_IO
	Port Map(
	E1END	=> Tile_X6Y8_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X6Y8_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X6Y8_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X6Y8_E6BEG( 11 downto 0 ),
	W1BEG	=> Tile_X7Y8_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X7Y8_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X7Y8_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X7Y8_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		OPA_I0 =>  Tile_X7Y8_OPA_I0 ,
		OPA_I1 =>  Tile_X7Y8_OPA_I1 ,
		OPA_I2 =>  Tile_X7Y8_OPA_I2 ,
		OPA_I3 =>  Tile_X7Y8_OPA_I3 ,
		UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y8_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y8_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y8_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y8_OPB_I3 ,
		RES0_O0 =>  Tile_X7Y8_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y8_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y8_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y8_RES0_O3 ,
		RES1_O0 =>  Tile_X7Y8_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y8_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y8_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y8_RES1_O3 ,
		RES2_O0 =>  Tile_X7Y8_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y8_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y8_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y8_RES2_O3 ,
		FrameData  	 =>	 Tile_Y8_FrameData, 
		FrameStrobe 	 =>	 Tile_X7_FrameStrobe  ); 

Tile_X1Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X1Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X1Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X1Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X1Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X1Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X1Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X1Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X1Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X1Y9_Co( 0 downto 0 ) 
		 );

Tile_X2Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X2Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X2Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X2Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X2Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X2Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X2Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X2Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X2Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X2Y9_Co( 0 downto 0 ) 
		 );

Tile_X3Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X3Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X3Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X3Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X3Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X3Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X3Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X3Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X3Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X3Y9_Co( 0 downto 0 ) 
		 );

Tile_X4Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X4Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X4Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X4Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X4Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X4Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X4Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X4Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X4Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X4Y9_Co( 0 downto 0 ) 
		 );

Tile_X5Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X5Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X5Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X5Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X5Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X5Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X5Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X5Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X5Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X5Y9_Co( 0 downto 0 ) 
		 );

Tile_X6Y9_S_term_single : S_term_single
	Port Map(
	S1END	=> Tile_X6Y8_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y8_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y8_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y8_S4BEG( 15 downto 0 ),
	N1BEG	=> Tile_X6Y9_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y9_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y9_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y9_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y9_Co( 0 downto 0 ) 
		 );


end Behavioral;

