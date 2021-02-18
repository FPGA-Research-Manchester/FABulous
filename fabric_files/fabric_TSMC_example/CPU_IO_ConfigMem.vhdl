library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  CPU_IO_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 20 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end entity;

architecture Behavioral of CPU_IO_ConfigMem is

signal frame0 	:	 STD_LOGIC_VECTOR( 8 -1 downto 0);
signal frame1 	:	 STD_LOGIC_VECTOR( 12 -1 downto 0);

begin

-- instantiate frame latches
Inst_frame0_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (3) ); 
 
Inst_frame0_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (2) ); 
 
Inst_frame0_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (1) ); 
 
Inst_frame0_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (0) ); 
 
Inst_frame0_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (7) ); 
 
Inst_frame0_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (6) ); 
 
Inst_frame0_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (5) ); 
 
Inst_frame0_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (4) ); 
 
Inst_frame1_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (19) ); 
 
Inst_frame1_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (18) ); 
 
Inst_frame1_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (17) ); 
 
Inst_frame1_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (16) ); 
 
Inst_frame1_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (15) ); 
 
Inst_frame1_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (14) ); 
 
Inst_frame1_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (13) ); 
 
Inst_frame1_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (12) ); 
 
Inst_frame1_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (11) ); 
 
Inst_frame1_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (10) ); 
 
Inst_frame1_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (9) ); 
 
Inst_frame1_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (8) ); 
 

end architecture;

