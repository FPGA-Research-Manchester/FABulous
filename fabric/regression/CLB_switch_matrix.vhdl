library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  CLB_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
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
		  A 	: in 	 STD_LOGIC;
		  AQ 	: in 	 STD_LOGIC;
		  B 	: in 	 STD_LOGIC;
		  BQ 	: in 	 STD_LOGIC;
		  C 	: in 	 STD_LOGIC;
		  CQ 	: in 	 STD_LOGIC;
		  D 	: in 	 STD_LOGIC;
		  DQ 	: in 	 STD_LOGIC;
		  TestOut 	: in 	 STD_LOGIC;
		  IJ_END0 	: in 	 STD_LOGIC;
		  IJ_END1 	: in 	 STD_LOGIC;
		  IJ_END2 	: in 	 STD_LOGIC;
		  IJ_END3 	: in 	 STD_LOGIC;
		  IJ_END4 	: in 	 STD_LOGIC;
		  IJ_END5 	: in 	 STD_LOGIC;
		  IJ_END6 	: in 	 STD_LOGIC;
		  IJ_END7 	: in 	 STD_LOGIC;
		  IJ_END8 	: in 	 STD_LOGIC;
		  IJ_END9 	: in 	 STD_LOGIC;
		  IJ_END10 	: in 	 STD_LOGIC;
		  IJ_END11 	: in 	 STD_LOGIC;
		  IJ_END12 	: in 	 STD_LOGIC;
		  OJ_END0 	: in 	 STD_LOGIC;
		  OJ_END1 	: in 	 STD_LOGIC;
		  OJ_END2 	: in 	 STD_LOGIC;
		  OJ_END3 	: in 	 STD_LOGIC;
		  OJ_END4 	: in 	 STD_LOGIC;
		  OJ_END5 	: in 	 STD_LOGIC;
		  OJ_END6 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  N4BEG0 	: out 	 STD_LOGIC;
		  N4BEG1 	: out 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
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
		  A0 	: out 	 STD_LOGIC;
		  A1 	: out 	 STD_LOGIC;
		  A2 	: out 	 STD_LOGIC;
		  A3 	: out 	 STD_LOGIC;
		  B0 	: out 	 STD_LOGIC;
		  B1 	: out 	 STD_LOGIC;
		  B2 	: out 	 STD_LOGIC;
		  B3 	: out 	 STD_LOGIC;
		  C0 	: out 	 STD_LOGIC;
		  C1 	: out 	 STD_LOGIC;
		  C2 	: out 	 STD_LOGIC;
		  C3 	: out 	 STD_LOGIC;
		  D0 	: out 	 STD_LOGIC;
		  D1 	: out 	 STD_LOGIC;
		  D2 	: out 	 STD_LOGIC;
		  D3 	: out 	 STD_LOGIC;
		  TestIn 	: out 	 STD_LOGIC;
		  IJ_BEG0 	: out 	 STD_LOGIC;
		  IJ_BEG1 	: out 	 STD_LOGIC;
		  IJ_BEG2 	: out 	 STD_LOGIC;
		  IJ_BEG3 	: out 	 STD_LOGIC;
		  IJ_BEG4 	: out 	 STD_LOGIC;
		  IJ_BEG5 	: out 	 STD_LOGIC;
		  IJ_BEG6 	: out 	 STD_LOGIC;
		  IJ_BEG7 	: out 	 STD_LOGIC;
		  IJ_BEG8 	: out 	 STD_LOGIC;
		  IJ_BEG9 	: out 	 STD_LOGIC;
		  IJ_BEG10 	: out 	 STD_LOGIC;
		  IJ_BEG11 	: out 	 STD_LOGIC;
		  IJ_BEG12 	: out 	 STD_LOGIC;
		  OJ_BEG0 	: out 	 STD_LOGIC;
		  OJ_BEG1 	: out 	 STD_LOGIC;
		  OJ_BEG2 	: out 	 STD_LOGIC;
		  OJ_BEG3 	: out 	 STD_LOGIC;
		  OJ_BEG4 	: out 	 STD_LOGIC;
		  OJ_BEG5 	: out 	 STD_LOGIC;
		  OJ_BEG6 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity CLB_switch_matrix ;

architecture Behavioral of  CLB_switch_matrix  is 

