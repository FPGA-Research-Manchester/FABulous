----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.05.2019 19:45:40
-- Design Name: 
-- Module Name: config - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity  MS_conf_cell  is 
	Port (
    S    : in      STD_LOGIC;     -- global signal 1: configuration, 0: operation
    R    : in      STD_LOGIC;
    Mq   : out      STD_LOGIC;
    Mqn  : out      STD_LOGIC;
    Sq   : out      STD_LOGIC;
    Sqn  : out      STD_LOGIC;
    C    : in      STD_LOGIC; 
    Cn   : in      STD_LOGIC ); 
end entity MS_conf_cell ;

architecture Behavioral of  MS_conf_cell  is

signal M_set_gate, M_reset_gate : std_logic := '0';
signal S_set_gate, S_reset_gate : std_logic := '0';
signal M_q, M_qn : std_logic := '0';
signal S_q, S_qn : std_logic := '0';

begin
-- master
M_set_gate   <= S NAND C after 1ps;
M_reset_gate <= R NAND C after 1ps;
M_q    <= M_qn NAND M_set_gate after 1ps;
M_qn   <= M_q  NAND M_reset_gate after 1ps;
-- slave
S_set_gate   <= M_q NAND Cn after 1ps;
S_reset_gate <= M_qn  NAND Cn after 1ps;
S_q    <= S_qn NAND S_set_gate after 1ps;
S_qn   <= S_q  NAND S_reset_gate after 1ps;
--S_q    <= M_set_gate after 100ps;
--S_qn   <= M_reset_gate after 100ps;

-- connect to output
Mq   <= M_q;
Mqn  <= M_qn;
Sq   <= S_q;
Sqn  <= S_qn;
end Behavioral; 
   

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity config is
--  Port ( );
end config;

architecture Behavioral of config is

--component  conf  is 
--	Port (
--	MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
--    CONFin    : in      STD_LOGIC;
--    CONFout    : out      STD_LOGIC;
--    CLK    : in      STD_LOGIC
--);	
 
component  MS_conf_cell  is 
	Port (
    S    : in      STD_LOGIC;     -- global signal 1: configuration, 0: operation
    R    : in      STD_LOGIC;
    Mq   : out      STD_LOGIC;
    Mqn  : out      STD_LOGIC;
    Sq   : out      STD_LOGIC;
    Sqn  : out      STD_LOGIC;
    C    : in      STD_LOGIC; 
    Cn   : in      STD_LOGIC ); 
end component MS_conf_cell ;


signal tb_S : std_logic := '0';
signal tb_R : std_logic := '1';
signal tb_C : std_logic := '0';
signal tb_Cn : std_logic := '1';
signal bitstream : std_logic_vector(5 downto 0) := (others => '0');
signal bitstream_n : std_logic_vector(5 downto 0) := (others => '1');

begin

-- stimulus
tb_C <= NOT tb_C after 5ns;

tb_S <= '1' after 12ns, '0' after 22ns, '1' after 37ns, '0' after 101ns, '1' after 201ns;

---------------------------
tb_Cn <= NOT tb_C;
tb_R <= NOT tb_S;

Inst_first : MS_conf_cell
	Port Map(
	S   => tb_S,
    R   => tb_R,
    Mq  => bitstream(0),
    Mqn => bitstream_n(0),
    Sq  => bitstream(1),
    Sqn => bitstream_n(1),
    C   => tb_C, 
    Cn  => tb_Cn
    ); 

Inst_second : MS_conf_cell
	Port Map(
	S   => bitstream(1),
    R   => bitstream_n(1),
    Mq  => bitstream(2),
    Mqn => bitstream_n(2),
    Sq  => bitstream(3),
    Sqn => bitstream_n(3),
    C   => tb_C, 
    Cn  => tb_Cn
    ); 

Inst_third : MS_conf_cell
	Port Map(
	S   => bitstream(3),
    R   => bitstream_n(3),
    Mq  => bitstream(4),
    Mqn => bitstream_n(4),
    Sq  => bitstream(5),
    Sqn => bitstream_n(5),
    C   => tb_C, 
    Cn  => tb_Cn
    ); 

end Behavioral;
