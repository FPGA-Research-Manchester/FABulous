library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LUT4c is
    -- Generic (LUT_SIZE : integer := 4);	
    Port (      -- IMPORTANT: this has to be in a dedicated line
	I0	: in	STD_LOGIC; -- LUT inputs
	I1	: in	STD_LOGIC;
	I2	: in	STD_LOGIC;
	I3	: in	STD_LOGIC;
	O	: out	STD_LOGIC; -- LUT output (combinatorial or FF)
	Ci	: in	STD_LOGIC; -- carry chain input
	Co	: out	STD_LOGIC; -- carry chain output
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
	CONFin	: in 	 STD_LOGIC;
	CONFout	: out 	 STD_LOGIC;
	CLK	: in 	 STD_LOGIC
	);
end entity LUT4c;

architecture Behavioral of LUT4c is

constant LUT_SIZE : integer := 4; 
constant N_LUT_flops : integer := 2 ** LUT_SIZE; 


signal LUT_values : std_logic_vector(N_LUT_flops-1 downto 0);

signal LUT_index : unsigned(LUT_SIZE-1 downto 0);

signal LUT_out : std_logic;
signal LUT_flop  : std_logic;
signal I0mux              : std_logic;	-- normal input '0', or carry input '1'
signal c_out_mux, c_I0mux : std_logic;	-- extra configuration bits

begin

-- The lookup tables are daisy-chained to a shift register
process(clk)
begin
	if clk'event and CLK='1' then
		if mode='1' then	--configuration mode
		LUT_values <= LUT_values(LUT_values'high-1 downto 0) & CONFin;
		c_out_mux  <= LUT_values(LUT_values'high);
		c_I0mux    <= c_out_mux;
		end if;
	end if;
end process;

CONFout <= c_I0mux;

I0mux <= I0 when (c_I0mux = '0') else Ci;
LUT_index <= I3 & I2 & I1 & I0mux;

-- The LUT is just a multiplexer 
-- for a first shot, I am using a 16:1
LUT_out <= LUT_values(TO_INTEGER(LUT_index));

O <= LUT_flop when (c_out_mux = '1') else LUT_out;

Co <= (Ci AND I1) OR (Ci AND I2) OR (I1 AND I2);	-- iCE40 like carry chain (as this is supported in Josys; would normally go for fractured LUT

process(clk)
begin
	if clk'event and CLK='1' then
		LUT_flop <= LUT_out;
	end if;
end process;


end architecture Behavioral;
