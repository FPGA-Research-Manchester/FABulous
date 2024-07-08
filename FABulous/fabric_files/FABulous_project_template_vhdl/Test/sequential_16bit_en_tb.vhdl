library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use std.env.finish;

entity sequential_16bit_en_tb is
end sequential_16bit_en_tb; 

architecture Behavior of sequential_16bit_en_tb is
  component top is 
    port (
      clk : in std_logic;
      io_out: out std_logic_vector(27 downto 0);
      io_oeb: out std_logic_vector(27 downto 0);
      io_in: in std_logic_vector(27 downto 0)
    );
  end component;

  constant MAX_BITBYTES:integer := 16384;

  
  signal I_top : std_logic_vector( 27 downto 0) := X"0000000";
  signal T_top : std_logic_vector(27 downto 0) := X"0000000";
  signal O_top : std_logic_vector( 27 downto 0) := X"0000001";
  signal A_cfg: std_logic_vector(55 downto 0) :=  X"00000000000000";
  signal B_cfg: std_logic_vector(55 downto 0) :=  X"00000000000000";
  signal C_cfg: std_logic_vector(55 downto 0) :=  X"00000000000000";
  signal I_top_gold : std_logic_vector(27 downto 0) := X"0000000";  
  signal T_top_gold : std_logic_vector(27 downto 0) := X"0000000";  
  signal resetn : std_logic := '1';
  signal CLK : std_logic := '0';  
  signal SelfWriteStrobe : std_logic := '0'; 
  signal SelfWriteData : std_logic_vector(31 downto 0) := X"00000000";  
  signal ComActive : std_logic;  
  signal Rx : std_logic := '1'; 
  signal s_clk : std_logic := '0'; 
  signal s_data : std_logic := '0';  
  signal ReceiveLED : std_logic := '0';  
  
  type bitstream_Type is array (MAX_BITBYTES-1 downto 0) of std_logic_vector(7 downto 0);
  signal bitstream : bitstream_Type;

  signal O_top_unsigned : unsigned(27 downto 0) :=X"0000000";

  impure function readmemh(filename : string) return bitstream_Type is
    variable bs : bitstream_Type;
    file read_file: text open READ_MODE is "../user_design/sequential_16bit_en.hex";
    variable counter : integer := 0;
    variable L: LINE;
    variable temp: std_logic_vector(7 downto 0);
    variable good_v : boolean := true;
    begin
      while not endfile(read_file) loop
        readline (read_file, L);
        hread (L, temp, good_v);
        bs(counter) := temp;
        counter := counter + 1;
      end loop;
    return bs;
  end function;

begin
  O_top_unsigned <= unsigned(O_top);
  init_eFPGA : entity work.eFPGA_top port map (
        I_top => I_top,
        T_top => T_top,
        O_top => O_top,
        A_config_C => A_cfg, 
        B_config_C => B_cfg,
        Config_accessC => C_cfg,
        CLK => CLK, 
        resetn => resetn,
        SelfWriteStrobe => SelfWriteStrobe, 
        SelfWriteData => SelfWriteData,
        Rx => Rx,
        ComActive => ComActive,
        ReceiveLED => ReceiveLED,
        s_clk => s_clk,
        s_data => s_data
    );

    init_top: top 
      port map (
        clk => CLK,
        io_out => I_top_gold,
        io_oeb => T_top_gold,
        io_in => O_top--_unsigned
      );
  

  clock:  process is
          begin
            wait for 5000 ps;
            CLK <= not CLK;
          end process clock;

  final:process is
    variable i : integer := 0;
    variable j : integer := 0; 
  begin
    while i < MAX_BITBYTES loop
      bitstream(i) <= X"00";
      i := i + 1;
    end loop;

    j := 0;
    bitstream <= readmemh("../user_design/sequential_16bit_en.hex");
    report "Bitstream loaded into memory array";
    wait for 100 ps;
    resetn <= '0';
    wait for 10000 ps;
    resetn <= '1';
    wait for 10000 ps;
    for Verilog_Repeat in 1 to 20 loop
      wait until rising_edge(CLK);
    end loop;
    
    wait for 2500 ps;
      
    while j <= MAX_BITBYTES - 4 loop
      SelfWriteData <= bitstream(j) & bitstream(j+1) &  bitstream(j+2) & bitstream(j+3);
      -- wait 2 clock cycles
      wait until rising_edge(CLK);
      wait until rising_edge(CLK);

      -- report integer'image(i) & " " & to_hstring(SelfWriteData); 
      SelfWriteStrobe <= '1';
      wait until rising_edge(CLK);
      SelfWriteStrobe <= '0';

      -- wait another 2 clock cycles
      wait until rising_edge(CLK);
      wait until rising_edge(CLK);

      j := j + 4;
    end loop;

    -- wait 100 clock cycles
    for Verilog_Repeat in 1 to 100 loop
      wait until rising_edge(CLK);
    end loop;
    report "Configuration completed";

    O_top <= X"0000001";
    wait until rising_edge(CLK);

    -- wait 5 clock cycles
    for Verilog_Repeat in 1 to 5 loop
      wait until rising_edge(CLK);
    end loop;

    O_top <= X"0000000";
    for Verilog_Repeat in 1 to 1000 loop
      wait until rising_edge(CLK);
    end loop;

    for Verilog_Repeat in 0 to 100 loop
      wait until falling_edge(CLK);
      report "fabric(I_top) = 0x" & to_hstring(I_top) & " gold = 0x" & to_hstring(I_top_gold) & " fabric(T_top) = 0x" & to_hstring(T_top) & " gold = 0x" & to_hstring(T_top_gold);
      if To_integer(unsigned(I_top)) /= To_integer(unsigned(I_top_gold)) then
        report "Error: Miss match between fabric output and golden " severity error; 
      end if;
    end loop;
    report "SIMULATION FINISHED";
    report "Calling finish";
    finish;
  end process final;
end architecture;

