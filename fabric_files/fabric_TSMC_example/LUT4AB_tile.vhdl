library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  LUT4AB  is 
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
end entity LUT4AB ;

architecture Behavioral of  LUT4AB  is 

component LUT4c_frame_config is
    Generic ( NoConfigBits : integer := 18 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port (      -- IMPORTANT: this has to be in a dedicated line
	I0	: in	STD_LOGIC; -- LUT inputs
	I1	: in	STD_LOGIC;
	I2	: in	STD_LOGIC;
	I3	: in	STD_LOGIC;
	O	: out	STD_LOGIC; -- LUT output (combinatorial or FF)
	Ci	: in	STD_LOGIC; -- carry chain input
	Co	: out	STD_LOGIC; -- carry chain output
	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this sisgnal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component LUT4c_frame_config;

component MUX8LUT_frame_config is
    Generic ( NoConfigBits : integer := 2 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port (      -- IMPORTANT: this has to be in a dedicated line
	A	: in	STD_LOGIC; -- MUX inputs
	B	: in	STD_LOGIC;
	C	: in	STD_LOGIC;
	D	: in	STD_LOGIC;
	E	: in	STD_LOGIC; 
	F	: in	STD_LOGIC;
	G	: in	STD_LOGIC;
	H	: in	STD_LOGIC;
	S0	: in	STD_LOGIC;
	S1	: in	STD_LOGIC;
	S2	: in	STD_LOGIC;
	S3	: in	STD_LOGIC;
	M_AB: out	STD_LOGIC;
	M_AD: out	STD_LOGIC;
	M_AH: out	STD_LOGIC;
	M_EF: out	STD_LOGIC;
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component MUX8LUT_frame_config;


component  LUT4AB_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 392 );
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N1END3 	: in 	 STD_LOGIC;
		  N2MID0 	: in 	 STD_LOGIC;
		  N2MID1 	: in 	 STD_LOGIC;
		  N2MID2 	: in 	 STD_LOGIC;
		  N2MID3 	: in 	 STD_LOGIC;
		  N2MID4 	: in 	 STD_LOGIC;
		  N2MID5 	: in 	 STD_LOGIC;
		  N2MID6 	: in 	 STD_LOGIC;
		  N2MID7 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N2END3 	: in 	 STD_LOGIC;
		  N2END4 	: in 	 STD_LOGIC;
		  N2END5 	: in 	 STD_LOGIC;
		  N2END6 	: in 	 STD_LOGIC;
		  N2END7 	: in 	 STD_LOGIC;
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
		  N4END2 	: in 	 STD_LOGIC;
		  N4END3 	: in 	 STD_LOGIC;
		  Ci0 	: in 	 STD_LOGIC;
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2MID0 	: in 	 STD_LOGIC;
		  E2MID1 	: in 	 STD_LOGIC;
		  E2MID2 	: in 	 STD_LOGIC;
		  E2MID3 	: in 	 STD_LOGIC;
		  E2MID4 	: in 	 STD_LOGIC;
		  E2MID5 	: in 	 STD_LOGIC;
		  E2MID6 	: in 	 STD_LOGIC;
		  E2MID7 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  E2END4 	: in 	 STD_LOGIC;
		  E2END5 	: in 	 STD_LOGIC;
		  E2END6 	: in 	 STD_LOGIC;
		  E2END7 	: in 	 STD_LOGIC;
		  E6END0 	: in 	 STD_LOGIC;
		  E6END1 	: in 	 STD_LOGIC;
		  S1END0 	: in 	 STD_LOGIC;
		  S1END1 	: in 	 STD_LOGIC;
		  S1END2 	: in 	 STD_LOGIC;
		  S1END3 	: in 	 STD_LOGIC;
		  S2MID0 	: in 	 STD_LOGIC;
		  S2MID1 	: in 	 STD_LOGIC;
		  S2MID2 	: in 	 STD_LOGIC;
		  S2MID3 	: in 	 STD_LOGIC;
		  S2MID4 	: in 	 STD_LOGIC;
		  S2MID5 	: in 	 STD_LOGIC;
		  S2MID6 	: in 	 STD_LOGIC;
		  S2MID7 	: in 	 STD_LOGIC;
		  S2END0 	: in 	 STD_LOGIC;
		  S2END1 	: in 	 STD_LOGIC;
		  S2END2 	: in 	 STD_LOGIC;
		  S2END3 	: in 	 STD_LOGIC;
		  S2END4 	: in 	 STD_LOGIC;
		  S2END5 	: in 	 STD_LOGIC;
		  S2END6 	: in 	 STD_LOGIC;
		  S2END7 	: in 	 STD_LOGIC;
		  S4END0 	: in 	 STD_LOGIC;
		  S4END1 	: in 	 STD_LOGIC;
		  S4END2 	: in 	 STD_LOGIC;
		  S4END3 	: in 	 STD_LOGIC;
		  W1END0 	: in 	 STD_LOGIC;
		  W1END1 	: in 	 STD_LOGIC;
		  W1END2 	: in 	 STD_LOGIC;
		  W1END3 	: in 	 STD_LOGIC;
		  W2MID0 	: in 	 STD_LOGIC;
		  W2MID1 	: in 	 STD_LOGIC;
		  W2MID2 	: in 	 STD_LOGIC;
		  W2MID3 	: in 	 STD_LOGIC;
		  W2MID4 	: in 	 STD_LOGIC;
		  W2MID5 	: in 	 STD_LOGIC;
		  W2MID6 	: in 	 STD_LOGIC;
		  W2MID7 	: in 	 STD_LOGIC;
		  W2END0 	: in 	 STD_LOGIC;
		  W2END1 	: in 	 STD_LOGIC;
		  W2END2 	: in 	 STD_LOGIC;
		  W2END3 	: in 	 STD_LOGIC;
		  W2END4 	: in 	 STD_LOGIC;
		  W2END5 	: in 	 STD_LOGIC;
		  W2END6 	: in 	 STD_LOGIC;
		  W2END7 	: in 	 STD_LOGIC;
		  W6END0 	: in 	 STD_LOGIC;
		  W6END1 	: in 	 STD_LOGIC;
		  LA_O 	: in 	 STD_LOGIC;
		  LA_Co 	: in 	 STD_LOGIC;
		  LB_O 	: in 	 STD_LOGIC;
		  LB_Co 	: in 	 STD_LOGIC;
		  LC_O 	: in 	 STD_LOGIC;
		  LC_Co 	: in 	 STD_LOGIC;
		  LD_O 	: in 	 STD_LOGIC;
		  LD_Co 	: in 	 STD_LOGIC;
		  LE_O 	: in 	 STD_LOGIC;
		  LE_Co 	: in 	 STD_LOGIC;
		  LF_O 	: in 	 STD_LOGIC;
		  LF_Co 	: in 	 STD_LOGIC;
		  LG_O 	: in 	 STD_LOGIC;
		  LG_Co 	: in 	 STD_LOGIC;
		  LH_O 	: in 	 STD_LOGIC;
		  LH_Co 	: in 	 STD_LOGIC;
		  M_AB 	: in 	 STD_LOGIC;
		  M_AD 	: in 	 STD_LOGIC;
		  M_AH 	: in 	 STD_LOGIC;
		  M_EF 	: in 	 STD_LOGIC;
		  J2MID_ABa_END0 	: in 	 STD_LOGIC;
		  J2MID_ABa_END1 	: in 	 STD_LOGIC;
		  J2MID_ABa_END2 	: in 	 STD_LOGIC;
		  J2MID_ABa_END3 	: in 	 STD_LOGIC;
		  J2MID_CDa_END0 	: in 	 STD_LOGIC;
		  J2MID_CDa_END1 	: in 	 STD_LOGIC;
		  J2MID_CDa_END2 	: in 	 STD_LOGIC;
		  J2MID_CDa_END3 	: in 	 STD_LOGIC;
		  J2MID_EFa_END0 	: in 	 STD_LOGIC;
		  J2MID_EFa_END1 	: in 	 STD_LOGIC;
		  J2MID_EFa_END2 	: in 	 STD_LOGIC;
		  J2MID_EFa_END3 	: in 	 STD_LOGIC;
		  J2MID_GHa_END0 	: in 	 STD_LOGIC;
		  J2MID_GHa_END1 	: in 	 STD_LOGIC;
		  J2MID_GHa_END2 	: in 	 STD_LOGIC;
		  J2MID_GHa_END3 	: in 	 STD_LOGIC;
		  J2MID_ABb_END0 	: in 	 STD_LOGIC;
		  J2MID_ABb_END1 	: in 	 STD_LOGIC;
		  J2MID_ABb_END2 	: in 	 STD_LOGIC;
		  J2MID_ABb_END3 	: in 	 STD_LOGIC;
		  J2MID_CDb_END0 	: in 	 STD_LOGIC;
		  J2MID_CDb_END1 	: in 	 STD_LOGIC;
		  J2MID_CDb_END2 	: in 	 STD_LOGIC;
		  J2MID_CDb_END3 	: in 	 STD_LOGIC;
		  J2MID_EFb_END0 	: in 	 STD_LOGIC;
		  J2MID_EFb_END1 	: in 	 STD_LOGIC;
		  J2MID_EFb_END2 	: in 	 STD_LOGIC;
		  J2MID_EFb_END3 	: in 	 STD_LOGIC;
		  J2MID_GHb_END0 	: in 	 STD_LOGIC;
		  J2MID_GHb_END1 	: in 	 STD_LOGIC;
		  J2MID_GHb_END2 	: in 	 STD_LOGIC;
		  J2MID_GHb_END3 	: in 	 STD_LOGIC;
		  J2END_AB_END0 	: in 	 STD_LOGIC;
		  J2END_AB_END1 	: in 	 STD_LOGIC;
		  J2END_AB_END2 	: in 	 STD_LOGIC;
		  J2END_AB_END3 	: in 	 STD_LOGIC;
		  J2END_CD_END0 	: in 	 STD_LOGIC;
		  J2END_CD_END1 	: in 	 STD_LOGIC;
		  J2END_CD_END2 	: in 	 STD_LOGIC;
		  J2END_CD_END3 	: in 	 STD_LOGIC;
		  J2END_EF_END0 	: in 	 STD_LOGIC;
		  J2END_EF_END1 	: in 	 STD_LOGIC;
		  J2END_EF_END2 	: in 	 STD_LOGIC;
		  J2END_EF_END3 	: in 	 STD_LOGIC;
		  J2END_GH_END0 	: in 	 STD_LOGIC;
		  J2END_GH_END1 	: in 	 STD_LOGIC;
		  J2END_GH_END2 	: in 	 STD_LOGIC;
		  J2END_GH_END3 	: in 	 STD_LOGIC;
		  JN2END0 	: in 	 STD_LOGIC;
		  JN2END1 	: in 	 STD_LOGIC;
		  JN2END2 	: in 	 STD_LOGIC;
		  JN2END3 	: in 	 STD_LOGIC;
		  JN2END4 	: in 	 STD_LOGIC;
		  JN2END5 	: in 	 STD_LOGIC;
		  JN2END6 	: in 	 STD_LOGIC;
		  JN2END7 	: in 	 STD_LOGIC;
		  JE2END0 	: in 	 STD_LOGIC;
		  JE2END1 	: in 	 STD_LOGIC;
		  JE2END2 	: in 	 STD_LOGIC;
		  JE2END3 	: in 	 STD_LOGIC;
		  JE2END4 	: in 	 STD_LOGIC;
		  JE2END5 	: in 	 STD_LOGIC;
		  JE2END6 	: in 	 STD_LOGIC;
		  JE2END7 	: in 	 STD_LOGIC;
		  JS2END0 	: in 	 STD_LOGIC;
		  JS2END1 	: in 	 STD_LOGIC;
		  JS2END2 	: in 	 STD_LOGIC;
		  JS2END3 	: in 	 STD_LOGIC;
		  JS2END4 	: in 	 STD_LOGIC;
		  JS2END5 	: in 	 STD_LOGIC;
		  JS2END6 	: in 	 STD_LOGIC;
		  JS2END7 	: in 	 STD_LOGIC;
		  JW2END0 	: in 	 STD_LOGIC;
		  JW2END1 	: in 	 STD_LOGIC;
		  JW2END2 	: in 	 STD_LOGIC;
		  JW2END3 	: in 	 STD_LOGIC;
		  JW2END4 	: in 	 STD_LOGIC;
		  JW2END5 	: in 	 STD_LOGIC;
		  JW2END6 	: in 	 STD_LOGIC;
		  JW2END7 	: in 	 STD_LOGIC;
		  J_l_AB_END0 	: in 	 STD_LOGIC;
		  J_l_AB_END1 	: in 	 STD_LOGIC;
		  J_l_AB_END2 	: in 	 STD_LOGIC;
		  J_l_AB_END3 	: in 	 STD_LOGIC;
		  J_l_CD_END0 	: in 	 STD_LOGIC;
		  J_l_CD_END1 	: in 	 STD_LOGIC;
		  J_l_CD_END2 	: in 	 STD_LOGIC;
		  J_l_CD_END3 	: in 	 STD_LOGIC;
		  J_l_EF_END0 	: in 	 STD_LOGIC;
		  J_l_EF_END1 	: in 	 STD_LOGIC;
		  J_l_EF_END2 	: in 	 STD_LOGIC;
		  J_l_EF_END3 	: in 	 STD_LOGIC;
		  J_l_GH_END0 	: in 	 STD_LOGIC;
		  J_l_GH_END1 	: in 	 STD_LOGIC;
		  J_l_GH_END2 	: in 	 STD_LOGIC;
		  J_l_GH_END3 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N1BEG3 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  N2BEG3 	: out 	 STD_LOGIC;
		  N2BEG4 	: out 	 STD_LOGIC;
		  N2BEG5 	: out 	 STD_LOGIC;
		  N2BEG6 	: out 	 STD_LOGIC;
		  N2BEG7 	: out 	 STD_LOGIC;
		  N2BEGb0 	: out 	 STD_LOGIC;
		  N2BEGb1 	: out 	 STD_LOGIC;
		  N2BEGb2 	: out 	 STD_LOGIC;
		  N2BEGb3 	: out 	 STD_LOGIC;
		  N2BEGb4 	: out 	 STD_LOGIC;
		  N2BEGb5 	: out 	 STD_LOGIC;
		  N2BEGb6 	: out 	 STD_LOGIC;
		  N2BEGb7 	: out 	 STD_LOGIC;
		  N4BEG0 	: out 	 STD_LOGIC;
		  N4BEG1 	: out 	 STD_LOGIC;
		  N4BEG2 	: out 	 STD_LOGIC;
		  N4BEG3 	: out 	 STD_LOGIC;
		  Co0 	: out 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
		  E2BEG4 	: out 	 STD_LOGIC;
		  E2BEG5 	: out 	 STD_LOGIC;
		  E2BEG6 	: out 	 STD_LOGIC;
		  E2BEG7 	: out 	 STD_LOGIC;
		  E2BEGb0 	: out 	 STD_LOGIC;
		  E2BEGb1 	: out 	 STD_LOGIC;
		  E2BEGb2 	: out 	 STD_LOGIC;
		  E2BEGb3 	: out 	 STD_LOGIC;
		  E2BEGb4 	: out 	 STD_LOGIC;
		  E2BEGb5 	: out 	 STD_LOGIC;
		  E2BEGb6 	: out 	 STD_LOGIC;
		  E2BEGb7 	: out 	 STD_LOGIC;
		  E6BEG0 	: out 	 STD_LOGIC;
		  E6BEG1 	: out 	 STD_LOGIC;
		  S1BEG0 	: out 	 STD_LOGIC;
		  S1BEG1 	: out 	 STD_LOGIC;
		  S1BEG2 	: out 	 STD_LOGIC;
		  S1BEG3 	: out 	 STD_LOGIC;
		  S2BEG0 	: out 	 STD_LOGIC;
		  S2BEG1 	: out 	 STD_LOGIC;
		  S2BEG2 	: out 	 STD_LOGIC;
		  S2BEG3 	: out 	 STD_LOGIC;
		  S2BEG4 	: out 	 STD_LOGIC;
		  S2BEG5 	: out 	 STD_LOGIC;
		  S2BEG6 	: out 	 STD_LOGIC;
		  S2BEG7 	: out 	 STD_LOGIC;
		  S2BEGb0 	: out 	 STD_LOGIC;
		  S2BEGb1 	: out 	 STD_LOGIC;
		  S2BEGb2 	: out 	 STD_LOGIC;
		  S2BEGb3 	: out 	 STD_LOGIC;
		  S2BEGb4 	: out 	 STD_LOGIC;
		  S2BEGb5 	: out 	 STD_LOGIC;
		  S2BEGb6 	: out 	 STD_LOGIC;
		  S2BEGb7 	: out 	 STD_LOGIC;
		  S4BEG0 	: out 	 STD_LOGIC;
		  S4BEG1 	: out 	 STD_LOGIC;
		  S4BEG2 	: out 	 STD_LOGIC;
		  S4BEG3 	: out 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  W2BEG6 	: out 	 STD_LOGIC;
		  W2BEG7 	: out 	 STD_LOGIC;
		  W2BEGb0 	: out 	 STD_LOGIC;
		  W2BEGb1 	: out 	 STD_LOGIC;
		  W2BEGb2 	: out 	 STD_LOGIC;
		  W2BEGb3 	: out 	 STD_LOGIC;
		  W2BEGb4 	: out 	 STD_LOGIC;
		  W2BEGb5 	: out 	 STD_LOGIC;
		  W2BEGb6 	: out 	 STD_LOGIC;
		  W2BEGb7 	: out 	 STD_LOGIC;
		  W6BEG0 	: out 	 STD_LOGIC;
		  W6BEG1 	: out 	 STD_LOGIC;
		  LA_I0 	: out 	 STD_LOGIC;
		  LA_I1 	: out 	 STD_LOGIC;
		  LA_I2 	: out 	 STD_LOGIC;
		  LA_I3 	: out 	 STD_LOGIC;
		  LA_Ci 	: out 	 STD_LOGIC;
		  LB_I0 	: out 	 STD_LOGIC;
		  LB_I1 	: out 	 STD_LOGIC;
		  LB_I2 	: out 	 STD_LOGIC;
		  LB_I3 	: out 	 STD_LOGIC;
		  LB_Ci 	: out 	 STD_LOGIC;
		  LC_I0 	: out 	 STD_LOGIC;
		  LC_I1 	: out 	 STD_LOGIC;
		  LC_I2 	: out 	 STD_LOGIC;
		  LC_I3 	: out 	 STD_LOGIC;
		  LC_Ci 	: out 	 STD_LOGIC;
		  LD_I0 	: out 	 STD_LOGIC;
		  LD_I1 	: out 	 STD_LOGIC;
		  LD_I2 	: out 	 STD_LOGIC;
		  LD_I3 	: out 	 STD_LOGIC;
		  LD_Ci 	: out 	 STD_LOGIC;
		  LE_I0 	: out 	 STD_LOGIC;
		  LE_I1 	: out 	 STD_LOGIC;
		  LE_I2 	: out 	 STD_LOGIC;
		  LE_I3 	: out 	 STD_LOGIC;
		  LE_Ci 	: out 	 STD_LOGIC;
		  LF_I0 	: out 	 STD_LOGIC;
		  LF_I1 	: out 	 STD_LOGIC;
		  LF_I2 	: out 	 STD_LOGIC;
		  LF_I3 	: out 	 STD_LOGIC;
		  LF_Ci 	: out 	 STD_LOGIC;
		  LG_I0 	: out 	 STD_LOGIC;
		  LG_I1 	: out 	 STD_LOGIC;
		  LG_I2 	: out 	 STD_LOGIC;
		  LG_I3 	: out 	 STD_LOGIC;
		  LG_Ci 	: out 	 STD_LOGIC;
		  LH_I0 	: out 	 STD_LOGIC;
		  LH_I1 	: out 	 STD_LOGIC;
		  LH_I2 	: out 	 STD_LOGIC;
		  LH_I3 	: out 	 STD_LOGIC;
		  LH_Ci 	: out 	 STD_LOGIC;
		  A 	: out 	 STD_LOGIC;
		  B 	: out 	 STD_LOGIC;
		  C 	: out 	 STD_LOGIC;
		  D 	: out 	 STD_LOGIC;
		  E 	: out 	 STD_LOGIC;
		  F 	: out 	 STD_LOGIC;
		  G 	: out 	 STD_LOGIC;
		  H 	: out 	 STD_LOGIC;
		  S0 	: out 	 STD_LOGIC;
		  S1 	: out 	 STD_LOGIC;
		  S2 	: out 	 STD_LOGIC;
		  S3 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG3 	: out 	 STD_LOGIC;
		  J2END_AB_BEG0 	: out 	 STD_LOGIC;
		  J2END_AB_BEG1 	: out 	 STD_LOGIC;
		  J2END_AB_BEG2 	: out 	 STD_LOGIC;
		  J2END_AB_BEG3 	: out 	 STD_LOGIC;
		  J2END_CD_BEG0 	: out 	 STD_LOGIC;
		  J2END_CD_BEG1 	: out 	 STD_LOGIC;
		  J2END_CD_BEG2 	: out 	 STD_LOGIC;
		  J2END_CD_BEG3 	: out 	 STD_LOGIC;
		  J2END_EF_BEG0 	: out 	 STD_LOGIC;
		  J2END_EF_BEG1 	: out 	 STD_LOGIC;
		  J2END_EF_BEG2 	: out 	 STD_LOGIC;
		  J2END_EF_BEG3 	: out 	 STD_LOGIC;
		  J2END_GH_BEG0 	: out 	 STD_LOGIC;
		  J2END_GH_BEG1 	: out 	 STD_LOGIC;
		  J2END_GH_BEG2 	: out 	 STD_LOGIC;
		  J2END_GH_BEG3 	: out 	 STD_LOGIC;
		  JN2BEG0 	: out 	 STD_LOGIC;
		  JN2BEG1 	: out 	 STD_LOGIC;
		  JN2BEG2 	: out 	 STD_LOGIC;
		  JN2BEG3 	: out 	 STD_LOGIC;
		  JN2BEG4 	: out 	 STD_LOGIC;
		  JN2BEG5 	: out 	 STD_LOGIC;
		  JN2BEG6 	: out 	 STD_LOGIC;
		  JN2BEG7 	: out 	 STD_LOGIC;
		  JE2BEG0 	: out 	 STD_LOGIC;
		  JE2BEG1 	: out 	 STD_LOGIC;
		  JE2BEG2 	: out 	 STD_LOGIC;
		  JE2BEG3 	: out 	 STD_LOGIC;
		  JE2BEG4 	: out 	 STD_LOGIC;
		  JE2BEG5 	: out 	 STD_LOGIC;
		  JE2BEG6 	: out 	 STD_LOGIC;
		  JE2BEG7 	: out 	 STD_LOGIC;
		  JS2BEG0 	: out 	 STD_LOGIC;
		  JS2BEG1 	: out 	 STD_LOGIC;
		  JS2BEG2 	: out 	 STD_LOGIC;
		  JS2BEG3 	: out 	 STD_LOGIC;
		  JS2BEG4 	: out 	 STD_LOGIC;
		  JS2BEG5 	: out 	 STD_LOGIC;
		  JS2BEG6 	: out 	 STD_LOGIC;
		  JS2BEG7 	: out 	 STD_LOGIC;
		  JW2BEG0 	: out 	 STD_LOGIC;
		  JW2BEG1 	: out 	 STD_LOGIC;
		  JW2BEG2 	: out 	 STD_LOGIC;
		  JW2BEG3 	: out 	 STD_LOGIC;
		  JW2BEG4 	: out 	 STD_LOGIC;
		  JW2BEG5 	: out 	 STD_LOGIC;
		  JW2BEG6 	: out 	 STD_LOGIC;
		  JW2BEG7 	: out 	 STD_LOGIC;
		  J_l_AB_BEG0 	: out 	 STD_LOGIC;
		  J_l_AB_BEG1 	: out 	 STD_LOGIC;
		  J_l_AB_BEG2 	: out 	 STD_LOGIC;
		  J_l_AB_BEG3 	: out 	 STD_LOGIC;
		  J_l_CD_BEG0 	: out 	 STD_LOGIC;
		  J_l_CD_BEG1 	: out 	 STD_LOGIC;
		  J_l_CD_BEG2 	: out 	 STD_LOGIC;
		  J_l_CD_BEG3 	: out 	 STD_LOGIC;
		  J_l_EF_BEG0 	: out 	 STD_LOGIC;
		  J_l_EF_BEG1 	: out 	 STD_LOGIC;
		  J_l_EF_BEG2 	: out 	 STD_LOGIC;
		  J_l_EF_BEG3 	: out 	 STD_LOGIC;
		  J_l_GH_BEG0 	: out 	 STD_LOGIC;
		  J_l_GH_BEG1 	: out 	 STD_LOGIC;
		  J_l_GH_BEG2 	: out 	 STD_LOGIC;
		  J_l_GH_BEG3 	: out 	 STD_LOGIC;
	-- global
		 ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component LUT4AB_switch_matrix ;


component  LUT4AB_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 538 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end component;

-- signal declarations

-- BEL ports (e.g., slices)
signal	LA_I0	:STD_LOGIC;
signal	LA_I1	:STD_LOGIC;
signal	LA_I2	:STD_LOGIC;
signal	LA_I3	:STD_LOGIC;
signal	LA_Ci	:STD_LOGIC;
signal	LB_I0	:STD_LOGIC;
signal	LB_I1	:STD_LOGIC;
signal	LB_I2	:STD_LOGIC;
signal	LB_I3	:STD_LOGIC;
signal	LB_Ci	:STD_LOGIC;
signal	LC_I0	:STD_LOGIC;
signal	LC_I1	:STD_LOGIC;
signal	LC_I2	:STD_LOGIC;
signal	LC_I3	:STD_LOGIC;
signal	LC_Ci	:STD_LOGIC;
signal	LD_I0	:STD_LOGIC;
signal	LD_I1	:STD_LOGIC;
signal	LD_I2	:STD_LOGIC;
signal	LD_I3	:STD_LOGIC;
signal	LD_Ci	:STD_LOGIC;
signal	LE_I0	:STD_LOGIC;
signal	LE_I1	:STD_LOGIC;
signal	LE_I2	:STD_LOGIC;
signal	LE_I3	:STD_LOGIC;
signal	LE_Ci	:STD_LOGIC;
signal	LF_I0	:STD_LOGIC;
signal	LF_I1	:STD_LOGIC;
signal	LF_I2	:STD_LOGIC;
signal	LF_I3	:STD_LOGIC;
signal	LF_Ci	:STD_LOGIC;
signal	LG_I0	:STD_LOGIC;
signal	LG_I1	:STD_LOGIC;
signal	LG_I2	:STD_LOGIC;
signal	LG_I3	:STD_LOGIC;
signal	LG_Ci	:STD_LOGIC;
signal	LH_I0	:STD_LOGIC;
signal	LH_I1	:STD_LOGIC;
signal	LH_I2	:STD_LOGIC;
signal	LH_I3	:STD_LOGIC;
signal	LH_Ci	:STD_LOGIC;
signal	A	:STD_LOGIC;
signal	B	:STD_LOGIC;
signal	C	:STD_LOGIC;
signal	D	:STD_LOGIC;
signal	E	:STD_LOGIC;
signal	F	:STD_LOGIC;
signal	G	:STD_LOGIC;
signal	H	:STD_LOGIC;
signal	S0	:STD_LOGIC;
signal	S1	:STD_LOGIC;
signal	S2	:STD_LOGIC;
signal	S3	:STD_LOGIC;
signal	LA_O	:STD_LOGIC;
signal	LA_Co	:STD_LOGIC;
signal	LB_O	:STD_LOGIC;
signal	LB_Co	:STD_LOGIC;
signal	LC_O	:STD_LOGIC;
signal	LC_Co	:STD_LOGIC;
signal	LD_O	:STD_LOGIC;
signal	LD_Co	:STD_LOGIC;
signal	LE_O	:STD_LOGIC;
signal	LE_Co	:STD_LOGIC;
signal	LF_O	:STD_LOGIC;
signal	LF_Co	:STD_LOGIC;
signal	LG_O	:STD_LOGIC;
signal	LG_Co	:STD_LOGIC;
signal	LH_O	:STD_LOGIC;
signal	LH_Co	:STD_LOGIC;
signal	M_AB	:STD_LOGIC;
signal	M_AD	:STD_LOGIC;
signal	M_AH	:STD_LOGIC;
signal	M_EF	:STD_LOGIC;
-- jump wires
signal	 J2MID_ABa_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_CDa_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_EFa_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_GHa_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_ABb_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_CDb_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_EFb_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2MID_GHb_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2END_AB_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2END_CD_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2END_EF_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J2END_GH_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 JN2BEG 	:	STD_LOGIC_VECTOR(8 downto 0);
signal	 JE2BEG 	:	STD_LOGIC_VECTOR(8 downto 0);
signal	 JS2BEG 	:	STD_LOGIC_VECTOR(8 downto 0);
signal	 JW2BEG 	:	STD_LOGIC_VECTOR(8 downto 0);
signal	 J_l_AB_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J_l_CD_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J_l_EF_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
signal	 J_l_GH_BEG 	:	STD_LOGIC_VECTOR(4 downto 0);
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	 STD_LOGIC_VECTOR(10 downto 0);
signal 	 ConfigBits :	 STD_LOGIC_VECTOR (NoConfigBits -1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
N4BEG(N4BEG'high - 4 downto 0) <= N4END(N4END'high downto 4);
E6BEG(E6BEG'high - 2 downto 0) <= E6END(E6END'high downto 2);
S4BEG(S4BEG'high - 4 downto 0) <= S4END(S4END'high downto 4);
W6BEG(W6BEG'high - 2 downto 0) <= W6END(W6END'high downto 2);

-- configuration storage latches
Inst_LUT4AB_ConfigMem : LUT4AB_ConfigMem
	Port Map( 
		 FrameData  	 =>	 FrameData, 
		 FrameStrobe 	 =>	 FrameStrobe, 
		 ConfigBits 	 =>	 ConfigBits  );

-- BEL component instantiations

Inst_LA_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LA_I0 ,
		 I1  =>  LA_I1 ,
		 I2  =>  LA_I2 ,
		 I3  =>  LA_I3 ,
		 Ci  =>  LA_Ci ,
		 O  =>  LA_O ,
		 Co  =>  LA_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 18 -1 downto 0 ) );

Inst_LB_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LB_I0 ,
		 I1  =>  LB_I1 ,
		 I2  =>  LB_I2 ,
		 I3  =>  LB_I3 ,
		 Ci  =>  LB_Ci ,
		 O  =>  LB_O ,
		 Co  =>  LB_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 36 -1 downto 18 ) );

