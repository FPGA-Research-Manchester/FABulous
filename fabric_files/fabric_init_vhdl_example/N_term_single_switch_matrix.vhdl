-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  N_term_single_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 0 );
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N1END3 	: in 	 STD_LOGIC;
		  N2MID0 	: in 	 STD_LOGIC;
		  N2MID1 	: in 	 STD_LOGIC;
		  N2MID2 	: in 	 STD_LOGIC;
		  N2MID3 	: in 	 STD_LOGIC;
		  N2MID4 	: in 	 STD_LOGIC;
		  N2MID5 	: in 	 STD_LOGIC;
		  N2MID6 	: in 	 STD_LOGIC;
		  N2MID7 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N2END3 	: in 	 STD_LOGIC;
		  N2END4 	: in 	 STD_LOGIC;
		  N2END5 	: in 	 STD_LOGIC;
		  N2END6 	: in 	 STD_LOGIC;
		  N2END7 	: in 	 STD_LOGIC;
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
		  N4END2 	: in 	 STD_LOGIC;
		  N4END3 	: in 	 STD_LOGIC;
		  N4END4 	: in 	 STD_LOGIC;
		  N4END5 	: in 	 STD_LOGIC;
		  N4END6 	: in 	 STD_LOGIC;
		  N4END7 	: in 	 STD_LOGIC;
		  N4END8 	: in 	 STD_LOGIC;
		  N4END9 	: in 	 STD_LOGIC;
		  N4END10 	: in 	 STD_LOGIC;
		  N4END11 	: in 	 STD_LOGIC;
		  N4END12 	: in 	 STD_LOGIC;
		  N4END13 	: in 	 STD_LOGIC;
		  N4END14 	: in 	 STD_LOGIC;
		  N4END15 	: in 	 STD_LOGIC;
		  Ci0 	: in 	 STD_LOGIC;
		  S1BEG0 	: out 	 STD_LOGIC;
		  S1BEG1 	: out 	 STD_LOGIC;
		  S1BEG2 	: out 	 STD_LOGIC;
		  S1BEG3 	: out 	 STD_LOGIC;
		  S2BEG0 	: out 	 STD_LOGIC;
		  S2BEG1 	: out 	 STD_LOGIC;
		  S2BEG2 	: out 	 STD_LOGIC;
		  S2BEG3 	: out 	 STD_LOGIC;
		  S2BEG4 	: out 	 STD_LOGIC;
		  S2BEG5 	: out 	 STD_LOGIC;
		  S2BEG6 	: out 	 STD_LOGIC;
		  S2BEG7 	: out 	 STD_LOGIC;
		  S2BEGb0 	: out 	 STD_LOGIC;
		  S2BEGb1 	: out 	 STD_LOGIC;
		  S2BEGb2 	: out 	 STD_LOGIC;
		  S2BEGb3 	: out 	 STD_LOGIC;
		  S2BEGb4 	: out 	 STD_LOGIC;
		  S2BEGb5 	: out 	 STD_LOGIC;
		  S2BEGb6 	: out 	 STD_LOGIC;
		  S2BEGb7 	: out 	 STD_LOGIC;
		  S4BEG0 	: out 	 STD_LOGIC;
		  S4BEG1 	: out 	 STD_LOGIC;
		  S4BEG2 	: out 	 STD_LOGIC;
		  S4BEG3 	: out 	 STD_LOGIC;
		  S4BEG4 	: out 	 STD_LOGIC;
		  S4BEG5 	: out 	 STD_LOGIC;
		  S4BEG6 	: out 	 STD_LOGIC;
		  S4BEG7 	: out 	 STD_LOGIC;
		  S4BEG8 	: out 	 STD_LOGIC;
		  S4BEG9 	: out 	 STD_LOGIC;
		  S4BEG10 	: out 	 STD_LOGIC;
		  S4BEG11 	: out 	 STD_LOGIC;
		  S4BEG12 	: out 	 STD_LOGIC;
		  S4BEG13 	: out 	 STD_LOGIC;
		  S4BEG14 	: out 	 STD_LOGIC;
		  S4BEG15 	: out 	 STD_LOGIC 

	-- global
	);
end entity N_term_single_switch_matrix ;

architecture Behavioral of  N_term_single_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
constant VDD0	 : std_logic := '1';
constant VDD	 : std_logic := '1';
	
signal 	  S1BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S1BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S1BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S1BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG8_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG9_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG10_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG11_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG12_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG13_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG14_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG15_input 	:	 std_logic_vector( 1 - 1 downto 0 );


