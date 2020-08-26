
-- 

library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_eFPGA_top is
end tb_eFPGA_top;

architecture a_tb_eFPGA_top of tb_eFPGA_top is

constant mode : string := "serial";          -- "serial": send configuration in through UART, "parallel" use parallel configuration port; "both" fires both, however UART has higher priority 
--constant clk_send_period: time := 4.340 us;   2 x 4.340 us -> 11 520 boud
constant clk_send_period: time := 250 ns;    -- 2 x 250ns -> 2M boud

signal tb_parallel_i : integer;
signal tb_serial_i : integer;

signal tb_clock					: std_logic := '0';
signal tb_stim_CLK					: std_logic := '0';

signal tb_clk_send					: std_logic := '0';

signal tb_Rx					: std_logic :='1';	

signal 	tb_PAD	:	STD_LOGIC_VECTOR (16 -1 downto 0) := (others => '0');
signal 	tb_OPA	:	STD_LOGIC_VECTOR (32 -1 downto 0) := (others => '0');
signal 	tb_OPB	:	STD_LOGIC_VECTOR (32 -1 downto 0) := (others => '0');
signal 	tb_RES0 :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	tb_RES1 :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	tb_RES2 :	STD_LOGIC_VECTOR (32 -1 downto 0);
signal 	tb_CLK	:	std_logic := '0';

signal	tb_WriteStrobe		:	std_logic := '0';
signal	tb_WriteData	:	STD_LOGIC_VECTOR (32 -1 downto 0) := x"1111_1111";	

signal tb_counter : integer := 0;

----------------------
-- UART 
signal  tb_ReceiveLED   : std_logic;
signal  tb_ComActive    : std_logic;
signal  tb_UART_WriteStrobe    : std_logic := '0';
signal  tb_UART_WriteData   : STD_LOGIC_VECTOR (31 downto 0);
signal  tb_Command          : STD_LOGIC_VECTOR (7 downto 0);


component  eFPGA_top  is 
	Port (
	-- External USER ports 
		PAD		:	inout	STD_LOGIC_VECTOR (16 -1 downto 0);	-- these are for Dirk and go to the pad ring
		OPA		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		OPB		:	in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES0	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES1	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		RES2	:	out		STD_LOGIC_VECTOR (32 -1 downto 0);	-- these are for Andrew	and go to the CPU
		CLK	    : 	in		STD_LOGIC;							-- This clock can go to the CPU (connects to the fabric LUT output flops
		
	-- CPU configuration port
		WriteStrobe:	in		STD_LOGIC; -- must decode address and write enable
		WriteData:		in		STD_LOGIC_VECTOR (32 -1 downto 0);	-- configuration data write port
		
		Rx:				in		STD_LOGIC -- alternative UART -> TODO

		);
end component eFPGA_top ;

component config_UART is
  generic ( Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                   -- bin is for faster binary mode, but might not work on all machines/boards
                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
		    ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port (
        CLK:           in  std_logic;
        Rx:            in  std_logic;
        WriteData:     out std_logic_vector(31 downto 0);
        ComActive:     out std_logic;
        WriteStrobe:   out std_logic;
		Command:       out std_logic_vector(7 downto 0);
        ReceiveLED:    out std_logic);
end component config_UART;


BEGIN


tb_stim_CLK <= NOT tb_stim_CLK after 133 ps;

p_OP_Stim: process(tb_stim_CLK)
begin
    if tb_stim_CLK'event and tb_stim_CLK='1' then
        tb_OPA <= tb_OPA + 1;
    end if;
    if tb_stim_CLK'event and tb_stim_CLK='0' then
        tb_OPB <= tb_OPB - 1;
    end if;
end process; 



tb_CLK <= NOT tb_CLK after 10 ns;

L_parallel : if (mode = "parallel") or (mode = "both") generate
    tb_parallel_data: process (tb_CLK)
    type characterFile_Typ is file of character;
    file f: characterFile_Typ open read_mode is "R:\work\FORTE\FPGA\fabric\fabric_test.bit";
    variable c:character;
    variable i:integer:=0;
    variable next_byte : std_logic_vector(7 downto 0);
    begin
      if tb_CLK'event AND tb_CLK='1' then   -- on negative edge for readability
           tb_WriteData <= (others => '0');
           tb_WriteStrobe <= '0';    if ((i MOD 10)=5) then --start bit position
           IF (NOT endfile(f)) then
              Read( f    => f, value=> c);  
              tb_WriteData(31 downto 24) <= CONV_STD_LOGIC_VECTOR(character'pos(c),8);
              Read( f    => f, value=> c);  
              tb_WriteData(23 downto 16) <= CONV_STD_LOGIC_VECTOR(character'pos(c),8);
              Read( f    => f, value=> c);  
              tb_WriteData(15 downto  8) <= CONV_STD_LOGIC_VECTOR(character'pos(c),8);
              Read( f    => f, value=> c);  
              tb_WriteData( 7 downto  0) <= CONV_STD_LOGIC_VECTOR(character'pos(c),8);
              tb_WriteStrobe <= '1';     -- we have something to send
           end if;
        end if; -- endfile
        i := i+1;
            tb_parallel_i <= i;
    end if ; --tb_CLK
    end process; 
end generate;

L_serial : if (mode = "serial") or (mode = "both") generate
    tb_clk_send <= NOT tb_clk_send after clk_send_period;
    
    tb_serial_data: process (tb_CLK_send)
    type characterFile_Typ is file of character;
    file f: characterFile_Typ open read_mode is "R:\work\FORTE\FPGA\fabric\fabric_test.bit";
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
        tb_serial_i <= i;
    end if ; --tb_CLK_send
    end process;
end generate; 

--process(tb_CLK)
--begin
--	if tb_CLK'event and tb_CLK='0' then
--		tb_WriteStrobe <= '0';
--		tb_counter <= tb_counter + 1;
--		if tb_counter = 10 then
--			tb_counter <= 0;
--			tb_WriteStrobe <= '1';
--    		tb_WriteData <= tb_WriteData(tb_WriteData'high-1 downto 0) & '1';
--		end if;
--	end if;
--end process;

DUT : eFPGA_top
Port Map(
		PAD		=> 	tb_PAD	,
		OPA		=> 	tb_OPA	,
		OPB		=> 	tb_OPB	,
		RES0	=> 	tb_RES0 ,
		RES1	=> 	tb_RES1 ,
		RES2	=> 	tb_RES2 ,
		CLK	    => 	tb_CLK	,
		
	-- CPU configuration port
		WriteStrobe	=> 	tb_WriteStrobe	,
		WriteData	=> 	tb_WriteData	,
		
		Rx	=> 	tb_Rx	
);


--DUT_COM : config_UART 
--   generic map ( Mode    => "auto", -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
--                                   -- bin is for faster binary mode, but might not work on all machines/boards
--                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
--                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
--                                   
--		    --ComRate => 217) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
--		    ComRate => 25) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
--		    
--        port map (
--        CLK                => tb_CLK,
--        Rx                 => tb_Rx,
--        WriteData          => tb_UART_WriteData,
--        ComActive          => tb_ComActive,
--        WriteStrobe        => tb_UART_WriteStrobe,
--		Command            => tb_Command,
--        ReceiveLED         => tb_ReceiveLED 
--        );

		
end a_tb_eFPGA_top;
