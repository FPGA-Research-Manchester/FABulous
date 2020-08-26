library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

entity InPassFlop4 is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	InPassI0	: in	STD_LOGIC; -- EXTERNAL
	InPassI1	: in	STD_LOGIC; -- EXTERNAL
	InPassI2	: in	STD_LOGIC; -- EXTERNAL
	InPassI3	: in	STD_LOGIC; -- EXTERNAL
	InPassO0	: out	STD_LOGIC; 
	InPassO1	: out	STD_LOGIC; 
	InPassO2	: out	STD_LOGIC; 
	InPassO3	: out	STD_LOGIC; 
	-- Tile IO ports from BELs
 	InPassUserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send UserCLK all the way to top
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end entity InPassFlop4;

architecture Behavioral of InPassFlop4 is

--              ______   ___
--    I----+--->|FLOP|-Q-|M|
--         |             |U|-------> O
--         +-------------|X|               

-- I am instantiating an IOBUF primitive.
-- However, it is possible to connect corresponding pins all the way to top, just by adding an "-- EXTERNAL" comment (see PAD in the entity)

signal c0, c1, c2, c3 : std_logic;   -- configuration bits ( 0 combinatorial; 1 registered )
signal Q0, Q1, Q2, Q3 : std_logic;   -- FLOPs

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
		
		inst_LHQD1c : LHQD1              
		Port Map(              
		D    => c1,              
		E    => CLK,               
		Q    => c2 );                 
              
		inst_LHQD1d : LHQD1              
		Port Map(              
		D    => c2,
		E    => MODE,
		Q    => c3 ); 
		
CONFout <= c3;


process(InPassUserCLK)
begin
	if InPassUserCLK'event and InPassUserCLK='1' then
		Q0 <= InPassI0;
		Q1 <= InPassI1;
		Q2 <= InPassI2;
		Q3 <= InPassI3;
	end if;
end process;

InPassO0 <= I0 when (c0 = '0') else Q0;
InPassO1 <= I1 when (c1 = '0') else Q1;
InPassO2 <= I2 when (c2 = '0') else Q2;
InPassO3 <= I3 when (c3 = '0') else Q3;

end architecture Behavioral;
