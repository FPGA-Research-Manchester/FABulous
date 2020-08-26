-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  CPU_IO_switch_matrix  is 
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
		  OPA_O0 	: in 	 STD_LOGIC;
		  OPA_O1 	: in 	 STD_LOGIC;
		  OPA_O2 	: in 	 STD_LOGIC;
		  OPA_O3 	: in 	 STD_LOGIC;
		  OPB_O0 	: in 	 STD_LOGIC;
		  OPB_O1 	: in 	 STD_LOGIC;
		  OPB_O2 	: in 	 STD_LOGIC;
		  OPB_O3 	: in 	 STD_LOGIC;
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
		  W6BEG11 	: out 	 STD_LOGIC;
		  RES0_I0 	: out 	 STD_LOGIC;
		  RES0_I1 	: out 	 STD_LOGIC;
		  RES0_I2 	: out 	 STD_LOGIC;
		  RES0_I3 	: out 	 STD_LOGIC;
		  RES1_I0 	: out 	 STD_LOGIC;
		  RES1_I1 	: out 	 STD_LOGIC;
		  RES1_I2 	: out 	 STD_LOGIC;
		  RES1_I3 	: out 	 STD_LOGIC;
		  RES2_I0 	: out 	 STD_LOGIC;
		  RES2_I1 	: out 	 STD_LOGIC;
		  RES2_I2 	: out 	 STD_LOGIC;
		  RES2_I3 	: out 	 STD_LOGIC
	-- global
	);
end entity CPU_IO_switch_matrix ;

architecture Behavioral of  CPU_IO_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
constant VDD0	 : std_logic := '1';
constant VDD	 : std_logic := '1';
	
signal 	  W1BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG8_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG9_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG10_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG11_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES0_I0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES0_I1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES0_I2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES0_I3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES1_I0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES1_I1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES1_I2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES1_I3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES2_I0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES2_I1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES2_I2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  RES2_I3_input 	:	 std_logic_vector( 1 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  W1BEG0 		MUX-1
W1BEG0 	 <= 	 E1END3 ;
-- switch matrix multiplexer  W1BEG1 		MUX-1
W1BEG1 	 <= 	 E1END2 ;
-- switch matrix multiplexer  W1BEG2 		MUX-1
W1BEG2 	 <= 	 E1END1 ;
-- switch matrix multiplexer  W1BEG3 		MUX-1
W1BEG3 	 <= 	 E1END0 ;
-- switch matrix multiplexer  W2BEG0 		MUX-1
W2BEG0 	 <= 	 E2MID7 ;
-- switch matrix multiplexer  W2BEG1 		MUX-1
W2BEG1 	 <= 	 E2MID6 ;
-- switch matrix multiplexer  W2BEG2 		MUX-1
W2BEG2 	 <= 	 OPB_O0 ;
-- switch matrix multiplexer  W2BEG3 		MUX-1
W2BEG3 	 <= 	 OPB_O1 ;
-- switch matrix multiplexer  W2BEG4 		MUX-1
W2BEG4 	 <= 	 OPB_O2 ;
-- switch matrix multiplexer  W2BEG5 		MUX-1
W2BEG5 	 <= 	 OPB_O3 ;
-- switch matrix multiplexer  W2BEG6 		MUX-1
W2BEG6 	 <= 	 E2MID1 ;
-- switch matrix multiplexer  W2BEG7 		MUX-1
W2BEG7 	 <= 	 E2MID0 ;
-- switch matrix multiplexer  W2BEGb0 		MUX-1
W2BEGb0 	 <= 	 E2END7 ;
-- switch matrix multiplexer  W2BEGb1 		MUX-1
W2BEGb1 	 <= 	 E2END6 ;
-- switch matrix multiplexer  W2BEGb2 		MUX-1
W2BEGb2 	 <= 	 OPA_O0 ;
-- switch matrix multiplexer  W2BEGb3 		MUX-1
W2BEGb3 	 <= 	 OPA_O1 ;
-- switch matrix multiplexer  W2BEGb4 		MUX-1
W2BEGb4 	 <= 	 OPA_O2 ;
-- switch matrix multiplexer  W2BEGb5 		MUX-1
W2BEGb5 	 <= 	 OPA_O3 ;
-- switch matrix multiplexer  W2BEGb6 		MUX-1
W2BEGb6 	 <= 	 E2END1 ;
-- switch matrix multiplexer  W2BEGb7 		MUX-1
W2BEGb7 	 <= 	 E2END0 ;
-- switch matrix multiplexer  W6BEG0 		MUX-1
W6BEG0 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG1 		MUX-1
W6BEG1 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG2 		MUX-1
W6BEG2 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG3 		MUX-1
W6BEG3 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG4 		MUX-1
W6BEG4 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG5 		MUX-1
W6BEG5 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG6 		MUX-1
W6BEG6 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG7 		MUX-1
W6BEG7 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG8 		MUX-1
W6BEG8 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG9 		MUX-1
W6BEG9 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG10 		MUX-1
W6BEG10 	 <= 	 GND0 ;
-- switch matrix multiplexer  W6BEG11 		MUX-1
W6BEG11 	 <= 	 GND0 ;
-- switch matrix multiplexer  RES0_I0 		MUX-1
RES0_I0 	 <= 	 E6END0 ;
-- switch matrix multiplexer  RES0_I1 		MUX-1
RES0_I1 	 <= 	 E6END1 ;
-- switch matrix multiplexer  RES0_I2 		MUX-1
RES0_I2 	 <= 	 E6END6 ;
-- switch matrix multiplexer  RES0_I3 		MUX-1
RES0_I3 	 <= 	 E6END7 ;
-- switch matrix multiplexer  RES1_I0 		MUX-1
RES1_I0 	 <= 	 E6END2 ;
-- switch matrix multiplexer  RES1_I1 		MUX-1
RES1_I1 	 <= 	 E6END3 ;
-- switch matrix multiplexer  RES1_I2 		MUX-1
RES1_I2 	 <= 	 E6END8 ;
-- switch matrix multiplexer  RES1_I3 		MUX-1
RES1_I3 	 <= 	 E6END9 ;
-- switch matrix multiplexer  RES2_I0 		MUX-1
RES2_I0 	 <= 	 E6END4 ;
-- switch matrix multiplexer  RES2_I1 		MUX-1
RES2_I1 	 <= 	 E6END5 ;
-- switch matrix multiplexer  RES2_I2 		MUX-1
RES2_I2 	 <= 	 E6END10 ;
-- switch matrix multiplexer  RES2_I3 		MUX-1
RES2_I3 	 <= 	 E6END11 ;

end architecture Behavioral;

