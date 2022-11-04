-- This VHDL was converted from Verilog using the
-- Icarus Verilog VHDL Code Generator 11.0 (stable) ()

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module LHQD1 (./models_pack.v:54)
entity LHQD1 is
  port (
    D : in std_logic;
    E : in std_logic;
    Q : out std_logic;
    QN : out std_logic
  );
end entity; 

-- Generated from Verilog module LHQD1 (./models_pack.v:54)
architecture from_verilog of LHQD1 is
  signal Q_Reg : std_logic;
  signal QN_Reg : std_logic;
begin
  Q <= Q_Reg;
  QN <= QN_Reg;
  
  -- Generated from always process in LHQD1 (./models_pack.v:55)
  process (E, D) is
  begin
    if E = '1' then
      Q_Reg <= D;
      QN_Reg <= not D;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module MUX16PTv2 (./models_pack.v:93)
entity MUX16PTv2 is
  port (
    IN1 : in std_logic;
    IN10 : in std_logic;
    IN11 : in std_logic;
    IN12 : in std_logic;
    IN13 : in std_logic;
    IN14 : in std_logic;
    IN15 : in std_logic;
    IN16 : in std_logic;
    IN2 : in std_logic;
    IN3 : in std_logic;
    IN4 : in std_logic;
    IN5 : in std_logic;
    IN6 : in std_logic;
    IN7 : in std_logic;
    IN8 : in std_logic;
    IN9 : in std_logic;
    O : out std_logic;
    S1 : in std_logic;
    S2 : in std_logic;
    S3 : in std_logic;
    S4 : in std_logic
  );
end entity; 

-- Generated from Verilog module MUX16PTv2 (./models_pack.v:93)
architecture from_verilog of MUX16PTv2 is
  signal O_Reg : std_logic;
  signal SEL : unsigned(3 downto 0);  -- Declared at ./models_pack.v:116
begin
  O <= O_Reg;
  SEL <= S4 & S3 & S2 & S1;
  
  -- Generated from always process in MUX16PTv2 (./models_pack.v:119)
  process (SEL, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15, IN16) is
  begin
    case SEL is
      when X"0" =>
        O_Reg <= IN1;
      when X"1" =>
        O_Reg <= IN2;
      when X"2" =>
        O_Reg <= IN3;
      when X"3" =>
        O_Reg <= IN4;
      when X"4" =>
        O_Reg <= IN5;
      when X"5" =>
        O_Reg <= IN6;
      when X"6" =>
        O_Reg <= IN7;
      when X"7" =>
        O_Reg <= IN8;
      when X"8" =>
        O_Reg <= IN9;
      when X"9" =>
        O_Reg <= IN10;
      when X"a" =>
        O_Reg <= IN11;
      when X"b" =>
        O_Reg <= IN12;
      when X"c" =>
        O_Reg <= IN13;
      when X"d" =>
        O_Reg <= IN14;
      when X"e" =>
        O_Reg <= IN15;
      when X"f" =>
        O_Reg <= IN16;
      when others =>
        O_Reg <= '0';
    end case;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module MUX4PTv4 (./models_pack.v:68)
entity MUX4PTv4 is
  port (
    IN1 : in std_logic;
    IN2 : in std_logic;
    IN3 : in std_logic;
    IN4 : in std_logic;
    O : out std_logic;
    S1 : in std_logic;
    S2 : in std_logic
  );
end entity; 

-- Generated from Verilog module MUX4PTv4 (./models_pack.v:68)
architecture from_verilog of MUX4PTv4 is
  signal O_Reg : std_logic;
  signal SEL : unsigned(1 downto 0);  -- Declared at ./models_pack.v:77
begin
  O <= O_Reg;
  SEL <= S2 & S1;
  
  -- Generated from always process in MUX4PTv4 (./models_pack.v:80)
  process (SEL, IN1, IN2, IN3, IN4) is
  begin
    case SEL is
      when "00" =>
        O_Reg <= IN1;
      when "01" =>
        O_Reg <= IN2;
      when "10" =>
        O_Reg <= IN3;
      when "11" =>
        O_Reg <= IN4;
      when others =>
        O_Reg <= '0';
    end case;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux161 (./models_pack.v:325)
entity cus_mux161 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A10 : in std_logic;
    A11 : in std_logic;
    A12 : in std_logic;
    A13 : in std_logic;
    A14 : in std_logic;
    A15 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    A8 : in std_logic;
    A9 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    S3 : in std_logic;
    S3N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux161 (./models_pack.v:325)