Inst_LC_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LC_I0 ,
		 I1  =>  LC_I1 ,
		 I2  =>  LC_I2 ,
		 I3  =>  LC_I3 ,
		 Ci  =>  LC_Ci ,
		 O  =>  LC_O ,
		 Co  =>  LC_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 54 -1 downto 36 ) );

Inst_LD_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LD_I0 ,
		 I1  =>  LD_I1 ,
		 I2  =>  LD_I2 ,
		 I3  =>  LD_I3 ,
		 Ci  =>  LD_Ci ,
		 O  =>  LD_O ,
		 Co  =>  LD_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 72 -1 downto 54 ) );

Inst_LE_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LE_I0 ,
		 I1  =>  LE_I1 ,
		 I2  =>  LE_I2 ,
		 I3  =>  LE_I3 ,
		 Ci  =>  LE_Ci ,
		 O  =>  LE_O ,
		 Co  =>  LE_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 90 -1 downto 72 ) );

Inst_LF_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LF_I0 ,
		 I1  =>  LF_I1 ,
		 I2  =>  LF_I2 ,
		 I3  =>  LF_I3 ,
		 Ci  =>  LF_Ci ,
		 O  =>  LF_O ,
		 Co  =>  LF_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 108 -1 downto 90 ) );

Inst_LG_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LG_I0 ,
		 I1  =>  LG_I1 ,
		 I2  =>  LG_I2 ,
		 I3  =>  LG_I3 ,
		 Ci  =>  LG_Ci ,
		 O  =>  LG_O ,
		 Co  =>  LG_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 126 -1 downto 108 ) );

