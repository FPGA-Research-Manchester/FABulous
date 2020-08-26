library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clb_slice_2xLUT4 is
    -- Generic (LUT_SIZE : integer := 4);	
    Port (      -- IMPORTANT: this has to be in a dedicated line
	-- LUT_A
	A0	: in	STD_LOGIC; -- ALUT inputs
	A1	: in	STD_LOGIC;
	A2	: in	STD_LOGIC;
	A3	: in	STD_LOGIC;
	A	: out	STD_LOGIC; -- combinatory output
	-- LUT_B
	B0	: in	STD_LOGIC; -- BLUT inputs
	B1	: in	STD_LOGIC;
	B2	: in	STD_LOGIC;
	B3	: in	STD_LOGIC;
	B	: out	STD_LOGIC; -- combinatory output
	-- Select input
	S	: in	STD_LOGIC; -- passed through flop
	-- Flop out
	Q	: out	STD_LOGIC; -- passed through flop
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
	CONFin	: in 	 STD_LOGIC;
	CONFout	: out 	 STD_LOGIC;
	CLK	: in 	 STD_LOGIC
	);
end entity clb_slice_2xLUT4;

architecture Behavioral of clb_slice_2xLUT4 is

constant LUT_SIZE : integer := 4; 
constant N_LUT_flops : integer := 2 ** LUT_SIZE; 


signal LUT_A_values : std_logic_vector(N_LUT_flops-1 downto 0);
signal LUT_B_values : std_logic_vector(N_LUT_flops-1 downto 0);
-- signal LUT_C_values : std_logic_vector(N_LUT_flops-1 downto 0);
-- signal LUT_D_values : std_logic_vector(N_LUT_flops-1 downto 0);

signal LUT_A_index : unsigned(LUT_SIZE-1 downto 0);
signal LUT_B_index : unsigned(LUT_SIZE-1 downto 0);
-- signal LUT_C_index : unsigned(LUT_SIZE-1 downto 0);
-- signal LUT_D_index : unsigned(LUT_SIZE-1 downto 0);

signal LUT_A_out : std_logic;
signal LUT_B_out : std_logic;
-- signal LUT_C_out : std_logic;
-- signal LUT_D_out : std_logic;

signal AB_mux, S_mux, F_mux : std_logic;
signal S_mode : std_logic;

begin

-- The lookup tables are daisy-chained to a shift register
process(clk)
begin
	if clk'event and CLK='1' then
		if mode='1' then	--configuration mode
		LUT_A_values <= LUT_A_values(LUT_A_values'high-1 downto 0) & CONFin;
		LUT_B_values <= LUT_B_values(LUT_A_values'high-1 downto 0) & LUT_A_values(LUT_A_values'high);
		S_mode <= LUT_B_values(LUT_B_values'high);
		-- LUT_D_values <= LUT_D_values(LUT_A_values'high-1 downto 0) & LUT_C_values(LUT_C_values'high);
		end if;
	end if;
end process;

-- CONFout <= LUT_D_values(LUT_D_values'high);
CONFout <= S_mode;

LUT_A_index <= A3 & A2 & A1 & A0;
LUT_B_index <= B3 & B2 & B1 & B0;
-- LUT_C_index <= C3 & C2 & C1 & C0;
-- LUT_D_index <= D3 & D2 & D1 & D0;

-- The LUT is just a multiplexer 
-- for a first shot, I am using a 16:1
LUT_A_out <= LUT_A_values(TO_INTEGER(LUT_A_index));
LUT_B_out <= LUT_B_values(TO_INTEGER(LUT_B_index));

AB_mux <= LUT_B_out when (S_mux = '1') else LUT_A_out;
S_mux  <= S when (S_mode = '1') else '1';
F_mux  <= AB_mux when (S_mode = '1') else S;

-- LUT_C_out <= LUT_C_values(TO_INTEGER(LUT_C_index));
-- LUT_D_out <= LUT_D_values(TO_INTEGER(LUT_D_index));

-- Slice outputs
A <= LUT_A_out;
B <= LUT_B_out;
-- C <= LUT_C_out;
-- D <= LUT_D_out;
process(clk)
begin
	if clk'event and CLK='1' then
		-- AQ <= LUT_A_out;
		-- BQ <= LUT_B_out;
		-- CQ <= LUT_C_out;
		-- DQ <= LUT_D_out;
		Q <= F_mux;
	end if;
end process;


end architecture Behavioral;
