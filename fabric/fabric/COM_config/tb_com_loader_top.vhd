-- TestBench für ComLoader
-- Die TB liest die Datei "tb_in.bin" und schickt diese
-- seriell mit der Rate 1/(2*clk_send_period) an den Rx-
-- Port des ComLoaders.
-- "tb_in.bin" kann so erzeugt werden:
-- 

library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_com_loader is
end tb_com_loader;

architecture a_tb_com_loader of tb_com_loader is

constant clk_send_period: time := 4.340 us;
--constant clk_send_period: time := 217 ns;
signal tb_i : integer;
signal tb_clock					: std_logic := '0';
signal tb_clk_send					: std_logic := '0';
signal tb_rx					: std_logic :='1';	



signal tb_d_address     : std_logic_vector ( 31 DOWNTO 0 );
signal tb_d_read_en     : std_logic;
signal tb_d_write_en    : std_logic;
signal tb_d_waitrequest : std_logic;
signal tb_d_writedata   : std_logic_vector ( 31 DOWNTO 0 );
signal tb_d_byteenable  : std_logic_vector ( 3 DOWNTO 0 );
signal tb_d_readdata    : std_logic_vector ( 31 DOWNTO 0 );
signal tb_active        : STD_LOGIC;
signal tb_Tx            : STD_LOGIC;

signal tb_reset_cpu     : STD_LOGIC;
signal tb_next_instr    : STD_LOGIC;
signal tb_Command       : STD_LOGIC_VECTOR ( 3 DOWNTO 0 );
signal tb_CRC           : STD_LOGIC_VECTOR (15 downto 0);
signal tb_ReceiveLED    : STD_LOGIC;
signal tb_ready         : STD_LOGIC;
signal tb_clk           : STD_LOGIC;


signal Tile_X6Y3_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y3_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X6Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y3_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );

signal Tile_X6Y4_N1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y4_N2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_N2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y4_N4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X6Y4_Co	:	 std_logic_vector( 0 downto 0 );
signal Tile_X5Y3_E1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X5Y3_E2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_E2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X5Y3_E6BEG	:	 std_logic_vector( 11 downto 0 );
signal Tile_X6Y2_S1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X6Y2_S2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_S2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X6Y2_S4BEG	:	 std_logic_vector( 15 downto 0 );
signal Tile_X7Y3_W1BEG	:	 std_logic_vector( 3 downto 0 );
signal Tile_X7Y3_W2BEG	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y3_W2BEGb	:	 std_logic_vector( 7 downto 0 );
signal Tile_X7Y3_W6BEG	:	 std_logic_vector( 11 downto 0 );
	
signal tb_ConfData_Out : std_logic_vector(7 downto 0);
signal ConfData : std_logic_vector(7 downto 0);
signal Clk1     : std_logic;
signal Clk2     : std_logic;


--     00 AA FF  A3 A2 A1 A0  **S3** S2 S1 S0(3)  CRC_H CRC_L command  data....

