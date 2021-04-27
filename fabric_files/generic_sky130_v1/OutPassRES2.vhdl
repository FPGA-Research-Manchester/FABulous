-- Copyright 2021 University of Manchester

-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at

--     http://www.apache.org/licenses/LICENSE-2.0

-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity
-- InPassFlop2 and OutPassFlop2 are the same except for changing which side I0,I1 or O0,O1 gets connected to the top entity

entity OutPassRES2 is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	RES2_I0	: in	STD_LOGIC; 
	RES2_I1	: in	STD_LOGIC; 
	RES2_I2	: in	STD_LOGIC; 
	RES2_I3	: in	STD_LOGIC; 
	RES2_O0	: out	STD_LOGIC; -- EXTERNAL
	RES2_O1	: out	STD_LOGIC; -- EXTERNAL
	RES2_O2	: out	STD_LOGIC; -- EXTERNAL
	RES2_O3	: out	STD_LOGIC; -- EXTERNAL
	-- Tile IO ports from BELs
 	RES2_UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end entity OutPassRES2;

architecture Behavioral of OutPassRES2 is

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


process(RES2_UserCLK)
begin
	if RES2_UserCLK'event and RES2_UserCLK='1' then
		Q0 <= RES2_I0;
		Q1 <= RES2_I1;
		Q2 <= RES2_I2;
		Q3 <= RES2_I3;
	end if;
end process;

RES2_O0 <= RES2_I0 when (c0 = '0') else Q0;
RES2_O1 <= RES2_I1 when (c1 = '0') else Q1;
RES2_O2 <= RES2_I2 when (c2 = '0') else Q2;
RES2_O3 <= RES2_I3 when (c3 = '0') else Q3;

end architecture Behavioral;
