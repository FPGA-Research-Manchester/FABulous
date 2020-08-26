-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  N_term_switch_matrix  is 
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
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
		  N4END2 	: in 	 STD_LOGIC;
		  N4END3 	: in 	 STD_LOGIC;
		  N4END4 	: in 	 STD_LOGIC;
		  N4END5 	: in 	 STD_LOGIC;
		  N4END6 	: in 	 STD_LOGIC;
		  N4END7 	: in 	 STD_LOGIC;
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
end entity N_term_switch_matrix ;

architecture Behavioral of  N_term_switch_matrix  is 

signal 	  S1BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S1BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S1BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S1BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S1BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG8_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  S2BEG9_input 	:	 std_logic_vector( 0 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  S1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG0
-- switch matrix multiplexer  S1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG1
-- switch matrix multiplexer  S1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG2
-- switch matrix multiplexer  S1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG3
-- switch matrix multiplexer  S1BEG4 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG4
-- switch matrix multiplexer  S2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG0
-- switch matrix multiplexer  S2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG1
-- switch matrix multiplexer  S2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG2
-- switch matrix multiplexer  S2BEG3 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG3
-- switch matrix multiplexer  S2BEG4 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG4
-- switch matrix multiplexer  S2BEG5 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG5
-- switch matrix multiplexer  S2BEG6 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG6
-- switch matrix multiplexer  S2BEG7 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG7
-- switch matrix multiplexer  S2BEG8 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG8
-- switch matrix multiplexer  S2BEG9 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG9

end architecture Behavioral;

