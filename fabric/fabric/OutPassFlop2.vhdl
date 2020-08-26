library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

entity OutPassFlop2 is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	OutPassI0	: in	STD_LOGIC; -- EXTERNAL
	OutPassI1	: in	STD_LOGIC; -- EXTERNAL
	OutPassO0	: out	STD_LOGIC; 
	OutPassO1	: out	STD_LOGIC; 
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send UserCLK all the way to top
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end entity OutPassFlop2;

architecture Behavioral of OutPassFlop2 is

--              ______   ___
--    I----+--->|FLOP|-Q-|M|
--         |             |U|-------> O
--         +-------------|X|               

-- I am instantiating an IOBUF primitive.
-- However, it is possible to connect corresponding pins all the way to top, just by adding an "-- EXTERNAL" comment (see PAD in the entity)

signal c0, c1 : std_logic;   -- configuration bits ( 0 combinatorial; 1 registered )
signal Q0, Q1 : std_logic;   -- FLOPs

begin

		inst_LHQD1a : LHQD1              
		Port Map(              
		D    => CONFin,              
		E    => CLK,               
		Q    => c0 );                 
              
		inst_LHQD1b : LHQD1              
		Port Map(              
		D    => c0,
		E    => MODE,
		Q    => c1 ); 
		
CONFout <= c1;


process(UserCLK)
begin
	if UserCLK'event and UserCLK='1' then
		Q0 <= OutPassI0;
		Q1 <= OutPassI1;
	end if;
end process;

OutPassO0 <= I0 when (c0 = '0') else Q0;
OutPassO1 <= I1 when (c1 = '0') else Q1;

end architecture Behavioral;
