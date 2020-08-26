library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  W_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
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
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity W_term_switch_matrix ;

architecture Behavioral of  W_term_switch_matrix  is 


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

end architecture Behavioral;

