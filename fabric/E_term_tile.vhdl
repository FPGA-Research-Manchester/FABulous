library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  E_term  is 
	Port (
	--  NORTH
	--  EAST
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:NULL destination_name:E1END  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:4 X_offset:2 Y_offset:0  source_name:NULL destination_name:E2END  
	--  SOUTH
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:NULL  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG destination_name:NULL  
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity E_term ;

architecture Behavioral of  E_term  is 


component  E_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  E2END4 	: in 	 STD_LOGIC;
		  E2END5 	: in 	 STD_LOGIC;
		  E2END6 	: in 	 STD_LOGIC;
		  E2END7 	: in 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W1BEG4 	: out 	 STD_LOGIC;
		  W1BEG5 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  W2BEG6 	: out 	 STD_LOGIC;
		  W2BEG7 	: out 	 STD_LOGIC;
		  W2BEG8 	: out 	 STD_LOGIC;
		  W2BEG9 	: out 	 STD_LOGIC;
		  W2BEG10 	: out 	 STD_LOGIC;
		  W2BEG11 	: out 	 STD_LOGIC
	-- global
	);
end component E_term_switch_matrix ;


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

Inst_E_term_switch_matrix : E_term_switch_matrix
	Port Map(
		 E1END0  => E1END(0),
		 E1END1  => E1END(1),
		 E1END2  => E1END(2),
		 E1END3  => E1END(3),
		 E2END0  => E2END(0),
		 E2END1  => E2END(1),
		 E2END2  => E2END(2),
		 E2END3  => E2END(3),
		 E2END4  => E2END(4),
		 E2END5  => E2END(5),
		 E2END6  => E2END(6),
		 E2END7  => E2END(7),
		 W1BEG0  => W1BEG(0),
		 W1BEG1  => W1BEG(1),
		 W1BEG2  => W1BEG(2),
		 W1BEG3  => W1BEG(3),
		 W1BEG4  => W1BEG(4),
		 W1BEG5  => W1BEG(5),
		 W2BEG0  => W2BEG(0),
		 W2BEG1  => W2BEG(1),
		 W2BEG2  => W2BEG(2),
		 W2BEG3  => W2BEG(3),
		 W2BEG4  => W2BEG(4),
		 W2BEG5  => W2BEG(5),
		 W2BEG6  => W2BEG(6),
		 W2BEG7  => W2BEG(7),
		 W2BEG8  => W2BEG(8),
		 W2BEG9  => W2BEG(9),
		 W2BEG10  => W2BEG(10),
		 W2BEG11  => W2BEG(11)		 );  

end Behavioral;