architecture from_verilog of cus_mux161 is
  signal cus_mux41_out0 : std_logic;  -- Declared at ./models_pack.v:352
  signal cus_mux41_out1 : std_logic;  -- Declared at ./models_pack.v:353
  signal cus_mux41_out2 : std_logic;  -- Declared at ./models_pack.v:354
  signal cus_mux41_out3 : std_logic;  -- Declared at ./models_pack.v:355
  
  component cus_mux41 is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      A2 : in std_logic;
      A3 : in std_logic;
      S0 : in std_logic;
      S0N : in std_logic;
      S1 : in std_logic;
      S1N : in std_logic;
      X : out std_logic
    );
  end component;
  signal X_Readable : std_logic;  -- Needed to connect outputs
begin
  
  -- Generated from instantiation at ./models_pack.v:357
  cus_mux41_inst0: cus_mux41
    port map (
      A0 => A0,
      A1 => A1,
      A2 => A2,
      A3 => A3,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out0
    );
  
  -- Generated from instantiation at ./models_pack.v:369
  cus_mux41_inst1: cus_mux41
    port map (
      A0 => A4,
      A1 => A5,
      A2 => A6,
      A3 => A7,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out1
    );
  
  -- Generated from instantiation at ./models_pack.v:381
  cus_mux41_inst2: cus_mux41
    port map (
      A0 => A8,
      A1 => A9,
      A2 => A10,
      A3 => A11,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out2
    );
  
  -- Generated from instantiation at ./models_pack.v:393
  cus_mux41_inst3: cus_mux41
    port map (
      A0 => A12,
      A1 => A13,
      A2 => A14,
      A3 => A15,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out3
    );
  X <= X_Readable;
  
  -- Generated from instantiation at ./models_pack.v:405
  cus_mux41_inst4: cus_mux41
    port map (
      A0 => cus_mux41_out0,
      A1 => cus_mux41_out1,
      A2 => cus_mux41_out2,
      A3 => cus_mux41_out3,
      S0 => S2,
      S0N => S2N,
      S1 => S3,
      S1N => S3N,
      X => X_Readable
    );
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux41 (./models_pack.v:150)
entity cus_mux41 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux41 (./models_pack.v:150)
architecture from_verilog of cus_mux41 is
  signal X_Reg : std_logic;
  signal SEL : unsigned(1 downto 0);  -- Declared at ./models_pack.v:161
  signal LPM_d0_ivl_1 : std_logic;
  signal LPM_d1_ivl_1 : std_logic;
begin
  X <= X_Reg;
  SEL <= S1 & S0;
  
  -- Generated from always process in cus_mux41 (./models_pack.v:164)
  process (SEL, A0, A1, A2, A3) is
  begin
    case SEL is
      when "00" =>
        X_Reg <= A0;
      when "01" =>
        X_Reg <= A1;
      when "10" =>
        X_Reg <= A2;
      when "11" =>
        X_Reg <= A3;
      when others =>
        X_Reg <= '0';
    end case;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux161_buf (./models_pack.v:418)
entity cus_mux161_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A10 : in std_logic;
    A11 : in std_logic;
    A12 : in std_logic;
    A13 : in std_logic;
    A14 : in std_logic;
    A15 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    A8 : in std_logic;
    A9 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    S3 : in std_logic;
    S3N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux161_buf (./models_pack.v:418)
architecture from_verilog of cus_mux161_buf is
  signal cus_mux41_buf_out0 : std_logic;  -- Declared at ./models_pack.v:445
  signal cus_mux41_buf_out1 : std_logic;  -- Declared at ./models_pack.v:446
  signal cus_mux41_buf_out2 : std_logic;  -- Declared at ./models_pack.v:447
  signal cus_mux41_buf_out3 : std_logic;  -- Declared at ./models_pack.v:448
  
  component cus_mux41_buf is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      A2 : in std_logic;
      A3 : in std_logic;
      S0 : in std_logic;
      S0N : in std_logic;
      S1 : in std_logic;
      S1N : in std_logic;
      X : out std_logic
    );
  end component;
  signal X_Readable : std_logic;  -- Needed to connect outputs
