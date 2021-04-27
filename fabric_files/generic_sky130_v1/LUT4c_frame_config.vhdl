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

entity LUT4c_frame_config is
    Generic ( NoConfigBits : integer := 18 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port (      -- IMPORTANT: this has to be in a dedicated line
	I0	: in	STD_LOGIC; -- LUT inputs
	I1	: in	STD_LOGIC;
	I2	: in	STD_LOGIC;
	I3	: in	STD_LOGIC;
	O	: out	STD_LOGIC; -- LUT output (combinatorial or FF)
	Ci	: in	STD_LOGIC; -- carry chain input
	Co	: out	STD_LOGIC; -- carry chain output
	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this sisgnal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end entity LUT4c_frame_config;

architecture Behavioral of LUT4c_frame_config is

constant LUT_SIZE : integer := 4; 
constant N_LUT_flops : integer := 2 ** LUT_SIZE; 


signal LUT_values : std_logic_vector(N_LUT_flops-1 downto 0);

signal LUT_index : unsigned(LUT_SIZE-1 downto 0);

signal LUT_out : std_logic;
signal LUT_flop  : std_logic;
signal I0mux              : std_logic;	-- normal input '0', or carry input '1'
signal c_out_mux, c_I0mux : std_logic;	-- extra configuration bits


begin

LUT_values <= ConfigBits(15 downto 0);
c_out_mux  <= ConfigBits(16);
c_I0mux    <= ConfigBits(17);

--CONFout <= c_I0mux;

I0mux <= I0 when (c_I0mux = '0') else Ci;
LUT_index <= I3 & I2 & I1 & I0mux;

-- The LUT is just a multiplexer 
-- for a first shot, I am using a 16:1
-- LUT_out <= LUT_values(TO_INTEGER(LUT_index));
inst_MUX16PTv2_E6BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> LUT_values(0),
		IN2 	=> LUT_values(1),
		IN3 	=> LUT_values(2),
		IN4 	=> LUT_values(3),
		IN5 	=> LUT_values(4),
		IN6 	=> LUT_values(5),
		IN7 	=> LUT_values(6),
		IN8 	=> LUT_values(7),
		IN9 	=> LUT_values(8),
		IN10 	=> LUT_values(9),
		IN11 	=> LUT_values(10),
		IN12 	=> LUT_values(11),
		IN13 	=> LUT_values(12),
		IN14 	=> LUT_values(13),
		IN15 	=> LUT_values(14),
		IN16 	=> LUT_values(15),
		S1 	=> LUT_index(0),
		S2 	=> LUT_index(1),
		S3 	=> LUT_index(2),
		S4 	=> LUT_index(3),
		O  	=> LUT_out );

O <= LUT_flop when (c_out_mux = '1') else LUT_out;

Co <= (Ci AND I1) OR (Ci AND I2) OR (I1 AND I2);	-- iCE40 like carry chain (as this is supported in Josys; would normally go for fractured LUT

process(UserCLK)
begin
	if UserCLK'event and UserCLK='1' then
		LUT_flop <= LUT_out;
	end if;
end process;


end architecture Behavioral;