-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  S1BEG0 		MUX-1
S1BEG0 	 <= 	 N1END3 ;
-- switch matrix multiplexer  S1BEG1 		MUX-1
S1BEG1 	 <= 	 N1END2 ;
-- switch matrix multiplexer  S1BEG2 		MUX-1
S1BEG2 	 <= 	 N1END1 ;
-- switch matrix multiplexer  S1BEG3 		MUX-1
S1BEG3 	 <= 	 N1END0 ;
-- switch matrix multiplexer  S2BEG0 		MUX-1
S2BEG0 	 <= 	 N2MID7 ;
-- switch matrix multiplexer  S2BEG1 		MUX-1
S2BEG1 	 <= 	 N2MID6 ;
-- switch matrix multiplexer  S2BEG2 		MUX-1
S2BEG2 	 <= 	 N2MID5 ;
-- switch matrix multiplexer  S2BEG3 		MUX-1
S2BEG3 	 <= 	 N2MID4 ;
-- switch matrix multiplexer  S2BEG4 		MUX-1
S2BEG4 	 <= 	 N2MID3 ;
-- switch matrix multiplexer  S2BEG5 		MUX-1
S2BEG5 	 <= 	 N2MID2 ;
-- switch matrix multiplexer  S2BEG6 		MUX-1
S2BEG6 	 <= 	 N2MID1 ;
-- switch matrix multiplexer  S2BEG7 		MUX-1
S2BEG7 	 <= 	 N2MID0 ;
-- switch matrix multiplexer  S2BEGb0 		MUX-1
S2BEGb0 	 <= 	 N2END7 ;
-- switch matrix multiplexer  S2BEGb1 		MUX-1
S2BEGb1 	 <= 	 N2END6 ;
-- switch matrix multiplexer  S2BEGb2 		MUX-1
S2BEGb2 	 <= 	 N2END5 ;
-- switch matrix multiplexer  S2BEGb3 		MUX-1
S2BEGb3 	 <= 	 N2END4 ;
-- switch matrix multiplexer  S2BEGb4 		MUX-1
S2BEGb4 	 <= 	 N2END3 ;
-- switch matrix multiplexer  S2BEGb5 		MUX-1
S2BEGb5 	 <= 	 N2END2 ;
-- switch matrix multiplexer  S2BEGb6 		MUX-1
S2BEGb6 	 <= 	 N2END1 ;
-- switch matrix multiplexer  S2BEGb7 		MUX-1
S2BEGb7 	 <= 	 N2END0 ;
-- switch matrix multiplexer  S4BEG0 		MUX-1
S4BEG0 	 <= 	 N4END15 ;
-- switch matrix multiplexer  S4BEG1 		MUX-1
S4BEG1 	 <= 	 N4END14 ;
-- switch matrix multiplexer  S4BEG2 		MUX-1
S4BEG2 	 <= 	 N4END13 ;
-- switch matrix multiplexer  S4BEG3 		MUX-1
S4BEG3 	 <= 	 N4END12 ;
-- switch matrix multiplexer  S4BEG4 		MUX-1
S4BEG4 	 <= 	 N4END11 ;
-- switch matrix multiplexer  S4BEG5 		MUX-1
S4BEG5 	 <= 	 N4END10 ;
-- switch matrix multiplexer  S4BEG6 		MUX-1
S4BEG6 	 <= 	 N4END9 ;
-- switch matrix multiplexer  S4BEG7 		MUX-1
S4BEG7 	 <= 	 N4END8 ;
-- switch matrix multiplexer  S4BEG8 		MUX-1
S4BEG8 	 <= 	 N4END7 ;
-- switch matrix multiplexer  S4BEG9 		MUX-1
S4BEG9 	 <= 	 N4END6 ;
-- switch matrix multiplexer  S4BEG10 		MUX-1
S4BEG10 	 <= 	 N4END5 ;
-- switch matrix multiplexer  S4BEG11 		MUX-1
S4BEG11 	 <= 	 N4END4 ;
-- switch matrix multiplexer  S4BEG12 		MUX-1
S4BEG12 	 <= 	 N4END3 ;
-- switch matrix multiplexer  S4BEG13 		MUX-1
S4BEG13 	 <= 	 N4END2 ;
-- switch matrix multiplexer  S4BEG14 		MUX-1
S4BEG14 	 <= 	 N4END1 ;
-- switch matrix multiplexer  S4BEG15 		MUX-1
S4BEG15 	 <= 	 N4END0 ;



end architecture Behavioral;

