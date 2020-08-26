library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IO_1_bidirectional_frame_config is
    Generic ( NoConfigBits : integer := 0 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port ( 
	-- Pin0
	I	: in	STD_LOGIC; -- from fabric to external pin
	T	: in	STD_LOGIC; -- tristate control
	O	: out	STD_LOGIC; -- from external pin to fabric
	Q	: out	STD_LOGIC; -- from external pin to fabric (registered)
	PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end entity IO_1_bidirectional_frame_config;

architecture Behavioral of IO_1_bidirectional_frame_config is

--                        _____
--    I-----T_DRIVER----->|PAD|--+-------> O
--              |         -----  |
--    T---------+                +-->FF--> Q

-- I am instantiating an IOBUF primitive.
-- However, it is possible to connect corresponding pins all the way to top, just by adding an "-- EXTERNAL" comment (see PAD in the entity)

-- component PDUW0208SCDG is		 	-- page 27 in TSMC Standard I/O
-- 	Port(
-- 		PE : in 	std_logic;		-- Pull-Up resistor control 
-- 		IE : in		std_logic;		-- Input Enable (set to '1')
-- 		C  : out	std_logic;		-- Schmitt trigger to fabric
-- 		DS : in		std_logic;		-- drive strength
-- 		I  : in		std_logic;		-- the actual input from the fabric (fabric to PAD)
-- 		OEN : in	std_logic;		-- tristate control (active low)
-- 		PAD : inout	std_logic  );
-- end component PDUW0208SCDG;

signal OEN : std_logic;
signal fromPad : std_logic;

begin

-- Slice outputs
O <= fromPad;

process(UserCLK)
begin
	if UserCLK'event and UserCLK='1' then
		Q <= fromPad;
	end if;
end process;

-- The following was used for using the I/O cell on a Xilinx FPGA
-- IOBUF_inst0 : IOBUF
-- port map (
-- O => fromPad, -- 1-bit output: Buffer output
-- I => I, -- 1-bit input: Buffer input
-- IO => PAD, -- 1-bit inout: Buffer inout (connect directly to top-level port)
-- T => T -- 1-bit input: 3-state enable input
-- );

OEN <= NOT T;	-- we invert this as that switches of PAD if configuration blanked

IOBUF_inst0 : PDUW0208SCDG -- page 27 in TSMC Standard I/O
port map (
		PE   => '1',		-- Pull-Up resistor control 
		IE   => '1',		-- Input Enable (set to '1')
		C    => fromPad,	-- Schmitt trigger to fabric
		DS   => '1' 		-- drive strength ('1' may allow driving a LED)
		I    => I			-- the actual input from the fabric (fabric to PAD)
		OEN  => OEN,		-- tristate control (active low)
		PAD  => PAD  );
end component PDUW0208SCDG;


end architecture Behavioral;
