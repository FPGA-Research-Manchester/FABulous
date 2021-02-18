library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  CPU_IO  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 20 );
	Port (
	--  NORTH
	--  EAST
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:NULL destination_name:E1END  
		 E2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2MID  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:NULL destination_name:E2END  
		 E6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:NULL destination_name:E6END  
	--  SOUTH
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:NULL  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:NULL  
		 W2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:NULL  
		 W6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:NULL  
	-- Tile IO ports from BELs
		 OPA_I0	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I1	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I2	: in	STD_LOGIC; -- EXTERNAL
		 OPA_I3	: in	STD_LOGIC; -- EXTERNAL
		 UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
		 OPB_I0	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I1	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I2	: in	STD_LOGIC; -- EXTERNAL
		 OPB_I3	: in	STD_LOGIC; -- EXTERNAL
		 RES0_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES0_O3	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES1_O3	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O0	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O1	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O2	: out	STD_LOGIC; -- EXTERNAL
		 RES2_O3	: out	STD_LOGIC; -- EXTERNAL
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );   -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 )    -- CONFIG_PORT this is a keyword needed to connect the tile to the bitstream frame register 

	-- global
	);
end entity CPU_IO ;

architecture Behavioral of  CPU_IO  is 

component InPass4_frame_config is
    Generic ( NoConfigBits : integer := 4 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port ( 
	-- Pin0
	I0	: in	STD_LOGIC; -- EXTERNAL
	I1	: in	STD_LOGIC; -- EXTERNAL
	I2	: in	STD_LOGIC; -- EXTERNAL
	I3	: in	STD_LOGIC; -- EXTERNAL
	O0	: out	STD_LOGIC; 
	O1	: out	STD_LOGIC; 
	O2	: out	STD_LOGIC; 
	O3	: out	STD_LOGIC; 
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component InPass4_frame_config;

component OutPass4_frame_config is
    Generic ( NoConfigBits : integer := 4 );	-- has to be adjusted manually (we don't use an arithmetic parser for the value)
    Port ( 
	-- Pin0
	I0	: in	STD_LOGIC; 
	I1	: in	STD_LOGIC; 
	I2	: in	STD_LOGIC; 
	I3	: in	STD_LOGIC; 
	O0	: out	STD_LOGIC; -- EXTERNAL
	O1	: out	STD_LOGIC; -- EXTERNAL
	O2	: out	STD_LOGIC; -- EXTERNAL
	O3	: out	STD_LOGIC; -- EXTERNAL
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end component OutPass4_frame_config;


component  CPU_IO_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 0 );
	Port (
		 -- switch matrix inputs
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2MID0 	: in 	 STD_LOGIC;
		  E2MID1 	: in 	 STD_LOGIC;
		  E2MID2 	: in 	 STD_LOGIC;
		  E2MID3 	: in 	 STD_LOGIC;
		  E2MID4 	: in 	 STD_LOGIC;
		  E2MID5 	: in 	 STD_LOGIC;
		  E2MID6 	: in 	 STD_LOGIC;
		  E2MID7 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  E2END4 	: in 	 STD_LOGIC;
		  E2END5 	: in 	 STD_LOGIC;
		  E2END6 	: in 	 STD_LOGIC;
		  E2END7 	: in 	 STD_LOGIC;
		  E6END0 	: in 	 STD_LOGIC;
		  E6END1 	: in 	 STD_LOGIC;
		  E6END2 	: in 	 STD_LOGIC;
		  E6END3 	: in 	 STD_LOGIC;
		  E6END4 	: in 	 STD_LOGIC;
		  E6END5 	: in 	 STD_LOGIC;
		  E6END6 	: in 	 STD_LOGIC;
		  E6END7 	: in 	 STD_LOGIC;
		  E6END8 	: in 	 STD_LOGIC;
		  E6END9 	: in 	 STD_LOGIC;
		  E6END10 	: in 	 STD_LOGIC;
		  E6END11 	: in 	 STD_LOGIC;
		  OPA_O0 	: in 	 STD_LOGIC;
		  OPA_O1 	: in 	 STD_LOGIC;
		  OPA_O2 	: in 	 STD_LOGIC;
		  OPA_O3 	: in 	 STD_LOGIC;
		  OPB_O0 	: in 	 STD_LOGIC;
		  OPB_O1 	: in 	 STD_LOGIC;
		  OPB_O2 	: in 	 STD_LOGIC;
		  OPB_O3 	: in 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  W2BEG6 	: out 	 STD_LOGIC;
		  W2BEG7 	: out 	 STD_LOGIC;
		  W2BEGb0 	: out 	 STD_LOGIC;
		  W2BEGb1 	: out 	 STD_LOGIC;
		  W2BEGb2 	: out 	 STD_LOGIC;
		  W2BEGb3 	: out 	 STD_LOGIC;
		  W2BEGb4 	: out 	 STD_LOGIC;
		  W2BEGb5 	: out 	 STD_LOGIC;
		  W2BEGb6 	: out 	 STD_LOGIC;
		  W2BEGb7 	: out 	 STD_LOGIC;
		  W6BEG0 	: out 	 STD_LOGIC;
		  W6BEG1 	: out 	 STD_LOGIC;
		  W6BEG2 	: out 	 STD_LOGIC;
		  W6BEG3 	: out 	 STD_LOGIC;
		  W6BEG4 	: out 	 STD_LOGIC;
		  W6BEG5 	: out 	 STD_LOGIC;
		  W6BEG6 	: out 	 STD_LOGIC;
		  W6BEG7 	: out 	 STD_LOGIC;
		  W6BEG8 	: out 	 STD_LOGIC;
		  W6BEG9 	: out 	 STD_LOGIC;
		  W6BEG10 	: out 	 STD_LOGIC;
		  W6BEG11 	: out 	 STD_LOGIC;
		  RES0_I0 	: out 	 STD_LOGIC;
		  RES0_I1 	: out 	 STD_LOGIC;
		  RES0_I2 	: out 	 STD_LOGIC;
		  RES0_I3 	: out 	 STD_LOGIC;
		  RES1_I0 	: out 	 STD_LOGIC;
		  RES1_I1 	: out 	 STD_LOGIC;
		  RES1_I2 	: out 	 STD_LOGIC;
		  RES1_I3 	: out 	 STD_LOGIC;
		  RES2_I0 	: out 	 STD_LOGIC;
		  RES2_I1 	: out 	 STD_LOGIC;
		  RES2_I2 	: out 	 STD_LOGIC;
		  RES2_I3 	: out 	 STD_LOGIC 

	-- global
	);
end component CPU_IO_switch_matrix ;


component  CPU_IO_ConfigMem  is 
	Generic ( 
			 MaxFramesPerCol : integer := 20;
			 FrameBitsPerRow : integer := 32;
			 NoConfigBits : integer := 20 );
	Port (
		 FrameData:     in  STD_LOGIC_VECTOR( FrameBitsPerRow -1 downto 0 );
		 FrameStrobe:   in  STD_LOGIC_VECTOR( MaxFramesPerCol -1 downto 0 );
		 ConfigBits :   out STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
		 );
end component;

-- signal declarations

-- BEL ports (e.g., slices)
signal	RES0_I0	:STD_LOGIC;
signal	RES0_I1	:STD_LOGIC;
signal	RES0_I2	:STD_LOGIC;
signal	RES0_I3	:STD_LOGIC;
signal	RES1_I0	:STD_LOGIC;
signal	RES1_I1	:STD_LOGIC;
signal	RES1_I2	:STD_LOGIC;
signal	RES1_I3	:STD_LOGIC;
signal	RES2_I0	:STD_LOGIC;
signal	RES2_I1	:STD_LOGIC;
signal	RES2_I2	:STD_LOGIC;
signal	RES2_I3	:STD_LOGIC;
signal	OPA_O0	:STD_LOGIC;
signal	OPA_O1	:STD_LOGIC;
signal	OPA_O2	:STD_LOGIC;
signal	OPA_O3	:STD_LOGIC;
signal	OPB_O0	:STD_LOGIC;
signal	OPB_O1	:STD_LOGIC;
signal	OPB_O2	:STD_LOGIC;
signal	OPB_O3	:STD_LOGIC;
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	 STD_LOGIC_VECTOR(5 downto 0);
signal 	 ConfigBits :	 STD_LOGIC_VECTOR (NoConfigBits -1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile

-- configuration storage latches
Inst_CPU_IO_ConfigMem : CPU_IO_ConfigMem
	Port Map( 
		 FrameData  	 =>	 FrameData, 
		 FrameStrobe 	 =>	 FrameStrobe, 
		 ConfigBits 	 =>	 ConfigBits  );

-- BEL component instantiations

Inst_OPA_InPass4_frame_config : InPass4_frame_config
	Port Map(
		 O0  =>  OPA_O0 ,
		 O1  =>  OPA_O1 ,
		 O2  =>  OPA_O2 ,
		 O3  =>  OPA_O3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 I0  => OPA_I0 ,
		 I1  => OPA_I1 ,
		 I2  => OPA_I2 ,
		 I3  => OPA_I3 ,
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 4 -1 downto 0 ) );

Inst_OPB_InPass4_frame_config : InPass4_frame_config
	Port Map(
		 O0  =>  OPB_O0 ,
		 O1  =>  OPB_O1 ,
		 O2  =>  OPB_O2 ,
		 O3  =>  OPB_O3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 I0  => OPB_I0 ,
		 I1  => OPB_I1 ,
		 I2  => OPB_I2 ,
		 I3  => OPB_I3 ,
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 8 -1 downto 4 ) );

Inst_RES0_OutPass4_frame_config : OutPass4_frame_config
	Port Map(
		 I0  =>  RES0_I0 ,
		 I1  =>  RES0_I1 ,
		 I2  =>  RES0_I2 ,
		 I3  =>  RES0_I3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 O0  => RES0_O0 ,
		 O1  => RES0_O1 ,
		 O2  => RES0_O2 ,
		 O3  => RES0_O3 ,
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 12 -1 downto 8 ) );

Inst_RES1_OutPass4_frame_config : OutPass4_frame_config
	Port Map(
		 I0  =>  RES1_I0 ,
		 I1  =>  RES1_I1 ,
		 I2  =>  RES1_I2 ,
		 I3  =>  RES1_I3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 O0  => RES1_O0 ,
		 O1  => RES1_O1 ,
		 O2  => RES1_O2 ,
		 O3  => RES1_O3 ,
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 16 -1 downto 12 ) );

