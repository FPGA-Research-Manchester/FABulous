library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity config_UART is
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
end config_UART;

architecture a_com_conf of config_UART is

--constant TimeToSendValue : integer := 16777216-1; --200000000;  
constant TimeToSendValue : integer := 16777-1; --200000000;  
constant CRC_InitValue : std_logic_vector(15 downto 0) := "1111111111111111";
constant TestFileChecksum : std_logic_vector(19 downto 0) := x"4FB00";

function ASCII2HEX(ASCII: std_logic_vector(7 downto 0)) return std_logic_vector is
begin
  case ASCII is
    when x"30" => return "00000";	-- 0
    when x"31" => return "00001";
    when x"32" => return "00010";
    when x"33" => return "00011";
    when x"34" => return "00100";
    when x"35" => return "00101";
    when x"36" => return "00110";
    when x"37" => return "00111";
    when x"38" => return "01000";
    when x"39" => return "01001";
    when x"41" => return "01010";  -- A
    when x"61" => return "01010";  -- a
    when x"42" => return "01011";  -- B
    when x"62" => return "01011";  -- b
    when x"43" => return "01100";  -- C
    when x"63" => return "01100";  -- c
    when x"44" => return "01101";  -- D
    when x"64" => return "01101";  -- d
    when x"45" => return "01110";  -- E
    when x"65" => return "01110";  -- e
    when x"46" => return "01111";  -- F
    when x"66" => return "01111";  -- f
    when others =>return "1----";   -- The MSB encodes if there was an unknown code -> error
  end case; 
end;

type ReceiveStateType is (HighNibble, LowNibble);
signal ReceiveState : ReceiveStateType;
signal HighReg : std_logic_vector(3 downto 0);
signal HexValue : std_logic_vector(4 downto 0); -- a '0' MSB indicates a valid value on [3..0]
signal HexData : std_logic_vector(7 downto 0); -- the received byte in hexmode mode
signal HexWriteStrobe : std_logic; -- we received two hex nibles and have a result byte

signal ComCount : integer range 0 to 4095;
signal ComTick : std_logic;
type ComStateType is (WaitForStartBit, DelayAfterStartBit, GetBit0, GetBit1, GetBit2,
                      GetBit3, GetBit4, GetBit5, GetBit6, GetBit7, GetStopBit);
signal ComState : ComStateType;
signal ReceivedWord : std_logic_vector(7 downto 0);
signal RxLocal : std_logic;

--signal W0, W1, W2, W3, W4, W5, W6, W7 : std_logic_vector(7 downto 0);

signal ID_Reg : std_logic_vector(23 downto 0);
signal Start_Reg : std_logic_vector(31 downto 0);
signal Size_Reg : std_logic_vector(15 downto 0);
signal CRC_Reg : std_logic_vector(15 downto 0);
signal Command_Reg : std_logic_vector(7 downto 0);
signal Data_Reg : std_logic_vector(7 downto 0);

signal ReceivedByte : std_logic_vector(7 downto 0);

signal TimeToSend : std_logic;
signal TimeToSendCounter : integer range 0 to TimeToSendValue;

type PresentType is (Idle, GetID_00, GetID_AA, GetID_FF, GetCommand, EvalCommand, GetData);
signal PresentState : PresentType;

type GetWordType is (Word0, Word1, Word2, Word3);
signal GetWordState : GetWordType;

signal LocalWriteStrobe : std_logic;

signal ByteWriteStrobe : std_logic;

signal Data_Reg32 : std_logic_vector(31 downto 0);

signal Word_Count : std_logic_vector(15 downto 0);                        

signal CRCReg,b_counter : std_logic_vector(19 downto 0) := TestFileChecksum;
signal ReceivedWordDebug : std_logic_vector(7 downto 0);
signal blink : std_logic_vector(22 downto 0) := (others => '0');

begin

P_sync:process(clk)
begin
  if clk'event AND clk='1' then
    RxLocal <= Rx;
  end if; -- clk;
end process;

P_com_en:process(clk)
begin
  if clk'event AND clk='1' then
    if ComState=WaitForStartBit then
      ComCount <= ComRate/2;  -- @ 25 MHz
       ComTick <= '0';
    elsif ComCount=0 then
       ComCount <= ComRate;   
       ComTick <= '1';
    else
       ComCount <= ComCount - 1;
       ComTick <= '0';
    end if;
  end if; -- clk
end process;

