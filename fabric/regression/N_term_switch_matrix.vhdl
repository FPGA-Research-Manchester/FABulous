library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  N_term_switch_matrix  is 
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
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity N_term_switch_matrix ;

architecture Behavioral of  N_term_switch_matrix  is 


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

end architecture Behavioral;

