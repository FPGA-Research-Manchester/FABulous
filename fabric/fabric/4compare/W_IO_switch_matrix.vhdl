-- NumberOfConfigBits:6
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  W_IO_switch_matrix  is 
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
		  O 	: in 	 STD_LOGIC;
		  Q 	: in 	 STD_LOGIC;
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
		  E6BEG11 	: out 	 STD_LOGIC;
		  I 	: out 	 STD_LOGIC;
		  T 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity W_IO_switch_matrix ;

architecture Behavioral of  W_IO_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
constant VDD0	 : std_logic := '1';
constant VDD	 : std_logic := '1';
	
signal 	  E1BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E1BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E1BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E1BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
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
signal 	  I_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  T_input 	:	 std_logic_vector( 4 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches
signal 	 ConfigBits :	 unsigned( 6-1 downto 0 );
signal 	 ConfigBitsInput :	 unsigned( 6-1 downto 0 );

begin

ConfigBitsInput <= ConfigBits(ConfigBitsInput'high-1 downto 0) & CONFin; 
     
-- for k in 0 to Conf/2 generate               
L: for k in 0 to 2 generate 
		inst_LHQD1a : LHQD1              
		Port Map(              
		D    => ConfigBitsInput(k*2),              
		E    => CLK,               
		Q    => ConfigBits(k*2) );                 
              
		inst_LHQD1b : LHQD1              
		Port Map(              
		D    => ConfigBitsInput((k*2)+1),
		E    => MODE,
		Q    => ConfigBits((k*2)+1) ); 
end generate; 
        
CONFout <= ConfigBits(ConfigBits'high);                                    
 

-- switch matrix multiplexer  E1BEG0 		MUX-1
E1BEG0 	 <= 	 W1END3 ;
-- switch matrix multiplexer  E1BEG1 		MUX-1
E1BEG1 	 <= 	 W1END2 ;
-- switch matrix multiplexer  E1BEG2 		MUX-1
E1BEG2 	 <= 	 W1END1 ;
-- switch matrix multiplexer  E1BEG3 		MUX-1
E1BEG3 	 <= 	 W1END0 ;
-- switch matrix multiplexer  E2BEG0 		MUX-1
E2BEG0 	 <= 	 W2MID7 ;
-- switch matrix multiplexer  E2BEG1 		MUX-1
E2BEG1 	 <= 	 W2MID6 ;
-- switch matrix multiplexer  E2BEG2 		MUX-1
E2BEG2 	 <= 	 W2MID5 ;
-- switch matrix multiplexer  E2BEG3 		MUX-1
E2BEG3 	 <= 	 W2MID4 ;
-- switch matrix multiplexer  E2BEG4 		MUX-1
E2BEG4 	 <= 	 W2MID3 ;
-- switch matrix multiplexer  E2BEG5 		MUX-1
E2BEG5 	 <= 	 W2MID2 ;
-- switch matrix multiplexer  E2BEG6 		MUX-1
E2BEG6 	 <= 	 W2MID1 ;
-- switch matrix multiplexer  E2BEG7 		MUX-1
E2BEG7 	 <= 	 W2MID0 ;
-- switch matrix multiplexer  E2BEGb0 		MUX-1
E2BEGb0 	 <= 	 W2END7 ;
-- switch matrix multiplexer  E2BEGb1 		MUX-1
E2BEGb1 	 <= 	 W2END6 ;
-- switch matrix multiplexer  E2BEGb2 		MUX-1
E2BEGb2 	 <= 	 W2END5 ;
-- switch matrix multiplexer  E2BEGb3 		MUX-1
E2BEGb3 	 <= 	 W2END4 ;
-- switch matrix multiplexer  E2BEGb4 		MUX-1
E2BEGb4 	 <= 	 W2END3 ;
-- switch matrix multiplexer  E2BEGb5 		MUX-1
E2BEGb5 	 <= 	 W2END2 ;
-- switch matrix multiplexer  E2BEGb6 		MUX-1
E2BEGb6 	 <= 	 W2END1 ;
-- switch matrix multiplexer  E2BEGb7 		MUX-1
E2BEGb7 	 <= 	 W2END0 ;
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
-- switch matrix multiplexer  I 		MUX-16
I_input 	 <= W2END7 & W2END6 & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W2MID7 & W2MID6 & W2MID5 & W2MID4 & W2MID3 & W2MID2 & W2MID1 & W2MID0;
inst_MUX16PTv2_I : MUX16PTv2
	 Port Map(
		IN1 	=> I_input(0),
		IN2 	=> I_input(1),
		IN3 	=> I_input(2),
		IN4 	=> I_input(3),
		IN5 	=> I_input(4),
		IN6 	=> I_input(5),
		IN7 	=> I_input(6),
		IN8 	=> I_input(7),
		IN9 	=> I_input(8),
		IN10 	=> I_input(9),
		IN11 	=> I_input(10),
		IN12 	=> I_input(11),
		IN13 	=> I_input(12),
		IN14 	=> I_input(13),
		IN15 	=> I_input(14),
		IN16 	=> I_input(15),
		S1 	=> ConfigBits(0 + 0),
		S2 	=> ConfigBits(0 + 1),
		S3 	=> ConfigBits(0 + 2),
		S4 	=> ConfigBits(0 + 3),
		O  	=> I );

-- switch matrix multiplexer  T 		MUX-4
T_input 	 <= VCC0 & GND0 & W2END0 & W2MID7;
inst_MUX4PTv4_T : MUX4PTv4
	 Port Map(
		IN1 	=> T_input(0),
		IN2 	=> T_input(1),
		IN3 	=> T_input(2),
		IN4 	=> T_input(3),
		S1 	=> ConfigBits(4 + 0),
		S2 	=> ConfigBits(4 + 1),
		O  	=> T );


end architecture Behavioral;

