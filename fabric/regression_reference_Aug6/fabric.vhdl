library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  eFPGA  is 
	Port (
	-- External IO ports exported directly from the corresponding tiles
		Tile_X0Y1_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
		UserCLK	:	 in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this sisgnal all the way to top
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
		Tile_X0Y2_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y3_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y4_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y5_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y6_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y7_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
		Tile_X0Y8_PAD	:	 inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
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
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity eFPGA ;
architecture Behavioral of  eFPGA  is 

component  N_term_single  is 
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
		 S4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:NULL  
	--  WEST
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component N_term_single ;

component  W_IO  is 
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
	 	PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	  	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this sisgnal all the way to top
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component W_IO ;

component  LUT4AB  is 
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
	 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component LUT4AB ;

component  CPU_IO  is 
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
	  	OPA_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	 	OPB_I0	: in	STD_LOGIC; -- EXTERNAL
	 	OPB_I1	: in	STD_LOGIC; -- EXTERNAL
	 	OPB_I2	: in	STD_LOGIC; -- EXTERNAL
	 	OPB_I3	: in	STD_LOGIC; -- EXTERNAL
	  	OPB_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	 	RES0_O0	: out	STD_LOGIC; -- EXTERNAL
	 	RES0_O1	: out	STD_LOGIC; -- EXTERNAL
	 	RES0_O2	: out	STD_LOGIC; -- EXTERNAL
	 	RES0_O3	: out	STD_LOGIC; -- EXTERNAL
	  	RES0_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	 	RES1_O0	: out	STD_LOGIC; -- EXTERNAL
	 	RES1_O1	: out	STD_LOGIC; -- EXTERNAL
	 	RES1_O2	: out	STD_LOGIC; -- EXTERNAL
	 	RES1_O3	: out	STD_LOGIC; -- EXTERNAL
	  	RES1_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	 	RES2_O0	: out	STD_LOGIC; -- EXTERNAL
	 	RES2_O1	: out	STD_LOGIC; -- EXTERNAL
	 	RES2_O2	: out	STD_LOGIC; -- EXTERNAL
	 	RES2_O3	: out	STD_LOGIC; -- EXTERNAL
	  	RES2_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component CPU_IO ;

component  S_term_single  is 
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
		 S4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:S4END  
	--  WEST
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component S_term_single ;

-- signal declarations

-- configuration signal declarations

signal	conf_data	:	STD_LOGIC_VECTOR(76 downto 0);

-- tile-to-tile signal declarations

signal Tile_X1Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X1Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X1Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X2Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X2Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X2Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X3Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X3Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X3Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X4Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X4Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X4Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X5Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y0_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y0_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y0_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y0_S4BEG	:	 std_logic_vector( 15 downto 0 );
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

-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity
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
	S4BEG	=> Tile_X1Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(0),  
		 CONFout	=> conf_data(1),  
		 CLK => CLK );  

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
	S4BEG	=> Tile_X2Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(1),  
		 CONFout	=> conf_data(2),  
		 CLK => CLK );  

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
	S4BEG	=> Tile_X3Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(2),  
		 CONFout	=> conf_data(3),  
		 CLK => CLK );  

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
	S4BEG	=> Tile_X4Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(3),  
		 CONFout	=> conf_data(4),  
		 CLK => CLK );  

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
	S4BEG	=> Tile_X5Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(4),  
		 CONFout	=> conf_data(5),  
		 CLK => CLK );  

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
	S4BEG	=> Tile_X6Y0_S4BEG( 15 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(5),  
		 CONFout	=> conf_data(6),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y1_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(6),  
		 CONFout	=> conf_data(7),  
		 CLK => CLK );  

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
	S4END	=> Tile_X1Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(7),  
		 CONFout	=> conf_data(8),  
		 CLK => CLK );  

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
	S4END	=> Tile_X2Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(8),  
		 CONFout	=> conf_data(9),  
		 CLK => CLK );  

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
	S4END	=> Tile_X3Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(9),  
		 CONFout	=> conf_data(10),  
		 CLK => CLK );  

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
	S4END	=> Tile_X4Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(10),  
		 CONFout	=> conf_data(11),  
		 CLK => CLK );  

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
	S4END	=> Tile_X5Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(11),  
		 CONFout	=> conf_data(12),  
		 CLK => CLK );  

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
	S4END	=> Tile_X6Y0_S4BEG( 15 downto 0 ),
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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(12),  
		 CONFout	=> conf_data(13),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y1_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y1_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y1_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y1_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y1_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y1_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y1_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y1_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y1_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y1_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y1_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y1_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y1_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y1_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y1_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y1_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(13),  
		 CONFout	=> conf_data(14),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y2_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(14),  
		 CONFout	=> conf_data(15),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(15),  
		 CONFout	=> conf_data(16),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(16),  
		 CONFout	=> conf_data(17),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(17),  
		 CONFout	=> conf_data(18),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(18),  
		 CONFout	=> conf_data(19),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(19),  
		 CONFout	=> conf_data(20),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(20),  
		 CONFout	=> conf_data(21),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y2_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y2_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y2_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y2_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y2_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y2_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y2_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y2_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y2_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y2_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y2_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y2_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y2_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y2_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y2_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y2_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(21),  
		 CONFout	=> conf_data(22),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y3_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(22),  
		 CONFout	=> conf_data(23),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(23),  
		 CONFout	=> conf_data(24),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(24),  
		 CONFout	=> conf_data(25),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(25),  
		 CONFout	=> conf_data(26),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(26),  
		 CONFout	=> conf_data(27),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(27),  
		 CONFout	=> conf_data(28),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(28),  
		 CONFout	=> conf_data(29),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y3_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y3_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y3_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y3_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y3_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y3_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y3_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y3_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y3_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y3_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y3_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y3_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y3_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y3_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y3_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y3_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(29),  
		 CONFout	=> conf_data(30),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y4_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(30),  
		 CONFout	=> conf_data(31),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(31),  
		 CONFout	=> conf_data(32),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(32),  
		 CONFout	=> conf_data(33),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(33),  
		 CONFout	=> conf_data(34),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(34),  
		 CONFout	=> conf_data(35),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(35),  
		 CONFout	=> conf_data(36),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(36),  
		 CONFout	=> conf_data(37),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y4_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y4_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y4_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y4_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y4_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y4_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y4_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y4_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y4_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y4_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y4_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y4_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y4_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y4_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y4_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y4_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(37),  
		 CONFout	=> conf_data(38),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y5_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(38),  
		 CONFout	=> conf_data(39),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(39),  
		 CONFout	=> conf_data(40),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(40),  
		 CONFout	=> conf_data(41),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(41),  
		 CONFout	=> conf_data(42),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(42),  
		 CONFout	=> conf_data(43),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(43),  
		 CONFout	=> conf_data(44),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(44),  
		 CONFout	=> conf_data(45),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y5_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y5_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y5_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y5_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y5_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y5_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y5_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y5_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y5_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y5_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y5_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y5_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y5_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y5_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y5_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y5_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(45),  
		 CONFout	=> conf_data(46),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y6_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(46),  
		 CONFout	=> conf_data(47),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(47),  
		 CONFout	=> conf_data(48),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(48),  
		 CONFout	=> conf_data(49),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(49),  
		 CONFout	=> conf_data(50),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(50),  
		 CONFout	=> conf_data(51),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(51),  
		 CONFout	=> conf_data(52),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(52),  
		 CONFout	=> conf_data(53),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y6_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y6_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y6_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y6_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y6_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y6_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y6_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y6_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y6_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y6_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y6_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y6_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y6_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y6_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y6_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y6_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(53),  
		 CONFout	=> conf_data(54),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y7_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(54),  
		 CONFout	=> conf_data(55),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(55),  
		 CONFout	=> conf_data(56),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(56),  
		 CONFout	=> conf_data(57),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(57),  
		 CONFout	=> conf_data(58),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(58),  
		 CONFout	=> conf_data(59),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(59),  
		 CONFout	=> conf_data(60),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(60),  
		 CONFout	=> conf_data(61),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y7_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y7_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y7_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y7_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y7_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y7_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y7_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y7_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y7_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y7_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y7_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y7_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y7_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y7_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y7_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y7_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(61),  
		 CONFout	=> conf_data(62),  
		 CLK => CLK );  

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
		PAD =>  Tile_X0Y8_PAD ,
		UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(62),  
		 CONFout	=> conf_data(63),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(63),  
		 CONFout	=> conf_data(64),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(64),  
		 CONFout	=> conf_data(65),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(65),  
		 CONFout	=> conf_data(66),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(66),  
		 CONFout	=> conf_data(67),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(67),  
		 CONFout	=> conf_data(68),  
		 CLK => CLK );  

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
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(68),  
		 CONFout	=> conf_data(69),  
		 CLK => CLK );  

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
		OPA_UserCLK =>  UserCLK ,
		OPB_I0 =>  Tile_X7Y8_OPB_I0 ,
		OPB_I1 =>  Tile_X7Y8_OPB_I1 ,
		OPB_I2 =>  Tile_X7Y8_OPB_I2 ,
		OPB_I3 =>  Tile_X7Y8_OPB_I3 ,
		OPB_UserCLK =>  UserCLK ,
		RES0_O0 =>  Tile_X7Y8_RES0_O0 ,
		RES0_O1 =>  Tile_X7Y8_RES0_O1 ,
		RES0_O2 =>  Tile_X7Y8_RES0_O2 ,
		RES0_O3 =>  Tile_X7Y8_RES0_O3 ,
		RES0_UserCLK =>  UserCLK ,
		RES1_O0 =>  Tile_X7Y8_RES1_O0 ,
		RES1_O1 =>  Tile_X7Y8_RES1_O1 ,
		RES1_O2 =>  Tile_X7Y8_RES1_O2 ,
		RES1_O3 =>  Tile_X7Y8_RES1_O3 ,
		RES1_UserCLK =>  UserCLK ,
		RES2_O0 =>  Tile_X7Y8_RES2_O0 ,
		RES2_O1 =>  Tile_X7Y8_RES2_O1 ,
		RES2_O2 =>  Tile_X7Y8_RES2_O2 ,
		RES2_O3 =>  Tile_X7Y8_RES2_O3 ,
		RES2_UserCLK =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(69),  
		 CONFout	=> conf_data(70),  
		 CLK => CLK );  

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
	Co	=> Tile_X1Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(70),  
		 CONFout	=> conf_data(71),  
		 CLK => CLK );  

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
	Co	=> Tile_X2Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(71),  
		 CONFout	=> conf_data(72),  
		 CLK => CLK );  

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
	Co	=> Tile_X3Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(72),  
		 CONFout	=> conf_data(73),  
		 CLK => CLK );  

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
	Co	=> Tile_X4Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(73),  
		 CONFout	=> conf_data(74),  
		 CLK => CLK );  

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
	Co	=> Tile_X5Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(74),  
		 CONFout	=> conf_data(75),  
		 CLK => CLK );  

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
	Co	=> Tile_X6Y9_Co( 0 downto 0 ),
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(75),  
		 CONFout	=> conf_data(76),  
		 CLK => CLK );  

end Behavioral;

