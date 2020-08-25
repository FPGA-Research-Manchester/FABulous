library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity frame_conf is
  generic ( 
			NumberOfRows : integer := 8;
			FrameBitsPerRow : integer := 32;
			MaxFramesPerCol : integer := 20;
			Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
										-- bin is for faster binary mode, but might not work on all machines/boards
										-- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
										-- "1--- ----" is for hex mode, "0--- ----" for bin mode
		    ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port (
        CLK:           in  std_logic;
		
		FrameRegister
		
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
end entity frame_conf;

architecture a_conf_contr of frame_conf is

component com_conf is
  generic ( Mode    : string := "auto"; -- [0:auto|1:hex|2:bin] auto selects between ASCII-Hex and binary mode and takes a bit more logic, 
                                   -- bin is for faster binary mode, but might not work on all machines/boards
                                   -- auto uses the MSB in the command byte (the 8th byte in the comload header) to set the mode
                                   -- "1--- ----" is for hex mode, "0--- ----" for bin mode
		    ComRate : integer := 217); -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
        port (
        CLK:           in  std_logic;
        Rx:            in  std_logic;
        WriteData:     out std_logic_vector(7 downto 0);
        ComActive:     out std_logic;
        WriteStrobe:   out std_logic;
		Command:       out std_logic_vector(7 downto 0);
		Col:           out std_logic_vector(7 downto 0);
		Row:           out std_logic_vector(7 downto 0);
        ReceiveLED:    out std_logic);
end component com_conf;

signal WriteData   : std_logic_vector (7 downto 0);
signal Command     : std_logic_vector (7 downto 0);
signal Col         : std_logic_vector (7 downto 0);
signal Row         : std_logic_vector (7 downto 0);
signal ComActive   : std_logic;
signal WriteStrobe : std_logic;

signal Col_Reg : std_logic_vector(7 downto 0);
signal Row_Reg : std_logic_vector(7 downto 0);


signal FrameRegister :       std_logic_vector(((NumberOfRows+1)*FrameBitsPerRow) -1 downto 0);
signal FrameAddressRegister: std_logic_vector(FrameBitsPerRow -1 downto 0);

signal FrameSelect : std_logic_vector((MaxFramesPerCol*NumberOfRows) -1 downto 0);




signal FrameShiftState : integer range 0 to (NumberOfRows + 1);

type StrobeStateType is (MuxLowNibble1a, EnCLK1, MuxLowNibble1b, MuxLowNibble2a, EnCLK2, MuxLowNibble2b);
signal StrobeState : StrobeStateType;

begin

inst_com_conf : com_conf
  generic map ( Mode    => Mode,
		        ComRate => ComRate) -- ComRate = f_CLK / Boud_rate (e.g., 25 MHz/115200 Boud = 217)
  port map    (
        CLK            => CLK,
        Rx             => Rx, 
        WriteData      => WriteData,
        ComActive      => ComActive,
        WriteStrobe    => WriteStrobe,
		Command        => Command,
		Col            => Col,
		Row            => Row,
        ReceiveLED     => ReceiveLED );    

		-- OUT_CARRY <= '0' WHEN slv_count = (slv_count'range => '0')
		
P_FSM:process(clk)
begin
  if clk'event AND clk='1' then
	if (FrameShiftState = 0) and (WriteStrobe = '1') then
		-- this will be the frame address FADR register
		FrameAddressRegister(((NumberOfRows+1)*FrameBitsPerRow) -1 downto ((NumberOfRows+1)*FrameBitsPerRow)) <= WriteData;
		FrameStrobe <= '0';
		FrameShiftState <= FrameShiftState -1 ;
	end if;
	if (FrameShiftState > 1) and (WriteStrobe = '1')
		-- get frame row-by-row
		FrameRegister(((FrameShiftState+1)*FrameBitsPerRow) -1 downto ((FrameShiftState)*FrameBitsPerRow)) <= WriteData;
		FrameStrobe <= '0';
		FrameShiftState <= FrameShiftState -1 ;
	end if;
	if (FrameShiftState = 1) and (WriteStrobe = '1')
		-- get last frame ant trigger FrameStrobe
		FrameRegister(((FrameShiftState+1)*FrameBitsPerRow) -1 downto ((FrameShiftState)*FrameBitsPerRow)) <= WriteData;
		FrameStrobe <= '1';
		FrameShiftState <= FrameShiftState -1 ;
	end if;
	if reset = '1' then
		FrameStrobe <= '0';
		FrameShiftState <= 0;
	end if;
  end if;--clk
end process;

P_StrobeREG:process(clk)
begin
  if clk'event AND clk='1' then
	FrameStrobe0 <= FrameStrobe;
	FrameStrobe1 <= FrameStrobe0;
  end if;--clk
end process;

process (FrameAddressRegister)
begin
	FrameSelect <= (others =>'0');
	-- we activate strobe for two clock cycles to relax timing
	if FrameStrobe0='1' or FrameStrobe1='1' then
		for k in 0 to NumberOfRows-1 loop
				-- the FrameSelect MSBs select the MJA (which col)
			if (FrameAddressRegister'high - NumberOfRows + k) = '1' then
				-- the FrameSelect LSBs select the MNA (which frame within a col)
				FrameSelect((MaxFramesPerCol+1)*k downto MaxFramesPerCol*k) <= FrameAddressRegister(MaxFramesPerCol-1 downto 0);
			end if;
		end for;
	end for;
end process;



end architecture;