begin
  
  -- Generated from instantiation at ./models_pack.v:450
  cus_mux41_buf_inst0: cus_mux41_buf
    port map (
      A0 => A0,
      A1 => A1,
      A2 => A2,
      A3 => A3,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out0
    );
  
  -- Generated from instantiation at ./models_pack.v:462
  cus_mux41_buf_inst1: cus_mux41_buf
    port map (
      A0 => A4,
      A1 => A5,
      A2 => A6,
      A3 => A7,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out1
    );
  
  -- Generated from instantiation at ./models_pack.v:474
  cus_mux41_buf_inst2: cus_mux41_buf
    port map (
      A0 => A8,
      A1 => A9,
      A2 => A10,
      A3 => A11,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out2
    );
  
  -- Generated from instantiation at ./models_pack.v:486
  cus_mux41_buf_inst3: cus_mux41_buf
    port map (
      A0 => A12,
      A1 => A13,
      A2 => A14,
      A3 => A15,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out3
    );
  X <= X_Readable;
  
  -- Generated from instantiation at ./models_pack.v:498
  cus_mux41_buf_inst4: cus_mux41_buf
    port map (
      A0 => cus_mux41_buf_out0,
      A1 => cus_mux41_buf_out1,
      A2 => cus_mux41_buf_out2,
      A3 => cus_mux41_buf_out3,
      S0 => S2,
      S0N => S2N,
      S1 => S3,
      S1N => S3N,
      X => X_Readable
    );
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux41_buf (./models_pack.v:176)
entity cus_mux41_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux41_buf (./models_pack.v:176)
architecture from_verilog of cus_mux41_buf is
  signal X_Reg : std_logic;
  signal SEL : unsigned(1 downto 0);  -- Declared at ./models_pack.v:187
  signal LPM_d0_ivl_1 : std_logic;
  signal LPM_d1_ivl_1 : std_logic;
begin
  X <= X_Reg;
  SEL <= S1 & S0;
  
  -- Generated from always process in cus_mux41_buf (./models_pack.v:190)
  process (SEL, A0, A1, A2, A3) is
  begin
    case SEL is
      when "00" =>
        X_Reg <= A0;
      when "01" =>
        X_Reg <= A1;
      when "10" =>
        X_Reg <= A2;
      when "11" =>
        X_Reg <= A3;
      when others =>
        X_Reg <= '0';
    end case;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux81 (./models_pack.v:221)
entity cus_mux81 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux81 (./models_pack.v:221)
architecture from_verilog of cus_mux81 is
  signal cus_mux41_out0 : std_logic;  -- Declared at ./models_pack.v:238
  signal cus_mux41_out1 : std_logic;  -- Declared at ./models_pack.v:239
  
  component cus_mux41 is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      A2 : in std_logic;
      A3 : in std_logic;
      S0 : in std_logic;
      S0N : in std_logic;
      S1 : in std_logic;
      S1N : in std_logic;
      X : out std_logic
    );
  end component;
  
  component my_mux2 is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      S : in std_logic;
      X : out std_logic
    );
  end component;
  signal X_Readable : std_logic;  -- Needed to connect outputs
begin
  
  -- Generated from instantiation at ./models_pack.v:241
  cus_mux41_inst0: cus_mux41
    port map (
      A0 => A0,
      A1 => A1,
      A2 => A2,
      A3 => A3,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out0
    );
  
  -- Generated from instantiation at ./models_pack.v:253
  cus_mux41_inst1: cus_mux41
    port map (
      A0 => A4,
      A1 => A5,
      A2 => A6,
      A3 => A7,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_out1
    );
  X <= X_Readable;
  
  -- Generated from instantiation at ./models_pack.v:265
  my_mux2_inst: my_mux2
    port map (
      A0 => cus_mux41_out0,
      A1 => cus_mux41_out1,
      S => S2,
      X => X_Readable
    );
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module my_mux2 (./models_pack.v:202)
entity my_mux2 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    S : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module my_mux2 (./models_pack.v:202)
architecture from_verilog of my_mux2 is
  signal X_Reg : std_logic;
  signal SEL : std_logic;  -- Declared at ./models_pack.v:208
begin
  X <= X_Reg;
  SEL <= S;
  
  -- Generated from always process in my_mux2 (./models_pack.v:211)
  process (SEL, A0, A1) is
  begin
    case SEL is
      when '0' =>
        X_Reg <= A0;
      when '1' =>
        X_Reg <= A1;
      when others =>
        X_Reg <= '0';
    end case;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module cus_mux81_buf (./models_pack.v:273)
entity cus_mux81_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module cus_mux81_buf (./models_pack.v:273)
architecture from_verilog of cus_mux81_buf is
  signal cus_mux41_buf_out0 : std_logic;  -- Declared at ./models_pack.v:290
  signal cus_mux41_buf_out1 : std_logic;  -- Declared at ./models_pack.v:291
  
  component cus_mux41_buf is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      A2 : in std_logic;
      A3 : in std_logic;
      S0 : in std_logic;
      S0N : in std_logic;
      S1 : in std_logic;
      S1N : in std_logic;
      X : out std_logic
    );
  end component;
  
  component my_mux2 is
    port (
      A0 : in std_logic;
      A1 : in std_logic;
      S : in std_logic;
      X : out std_logic
    );
  end component;
  signal X_Readable : std_logic;  -- Needed to connect outputs