P_COM:process(clk, ComState, ReceivedWord)
begin
  if clk'event AND clk='1' then
  case ComState is
    when WaitForStartBit =>
      if RxLocal='0' then
        ComState <= DelayAfterStartBit;
        ReceivedWord <= (others => '0');
      end if;
    when DelayAfterStartBit =>
      if ComTick='1' then
        ComState <= GetBit0;
      end if;
    when GetBit0 =>
      if ComTick='1' then
        ComState <= GetBit1;
        ReceivedWord(0) <= RxLocal;
      end if;
    when GetBit1 =>
      if ComTick='1' then
        ComState <= GetBit2;
        ReceivedWord(1) <= RxLocal;
      end if;
    when GetBit2 =>
      if ComTick='1' then
        ComState <= GetBit3;
        ReceivedWord(2) <= RxLocal;
      end if;
    when GetBit3 =>
      if ComTick='1' then
        ComState <= GetBit4;
        ReceivedWord(3) <= RxLocal;
      end if;
    when GetBit4 =>
      if ComTick='1' then
        ComState <= GetBit5;
        ReceivedWord(4) <= RxLocal;
      end if;
    when GetBit5 =>
      if ComTick='1' then
        ComState <= GetBit6;
        ReceivedWord(5) <= RxLocal;
      end if;
    when GetBit6 =>
      if ComTick='1' then
        ComState <= GetBit7;
        ReceivedWord(6) <= RxLocal;
      end if;
    when GetBit7 =>
      if ComTick='1' then
        ComState <= GetStopBit;
        ReceivedWord(7) <= RxLocal;
      end if;
    when GetStopBit =>
      if ComTick='1' then
        ComState <= WaitForStartBit;
      end if;
  end case;
  end if; --clk
  if clk'event AND clk='1' then
-- scan order:
-- <-to_modules_scan_in <- LSB_W0..MSB_W0 <- LSB_W1.... <- LSB_W7 <- from_modules_scan_out
-- W8(7..1) wird nicht benötigt da 57 flip-flops - werden als command ID verwendet!
    if ComState=GetStopBit AND ComTick='1' then
       case PresentState is
         when GetID_00 => ID_Reg(23 downto 16) <= ReceivedWord;
         when GetID_AA => ID_Reg(15 downto 8) <= ReceivedWord;
         when GetID_FF => ID_Reg(7 downto 0) <= ReceivedWord;
--         when GetSize0 => Size_Reg(15 downto 8) <= ReceivedWord;
--         when GetSize1 => Size_Reg(7 downto 0) <= ReceivedWord;
--         when GetCRC_H => CRC_Reg(15 downto 8) <= ReceivedWord;
--         when GetCRC_L => CRC_Reg(7 downto 0) <= ReceivedWord;
         when GetCommand => Command_Reg <= ReceivedWord;   
         when GetData => Data_Reg <= ReceivedWord;
         when others => 
       end case;
    end if;
  end if; --clk
end process;

P_FSM:process(clk)
begin
  if clk'event AND clk='1' then
    case PresentState is
      when Idle =>
        if ComState=WaitForStartBit AND RxLocal='0' then PresentState <= GetID_00; end if;
      when GetID_00 =>
        if TimeToSend='1' then PresentState<=Idle;
        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= GetID_AA; end if;
      when GetID_AA =>
        if TimeToSend='1' then PresentState<=Idle;
        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= GetID_FF; end if;
      when GetID_FF =>
        if TimeToSend='1' then PresentState<=Idle;
        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= GetCommand; end if;
--      when GetSize1 =>
--        if TimeToSend='1' then PresentState<=Idle;
--        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= GetSize0; end if;
--      when GetSize0 =>
--        if TimeToSend='1' then PresentState<=Idle;
--        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= GetCommand; end if;
      when GetCommand =>
        if TimeToSend='1' then PresentState<=Idle;
        elsif ComState=GetStopBit AND ComTick='1' then PresentState <= EvalCommand; end if;
      when EvalCommand =>
        if ID_Reg=x"00AAFF" AND (Command_Reg(6 downto 0)="000" & x"1" OR Command_Reg(6 downto 0)="000" & x"2")then 
              PresentState <= GetData; 
         else  
              PresentState <= Idle; 
        end if;
      when GetData =>
        if TimeToSend='1' then 
            PresentState<=Idle;
        end if;
    end case;
  end if;--clk
end process;
Command <= Command_Reg;