Inst_LH_LUT4c_frame_config : LUT4c_frame_config
	Port Map(
		 I0  =>  LH_I0 ,
		 I1  =>  LH_I1 ,
		 I2  =>  LH_I2 ,
		 I3  =>  LH_I3 ,
		 Ci  =>  LH_Ci ,
		 O  =>  LH_O ,
		 Co  =>  LH_Co ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 144 -1 downto 126 ) );

Inst_MUX8LUT_frame_config : MUX8LUT_frame_config
	Port Map(
		 A  =>  A ,
		 B  =>  B ,
		 C  =>  C ,
		 D  =>  D ,
		 E  =>  E ,
		 F  =>  F ,
		 G  =>  G ,
		 H  =>  H ,
		 S0  =>  S0 ,
		 S1  =>  S1 ,
		 S2  =>  S2 ,
		 S3  =>  S3 ,
		 M_AB  =>  M_AB ,
		 M_AD  =>  M_AD ,
		 M_AH  =>  M_AH ,
		 M_EF  =>  M_EF ,
		 ConfigBits => ConfigBits ( 146 -1 downto 144 ) );


-- switch matrix component instantiation

Inst_LUT4AB_switch_matrix : LUT4AB_switch_matrix
	Port Map(
		 N1END0  => N1END(0),
		 N1END1  => N1END(1),
		 N1END2  => N1END(2),
		 N1END3  => N1END(3),
		 N2MID0  => N2MID(0),
		 N2MID1  => N2MID(1),
		 N2MID2  => N2MID(2),
		 N2MID3  => N2MID(3),
		 N2MID4  => N2MID(4),
		 N2MID5  => N2MID(5),
		 N2MID6  => N2MID(6),
		 N2MID7  => N2MID(7),
		 N2END0  => N2END(0),
		 N2END1  => N2END(1),
		 N2END2  => N2END(2),
		 N2END3  => N2END(3),
		 N2END4  => N2END(4),
		 N2END5  => N2END(5),
		 N2END6  => N2END(6),
		 N2END7  => N2END(7),
		 N4END0  => N4END(0),
		 N4END1  => N4END(1),
		 N4END2  => N4END(2),
		 N4END3  => N4END(3),
		 Ci0  => Ci(0),
		 E1END0  => E1END(0),
		 E1END1  => E1END(1),
		 E1END2  => E1END(2),
		 E1END3  => E1END(3),
		 E2MID0  => E2MID(0),
		 E2MID1  => E2MID(1),
		 E2MID2  => E2MID(2),
		 E2MID3  => E2MID(3),
		 E2MID4  => E2MID(4),
		 E2MID5  => E2MID(5),
		 E2MID6  => E2MID(6),
		 E2MID7  => E2MID(7),
		 E2END0  => E2END(0),
		 E2END1  => E2END(1),
		 E2END2  => E2END(2),
		 E2END3  => E2END(3),
		 E2END4  => E2END(4),
		 E2END5  => E2END(5),
		 E2END6  => E2END(6),
		 E2END7  => E2END(7),
		 E6END0  => E6END(0),
		 E6END1  => E6END(1),
		 S1END0  => S1END(0),
		 S1END1  => S1END(1),
		 S1END2  => S1END(2),
		 S1END3  => S1END(3),
		 S2MID0  => S2MID(0),
		 S2MID1  => S2MID(1),
		 S2MID2  => S2MID(2),
		 S2MID3  => S2MID(3),
		 S2MID4  => S2MID(4),
		 S2MID5  => S2MID(5),
		 S2MID6  => S2MID(6),
		 S2MID7  => S2MID(7),
		 S2END0  => S2END(0),
		 S2END1  => S2END(1),
		 S2END2  => S2END(2),
		 S2END3  => S2END(3),
		 S2END4  => S2END(4),
		 S2END5  => S2END(5),
		 S2END6  => S2END(6),
		 S2END7  => S2END(7),
		 S4END0  => S4END(0),
		 S4END1  => S4END(1),
		 S4END2  => S4END(2),
		 S4END3  => S4END(3),
		 W1END0  => W1END(0),
		 W1END1  => W1END(1),
		 W1END2  => W1END(2),
		 W1END3  => W1END(3),
		 W2MID0  => W2MID(0),
		 W2MID1  => W2MID(1),
		 W2MID2  => W2MID(2),
		 W2MID3  => W2MID(3),
		 W2MID4  => W2MID(4),
		 W2MID5  => W2MID(5),
		 W2MID6  => W2MID(6),
		 W2MID7  => W2MID(7),
		 W2END0  => W2END(0),
		 W2END1  => W2END(1),
		 W2END2  => W2END(2),
		 W2END3  => W2END(3),
		 W2END4  => W2END(4),
		 W2END5  => W2END(5),
		 W2END6  => W2END(6),
		 W2END7  => W2END(7),
		 W6END0  => W6END(0),
		 W6END1  => W6END(1),
		 LA_O  => LA_O,
		 LA_Co  => LA_Co,
		 LB_O  => LB_O,
		 LB_Co  => LB_Co,
		 LC_O  => LC_O,
		 LC_Co  => LC_Co,
		 LD_O  => LD_O,
		 LD_Co  => LD_Co,
		 LE_O  => LE_O,
		 LE_Co  => LE_Co,
		 LF_O  => LF_O,
		 LF_Co  => LF_Co,
		 LG_O  => LG_O,
		 LG_Co  => LG_Co,
		 LH_O  => LH_O,
		 LH_Co  => LH_Co,
		 M_AB  => M_AB,
		 M_AD  => M_AD,
		 M_AH  => M_AH,
		 M_EF  => M_EF,
		 J2MID_ABa_END0  => J2MID_ABa_BEG(0),
		 J2MID_ABa_END1  => J2MID_ABa_BEG(1),
		 J2MID_ABa_END2  => J2MID_ABa_BEG(2),
		 J2MID_ABa_END3  => J2MID_ABa_BEG(3),
		 J2MID_CDa_END0  => J2MID_CDa_BEG(0),
		 J2MID_CDa_END1  => J2MID_CDa_BEG(1),
		 J2MID_CDa_END2  => J2MID_CDa_BEG(2),
		 J2MID_CDa_END3  => J2MID_CDa_BEG(3),
		 J2MID_EFa_END0  => J2MID_EFa_BEG(0),
		 J2MID_EFa_END1  => J2MID_EFa_BEG(1),
		 J2MID_EFa_END2  => J2MID_EFa_BEG(2),
		 J2MID_EFa_END3  => J2MID_EFa_BEG(3),
		 J2MID_GHa_END0  => J2MID_GHa_BEG(0),
		 J2MID_GHa_END1  => J2MID_GHa_BEG(1),
		 J2MID_GHa_END2  => J2MID_GHa_BEG(2),
		 J2MID_GHa_END3  => J2MID_GHa_BEG(3),
		 J2MID_ABb_END0  => J2MID_ABb_BEG(0),
		 J2MID_ABb_END1  => J2MID_ABb_BEG(1),
		 J2MID_ABb_END2  => J2MID_ABb_BEG(2),
		 J2MID_ABb_END3  => J2MID_ABb_BEG(3),
		 J2MID_CDb_END0  => J2MID_CDb_BEG(0),
		 J2MID_CDb_END1  => J2MID_CDb_BEG(1),
		 J2MID_CDb_END2  => J2MID_CDb_BEG(2),
		 J2MID_CDb_END3  => J2MID_CDb_BEG(3),
		 J2MID_EFb_END0  => J2MID_EFb_BEG(0),
		 J2MID_EFb_END1  => J2MID_EFb_BEG(1),
		 J2MID_EFb_END2  => J2MID_EFb_BEG(2),
		 J2MID_EFb_END3  => J2MID_EFb_BEG(3),
		 J2MID_GHb_END0  => J2MID_GHb_BEG(0),
		 J2MID_GHb_END1  => J2MID_GHb_BEG(1),
		 J2MID_GHb_END2  => J2MID_GHb_BEG(2),
		 J2MID_GHb_END3  => J2MID_GHb_BEG(3),
		 J2END_AB_END0  => J2END_AB_BEG(0),
		 J2END_AB_END1  => J2END_AB_BEG(1),
		 J2END_AB_END2  => J2END_AB_BEG(2),
		 J2END_AB_END3  => J2END_AB_BEG(3),
		 J2END_CD_END0  => J2END_CD_BEG(0),
		 J2END_CD_END1  => J2END_CD_BEG(1),
		 J2END_CD_END2  => J2END_CD_BEG(2),
		 J2END_CD_END3  => J2END_CD_BEG(3),
		 J2END_EF_END0  => J2END_EF_BEG(0),
		 J2END_EF_END1  => J2END_EF_BEG(1),
		 J2END_EF_END2  => J2END_EF_BEG(2),
		 J2END_EF_END3  => J2END_EF_BEG(3),
		 J2END_GH_END0  => J2END_GH_BEG(0),
		 J2END_GH_END1  => J2END_GH_BEG(1),
		 J2END_GH_END2  => J2END_GH_BEG(2),
		 J2END_GH_END3  => J2END_GH_BEG(3),
		 JN2END0  => JN2BEG(0),
		 JN2END1  => JN2BEG(1),
		 JN2END2  => JN2BEG(2),
		 JN2END3  => JN2BEG(3),
		 JN2END4  => JN2BEG(4),
		 JN2END5  => JN2BEG(5),
		 JN2END6  => JN2BEG(6),
		 JN2END7  => JN2BEG(7),
		 JE2END0  => JE2BEG(0),
		 JE2END1  => JE2BEG(1),
		 JE2END2  => JE2BEG(2),
		 JE2END3  => JE2BEG(3),
		 JE2END4  => JE2BEG(4),
		 JE2END5  => JE2BEG(5),
		 JE2END6  => JE2BEG(6),
		 JE2END7  => JE2BEG(7),
		 JS2END0  => JS2BEG(0),
		 JS2END1  => JS2BEG(1),
		 JS2END2  => JS2BEG(2),
		 JS2END3  => JS2BEG(3),
		 JS2END4  => JS2BEG(4),
		 JS2END5  => JS2BEG(5),
		 JS2END6  => JS2BEG(6),
		 JS2END7  => JS2BEG(7),
		 JW2END0  => JW2BEG(0),
		 JW2END1  => JW2BEG(1),
		 JW2END2  => JW2BEG(2),
		 JW2END3  => JW2BEG(3),
		 JW2END4  => JW2BEG(4),
		 JW2END5  => JW2BEG(5),
		 JW2END6  => JW2BEG(6),
		 JW2END7  => JW2BEG(7),
		 J_l_AB_END0  => J_l_AB_BEG(0),
		 J_l_AB_END1  => J_l_AB_BEG(1),
		 J_l_AB_END2  => J_l_AB_BEG(2),
		 J_l_AB_END3  => J_l_AB_BEG(3),
		 J_l_CD_END0  => J_l_CD_BEG(0),
		 J_l_CD_END1  => J_l_CD_BEG(1),
		 J_l_CD_END2  => J_l_CD_BEG(2),
		 J_l_CD_END3  => J_l_CD_BEG(3),
		 J_l_EF_END0  => J_l_EF_BEG(0),
		 J_l_EF_END1  => J_l_EF_BEG(1),
		 J_l_EF_END2  => J_l_EF_BEG(2),
		 J_l_EF_END3  => J_l_EF_BEG(3),
		 J_l_GH_END0  => J_l_GH_BEG(0),
		 J_l_GH_END1  => J_l_GH_BEG(1),
		 J_l_GH_END2  => J_l_GH_BEG(2),
		 J_l_GH_END3  => J_l_GH_BEG(3),
		 N1BEG0  => N1BEG(0),
		 N1BEG1  => N1BEG(1),
		 N1BEG2  => N1BEG(2),
		 N1BEG3  => N1BEG(3),
		 N2BEG0  => N2BEG(0),
		 N2BEG1  => N2BEG(1),
		 N2BEG2  => N2BEG(2),
		 N2BEG3  => N2BEG(3),
		 N2BEG4  => N2BEG(4),
		 N2BEG5  => N2BEG(5),
		 N2BEG6  => N2BEG(6),
		 N2BEG7  => N2BEG(7),
		 N2BEGb0  => N2BEGb(0),
		 N2BEGb1  => N2BEGb(1),
		 N2BEGb2  => N2BEGb(2),
		 N2BEGb3  => N2BEGb(3),
		 N2BEGb4  => N2BEGb(4),
		 N2BEGb5  => N2BEGb(5),
		 N2BEGb6  => N2BEGb(6),
		 N2BEGb7  => N2BEGb(7),
		 N4BEG0  => N4BEG(12),
		 N4BEG1  => N4BEG(13),
		 N4BEG2  => N4BEG(14),
		 N4BEG3  => N4BEG(15),
		 Co0  => Co(0),
		 E1BEG0  => E1BEG(0),
		 E1BEG1  => E1BEG(1),
		 E1BEG2  => E1BEG(2),
		 E1BEG3  => E1BEG(3),
		 E2BEG0  => E2BEG(0),
		 E2BEG1  => E2BEG(1),
		 E2BEG2  => E2BEG(2),
		 E2BEG3  => E2BEG(3),
		 E2BEG4  => E2BEG(4),
		 E2BEG5  => E2BEG(5),
		 E2BEG6  => E2BEG(6),
		 E2BEG7  => E2BEG(7),
		 E2BEGb0  => E2BEGb(0),
		 E2BEGb1  => E2BEGb(1),
		 E2BEGb2  => E2BEGb(2),
		 E2BEGb3  => E2BEGb(3),
		 E2BEGb4  => E2BEGb(4),
		 E2BEGb5  => E2BEGb(5),
		 E2BEGb6  => E2BEGb(6),
		 E2BEGb7  => E2BEGb(7),
		 E6BEG0  => E6BEG(10),
		 E6BEG1  => E6BEG(11),
		 S1BEG0  => S1BEG(0),
		 S1BEG1  => S1BEG(1),
		 S1BEG2  => S1BEG(2),
		 S1BEG3  => S1BEG(3),
		 S2BEG0  => S2BEG(0),
		 S2BEG1  => S2BEG(1),
		 S2BEG2  => S2BEG(2),
		 S2BEG3  => S2BEG(3),
		 S2BEG4  => S2BEG(4),
		 S2BEG5  => S2BEG(5),
		 S2BEG6  => S2BEG(6),
		 S2BEG7  => S2BEG(7),
		 S2BEGb0  => S2BEGb(0),
		 S2BEGb1  => S2BEGb(1),
		 S2BEGb2  => S2BEGb(2),
		 S2BEGb3  => S2BEGb(3),
		 S2BEGb4  => S2BEGb(4),
		 S2BEGb5  => S2BEGb(5),
		 S2BEGb6  => S2BEGb(6),
		 S2BEGb7  => S2BEGb(7),
		 S4BEG0  => S4BEG(12),
		 S4BEG1  => S4BEG(13),
		 S4BEG2  => S4BEG(14),
		 S4BEG3  => S4BEG(15),
		 W1BEG0  => W1BEG(0),
		 W1BEG1  => W1BEG(1),
		 W1BEG2  => W1BEG(2),
		 W1BEG3  => W1BEG(3),
		 W2BEG0  => W2BEG(0),
		 W2BEG1  => W2BEG(1),
		 W2BEG2  => W2BEG(2),
		 W2BEG3  => W2BEG(3),
		 W2BEG4  => W2BEG(4),
		 W2BEG5  => W2BEG(5),
		 W2BEG6  => W2BEG(6),
		 W2BEG7  => W2BEG(7),
		 W2BEGb0  => W2BEGb(0),
		 W2BEGb1  => W2BEGb(1),
		 W2BEGb2  => W2BEGb(2),
		 W2BEGb3  => W2BEGb(3),
		 W2BEGb4  => W2BEGb(4),
		 W2BEGb5  => W2BEGb(5),
		 W2BEGb6  => W2BEGb(6),
		 W2BEGb7  => W2BEGb(7),
		 W6BEG0  => W6BEG(10),
		 W6BEG1  => W6BEG(11),
		 LA_I0  => LA_I0,
		 LA_I1  => LA_I1,
		 LA_I2  => LA_I2,
		 LA_I3  => LA_I3,
		 LA_Ci  => LA_Ci,
		 LB_I0  => LB_I0,
		 LB_I1  => LB_I1,
		 LB_I2  => LB_I2,
		 LB_I3  => LB_I3,
		 LB_Ci  => LB_Ci,
		 LC_I0  => LC_I0,
		 LC_I1  => LC_I1,
		 LC_I2  => LC_I2,
		 LC_I3  => LC_I3,
		 LC_Ci  => LC_Ci,
		 LD_I0  => LD_I0,
		 LD_I1  => LD_I1,
		 LD_I2  => LD_I2,
		 LD_I3  => LD_I3,
		 LD_Ci  => LD_Ci,
		 LE_I0  => LE_I0,
		 LE_I1  => LE_I1,
		 LE_I2  => LE_I2,
		 LE_I3  => LE_I3,
		 LE_Ci  => LE_Ci,
		 LF_I0  => LF_I0,
		 LF_I1  => LF_I1,
		 LF_I2  => LF_I2,
		 LF_I3  => LF_I3,
		 LF_Ci  => LF_Ci,
		 LG_I0  => LG_I0,
		 LG_I1  => LG_I1,
		 LG_I2  => LG_I2,
		 LG_I3  => LG_I3,
		 LG_Ci  => LG_Ci,
		 LH_I0  => LH_I0,
		 LH_I1  => LH_I1,
		 LH_I2  => LH_I2,
		 LH_I3  => LH_I3,
		 LH_Ci  => LH_Ci,
		 A  => A,
		 B  => B,
		 C  => C,
		 D  => D,
		 E  => E,
		 F  => F,
		 G  => G,
		 H  => H,
		 S0  => S0,
		 S1  => S1,
		 S2  => S2,
		 S3  => S3,
		 J2MID_ABa_BEG0  => J2MID_ABa_BEG(0),
		 J2MID_ABa_BEG1  => J2MID_ABa_BEG(1),
		 J2MID_ABa_BEG2  => J2MID_ABa_BEG(2),
		 J2MID_ABa_BEG3  => J2MID_ABa_BEG(3),
		 J2MID_CDa_BEG0  => J2MID_CDa_BEG(0),
		 J2MID_CDa_BEG1  => J2MID_CDa_BEG(1),
		 J2MID_CDa_BEG2  => J2MID_CDa_BEG(2),
		 J2MID_CDa_BEG3  => J2MID_CDa_BEG(3),
		 J2MID_EFa_BEG0  => J2MID_EFa_BEG(0),
		 J2MID_EFa_BEG1  => J2MID_EFa_BEG(1),
		 J2MID_EFa_BEG2  => J2MID_EFa_BEG(2),
		 J2MID_EFa_BEG3  => J2MID_EFa_BEG(3),
		 J2MID_GHa_BEG0  => J2MID_GHa_BEG(0),
		 J2MID_GHa_BEG1  => J2MID_GHa_BEG(1),
		 J2MID_GHa_BEG2  => J2MID_GHa_BEG(2),
		 J2MID_GHa_BEG3  => J2MID_GHa_BEG(3),
		 J2MID_ABb_BEG0  => J2MID_ABb_BEG(0),
		 J2MID_ABb_BEG1  => J2MID_ABb_BEG(1),
		 J2MID_ABb_BEG2  => J2MID_ABb_BEG(2),
		 J2MID_ABb_BEG3  => J2MID_ABb_BEG(3),
		 J2MID_CDb_BEG0  => J2MID_CDb_BEG(0),
		 J2MID_CDb_BEG1  => J2MID_CDb_BEG(1),
		 J2MID_CDb_BEG2  => J2MID_CDb_BEG(2),
		 J2MID_CDb_BEG3  => J2MID_CDb_BEG(3),
		 J2MID_EFb_BEG0  => J2MID_EFb_BEG(0),
		 J2MID_EFb_BEG1  => J2MID_EFb_BEG(1),
		 J2MID_EFb_BEG2  => J2MID_EFb_BEG(2),
		 J2MID_EFb_BEG3  => J2MID_EFb_BEG(3),
		 J2MID_GHb_BEG0  => J2MID_GHb_BEG(0),
		 J2MID_GHb_BEG1  => J2MID_GHb_BEG(1),
		 J2MID_GHb_BEG2  => J2MID_GHb_BEG(2),
		 J2MID_GHb_BEG3  => J2MID_GHb_BEG(3),
		 J2END_AB_BEG0  => J2END_AB_BEG(0),
		 J2END_AB_BEG1  => J2END_AB_BEG(1),
		 J2END_AB_BEG2  => J2END_AB_BEG(2),
		 J2END_AB_BEG3  => J2END_AB_BEG(3),
		 J2END_CD_BEG0  => J2END_CD_BEG(0),
		 J2END_CD_BEG1  => J2END_CD_BEG(1),
		 J2END_CD_BEG2  => J2END_CD_BEG(2),
		 J2END_CD_BEG3  => J2END_CD_BEG(3),
		 J2END_EF_BEG0  => J2END_EF_BEG(0),
		 J2END_EF_BEG1  => J2END_EF_BEG(1),
		 J2END_EF_BEG2  => J2END_EF_BEG(2),
		 J2END_EF_BEG3  => J2END_EF_BEG(3),
		 J2END_GH_BEG0  => J2END_GH_BEG(0),
		 J2END_GH_BEG1  => J2END_GH_BEG(1),
		 J2END_GH_BEG2  => J2END_GH_BEG(2),
		 J2END_GH_BEG3  => J2END_GH_BEG(3),
		 JN2BEG0  => JN2BEG(0),
		 JN2BEG1  => JN2BEG(1),
		 JN2BEG2  => JN2BEG(2),
		 JN2BEG3  => JN2BEG(3),
		 JN2BEG4  => JN2BEG(4),
		 JN2BEG5  => JN2BEG(5),
		 JN2BEG6  => JN2BEG(6),
		 JN2BEG7  => JN2BEG(7),
		 JE2BEG0  => JE2BEG(0),
		 JE2BEG1  => JE2BEG(1),
		 JE2BEG2  => JE2BEG(2),
		 JE2BEG3  => JE2BEG(3),
		 JE2BEG4  => JE2BEG(4),
		 JE2BEG5  => JE2BEG(5),
		 JE2BEG6  => JE2BEG(6),
		 JE2BEG7  => JE2BEG(7),
		 JS2BEG0  => JS2BEG(0),
		 JS2BEG1  => JS2BEG(1),
		 JS2BEG2  => JS2BEG(2),
		 JS2BEG3  => JS2BEG(3),
		 JS2BEG4  => JS2BEG(4),
		 JS2BEG5  => JS2BEG(5),
		 JS2BEG6  => JS2BEG(6),
		 JS2BEG7  => JS2BEG(7),
		 JW2BEG0  => JW2BEG(0),
		 JW2BEG1  => JW2BEG(1),
		 JW2BEG2  => JW2BEG(2),
		 JW2BEG3  => JW2BEG(3),
		 JW2BEG4  => JW2BEG(4),
		 JW2BEG5  => JW2BEG(5),
		 JW2BEG6  => JW2BEG(6),
		 JW2BEG7  => JW2BEG(7),
		 J_l_AB_BEG0  => J_l_AB_BEG(0),
		 J_l_AB_BEG1  => J_l_AB_BEG(1),
		 J_l_AB_BEG2  => J_l_AB_BEG(2),
		 J_l_AB_BEG3  => J_l_AB_BEG(3),
		 J_l_CD_BEG0  => J_l_CD_BEG(0),
		 J_l_CD_BEG1  => J_l_CD_BEG(1),
		 J_l_CD_BEG2  => J_l_CD_BEG(2),
		 J_l_CD_BEG3  => J_l_CD_BEG(3),
		 J_l_EF_BEG0  => J_l_EF_BEG(0),
		 J_l_EF_BEG1  => J_l_EF_BEG(1),
		 J_l_EF_BEG2  => J_l_EF_BEG(2),
		 J_l_EF_BEG3  => J_l_EF_BEG(3),
		 J_l_GH_BEG0  => J_l_GH_BEG(0),
		 J_l_GH_BEG1  => J_l_GH_BEG(1),
		 J_l_GH_BEG2  => J_l_GH_BEG(2),
		 J_l_GH_BEG3  => J_l_GH_BEG(3),
		 ConfigBits => ConfigBits ( 538 -1 downto 146 ) 
		 );  

end Behavioral;

