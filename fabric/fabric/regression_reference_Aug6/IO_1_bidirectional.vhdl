library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity IO_1_bidirectional is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	I	: in	STD_LOGIC; -- from fabric to external pin
	T	: in	STD_LOGIC; -- tristate control
	O	: out	STD_LOGIC; -- from external pin to fabric
	Q	: out	STD_LOGIC; -- from external pin to fabric (registered)
	PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this sisgnal all the way to top
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end entity IO_1_bidirectional;

architecture Behavioral of IO_1_bidirectional is

--                        _____
--    I-----T_DRIVER----->|PAD|--+-------> O
--              |         -----  |
--    T---------+                +-->FF--> Q

-- I am instantiating an IOBUF primitive.
-- However, it is possible to connect corresponding pins all the way to top, just by adding an "-- EXTERNAL" comment (see PAD in the entity)

signal fromPad : std_logic;

begin

CONFout <= CONFin;

-- Slice outputs
O <= fromPad;

process(UserCLK)
begin
	if UserCLK'event and UserCLK='1' then
		Q <= fromPad;
	end if;
end process;

IOBUF_inst0 : IOBUF
port map (
O => fromPad, -- 1-bit output: Buffer output
I => I, -- 1-bit input: Buffer input
IO => PAD, -- 1-bit inout: Buffer inout (connect directly to top-level port)
T => T -- 1-bit input: 3-state enable input
);

end architecture Behavioral;
