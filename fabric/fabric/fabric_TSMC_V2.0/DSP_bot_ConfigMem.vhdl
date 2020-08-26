library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  DSP_bot_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 368 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end entity;

architecture Behavioral of DSP_bot_ConfigMem is

signal frame0 	:	 STD_LOGIC_VECTOR( 32 -1 downto 0);
signal frame1 	:	 STD_LOGIC_VECTOR( 32 -1 downto 0);
signal frame2 	:	 STD_LOGIC_VECTOR( 32 -1 downto 0);
signal frame3 	:	 STD_LOGIC_VECTOR( 32 -1 downto 0);
signal frame4 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame5 	:	 STD_LOGIC_VECTOR( 6 -1 downto 0);
signal frame6 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame7 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame8 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame9 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame10 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame11 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame12 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame13 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame14 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame15 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame16 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame17 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame18 	:	 STD_LOGIC_VECTOR( 16 -1 downto 0);
signal frame19 	:	 STD_LOGIC_VECTOR( 10 -1 downto 0);

begin

-- instantiate frame latches
Inst_frame0_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (211) ); 
 
Inst_frame0_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (210) ); 
 
Inst_frame0_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (209) ); 
 
Inst_frame0_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (208) ); 
 
Inst_frame0_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (215) ); 
 
Inst_frame0_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (214) ); 
 
Inst_frame0_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (213) ); 
 
Inst_frame0_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (212) ); 
 
Inst_frame0_bit23  : LHQD1
Port Map (
	 D 	=>	 FrameData(23), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (219) ); 
 
Inst_frame0_bit22  : LHQD1
Port Map (
	 D 	=>	 FrameData(22), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (218) ); 
 
Inst_frame0_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (217) ); 
 
Inst_frame0_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (216) ); 
 
Inst_frame0_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (223) ); 
 
Inst_frame0_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (222) ); 
 
Inst_frame0_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (221) ); 
 
Inst_frame0_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (220) ); 
 
Inst_frame0_bit15  : LHQD1
Port Map (
	 D 	=>	 FrameData(15), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (227) ); 
 
Inst_frame0_bit14  : LHQD1
Port Map (
	 D 	=>	 FrameData(14), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (226) ); 
 
Inst_frame0_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (225) ); 
 
Inst_frame0_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (224) ); 
 
Inst_frame0_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (231) ); 
 
Inst_frame0_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (230) ); 
 
Inst_frame0_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (229) ); 
 
Inst_frame0_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (228) ); 
 
Inst_frame0_bit7  : LHQD1
Port Map (
	 D 	=>	 FrameData(7), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (235) ); 
 
Inst_frame0_bit6  : LHQD1
Port Map (
	 D 	=>	 FrameData(6), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (234) ); 
 
Inst_frame0_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (233) ); 
 
Inst_frame0_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (232) ); 
 
Inst_frame0_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (239) ); 
 
Inst_frame0_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (238) ); 
 
Inst_frame0_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (237) ); 
 
Inst_frame0_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(0), 
	 Q 	=>	 ConfigBits (236) ); 
 
Inst_frame1_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (243) ); 
 
Inst_frame1_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (242) ); 
 
Inst_frame1_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (241) ); 
 
Inst_frame1_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (240) ); 
 
Inst_frame1_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (247) ); 
 
Inst_frame1_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (246) ); 
 
Inst_frame1_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (245) ); 
 
Inst_frame1_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (244) ); 
 
Inst_frame1_bit23  : LHQD1
Port Map (
	 D 	=>	 FrameData(23), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (251) ); 
 
Inst_frame1_bit22  : LHQD1
Port Map (
	 D 	=>	 FrameData(22), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (250) ); 
 
Inst_frame1_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (249) ); 
 
Inst_frame1_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (248) ); 
 
Inst_frame1_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (255) ); 
 
Inst_frame1_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (254) ); 
 
Inst_frame1_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (253) ); 
 
Inst_frame1_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (252) ); 
 
Inst_frame1_bit15  : LHQD1
Port Map (
	 D 	=>	 FrameData(15), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (259) ); 
 
Inst_frame1_bit14  : LHQD1
Port Map (
	 D 	=>	 FrameData(14), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (258) ); 
 
Inst_frame1_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (257) ); 
 
Inst_frame1_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (256) ); 
 
Inst_frame1_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (263) ); 
 
Inst_frame1_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (262) ); 
 
Inst_frame1_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (261) ); 
 
Inst_frame1_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (260) ); 
 
Inst_frame1_bit7  : LHQD1
Port Map (
	 D 	=>	 FrameData(7), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (267) ); 
 