signal 	  N1BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N1BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N1BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N2BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N2BEG1_input 	:	 std_logic_vector( 5 - 1 downto 0 );
signal 	  N2BEG2_input 	:	 std_logic_vector( 6 - 1 downto 0 );
signal 	  N4BEG0_input 	:	 std_logic_vector( 7 - 1 downto 0 );
signal 	  N4BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  E1BEG0_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  E1BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  E1BEG2_input 	:	 std_logic_vector( 9 - 1 downto 0 );
signal 	  E1BEG3_input 	:	 std_logic_vector( 10 - 1 downto 0 );
signal 	  E2BEG0_input 	:	 std_logic_vector( 7 - 1 downto 0 );
signal 	  E2BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  E2BEG2_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  E2BEG3_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S1BEG0_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S1BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S1BEG2_input 	:	 std_logic_vector( 7 - 1 downto 0 );
signal 	  S1BEG3_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S1BEG4_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S2BEG0_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S2BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S2BEG2_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  S2BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S2BEG4_input 	:	 std_logic_vector( 5 - 1 downto 0 );
signal 	  W1BEG0_input 	:	 std_logic_vector( 6 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 10 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 11 - 1 downto 0 );
signal 	  W1BEG4_input 	:	 std_logic_vector( 12 - 1 downto 0 );
signal 	  W1BEG5_input 	:	 std_logic_vector( 12 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 12 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  A0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  A1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  A2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  A3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  B0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  B1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  B2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  B3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  C0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  C1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  C2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  C3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  D0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  D1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  D2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  D3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  TestIn_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  IJ_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  IJ_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  IJ_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  IJ_BEG3_input 	:	 std_logic_vector( 5 - 1 downto 0 );
signal 	  IJ_BEG4_input 	:	 std_logic_vector( 6 - 1 downto 0 );
signal 	  IJ_BEG5_input 	:	 std_logic_vector( 7 - 1 downto 0 );
signal 	  IJ_BEG6_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  IJ_BEG7_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  IJ_BEG8_input 	:	 std_logic_vector( 8 - 1 downto 0 );
signal 	  IJ_BEG9_input 	:	 std_logic_vector( 7 - 1 downto 0 );
signal 	  IJ_BEG10_input 	:	 std_logic_vector( 5 - 1 downto 0 );
signal 	  IJ_BEG11_input 	:	 std_logic_vector( 2 - 1 downto 0 );
signal 	  IJ_BEG12_input 	:	 std_logic_vector( 2 - 1 downto 0 );
signal 	  OJ_BEG0_input 	:	 std_logic_vector( 2 - 1 downto 0 );
signal 	  OJ_BEG1_input 	:	 std_logic_vector( 2 - 1 downto 0 );
signal 	  OJ_BEG2_input 	:	 std_logic_vector( 2 - 1 downto 0 );

-- The configuration bits are just a long shift register
signal 	 ConfigBits :	 unsigned( 182-1 downto 0 );

begin

-- the configuration bits shift register                                    
process(CLK)                                                                
begin                                                                       
	if CLK'event and CLK='1' then                                        
		if mode='1' then	--configuration mode                             
			ConfigBits <= CONFin & ConfigBits(ConfigBits'high downto 1);   
		end if;                                                             
	end if;                                                                 
end process;                                                                
CONFout <= ConfigBits(ConfigBits'high);                                    
 

-- switch matrix multiplexer  N1BEG0 		MUX-4
N1BEG0_input 	 <= N2END0 & N1END2 & N1END1 & N1END0;
N1BEG0	<= N1BEG0_input(TO_INTEGER(ConfigBits(1 downto 0)));
 
-- switch matrix multiplexer  N1BEG1 		MUX-4
N1BEG1_input 	 <= N2END1 & N2END0 & N1END2 & N1END1;
N1BEG1	<= N1BEG1_input(TO_INTEGER(ConfigBits(3 downto 2)));
 
-- switch matrix multiplexer  N1BEG2 		MUX-4
N1BEG2_input 	 <= N2END2 & N2END1 & N2END0 & N1END2;
N1BEG2	<= N1BEG2_input(TO_INTEGER(ConfigBits(5 downto 4)));
 
-- switch matrix multiplexer  N2BEG0 		MUX-4
N2BEG0_input 	 <= N4END0 & N2END2 & N2END1 & N2END0;
N2BEG0	<= N2BEG0_input(TO_INTEGER(ConfigBits(7 downto 6)));
 
-- switch matrix multiplexer  N2BEG1 		MUX-5
N2BEG1_input 	 <= IJ_END5 & N4END1 & N4END0 & N2END2 & N2END1;
N2BEG1	<= N2BEG1_input(TO_INTEGER(ConfigBits(10 downto 8)));
 
-- switch matrix multiplexer  N2BEG2 		MUX-6
N2BEG2_input 	 <= IJ_END6 & IJ_END5 & E1END0 & N4END1 & N4END0 & N2END2;
N2BEG2	<= N2BEG2_input(TO_INTEGER(ConfigBits(13 downto 11)));
 
-- switch matrix multiplexer  N4BEG0 		MUX-7
N4BEG0_input 	 <= IJ_END7 & IJ_END6 & IJ_END5 & E1END1 & E1END0 & N4END1 & N4END0;
N4BEG0	<= N4BEG0_input(TO_INTEGER(ConfigBits(16 downto 14)));
 
-- switch matrix multiplexer  N4BEG1 		MUX-8
N4BEG1_input 	 <= IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & E1END2 & E1END1 & E1END0 & N4END1;
N4BEG1	<= N4BEG1_input(TO_INTEGER(ConfigBits(19 downto 17)));
 
-- switch matrix multiplexer  E1BEG0 		MUX-8
E1BEG0_input 	 <= IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & E1END3 & E1END2 & E1END1 & E1END0;
E1BEG0	<= E1BEG0_input(TO_INTEGER(ConfigBits(22 downto 20)));
 
-- switch matrix multiplexer  E1BEG1 		MUX-8
E1BEG1_input 	 <= IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & E2END0 & E1END3 & E1END2 & E1END1;
E1BEG1	<= E1BEG1_input(TO_INTEGER(ConfigBits(25 downto 23)));
 
-- switch matrix multiplexer  E1BEG2 		MUX-9
E1BEG2_input 	 <= IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & DQ & E2END1 & E2END0 & E1END3 & E1END2;
E1BEG2	<= E1BEG2_input(TO_INTEGER(ConfigBits(29 downto 26)));
 
-- switch matrix multiplexer  E1BEG3 		MUX-10
E1BEG3_input 	 <= IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & TestOut & DQ & E2END2 & E2END1 & E2END0 & E1END3;
E1BEG3	<= E1BEG3_input(TO_INTEGER(ConfigBits(33 downto 30)));
 
-- switch matrix multiplexer  E2BEG0 		MUX-7
E2BEG0_input 	 <= IJ_END0 & TestOut & DQ & E2END3 & E2END2 & E2END1 & E2END0;
E2BEG0	<= E2BEG0_input(TO_INTEGER(ConfigBits(36 downto 34)));
 
-- switch matrix multiplexer  E2BEG1 		MUX-8
E2BEG1_input 	 <= IJ_END1 & IJ_END0 & TestOut & DQ & S1END0 & E2END3 & E2END2 & E2END1;
E2BEG1	<= E2BEG1_input(TO_INTEGER(ConfigBits(39 downto 37)));
 
-- switch matrix multiplexer  E2BEG2 		MUX-8
E2BEG2_input 	 <= IJ_END2 & IJ_END1 & IJ_END0 & TestOut & S1END1 & S1END0 & E2END3 & E2END2;
E2BEG2	<= E2BEG2_input(TO_INTEGER(ConfigBits(42 downto 40)));
 
-- switch matrix multiplexer  E2BEG3 		MUX-8
E2BEG3_input 	 <= IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & S1END2 & S1END1 & S1END0 & E2END3;
E2BEG3	<= E2BEG3_input(TO_INTEGER(ConfigBits(45 downto 43)));
 
-- switch matrix multiplexer  S1BEG0 		MUX-8
S1BEG0_input 	 <= IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & S1END3 & S1END2 & S1END1 & S1END0;
S1BEG0	<= S1BEG0_input(TO_INTEGER(ConfigBits(48 downto 46)));
 
-- switch matrix multiplexer  S1BEG1 		MUX-8
S1BEG1_input 	 <= IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & S1END4 & S1END3 & S1END2 & S1END1;
S1BEG1	<= S1BEG1_input(TO_INTEGER(ConfigBits(51 downto 49)));
 
-- switch matrix multiplexer  S1BEG2 		MUX-7
S1BEG2_input 	 <= IJ_END2 & IJ_END1 & IJ_END0 & S2END0 & S1END4 & S1END3 & S1END2;
S1BEG2	<= S1BEG2_input(TO_INTEGER(ConfigBits(54 downto 52)));
 
-- switch matrix multiplexer  S1BEG3 		MUX-8
S1BEG3_input 	 <= IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & S2END1 & S2END0 & S1END4 & S1END3;
S1BEG3	<= S1BEG3_input(TO_INTEGER(ConfigBits(57 downto 55)));
 
-- switch matrix multiplexer  S1BEG4 		MUX-8
S1BEG4_input 	 <= IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & S2END2 & S2END1 & S2END0 & S1END4;
S1BEG4	<= S1BEG4_input(TO_INTEGER(ConfigBits(60 downto 58)));
 
-- switch matrix multiplexer  S2BEG0 		MUX-8
S2BEG0_input 	 <= IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & S2END3 & S2END2 & S2END1 & S2END0;
S2BEG0	<= S2BEG0_input(TO_INTEGER(ConfigBits(63 downto 61)));
 
-- switch matrix multiplexer  S2BEG1 		MUX-8
S2BEG1_input 	 <= IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & S2END4 & S2END3 & S2END2 & S2END1;
S2BEG1	<= S2BEG1_input(TO_INTEGER(ConfigBits(66 downto 64)));
 
-- switch matrix multiplexer  S2BEG2 		MUX-8
S2BEG2_input 	 <= IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & W1END0 & S2END4 & S2END3 & S2END2;
S2BEG2	<= S2BEG2_input(TO_INTEGER(ConfigBits(69 downto 67)));
 
-- switch matrix multiplexer  S2BEG3 		MUX-4
S2BEG3_input 	 <= W1END1 & W1END0 & S2END4 & S2END3;
S2BEG3	<= S2BEG3_input(TO_INTEGER(ConfigBits(71 downto 70)));
 
-- switch matrix multiplexer  S2BEG4 		MUX-5
S2BEG4_input 	 <= IJ_END7 & W1END2 & W1END1 & W1END0 & S2END4;
S2BEG4	<= S2BEG4_input(TO_INTEGER(ConfigBits(74 downto 72)));
 
-- switch matrix multiplexer  W1BEG0 		MUX-6
W1BEG0_input 	 <= IJ_END8 & IJ_END7 & W1END3 & W1END2 & W1END1 & W1END0;
W1BEG0	<= W1BEG0_input(TO_INTEGER(ConfigBits(77 downto 75)));
 
-- switch matrix multiplexer  W1BEG1 		MUX-8
W1BEG1_input 	 <= IJ_END9 & IJ_END8 & IJ_END7 & DQ & W1END4 & W1END3 & W1END2 & W1END1;
W1BEG1	<= W1BEG1_input(TO_INTEGER(ConfigBits(80 downto 78)));
 
-- switch matrix multiplexer  W1BEG2 		MUX-10
W1BEG2_input 	 <= IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & TestOut & DQ & W1END5 & W1END4 & W1END3 & W1END2;
W1BEG2	<= W1BEG2_input(TO_INTEGER(ConfigBits(84 downto 81)));
 
-- switch matrix multiplexer  W1BEG3 		MUX-11
W1BEG3_input 	 <= IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END0 & TestOut & DQ & W2END0 & W1END5 & W1END4 & W1END3;
W1BEG3	<= W1BEG3_input(TO_INTEGER(ConfigBits(88 downto 85)));
 
-- switch matrix multiplexer  W1BEG4 		MUX-12
W1BEG4_input 	 <= IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END1 & IJ_END0 & TestOut & DQ & W2END1 & W2END0 & W1END5 & W1END4;
W1BEG4	<= W1BEG4_input(TO_INTEGER(ConfigBits(92 downto 89)));
 
-- switch matrix multiplexer  W1BEG5 		MUX-12
W1BEG5_input 	 <= OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & W2END2 & W2END1 & W2END0 & W1END5;
W1BEG5	<= W1BEG5_input(TO_INTEGER(ConfigBits(96 downto 93)));
 
-- switch matrix multiplexer  W2BEG0 		MUX-12
W2BEG0_input 	 <= OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & W2END3 & W2END2 & W2END1 & W2END0;
W2BEG0	<= W2BEG0_input(TO_INTEGER(ConfigBits(100 downto 97)));
 
-- switch matrix multiplexer  W2BEG1 		MUX-8
W2BEG1_input 	 <= IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & W2END4 & W2END3 & W2END2 & W2END1;
W2BEG1	<= W2BEG1_input(TO_INTEGER(ConfigBits(103 downto 101)));
 
-- switch matrix multiplexer  W2BEG2 		MUX-8
W2BEG2_input 	 <= IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & W2END5 & W2END4 & W2END3 & W2END2;
W2BEG2	<= W2BEG2_input(TO_INTEGER(ConfigBits(106 downto 104)));
 
-- switch matrix multiplexer  W2BEG3 		MUX-4
W2BEG3_input 	 <= A & W2END5 & W2END4 & W2END3;
W2BEG3	<= W2BEG3_input(TO_INTEGER(ConfigBits(108 downto 107)));
 
-- switch matrix multiplexer  W2BEG4 		MUX-4
W2BEG4_input 	 <= AQ & A & W2END5 & W2END4;
W2BEG4	<= W2BEG4_input(TO_INTEGER(ConfigBits(110 downto 109)));
 
-- switch matrix multiplexer  W2BEG5 		MUX-4
W2BEG5_input 	 <= B & AQ & A & W2END5;
W2BEG5	<= W2BEG5_input(TO_INTEGER(ConfigBits(112 downto 111)));
 
-- switch matrix multiplexer  A0 		MUX-4
A0_input 	 <= BQ & B & AQ & A;
A0	<= A0_input(TO_INTEGER(ConfigBits(114 downto 113)));
 
-- switch matrix multiplexer  A1 		MUX-4
A1_input 	 <= C & BQ & B & AQ;
A1	<= A1_input(TO_INTEGER(ConfigBits(116 downto 115)));
 
-- switch matrix multiplexer  A2 		MUX-4
A2_input 	 <= CQ & C & BQ & B;
A2	<= A2_input(TO_INTEGER(ConfigBits(118 downto 117)));
 
-- switch matrix multiplexer  A3 		MUX-4
A3_input 	 <= D & CQ & C & BQ;
A3	<= A3_input(TO_INTEGER(ConfigBits(120 downto 119)));
 
-- switch matrix multiplexer  B0 		MUX-4
B0_input 	 <= DQ & D & CQ & C;
B0	<= B0_input(TO_INTEGER(ConfigBits(122 downto 121)));
 
-- switch matrix multiplexer  B1 		MUX-4
B1_input 	 <= TestOut & DQ & D & CQ;
B1	<= B1_input(TO_INTEGER(ConfigBits(124 downto 123)));
 
-- switch matrix multiplexer  B2 		MUX-4
B2_input 	 <= IJ_END0 & TestOut & DQ & D;
B2	<= B2_input(TO_INTEGER(ConfigBits(126 downto 125)));
 
-- switch matrix multiplexer  B3 		MUX-4
B3_input 	 <= IJ_END1 & IJ_END0 & TestOut & DQ;
B3	<= B3_input(TO_INTEGER(ConfigBits(128 downto 127)));
 
-- switch matrix multiplexer  C0 		MUX-4
C0_input 	 <= IJ_END2 & IJ_END1 & IJ_END0 & TestOut;
C0	<= C0_input(TO_INTEGER(ConfigBits(130 downto 129)));
 
-- switch matrix multiplexer  C1 		MUX-4
C1_input 	 <= IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0;
C1	<= C1_input(TO_INTEGER(ConfigBits(132 downto 131)));
 
-- switch matrix multiplexer  C2 		MUX-4
C2_input 	 <= IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1;
C2	<= C2_input(TO_INTEGER(ConfigBits(134 downto 133)));
 
-- switch matrix multiplexer  C3 		MUX-4
C3_input 	 <= IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2;
C3	<= C3_input(TO_INTEGER(ConfigBits(136 downto 135)));
 
-- switch matrix multiplexer  D0 		MUX-4
D0_input 	 <= IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3;
D0	<= D0_input(TO_INTEGER(ConfigBits(138 downto 137)));
 
-- switch matrix multiplexer  D1 		MUX-4
D1_input 	 <= IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4;
D1	<= D1_input(TO_INTEGER(ConfigBits(140 downto 139)));
 
-- switch matrix multiplexer  D2 		MUX-4
D2_input 	 <= IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5;
D2	<= D2_input(TO_INTEGER(ConfigBits(142 downto 141)));
 
-- switch matrix multiplexer  D3 		MUX-4
D3_input 	 <= IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6;
D3	<= D3_input(TO_INTEGER(ConfigBits(144 downto 143)));
 
-- switch matrix multiplexer  TestIn 		MUX-4
TestIn_input 	 <= IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7;
TestIn	<= TestIn_input(TO_INTEGER(ConfigBits(146 downto 145)));
 
-- switch matrix multiplexer  IJ_BEG0 		MUX-4
IJ_BEG0_input 	 <= IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8;
IJ_BEG0	<= IJ_BEG0_input(TO_INTEGER(ConfigBits(148 downto 147)));
 
-- switch matrix multiplexer  IJ_BEG1 		MUX-4
IJ_BEG1_input 	 <= IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9;
IJ_BEG1	<= IJ_BEG1_input(TO_INTEGER(ConfigBits(150 downto 149)));
 
-- switch matrix multiplexer  IJ_BEG2 		MUX-4
IJ_BEG2_input 	 <= OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10;
IJ_BEG2	<= IJ_BEG2_input(TO_INTEGER(ConfigBits(152 downto 151)));
 
-- switch matrix multiplexer  IJ_BEG3 		MUX-5
IJ_BEG3_input 	 <= OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & D;
IJ_BEG3	<= IJ_BEG3_input(TO_INTEGER(ConfigBits(155 downto 153)));
 
-- switch matrix multiplexer  IJ_BEG4 		MUX-6
IJ_BEG4_input 	 <= OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & DQ & D;
IJ_BEG4	<= IJ_BEG4_input(TO_INTEGER(ConfigBits(158 downto 156)));
 
-- switch matrix multiplexer  IJ_BEG5 		MUX-7
IJ_BEG5_input 	 <= OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & TestOut & DQ & D;
IJ_BEG5	<= IJ_BEG5_input(TO_INTEGER(ConfigBits(161 downto 159)));
 
-- switch matrix multiplexer  IJ_BEG6 		MUX-8
IJ_BEG6_input 	 <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & IJ_END0 & TestOut & DQ & D;
IJ_BEG6	<= IJ_BEG6_input(TO_INTEGER(ConfigBits(164 downto 162)));
 
-- switch matrix multiplexer  IJ_BEG7 		MUX-8
IJ_BEG7_input 	 <= OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & IJ_END1 & IJ_END0 & TestOut & DQ;
IJ_BEG7	<= IJ_BEG7_input(TO_INTEGER(ConfigBits(167 downto 165)));
 
-- switch matrix multiplexer  IJ_BEG8 		MUX-8
IJ_BEG8_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut;
IJ_BEG8	<= IJ_BEG8_input(TO_INTEGER(ConfigBits(170 downto 168)));
 
-- switch matrix multiplexer  IJ_BEG9 		MUX-7
IJ_BEG9_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0;
IJ_BEG9	<= IJ_BEG9_input(TO_INTEGER(ConfigBits(173 downto 171)));
 
-- switch matrix multiplexer  IJ_BEG10 		MUX-5
IJ_BEG10_input 	 <= IJ_END6 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1;
IJ_BEG10	<= IJ_BEG10_input(TO_INTEGER(ConfigBits(176 downto 174)));
 
-- switch matrix multiplexer  IJ_BEG11 		MUX-2
IJ_BEG11_input 	 <= IJ_END7 & IJ_END4;
IJ_BEG11	<= IJ_BEG11_input(TO_INTEGER(ConfigBits(177 downto 177)));
 
-- switch matrix multiplexer  IJ_BEG12 		MUX-2
IJ_BEG12_input 	 <= IJ_END8 & IJ_END5;
IJ_BEG12	<= IJ_BEG12_input(TO_INTEGER(ConfigBits(178 downto 178)));
 
-- switch matrix multiplexer  OJ_BEG0 		MUX-2
OJ_BEG0_input 	 <= IJ_END9 & IJ_END6;
OJ_BEG0	<= OJ_BEG0_input(TO_INTEGER(ConfigBits(179 downto 179)));
 
-- switch matrix multiplexer  OJ_BEG1 		MUX-2
OJ_BEG1_input 	 <= IJ_END10 & IJ_END7;
OJ_BEG1	<= OJ_BEG1_input(TO_INTEGER(ConfigBits(180 downto 180)));
 
-- switch matrix multiplexer  OJ_BEG2 		MUX-2
OJ_BEG2_input 	 <= IJ_END11 & IJ_END8;
OJ_BEG2	<= OJ_BEG2_input(TO_INTEGER(ConfigBits(181 downto 181)));
 
-- switch matrix multiplexer  OJ_BEG3 		MUX-1
OJ_BEG3 	 <= 	 IJ_END9 ;
-- switch matrix multiplexer  OJ_BEG4 		MUX-1
OJ_BEG4 	 <= 	 IJ_END10 ;
-- switch matrix multiplexer  OJ_BEG5 		MUX-1
OJ_BEG5 	 <= 	 IJ_END11 ;
-- switch matrix multiplexer  OJ_BEG6 		MUX-1
OJ_BEG6 	 <= 	 IJ_END12 ;

end architecture Behavioral;

