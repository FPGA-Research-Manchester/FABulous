-- NumberOfConfigBits:637
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
		  B_A 	: in 	 STD_LOGIC;
		  B_AQ 	: in 	 STD_LOGIC;
		  B_B 	: in 	 STD_LOGIC;
		  B_BQ 	: in 	 STD_LOGIC;
		  B_C 	: in 	 STD_LOGIC;
		  B_CQ 	: in 	 STD_LOGIC;
		  B_D 	: in 	 STD_LOGIC;
		  B_DQ 	: in 	 STD_LOGIC;
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
		  B_A0 	: out 	 STD_LOGIC;
		  B_A1 	: out 	 STD_LOGIC;
		  B_A2 	: out 	 STD_LOGIC;
		  B_A3 	: out 	 STD_LOGIC;
		  B_B0 	: out 	 STD_LOGIC;
		  B_B1 	: out 	 STD_LOGIC;
		  B_B2 	: out 	 STD_LOGIC;
		  B_B3 	: out 	 STD_LOGIC;
		  B_C0 	: out 	 STD_LOGIC;
		  B_C1 	: out 	 STD_LOGIC;
		  B_C2 	: out 	 STD_LOGIC;
		  B_C3 	: out 	 STD_LOGIC;
		  B_D0 	: out 	 STD_LOGIC;
		  B_D1 	: out 	 STD_LOGIC;
		  B_D2 	: out 	 STD_LOGIC;
		  B_D3 	: out 	 STD_LOGIC;
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

