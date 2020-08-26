library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  W_IO  is 
	Port (
	--  NORTH
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:NULL  
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:NULL  
		 E2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:NULL  
		 E6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:NULL  
	--  SOUTH
	--  WEST
		 W1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W1END  
		 W2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2MID  
		 W2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:NULL destination_name:W2END  
		 W6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:NULL destination_name:W6END  
	-- Tile IO ports from BELs
	 	PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
	  	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this sisgnal all the way to top
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity W_IO ;

architecture Behavioral of  W_IO  is 

component IO_1_bidirectional is
    -- Generic (LUT_SIZE : integer := 4);	
    Port ( 
	-- Pin0
	I	: in	STD_LOGIC; -- from fabric to external pin
	T	: in	STD_LOGIC; -- tristate control
	O	: out	STD_LOGIC; -- from external pin to fabric
	Q	: out	STD_LOGIC; -- from external pin to fabric (registered)
	PAD : inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
	-- Tile IO ports from BELs
 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this sisgnal all the way to top
	-- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	MODE	: in 	 STD_LOGIC;	 -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
	);
end component IO_1_bidirectional;


component  W_IO_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  W1END0 	: in 	 STD_LOGIC;
		  W1END1 	: in 	 STD_LOGIC;
		  W1END2 	: in 	 STD_LOGIC;
		  W1END3 	: in 	 STD_LOGIC;
		  W2MID0 	: in 	 STD_LOGIC;
		  W2MID1 	: in 	 STD_LOGIC;
		  W2MID2 	: in 	 STD_LOGIC;
		  W2MID3 	: in 	 STD_LOGIC;
		  W2MID4 	: in 	 STD_LOGIC;
		  W2MID5 	: in 	 STD_LOGIC;
		  W2MID6 	: in 	 STD_LOGIC;
		  W2MID7 	: in 	 STD_LOGIC;
		  W2END0 	: in 	 STD_LOGIC;
		  W2END1 	: in 	 STD_LOGIC;
		  W2END2 	: in 	 STD_LOGIC;
		  W2END3 	: in 	 STD_LOGIC;
		  W2END4 	: in 	 STD_LOGIC;
		  W2END5 	: in 	 STD_LOGIC;
		  W2END6 	: in 	 STD_LOGIC;
		  W2END7 	: in 	 STD_LOGIC;
		  W6END0 	: in 	 STD_LOGIC;
		  W6END1 	: in 	 STD_LOGIC;
		  W6END2 	: in 	 STD_LOGIC;
		  W6END3 	: in 	 STD_LOGIC;
		  W6END4 	: in 	 STD_LOGIC;
		  W6END5 	: in 	 STD_LOGIC;
		  W6END6 	: in 	 STD_LOGIC;
		  W6END7 	: in 	 STD_LOGIC;
		  W6END8 	: in 	 STD_LOGIC;
		  W6END9 	: in 	 STD_LOGIC;
		  W6END10 	: in 	 STD_LOGIC;
		  W6END11 	: in 	 STD_LOGIC;
		  O 	: in 	 STD_LOGIC;
		  Q 	: in 	 STD_LOGIC;
		  E1BEG0 	: out 	 STD_LOGIC;
		  E1BEG1 	: out 	 STD_LOGIC;
		  E1BEG2 	: out 	 STD_LOGIC;
		  E1BEG3 	: out 	 STD_LOGIC;
		  E2BEG0 	: out 	 STD_LOGIC;
		  E2BEG1 	: out 	 STD_LOGIC;
		  E2BEG2 	: out 	 STD_LOGIC;
		  E2BEG3 	: out 	 STD_LOGIC;
		  E2BEG4 	: out 	 STD_LOGIC;
		  E2BEG5 	: out 	 STD_LOGIC;
		  E2BEG6 	: out 	 STD_LOGIC;
		  E2BEG7 	: out 	 STD_LOGIC;
		  E2BEGb0 	: out 	 STD_LOGIC;
		  E2BEGb1 	: out 	 STD_LOGIC;
		  E2BEGb2 	: out 	 STD_LOGIC;
		  E2BEGb3 	: out 	 STD_LOGIC;
		  E2BEGb4 	: out 	 STD_LOGIC;
		  E2BEGb5 	: out 	 STD_LOGIC;
		  E2BEGb6 	: out 	 STD_LOGIC;
		  E2BEGb7 	: out 	 STD_LOGIC;
		  E6BEG0 	: out 	 STD_LOGIC;
		  E6BEG1 	: out 	 STD_LOGIC;
		  E6BEG2 	: out 	 STD_LOGIC;
		  E6BEG3 	: out 	 STD_LOGIC;
		  E6BEG4 	: out 	 STD_LOGIC;
		  E6BEG5 	: out 	 STD_LOGIC;
		  E6BEG6 	: out 	 STD_LOGIC;
		  E6BEG7 	: out 	 STD_LOGIC;
		  E6BEG8 	: out 	 STD_LOGIC;
		  E6BEG9 	: out 	 STD_LOGIC;
		  E6BEG10 	: out 	 STD_LOGIC;
		  E6BEG11 	: out 	 STD_LOGIC;
		  I 	: out 	 STD_LOGIC;
		  T 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component W_IO_switch_matrix ;


-- signal declarations

-- BEL ports (e.g., slices)
signal	I	:STD_LOGIC;
signal	T	:STD_LOGIC;
signal	O	:STD_LOGIC;
signal	Q	:STD_LOGIC;
-- jump wires
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal	conf_data	:	STD_LOGIC_VECTOR(2 downto 0);

begin

-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
conf_data(conf_data'low) <= CONFin; -- conf_data'low=0 and CONFin is from tile entity
CONFout <= conf_data(conf_data'high); -- CONFout is from tile entity

-- BEL component instantiations

Inst_IO_1_bidirectional : IO_1_bidirectional
	Port Map(
		 I  =>  I ,
		 T  =>  T ,
		 O  =>  O ,
		 Q  =>  Q ,
	 -- I/O primitive pins go to tile top level entity (not further parsed)  
		 PAD  =>  PAD ,
		 UserCLK  =>  UserCLK ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(0),  
		 CONFout	=> conf_data(1),  
		 CLK => CLK );  


-- switch matrix component instantiation

Inst_W_IO_switch_matrix : W_IO_switch_matrix
	Port Map(
		 W1END0  => W1END(0),
		 W1END1  => W1END(1),
		 W1END2  => W1END(2),
		 W1END3  => W1END(3),
		 W2MID0  => W2MID(0),
		 W2MID1  => W2MID(1),
		 W2MID2  => W2MID(2),
		 W2MID3  => W2MID(3),
		 W2MID4  => W2MID(4),
		 W2MID5  => W2MID(5),
		 W2MID6  => W2MID(6),
		 W2MID7  => W2MID(7),
		 W2END0  => W2END(0),
		 W2END1  => W2END(1),
		 W2END2  => W2END(2),
		 W2END3  => W2END(3),
		 W2END4  => W2END(4),
		 W2END5  => W2END(5),
		 W2END6  => W2END(6),
		 W2END7  => W2END(7),
		 W6END0  => W6END(0),
		 W6END1  => W6END(1),
		 W6END2  => W6END(2),
		 W6END3  => W6END(3),
		 W6END4  => W6END(4),
		 W6END5  => W6END(5),
		 W6END6  => W6END(6),
		 W6END7  => W6END(7),
		 W6END8  => W6END(8),
		 W6END9  => W6END(9),
		 W6END10  => W6END(10),
		 W6END11  => W6END(11),
		 O  => O,
		 Q  => Q,
		 E1BEG0  => E1BEG(0),
		 E1BEG1  => E1BEG(1),
		 E1BEG2  => E1BEG(2),
		 E1BEG3  => E1BEG(3),
		 E2BEG0  => E2BEG(0),
		 E2BEG1  => E2BEG(1),
		 E2BEG2  => E2BEG(2),
		 E2BEG3  => E2BEG(3),
		 E2BEG4  => E2BEG(4),
		 E2BEG5  => E2BEG(5),
		 E2BEG6  => E2BEG(6),
		 E2BEG7  => E2BEG(7),
		 E2BEGb0  => E2BEGb(0),
		 E2BEGb1  => E2BEGb(1),
		 E2BEGb2  => E2BEGb(2),
		 E2BEGb3  => E2BEGb(3),
		 E2BEGb4  => E2BEGb(4),
		 E2BEGb5  => E2BEGb(5),
		 E2BEGb6  => E2BEGb(6),
		 E2BEGb7  => E2BEGb(7),
		 E6BEG0  => E6BEG(0),
		 E6BEG1  => E6BEG(1),
		 E6BEG2  => E6BEG(2),
		 E6BEG3  => E6BEG(3),
		 E6BEG4  => E6BEG(4),
		 E6BEG5  => E6BEG(5),
		 E6BEG6  => E6BEG(6),
		 E6BEG7  => E6BEG(7),
		 E6BEG8  => E6BEG(8),
		 E6BEG9  => E6BEG(9),
		 E6BEG10  => E6BEG(10),
		 E6BEG11  => E6BEG(11),
		 I  => I,
		 T  => T,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Mode,  
		 CONFin	=> conf_data(1),  
		 CONFout	=> conf_data(2),  
		 CLK => CLK   
		 );  

end Behavioral;

