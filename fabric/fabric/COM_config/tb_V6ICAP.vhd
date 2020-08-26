--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:43:48 03/23/2015
-- Design Name:   
-- Module Name:   C:/work/V6ICAP/tb_V6ICAP.vhd
-- Project Name:  V6ICAP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: V6ICAP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_V6ICAP IS
END tb_V6ICAP;
 
ARCHITECTURE behavior OF tb_V6ICAP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT V6ICAP
    PORT(
         SW : IN  std_logic_vector(7 downto 0);
         Btn : IN  std_logic_vector(4 downto 0);
         BtnLED : OUT  std_logic_vector(4 downto 0);
         LED : OUT  std_logic_vector(7 downto 0);
         SYSCLK_P : IN  std_logic;
         UartRx : IN  std_logic;
         UartTx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SW : std_logic_vector(7 downto 0) := (others => '0');
   signal Btn : std_logic_vector(4 downto 0) := (others => '0');
   signal SYSCLK_P : std_logic := '0';
   signal UartRx : std_logic := '0';

 	--Outputs
   signal BtnLED : std_logic_vector(4 downto 0);
   signal LED : std_logic_vector(7 downto 0);
   signal UartTx : std_logic;
   -- No clocks detected in port list. Replace clock below with 
   -- appropriate port name 
 
   constant clock_period : time := 5 ns;
	
	signal tb_clk_send					: std_logic := '0';
	constant clk_send_period: time := 4.340 us;
--	constant clk_send_period: time := 434 ns;
	signal tb_i : integer;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: V6ICAP PORT MAP (
          SW => SW,
          Btn => Btn,
          BtnLED => BtnLED,
          LED => LED,
          SYSCLK_P => SYSCLK_P,
          UartRx => UartRx,
          UartTx => UartTx
        );

   -- Clock process definitions
   clock_process :process
   begin
		SYSCLK_P <= '0';
		wait for clock_period/2;
		SYSCLK_P <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;
	
tb_clk_send <= NOT tb_clk_send after clk_send_period;
	
tb_data: process (tb_CLK_send)
type characterFile_Typ is file of character;
file f: characterFile_Typ open read_mode is "C:\work\V6ICAP\one_com.bin";
variable c:character;
variable i:integer:=0;
variable next_byte : std_logic_vector(7 downto 0);
begin
  if tb_CLK_send'event AND tb_CLK_send='1' then   -- on negative edge for readability
    if i<=59 then UartRx <='1'; 
    elsif ((i MOD 10)=0) then --start bit position
       IF (NOT endfile(f)) then
          Read( f    => f,
                value=> c);  
          next_byte := CONV_STD_LOGIC_VECTOR(character'pos(c),8);
          UartRx <= '0';     -- we have something to send
       else
          next_byte := b"1111_1111";
          UartRx <= '1';     -- we have nothing to send - so no start bit
       end if;
    elsif ((i MOD 10)=9) then --stop bit position
          UartRx <= '1';
    else                 -- send data bits (LSB first)
          UartRx <= next_byte((i MOD 10)-1);
    end if; -- endfile
    i := i+1;
    tb_i <= i;
end if ; --tb_CLK_send
end process;	

END;
