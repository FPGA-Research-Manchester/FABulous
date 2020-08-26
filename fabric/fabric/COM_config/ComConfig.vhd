--------------- Declaration Template ---------------------------------------------
-- component ComConfig is
 -- generic ( Family     : string := "Spartan6"; -- [Spartan6|Virtex5|Virtex6]
           -- Mode       : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
 -- --                                bin is for faster binary mode, but might not work on all machines/boards
 -- --                                auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
 -- --                                "1--- ----" is for hex mode, "0--- ----" for bin mode
           -- ComRate    : integer := 217);  -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
    -- Port ( CLK        : in  STD_LOGIC;
           -- Rx         : in  STD_LOGIC;
           -- ReceiveLED : out  STD_LOGIC);
-- end component ComConfig;
----------------------------------------------------------------------------------

----------------Instantiation Template -------------------------------------------
-- Inst_ComConfig:ComConfig 		-- instantiate the UART receiving the configuration data
  -- generic map(
    -- Family  => "Spartan6", -- [Spartan6|Virtex5|Virtex6]
    -- Mode    => "auto",  -- [0:auto|1:hex|2:bin] 0:auto : select automatically between bin/hex mode
    -- ComRate => 434)     -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217) 1302 @ 19200 Boud
  -- port map (
    -- CLK            => clk_50,
    -- Rx             => UartRx, 
    -- ReceiveLED     => LED ); --receiveled  );
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity ComConfig is
 generic ( Family     : string := "Spartan6"; -- [Spartan6|Virtex5|Virtex6]
--         ByteWise   : Boolean := true;  -- Full ICAP width (false) or ByteWise reconfiguration (true)
           Mode       : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                          -- bin is for faster binary mode, but might not work on all machines/boards
                                          -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                          -- "1--- ----" is for hex mode, "0--- ----" for bin mode
           ComRate    : integer := 217);  -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
    Port ( CLK        : in  STD_LOGIC;
           Rx         : in  STD_LOGIC;
           ReceiveLED : out  STD_LOGIC);
end ComConfig;

architecture Behavioral of ComConfig is

