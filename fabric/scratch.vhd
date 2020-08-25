ConfigBitsInput <= ConfigBits(ConfigBitsInput'high-1 downto 0) & CONFin; 
     
-- for k in 0 to Conf/2 generate               
L: for k in 0 to 187 generate 
		inst_LHQD1a : LHQD1              
		Port Map(              
		D    => ConfigBitsInput(k*2),              
		E    => CLK,               
		Q    => ConfigBits(k*2) );                 
              
		inst_LHQD1b : LHQD1              
		Port Map(              
		D    => ConfigBitsInput((k*2)+1),
		E    => MODE,
		Q    => ConfigBits((k*2)+1) ); 
end generate; 
        
CONFout <= ConfigBits(ConfigBits'high);  




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  LUT4AB_ConfigMem  is 
  generic ( MaxFramesPerCol : integer := 20;
            FrameBitsPerRow : integer := 32;
			NoConfigBits    : integer := 42 );
  port    (	FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
            FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 ); 
            ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end entity LUT4AB_ConfigMem;

architecture Behavioral of LUT4AB_ConfigMem is	
signal frame00 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
signal frame01 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
signal frame02 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
signal frame03 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
signal frame04 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
signal frame05 : STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );

begin

Lframe00:	for k in 0 to frame00_size-1 generate
				inst_frame00:LHQD1a : LHQD1              
				Port Map(              
				D    => FrameData(k),              
				E    => FrameStrobe(0),               
				Q    => frame00(k)
				);
end generate;

ConfigBits <= frame00(2) & ....;






eFPGA_top													eFPGA_top.vhd
	|
	+---eFPGA												fabric.vhdl
			|		
			+---N_term_single								N_term_single_tile.vhdl
			|		|
			|		+---N_term_single_switch_matrix			N_term_single_switch_matrix.vhdl
			+---W_IO										W_IO_tile.vhdl
			|		|
			|		+---W_IO_ConfigMem						W_IO_ConfigMem.vhdl
			|		|		|
			|		|		+---LHQD1						my_lib.vhd
			|		+---IO_1_bidirectional_frame_config		IO_1_bidirectional_frame_config.vhdl
			|		+---W_IO_switch_matrix					W_IO_switch_matrix.vhdl
			|		 		|
			|		 		+---MUX16PTv2					my_lib.vhd
			|		 		+---MUX4PTv4					my_lib.vhd
			+---LUT4AB										LUT4AB_tile.vhdl
			|		|
			|		+---LUT4AB_ConfigMem					LUT4AB_ConfigMem.vhdl
			|		|		|
			|		|		+---LHQD1						my_lib.vhd
			|		+---LUT4c_frame_config					LUT4c_frame_config.vhdl
			|		|		|
			|		|		+---MUX16PTv2					my_lib.vhd
			|		+---MUX8LUT_frame_config				MUX8LUT_frame_config.vhdl
			|		+---LUT4AB_switch_matrix				LUT4AB_switch_matrix.vhdl
			|		 		|
			|		 		+---MUX16PTv2					my_lib.vhd
			|		 		+---MUX4PTv4					my_lib.vhd
			+---CPU_IO										CPU_IO_tile.vhdl
			|		|
			|		+---CPU_IO_ConfigMem					CPU_IO_ConfigMem.vhdl
			|		|		|
			|		|		+---LHQD1						my_lib.vhd
			|		+---InPass4_frame_config				InPass4_frame_config.vhdl
			|		+---OutPass4_frame_config				OutPass4_frame_config.vhdl
			|		+--CPU_IO_switch_matrix					CPU_IO_switch_matrix.vhdl
			|		 		|
			|		 		+---MUX16PTv2					my_lib.vhd
			|		 		+---MUX4PTv4					my_lib.vhd
			+---S_term_single								S_term_single_tile.vhdl
			|		|
			|		+---N_term_single_switch_matrix			S_term_single_switch_matrix.vhdl
























	