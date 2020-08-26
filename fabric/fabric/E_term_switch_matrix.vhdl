-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  E_term_switch_matrix  is 
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
end entity E_term_switch_matrix ;

architecture Behavioral of  E_term_switch_matrix  is 

signal 	  W1BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG8_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG9_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG10_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG11_input 	:	 std_logic_vector( 0 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  W1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG0
-- switch matrix multiplexer  W1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG1
-- switch matrix multiplexer  W1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG2
-- switch matrix multiplexer  W1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG3
-- switch matrix multiplexer  W1BEG4 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG4
-- switch matrix multiplexer  W1BEG5 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG5
-- switch matrix multiplexer  W2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG0
-- switch matrix multiplexer  W2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG1
-- switch matrix multiplexer  W2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG2
-- switch matrix multiplexer  W2BEG3 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG3
-- switch matrix multiplexer  W2BEG4 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG4
-- switch matrix multiplexer  W2BEG5 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG5
-- switch matrix multiplexer  W2BEG6 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG6
-- switch matrix multiplexer  W2BEG7 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG7
-- switch matrix multiplexer  W2BEG8 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG8
-- switch matrix multiplexer  W2BEG9 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG9
-- switch matrix multiplexer  W2BEG10 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG10
-- switch matrix multiplexer  W2BEG11 		MUX-0
-- WARNING unused multiplexer MUX-W2BEG11

end architecture Behavioral;

