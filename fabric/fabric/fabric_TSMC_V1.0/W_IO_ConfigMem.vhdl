library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  W_IO_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 12 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end entity;

architecture Behavioral of W_IO_ConfigMem is

signal frame0 	:	 STD_LOGIC_VECTOR( 12 -1 downto 0);

begin

-- instantiate frame latches
Inst_frame0_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (3) ); 
 
Inst_frame0_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (2) ); 
 
Inst_frame0_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (1) ); 
 
Inst_frame0_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (0) ); 
 
Inst_frame0_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (9) ); 
 
Inst_frame0_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (8) ); 
 
Inst_frame0_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (7) ); 
 
Inst_frame0_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (6) ); 
 
Inst_frame0_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (5) ); 
 
Inst_frame0_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (4) ); 
 
Inst_frame0_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (11) ); 
 
Inst_frame0_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (10) ); 
 

end architecture;

