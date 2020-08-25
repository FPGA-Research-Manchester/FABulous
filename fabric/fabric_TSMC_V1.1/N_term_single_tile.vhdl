library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  N_term_single  is 
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
end entity N_term_single ;

architecture Behavioral of  N_term_single  is 


component  N_term_single_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 0 );
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
		  N4END4 	: in 	 STD_LOGIC;
		  N4END5 	: in 	 STD_LOGIC;
		  N4END6 	: in 	 STD_LOGIC;
		  N4END7 	: in 	 STD_LOGIC;
		  N4END8 	: in 	 STD_LOGIC;
		  N4END9 	: in 	 STD_LOGIC;
		  N4END10 	: in 	 STD_LOGIC;
		  N4END11 	: in 	 STD_LOGIC;
		  N4END12 	: in 	 STD_LOGIC;
		  N4END13 	: in 	 STD_LOGIC;
		  N4END14 	: in 	 STD_LOGIC;
		  N4END15 	: in 	 STD_LOGIC;
		  Ci0 	: in 	 STD_LOGIC;
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
		  S4BEG4 	: out 	 STD_LOGIC;
		  S4BEG5 	: out 	 STD_LOGIC;
		  S4BEG6 	: out 	 STD_LOGIC;
		  S4BEG7 	: out 	 STD_LOGIC;
		  S4BEG8 	: out 	 STD_LOGIC;
		  S4BEG9 	: out 	 STD_LOGIC;
		  S4BEG10 	: out 	 STD_LOGIC;
		  S4BEG11 	: out 	 STD_LOGIC;
		  S4BEG12 	: out 	 STD_LOGIC;
		  S4BEG13 	: out 	 STD_LOGIC;
		  S4BEG14 	: out 	 STD_LOGIC;
		  S4BEG15 	: out 	 STD_LOGIC 

	-- global
	);
end component N_term_single_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	 STD_LOGIC_VECTOR(0 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile

-- BEL component instantiations


-- switch matrix component instantiation

Inst_N_term_single_switch_matrix : N_term_single_switch_matrix
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
		 N4END4  => N4END(4),
		 N4END5  => N4END(5),
		 N4END6  => N4END(6),
		 N4END7  => N4END(7),
		 N4END8  => N4END(8),
		 N4END9  => N4END(9),
		 N4END10  => N4END(10),
		 N4END11  => N4END(11),
		 N4END12  => N4END(12),
		 N4END13  => N4END(13),
		 N4END14  => N4END(14),
		 N4END15  => N4END(15),
		 Ci0  => Ci(0),
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
		 S4BEG0  => S4BEG(0),
		 S4BEG1  => S4BEG(1),
		 S4BEG2  => S4BEG(2),
		 S4BEG3  => S4BEG(3),
		 S4BEG4  => S4BEG(4),
		 S4BEG5  => S4BEG(5),
		 S4BEG6  => S4BEG(6),
		 S4BEG7  => S4BEG(7),
		 S4BEG8  => S4BEG(8),
		 S4BEG9  => S4BEG(9),
		 S4BEG10  => S4BEG(10),
		 S4BEG11  => S4BEG(11),
		 S4BEG12  => S4BEG(12),
		 S4BEG13  => S4BEG(13),
		 S4BEG14  => S4BEG(14),
		 S4BEG15  => S4BEG(15)		 );  

end Behavioral;

