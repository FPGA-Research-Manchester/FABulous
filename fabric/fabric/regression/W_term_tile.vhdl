library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  W_term  is 
	Port (
	--  NORTH
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:  4
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:  4
	--  SOUTH
	--  WEST
		 W1END 	: in 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:  6
		 W2END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:  6
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity W_term ;

architecture Behavioral of  W_term  is 


component  W_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  W1END0 	: in 	 STD_LOGIC;
		  W1END1 	: in 	 STD_LOGIC;
		  W1END2 	: in 	 STD_LOGIC;
		  W1END3 	: in 	 STD_LOGIC;
		  W1END4 	: in 	 STD_LOGIC;
		  W1END5 	: in 	 STD_LOGIC;
		  W2END0 	: in 	 STD_LOGIC;
		  W2END1 	: in 	 STD_LOGIC;
		  W2END2 	: in 	 STD_LOGIC;
		  W2END3 	: in 	 STD_LOGIC;
		  W2END4 	: in 	 STD_LOGIC;
		  W2END5 	: in 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component W_term_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
-- Tile ports (the signals to wire all tile top-level routing signals)
signal	sigW1END	:	STD_LOGIC_VECTOR(6 downto 0);
signal	sigW2END	:	STD_LOGIC_VECTOR(12 downto 0);
signal	sigE1BEG	:	STD_LOGIC_VECTOR(4 downto 0);
signal	sigE2BEG	:	STD_LOGIC_VECTOR(8 downto 0);
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	STD_LOGIC_VECTOR(1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
E2BEG(E2BEG'high - 4 downto 0) <= NULL(NULL'high downto 4);
NULL(NULL'high - 6 downto 0) <= W2END(W2END'high downto 6);
-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity

-- BEL component instantiations


-- switch matrix component instantiation

Inst_W_term_switch_matrix : W_term_switch_matrix
	Port Map(
		 W1END0  => W1END(0) ,
		 W1END1  => W1END(1) ,
		 W1END2  => W1END(2) ,
		 W1END3  => W1END(3) ,
		 W1END4  => W1END(4) ,
		 W1END5  => W1END(5) ,
		 W2END0  => W2END(0) ,
		 W2END1  => W2END(1) ,
		 W2END2  => W2END(2) ,
		 W2END3  => W2END(3) ,
		 W2END4  => W2END(4) ,
		 W2END5  => W2END(5) ,
		 E1BEG0  => E1BEG(0) ,
		 E1BEG1  => E1BEG(1) ,
		 E1BEG2  => E1BEG(2) ,
		 E1BEG3  => E1BEG(3) ,
		 E2BEG0  => E2BEG(4) ,
		 E2BEG1  => E2BEG(5) ,
		 E2BEG2  => E2BEG(6) ,
		 E2BEG3  => E2BEG(7) ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(0),  
		 CONFout	=> conf_data(1),  
		 CLK => CLK );  

end Behavioral;

