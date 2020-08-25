library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  IO  is 
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 2 downto 0 );	 -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destination_name:N2END  
		 N1END 	: in 	STD_LOGIC_VECTOR( 2 downto 0 );	 -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2END 	: in 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destination_name:N2END  
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destination_name:E2END  
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destination_name:E2END  
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 4 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destination_name:S2END  
		 S1END 	: in 	STD_LOGIC_VECTOR( 4 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2END 	: in 	STD_LOGIC_VECTOR( 9 downto 0 );	 -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destination_name:S2END  
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG destination_name:W2END  
		 W1END 	: in 	STD_LOGIC_VECTOR( 5 downto 0 );	 -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG destination_name:W2END  
	-- Tile IO ports from BELs
	 	PAD0: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	 	PAD1: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	 	PAD2: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	 	PAD3: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity IO ;

architecture Behavioral of  IO  is 

component IO_4_bidirectional is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	I0	: in	STD_LOGIC; -- from fabric to external pin
	T0	: in	STD_LOGIC; -- tristate control
	O0	: out	STD_LOGIC; -- from external pin to fabric
	Q0	: out	STD_LOGIC; -- from external pin to fabric (registered)
	PAD0: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	-- Pin1
	I1	: in	STD_LOGIC; -- from fabric to external pin
    T1	: in    STD_LOGIC; -- tristate control
    O1	: out    STD_LOGIC; -- from external pin to fabric
    Q1	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD1: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	-- Pin2
	I2	: in	STD_LOGIC; -- from fabric to external pin
    T2	: in    STD_LOGIC; -- tristate control
    O2	: out    STD_LOGIC; -- from external pin to fabric
    Q2	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD2: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	-- Pin3
	I3	: in	STD_LOGIC; -- from fabric to external pin
    T3	: in    STD_LOGIC; -- tristate control
    O3	: out    STD_LOGIC; -- from external pin to fabric
    Q3	: out    STD_LOGIC; -- from external pin to fabric (registered)
	PAD3: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end component IO_4_bidirectional;


component  IO_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  S1END0 	: in 	 STD_LOGIC;
		  S1END1 	: in 	 STD_LOGIC;
		  S1END2 	: in 	 STD_LOGIC;
		  S1END3 	: in 	 STD_LOGIC;
		  S1END4 	: in 	 STD_LOGIC;
		  S2END0 	: in 	 STD_LOGIC;
		  S2END1 	: in 	 STD_LOGIC;
		  S2END2 	: in 	 STD_LOGIC;
		  S2END3 	: in 	 STD_LOGIC;
		  S2END4 	: in 	 STD_LOGIC;
		  W1END0 	: in 	 STD_LOGIC;
		  W1END1 	: in 	 STD_LOGIC;
		  W1END2 	: in 	 STD_LOGIC;
		  W1END3 	: in 	 STD_LOGIC;
		  W1END4 	: in 	 STD_LOGIC;
		  W1END5 	: in 	 STD_LOGIC;
		  W2END0 	: in 	 STD_LOGIC;
		  W2END1 	: in 	 STD_LOGIC;
		  W2END2 	: in 	 STD_LOGIC;
		  W2END3 	: in 	 STD_LOGIC;
		  W2END4 	: in 	 STD_LOGIC;
		  W2END5 	: in 	 STD_LOGIC;
		  O0 	: in 	 STD_LOGIC;
		  Q0 	: in 	 STD_LOGIC;
		  O1 	: in 	 STD_LOGIC;
		  Q1 	: in 	 STD_LOGIC;
		  O2 	: in 	 STD_LOGIC;
		  Q2 	: in 	 STD_LOGIC;
		  O3 	: in 	 STD_LOGIC;
		  Q3 	: in 	 STD_LOGIC;
		  IJ_END0 	: in 	 STD_LOGIC;
		  IJ_END1 	: in 	 STD_LOGIC;
		  IJ_END2 	: in 	 STD_LOGIC;
		  IJ_END3 	: in 	 STD_LOGIC;
		  IJ_END4 	: in 	 STD_LOGIC;
		  IJ_END5 	: in 	 STD_LOGIC;
		  IJ_END6 	: in 	 STD_LOGIC;
		  IJ_END7 	: in 	 STD_LOGIC;
		  IJ_END8 	: in 	 STD_LOGIC;
		  IJ_END9 	: in 	 STD_LOGIC;
		  IJ_END10 	: in 	 STD_LOGIC;
		  IJ_END11 	: in 	 STD_LOGIC;
		  IJ_END12 	: in 	 STD_LOGIC;
		  OJ_END0 	: in 	 STD_LOGIC;
		  OJ_END1 	: in 	 STD_LOGIC;
		  OJ_END2 	: in 	 STD_LOGIC;
		  OJ_END3 	: in 	 STD_LOGIC;
		  OJ_END4 	: in 	 STD_LOGIC;
		  OJ_END5 	: in 	 STD_LOGIC;
		  OJ_END6 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
		  S1BEG0 	: out 	 STD_LOGIC;
		  S1BEG1 	: out 	 STD_LOGIC;
		  S1BEG2 	: out 	 STD_LOGIC;
		  S1BEG3 	: out 	 STD_LOGIC;
		  S1BEG4 	: out 	 STD_LOGIC;
		  S2BEG0 	: out 	 STD_LOGIC;
		  S2BEG1 	: out 	 STD_LOGIC;
		  S2BEG2 	: out 	 STD_LOGIC;
		  S2BEG3 	: out 	 STD_LOGIC;
		  S2BEG4 	: out 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W1BEG4 	: out 	 STD_LOGIC;
		  W1BEG5 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  I0 	: out 	 STD_LOGIC;
		  T0 	: out 	 STD_LOGIC;
		  I1 	: out 	 STD_LOGIC;
		  T1 	: out 	 STD_LOGIC;
		  I2 	: out 	 STD_LOGIC;
		  T2 	: out 	 STD_LOGIC;
		  I3 	: out 	 STD_LOGIC;
		  T3 	: out 	 STD_LOGIC;
		  IJ_BEG0 	: out 	 STD_LOGIC;
		  IJ_BEG1 	: out 	 STD_LOGIC;
		  IJ_BEG2 	: out 	 STD_LOGIC;
		  IJ_BEG3 	: out 	 STD_LOGIC;
		  IJ_BEG4 	: out 	 STD_LOGIC;
		  IJ_BEG5 	: out 	 STD_LOGIC;
		  IJ_BEG6 	: out 	 STD_LOGIC;
		  IJ_BEG7 	: out 	 STD_LOGIC;
		  IJ_BEG8 	: out 	 STD_LOGIC;
		  IJ_BEG9 	: out 	 STD_LOGIC;
		  IJ_BEG10 	: out 	 STD_LOGIC;
		  IJ_BEG11 	: out 	 STD_LOGIC;
		  IJ_BEG12 	: out 	 STD_LOGIC;
		  OJ_BEG0 	: out 	 STD_LOGIC;
		  OJ_BEG1 	: out 	 STD_LOGIC;
		  OJ_BEG2 	: out 	 STD_LOGIC;
		  OJ_BEG3 	: out 	 STD_LOGIC;
		  OJ_BEG4 	: out 	 STD_LOGIC;
		  OJ_BEG5 	: out 	 STD_LOGIC;
		  OJ_BEG6 	: out 	 STD_LOGIC
	-- global
	);
