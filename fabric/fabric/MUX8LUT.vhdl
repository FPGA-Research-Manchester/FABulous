library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX8LUT is
    -- Generic (LUT_SIZE : integer := 4);	
    Port (      -- IMPORTANT: this has to be in a dedicated line
	A	: in	STD_LOGIC; -- MUX inputs
	B	: in	STD_LOGIC;
	C	: in	STD_LOGIC;
	D	: in	STD_LOGIC;
	E	: in	STD_LOGIC; 
	F	: in	STD_LOGIC;
	G	: in	STD_LOGIC;
	H	: in	STD_LOGIC;
	S0	: in	STD_LOGIC;
	S1	: in	STD_LOGIC;
	S2	: in	STD_LOGIC;
	S3	: in	STD_LOGIC;
	M_AB: out	STD_LOGIC;
	M_AD: out	STD_LOGIC;
	M_AH: out	STD_LOGIC;
	M_EF: out	STD_LOGIC;
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
	CONFin	: in 	 STD_LOGIC;
	CONFout	: out 	 STD_LOGIC;
	CLK	: in 	 STD_LOGIC
	);
end entity MUX8LUT;

architecture Behavioral of MUX8LUT is

signal AB, CD, EF, GH : std_logic;
signal sCD, sEF, sGH, sEH : std_logic;
signal AD, EH, AH : std_logic;
signal EH_GH : std_logic;

signal c0, c1 : std_logic;	-- configuration bits

begin

-- configuration bits
process(clk)
begin
	if clk'event and CLK='1' then
		if mode='1' then	-- configuration mode
		c0  <= CONFin;
		c1  <= c0;
		end if;
	end if;
end process;

CONFout <= c1;

-- see figure (column-wise left-to-right)
AB <= A when (S0  = '0') else B;
CD <= C when (sCD = '0') else D;
EF <= E when (sEF = '0') else F;
GH <= G when (sGH = '0') else H;

sCD <= S0  when (c0 = '1') else S1;
sEF <= S0  when (c1 = '1') else S2;
sGH <= sEF when (c0 = '1') else sEH;
sEH <= S1  when (c1 = '1') else S3;

AD <= AB when (S1  = '0') else CD;
EH <= EF when (sEH = '0') else GH;

AH <= AD when (S3 = '0') else EH;

EH_GH <= EH when (c0 = '1') else GH;

M_AB <= AB;
M_AD <= AD when (c0 = '1') else CD;
M_AH <= AH when (c1 = '1') else EH_GH;
M_EF <= EF;

end architecture Behavioral;