component conf_contr is
  generic ( Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                   -- bin is for faster binary mode, but might not work on all machines/boards
                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
		       ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port (
        CLK:           in  std_logic;
        Rx:            in  std_logic;
        ConfData:      out std_logic_vector(7 downto 0);
        Clk1:          out std_logic;
        Clk2:          out std_logic;        
        -- Tx:            out std_logic;
        -- WriteData:     out std_logic_vector(7 downto 0);
        -- ComActive:     out std_logic;
        -- WriteStrobe:   out std_logic;
		-- Command:       out std_logic_vector(7 downto 0);
        ReceiveLED:    out std_logic);
end component conf_contr;

component  LUT4AB  is 
	Port (
	--  NORTH
		 N1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
		 Co 	: out 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:Co destination_name:Ci  
		 N1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:1  source_name:N1BEG destination_name:N1END  
		 N2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEG destination_name:N2MID  
		 N2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:1  source_name:N2BEGb destination_name:N2END  
		 N4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:4  source_name:N4BEG destination_name:N4END  
		 Ci 	: in 	STD_LOGIC_VECTOR( 0 downto 0 );	 -- wires:1 X_offset:0 Y_offset:1  source_name:Co destination_name:Ci  
	--  EAST
		 E1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
		 E2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
		 E6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
		 E1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destination_name:E1END  
		 E2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEG destination_name:E2MID  
		 E2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:1 Y_offset:0  source_name:E2BEGb destination_name:E2END  
		 E6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:6 Y_offset:0  source_name:E6BEG destination_name:E6END  
	--  SOUTH
		 S1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
		 S2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
		 S4BEG 	: out 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
		 S1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-1  source_name:S1BEG destination_name:S1END  
		 S2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEG destination_name:S2MID  
		 S2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:0 Y_offset:-1  source_name:S2BEGb destination_name:S2END  
		 S4END 	: in 	STD_LOGIC_VECTOR( 15 downto 0 );	 -- wires:4 X_offset:0 Y_offset:-4  source_name:S4BEG destination_name:S4END  
	--  WEST
		 W1BEG 	: out 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2BEG 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
		 W2BEGb 	: out 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
		 W6BEG 	: out 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
		 W1END 	: in 	STD_LOGIC_VECTOR( 3 downto 0 );	 -- wires:4 X_offset:-1 Y_offset:0  source_name:W1BEG destination_name:W1END  
		 W2MID 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEG destination_name:W2MID  
		 W2END 	: in 	STD_LOGIC_VECTOR( 7 downto 0 );	 -- wires:8 X_offset:-1 Y_offset:0  source_name:W2BEGb destination_name:W2END  
		 W6END 	: in 	STD_LOGIC_VECTOR( 11 downto 0 );	 -- wires:2 X_offset:-6 Y_offset:0  source_name:W6BEG destination_name:W6END  
	-- Tile IO ports from BELs
	 	UserCLK : in	STD_LOGIC; -- EXTERNAL -- the EXTERNAL keyword will send this signal all the way to top
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end component LUT4AB ;


begin

tb_clock <= not tb_clock after 20 ns;
tb_clk_send <= NOT tb_clk_send after clk_send_period;



tb_data: process (tb_CLK_send)
type characterFile_Typ is file of character;
file f: characterFile_Typ open read_mode is "R:\work\FORTE\FPGA\fabric\COM_config\zero_com.bin";
variable c:character;
variable i:integer:=0;
variable next_byte : std_logic_vector(7 downto 0);
begin
  if tb_CLK_send'event AND tb_CLK_send='1' then   -- on negative edge for readability
    if i<=19 then tb_rx <='1'; 
    elsif ((i MOD 10)=0) then --start bit position
       IF (NOT endfile(f)) then
          Read( f    => f,
                value=> c);  
          next_byte := CONV_STD_LOGIC_VECTOR(character'pos(c),8);
          tb_rx <= '0';     -- we have something to send
       else
          next_byte := b"1111_1111";
          tb_rx <= '1';     -- we have nothing to send - so no start bit
       end if;
    elsif ((i MOD 10)=9) then --stop bit position
          tb_rx <= '1';
    else                 -- send data bits (LSB first)
          tb_rx <= next_byte((i MOD 10)-1);
    end if; -- endfile
    i := i+1;
    tb_i <= i;
end if ; --tb_CLK_send
end process;   


DUT : conf_contr 
  generic map ( ComRate => 217) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port map(
        CLK			=> tb_clock,
        Rx			=> tb_rx,
        ConfData    => ConfData,
        Clk1        => Clk1,
        Clk2        => Clk2,        
        ReceiveLED	=> tb_ReceiveLED);

Tile_X6Y3_LUT4AB : LUT4AB
	Port Map(
	N1END	=> Tile_X6Y4_N1BEG( 3 downto 0 ),
	N2MID	=> Tile_X6Y4_N2BEG( 7 downto 0 ),
	N2END	=> Tile_X6Y4_N2BEGb( 7 downto 0 ),
	N4END	=> Tile_X6Y4_N4BEG( 15 downto 0 ),
	Ci	=> Tile_X6Y4_Co( 0 downto 0 ),
	E1END	=> Tile_X5Y3_E1BEG( 3 downto 0 ),
	E2MID	=> Tile_X5Y3_E2BEG( 7 downto 0 ),
	E2END	=> Tile_X5Y3_E2BEGb( 7 downto 0 ),
	E6END	=> Tile_X5Y3_E6BEG( 11 downto 0 ),
	S1END	=> Tile_X6Y2_S1BEG( 3 downto 0 ),
	S2MID	=> Tile_X6Y2_S2BEG( 7 downto 0 ),
	S2END	=> Tile_X6Y2_S2BEGb( 7 downto 0 ),
	S4END	=> Tile_X6Y2_S4BEG( 15 downto 0 ),
	W1END	=> Tile_X7Y3_W1BEG( 3 downto 0 ),
	W2MID	=> Tile_X7Y3_W2BEG( 7 downto 0 ),
	W2END	=> Tile_X7Y3_W2BEGb( 7 downto 0 ),
	W6END	=> Tile_X7Y3_W6BEG( 11 downto 0 ),
	N1BEG	=> Tile_X6Y3_N1BEG( 3 downto 0 ),
	N2BEG	=> Tile_X6Y3_N2BEG( 7 downto 0 ),
	N2BEGb	=> Tile_X6Y3_N2BEGb( 7 downto 0 ),
	N4BEG	=> Tile_X6Y3_N4BEG( 15 downto 0 ),
	Co	=> Tile_X6Y3_Co( 0 downto 0 ),
	E1BEG	=> Tile_X6Y3_E1BEG( 3 downto 0 ),
	E2BEG	=> Tile_X6Y3_E2BEG( 7 downto 0 ),
	E2BEGb	=> Tile_X6Y3_E2BEGb( 7 downto 0 ),
	E6BEG	=> Tile_X6Y3_E6BEG( 11 downto 0 ),
	S1BEG	=> Tile_X6Y3_S1BEG( 3 downto 0 ),
	S2BEG	=> Tile_X6Y3_S2BEG( 7 downto 0 ),
	S2BEGb	=> Tile_X6Y3_S2BEGb( 7 downto 0 ),
	S4BEG	=> Tile_X6Y3_S4BEG( 15 downto 0 ),
	W1BEG	=> Tile_X6Y3_W1BEG( 3 downto 0 ),
	W2BEG	=> Tile_X6Y3_W2BEG( 7 downto 0 ),
	W2BEGb	=> Tile_X6Y3_W2BEGb( 7 downto 0 ),
	W6BEG	=> Tile_X6Y3_W6BEG( 11 downto 0 ),
	 -- tile IO port which gets directly connected to top-level tile entity
		UserCLK =>  tb_clock ,
	 -- GLOBAL all primitive pins for configuration (not further parsed)  
		 MODE	=> Clk2,  
		 CONFin	=> ConfData(0),  
		 CONFout	=> tb_ConfData_Out(0),  
		 CLK => Clk1 ); 

end architecture;
