library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  DSP_bot  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 368 );
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
		 bot2top 	: out 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:10 X_offset:0 Y_offset:1  source_name:bot2top destination_name:NULL  
		 N1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
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
		 top2bot 	: in 	STD_LOGIC_VECTOR( 17 downto 0 );	 -- wires:18 X_offset:0 Y_offset:-1  source_name:NULL destination_name:top2bot  
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
end entity DSP_bot ;

architecture Behavioral of  DSP_bot  is 

component MULADD is
    Generic ( NoConfigBits : integer := 6 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port (      -- IMPORTANT: this has to be in a dedicated line
		A7 	: in	std_logic;					-- operand A
		A6 	: in	std_logic;					
		A5 	: in	std_logic;					
		A4 	: in	std_logic;					
		A3 	: in	std_logic;					
		A2 	: in	std_logic;					
		A1 	: in	std_logic;					
		A0 	: in	std_logic;					
 	
		B7 	: in	std_logic;					-- operand B
		B6 	: in	std_logic;					
		B5 	: in	std_logic;					
		B4 	: in	std_logic;					
		B3 	: in	std_logic;					
		B2 	: in	std_logic;					
		B1 	: in	std_logic;					
		B0 	: in	std_logic;					
  
		C19	: in	std_logic;					-- operand C
		C18	: in	std_logic;					
		C17	: in	std_logic;					
		C16	: in	std_logic;					
		C15	: in	std_logic;					
		C14	: in	std_logic;					
		C13	: in	std_logic;					
		C12	: in	std_logic;					
		C11	: in	std_logic;					
		C10	: in	std_logic;					
		C9 	: in	std_logic;					
		C8 	: in	std_logic;					
		C7 	: in	std_logic;					
		C6 	: in	std_logic;					
		C5 	: in	std_logic;					
		C4 	: in	std_logic;					
		C3 	: in	std_logic;					
		C2 	: in	std_logic;					
		C1 	: in	std_logic;					
		C0 	: in	std_logic;					
		
		Q19	: out	std_logic;					-- result
		Q18	: out	std_logic;					
		Q17	: out	std_logic;					
		Q16	: out	std_logic;					
		Q15	: out	std_logic;					
		Q14	: out	std_logic;					
		Q13	: out	std_logic;					
		Q12	: out	std_logic;					
		Q11	: out	std_logic;					
		Q10	: out	std_logic;					
		Q9 	: out	std_logic;					
		Q8 	: out	std_logic;					
		Q7 	: out	std_logic;					
		Q6 	: out	std_logic;					
		Q5 	: out	std_logic;					
		Q4 	: out	std_logic;					
		Q3 	: out	std_logic;					
		Q2 	: out	std_logic;					
		Q1 	: out	std_logic;					
		Q0 	: out	std_logic;					
		
		clr : in	std_logic;	
		
	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this sisgnal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component MULADD;


component  DSP_bot_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 362 );
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
		  top2bot0 	: in 	 STD_LOGIC;
		  top2bot1 	: in 	 STD_LOGIC;
		  top2bot2 	: in 	 STD_LOGIC;
		  top2bot3 	: in 	 STD_LOGIC;
		  top2bot4 	: in 	 STD_LOGIC;
		  top2bot5 	: in 	 STD_LOGIC;
		  top2bot6 	: in 	 STD_LOGIC;
		  top2bot7 	: in 	 STD_LOGIC;
		  top2bot8 	: in 	 STD_LOGIC;
		  top2bot9 	: in 	 STD_LOGIC;
		  top2bot10 	: in 	 STD_LOGIC;
		  top2bot11 	: in 	 STD_LOGIC;
		  top2bot12 	: in 	 STD_LOGIC;
		  top2bot13 	: in 	 STD_LOGIC;
		  top2bot14 	: in 	 STD_LOGIC;
		  top2bot15 	: in 	 STD_LOGIC;
		  top2bot16 	: in 	 STD_LOGIC;
		  top2bot17 	: in 	 STD_LOGIC;
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
		  Q19 	: in 	 STD_LOGIC;
		  Q18 	: in 	 STD_LOGIC;
		  Q17 	: in 	 STD_LOGIC;
		  Q16 	: in 	 STD_LOGIC;
		  Q15 	: in 	 STD_LOGIC;
		  Q14 	: in 	 STD_LOGIC;
		  Q13 	: in 	 STD_LOGIC;
		  Q12 	: in 	 STD_LOGIC;
		  Q11 	: in 	 STD_LOGIC;
		  Q10 	: in 	 STD_LOGIC;
		  Q9 	: in 	 STD_LOGIC;
		  Q8 	: in 	 STD_LOGIC;
		  Q7 	: in 	 STD_LOGIC;
		  Q6 	: in 	 STD_LOGIC;
		  Q5 	: in 	 STD_LOGIC;
		  Q4 	: in 	 STD_LOGIC;
		  Q3 	: in 	 STD_LOGIC;
		  Q2 	: in 	 STD_LOGIC;
		  Q1 	: in 	 STD_LOGIC;
		  Q0 	: in 	 STD_LOGIC;
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
		  bot2top0 	: out 	 STD_LOGIC;
		  bot2top1 	: out 	 STD_LOGIC;
		  bot2top2 	: out 	 STD_LOGIC;
		  bot2top3 	: out 	 STD_LOGIC;
		  bot2top4 	: out 	 STD_LOGIC;
		  bot2top5 	: out 	 STD_LOGIC;
		  bot2top6 	: out 	 STD_LOGIC;
		  bot2top7 	: out 	 STD_LOGIC;
		  bot2top8 	: out 	 STD_LOGIC;
		  bot2top9 	: out 	 STD_LOGIC;
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
		  A7 	: out 	 STD_LOGIC;
		  A6 	: out 	 STD_LOGIC;
		  A5 	: out 	 STD_LOGIC;
		  A4 	: out 	 STD_LOGIC;
		  A3 	: out 	 STD_LOGIC;
		  A2 	: out 	 STD_LOGIC;
		  A1 	: out 	 STD_LOGIC;
		  A0 	: out 	 STD_LOGIC;
		  B7 	: out 	 STD_LOGIC;
		  B6 	: out 	 STD_LOGIC;
		  B5 	: out 	 STD_LOGIC;
		  B4 	: out 	 STD_LOGIC;
		  B3 	: out 	 STD_LOGIC;
		  B2 	: out 	 STD_LOGIC;
		  B1 	: out 	 STD_LOGIC;
		  B0 	: out 	 STD_LOGIC;
		  C19 	: out 	 STD_LOGIC;
		  C18 	: out 	 STD_LOGIC;
		  C17 	: out 	 STD_LOGIC;
		  C16 	: out 	 STD_LOGIC;
		  C15 	: out 	 STD_LOGIC;
		  C14 	: out 	 STD_LOGIC;
		  C13 	: out 	 STD_LOGIC;
		  C12 	: out 	 STD_LOGIC;
		  C11 	: out 	 STD_LOGIC;
		  C10 	: out 	 STD_LOGIC;
		  C9 	: out 	 STD_LOGIC;
		  C8 	: out 	 STD_LOGIC;
		  C7 	: out 	 STD_LOGIC;
		  C6 	: out 	 STD_LOGIC;
		  C5 	: out 	 STD_LOGIC;
		  C4 	: out 	 STD_LOGIC;
		  C3 	: out 	 STD_LOGIC;
		  C2 	: out 	 STD_LOGIC;
		  C1 	: out 	 STD_LOGIC;
		  C0 	: out 	 STD_LOGIC;
		  clr 	: out 	 STD_LOGIC;
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
end component DSP_bot_switch_matrix ;


component  DSP_bot_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 368 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end component;

-- signal declarations

-- BEL ports (e.g., slices)
signal	A7	:STD_LOGIC;
signal	A6	:STD_LOGIC;
signal	A5	:STD_LOGIC;
signal	A4	:STD_LOGIC;
signal	A3	:STD_LOGIC;
signal	A2	:STD_LOGIC;
signal	A1	:STD_LOGIC;
signal	A0	:STD_LOGIC;
signal	B7	:STD_LOGIC;
signal	B6	:STD_LOGIC;
signal	B5	:STD_LOGIC;
signal	B4	:STD_LOGIC;
signal	B3	:STD_LOGIC;
signal	B2	:STD_LOGIC;
signal	B1	:STD_LOGIC;
signal	B0	:STD_LOGIC;
signal	C19	:STD_LOGIC;
signal	C18	:STD_LOGIC;
signal	C17	:STD_LOGIC;
signal	C16	:STD_LOGIC;
signal	C15	:STD_LOGIC;
signal	C14	:STD_LOGIC;
signal	C13	:STD_LOGIC;
signal	C12	:STD_LOGIC;
signal	C11	:STD_LOGIC;
signal	C10	:STD_LOGIC;
signal	C9	:STD_LOGIC;
signal	C8	:STD_LOGIC;
signal	C7	:STD_LOGIC;
signal	C6	:STD_LOGIC;
signal	C5	:STD_LOGIC;
signal	C4	:STD_LOGIC;
signal	C3	:STD_LOGIC;
signal	C2	:STD_LOGIC;
signal	C1	:STD_LOGIC;
signal	C0	:STD_LOGIC;
signal	clr	:STD_LOGIC;
signal	Q19	:STD_LOGIC;
signal	Q18	:STD_LOGIC;
signal	Q17	:STD_LOGIC;
signal	Q16	:STD_LOGIC;
signal	Q15	:STD_LOGIC;
signal	Q14	:STD_LOGIC;
signal	Q13	:STD_LOGIC;
signal	Q12	:STD_LOGIC;
signal	Q11	:STD_LOGIC;
signal	Q10	:STD_LOGIC;
signal	Q9	:STD_LOGIC;
signal	Q8	:STD_LOGIC;
signal	Q7	:STD_LOGIC;
signal	Q6	:STD_LOGIC;
signal	Q5	:STD_LOGIC;
signal	Q4	:STD_LOGIC;
signal	Q3	:STD_LOGIC;
signal	Q2	:STD_LOGIC;
signal	Q1	:STD_LOGIC;
signal	Q0	:STD_LOGIC;
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
signal	conf_data	:	 STD_LOGIC_VECTOR(2 downto 0);
signal 	 ConfigBits :	 STD_LOGIC_VECTOR (NoConfigBits -1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
N4BEG(N4BEG'high - 4 downto 0) <= N4END(N4END'high downto 4);
E6BEG(E6BEG'high - 2 downto 0) <= E6END(E6END'high downto 2);
S4BEG(S4BEG'high - 4 downto 0) <= S4END(S4END'high downto 4);
W6BEG(W6BEG'high - 2 downto 0) <= W6END(W6END'high downto 2);

-- configuration storage latches
Inst_DSP_bot_ConfigMem : DSP_bot_ConfigMem
	Port Map( 
		 FrameData  	 =>	 FrameData, 
		 FrameStrobe 	 =>	 FrameStrobe, 
		 ConfigBits 	 =>	 ConfigBits  );

-- BEL component instantiations

Inst_MULADD : MULADD
	Port Map(
		 A7  =>  A7 ,
		 A6  =>  A6 ,
		 A5  =>  A5 ,
		 A4  =>  A4 ,
		 A3  =>  A3 ,
		 A2  =>  A2 ,
		 A1  =>  A1 ,
		 A0  =>  A0 ,
		 B7  =>  B7 ,
		 B6  =>  B6 ,
		 B5  =>  B5 ,
		 B4  =>  B4 ,
		 B3  =>  B3 ,
		 B2  =>  B2 ,
		 B1  =>  B1 ,
		 B0  =>  B0 ,
		 C19  =>  C19 ,
		 C18  =>  C18 ,
		 C17  =>  C17 ,
		 C16  =>  C16 ,
		 C15  =>  C15 ,
		 C14  =>  C14 ,
		 C13  =>  C13 ,
		 C12  =>  C12 ,
		 C11  =>  C11 ,
		 C10  =>  C10 ,
		 C9  =>  C9 ,
		 C8  =>  C8 ,
		 C7  =>  C7 ,
		 C6  =>  C6 ,
		 C5  =>  C5 ,
		 C4  =>  C4 ,
		 C3  =>  C3 ,
		 C2  =>  C2 ,
		 C1  =>  C1 ,
		 C0  =>  C0 ,
		 clr  =>  clr ,
		 Q19  =>  Q19 ,
		 Q18  =>  Q18 ,
		 Q17  =>  Q17 ,
		 Q16  =>  Q16 ,
		 Q15  =>  Q15 ,
		 Q14  =>  Q14 ,
		 Q13  =>  Q13 ,
		 Q12  =>  Q12 ,
		 Q11  =>  Q11 ,
		 Q10  =>  Q10 ,
		 Q9  =>  Q9 ,
		 Q8  =>  Q8 ,
		 Q7  =>  Q7 ,
		 Q6  =>  Q6 ,
		 Q5  =>  Q5 ,
		 Q4  =>  Q4 ,
		 Q3  =>  Q3 ,
		 Q2  =>  Q2 ,
		 Q1  =>  Q1 ,
		 Q0  =>  Q0 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 6 -1 downto 0 ) );


-- switch matrix component instantiation

Inst_DSP_bot_switch_matrix : DSP_bot_switch_matrix
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
		 top2bot0  => top2bot(0),
		 top2bot1  => top2bot(1),
		 top2bot2  => top2bot(2),
		 top2bot3  => top2bot(3),
		 top2bot4  => top2bot(4),
		 top2bot5  => top2bot(5),
		 top2bot6  => top2bot(6),
		 top2bot7  => top2bot(7),
		 top2bot8  => top2bot(8),
		 top2bot9  => top2bot(9),
		 top2bot10  => top2bot(10),
		 top2bot11  => top2bot(11),
		 top2bot12  => top2bot(12),
		 top2bot13  => top2bot(13),
		 top2bot14  => top2bot(14),
		 top2bot15  => top2bot(15),
		 top2bot16  => top2bot(16),
		 top2bot17  => top2bot(17),
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
		 Q19  => Q19,
		 Q18  => Q18,
		 Q17  => Q17,
		 Q16  => Q16,
		 Q15  => Q15,
		 Q14  => Q14,
		 Q13  => Q13,
		 Q12  => Q12,
		 Q11  => Q11,
		 Q10  => Q10,
		 Q9  => Q9,
		 Q8  => Q8,
		 Q7  => Q7,
		 Q6  => Q6,
		 Q5  => Q5,
		 Q4  => Q4,
		 Q3  => Q3,
		 Q2  => Q2,
		 Q1  => Q1,
		 Q0  => Q0,
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
		 bot2top0  => bot2top(0),
		 bot2top1  => bot2top(1),
		 bot2top2  => bot2top(2),
		 bot2top3  => bot2top(3),
		 bot2top4  => bot2top(4),
		 bot2top5  => bot2top(5),
		 bot2top6  => bot2top(6),
		 bot2top7  => bot2top(7),
		 bot2top8  => bot2top(8),
		 bot2top9  => bot2top(9),
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
		 A7  => A7,
		 A6  => A6,
		 A5  => A5,
		 A4  => A4,
		 A3  => A3,
		 A2  => A2,
		 A1  => A1,
		 A0  => A0,
		 B7  => B7,
		 B6  => B6,
		 B5  => B5,
		 B4  => B4,
		 B3  => B3,
		 B2  => B2,
		 B1  => B1,
		 B0  => B0,
		 C19  => C19,
		 C18  => C18,
		 C17  => C17,
		 C16  => C16,
		 C15  => C15,
		 C14  => C14,
		 C13  => C13,
		 C12  => C12,
		 C11  => C11,
		 C10  => C10,
		 C9  => C9,
		 C8  => C8,
		 C7  => C7,
		 C6  => C6,
		 C5  => C5,
		 C4  => C4,
		 C3  => C3,
		 C2  => C2,
		 C1  => C1,
		 C0  => C0,
		 clr  => clr,
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
		 ConfigBits => ConfigBits ( 368 -1 downto 6 ) 
		 );  

end Behavioral;