Inst_frame1_bit6  : LHQD1
Port Map (
	 D 	=>	 FrameData(6), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (266) ); 
 
Inst_frame1_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (265) ); 
 
Inst_frame1_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (264) ); 
 
Inst_frame1_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (271) ); 
 
Inst_frame1_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (270) ); 
 
Inst_frame1_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (269) ); 
 
Inst_frame1_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(1), 
	 Q 	=>	 ConfigBits (268) ); 
 
Inst_frame2_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (275) ); 
 
Inst_frame2_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (274) ); 
 
Inst_frame2_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (273) ); 
 
Inst_frame2_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (272) ); 
 
Inst_frame2_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (279) ); 
 
Inst_frame2_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (278) ); 
 
Inst_frame2_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (277) ); 
 
Inst_frame2_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (276) ); 
 
Inst_frame2_bit23  : LHQD1
Port Map (
	 D 	=>	 FrameData(23), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (283) ); 
 
Inst_frame2_bit22  : LHQD1
Port Map (
	 D 	=>	 FrameData(22), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (282) ); 
 
Inst_frame2_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (281) ); 
 
Inst_frame2_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (280) ); 
 
Inst_frame2_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (287) ); 
 
Inst_frame2_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (286) ); 
 
Inst_frame2_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (285) ); 
 
Inst_frame2_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (284) ); 
 
Inst_frame2_bit15  : LHQD1
Port Map (
	 D 	=>	 FrameData(15), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (291) ); 
 
Inst_frame2_bit14  : LHQD1
Port Map (
	 D 	=>	 FrameData(14), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (290) ); 
 
Inst_frame2_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (289) ); 
 
Inst_frame2_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (288) ); 
 
Inst_frame2_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (295) ); 
 
Inst_frame2_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (294) ); 
 
Inst_frame2_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (293) ); 
 
Inst_frame2_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (292) ); 
 
Inst_frame2_bit7  : LHQD1
Port Map (
	 D 	=>	 FrameData(7), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (299) ); 
 
Inst_frame2_bit6  : LHQD1
Port Map (
	 D 	=>	 FrameData(6), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (298) ); 
 
Inst_frame2_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (297) ); 
 
Inst_frame2_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (296) ); 
 
Inst_frame2_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (303) ); 
 
Inst_frame2_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (302) ); 
 
Inst_frame2_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (301) ); 
 
Inst_frame2_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(2), 
	 Q 	=>	 ConfigBits (300) ); 
 
Inst_frame3_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (307) ); 
 
Inst_frame3_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (306) ); 
 
Inst_frame3_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (305) ); 
 
Inst_frame3_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (304) ); 
 
Inst_frame3_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (311) ); 
 
Inst_frame3_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (310) ); 
 
Inst_frame3_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (309) ); 
 
Inst_frame3_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (308) ); 
 
Inst_frame3_bit23  : LHQD1
Port Map (
	 D 	=>	 FrameData(23), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (315) ); 
 
Inst_frame3_bit22  : LHQD1
Port Map (
	 D 	=>	 FrameData(22), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (314) ); 
 
Inst_frame3_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (313) ); 
 
Inst_frame3_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (312) ); 
 
Inst_frame3_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (319) ); 
 
Inst_frame3_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (318) ); 
 
Inst_frame3_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (317) ); 
 
Inst_frame3_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (316) ); 
 
Inst_frame3_bit15  : LHQD1
Port Map (
	 D 	=>	 FrameData(15), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (323) ); 
 
Inst_frame3_bit14  : LHQD1
Port Map (
	 D 	=>	 FrameData(14), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (322) ); 
 
Inst_frame3_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (321) ); 
 
Inst_frame3_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (320) ); 
 
Inst_frame3_bit11  : LHQD1
Port Map (
	 D 	=>	 FrameData(11), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (327) ); 
 
Inst_frame3_bit10  : LHQD1
Port Map (
	 D 	=>	 FrameData(10), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (326) ); 
 
Inst_frame3_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (325) ); 
 
Inst_frame3_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (324) ); 
 
Inst_frame3_bit7  : LHQD1
Port Map (
	 D 	=>	 FrameData(7), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (331) ); 
 
Inst_frame3_bit6  : LHQD1
Port Map (
	 D 	=>	 FrameData(6), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (330) ); 
 
Inst_frame3_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (329) ); 
 
Inst_frame3_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (328) ); 
 
Inst_frame3_bit3  : LHQD1
Port Map (
	 D 	=>	 FrameData(3), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (335) ); 
 
Inst_frame3_bit2  : LHQD1
Port Map (
	 D 	=>	 FrameData(2), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (334) ); 
 
