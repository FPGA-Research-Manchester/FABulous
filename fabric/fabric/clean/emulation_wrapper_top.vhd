----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2019 20:14:36
-- Design Name: 
-- Module Name: emulation_wrapper_top - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity emulation_wrapper_top is
    Port (  LED         : out STD_LOGIC_VECTOR(15 downto 0);
            SW          : in  STD_LOGIC_VECTOR(15 downto 0);
            UART_TXD_IN : in STD_LOGIC;
            clk20a : out STD_LOGIC;
            ReceiveLED : out STD_LOGIC;
            ComActive : out STD_LOGIC;
            PAD	:	inout STD_LOGIC_VECTOR (16 -1 downto 0);
            clk20b : in STD_LOGIC;
            sys_clk_pin : in STD_LOGIC);
end emulation_wrapper_top;

architecture Behavioral of emulation_wrapper_top is

component clk_wiz_0 is 
 Port ( 
         clk_out1 : out STD_LOGIC;
         locked   : out STD_LOGIC;
         clk_in1  : in STD_LOGIC );
end component clk_wiz_0;

component  eFPGA_top  is 
	Port (
	-- External USER ports 
		PAD		:	inout	STD_LOGIC_VECTOR (16 -1 downto 0);	-- these are for Dirk and go to the pad ring
		OPA		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		OPB		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES0	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES1	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES2	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		CLK	    : 	in		STD_LOGIC;							-- This clock can go to the CPU (connects to the fabric LUT output flops
		
	-- CPU configuration port
        WriteStrobe:    in        STD_LOGIC; -- must decode address and write enable
        WriteData:        in        STD_LOGIC_VECTOR (32 -1 downto 0);    -- configuration data write port
            
    -- UART configuration port
        Rx:                in        STD_LOGIC; 
        ComActive:      out STD_LOGIC;
        ReceiveLED:     out STD_LOGIC

		);
end component eFPGA_top ;


signal clk : std_logic;

signal RX : std_logic;

--signal 	PAD	:	STD_LOGIC_VECTOR (16 -1 downto 0) := (others => '0');

signal 	OPA	:	STD_LOGIC_VECTOR (32 -1 downto 0) := (others => '0');
signal 	OPB	:	STD_LOGIC_VECTOR (32 -1 downto 0) := (others => '0');
signal 	RES0 :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	RES1 :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	RES2 :	STD_LOGIC_VECTOR (32 -1 downto 0);

signal 	stim_count  :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	stim_switch :	STD_LOGIC_VECTOR (32 -1 downto 0);

signal count : unsigned (28 downto 0) := (others => '0');

begin

--INST_clk_wiz_0 : clk_wiz_0
--port map( clk_out1 => clk20a,
--          clk_in1  => sys_clk_pin,
--          locked   => open );
          
Inst_BUFG : BUFG 
port map( O => clk,
          I => sys_clk_pin );         

DUT : eFPGA_top
          Port Map(
                  PAD        =>     PAD    ,
                  OPA        =>     OPA    ,
                  OPB        =>     OPB    ,
                  RES0    =>     RES0 ,
                  RES1    =>     RES1 ,
                  RES2    =>     RES2 ,
                  CLK        =>     clk    ,
                  
              -- CPU configuration port
                  WriteStrobe    =>     '0'    ,
                  WriteData    =>     x"00_00_00_00"    ,
                  
                  Rx    =>     UART_TXD_IN ,
                  ComActive  => ComActive,      
                  ReceiveLED => ReceiveLED
   
          );

process(RES0,RES1,RES2,SW)
begin
    case (SW(2 downto 0)) is

        when "000" => LED <= RES0(15 downto 0);
        when "001" => LED <= RES0(31 downto 16);
    
        when "010" => LED <= RES1(15 downto 0);
        when "011" => LED <= RES1(31 downto 16);

        when "100" => LED <= RES2(15 downto 0);
        when "101" => LED <= RES2(31 downto 16);

        when "110" => LED <= std_logic_vector(count(count'high downto count'high-15));
        
        when others => LED <= SW XOR std_logic_vector(count(count'high downto count'high-15));
        
    end case;
end process;

process (clk)
begin
  if clk'event and clk='1' then
    count <= count +1;
  end if;
end process;

stim_switch <= SW(15 downto 8) & SW(15 downto 8) & SW(15 downto 8) & SW(15 downto 8);
stim_count <= std_logic_vector(count(count'high downto count'high-15)) & std_logic_vector(count(count'high downto count'high-15));


OPA <= stim_switch when (SW(4) = '1') else stim_count;
OPB <= stim_switch when (SW(5) = '1') else stim_count;

RX <= UART_TXD_IN XOR SW(6);

end Behavioral;
