library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity conf_contr is
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
end entity conf_contr;

architecture a_conf_contr of conf_contr is

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



type StateType is (GetRow, GetCol, GetData);
signal State : StateType;

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

P_FSM:process(clk)
begin
  if clk'event AND clk='1' then
    case State is
      when GetRow =>
         if WriteStrobe = '1' then
             Row_Reg <= WriteData;
             State <= GetCol;
         end if;
      when GetCol =>
         if WriteStrobe = '1' then
             Col_Reg <= WriteData;
             State <= GetData;
         end if;
      when GetData =>
         if WriteStrobe = '1' then
             Col_Reg <= WriteData;
             State <= GetData;
         end if;
    end case;
    if ComActive='0' then
       State <= GetRow;
    end if;
  end if;--clk
end process;



P_Strobe_FSM:process(clk)
begin
  if clk'event AND clk='1' then
    case StrobeState is
      when MuxLowNibble1a =>
        if State = GetData AND WriteStrobe = '1' then
           ConfData <= WriteData; --(7 downto 4);
           Clk1     <= '0';
           Clk2     <= '0';
           StrobeState <= EnCLK1;
        end if;
      when EnCLK1 =>
       -- if WriteStrobe = '1' then
           ConfData <= WriteData; --(7 downto 4);
           Clk1     <= '1';
           Clk2     <= '0';
           StrobeState <= MuxLowNibble1b;
       -- end if;
      when MuxLowNibble1b =>
       -- if WriteStrobe = '1' then
           ConfData <= WriteData; --(7 downto 4);
           Clk1     <= '0';
           Clk2     <= '0';
           StrobeState <= MuxLowNibble2a;
       -- end if;
      when MuxLowNibble2a =>
        if WriteStrobe = '1' then
           ConfData <= WriteData; --(3 downto 0);
           Clk1     <= '0';
           Clk2     <= '0';
           StrobeState <= EnCLK2;
        end if;
      when EnCLK2 =>
       -- if WriteStrobe = '1' then
           ConfData <= WriteData; --(3 downto 0);
           Clk1     <= '0';
           Clk2     <= '1';
           StrobeState <= MuxLowNibble2b;
       -- end if;
      when MuxLowNibble2b =>
       -- if WriteStrobe = '1' then
           ConfData <= WriteData; --(3 downto 0);
           Clk1     <= '0';
           Clk2     <= '0';
           StrobeState <= MuxLowNibble1a;
       -- end if;
    end case;
    -- if ComActive='0' then
    if State /= GetData then
       StrobeState <= MuxLowNibble1a;
    end if;
  end if;--clk
end process;


-- P_Strobe_FSM:process(clk)
-- begin
--   if clk'event AND clk='1' then
--     case StrobeState is
--       when MuxLowNibble1a =>
--        if State = GetData AND WriteStrobe = '1' then
--            ConfData <= WriteData(7 downto 4);
--            Clk1     <= '0';
--            Clk2     <= '0';
--            StrobeState <= EnCLK1;
--        end if;
--       when EnCLK1 =>
--        -- if WriteStrobe = '1' then
--            ConfData <= WriteData(7 downto 4);
--            Clk1     <= '1';
--            Clk2     <= '0';
--            StrobeState <= MuxLowNibble1b;
--        -- end if;
--       when MuxLowNibble1b =>
--        -- if WriteStrobe = '1' then
--            ConfData <= WriteData(7 downto 4);
--            Clk1     <= '0';
--            Clk2     <= '0';
--            StrobeState <= MuxLowNibble2a;
--        -- end if;
--       when MuxLowNibble2a =>
--        -- if WriteStrobe = '1' then
--            ConfData <= WriteData(3 downto 0);
--            Clk1     <= '0';
--            Clk2     <= '0';
--            StrobeState <= EnCLK2;
--        -- end if;
--       when EnCLK2 =>
--        -- if WriteStrobe = '1' then
--            ConfData <= WriteData(3 downto 0);
--            Clk1     <= '0';
--            Clk2     <= '1';
--            StrobeState <= MuxLowNibble2b;
--        -- end if;
--       when MuxLowNibble2b =>
--        -- if WriteStrobe = '1' then
--            ConfData <= WriteData(3 downto 0);
--            Clk1     <= '0';
--            Clk2     <= '0';
--            StrobeState <= MuxLowNibble1a;
--        -- end if;
--     end case;
--     -- if ComActive='0' then
--     if State /= GetData then
--        StrobeState <= MuxLowNibble1a;
--     end if;
--   end if;--clk
-- end process;

end architecture;