Inst_frame3_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (333) ); 
 
Inst_frame3_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(3), 
	 Q 	=>	 ConfigBits (332) ); 
 
Inst_frame4_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (33) ); 
 
Inst_frame4_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (32) ); 
 
Inst_frame4_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (31) ); 
 
Inst_frame4_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (30) ); 
 
Inst_frame4_bit27  : LHQD1
Port Map (
	 D 	=>	 FrameData(27), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (37) ); 
 
Inst_frame4_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (36) ); 
 
Inst_frame4_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (35) ); 
 
Inst_frame4_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (34) ); 
 
Inst_frame4_bit23  : LHQD1
Port Map (
	 D 	=>	 FrameData(23), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (65) ); 
 
Inst_frame4_bit22  : LHQD1
Port Map (
	 D 	=>	 FrameData(22), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (64) ); 
 
Inst_frame4_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (63) ); 
 
Inst_frame4_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (62) ); 
 
Inst_frame4_bit19  : LHQD1
Port Map (
	 D 	=>	 FrameData(19), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (69) ); 
 
Inst_frame4_bit18  : LHQD1
Port Map (
	 D 	=>	 FrameData(18), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (68) ); 
 
Inst_frame4_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (67) ); 
 
Inst_frame4_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(4), 
	 Q 	=>	 ConfigBits (66) ); 
 
Inst_frame5_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (88) ); 
 
Inst_frame5_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (87) ); 
 
Inst_frame5_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (86) ); 
 
Inst_frame5_bit26  : LHQD1
Port Map (
	 D 	=>	 FrameData(26), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (91) ); 
 
Inst_frame5_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (90) ); 
 
Inst_frame5_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(5), 
	 Q 	=>	 ConfigBits (89) ); 
 
Inst_frame6_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (7) ); 
 
Inst_frame6_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (6) ); 
 
Inst_frame6_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (9) ); 
 
Inst_frame6_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (8) ); 
 
Inst_frame6_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (11) ); 
 
Inst_frame6_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (10) ); 
 
Inst_frame6_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (13) ); 
 
Inst_frame6_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (12) ); 
 
Inst_frame6_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (15) ); 
 
Inst_frame6_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (14) ); 
 
Inst_frame6_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (17) ); 
 
Inst_frame6_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (16) ); 
 
Inst_frame6_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (19) ); 
 
Inst_frame6_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (18) ); 
 
Inst_frame6_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (21) ); 
 
Inst_frame6_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(6), 
	 Q 	=>	 ConfigBits (20) ); 
 
Inst_frame7_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (23) ); 
 
Inst_frame7_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (22) ); 
 
Inst_frame7_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (25) ); 
 
Inst_frame7_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (24) ); 
 
Inst_frame7_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (27) ); 
 
Inst_frame7_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (26) ); 
 
Inst_frame7_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (29) ); 
 
Inst_frame7_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (28) ); 
 
Inst_frame7_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (39) ); 
 
Inst_frame7_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (38) ); 
 
Inst_frame7_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (41) ); 
 
Inst_frame7_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (40) ); 
 
Inst_frame7_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (43) ); 
 
Inst_frame7_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (42) ); 
 
Inst_frame7_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (45) ); 
 
Inst_frame7_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(7), 
	 Q 	=>	 ConfigBits (44) ); 
 
Inst_frame8_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (47) ); 
 
Inst_frame8_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (46) ); 
 
Inst_frame8_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (49) ); 
 
Inst_frame8_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (48) ); 
 
Inst_frame8_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (51) ); 
 
Inst_frame8_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (50) ); 
 
Inst_frame8_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (53) ); 
 
Inst_frame8_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (52) ); 
 
Inst_frame8_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (55) ); 
 
Inst_frame8_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (54) ); 
 
Inst_frame8_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (57) ); 
 
Inst_frame8_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (56) ); 
 
Inst_frame8_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (59) ); 
 
Inst_frame8_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (58) ); 
 
Inst_frame8_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (61) ); 
 
Inst_frame8_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(8), 
	 Q 	=>	 ConfigBits (60) ); 
 
Inst_frame9_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (71) ); 
 
Inst_frame9_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (70) ); 
 
Inst_frame9_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (73) ); 
 
Inst_frame9_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (72) ); 
 
Inst_frame9_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (75) ); 
 
Inst_frame9_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (74) ); 
 
Inst_frame9_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (77) ); 
 
Inst_frame9_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (76) ); 
 
Inst_frame9_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (79) ); 
 
Inst_frame9_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (78) ); 
 
Inst_frame9_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (81) ); 
 
Inst_frame9_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (80) ); 
 