component com_icap is
  generic ( Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                        -- bin is for faster binary mode, but might not work on all machines/boards
            ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
  port (CLK         : in  std_logic;
        Rx          : in  std_logic;
        Tx          : out std_logic;
        WriteData   : out std_logic_vector(7 downto 0);
        ComActive   : out std_logic;
        WriteStrobe : out std_logic;
	     Command     : out std_logic_vector(7 downto 0);
        ReceiveLED  : out std_logic);
end component com_icap;

signal ComWriteData : std_logic_vector(7 downto 0);
signal ComCommand : std_logic_vector(7 downto 0);
signal ComActive : std_logic;
signal ComWritestrobe : std_logic;
signal com_ReceiveLED : std_logic;
signal IcapCLK_trigger, IcapCLK : std_logic;
signal IcapI, IcapO : std_logic_vector(31 downto 0) := (others =>'1');
signal IcapBUSY : std_logic;
signal IcapCE : std_logic;

type ReceiveType is (Idle, Get0, Get1, Get2, Get3);
signal ReceiveState : ReceiveType :=Idle;
signal COM32Data : std_logic_vector(31 downto 0) := (others =>'0');
signal COM32Strobe : std_logic := '0';

---------------------------------------------------------
 attribute KEEP : string;
 
 attribute keep of IcapO : signal is "true";
 attribute keep of IcapBUSY : signal is "true";


begin

L_ICAP_SPARTAN6: if (Family="Spartan6") generate
	ICAP_inst : ICAP_SPARTAN6
	  port map (  BUSY  => IcapBUSY,              -- 1-bit Busy output
					  O     => IcapO(15 downto 0),    -- 16-bit Configuartion data output bus
					  CE    => IcapCE,                -- 1-bit Active low clock enable input
					  CLK   => IcapCLK,               -- 1-bit Clock input
					  I     => IcapI(15 downto 0),    -- 16-bit Configuration data input bus
					  WRITE => '0'                    -- IcapWRITE -- 1-bit Active low write input
	);
end generate;
L_ICAP_Virtex6: if (Family="Virtex6") generate
	ICAP_inst : ICAP_VIRTEX6
	generic map(  ICAP_WIDTH => "X32")
	  port map (  BUSY  => IcapBUSY,              -- 1-bit Busy output
					  O     => IcapO(31 downto 0),    -- 16-bit Configuartion data output bus
					  CSB   => IcapCE,                -- 1-bit Active low clock enable input
					  CLK   => IcapCLK,               -- 1-bit Clock input
					  I     => IcapI(31 downto 0),    -- 16-bit Configuration data input bus
					  RDWRB => '0'                    -- IcapWRITE -- 1-bit Active low write input
	);
end generate;
L_ICAP_Virtex5: if (Family="Virtex5") generate
	ICAP_inst : ICAP_VIRTEX5
	  port map (  BUSY  => IcapBUSY,              -- 1-bit Busy output
					  O     => IcapO(31 downto 0),    -- 16-bit Configuartion data output bus
					  CE    => IcapCE,                -- 1-bit Active low clock enable input
					  CLK   => IcapCLK,               -- 1-bit Clock input
					  I     => IcapI(31 downto 0),    -- 16-bit Configuration data input bus
					  WRITE => '0'                    -- IcapWRITE -- 1-bit Active low write input
	);
end generate;

instcomicap:com_icap 		-- instantiate the UART receiving the configuration data
  generic map(
    Mode    => Mode,       -- [0:auto|1:hex|2:bin] 0:auto : select automatically between bin/hex mode
    ComRate => ComRate)    -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
	                        -- 1302 @ 19200 Boud
  port map (
    clk            => CLK,
    rx             => Rx,
    tx             => open,
    writedata      => ComWriteData,
    comactive      => ComActive,
    writestrobe    => ComWritestrobe,
    command        => ComCommand,
    receiveled     => com_ReceiveLED  );
	 
process(CLK)
begin
  if clk'event and CLK='1'then
    if ComActive='0' then 
	   COM32Data <= (others => '0');
	   ReceiveState <= Get0;
		COM32Strobe            <= '0';
    elsif ReceiveState=Get0 AND ComWritestrobe='1' then
	   COM32Data(7 downto 0) <= ComWriteData;
		ReceiveState        <= Get1;
		COM32Strobe            <= '0';
    elsif ReceiveState=Get1 AND ComWritestrobe='1' then
	   COM32Data(15 downto 8) <= ComWriteData;
		ReceiveState        <= Get2;
		COM32Strobe            <= '0';
    elsif ReceiveState=Get2 AND ComWritestrobe='1' then
	   COM32Data(23 downto 16) <= ComWriteData;
		ReceiveState        <= Get3;
		COM32Strobe            <= '0';
    elsif ReceiveState=Get3 AND ComWritestrobe='1' then
	   COM32Data(31 downto 24) <= ComWriteData;
		ReceiveState        <= Get0;
		COM32Strobe            <= '1';
	 else
		COM32Strobe            <= '0';
    end if;
  end if;
end process;

-- Note that we have to permute the bits within each byte...
--IcapI(7 downto 0) <= ComWriteData(0) & ComWriteData(1) & ComWriteData(2) & ComWriteData(3) & ComWriteData(4) & ComWriteData(5) & ComWriteData(6) & ComWriteData(7);
IcapI <= COM32Data(0) & COM32Data(1) & COM32Data(2) & COM32Data(3) & COM32Data(4) & COM32Data(5) & COM32Data(6) & COM32Data(7) &
         COM32Data(8) & COM32Data(9) & COM32Data(10) & COM32Data(11) & COM32Data(12) & COM32Data(13) & COM32Data(14) & COM32Data(15) &
         COM32Data(16) & COM32Data(17) & COM32Data(18) & COM32Data(19) & COM32Data(20) & COM32Data(21) & COM32Data(22) & COM32Data(23) &
         COM32Data(24) & COM32Data(25) & COM32Data(26) & COM32Data(27) & COM32Data(28) & COM32Data(29) & COM32Data(30) & COM32Data(31);
-- We use only the 8-bit mode and it is easier for the router to set unused inputs to '1'
-- IcapI(15 downto 8) <= (others => '1'); -- done in the declaration inorder to avoiud device specific assignments

ReceiveLED <= com_ReceiveLED; -- AND (ComCommand(1) XOR IcapBUSY); -- include the dummy logic if the keep attribute is not working 
                                                                   -- (i.e., the ICAP primitive gets trimed as no output signals are connected)

-- generate the clock signal to strobe in the configuration data (here we use clock to control the configuration)
--process(CLK)
--begin
--  if CLK'event AND CLK='1' then
--	 if ComWritestrobe='1' AND ComCommand(3 downto 0)= x"1" then
--	   IcapCLK_trigger <= '1';
--	 else
--	   IcapCLK_trigger <= '0';
--	 end if;
--	 IcapCLK <= IcapCLK_trigger;
--  end if; 
--end process;

-- this is for clock control
--process(CLK)
--begin
--  if clk'event and CLK='0'then
--	 IcapCLK <= COM32Strobe;
--  end if;
--end process;
--IcapCLK <= COM32Strobe; -- was not working
--IcapCE <= '0';  -- we use clk control

-- this is for enable control
IcapCLK <= clk;
IcapCE <= NOT COM32Strobe;

end Behavioral;

