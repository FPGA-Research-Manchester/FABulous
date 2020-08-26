-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  S_term_single_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  S1END0 	: in 	 STD_LOGIC;
		  S1END1 	: in 	 STD_LOGIC;
		  S1END2 	: in 	 STD_LOGIC;
		  S1END3 	: in 	 STD_LOGIC;
		  S2MID0 	: in 	 STD_LOGIC;
		  S2MID1 	: in 	 STD_LOGIC;
		  S2MID2 	: in 	 STD_LOGIC;
		  S2MID3 	: in 	 STD_LOGIC;
		  S2MID4 	: in 	 STD_LOGIC;
		  S2MID5 	: in 	 STD_LOGIC;
		  S2MID6 	: in 	 STD_LOGIC;
		  S2MID7 	: in 	 STD_LOGIC;
		  S2END0 	: in 	 STD_LOGIC;
		  S2END1 	: in 	 STD_LOGIC;
		  S2END2 	: in 	 STD_LOGIC;
		  S2END3 	: in 	 STD_LOGIC;
		  S2END4 	: in 	 STD_LOGIC;
		  S2END5 	: in 	 STD_LOGIC;
		  S2END6 	: in 	 STD_LOGIC;
		  S2END7 	: in 	 STD_LOGIC;
		  S4END0 	: in 	 STD_LOGIC;
		  S4END1 	: in 	 STD_LOGIC;
		  S4END2 	: in 	 STD_LOGIC;
		  S4END3 	: in 	 STD_LOGIC;
		  S4END4 	: in 	 STD_LOGIC;
		  S4END5 	: in 	 STD_LOGIC;
		  S4END6 	: in 	 STD_LOGIC;
		  S4END7 	: in 	 STD_LOGIC;
		  S4END8 	: in 	 STD_LOGIC;
		  S4END9 	: in 	 STD_LOGIC;
		  S4END10 	: in 	 STD_LOGIC;
		  S4END11 	: in 	 STD_LOGIC;
		  S4END12 	: in 	 STD_LOGIC;
		  S4END13 	: in 	 STD_LOGIC;
		  S4END14 	: in 	 STD_LOGIC;
		  S4END15 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N1BEG3 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  N2BEG3 	: out 	 STD_LOGIC;
		  N2BEG4 	: out 	 STD_LOGIC;
		  N2BEG5 	: out 	 STD_LOGIC;
		  N2BEG6 	: out 	 STD_LOGIC;
		  N2BEG7 	: out 	 STD_LOGIC;
		  N2BEGb0 	: out 	 STD_LOGIC;
		  N2BEGb1 	: out 	 STD_LOGIC;
		  N2BEGb2 	: out 	 STD_LOGIC;
		  N2BEGb3 	: out 	 STD_LOGIC;
		  N2BEGb4 	: out 	 STD_LOGIC;
		  N2BEGb5 	: out 	 STD_LOGIC;
		  N2BEGb6 	: out 	 STD_LOGIC;
		  N2BEGb7 	: out 	 STD_LOGIC;
		  N4BEG0 	: out 	 STD_LOGIC;
		  N4BEG1 	: out 	 STD_LOGIC;
		  N4BEG2 	: out 	 STD_LOGIC;
		  N4BEG3 	: out 	 STD_LOGIC;
		  N4BEG4 	: out 	 STD_LOGIC;
		  N4BEG5 	: out 	 STD_LOGIC;
		  N4BEG6 	: out 	 STD_LOGIC;
		  N4BEG7 	: out 	 STD_LOGIC;
		  N4BEG8 	: out 	 STD_LOGIC;
		  N4BEG9 	: out 	 STD_LOGIC;
		  N4BEG10 	: out 	 STD_LOGIC;
		  N4BEG11 	: out 	 STD_LOGIC;
		  N4BEG12 	: out 	 STD_LOGIC;
		  N4BEG13 	: out 	 STD_LOGIC;
		  N4BEG14 	: out 	 STD_LOGIC;
		  N4BEG15 	: out 	 STD_LOGIC;
		  Co0 	: out 	 STD_LOGIC
	-- global
	);
end entity S_term_single_switch_matrix ;

architecture Behavioral of  S_term_single_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
constant VDD0	 : std_logic := '1';
constant VDD	 : std_logic := '1';
	