begin
  
  -- Generated from instantiation at ./models_pack.v:293
  cus_mux41_buf_inst0: cus_mux41_buf
    port map (
      A0 => A0,
      A1 => A1,
      A2 => A2,
      A3 => A3,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out0
    );
  
  -- Generated from instantiation at ./models_pack.v:305
  cus_mux41_buf_inst1: cus_mux41_buf
    port map (
      A0 => A4,
      A1 => A5,
      A2 => A6,
      A3 => A7,
      S0 => S0,
      S0N => S0N,
      S1 => S1,
      S1N => S1N,
      X => cus_mux41_buf_out1
    );
  X <= X_Readable;
  
  -- Generated from instantiation at ./models_pack.v:317
  my_mux2_inst: my_mux2
    port map (
      A0 => cus_mux41_buf_out0,
      A1 => cus_mux41_buf_out1,
      S => S2,
      X => X_Readable
    );
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module my_buf (./models_pack.v:144)
entity my_buf is
  port (
    A : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module my_buf (./models_pack.v:144)
architecture from_verilog of my_buf is
begin
  X <= A;
end architecture;

-- Generated from Verilog module clk_buf (fabulous_tb.v:83)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity clk_buf is
  port (
    A : in std_logic;
    X : out std_logic
  );
end entity; 

-- Generated from Verilog module clk_buf (fabulous_tb.v:83)
architecture Behavior of clk_buf is
begin
  X <= A;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

package my_package is 

component LHQD1 is
  port (
    D : in std_logic;
    E : in std_logic;
    Q : out std_logic;
    QN : out std_logic
  );
end component;

component MUX16PTv2 is
  port (
    IN1 : in std_logic;
    IN10 : in std_logic;
    IN11 : in std_logic;
    IN12 : in std_logic;
    IN13 : in std_logic;
    IN14 : in std_logic;
    IN15 : in std_logic;
    IN16 : in std_logic;
    IN2 : in std_logic;
    IN3 : in std_logic;
    IN4 : in std_logic;
    IN5 : in std_logic;
    IN6 : in std_logic;
    IN7 : in std_logic;
    IN8 : in std_logic;
    IN9 : in std_logic;
    O : out std_logic;
    S1 : in std_logic;
    S2 : in std_logic;
    S3 : in std_logic;
    S4 : in std_logic
  );
end component;

component MUX4PTv4 is
  port (
    IN1 : in std_logic;
    IN2 : in std_logic;
    IN3 : in std_logic;
    IN4 : in std_logic;
    O : out std_logic;
    S1 : in std_logic;
    S2 : in std_logic
  );
end component; 

component cus_mux161 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A10 : in std_logic;
    A11 : in std_logic;
    A12 : in std_logic;
    A13 : in std_logic;
    A14 : in std_logic;
    A15 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    A8 : in std_logic;
    A9 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    S3 : in std_logic;
    S3N : in std_logic;
    X : out std_logic
  );
end component; 

component cus_mux41 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    X : out std_logic
  );
end component; 

component cus_mux161_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A10 : in std_logic;
    A11 : in std_logic;
    A12 : in std_logic;
    A13 : in std_logic;
    A14 : in std_logic;
    A15 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    A8 : in std_logic;
    A9 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    S3 : in std_logic;
    S3N : in std_logic;
    X : out std_logic
  );
end component; 

component cus_mux41_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    X : out std_logic
  );
end component; 

component cus_mux81 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    X : out std_logic
  );
end component; 

component my_mux2 is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    S : in std_logic;
    X : out std_logic
  );
end component; 

component cus_mux81_buf is
  port (
    A0 : in std_logic;
    A1 : in std_logic;
    A2 : in std_logic;
    A3 : in std_logic;
    A4 : in std_logic;
    A5 : in std_logic;
    A6 : in std_logic;
    A7 : in std_logic;
    S0 : in std_logic;
    S0N : in std_logic;
    S1 : in std_logic;
    S1N : in std_logic;
    S2 : in std_logic;
    S2N : in std_logic;
    X : out std_logic
  );
end component; 

component my_buf is
  port (
    A : in std_logic;
    X : out std_logic
  );
end component; 

component clk_buf is
  port (
    A : in std_logic;
    X : out std_logic
  );
end component; 

end package my_package;