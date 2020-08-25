library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  N_term  is 
	Port (
	--  NORTH
		 N1END 	: in 	STD_LOGIC_VECTOR( 2 downto 0 );	 -- wires:  3
		 N2END 	: in 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:  3
		 N4END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:  2
	--  EAST
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 4 downto 0 );	 -- wires:  5
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:  5
	--  WEST
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity N_term ;

architecture Behavioral of  N_term  is 


component  N_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
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
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component N_term_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
-- Tile ports (the signals to wire all tile top-level routing signals)
signal	sigN1END	:	STD_LOGIC_VECTOR(3 downto 0);
signal	sigN2END	:	STD_LOGIC_VECTOR(6 downto 0);
signal	sigN4END	:	STD_LOGIC_VECTOR(8 downto 0);
signal	sigS1BEG	:	STD_LOGIC_VECTOR(5 downto 0);
signal	sigS2BEG	:	STD_LOGIC_VECTOR(10 downto 0);
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	STD_LOGIC_VECTOR(1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
NULL(NULL'high - 3 downto 0) <= N2END(N2END'high downto 3);
NULL(NULL'high - 2 downto 0) <= N4END(N4END'high downto 2);
S2BEG(S2BEG'high - 5 downto 0) <= NULL(NULL'high downto 5);
-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity

-- BEL component instantiations


-- switch matrix component instantiation

Inst_N_term_switch_matrix : N_term_switch_matrix
	Port Map(
		 N1END0  => N1END(0) ,
		 N1END1  => N1END(1) ,
		 N1END2  => N1END(2) ,
		 N2END0  => N2END(0) ,
		 N2END1  => N2END(1) ,
		 N2END2  => N2END(2) ,
		 N4END0  => N4END(0) ,
		 N4END1  => N4END(1) ,
		 S1BEG0  => S1BEG(0) ,
		 S1BEG1  => S1BEG(1) ,
		 S1BEG2  => S1BEG(2) ,
		 S1BEG3  => S1BEG(3) ,
		 S1BEG4  => S1BEG(4) ,
		 S2BEG0  => S2BEG(5) ,
		 S2BEG1  => S2BEG(6) ,
		 S2BEG2  => S2BEG(7) ,
		 S2BEG3  => S2BEG(8) ,
		 S2BEG4  => S2BEG(9) ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(0),  
		 CONFout	=> conf_data(1),  
		 CLK => CLK );  

end Behavioral;