signal 	  N1BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N1BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N1BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N2BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N2BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N2BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N4BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  N4BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E1BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E1BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E1BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E1BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E2BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E2BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E2BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  E2BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S1BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S1BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S1BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S1BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S1BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S2BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S2BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S2BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S2BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  S2BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W1BEG5_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  A0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  A1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  A2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  A3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  C0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  C1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  C2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  C3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  D0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  D1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  D2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  D3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_A0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_A1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_A2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_A3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_B0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_B1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_B2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_B3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_C0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_C1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_C2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_C3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_D0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_D1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_D2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  B_D3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  TestIn_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG5_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG6_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG7_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG8_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG9_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG10_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG11_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  IJ_BEG12_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG0_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG1_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG2_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG3_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG4_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG5_input 	:	 std_logic_vector( 75 - 1 downto 0 );
signal 	  OJ_BEG6_input 	:	 std_logic_vector( 75 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register
signal 	 ConfigBits :	 unsigned( 637-1 downto 0 );

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
 

-- switch matrix multiplexer  N1BEG0 		MUX-75
N1BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N1BEG0	<= N1BEG0_input(TO_INTEGER(ConfigBits(6 downto 0)));
 
-- switch matrix multiplexer  N1BEG1 		MUX-75
N1BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N1BEG1	<= N1BEG1_input(TO_INTEGER(ConfigBits(13 downto 7)));
 
-- switch matrix multiplexer  N1BEG2 		MUX-75
N1BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N1BEG2	<= N1BEG2_input(TO_INTEGER(ConfigBits(20 downto 14)));
 
-- switch matrix multiplexer  N2BEG0 		MUX-75
N2BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N2BEG0	<= N2BEG0_input(TO_INTEGER(ConfigBits(27 downto 21)));
 
-- switch matrix multiplexer  N2BEG1 		MUX-75
N2BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N2BEG1	<= N2BEG1_input(TO_INTEGER(ConfigBits(34 downto 28)));
 
-- switch matrix multiplexer  N2BEG2 		MUX-75
N2BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N2BEG2	<= N2BEG2_input(TO_INTEGER(ConfigBits(41 downto 35)));
 
-- switch matrix multiplexer  N4BEG0 		MUX-75
N4BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N4BEG0	<= N4BEG0_input(TO_INTEGER(ConfigBits(48 downto 42)));
 
-- switch matrix multiplexer  N4BEG1 		MUX-75
N4BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
N4BEG1	<= N4BEG1_input(TO_INTEGER(ConfigBits(55 downto 49)));
 
-- switch matrix multiplexer  E1BEG0 		MUX-75
E1BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E1BEG0	<= E1BEG0_input(TO_INTEGER(ConfigBits(62 downto 56)));
 
-- switch matrix multiplexer  E1BEG1 		MUX-75
E1BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E1BEG1	<= E1BEG1_input(TO_INTEGER(ConfigBits(69 downto 63)));
 
-- switch matrix multiplexer  E1BEG2 		MUX-75
E1BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E1BEG2	<= E1BEG2_input(TO_INTEGER(ConfigBits(76 downto 70)));
 
-- switch matrix multiplexer  E1BEG3 		MUX-75
E1BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E1BEG3	<= E1BEG3_input(TO_INTEGER(ConfigBits(83 downto 77)));
 
-- switch matrix multiplexer  E2BEG0 		MUX-75
E2BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E2BEG0	<= E2BEG0_input(TO_INTEGER(ConfigBits(90 downto 84)));
 
-- switch matrix multiplexer  E2BEG1 		MUX-75
E2BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E2BEG1	<= E2BEG1_input(TO_INTEGER(ConfigBits(97 downto 91)));
 
-- switch matrix multiplexer  E2BEG2 		MUX-75
E2BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E2BEG2	<= E2BEG2_input(TO_INTEGER(ConfigBits(104 downto 98)));
 
-- switch matrix multiplexer  E2BEG3 		MUX-75
E2BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
E2BEG3	<= E2BEG3_input(TO_INTEGER(ConfigBits(111 downto 105)));
 
-- switch matrix multiplexer  S1BEG0 		MUX-75
S1BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S1BEG0	<= S1BEG0_input(TO_INTEGER(ConfigBits(118 downto 112)));
 
-- switch matrix multiplexer  S1BEG1 		MUX-75
S1BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S1BEG1	<= S1BEG1_input(TO_INTEGER(ConfigBits(125 downto 119)));
 
-- switch matrix multiplexer  S1BEG2 		MUX-75
S1BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S1BEG2	<= S1BEG2_input(TO_INTEGER(ConfigBits(132 downto 126)));
 
-- switch matrix multiplexer  S1BEG3 		MUX-75
S1BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S1BEG3	<= S1BEG3_input(TO_INTEGER(ConfigBits(139 downto 133)));
 
-- switch matrix multiplexer  S1BEG4 		MUX-75
S1BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S1BEG4	<= S1BEG4_input(TO_INTEGER(ConfigBits(146 downto 140)));
 
-- switch matrix multiplexer  S2BEG0 		MUX-75
S2BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S2BEG0	<= S2BEG0_input(TO_INTEGER(ConfigBits(153 downto 147)));
 
-- switch matrix multiplexer  S2BEG1 		MUX-75
S2BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S2BEG1	<= S2BEG1_input(TO_INTEGER(ConfigBits(160 downto 154)));
 
-- switch matrix multiplexer  S2BEG2 		MUX-75
S2BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S2BEG2	<= S2BEG2_input(TO_INTEGER(ConfigBits(167 downto 161)));
 
-- switch matrix multiplexer  S2BEG3 		MUX-75
S2BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S2BEG3	<= S2BEG3_input(TO_INTEGER(ConfigBits(174 downto 168)));
 
-- switch matrix multiplexer  S2BEG4 		MUX-75
S2BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
S2BEG4	<= S2BEG4_input(TO_INTEGER(ConfigBits(181 downto 175)));
 
-- switch matrix multiplexer  W1BEG0 		MUX-75
W1BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG0	<= W1BEG0_input(TO_INTEGER(ConfigBits(188 downto 182)));
 
-- switch matrix multiplexer  W1BEG1 		MUX-75
W1BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG1	<= W1BEG1_input(TO_INTEGER(ConfigBits(195 downto 189)));
 
-- switch matrix multiplexer  W1BEG2 		MUX-75
W1BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG2	<= W1BEG2_input(TO_INTEGER(ConfigBits(202 downto 196)));
 
-- switch matrix multiplexer  W1BEG3 		MUX-75
W1BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG3	<= W1BEG3_input(TO_INTEGER(ConfigBits(209 downto 203)));
 
-- switch matrix multiplexer  W1BEG4 		MUX-75
W1BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG4	<= W1BEG4_input(TO_INTEGER(ConfigBits(216 downto 210)));
 
-- switch matrix multiplexer  W1BEG5 		MUX-75
W1BEG5_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W1BEG5	<= W1BEG5_input(TO_INTEGER(ConfigBits(223 downto 217)));
 
-- switch matrix multiplexer  W2BEG0 		MUX-75
W2BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG0	<= W2BEG0_input(TO_INTEGER(ConfigBits(230 downto 224)));
 
-- switch matrix multiplexer  W2BEG1 		MUX-75
W2BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG1	<= W2BEG1_input(TO_INTEGER(ConfigBits(237 downto 231)));
 
-- switch matrix multiplexer  W2BEG2 		MUX-75
W2BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG2	<= W2BEG2_input(TO_INTEGER(ConfigBits(244 downto 238)));
 
-- switch matrix multiplexer  W2BEG3 		MUX-75
W2BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG3	<= W2BEG3_input(TO_INTEGER(ConfigBits(251 downto 245)));
 
-- switch matrix multiplexer  W2BEG4 		MUX-75
W2BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG4	<= W2BEG4_input(TO_INTEGER(ConfigBits(258 downto 252)));
 
-- switch matrix multiplexer  W2BEG5 		MUX-75
W2BEG5_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
W2BEG5	<= W2BEG5_input(TO_INTEGER(ConfigBits(265 downto 259)));
 
-- switch matrix multiplexer  A0 		MUX-75
A0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
A0	<= A0_input(TO_INTEGER(ConfigBits(272 downto 266)));
 
-- switch matrix multiplexer  A1 		MUX-75
A1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
A1	<= A1_input(TO_INTEGER(ConfigBits(279 downto 273)));
 
-- switch matrix multiplexer  A2 		MUX-75
A2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
A2	<= A2_input(TO_INTEGER(ConfigBits(286 downto 280)));
 
-- switch matrix multiplexer  A3 		MUX-75
A3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
A3	<= A3_input(TO_INTEGER(ConfigBits(293 downto 287)));
 
-- switch matrix multiplexer  B0 		MUX-75
B0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B0	<= B0_input(TO_INTEGER(ConfigBits(300 downto 294)));
 
-- switch matrix multiplexer  B1 		MUX-75
B1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B1	<= B1_input(TO_INTEGER(ConfigBits(307 downto 301)));
 
-- switch matrix multiplexer  B2 		MUX-75
B2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B2	<= B2_input(TO_INTEGER(ConfigBits(314 downto 308)));
 
-- switch matrix multiplexer  B3 		MUX-75
B3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B3	<= B3_input(TO_INTEGER(ConfigBits(321 downto 315)));
 
-- switch matrix multiplexer  C0 		MUX-75
C0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
C0	<= C0_input(TO_INTEGER(ConfigBits(328 downto 322)));
 
-- switch matrix multiplexer  C1 		MUX-75
C1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
C1	<= C1_input(TO_INTEGER(ConfigBits(335 downto 329)));
 
-- switch matrix multiplexer  C2 		MUX-75
C2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
C2	<= C2_input(TO_INTEGER(ConfigBits(342 downto 336)));
 
-- switch matrix multiplexer  C3 		MUX-75
C3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
C3	<= C3_input(TO_INTEGER(ConfigBits(349 downto 343)));
 
-- switch matrix multiplexer  D0 		MUX-75
D0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
D0	<= D0_input(TO_INTEGER(ConfigBits(356 downto 350)));
 
-- switch matrix multiplexer  D1 		MUX-75
D1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
D1	<= D1_input(TO_INTEGER(ConfigBits(363 downto 357)));
 
-- switch matrix multiplexer  D2 		MUX-75
D2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
D2	<= D2_input(TO_INTEGER(ConfigBits(370 downto 364)));
 
-- switch matrix multiplexer  D3 		MUX-75
D3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
D3	<= D3_input(TO_INTEGER(ConfigBits(377 downto 371)));
 
-- switch matrix multiplexer  B_A0 		MUX-75
B_A0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_A0	<= B_A0_input(TO_INTEGER(ConfigBits(384 downto 378)));
 
-- switch matrix multiplexer  B_A1 		MUX-75
B_A1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_A1	<= B_A1_input(TO_INTEGER(ConfigBits(391 downto 385)));
 
-- switch matrix multiplexer  B_A2 		MUX-75
B_A2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_A2	<= B_A2_input(TO_INTEGER(ConfigBits(398 downto 392)));
 
-- switch matrix multiplexer  B_A3 		MUX-75
B_A3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_A3	<= B_A3_input(TO_INTEGER(ConfigBits(405 downto 399)));
 
-- switch matrix multiplexer  B_B0 		MUX-75
B_B0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_B0	<= B_B0_input(TO_INTEGER(ConfigBits(412 downto 406)));
 
-- switch matrix multiplexer  B_B1 		MUX-75
B_B1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_B1	<= B_B1_input(TO_INTEGER(ConfigBits(419 downto 413)));
 
-- switch matrix multiplexer  B_B2 		MUX-75
B_B2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_B2	<= B_B2_input(TO_INTEGER(ConfigBits(426 downto 420)));
 
-- switch matrix multiplexer  B_B3 		MUX-75
B_B3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_B3	<= B_B3_input(TO_INTEGER(ConfigBits(433 downto 427)));
 
-- switch matrix multiplexer  B_C0 		MUX-75
B_C0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_C0	<= B_C0_input(TO_INTEGER(ConfigBits(440 downto 434)));
 
-- switch matrix multiplexer  B_C1 		MUX-75
B_C1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_C1	<= B_C1_input(TO_INTEGER(ConfigBits(447 downto 441)));
 
-- switch matrix multiplexer  B_C2 		MUX-75
B_C2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_C2	<= B_C2_input(TO_INTEGER(ConfigBits(454 downto 448)));
 
-- switch matrix multiplexer  B_C3 		MUX-75
B_C3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_C3	<= B_C3_input(TO_INTEGER(ConfigBits(461 downto 455)));
 
-- switch matrix multiplexer  B_D0 		MUX-75
B_D0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_D0	<= B_D0_input(TO_INTEGER(ConfigBits(468 downto 462)));
 
-- switch matrix multiplexer  B_D1 		MUX-75
B_D1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_D1	<= B_D1_input(TO_INTEGER(ConfigBits(475 downto 469)));
 
-- switch matrix multiplexer  B_D2 		MUX-75
B_D2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_D2	<= B_D2_input(TO_INTEGER(ConfigBits(482 downto 476)));
 
-- switch matrix multiplexer  B_D3 		MUX-75
B_D3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
B_D3	<= B_D3_input(TO_INTEGER(ConfigBits(489 downto 483)));
 
-- switch matrix multiplexer  TestIn 		MUX-75
TestIn_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
TestIn	<= TestIn_input(TO_INTEGER(ConfigBits(496 downto 490)));
 
-- switch matrix multiplexer  IJ_BEG0 		MUX-75
IJ_BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG0	<= IJ_BEG0_input(TO_INTEGER(ConfigBits(503 downto 497)));
 
-- switch matrix multiplexer  IJ_BEG1 		MUX-75
IJ_BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG1	<= IJ_BEG1_input(TO_INTEGER(ConfigBits(510 downto 504)));
 
-- switch matrix multiplexer  IJ_BEG2 		MUX-75
IJ_BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG2	<= IJ_BEG2_input(TO_INTEGER(ConfigBits(517 downto 511)));
 
-- switch matrix multiplexer  IJ_BEG3 		MUX-75
IJ_BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG3	<= IJ_BEG3_input(TO_INTEGER(ConfigBits(524 downto 518)));
 
-- switch matrix multiplexer  IJ_BEG4 		MUX-75
IJ_BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG4	<= IJ_BEG4_input(TO_INTEGER(ConfigBits(531 downto 525)));
 
-- switch matrix multiplexer  IJ_BEG5 		MUX-75
IJ_BEG5_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG5	<= IJ_BEG5_input(TO_INTEGER(ConfigBits(538 downto 532)));
 
-- switch matrix multiplexer  IJ_BEG6 		MUX-75
IJ_BEG6_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG6	<= IJ_BEG6_input(TO_INTEGER(ConfigBits(545 downto 539)));
 
-- switch matrix multiplexer  IJ_BEG7 		MUX-75
IJ_BEG7_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG7	<= IJ_BEG7_input(TO_INTEGER(ConfigBits(552 downto 546)));
 
-- switch matrix multiplexer  IJ_BEG8 		MUX-75
IJ_BEG8_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG8	<= IJ_BEG8_input(TO_INTEGER(ConfigBits(559 downto 553)));
 
-- switch matrix multiplexer  IJ_BEG9 		MUX-75
IJ_BEG9_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG9	<= IJ_BEG9_input(TO_INTEGER(ConfigBits(566 downto 560)));
 
-- switch matrix multiplexer  IJ_BEG10 		MUX-75
IJ_BEG10_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG10	<= IJ_BEG10_input(TO_INTEGER(ConfigBits(573 downto 567)));
 
-- switch matrix multiplexer  IJ_BEG11 		MUX-75
IJ_BEG11_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG11	<= IJ_BEG11_input(TO_INTEGER(ConfigBits(580 downto 574)));
 
-- switch matrix multiplexer  IJ_BEG12 		MUX-75
IJ_BEG12_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
IJ_BEG12	<= IJ_BEG12_input(TO_INTEGER(ConfigBits(587 downto 581)));
 
-- switch matrix multiplexer  OJ_BEG0 		MUX-75
OJ_BEG0_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG0	<= OJ_BEG0_input(TO_INTEGER(ConfigBits(594 downto 588)));
 
-- switch matrix multiplexer  OJ_BEG1 		MUX-75
OJ_BEG1_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG1	<= OJ_BEG1_input(TO_INTEGER(ConfigBits(601 downto 595)));
 
-- switch matrix multiplexer  OJ_BEG2 		MUX-75
OJ_BEG2_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG2	<= OJ_BEG2_input(TO_INTEGER(ConfigBits(608 downto 602)));
 
-- switch matrix multiplexer  OJ_BEG3 		MUX-75
OJ_BEG3_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG3	<= OJ_BEG3_input(TO_INTEGER(ConfigBits(615 downto 609)));
 
-- switch matrix multiplexer  OJ_BEG4 		MUX-75
OJ_BEG4_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG4	<= OJ_BEG4_input(TO_INTEGER(ConfigBits(622 downto 616)));
 
-- switch matrix multiplexer  OJ_BEG5 		MUX-75
OJ_BEG5_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG5	<= OJ_BEG5_input(TO_INTEGER(ConfigBits(629 downto 623)));
 
-- switch matrix multiplexer  OJ_BEG6 		MUX-75
OJ_BEG6_input 	 <= OJ_END6 & OJ_END5 & OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END12 & IJ_END11 & IJ_END10 & IJ_END9 & IJ_END8 & IJ_END7 & IJ_END6 & IJ_END5 & IJ_END4 & IJ_END3 & IJ_END2 & IJ_END1 & IJ_END0 & TestOut & B_DQ & B_D & B_CQ & B_C & B_BQ & B_B & B_AQ & B_A & DQ & D & CQ & C & BQ & B & AQ & A & W2END5 & W2END4 & W2END3 & W2END2 & W2END1 & W2END0 & W1END5 & W1END4 & W1END3 & W1END2 & W1END1 & W1END0 & S2END4 & S2END3 & S2END2 & S2END1 & S2END0 & S1END4 & S1END3 & S1END2 & S1END1 & S1END0 & E2END3 & E2END2 & E2END1 & E2END0 & E1END3 & E1END2 & E1END1 & E1END0 & N4END1 & N4END0 & N2END2 & N2END1 & N2END0 & N1END2 & N1END1 & N1END0;
OJ_BEG6	<= OJ_BEG6_input(TO_INTEGER(ConfigBits(636 downto 630)));
 

end architecture Behavioral;

