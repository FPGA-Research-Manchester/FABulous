library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  S_term  is 
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 2 downto 0 );	 -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:NULL  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destination_name:NULL  
		 N4BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:2 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:NULL  
	--  EAST
	--  SOUTH
		 S1END 	: in 	STD_LOGIC_VECTOR( 4 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-1  source_name:NULL destination_name:S1END  
		 S2END 	: in 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-2  source_name:NULL destination_name:S2END  
	--  WEST
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity S_term ;

architecture Behavioral of  S_term  is 


component  S_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  S1END0 	: in 	 STD_LOGIC;
		  S1END1 	: in 	 STD_LOGIC;
		  S1END2 	: in 	 STD_LOGIC;
		  S1END3 	: in 	 STD_LOGIC;
		  S1END4 	: in 	 STD_LOGIC;
		  S2END0 	: in 	 STD_LOGIC;
		  S2END1 	: in 	 STD_LOGIC;
		  S2END2 	: in 	 STD_LOGIC;
		  S2END3 	: in 	 STD_LOGIC;
		  S2END4 	: in 	 STD_LOGIC;
		  S2END5 	: in 	 STD_LOGIC;
		  S2END6 	: in 	 STD_LOGIC;
		  S2END7 	: in 	 STD_LOGIC;
		  S2END8 	: in 	 STD_LOGIC;
		  S2END9 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  N2BEG3 	: out 	 STD_LOGIC;
		  N2BEG4 	: out 	 STD_LOGIC;
		  N2BEG5 	: out 	 STD_LOGIC;
		  N4BEG0 	: out 	 STD_LOGIC;
		  N4BEG1 	: out 	 STD_LOGIC;
		  N4BEG2 	: out 	 STD_LOGIC;
		  N4BEG3 	: out 	 STD_LOGIC;
		  N4BEG4 	: out 	 STD_LOGIC;
		  N4BEG5 	: out 	 STD_LOGIC;
		  N4BEG6 	: out 	 STD_LOGIC;
		  N4BEG7 	: out 	 STD_LOGIC
	-- global
	);
end component S_term_switch_matrix ;


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

Inst_S_term_switch_matrix : S_term_switch_matrix
	Port Map(
		 S1END0  => S1END(0),
		 S1END1  => S1END(1),
		 S1END2  => S1END(2),
		 S1END3  => S1END(3),
		 S1END4  => S1END(4),
		 S2END0  => S2END(0),
		 S2END1  => S2END(1),
		 S2END2  => S2END(2),
		 S2END3  => S2END(3),
		 S2END4  => S2END(4),
		 S2END5  => S2END(5),
		 S2END6  => S2END(6),
		 S2END7  => S2END(7),
		 S2END8  => S2END(8),
		 S2END9  => S2END(9),
		 N1BEG0  => N1BEG(0),
		 N1BEG1  => N1BEG(1),
		 N1BEG2  => N1BEG(2),
		 N2BEG0  => N2BEG(0),
		 N2BEG1  => N2BEG(1),
		 N2BEG2  => N2BEG(2),
		 N2BEG3  => N2BEG(3),
		 N2BEG4  => N2BEG(4),
		 N2BEG5  => N2BEG(5),
		 N4BEG0  => N4BEG(0),
		 N4BEG1  => N4BEG(1),
		 N4BEG2  => N4BEG(2),
		 N4BEG3  => N4BEG(3),
		 N4BEG4  => N4BEG(4),
		 N4BEG5  => N4BEG(5),
		 N4BEG6  => N4BEG(6),
		 N4BEG7  => N4BEG(7)		 );  

end Behavioral;

