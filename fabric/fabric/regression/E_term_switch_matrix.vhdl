library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  E_term_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
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
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity E_term_switch_matrix ;

architecture Behavioral of  E_term_switch_matrix  is 


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

end architecture Behavioral;

