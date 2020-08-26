library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity IO_4_bidirectional is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	I0	: in	STD_LOGIC; -- from fabric to external pin
	T0	: in	STD_LOGIC; -- tristate control
	O0	: out	STD_LOGIC; -- from external pin to fabric
	Q0	: out	STD_LOGIC; -- from external pin to fabric (registered)
	PAD0: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- Pin1
	I1	: in	STD_LOGIC; -- from fabric to external pin
    T1	: in    STD_LOGIC; -- tristate control
    O1	: out    STD_LOGIC; -- from external pin to fabric
    Q1	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD1: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- Pin2
	I2	: in	STD_LOGIC; -- from fabric to external pin
    T2	: in    STD_LOGIC; -- tristate control
    O2	: out    STD_LOGIC; -- from external pin to fabric
    Q2	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD2: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- Pin3
	I3	: in	STD_LOGIC; -- from fabric to external pin
    T3	: in    STD_LOGIC; -- tristate control
    O3	: out    STD_LOGIC; -- from external pin to fabric
    Q3	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD3: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end entity IO_4_bidirectional;

architecture Behavioral of IO_4_bidirectional is

signal fromPad0 : std_logic;
signal fromPad1 : std_logic;
signal fromPad2 : std_logic;
signal fromPad3 : std_logic;

begin

CONFout <= CONFin;

-- Slice outputs
O0 <= fromPad0;
O1 <= fromPad1;
O2 <= fromPad2;
O3 <= fromPad3;

process(clk)
begin
	if clk'event and CLK='1' then
		Q0 <= fromPad0;
		Q1 <= fromPad1;
		Q2 <= fromPad2;
		Q3 <= fromPad3;
	end if;
end process;

IOBUF_inst0 : IOBUF
port map (
O => fromPad0, -- 1-bit output: Buffer output
I => I0, -- 1-bit input: Buffer input
IO => PAD0, -- 1-bit inout: Buffer inout (connect directly to top-level port)
T => T0 -- 1-bit input: 3-state enable input
);

IOBUF_inst1 : IOBUF
port map (
O => fromPad1, -- 1-bit output: Buffer output
I => I1, -- 1-bit input: Buffer input
IO => PAD1, -- 1-bit inout: Buffer inout (connect directly to top-level port)
T => T1 -- 1-bit input: 3-state enable input
);

IOBUF_inst2 : IOBUF
port map (
O => fromPad2, -- 1-bit output: Buffer output
I => I2, -- 1-bit input: Buffer input
IO => PAD2, -- 1-bit inout: Buffer inout (connect directly to top-level port)
T => T2 -- 1-bit input: 3-state enable input
);

IOBUF_inst3 : IOBUF
port map (
O => fromPad3, -- 1-bit output: Buffer output
I => I3, -- 1-bit input: Buffer input
IO => PAD3, -- 1-bit inout: Buffer inout (connect directly to top-level port)
T => T3 -- 1-bit input: 3-state enable input
);


end architecture Behavioral;