L_hexmode : if (Mode="auto" OR Mode="hex") generate -- mode [0:auto|1:hex|2:bin]

	HexValue <=  ASCII2HEX(ReceivedWord);

	process(clk)
	begin
	  if CLK'event AND CLK='1' then
		 if PresentState/=GetData then
			ReceiveState <= HighNibble;
		 elsif ComState=GetStopBit AND ComTick='1' AND HexValue(HexValue'high)='0' then
			if(ReceiveState=HighNibble) then
			  ReceiveState <= LowNibble;
			else
			  ReceiveState <= HighNibble;
			end if;
		 end if;
	  end if; -- CLK
	end process;

	process(clk)
	begin
	  if CLK'event AND CLK='1' then
		 if ComState=GetStopBit AND ComTick='1' AND HexValue(HexValue'high)='0' then
			if(ReceiveState=HighNibble) then
			  HighReg <= HexValue(3 downto 0);
			  HexWriteStrobe <= '0';
			else			-- LowNibble
			  HexData  <= HighReg & HexValue(3 downto 0);
			  HexWriteStrobe <= '1';
			end if;
		 else
			HexWriteStrobe <= '0';
		 end if;
	  end if; -- CLK
	end process;

end generate;

P_checksum:process(clk)
begin
  if clk'event AND clk='1' then          
    if PresentState=GetCommand then    -- init before data arrives 
      CRCReg       <= (others => '0');
      b_counter       <= (others => '0');
	 elsif Mode="hex" OR (Mode="auto" AND Command_Reg(7)='1') then  -- mode [0:auto|1:hex|2:bin]
      -- if hex mode or if auto mode with detected hex mode in the command register
        if ComState=GetStopBit AND ComTick='1' AND HexValue(HexValue'high)='0' AND PresentState=GetData AND ReceiveState=LowNibble then
          CRCReg <= CRCReg + (HighReg & HexValue(3 downto 0));
	  	    b_counter <= b_counter +1;
		  end if;
	 else -- binary mode
        if ComState=GetStopBit AND ComTick='1' AND (PresentState=GetData) then
          CRCReg <= CRCReg + ReceivedWord;
		    b_counter <= b_counter +1;
		  end if;
    end if; -- checksum computation
    
    if (PresentState=GetData) then
      ReceiveLED <= '1';  -- receive process in progress
    elsif (PresentState=Idle) and (CRCReg/=TestFileChecksum) then
      ReceiveLED <= blink(blink'high);
    else
      ReceiveLED <= '0';  -- receive process was OK
    end if;
    
  blink <= blink -1;
    
  end if; --clk
end process;                                                                 

P_bus:process(clk)
begin
  if clk'event AND clk='1' then
    
    if PresentState=EvalCommand then
      LocalWriteStrobe <= '0';
    elsif PresentState=GetData AND ComState=GetStopBit AND ComTick='1' then
      LocalWriteStrobe <= '1'; 
    else
      LocalWriteStrobe <= '0';
    end if;

	if Mode="bin" OR (Mode="auto" AND Command_Reg(7)='0') then -- mode [0:auto|1:hex|2:bin]
	  -- if binary mode or if auto mode with detected binary mode in the command register
		ByteWriteStrobe <= LocalWriteStrobe ;  -- delay Strobe to ensure that data is valid when applying clk
													  -- should further prevent glitches in ICAP clk
	else
		ByteWriteStrobe <= HexWriteStrobe ;  
	end if;

  end if; -- clk
end process;

P_WordMode:process(clk)
begin
  if clk'event AND clk='1' then
    if (PresentState=EvalCommand) then
	   GetWordState <= Word0;
	   WriteData <= "--------------------------------";
	 else
		case GetWordState is 
		  when Word0 =>
		    if ByteWriteStrobe='1' then
			   WriteData(31 downto 24) <=  ReceivedByte;
			   GetWordState <= Word1;
		    end if;
		  when Word1 =>
		    if ByteWriteStrobe='1' then
			   WriteData(23 downto 16) <= ReceivedByte;
			   GetWordState <= Word2;
		    end if;
		  when Word2 =>
		    if ByteWriteStrobe='1' then
			   WriteData(15 downto 8)  <= ReceivedByte;
			   GetWordState <= Word3;
		    end if;
		  when Word3 =>
		    if ByteWriteStrobe='1' then
			   WriteData(7 downto 0)   <= ReceivedByte;
			   GetWordState <= Word0;
		    end if;
		end case;
	 end if;

    if ByteWriteStrobe='1' AND GetWordState = Word3 then
		WriteStrobe <= '1';
	else
		WriteStrobe <= '0';
	end if;

  end if; -- clk
end process;

--      ComLoaderActive <= '0';
ReceivedByte      <= Data_Reg when (Mode="bin" OR (Mode="auto" AND Command_Reg(7)='0')) else HexData;  -- mode [0:auto|1:hex|2:bin]
            -- if binary mode or if auto mode with detected binary mode in the command register
-- ReceivedWordDebug <= Data_Reg when (Mode="bin" OR (Mode="auto" AND Command_Reg(7)='0')) else HexData;
ComActive <= '1' when (PresentState=GetData) else '0';


P_TimeOut:process(clk)
-- im Moment einmal dafür benutzt rauszufinden, ob ComState 'verhungert' und
-- damit die ganze Maschine stehen bleibt
begin
  if clk'event AND clk='1' then
    if (PresentState=Idle) OR 
        ComState=GetStopBit then
         --      Init TimeOut wenn neue Eingangs-Sequenz startet 
         --      oder wenn wieder ein Byte empfangen wurde
         --      um missglückten Empfangsvorgang abzubrechen
      TimeToSendCounter <= TimeToSendValue;
      TimeToSend <= '0';
    elsif TimeToSendCounter>0 then
      TimeToSendCounter <= TimeToSendCounter - 1;
      TimeToSend <= '0';
    else
      TimeToSendCounter <= TimeToSendCounter;
      TimeToSend <= '1'; -- force FSM to go back to idle when inactive
    end if;
  end if; --clk
end process;

end architecture;





