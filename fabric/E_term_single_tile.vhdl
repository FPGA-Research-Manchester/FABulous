library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  E_term_single  is 
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
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity E_term_single ;

architecture Behavioral of  E_term_single  is 


component  E_term_single_switch_matrix  is 
	Port (
		 -- switch matrix inputs
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
		  E6END2 	: in 	 STD_LOGIC;
		  E6END3 	: in 	 STD_LOGIC;
		  E6END4 	: in 	 STD_LOGIC;
		  E6END5 	: in 	 STD_LOGIC;
		  E6END6 	: in 	 STD_LOGIC;
		  E6END7 	: in 	 STD_LOGIC;
		  E6END8 	: in 	 STD_LOGIC;
		  E6END9 	: in 	 STD_LOGIC;
		  E6END10 	: in 	 STD_LOGIC;
		  E6END11 	: in 	 STD_LOGIC;
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
		  W6BEG2 	: out 	 STD_LOGIC;
		  W6BEG3 	: out 	 STD_LOGIC;
		  W6BEG4 	: out 	 STD_LOGIC;
		  W6BEG5 	: out 	 STD_LOGIC;
		  W6BEG6 	: out 	 STD_LOGIC;
		  W6BEG7 	: out 	 STD_LOGIC;
		  W6BEG8 	: out 	 STD_LOGIC;
		  W6BEG9 	: out 	 STD_LOGIC;
		  W6BEG10 	: out 	 STD_LOGIC;
		  W6BEG11 	: out 	 STD_LOGIC
	-- global
	);
end component E_term_single_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	STD_LOGIC_VECTOR(0 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity

-- BEL component instantiations


-- switch matrix component instantiation

Inst_E_term_single_switch_matrix : E_term_single_switch_matrix
	Port Map(
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
		 E6END2  => E6END(2),
		 E6END3  => E6END(3),
		 E6END4  => E6END(4),
		 E6END5  => E6END(5),
		 E6END6  => E6END(6),
		 E6END7  => E6END(7),
		 E6END8  => E6END(8),
		 E6END9  => E6END(9),
		 E6END10  => E6END(10),
		 E6END11  => E6END(11),
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
		 W6BEG0  => W6BEG(0),
		 W6BEG1  => W6BEG(1),
		 W6BEG2  => W6BEG(2),
		 W6BEG3  => W6BEG(3),
		 W6BEG4  => W6BEG(4),
		 W6BEG5  => W6BEG(5),
		 W6BEG6  => W6BEG(6),
		 W6BEG7  => W6BEG(7),
		 W6BEG8  => W6BEG(8),
		 W6BEG9  => W6BEG(9),
		 W6BEG10  => W6BEG(10),
		 W6BEG11  => W6BEG(11)		 );  

end Behavioral;

