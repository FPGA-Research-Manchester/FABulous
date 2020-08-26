library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  N_term_single_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 0 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end entity;

architecture Behavioral of N_term_single_ConfigMem is


begin

-- instantiate frame latches

end architecture;