Inst_frame9_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (83) ); 
 
Inst_frame9_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (82) ); 
 
Inst_frame9_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (85) ); 
 
Inst_frame9_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(9), 
	 Q 	=>	 ConfigBits (84) ); 
 
Inst_frame10_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (93) ); 
 
Inst_frame10_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (92) ); 
 
Inst_frame10_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (95) ); 
 
Inst_frame10_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (94) ); 
 
Inst_frame10_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (97) ); 
 
Inst_frame10_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (96) ); 
 
Inst_frame10_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (99) ); 
 
Inst_frame10_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (98) ); 
 
Inst_frame10_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (101) ); 
 
Inst_frame10_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (100) ); 
 
Inst_frame10_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (103) ); 
 
Inst_frame10_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (102) ); 
 
Inst_frame10_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (105) ); 
 
Inst_frame10_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (104) ); 
 
Inst_frame10_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (107) ); 
 
Inst_frame10_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(10), 
	 Q 	=>	 ConfigBits (106) ); 
 
Inst_frame11_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (113) ); 
 
Inst_frame11_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (112) ); 
 
Inst_frame11_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (115) ); 
 
Inst_frame11_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (114) ); 
 
Inst_frame11_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (117) ); 
 
Inst_frame11_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (116) ); 
 
Inst_frame11_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (119) ); 
 
Inst_frame11_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (118) ); 
 
Inst_frame11_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (121) ); 
 
Inst_frame11_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (120) ); 
 
Inst_frame11_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (123) ); 
 
Inst_frame11_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (122) ); 
 
Inst_frame11_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (125) ); 
 
Inst_frame11_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (124) ); 
 
Inst_frame11_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (127) ); 
 
Inst_frame11_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(11), 
	 Q 	=>	 ConfigBits (126) ); 
 
Inst_frame12_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (129) ); 
 
Inst_frame12_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (128) ); 
 
Inst_frame12_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (131) ); 
 
Inst_frame12_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (130) ); 
 
Inst_frame12_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (133) ); 
 
Inst_frame12_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (132) ); 
 
Inst_frame12_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (135) ); 
 
Inst_frame12_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (134) ); 
 
Inst_frame12_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (137) ); 
 
Inst_frame12_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (136) ); 
 
Inst_frame12_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (139) ); 
 
Inst_frame12_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (138) ); 
 
Inst_frame12_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (141) ); 
 
Inst_frame12_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (140) ); 
 
Inst_frame12_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (143) ); 
 
Inst_frame12_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(12), 
	 Q 	=>	 ConfigBits (142) ); 
 
Inst_frame13_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (145) ); 
 
Inst_frame13_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (144) ); 
 
Inst_frame13_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (147) ); 
 
Inst_frame13_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (146) ); 
 
Inst_frame13_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (149) ); 
 
Inst_frame13_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (148) ); 
 
Inst_frame13_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (151) ); 
 
Inst_frame13_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (150) ); 
 
Inst_frame13_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (153) ); 
 
Inst_frame13_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (152) ); 
 
Inst_frame13_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (155) ); 
 
Inst_frame13_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (154) ); 
 
Inst_frame13_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (157) ); 
 
Inst_frame13_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (156) ); 
 
Inst_frame13_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (159) ); 
 
Inst_frame13_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(13), 
	 Q 	=>	 ConfigBits (158) ); 
 
Inst_frame14_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (161) ); 
 
Inst_frame14_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (160) ); 
 
Inst_frame14_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (163) ); 
 
Inst_frame14_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (162) ); 
 
Inst_frame14_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (165) ); 
 
Inst_frame14_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (164) ); 
 
Inst_frame14_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (167) ); 
 
Inst_frame14_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (166) ); 
 
Inst_frame14_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (169) ); 
 
Inst_frame14_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (168) ); 
 
Inst_frame14_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (171) ); 
 
Inst_frame14_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (170) ); 
 
Inst_frame14_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (173) ); 
 
Inst_frame14_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (172) ); 
 
Inst_frame14_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (175) ); 
 
Inst_frame14_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(14), 
	 Q 	=>	 ConfigBits (174) ); 
 
Inst_frame15_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (177) ); 
 
Inst_frame15_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (176) ); 
 
Inst_frame15_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (179) ); 
 
Inst_frame15_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (178) ); 
 
Inst_frame15_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (181) ); 
 
Inst_frame15_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (180) ); 
 
Inst_frame15_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (183) ); 
 
Inst_frame15_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (182) ); 
 
Inst_frame15_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (185) ); 
 
Inst_frame15_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (184) ); 
 
Inst_frame15_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (187) ); 
 
Inst_frame15_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (186) ); 
 