Inst_RES2_OutPass4_frame_config : OutPass4_frame_config
	Port Map(
		 I0  =>  RES2_I0 ,
		 I1  =>  RES2_I1 ,
		 I2  =>  RES2_I2 ,
		 I3  =>  RES2_I3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 O0  => RES2_O0 ,
		 O1  => RES2_O1 ,
		 O2  => RES2_O2 ,
		 O3  => RES2_O3 ,
		 UserCLK  => UserCLK ,
		 ConfigBits => ConfigBits ( 20 -1 downto 16 ) );


-- switch matrix component instantiation

Inst_CPU_IO_switch_matrix : CPU_IO_switch_matrix
	Port Map(
		 E1END0  => E1END(0),
		 E1END1  => E1END(1),
		 E1END2  => E1END(2),
		 E1END3  => E1END(3),
		 E2MID0  => E2MID(0),
		 E2MID1  => E2MID(1),
		 E2MID2  => E2MID(2),
		 E2MID3  => E2MID(3),
		 E2MID4  => E2MID(4),
		 E2MID5  => E2MID(5),
		 E2MID6  => E2MID(6),
		 E2MID7  => E2MID(7),
		 E2END0  => E2END(0),
		 E2END1  => E2END(1),
		 E2END2  => E2END(2),
		 E2END3  => E2END(3),
		 E2END4  => E2END(4),
		 E2END5  => E2END(5),
		 E2END6  => E2END(6),
		 E2END7  => E2END(7),
		 E6END0  => E6END(0),
		 E6END1  => E6END(1),
		 E6END2  => E6END(2),
		 E6END3  => E6END(3),
		 E6END4  => E6END(4),
		 E6END5  => E6END(5),
		 E6END6  => E6END(6),
		 E6END7  => E6END(7),
		 E6END8  => E6END(8),
		 E6END9  => E6END(9),
		 E6END10  => E6END(10),
		 E6END11  => E6END(11),
		 OPA_O0  => OPA_O0,
		 OPA_O1  => OPA_O1,
		 OPA_O2  => OPA_O2,
		 OPA_O3  => OPA_O3,
		 OPB_O0  => OPB_O0,
		 OPB_O1  => OPB_O1,
		 OPB_O2  => OPB_O2,
		 OPB_O3  => OPB_O3,
		 W1BEG0  => W1BEG(0),
		 W1BEG1  => W1BEG(1),
		 W1BEG2  => W1BEG(2),
		 W1BEG3  => W1BEG(3),
		 W2BEG0  => W2BEG(0),
		 W2BEG1  => W2BEG(1),
		 W2BEG2  => W2BEG(2),
		 W2BEG3  => W2BEG(3),
		 W2BEG4  => W2BEG(4),
		 W2BEG5  => W2BEG(5),
		 W2BEG6  => W2BEG(6),
		 W2BEG7  => W2BEG(7),
		 W2BEGb0  => W2BEGb(0),
		 W2BEGb1  => W2BEGb(1),
		 W2BEGb2  => W2BEGb(2),
		 W2BEGb3  => W2BEGb(3),
		 W2BEGb4  => W2BEGb(4),
		 W2BEGb5  => W2BEGb(5),
		 W2BEGb6  => W2BEGb(6),
		 W2BEGb7  => W2BEGb(7),
		 W6BEG0  => W6BEG(0),
		 W6BEG1  => W6BEG(1),
		 W6BEG2  => W6BEG(2),
		 W6BEG3  => W6BEG(3),
		 W6BEG4  => W6BEG(4),
		 W6BEG5  => W6BEG(5),
		 W6BEG6  => W6BEG(6),
		 W6BEG7  => W6BEG(7),
		 W6BEG8  => W6BEG(8),
		 W6BEG9  => W6BEG(9),
		 W6BEG10  => W6BEG(10),
		 W6BEG11  => W6BEG(11),
		 RES0_I0  => RES0_I0,
		 RES0_I1  => RES0_I1,
		 RES0_I2  => RES0_I2,
		 RES0_I3  => RES0_I3,
		 RES1_I0  => RES1_I0,
		 RES1_I1  => RES1_I1,
		 RES1_I2  => RES1_I2,
		 RES1_I3  => RES1_I3,
		 RES2_I0  => RES2_I0,
		 RES2_I1  => RES2_I1,
		 RES2_I2  => RES2_I2,
		 RES2_I3  => RES2_I3		 );  

end Behavioral;

