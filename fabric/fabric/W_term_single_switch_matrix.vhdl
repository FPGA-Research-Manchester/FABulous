-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  W_term_single_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  W1END0 	: in 	 STD_LOGIC;
		  W1END1 	: in 	 STD_LOGIC;
		  W1END2 	: in 	 STD_LOGIC;
		  W1END3 	: in 	 STD_LOGIC;
		  W2MID0 	: in 	 STD_LOGIC;
		  W2MID1 	: in 	 STD_LOGIC;
		  W2MID2 	: in 	 STD_LOGIC;
		  W2MID3 	: in 	 STD_LOGIC;
		  W2MID4 	: in 	 STD_LOGIC;
		  W2MID5 	: in 	 STD_LOGIC;
		  W2MID6 	: in 	 STD_LOGIC;
		  W2MID7 	: in 	 STD_LOGIC;
		  W2END0 	: in 	 STD_LOGIC;
		  W2END1 	: in 	 STD_LOGIC;
		  W2END2 	: in 	 STD_LOGIC;
		  W2END3 	: in 	 STD_LOGIC;
		  W2END4 	: in 	 STD_LOGIC;
		  W2END5 	: in 	 STD_LOGIC;
		  W2END6 	: in 	 STD_LOGIC;
		  W2END7 	: in 	 STD_LOGIC;
		  W6END0 	: in 	 STD_LOGIC;
		  W6END1 	: in 	 STD_LOGIC;
		  W6END2 	: in 	 STD_LOGIC;
		  W6END3 	: in 	 STD_LOGIC;
		  W6END4 	: in 	 STD_LOGIC;
		  W6END5 	: in 	 STD_LOGIC;
		  W6END6 	: in 	 STD_LOGIC;
		  W6END7 	: in 	 STD_LOGIC;
		  W6END8 	: in 	 STD_LOGIC;
		  W6END9 	: in 	 STD_LOGIC;
		  W6END10 	: in 	 STD_LOGIC;
		  W6END11 	: in 	 STD_LOGIC;
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
		  E2BEG7 	: out 	 STD_LOGIC;
		  E2BEGb0 	: out 	 STD_LOGIC;
		  E2BEGb1 	: out 	 STD_LOGIC;
		  E2BEGb2 	: out 	 STD_LOGIC;
		  E2BEGb3 	: out 	 STD_LOGIC;
		  E2BEGb4 	: out 	 STD_LOGIC;
		  E2BEGb5 	: out 	 STD_LOGIC;
		  E2BEGb6 	: out 	 STD_LOGIC;
		  E2BEGb7 	: out 	 STD_LOGIC;
		  E6BEG0 	: out 	 STD_LOGIC;
		  E6BEG1 	: out 	 STD_LOGIC;
		  E6BEG2 	: out 	 STD_LOGIC;
		  E6BEG3 	: out 	 STD_LOGIC;
		  E6BEG4 	: out 	 STD_LOGIC;
		  E6BEG5 	: out 	 STD_LOGIC;
		  E6BEG6 	: out 	 STD_LOGIC;
		  E6BEG7 	: out 	 STD_LOGIC;
		  E6BEG8 	: out 	 STD_LOGIC;
		  E6BEG9 	: out 	 STD_LOGIC;
		  E6BEG10 	: out 	 STD_LOGIC;
		  E6BEG11 	: out 	 STD_LOGIC
	-- global
	);
end entity W_term_single_switch_matrix ;

architecture Behavioral of  W_term_single_switch_matrix  is 

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
signal 	  E2BEGb0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E2BEGb7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG8_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG9_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG10_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  E6BEG11_input 	:	 std_logic_vector( 0 - 1 downto 0 );

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
-- switch matrix multiplexer  E2BEGb0 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb0
-- switch matrix multiplexer  E2BEGb1 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb1
-- switch matrix multiplexer  E2BEGb2 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb2
-- switch matrix multiplexer  E2BEGb3 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb3
-- switch matrix multiplexer  E2BEGb4 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb4
-- switch matrix multiplexer  E2BEGb5 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb5
-- switch matrix multiplexer  E2BEGb6 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb6
-- switch matrix multiplexer  E2BEGb7 		MUX-0
-- WARNING unused multiplexer MUX-E2BEGb7
-- switch matrix multiplexer  E6BEG0 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG0
-- switch matrix multiplexer  E6BEG1 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG1
-- switch matrix multiplexer  E6BEG2 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG2
-- switch matrix multiplexer  E6BEG3 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG3
-- switch matrix multiplexer  E6BEG4 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG4
-- switch matrix multiplexer  E6BEG5 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG5
-- switch matrix multiplexer  E6BEG6 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG6
-- switch matrix multiplexer  E6BEG7 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG7
-- switch matrix multiplexer  E6BEG8 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG8
-- switch matrix multiplexer  E6BEG9 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG9
-- switch matrix multiplexer  E6BEG10 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG10
-- switch matrix multiplexer  E6BEG11 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG11

end architecture Behavioral;