Inst_frame15_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (189) ); 
 
Inst_frame15_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (188) ); 
 
Inst_frame15_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (191) ); 
 
Inst_frame15_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(15), 
	 Q 	=>	 ConfigBits (190) ); 
 
Inst_frame16_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (193) ); 
 
Inst_frame16_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (192) ); 
 
Inst_frame16_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (195) ); 
 
Inst_frame16_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (194) ); 
 
Inst_frame16_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (197) ); 
 
Inst_frame16_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (196) ); 
 
Inst_frame16_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (199) ); 
 
Inst_frame16_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (198) ); 
 
Inst_frame16_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (201) ); 
 
Inst_frame16_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (200) ); 
 
Inst_frame16_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (203) ); 
 
Inst_frame16_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (202) ); 
 
Inst_frame16_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (205) ); 
 
Inst_frame16_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (204) ); 
 
Inst_frame16_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (207) ); 
 
Inst_frame16_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(16), 
	 Q 	=>	 ConfigBits (206) ); 
 
Inst_frame17_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (337) ); 
 
Inst_frame17_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (336) ); 
 
Inst_frame17_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (339) ); 
 
Inst_frame17_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (338) ); 
 
Inst_frame17_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (341) ); 
 
Inst_frame17_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (340) ); 
 
Inst_frame17_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (343) ); 
 
Inst_frame17_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (342) ); 
 
Inst_frame17_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (345) ); 
 
Inst_frame17_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (344) ); 
 
Inst_frame17_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (347) ); 
 
Inst_frame17_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (346) ); 
 
Inst_frame17_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (349) ); 
 
Inst_frame17_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (348) ); 
 
Inst_frame17_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (351) ); 
 
Inst_frame17_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(17), 
	 Q 	=>	 ConfigBits (350) ); 
 
Inst_frame18_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (353) ); 
 
Inst_frame18_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (352) ); 
 
Inst_frame18_bit25  : LHQD1
Port Map (
	 D 	=>	 FrameData(25), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (355) ); 
 
Inst_frame18_bit24  : LHQD1
Port Map (
	 D 	=>	 FrameData(24), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (354) ); 
 
Inst_frame18_bit21  : LHQD1
Port Map (
	 D 	=>	 FrameData(21), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (357) ); 
 
Inst_frame18_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (356) ); 
 
Inst_frame18_bit17  : LHQD1
Port Map (
	 D 	=>	 FrameData(17), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (359) ); 
 
Inst_frame18_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (358) ); 
 
Inst_frame18_bit13  : LHQD1
Port Map (
	 D 	=>	 FrameData(13), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (361) ); 
 
Inst_frame18_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (360) ); 
 
Inst_frame18_bit9  : LHQD1
Port Map (
	 D 	=>	 FrameData(9), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (363) ); 
 
Inst_frame18_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (362) ); 
 
Inst_frame18_bit5  : LHQD1
Port Map (
	 D 	=>	 FrameData(5), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (365) ); 
 
Inst_frame18_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (364) ); 
 
Inst_frame18_bit1  : LHQD1
Port Map (
	 D 	=>	 FrameData(1), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (367) ); 
 
Inst_frame18_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(18), 
	 Q 	=>	 ConfigBits (366) ); 
 
Inst_frame19_bit31  : LHQD1
Port Map (
	 D 	=>	 FrameData(31), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (111) ); 
 
Inst_frame19_bit30  : LHQD1
Port Map (
	 D 	=>	 FrameData(30), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (110) ); 
 
Inst_frame19_bit29  : LHQD1
Port Map (
	 D 	=>	 FrameData(29), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (109) ); 
 
Inst_frame19_bit28  : LHQD1
Port Map (
	 D 	=>	 FrameData(28), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (108) ); 
 
Inst_frame19_bit20  : LHQD1
Port Map (
	 D 	=>	 FrameData(20), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (5) ); 
 
Inst_frame19_bit16  : LHQD1
Port Map (
	 D 	=>	 FrameData(16), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (4) ); 
 
Inst_frame19_bit12  : LHQD1
Port Map (
	 D 	=>	 FrameData(12), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (3) ); 
 
Inst_frame19_bit8  : LHQD1
Port Map (
	 D 	=>	 FrameData(8), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (2) ); 
 
Inst_frame19_bit4  : LHQD1
Port Map (
	 D 	=>	 FrameData(4), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (1) ); 
 
Inst_frame19_bit0  : LHQD1
Port Map (
	 D 	=>	 FrameData(0), 
	 E 	=>	 FrameStrobe(19), 
	 Q 	=>	 ConfigBits (0) ); 
 

end architecture;

