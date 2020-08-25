-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  S_term_IO_switch_matrix  is 
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
		  N2BEG5 	: out 	 STD_LOGIC
	-- global
	);
end entity S_term_IO_switch_matrix ;

architecture Behavioral of  S_term_IO_switch_matrix  is 

signal 	  N1BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N1BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N1BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  N2BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  N1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG0
-- switch matrix multiplexer  N1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG1
-- switch matrix multiplexer  N1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG2
-- switch matrix multiplexer  N2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG0
-- switch matrix multiplexer  N2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG1
-- switch matrix multiplexer  N2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG2
-- switch matrix multiplexer  N2BEG3 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG3
-- switch matrix multiplexer  N2BEG4 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG4
-- switch matrix multiplexer  N2BEG5 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG5

end architecture Behavioral;

