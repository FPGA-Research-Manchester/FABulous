library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  N_term_IO  is 
	Port (
	--  NORTH
		 N1END 	: in 	STD_LOGIC_VECTOR( 2 downto 0 );	 -- wires:3 X_offset:0 Y_offset:1  source_name:NULL destination_name:N1END  
		 N2END 	: in 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:3 X_offset:0 Y_offset:2  source_name:NULL destination_name:N2END  
	--  EAST
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 4 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:NULL  
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destination_name:NULL  
	--  WEST
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity N_term_IO ;

architecture Behavioral of  N_term_IO  is 


component  N_term_IO_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N2END3 	: in 	 STD_LOGIC;
		  N2END4 	: in 	 STD_LOGIC;
		  N2END5 	: in 	 STD_LOGIC;
		  S1BEG0 	: out 	 STD_LOGIC;
		  S1BEG1 	: out 	 STD_LOGIC;
		  S1BEG2 	: out 	 STD_LOGIC;
		  S1BEG3 	: out 	 STD_LOGIC;
		  S1BEG4 	: out 	 STD_LOGIC;
		  S2BEG0 	: out 	 STD_LOGIC;
		  S2BEG1 	: out 	 STD_LOGIC;
		  S2BEG2 	: out 	 STD_LOGIC;
		  S2BEG3 	: out 	 STD_LOGIC;
		  S2BEG4 	: out 	 STD_LOGIC;
		  S2BEG5 	: out 	 STD_LOGIC;
		  S2BEG6 	: out 	 STD_LOGIC;
		  S2BEG7 	: out 	 STD_LOGIC;
		  S2BEG8 	: out 	 STD_LOGIC;
		  S2BEG9 	: out 	 STD_LOGIC
	-- global
	);
end component N_term_IO_switch_matrix ;


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

Inst_N_term_IO_switch_matrix : N_term_IO_switch_matrix
	Port Map(
		 N1END0  => N1END(0),
		 N1END1  => N1END(1),
		 N1END2  => N1END(2),
		 N2END0  => N2END(0),
		 N2END1  => N2END(1),
		 N2END2  => N2END(2),
		 N2END3  => N2END(3),
		 N2END4  => N2END(4),
		 N2END5  => N2END(5),
		 S1BEG0  => S1BEG(0),
		 S1BEG1  => S1BEG(1),
		 S1BEG2  => S1BEG(2),
		 S1BEG3  => S1BEG(3),
		 S1BEG4  => S1BEG(4),
		 S2BEG0  => S2BEG(0),
		 S2BEG1  => S2BEG(1),
		 S2BEG2  => S2BEG(2),
		 S2BEG3  => S2BEG(3),
		 S2BEG4  => S2BEG(4),
		 S2BEG5  => S2BEG(5),
		 S2BEG6  => S2BEG(6),
		 S2BEG7  => S2BEG(7),
		 S2BEG8  => S2BEG(8),
		 S2BEG9  => S2BEG(9)		 );  

end Behavioral;