end component IO_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
signal	I0	:STD_LOGIC;
signal	T0	:STD_LOGIC;
signal	I1	:STD_LOGIC;
signal	T1	:STD_LOGIC;
signal	I2	:STD_LOGIC;
signal	T2	:STD_LOGIC;
signal	I3	:STD_LOGIC;
signal	T3	:STD_LOGIC;
signal	O0	:STD_LOGIC;
signal	Q0	:STD_LOGIC;
signal	O1	:STD_LOGIC;
signal	Q1	:STD_LOGIC;
signal	O2	:STD_LOGIC;
signal	Q2	:STD_LOGIC;
signal	O3	:STD_LOGIC;
signal	Q3	:STD_LOGIC;
-- jump wires
signal	 IJ_BEG 	:	STD_LOGIC_VECTOR(13 downto 0);
signal	 OJ_BEG 	:	STD_LOGIC_VECTOR(7 downto 0);
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	STD_LOGIC_VECTOR(1 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
N2BEG(N2BEG'high - 3 downto 0) <= N2END(N2END'high downto 3);
E2BEG(E2BEG'high - 4 downto 0) <= E2END(E2END'high downto 4);
S2BEG(S2BEG'high - 5 downto 0) <= S2END(S2END'high downto 5);
W2BEG(W2BEG'high - 6 downto 0) <= W2END(W2END'high downto 6);
-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity

-- BEL component instantiations

Inst_IO_4_bidirectional : IO_4_bidirectional
	Port Map(
		 I0  =>  I0 ,
		 T0  =>  T0 ,
		 I1  =>  I1 ,
		 T1  =>  T1 ,
		 I2  =>  I2 ,
		 T2  =>  T2 ,
		 I3  =>  I3 ,
		 T3  =>  T3 ,
		 O0  =>  O0 ,
		 Q0  =>  Q0 ,
		 O1  =>  O1 ,
		 Q1  =>  Q1 ,
		 O2  =>  O2 ,
		 Q2  =>  Q2 ,
		 O3  =>  O3 ,
		 Q3  =>  Q3 ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 PAD0  =>  PAD0 ,
		 PAD1  =>  PAD1 ,
		 PAD2  =>  PAD2 ,
		 PAD3  =>  PAD3 ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(0),  
		 CONFout	=> conf_data(1),  
		 CLK => CLK );  


-- switch matrix component instantiation

Inst_IO_switch_matrix : IO_switch_matrix
	Port Map(
		 N1END0  => N1END(0),
		 N1END1  => N1END(1),
		 N1END2  => N1END(2),
		 N2END0  => N2END(0),
		 N2END1  => N2END(1),
		 N2END2  => N2END(2),
		 E1END0  => E1END(0),
		 E1END1  => E1END(1),
		 E1END2  => E1END(2),
		 E1END3  => E1END(3),
		 E2END0  => E2END(0),
		 E2END1  => E2END(1),
		 E2END2  => E2END(2),
		 E2END3  => E2END(3),
		 S1END0  => S1END(0),
		 S1END1  => S1END(1),
		 S1END2  => S1END(2),
		 S1END3  => S1END(3),
		 S1END4  => S1END(4),
		 S2END0  => S2END(0),
		 S2END1  => S2END(1),
		 S2END2  => S2END(2),
		 S2END3  => S2END(3),
		 S2END4  => S2END(4),
		 W1END0  => W1END(0),
		 W1END1  => W1END(1),
		 W1END2  => W1END(2),
		 W1END3  => W1END(3),
		 W1END4  => W1END(4),
		 W1END5  => W1END(5),
		 W2END0  => W2END(0),
		 W2END1  => W2END(1),
		 W2END2  => W2END(2),
		 W2END3  => W2END(3),
		 W2END4  => W2END(4),
		 W2END5  => W2END(5),
		 O0  => O0,
		 Q0  => Q0,
		 O1  => O1,
		 Q1  => Q1,
		 O2  => O2,
		 Q2  => Q2,
		 O3  => O3,
		 Q3  => Q3,
		 IJ_END0  => IJ_BEG(0),
		 IJ_END1  => IJ_BEG(1),
		 IJ_END2  => IJ_BEG(2),
		 IJ_END3  => IJ_BEG(3),
		 IJ_END4  => IJ_BEG(4),
		 IJ_END5  => IJ_BEG(5),
		 IJ_END6  => IJ_BEG(6),
		 IJ_END7  => IJ_BEG(7),
		 IJ_END8  => IJ_BEG(8),
		 IJ_END9  => IJ_BEG(9),
		 IJ_END10  => IJ_BEG(10),
		 IJ_END11  => IJ_BEG(11),
		 IJ_END12  => IJ_BEG(12),
		 OJ_END0  => OJ_BEG(0),
		 OJ_END1  => OJ_BEG(1),
		 OJ_END2  => OJ_BEG(2),
		 OJ_END3  => OJ_BEG(3),
		 OJ_END4  => OJ_BEG(4),
		 OJ_END5  => OJ_BEG(5),
		 OJ_END6  => OJ_BEG(6),
		 N1BEG0  => N1BEG(0),
		 N1BEG1  => N1BEG(1),
		 N1BEG2  => N1BEG(2),
		 N2BEG0  => N2BEG(3),
		 N2BEG1  => N2BEG(4),
		 N2BEG2  => N2BEG(5),
		 E1BEG0  => E1BEG(0),
		 E1BEG1  => E1BEG(1),
		 E1BEG2  => E1BEG(2),
		 E1BEG3  => E1BEG(3),
		 E2BEG0  => E2BEG(4),
		 E2BEG1  => E2BEG(5),
		 E2BEG2  => E2BEG(6),
		 E2BEG3  => E2BEG(7),
		 S1BEG0  => S1BEG(0),
		 S1BEG1  => S1BEG(1),
		 S1BEG2  => S1BEG(2),
		 S1BEG3  => S1BEG(3),
		 S1BEG4  => S1BEG(4),
		 S2BEG0  => S2BEG(5),
		 S2BEG1  => S2BEG(6),
		 S2BEG2  => S2BEG(7),
		 S2BEG3  => S2BEG(8),
		 S2BEG4  => S2BEG(9),
		 W1BEG0  => W1BEG(0),
		 W1BEG1  => W1BEG(1),
		 W1BEG2  => W1BEG(2),
		 W1BEG3  => W1BEG(3),
		 W1BEG4  => W1BEG(4),
		 W1BEG5  => W1BEG(5),
		 W2BEG0  => W2BEG(6),
		 W2BEG1  => W2BEG(7),
		 W2BEG2  => W2BEG(8),
		 W2BEG3  => W2BEG(9),
		 W2BEG4  => W2BEG(10),
		 W2BEG5  => W2BEG(11),
		 I0  => I0,
		 T0  => T0,
		 I1  => I1,
		 T1  => T1,
		 I2  => I2,
		 T2  => T2,
		 I3  => I3,
		 T3  => T3,
		 IJ_BEG0  => IJ_BEG(0),
		 IJ_BEG1  => IJ_BEG(1),
		 IJ_BEG2  => IJ_BEG(2),
		 IJ_BEG3  => IJ_BEG(3),
		 IJ_BEG4  => IJ_BEG(4),
		 IJ_BEG5  => IJ_BEG(5),
		 IJ_BEG6  => IJ_BEG(6),
		 IJ_BEG7  => IJ_BEG(7),
		 IJ_BEG8  => IJ_BEG(8),
		 IJ_BEG9  => IJ_BEG(9),
		 IJ_BEG10  => IJ_BEG(10),
		 IJ_BEG11  => IJ_BEG(11),
		 IJ_BEG12  => IJ_BEG(12),
		 OJ_BEG0  => OJ_BEG(0),
		 OJ_BEG1  => OJ_BEG(1),
		 OJ_BEG2  => OJ_BEG(2),
		 OJ_BEG3  => OJ_BEG(3),
		 OJ_BEG4  => OJ_BEG(4),
		 OJ_BEG5  => OJ_BEG(5),
		 OJ_BEG6  => OJ_BEG(6)		 );  

end Behavioral;

