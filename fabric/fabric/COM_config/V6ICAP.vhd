----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:47:47 03/23/2015 
-- Design Name: 
-- Module Name:    V6ICAP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity V6ICAP is
    Port ( SW     : in  STD_LOGIC_VECTOR (7 downto 0);
           Btn    : in  STD_LOGIC_VECTOR (4 downto 0);
           BtnLED : out  STD_LOGIC_VECTOR (4 downto 0);
			  LED    : out  STD_LOGIC_VECTOR (7 downto 0);
	        SYSCLK_P : in std_logic; -- 200 MHz
           UartRx : in  STD_LOGIC;
           UartTx : out  STD_LOGIC);
end V6ICAP;

architecture Behavioral of V6ICAP is

component ComConfig is
 generic ( Family     : string := "Spartan6"; -- [Spartan6|Virtex5|Virtex6]
--         ByteWise   : Boolean := true;  -- Full ICAP width (false) or ByteWise reconfiguration (true)
           Mode       : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                          -- bin is for faster binary mode, but might not work on all machines/boards
                                          -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                          -- "1--- ----" is for hex mode, "0--- ----" for bin mode
           ComRate    : integer := 217);  -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
    Port ( CLK        : in  STD_LOGIC;
           Rx         : in  STD_LOGIC;
           ReceiveLED : out  STD_LOGIC);
end component ComConfig;

component testXOR is
    Port ( clk : in STD_LOGIC;
	        I1 : in  STD_LOGIC;
           I2 : in  STD_LOGIC;
           I3 : in  STD_LOGIC;
           I4 : in  STD_LOGIC;
           I5 : in  STD_LOGIC;
           I6 : in  STD_LOGIC;
           O : out  STD_LOGIC);
end component testXOR;

signal CLK200 : std_logic :='0';
signal CLK100, CLK_100 : std_logic :='0';
signal XOR1,XOR2,XOR3 : std_logic;

begin

LED(7 downto 0) <= SW(7 downto 0);
BtnLED(4 downto 2) <= Btn(4 downto 2);
UartTx <= UartRx;


InstBUFG200 : BUFG
port map ( I => SYSCLK_P,
           O => CLK200);
process(CLK200)
begin
  if CLK200'event AND CLK200='1' then
    CLK_100 <= NOT CLK_100;
  end if;
end process;
InstBUFG100 : BUFG
port map ( I => CLK_100,
           O => CLK100);
			  
Inst_ComConfig : ComConfig
generic map (Family     => "Virtex6", -- [Spartan6|Virtex5|Virtex6]
--           ByteWise   : Boolean := true;  -- Full ICAP width (false) or ByteWise reconfiguration (true)
             Mode       => "auto",    -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                      -- bin is for faster binary mode, but might not work on all machines/boards
                                      -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                      -- "1--- ----" is for hex mode, "0--- ----" for bin mode
             ComRate    => 868)      -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
--             ComRate    => 176)      -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
port map ( CLK        => CLK100,
           Rx         => UartRx,
           ReceiveLED => BtnLED(0));

inst_testXOR1 : testXOR
  port map ( CLK        => CLK100,
             I1 => SW(5),
             I2 => SW(4),
             I3 => SW(3),
             I4 => SW(2),
             I5 => SW(1),
             I6 => SW(0),
				 O  => XOR1 );
inst_testXOR2 : testXOR
  port map ( CLK        => CLK100,
             I1 => BTN(0),
             I2 => BTN(1),
             I3 => BTN(2),
             I4 => BTN(3),
             I5 => BTN(4),
             I6 => XOR1,
				 O  => XOR2 );
inst_testXOR3 : testXOR
  port map ( CLK        => CLK100,
             I1 => BTN(0),
             I2 => BTN(1),
             I3 => BTN(2),
             I4 => BTN(3),
             I5 => BTN(4),
             I6 => XOR2,
				 O  => XOR3 );
inst_testXOR4 : testXOR
  port map ( CLK        => CLK100,
             I1 => BTN(0),
             I2 => BTN(1),
             I3 => BTN(2),
             I4 => BTN(3),
             I5 => BTN(4),
             I6 => XOR3,
				 O  => BtnLED(1) );
				 

end Behavioral;

