----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.07.2019 11:13:09
-- Design Name: 
-- Module Name: top - Behavioral
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
use work.my_package.all;

entity top is
    Port ( i1 : in STD_LOGIC;
           i2 : in STD_LOGIC;
           o1 : out STD_LOGIC;
           o2 : in STD_LOGIC);
end top;

architecture Behavioral of top is

begin

inst_MUX4PTv4 : MUX4PTv4
	Port Map(
    IN1  => '0',     
    IN2  => '0',     
    IN3  => '1',     
    IN4  => '0',     
    S1   => i1,
    S2   => i2,
    O    => o1 );
  
end Behavioral;
