library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  S_term_single2  is 
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
	--  EAST
	--  SOUTH
		 S1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S1END  
		 S2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2MID  
		 S2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S2END  
		 S4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 ) 	 -- wires:4 X_offset:0 Y_offset:-4  source_name:NULL destination_name:S4END  
	--  WEST

	-- global
	);
end entity S_term_single2 ;

architecture Behavioral of  S_term_single2  is 


component  S_term_single2_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 0 );
	Port (
		 -- switch matrix inputs
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
		  S4END4 	: in 	 STD_LOGIC;
		  S4END5 	: in 	 STD_LOGIC;
		  S4END6 	: in 	 STD_LOGIC;
		  S4END7 	: in 	 STD_LOGIC;
		  S4END8 	: in 	 STD_LOGIC;
		  S4END9 	: in 	 STD_LOGIC;
		  S4END10 	: in 	 STD_LOGIC;
		  S4END11 	: in 	 STD_LOGIC;
		  S4END12 	: in 	 STD_LOGIC;
		  S4END13 	: in 	 STD_LOGIC;
		  S4END14 	: in 	 STD_LOGIC;
		  S4END15 	: in 	 STD_LOGIC;
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
		  N4BEG4 	: out 	 STD_LOGIC;
		  N4BEG5 	: out 	 STD_LOGIC;
		  N4BEG6 	: out 	 STD_LOGIC;
		  N4BEG7 	: out 	 STD_LOGIC;
		  N4BEG8 	: out 	 STD_LOGIC;
		  N4BEG9 	: out 	 STD_LOGIC;
		  N4BEG10 	: out 	 STD_LOGIC;
		  N4BEG11 	: out 	 STD_LOGIC;
		  N4BEG12 	: out 	 STD_LOGIC;
		  N4BEG13 	: out 	 STD_LOGIC;
		  N4BEG14 	: out 	 STD_LOGIC;
		  N4BEG15 	: out 	 STD_LOGIC 

	-- global
	);
end component S_term_single2_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	 STD_LOGIC_VECTOR(0 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile

-- BEL component instantiations


-- switch matrix component instantiation

Inst_S_term_single2_switch_matrix : S_term_single2_switch_matrix
	Port Map(
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
		 S4END4  => S4END(4),
		 S4END5  => S4END(5),
		 S4END6  => S4END(6),
		 S4END7  => S4END(7),
		 S4END8  => S4END(8),
		 S4END9  => S4END(9),
		 S4END10  => S4END(10),
		 S4END11  => S4END(11),
		 S4END12  => S4END(12),
		 S4END13  => S4END(13),
		 S4END14  => S4END(14),
		 S4END15  => S4END(15),
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
		 N4BEG0  => N4BEG(0),
		 N4BEG1  => N4BEG(1),
		 N4BEG2  => N4BEG(2),
		 N4BEG3  => N4BEG(3),
		 N4BEG4  => N4BEG(4),
		 N4BEG5  => N4BEG(5),
		 N4BEG6  => N4BEG(6),
		 N4BEG7  => N4BEG(7),
		 N4BEG8  => N4BEG(8),
		 N4BEG9  => N4BEG(9),
		 N4BEG10  => N4BEG(10),
		 N4BEG11  => N4BEG(11),
		 N4BEG12  => N4BEG(12),
		 N4BEG13  => N4BEG(13),
		 N4BEG14  => N4BEG(14),
		 N4BEG15  => N4BEG(15)		 );  

end Behavioral;

