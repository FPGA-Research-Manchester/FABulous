-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  E_term_single_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2MID0 	: in 	 STD_LOGIC;
		  E2MID1 	: in 	 STD_LOGIC;
		  E2MID2 	: in 	 STD_LOGIC;
		  E2MID3 	: in 	 STD_LOGIC;
		  E2MID4 	: in 	 STD_LOGIC;
		  E2MID5 	: in 	 STD_LOGIC;
		  E2MID6 	: in 	 STD_LOGIC;
		  E2MID7 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  E2END4 	: in 	 STD_LOGIC;
		  E2END5 	: in 	 STD_LOGIC;
		  E2END6 	: in 	 STD_LOGIC;
		  E2END7 	: in 	 STD_LOGIC;
		  E6END0 	: in 	 STD_LOGIC;
		  E6END1 	: in 	 STD_LOGIC;
		  E6END2 	: in 	 STD_LOGIC;
		  E6END3 	: in 	 STD_LOGIC;
		  E6END4 	: in 	 STD_LOGIC;
		  E6END5 	: in 	 STD_LOGIC;
		  E6END6 	: in 	 STD_LOGIC;
		  E6END7 	: in 	 STD_LOGIC;
		  E6END8 	: in 	 STD_LOGIC;
		  E6END9 	: in 	 STD_LOGIC;
		  E6END10 	: in 	 STD_LOGIC;
		  E6END11 	: in 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  W2BEG6 	: out 	 STD_LOGIC;
		  W2BEG7 	: out 	 STD_LOGIC;
		  W2BEGb0 	: out 	 STD_LOGIC;
		  W2BEGb1 	: out 	 STD_LOGIC;
		  W2BEGb2 	: out 	 STD_LOGIC;
		  W2BEGb3 	: out 	 STD_LOGIC;
		  W2BEGb4 	: out 	 STD_LOGIC;
		  W2BEGb5 	: out 	 STD_LOGIC;
		  W2BEGb6 	: out 	 STD_LOGIC;
		  W2BEGb7 	: out 	 STD_LOGIC;
		  W6BEG0 	: out 	 STD_LOGIC;
		  W6BEG1 	: out 	 STD_LOGIC;
		  W6BEG2 	: out 	 STD_LOGIC;
		  W6BEG3 	: out 	 STD_LOGIC;
		  W6BEG4 	: out 	 STD_LOGIC;
		  W6BEG5 	: out 	 STD_LOGIC;
		  W6BEG6 	: out 	 STD_LOGIC;
		  W6BEG7 	: out 	 STD_LOGIC;
		  W6BEG8 	: out 	 STD_LOGIC;
		  W6BEG9 	: out 	 STD_LOGIC;
		  W6BEG10 	: out 	 STD_LOGIC;
		  W6BEG11 	: out 	 STD_LOGIC
	-- global
	);
end entity E_term_single_switch_matrix ;

architecture Behavioral of  E_term_single_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
	
signal 	  W1BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W2BEGb7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG0_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG1_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG2_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG3_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG4_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG5_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG6_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG7_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG8_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG9_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG10_input 	:	 std_logic_vector( 0 - 1 downto 0 );
signal 	  W6BEG11_input 	:	 std_logic_vector( 0 - 1 downto 0 );

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
-- switch matrix multiplexer  W2BEGb0 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb0
-- switch matrix multiplexer  W2BEGb1 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb1
-- switch matrix multiplexer  W2BEGb2 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb2
-- switch matrix multiplexer  W2BEGb3 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb3
-- switch matrix multiplexer  W2BEGb4 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb4
-- switch matrix multiplexer  W2BEGb5 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb5
-- switch matrix multiplexer  W2BEGb6 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb6
-- switch matrix multiplexer  W2BEGb7 		MUX-0
-- WARNING unused multiplexer MUX-W2BEGb7
-- switch matrix multiplexer  W6BEG0 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG0
-- switch matrix multiplexer  W6BEG1 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG1
-- switch matrix multiplexer  W6BEG2 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG2
-- switch matrix multiplexer  W6BEG3 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG3
-- switch matrix multiplexer  W6BEG4 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG4
-- switch matrix multiplexer  W6BEG5 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG5
-- switch matrix multiplexer  W6BEG6 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG6
-- switch matrix multiplexer  W6BEG7 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG7
-- switch matrix multiplexer  W6BEG8 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG8
-- switch matrix multiplexer  W6BEG9 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG9
-- switch matrix multiplexer  W6BEG10 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG10
-- switch matrix multiplexer  W6BEG11 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG11

end architecture Behavioral;

