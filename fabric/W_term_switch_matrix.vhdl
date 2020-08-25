-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  W_term_switch_matrix  is 
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
		  W2END6 	: in 	 STD_LOGIC;
		  W2END7 	: in 	 STD_LOGIC;
		  W2END8 	: in 	 STD_LOGIC;
		  W2END9 	: in 	 STD_LOGIC;
		  W2END10 	: in 	 STD_LOGIC;
		  W2END11 	: in 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
		  E2BEG4 	: out 	 STD_LOGIC;
		  E2BEG5 	: out 	 STD_LOGIC;
		  E2BEG6 	: out 	 STD_LOGIC;
		  E2BEG7 	: out 	 STD_LOGIC
	-- global
	);
end entity W_term_switch_matrix ;

architecture Behavioral of  W_term_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
	
signal 	  E1BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E1BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E1BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E1BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  E1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG0
-- switch matrix multiplexer  E1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG1
-- switch matrix multiplexer  E1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG2
-- switch matrix multiplexer  E1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG3
-- switch matrix multiplexer  E2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG0
-- switch matrix multiplexer  E2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG1
-- switch matrix multiplexer  E2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG2
-- switch matrix multiplexer  E2BEG3 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG3
-- switch matrix multiplexer  E2BEG4 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG4
-- switch matrix multiplexer  E2BEG5 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG5
-- switch matrix multiplexer  E2BEG6 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG6
-- switch matrix multiplexer  E2BEG7 		MUX-0
-- WARNING unused multiplexer MUX-E2BEG7

end architecture Behavioral;

