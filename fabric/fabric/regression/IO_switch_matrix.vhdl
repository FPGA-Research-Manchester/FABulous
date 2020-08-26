library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  IO_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
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
		  I0 	: in 	 STD_LOGIC;
		  IQ0 	: in 	 STD_LOGIC;
		  I1 	: in 	 STD_LOGIC;
		  IQ1 	: in 	 STD_LOGIC;
		  I2 	: in 	 STD_LOGIC;
		  IQ2 	: in 	 STD_LOGIC;
		  I3 	: in 	 STD_LOGIC;
		  IQ3 	: in 	 STD_LOGIC;
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
		  O0 	: out 	 STD_LOGIC;
		  T0 	: out 	 STD_LOGIC;
		  O1 	: out 	 STD_LOGIC;
		  T1 	: out 	 STD_LOGIC;
		  O2 	: out 	 STD_LOGIC;
		  T2 	: out 	 STD_LOGIC;
		  O3 	: out 	 STD_LOGIC;
		  T3 	: out 	 STD_LOGIC;
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
end entity IO_switch_matrix ;

architecture Behavioral of  IO_switch_matrix  is 


-- The configuration bits are just a long shift register
signal 	 ConfigBits :	 unsigned( 0-1 downto 0 );

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
 

-- switch matrix multiplexer  N1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG0
-- switch matrix multiplexer  N1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG1
-- switch matrix multiplexer  N1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG2
-- switch matrix multiplexer  N2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG0
-- switch matrix multiplexer  N2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG1
-- switch matrix multiplexer  N2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-N2BEG2
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
-- switch matrix multiplexer  S1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG0
-- switch matrix multiplexer  S1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG1
-- switch matrix multiplexer  S1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG2
-- switch matrix multiplexer  S1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG3
-- switch matrix multiplexer  S1BEG4 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG4
-- switch matrix multiplexer  S2BEG0 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG0
-- switch matrix multiplexer  S2BEG1 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG1
-- switch matrix multiplexer  S2BEG2 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG2
-- switch matrix multiplexer  S2BEG3 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG3
-- switch matrix multiplexer  S2BEG4 		MUX-0
-- WARNING unused multiplexer MUX-S2BEG4
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
-- switch matrix multiplexer  O0 		MUX-0
-- WARNING unused multiplexer MUX-O0
-- switch matrix multiplexer  T0 		MUX-0
-- WARNING unused multiplexer MUX-T0
-- switch matrix multiplexer  O1 		MUX-0
-- WARNING unused multiplexer MUX-O1
-- switch matrix multiplexer  T1 		MUX-0
-- WARNING unused multiplexer MUX-T1
-- switch matrix multiplexer  O2 		MUX-0
-- WARNING unused multiplexer MUX-O2
-- switch matrix multiplexer  T2 		MUX-0
-- WARNING unused multiplexer MUX-T2
-- switch matrix multiplexer  O3 		MUX-0
-- WARNING unused multiplexer MUX-O3
-- switch matrix multiplexer  T3 		MUX-0
-- WARNING unused multiplexer MUX-T3
-- switch matrix multiplexer  IJ_BEG0 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG0
-- switch matrix multiplexer  IJ_BEG1 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG1
-- switch matrix multiplexer  IJ_BEG2 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG2
-- switch matrix multiplexer  IJ_BEG3 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG3
-- switch matrix multiplexer  IJ_BEG4 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG4
-- switch matrix multiplexer  IJ_BEG5 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG5
-- switch matrix multiplexer  IJ_BEG6 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG6
-- switch matrix multiplexer  IJ_BEG7 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG7
-- switch matrix multiplexer  IJ_BEG8 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG8
-- switch matrix multiplexer  IJ_BEG9 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG9
-- switch matrix multiplexer  IJ_BEG10 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG10
-- switch matrix multiplexer  IJ_BEG11 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG11
-- switch matrix multiplexer  IJ_BEG12 		MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG12
-- switch matrix multiplexer  OJ_BEG0 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG0
-- switch matrix multiplexer  OJ_BEG1 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG1
-- switch matrix multiplexer  OJ_BEG2 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG2
-- switch matrix multiplexer  OJ_BEG3 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG3
-- switch matrix multiplexer  OJ_BEG4 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG4
-- switch matrix multiplexer  OJ_BEG5 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG5
-- switch matrix multiplexer  OJ_BEG6 		MUX-0
-- WARNING unused multiplexer MUX-OJ_BEG6

end architecture Behavioral;