signal 	  N1BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N1BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N1BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N1BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG8_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG9_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG10_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG11_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG12_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG13_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG14_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG15_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  Co0_input 	:	 std_logic_vector( 1 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  N1BEG0 		MUX-1
N1BEG0 	 <= 	 S1END3 ;
-- switch matrix multiplexer  N1BEG1 		MUX-1
N1BEG1 	 <= 	 S1END2 ;
-- switch matrix multiplexer  N1BEG2 		MUX-1
N1BEG2 	 <= 	 S1END1 ;
-- switch matrix multiplexer  N1BEG3 		MUX-1
N1BEG3 	 <= 	 S1END0 ;
-- switch matrix multiplexer  N2BEG0 		MUX-1
N2BEG0 	 <= 	 S2MID7 ;
-- switch matrix multiplexer  N2BEG1 		MUX-1
N2BEG1 	 <= 	 S2MID6 ;
-- switch matrix multiplexer  N2BEG2 		MUX-1
N2BEG2 	 <= 	 S2MID5 ;
-- switch matrix multiplexer  N2BEG3 		MUX-1
N2BEG3 	 <= 	 S2MID4 ;
-- switch matrix multiplexer  N2BEG4 		MUX-1
N2BEG4 	 <= 	 S2MID3 ;
-- switch matrix multiplexer  N2BEG5 		MUX-1
N2BEG5 	 <= 	 S2MID2 ;
-- switch matrix multiplexer  N2BEG6 		MUX-1
N2BEG6 	 <= 	 S2MID1 ;
-- switch matrix multiplexer  N2BEG7 		MUX-1
N2BEG7 	 <= 	 S2MID0 ;
-- switch matrix multiplexer  N2BEGb0 		MUX-1
N2BEGb0 	 <= 	 S2END7 ;
-- switch matrix multiplexer  N2BEGb1 		MUX-1
N2BEGb1 	 <= 	 S2END6 ;
-- switch matrix multiplexer  N2BEGb2 		MUX-1
N2BEGb2 	 <= 	 S2END5 ;
-- switch matrix multiplexer  N2BEGb3 		MUX-1
N2BEGb3 	 <= 	 S2END4 ;
-- switch matrix multiplexer  N2BEGb4 		MUX-1
N2BEGb4 	 <= 	 S2END3 ;
-- switch matrix multiplexer  N2BEGb5 		MUX-1
N2BEGb5 	 <= 	 S2END2 ;
-- switch matrix multiplexer  N2BEGb6 		MUX-1
N2BEGb6 	 <= 	 S2END1 ;
-- switch matrix multiplexer  N2BEGb7 		MUX-1
N2BEGb7 	 <= 	 S2END0 ;
-- switch matrix multiplexer  N4BEG0 		MUX-1
N4BEG0 	 <= 	 S4END15 ;
-- switch matrix multiplexer  N4BEG1 		MUX-1
N4BEG1 	 <= 	 S4END14 ;
-- switch matrix multiplexer  N4BEG2 		MUX-1
N4BEG2 	 <= 	 S4END13 ;
-- switch matrix multiplexer  N4BEG3 		MUX-1
N4BEG3 	 <= 	 S4END12 ;
-- switch matrix multiplexer  N4BEG4 		MUX-1
N4BEG4 	 <= 	 S4END11 ;
-- switch matrix multiplexer  N4BEG5 		MUX-1
N4BEG5 	 <= 	 S4END10 ;
-- switch matrix multiplexer  N4BEG6 		MUX-1
N4BEG6 	 <= 	 S4END9 ;
-- switch matrix multiplexer  N4BEG7 		MUX-1
N4BEG7 	 <= 	 S4END8 ;
-- switch matrix multiplexer  N4BEG8 		MUX-1
N4BEG8 	 <= 	 S4END7 ;
-- switch matrix multiplexer  N4BEG9 		MUX-1
N4BEG9 	 <= 	 S4END6 ;
-- switch matrix multiplexer  N4BEG10 		MUX-1
N4BEG10 	 <= 	 S4END5 ;
-- switch matrix multiplexer  N4BEG11 		MUX-1
N4BEG11 	 <= 	 S4END4 ;
-- switch matrix multiplexer  N4BEG12 		MUX-1
N4BEG12 	 <= 	 S4END3 ;
-- switch matrix multiplexer  N4BEG13 		MUX-1
N4BEG13 	 <= 	 S4END2 ;
-- switch matrix multiplexer  N4BEG14 		MUX-1
N4BEG14 	 <= 	 S4END1 ;
-- switch matrix multiplexer  N4BEG15 		MUX-1
N4BEG15 	 <= 	 S4END0 ;
-- switch matrix multiplexer  Co0 		MUX-1
Co0 	 <= 	 GND0 ;

end architecture Behavioral;

