library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IO_4_bidirectional is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	O0	: in	STD_LOGIC; -- fabric to external pin
	T0	: in	STD_LOGIC; -- tristate control
	I0	: out	STD_LOGIC; -- external pin to fabric
	IQ0	: out	STD_LOGIC; -- external pin to fabric (registered)
	-- Pin1
	O1	: in	STD_LOGIC; -- fabric to external pin
    T1	: in    STD_LOGIC; -- tristate control
    I1	: out    STD_LOGIC; -- external pin to fabric
    IQ1	: out    STD_LOGIC; -- external pin to fabric (registered)
	-- Pin2
	O2	: in	STD_LOGIC; -- fabric to external pin
    T2	: in    STD_LOGIC; -- tristate control
    I2	: out    STD_LOGIC; -- external pin to fabric
    IQ2	: out    STD_LOGIC; -- external pin to fabric (registered)
	-- Pin3
	O3	: in	STD_LOGIC; -- fabric to external pin
    T3	: in    STD_LOGIC; -- tristate control
    I3	: out    STD_LOGIC; -- external pin to fabric
    IQ3	: out    STD_LOGIC; -- external pin to fabric (registered)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	CLK	: in 	 STD_LOGIC
	);
end entity IO_4_bidirectional;

architecture Behavioral of IO_4_bidirectional is

signal LUT_A_out : std_logic;
signal LUT_B_out : std_logic;
signal LUT_C_out : std_logic;
signal LUT_D_out : std_logic;

begin

-- Slice outputs
I0 <= O0 AND T0;
I1 <= O1 AND T1;
I2 <= O2 AND T2;
I3 <= O3 AND T3;

process(clk)
begin
	if clk'event and CLK='1' then
		IQ0 <= O0 AND T0;
		IQ1 <= O1 AND T1;
		IQ2 <= O2 AND T2;
		IQ3 <= O3 AND T3;
	end if;
end process;


end architecture Behavioral;
