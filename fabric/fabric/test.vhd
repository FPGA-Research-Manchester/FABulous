----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2019 21:15:37
-- Design Name: 
-- Module Name: test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
    Port (      -- IMPORTANT: this has to be in a dedicated line

TestIn    : in    STD_LOGIC; -- ALUT inputs
TestOut    : out    STD_LOGIC; -- combinatory output
-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
MODE    : in      STD_LOGIC;     -- 1 configuration, 0 action
CONFin    : in      STD_LOGIC;
CONFout    : out      STD_LOGIC;
CLK    : in      STD_LOGIC
);
end entity test;

architecture Behavioral of test is

signal congig_bit : std_logic;

begin

process(clk)
begin
	if clk'event and CLK='1' then
		if mode='1' then	--configuration mode
		congig_bit <= CONFin;
		end if;
	end if;
end process;
CONFout <= congig_bit;

TestOut <= TestIn XOR congig_bit;   -- configurable inverter for test

end Behavioral;
