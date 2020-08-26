### Read Fabric csv file ###
### Script command arguments are:
 ['R:\\work\\FORTE\\FPGA\\fabric\\gen.py', '-GenTileSwitchMatrixCSV']
### Generate initial switch matrix template (has to be bootstrapped first)
### generate csv for tile  N_term  # filename: N_term_switch_matrix.csv
### generate csv for tile  N_term_IO  # filename: N_term_IO_switch_matrix.csv
### generate csv for tile  W_term  # filename: W_term_switch_matrix.csv
### generate csv for tile  CLB  # filename: CLB_switch_matrix.csv
### generate csv for tile  IO  # filename: IO_switch_matrix.csv
### generate csv for tile  E_term  # filename: E_term_switch_matrix.csv
### generate csv for tile  S_term  # filename: S_term_switch_matrix.csv
### generate csv for tile  S_term_IO  # filename: S_term_IO_switch_matrix.csv
Comparing files R:\WORK\FORTE\FPGA\FABRIC\CLB_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_SWITCH_MATRIX.CSV
FC: no differences encountered

Comparing files R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.CSV
FC: no differences encountered

Comparing files R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.CSV
FC: no differences encountered

Comparing files R:\WORK\FORTE\FPGA\FABRIC\S_term_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_SWITCH_MATRIX.CSV
FC: no differences encountered

Comparing files R:\WORK\FORTE\FPGA\FABRIC\W_term_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_SWITCH_MATRIX.CSV
FC: no differences encountered

Comparing files R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv
3,S1END4,S2END0,S2END1,S2END2,S2END3,S2END4,W1END0,W1END1,W1END2,W1END3,W1END4,W1END5,W2END0,W2END1,W2END2,W2END3,W2END4,W2END5
,O0,Q0,O1,Q1,O2,Q2,O3,Q3,IJ_END0,IJ_END1,IJ_END2,IJ_END3,IJ_END4,IJ_END5,IJ_END6,IJ_END7,IJ_END8,IJ_END9,IJ_END10,IJ_END11,IJ_E
ND12,OJ_END0,OJ_END1,OJ_END2,OJ_END3,OJ_END4,OJ_END5,OJ_END6
N1BEG0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
3,S1END4,S2END0,S2END1,S2END2,S2END3,S2END4,W1END0,W1END1,W1END2,W1END3,W1END4,W1END5,W2END0,W2END1,W2END2,W2END3,W2END4,W2END5
,I0,IQ0,I1,IQ1,I2,IQ2,I3,IQ3,IJ_END0,IJ_END1,IJ_END2,IJ_END3,IJ_END4,IJ_END5,IJ_END6,IJ_END7,IJ_END8,IJ_END9,IJ_END10,IJ_END11,
IJ_END12,OJ_END0,OJ_END1,OJ_END2,OJ_END3,OJ_END4,OJ_END5,OJ_END6
N1BEG0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv
0,0,0,0
I0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
0,0,0,0
O0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv
0,0
I1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
0,0
O1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv
0,0
I2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
0,0
O2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.csv
0,0
I3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.CSV
0,0
O3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0
*****

### Read Fabric csv file ###
### Script command arguments are:
 ['R:\\work\\FORTE\\FPGA\\fabric\\gen.py', '-GenTileSwitchMatrixVHDL']
### Generate initial switch matrix VHDL code
### generate VHDL for tile  N_term  # filename: N_term_switch_matrix.vhdl
### Read  N_term  csv file ###
### generate VHDL for tile  N_term_IO  # filename: N_term_IO_switch_matrix.vhdl
### Read  N_term_IO  csv file ###
### generate VHDL for tile  W_term  # filename: W_term_switch_matrix.vhdl
### Read  W_term  csv file ###
### generate VHDL for tile  CLB  # filename: CLB_switch_matrix.vhdl
### Read  CLB  csv file ###
### generate VHDL for tile  IO  # filename: IO_switch_matrix.vhdl
### Read  IO  csv file ###
### generate VHDL for tile  E_term  # filename: E_term_switch_matrix.vhdl
### Read  E_term  csv file ###
### generate VHDL for tile  S_term  # filename: S_term_switch_matrix.vhdl
### Read  S_term  csv file ###
### generate VHDL for tile  S_term_IO  # filename: S_term_IO_switch_matrix.vhdl
### Read  S_term_IO  csv file ###
Comparing files R:\WORK\FORTE\FPGA\FABRIC\CLB_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\CLB_switch_matrix.vhdl
-- NumberOfConfigBits:182
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\CLB_switch_matrix.vhdl

-- The configuration bits (if any) are just a long shift register
signal   ConfigBits :    unsigned( 182-1 downto 0 );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_SWITCH_MATRIX.VHDL

-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 182-1 downto 0 );
*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl
-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl
                  S2BEG3        : out    STD_LOGIC;
                  S2BEG4        : out    STD_LOGIC
        -- global
        );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL
                  S2BEG3        : out    STD_LOGIC;
                  S2BEG4        : out    STD_LOGIC;
        -- global
                 MODE   : in     STD_LOGIC;      -- global signal 1: configuration, 0: operation
                 CONFin : in     STD_LOGIC;
                 CONFout        : out    STD_LOGIC;
                 CLK    : in     STD_LOGIC
        );
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl

-- The configuration bits (if any) are just a long shift register

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL

-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 0-1 downto 0 );

*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl

-- switch matrix multiplexer  S1BEG0            MUX-1
S1BEG0   <=      N1END0 ;
-- switch matrix multiplexer  S1BEG1            MUX-1
S1BEG1   <=      N1END1 ;
-- switch matrix multiplexer  S1BEG2            MUX-1
S1BEG2   <=      N1END2 ;
-- switch matrix multiplexer  S1BEG3            MUX-1
S1BEG3   <=      N2END0 ;
-- switch matrix multiplexer  S1BEG4            MUX-1
S1BEG4   <=      N2END1 ;
-- switch matrix multiplexer  S2BEG0            MUX-1
S2BEG0   <=      N2END2 ;
-- switch matrix multiplexer  S2BEG1            MUX-1
S2BEG1   <=      N4END0 ;
-- switch matrix multiplexer  S2BEG2            MUX-1
S2BEG2   <=      N4END1 ;
-- switch matrix multiplexer  S2BEG3            MUX-1
S2BEG3   <=      N4END1 ;
-- switch matrix multiplexer  S2BEG4            MUX-1
S2BEG4   <=      N4END0 ;

end architecture Behavioral;

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL

-- the configuration bits shift register                                    
process(CLK)                                                                
begin                                                                       
        if CLK'event and CLK='1' then                                        
                if mode='1' then        --configuration mode                             
                        ConfigBits <= CONFin & ConfigBits(ConfigBits'high downto 1);   
                end if;                                                             
        end if;                                                                 
end process;                                                                
CONFout <= ConfigBits(ConfigBits'high);                                    
 

*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_switch_matrix.vhdl
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_SWITCH_MATRIX.VHDL
-- switch matrix multiplexer  S1BEG0            MUX-0
-- WARNING unused multiplexer MUX-S1BEG0
-- switch matrix multiplexer  S1BEG1            MUX-0
-- WARNING unused multiplexer MUX-S1BEG1
-- switch matrix multiplexer  S1BEG2            MUX-0
-- WARNING unused multiplexer MUX-S1BEG2
-- switch matrix multiplexer  S1BEG3            MUX-0
-- WARNING unused multiplexer MUX-S1BEG3
-- switch matrix multiplexer  S1BEG4            MUX-0
-- WARNING unused multiplexer MUX-S1BEG4
-- switch matrix multiplexer  S2BEG0            MUX-0
-- WARNING unused multiplexer MUX-S2BEG0
-- switch matrix multiplexer  S2BEG1            MUX-0
-- WARNING unused multiplexer MUX-S2BEG1
-- switch matrix multiplexer  S2BEG2            MUX-0
-- WARNING unused multiplexer MUX-S2BEG2
-- switch matrix multiplexer  S2BEG3            MUX-0
-- WARNING unused multiplexer MUX-S2BEG3
-- switch matrix multiplexer  S2BEG4            MUX-0
-- WARNING unused multiplexer MUX-S2BEG4

end architecture Behavioral;

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl
-- NumberOfConfigBits:0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl
                  W2BEG4        : out    STD_LOGIC;
                  W2BEG5        : out    STD_LOGIC
        -- global
        );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL
                  W2BEG4        : out    STD_LOGIC;
                  W2BEG5        : out    STD_LOGIC;
        -- global
                 MODE   : in     STD_LOGIC;      -- global signal 1: configuration, 0: operation
                 CONFin : in     STD_LOGIC;
                 CONFout        : out    STD_LOGIC;
                 CLK    : in     STD_LOGIC
        );
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl

-- The configuration bits (if any) are just a long shift register

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL

-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 0-1 downto 0 );

*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl

-- switch matrix multiplexer  W1BEG0            MUX-1
W1BEG0   <=      E1END0 ;
-- switch matrix multiplexer  W1BEG1            MUX-1
W1BEG1   <=      E1END1 ;
-- switch matrix multiplexer  W1BEG2            MUX-1
W1BEG2   <=      E1END2 ;
-- switch matrix multiplexer  W1BEG3            MUX-1
W1BEG3   <=      E1END3 ;
-- switch matrix multiplexer  W1BEG4            MUX-1
W1BEG4   <=      E2END0 ;
-- switch matrix multiplexer  W1BEG5            MUX-1
W1BEG5   <=      E2END1 ;
-- switch matrix multiplexer  W2BEG0            MUX-1
W2BEG0   <=      E2END2 ;
-- switch matrix multiplexer  W2BEG1            MUX-1
W2BEG1   <=      E2END3 ;
-- switch matrix multiplexer  W2BEG2            MUX-1
W2BEG2   <=      E2END0 ;
-- switch matrix multiplexer  W2BEG3            MUX-1
W2BEG3   <=      E2END1 ;
-- switch matrix multiplexer  W2BEG4            MUX-1
W2BEG4   <=      E2END2 ;
-- switch matrix multiplexer  W2BEG5            MUX-1
W2BEG5   <=      E2END3 ;

end architecture Behavioral;

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL

-- the configuration bits shift register                                    
process(CLK)                                                                
begin                                                                       
        if CLK'event and CLK='1' then                                        
                if mode='1' then        --configuration mode                             
                        ConfigBits <= CONFin & ConfigBits(ConfigBits'high downto 1);   
                end if;                                                             
        end if;                                                                 
end process;                                                                
CONFout <= ConfigBits(ConfigBits'high);                                    
 

*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_switch_matrix.vhdl
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_SWITCH_MATRIX.VHDL
-- switch matrix multiplexer  W1BEG0            MUX-0
-- WARNING unused multiplexer MUX-W1BEG0
-- switch matrix multiplexer  W1BEG1            MUX-0
-- WARNING unused multiplexer MUX-W1BEG1
-- switch matrix multiplexer  W1BEG2            MUX-0
-- WARNING unused multiplexer MUX-W1BEG2
-- switch matrix multiplexer  W1BEG3            MUX-0
-- WARNING unused multiplexer MUX-W1BEG3
-- switch matrix multiplexer  W1BEG4            MUX-0
-- WARNING unused multiplexer MUX-W1BEG4
-- switch matrix multiplexer  W1BEG5            MUX-0
-- WARNING unused multiplexer MUX-W1BEG5
-- switch matrix multiplexer  W2BEG0            MUX-0
-- WARNING unused multiplexer MUX-W2BEG0
-- switch matrix multiplexer  W2BEG1            MUX-0
-- WARNING unused multiplexer MUX-W2BEG1
-- switch matrix multiplexer  W2BEG2            MUX-0
-- WARNING unused multiplexer MUX-W2BEG2
-- switch matrix multiplexer  W2BEG3            MUX-0
-- WARNING unused multiplexer MUX-W2BEG3
-- switch matrix multiplexer  W2BEG4            MUX-0
-- WARNING unused multiplexer MUX-W2BEG4
-- switch matrix multiplexer  W2BEG5            MUX-0
-- WARNING unused multiplexer MUX-W2BEG5

end architecture Behavioral;

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\S_term_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\S_term_switch_matrix.vhdl
-- NumberOfConfigBits:2
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_switch_matrix.vhdl

signal    N2BEG2_input  :        std_logic_vector( 2 - 1 downto 0 );
signal    N4BEG0_input  :        std_logic_vector( 2 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register
signal   ConfigBits :    unsigned( 2-1 downto 0 );

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_SWITCH_MATRIX.VHDL


-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 0-1 downto 0 );

*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_switch_matrix.vhdl

-- switch matrix multiplexer  N1BEG0            MUX-1
N1BEG0   <=      S1END0 ;
-- switch matrix multiplexer  N1BEG1            MUX-1
N1BEG1   <=      S1END1 ;
-- switch matrix multiplexer  N1BEG2            MUX-1
N1BEG2   <=      S1END2 ;
-- switch matrix multiplexer  N2BEG0            MUX-1
N2BEG0   <=      S1END3 ;
-- switch matrix multiplexer  N2BEG1            MUX-1
N2BEG1   <=      S1END4 ;
-- switch matrix multiplexer  N2BEG2            MUX-2
N2BEG2_input     <= S2END4 & S2END0;
N2BEG2  <= N2BEG2_input(TO_INTEGER(ConfigBits(0 downto 0)));
 
-- switch matrix multiplexer  N4BEG0            MUX-2
N4BEG0_input     <= S2END3 & S2END1;
N4BEG0  <= N4BEG0_input(TO_INTEGER(ConfigBits(1 downto 1)));
 
-- switch matrix multiplexer  N4BEG1            MUX-1
N4BEG1   <=      S2END2 ;

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_SWITCH_MATRIX.VHDL

-- switch matrix multiplexer  N1BEG0            MUX-0
-- WARNING unused multiplexer MUX-N1BEG0
-- switch matrix multiplexer  N1BEG1            MUX-0
-- WARNING unused multiplexer MUX-N1BEG1
-- switch matrix multiplexer  N1BEG2            MUX-0
-- WARNING unused multiplexer MUX-N1BEG2
-- switch matrix multiplexer  N2BEG0            MUX-0
-- WARNING unused multiplexer MUX-N2BEG0
-- switch matrix multiplexer  N2BEG1            MUX-0
-- WARNING unused multiplexer MUX-N2BEG1
-- switch matrix multiplexer  N2BEG2            MUX-0
-- WARNING unused multiplexer MUX-N2BEG2
-- switch matrix multiplexer  N4BEG0            MUX-0
-- WARNING unused multiplexer MUX-N4BEG0
-- switch matrix multiplexer  N4BEG1            MUX-0
-- WARNING unused multiplexer MUX-N4BEG1

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\W_term_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\W_term_switch_matrix.vhdl
-- NumberOfConfigBits:4
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_switch_matrix.vhdl

signal    E2BEG2_input  :        std_logic_vector( 3 - 1 downto 0 );
signal    E2BEG3_input  :        std_logic_vector( 3 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register
signal   ConfigBits :    unsigned( 4-1 downto 0 );

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_SWITCH_MATRIX.VHDL


-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 0-1 downto 0 );

*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_switch_matrix.vhdl

-- switch matrix multiplexer  E1BEG0            MUX-1
E1BEG0   <=      W1END0 ;
-- switch matrix multiplexer  E1BEG1            MUX-1
E1BEG1   <=      W1END1 ;
-- switch matrix multiplexer  E1BEG2            MUX-1
E1BEG2   <=      W1END2 ;
-- switch matrix multiplexer  E1BEG3            MUX-1
E1BEG3   <=      W1END3 ;
-- switch matrix multiplexer  E2BEG0            MUX-1
E2BEG0   <=      W1END4 ;
-- switch matrix multiplexer  E2BEG1            MUX-1
E2BEG1   <=      W1END5 ;
-- switch matrix multiplexer  E2BEG2            MUX-3
E2BEG2_input     <= W2END4 & W2END2 & W2END0;
E2BEG2  <= E2BEG2_input(TO_INTEGER(ConfigBits(1 downto 0)));
 
-- switch matrix multiplexer  E2BEG3            MUX-3
E2BEG3_input     <= W2END5 & W2END3 & W2END1;
E2BEG3  <= E2BEG3_input(TO_INTEGER(ConfigBits(3 downto 2)));
 

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_SWITCH_MATRIX.VHDL

-- switch matrix multiplexer  E1BEG0            MUX-0
-- WARNING unused multiplexer MUX-E1BEG0
-- switch matrix multiplexer  E1BEG1            MUX-0
-- WARNING unused multiplexer MUX-E1BEG1
-- switch matrix multiplexer  E1BEG2            MUX-0
-- WARNING unused multiplexer MUX-E1BEG2
-- switch matrix multiplexer  E1BEG3            MUX-0
-- WARNING unused multiplexer MUX-E1BEG3
-- switch matrix multiplexer  E2BEG0            MUX-0
-- WARNING unused multiplexer MUX-E2BEG0
-- switch matrix multiplexer  E2BEG1            MUX-0
-- WARNING unused multiplexer MUX-E2BEG1
-- switch matrix multiplexer  E2BEG2            MUX-0
-- WARNING unused multiplexer MUX-E2BEG2
-- switch matrix multiplexer  E2BEG3            MUX-0
-- WARNING unused multiplexer MUX-E2BEG3

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.vhdl
-- NumberOfConfigBits:214
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.vhdl

signal    N1BEG0_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    N1BEG1_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    N1BEG2_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    N2BEG0_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    N2BEG1_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    N2BEG2_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    E1BEG0_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    E1BEG1_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    E1BEG2_input  :        std_logic_vector( 13 - 1 downto 0 );
signal    E1BEG3_input  :        std_logic_vector( 9 - 1 downto 0 );
signal    E2BEG0_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    E2BEG1_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    E2BEG2_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    E2BEG3_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S1BEG0_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S1BEG1_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S1BEG2_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S1BEG3_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S1BEG4_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S2BEG0_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S2BEG1_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S2BEG2_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S2BEG3_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    S2BEG4_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG0_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG1_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG2_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG3_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG4_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W1BEG5_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG0_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG1_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG2_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG3_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG4_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    W2BEG5_input  :        std_logic_vector( 5 - 1 downto 0 );
signal    O0_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    T0_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    O1_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    T1_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    O2_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    T2_input      :        std_logic_vector( 9 - 1 downto 0 );
signal    O3_input      :        std_logic_vector( 11 - 1 downto 0 );
signal    T3_input      :        std_logic_vector( 10 - 1 downto 0 );
signal    IJ_BEG0_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG1_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG2_input         :        std_logic_vector( 4 - 1 downto 0 );
signal    IJ_BEG3_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG4_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG5_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG6_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG7_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG8_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG9_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG10_input        :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG11_input        :        std_logic_vector( 8 - 1 downto 0 );
signal    IJ_BEG12_input        :        std_logic_vector( 12 - 1 downto 0 );
signal    OJ_BEG0_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    OJ_BEG1_input         :        std_logic_vector( 12 - 1 downto 0 );
signal    OJ_BEG2_input         :        std_logic_vector( 12 - 1 downto 0 );
signal    OJ_BEG3_input         :        std_logic_vector( 12 - 1 downto 0 );
signal    OJ_BEG4_input         :        std_logic_vector( 12 - 1 downto 0 );
signal    OJ_BEG5_input         :        std_logic_vector( 8 - 1 downto 0 );
signal    OJ_BEG6_input         :        std_logic_vector( 8 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register
signal   ConfigBits :    unsigned( 214-1 downto 0 );

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.VHDL


-- The configuration bits are just a long shift register
signal   ConfigBits :    unsigned( 0-1 downto 0 );

*****

Resync Failed.  Files are too different.
***** R:\WORK\FORTE\FPGA\FABRIC\IO_switch_matrix.vhdl

-- switch matrix multiplexer  N1BEG0            MUX-13
N1BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & I1 & IQ0 & I0 & W2END5 & N2END0 & N1END2 & N1END1 & N1END
0;
N1BEG0  <= N1BEG0_input(TO_INTEGER(ConfigBits(3 downto 0)));
 
-- switch matrix multiplexer  N1BEG1            MUX-13
N1BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IQ1 & I1 & IQ0 & I0 & N2END1 & N2END0 & N1END2 & N1END1;
N1BEG1  <= N1BEG1_input(TO_INTEGER(ConfigBits(7 downto 4)));
 
-- switch matrix multiplexer  N1BEG2            MUX-13
N1BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & I2 & IQ1 & I1 & IQ0 & N2END2 & N2END1 & N2END0 & N1END2;
N1BEG2  <= N1BEG2_input(TO_INTEGER(ConfigBits(11 downto 8)));
 
-- switch matrix multiplexer  N2BEG0            MUX-13
N2BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IQ2 & I2 & IQ1 & I1 & E1END0 & N2END2 & N2END1 & N2END0;
N2BEG0  <= N2BEG0_input(TO_INTEGER(ConfigBits(15 downto 12)));
 
-- switch matrix multiplexer  N2BEG1            MUX-13
N2BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & I3 & IQ2 & I2 & IQ1 & E1END1 & E1END0 & N2END2 & N2END1;
N2BEG1  <= N2BEG1_input(TO_INTEGER(ConfigBits(19 downto 16)));
 
-- switch matrix multiplexer  N2BEG2            MUX-13
N2BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IQ3 & I3 & IQ2 & I2 & E1END2 & E1END1 & E1END0 & N2END2;
N2BEG2  <= N2BEG2_input(TO_INTEGER(ConfigBits(23 downto 20)));
 
-- switch matrix multiplexer  E1BEG0            MUX-13
E1BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END0 & IQ3 & I3 & IQ2 & E1END3 & E1END2 & E1END1 & E1E
ND0;
E1BEG0  <= E1BEG0_input(TO_INTEGER(ConfigBits(27 downto 24)));
 
-- switch matrix multiplexer  E1BEG1            MUX-13
E1BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END1 & IJ_END0 & IQ3 & I3 & E2END0 & E1END3 & E1END2 &
 E1END1;
E1BEG1  <= E1BEG1_input(TO_INTEGER(ConfigBits(31 downto 28)));
 
-- switch matrix multiplexer  E1BEG2            MUX-13
E1BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & IJ_END2 & IJ_END1 & IJ_END0 & IQ3 & E2END1 & E2END0 & E1E
ND3 & E1END2;
E1BEG2  <= E1BEG2_input(TO_INTEGER(ConfigBits(35 downto 32)));
 
-- switch matrix multiplexer  E1BEG3            MUX-9
E1BEG3_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0 & E2END2 & E2END1 & E2END0 & E1END3;
E1BEG3  <= E1BEG3_input(TO_INTEGER(ConfigBits(39 downto 36)));
 
-- switch matrix multiplexer  E2BEG0            MUX-5
E2BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
E2BEG0  <= E2BEG0_input(TO_INTEGER(ConfigBits(42 downto 40)));
 
-- switch matrix multiplexer  E2BEG1            MUX-5
E2BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
E2BEG1  <= E2BEG1_input(TO_INTEGER(ConfigBits(45 downto 43)));
 
-- switch matrix multiplexer  E2BEG2            MUX-5
E2BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
E2BEG2  <= E2BEG2_input(TO_INTEGER(ConfigBits(48 downto 46)));
 
-- switch matrix multiplexer  E2BEG3            MUX-5
E2BEG3_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
E2BEG3  <= E2BEG3_input(TO_INTEGER(ConfigBits(51 downto 49)));
 
-- switch matrix multiplexer  S1BEG0            MUX-5
S1BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S1BEG0  <= S1BEG0_input(TO_INTEGER(ConfigBits(54 downto 52)));
 
-- switch matrix multiplexer  S1BEG1            MUX-5
S1BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S1BEG1  <= S1BEG1_input(TO_INTEGER(ConfigBits(57 downto 55)));
 
-- switch matrix multiplexer  S1BEG2            MUX-5
S1BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S1BEG2  <= S1BEG2_input(TO_INTEGER(ConfigBits(60 downto 58)));
 
-- switch matrix multiplexer  S1BEG3            MUX-5
S1BEG3_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S1BEG3  <= S1BEG3_input(TO_INTEGER(ConfigBits(63 downto 61)));
 
-- switch matrix multiplexer  S1BEG4            MUX-5
S1BEG4_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S1BEG4  <= S1BEG4_input(TO_INTEGER(ConfigBits(66 downto 64)));
 
-- switch matrix multiplexer  S2BEG0            MUX-5
S2BEG0_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S2BEG0  <= S2BEG0_input(TO_INTEGER(ConfigBits(69 downto 67)));
 
-- switch matrix multiplexer  S2BEG1            MUX-5
S2BEG1_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S2BEG1  <= S2BEG1_input(TO_INTEGER(ConfigBits(72 downto 70)));
 
-- switch matrix multiplexer  S2BEG2            MUX-5
S2BEG2_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S2BEG2  <= S2BEG2_input(TO_INTEGER(ConfigBits(75 downto 73)));
 
-- switch matrix multiplexer  S2BEG3            MUX-5
S2BEG3_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S2BEG3  <= S2BEG3_input(TO_INTEGER(ConfigBits(78 downto 76)));
 
-- switch matrix multiplexer  S2BEG4            MUX-5
S2BEG4_input     <= OJ_END4 & OJ_END3 & OJ_END2 & OJ_END1 & OJ_END0;
S2BEG4  <= S2BEG4_input(TO_INTEGER(ConfigBits(81 downto 79)));
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_SWITCH_MATRIX.VHDL

-- switch matrix multiplexer  N1BEG0            MUX-0
-- WARNING unused multiplexer MUX-N1BEG0
-- switch matrix multiplexer  N1BEG1            MUX-0
-- WARNING unused multiplexer MUX-N1BEG1
-- switch matrix multiplexer  N1BEG2            MUX-0
-- WARNING unused multiplexer MUX-N1BEG2
-- switch matrix multiplexer  N2BEG0            MUX-0
-- WARNING unused multiplexer MUX-N2BEG0
-- switch matrix multiplexer  N2BEG1            MUX-0
-- WARNING unused multiplexer MUX-N2BEG1
-- switch matrix multiplexer  N2BEG2            MUX-0
-- WARNING unused multiplexer MUX-N2BEG2
-- switch matrix multiplexer  E1BEG0            MUX-0
-- WARNING unused multiplexer MUX-E1BEG0
-- switch matrix multiplexer  E1BEG1            MUX-0
-- WARNING unused multiplexer MUX-E1BEG1
-- switch matrix multiplexer  E1BEG2            MUX-0
-- WARNING unused multiplexer MUX-E1BEG2
-- switch matrix multiplexer  E1BEG3            MUX-0
-- WARNING unused multiplexer MUX-E1BEG3
-- switch matrix multiplexer  E2BEG0            MUX-0
-- WARNING unused multiplexer MUX-E2BEG0
-- switch matrix multiplexer  E2BEG1            MUX-0
-- WARNING unused multiplexer MUX-E2BEG1
-- switch matrix multiplexer  E2BEG2            MUX-0
-- WARNING unused multiplexer MUX-E2BEG2
-- switch matrix multiplexer  E2BEG3            MUX-0
-- WARNING unused multiplexer MUX-E2BEG3
-- switch matrix multiplexer  S1BEG0            MUX-0
-- WARNING unused multiplexer MUX-S1BEG0
-- switch matrix multiplexer  S1BEG1            MUX-0
-- WARNING unused multiplexer MUX-S1BEG1
-- switch matrix multiplexer  S1BEG2            MUX-0
-- WARNING unused multiplexer MUX-S1BEG2
-- switch matrix multiplexer  S1BEG3            MUX-0
-- WARNING unused multiplexer MUX-S1BEG3
-- switch matrix multiplexer  S1BEG4            MUX-0
-- WARNING unused multiplexer MUX-S1BEG4
-- switch matrix multiplexer  S2BEG0            MUX-0
-- WARNING unused multiplexer MUX-S2BEG0
-- switch matrix multiplexer  S2BEG1            MUX-0
-- WARNING unused multiplexer MUX-S2BEG1
-- switch matrix multiplexer  S2BEG2            MUX-0
-- WARNING unused multiplexer MUX-S2BEG2
-- switch matrix multiplexer  S2BEG3            MUX-0
-- WARNING unused multiplexer MUX-S2BEG3
-- switch matrix multiplexer  S2BEG4            MUX-0
-- WARNING unused multiplexer MUX-S2BEG4
-- switch matrix multiplexer  W1BEG0            MUX-0
-- WARNING unused multiplexer MUX-W1BEG0
-- switch matrix multiplexer  W1BEG1            MUX-0
-- WARNING unused multiplexer MUX-W1BEG1
-- switch matrix multiplexer  W1BEG2            MUX-0
-- WARNING unused multiplexer MUX-W1BEG2
-- switch matrix multiplexer  W1BEG3            MUX-0
-- WARNING unused multiplexer MUX-W1BEG3
-- switch matrix multiplexer  W1BEG4            MUX-0
-- WARNING unused multiplexer MUX-W1BEG4
-- switch matrix multiplexer  W1BEG5            MUX-0
-- WARNING unused multiplexer MUX-W1BEG5
-- switch matrix multiplexer  W2BEG0            MUX-0
-- WARNING unused multiplexer MUX-W2BEG0
-- switch matrix multiplexer  W2BEG1            MUX-0
-- WARNING unused multiplexer MUX-W2BEG1
-- switch matrix multiplexer  W2BEG2            MUX-0
-- WARNING unused multiplexer MUX-W2BEG2
-- switch matrix multiplexer  W2BEG3            MUX-0
-- WARNING unused multiplexer MUX-W2BEG3
-- switch matrix multiplexer  W2BEG4            MUX-0
-- WARNING unused multiplexer MUX-W2BEG4
-- switch matrix multiplexer  W2BEG5            MUX-0
-- WARNING unused multiplexer MUX-W2BEG5
-- switch matrix multiplexer  O0                MUX-0
-- WARNING unused multiplexer MUX-O0
-- switch matrix multiplexer  T0                MUX-0
-- WARNING unused multiplexer MUX-T0
-- switch matrix multiplexer  O1                MUX-0
-- WARNING unused multiplexer MUX-O1
-- switch matrix multiplexer  T1                MUX-0
-- WARNING unused multiplexer MUX-T1
-- switch matrix multiplexer  O2                MUX-0
-- WARNING unused multiplexer MUX-O2
-- switch matrix multiplexer  T2                MUX-0
-- WARNING unused multiplexer MUX-T2
-- switch matrix multiplexer  O3                MUX-0
-- WARNING unused multiplexer MUX-O3
-- switch matrix multiplexer  T3                MUX-0
-- WARNING unused multiplexer MUX-T3
-- switch matrix multiplexer  IJ_BEG0           MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG0
-- switch matrix multiplexer  IJ_BEG1           MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG1
-- switch matrix multiplexer  IJ_BEG2           MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG2
-- switch matrix multiplexer  IJ_BEG3           MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG3
-- switch matrix multiplexer  IJ_BEG4           MUX-0
-- WARNING unused multiplexer MUX-IJ_BEG4
-- switch matrix multiplexer  IJ_BEG5           MUX-0
*****

### Read Fabric csv file ###
### Script command arguments are:
 ['R:\\work\\FORTE\\FPGA\\fabric\\gen.py', '-GenTileHDL']
### Generate all tile HDL descriptions
### generate VHDL for tile  N_term  # filename: N_term_tile.vhdl
### generate VHDL for tile  N_term_IO  # filename: N_term_IO_tile.vhdl
### generate VHDL for tile  W_term  # filename: W_term_tile.vhdl
### generate VHDL for tile  CLB  # filename: CLB_tile.vhdl
### generate VHDL for tile  IO  # filename: IO_tile.vhdl
### generate VHDL for tile  E_term  # filename: E_term_tile.vhdl
### generate VHDL for tile  S_term  # filename: S_term_tile.vhdl
### generate VHDL for tile  S_term_IO  # filename: S_term_IO_tile.vhdl
Comparing files R:\WORK\FORTE\FPGA\FABRIC\CLB_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\CLB_tile.vhdl
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destinatio
n_name:N1END  
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destinatio
n_name:N2END  
                 N4BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:2 X_offset:0 Y_offset:4  source_name:N4BEG destinatio
n_name:N4END  
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destinatio
n_name:N1END  
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destinatio
n_name:N2END  
                 N4END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:2 X_offset:0 Y_offset:4  source_name:N4BEG destinatio
n_name:N4END  
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destinatio
n_name:E1END  
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destinatio
n_name:E2END  
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destinatio
n_name:E1END  
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destinatio
n_name:E2END  
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destinati
on_name:S1END  
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destinati
on_name:S2END  
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destinati
on_name:S1END  
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destinati
on_name:S2END  
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destinati
on_name:W1END  
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG d
estination_name:W2END  
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destinati
on_name:W1END  
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG d
estination_name:W2END  
        -- global
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_TILE.VHDL
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
                 N4BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  2
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
                 N4END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  2
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
        -- global
*****

Resync Failed.  Files are too different.
***** R:\WORK\FORTE\FPGA\FABRIC\CLB_tile.vhdl
        Port Map(
                 N1END0  => N1END(0),
                 N1END1  => N1END(1),
                 N1END2  => N1END(2),
                 N2END0  => N2END(0),
                 N2END1  => N2END(1),
                 N2END2  => N2END(2),
                 N4END0  => N4END(0),
                 N4END1  => N4END(1),
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
                 A  => A,
                 AQ  => AQ,
                 B  => B,
                 BQ  => BQ,
                 C  => C,
                 CQ  => CQ,
                 D  => D,
                 DQ  => DQ,
                 TestOut  => TestOut,
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
                 N4BEG0  => N4BEG(6),
                 N4BEG1  => N4BEG(7),
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
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\CLB_TILE.VHDL
        Port Map(
                 N1END0  => N1END(0) ,
                 N1END1  => N1END(1) ,
                 N1END2  => N1END(2) ,
                 N2END0  => N2END(0) ,
                 N2END1  => N2END(1) ,
                 N2END2  => N2END(2) ,
                 N4END0  => N4END(0) ,
                 N4END1  => N4END(1) ,
                 E1END0  => E1END(0) ,
                 E1END1  => E1END(1) ,
                 E1END2  => E1END(2) ,
                 E1END3  => E1END(3) ,
                 E2END0  => E2END(0) ,
                 E2END1  => E2END(1) ,
                 E2END2  => E2END(2) ,
                 E2END3  => E2END(3) ,
                 S1END0  => S1END(0) ,
                 S1END1  => S1END(1) ,
                 S1END2  => S1END(2) ,
                 S1END3  => S1END(3) ,
                 S1END4  => S1END(4) ,
                 S2END0  => S2END(0) ,
                 S2END1  => S2END(1) ,
                 S2END2  => S2END(2) ,
                 S2END3  => S2END(3) ,
                 S2END4  => S2END(4) ,
                 W1END0  => W1END(0) ,
                 W1END1  => W1END(1) ,
                 W1END2  => W1END(2) ,
                 W1END3  => W1END(3) ,
                 W1END4  => W1END(4) ,
                 W1END5  => W1END(5) ,
                 W2END0  => W2END(0) ,
                 W2END1  => W2END(1) ,
                 W2END2  => W2END(2) ,
                 W2END3  => W2END(3) ,
                 W2END4  => W2END(4) ,
                 W2END5  => W2END(5) ,
                 A  => A ,
                 AQ  => AQ ,
                 B  => B ,
                 BQ  => BQ ,
                 C  => C ,
                 CQ  => CQ ,
                 D  => D ,
                 DQ  => DQ ,
                 TestOut  => TestOut ,
                 IJ_END0  => IJ_BEG(0) ,
                 IJ_END1  => IJ_BEG(1) ,
                 IJ_END2  => IJ_BEG(2) ,
                 IJ_END3  => IJ_BEG(3) ,
                 IJ_END4  => IJ_BEG(4) ,
                 IJ_END5  => IJ_BEG(5) ,
                 IJ_END6  => IJ_BEG(6) ,
                 IJ_END7  => IJ_BEG(7) ,
                 IJ_END8  => IJ_BEG(8) ,
                 IJ_END9  => IJ_BEG(9) ,
                 IJ_END10  => IJ_BEG(10) ,
                 IJ_END11  => IJ_BEG(11) ,
                 IJ_END12  => IJ_BEG(12) ,
                 OJ_END0  => OJ_BEG(0) ,
                 OJ_END1  => OJ_BEG(1) ,
                 OJ_END2  => OJ_BEG(2) ,
                 OJ_END3  => OJ_BEG(3) ,
                 OJ_END4  => OJ_BEG(4) ,
                 OJ_END5  => OJ_BEG(5) ,
                 OJ_END6  => OJ_BEG(6) ,
                 N1BEG0  => N1BEG(0) ,
                 N1BEG1  => N1BEG(1) ,
                 N1BEG2  => N1BEG(2) ,
                 N2BEG0  => N2BEG(3) ,
                 N2BEG1  => N2BEG(4) ,
                 N2BEG2  => N2BEG(5) ,
                 N4BEG0  => N4BEG(6) ,
                 N4BEG1  => N4BEG(7) ,
                 E1BEG0  => E1BEG(0) ,
                 E1BEG1  => E1BEG(1) ,
                 E1BEG2  => E1BEG(2) ,
                 E1BEG3  => E1BEG(3) ,
                 E2BEG0  => E2BEG(4) ,
                 E2BEG1  => E2BEG(5) ,
                 E2BEG2  => E2BEG(6) ,
                 E2BEG3  => E2BEG(7) ,
                 S1BEG0  => S1BEG(0) ,
                 S1BEG1  => S1BEG(1) ,
                 S1BEG2  => S1BEG(2) ,
                 S1BEG3  => S1BEG(3) ,
                 S1BEG4  => S1BEG(4) ,
                 S2BEG0  => S2BEG(5) ,
                 S2BEG1  => S2BEG(6) ,
                 S2BEG2  => S2BEG(7) ,
                 S2BEG3  => S2BEG(8) ,
                 S2BEG4  => S2BEG(9) ,
                 W1BEG0  => W1BEG(0) ,
                 W1BEG1  => W1BEG(1) ,
                 W1BEG2  => W1BEG(2) ,
                 W1BEG3  => W1BEG(3) ,
                 W1BEG4  => W1BEG(4) ,
                 W1BEG5  => W1BEG(5) ,
*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
        --  NORTH
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:NULL destination
_name:N1END  
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:NULL destination
_name:N2END  
                 N4END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:2 X_offset:0 Y_offset:4  source_name:NULL destination
_name:N4END  
        --  EAST
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
        --  NORTH
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
                 N4END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  2
        --  EAST
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destinati
on_name:NULL  
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destinati
on_name:NULL  
        --  WEST
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
        --  WEST
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
                  S2BEG3        : out    STD_LOGIC;
                  S2BEG4        : out    STD_LOGIC
        -- global
        );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
                  S2BEG3        : out    STD_LOGIC;
                  S2BEG4        : out    STD_LOGIC;
        -- global
                 MODE   : in     STD_LOGIC;      -- global signal 1: configuration, 0: operation
                 CONFin : in     STD_LOGIC;
                 CONFout        : out    STD_LOGIC;
                 CLK    : in     STD_LOGIC
        );
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal  conf_data       :       STD_LOGIC_VECTOR(0 downto 0);

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal  conf_data       :       STD_LOGIC_VECTOR(1 downto 0);

*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
-- Cascading of routing for wires spanning more than one tile
NULL(NULL'high - 3 downto 0) <= N2END(N2END'high downto 3);
NULL(NULL'high - 2 downto 0) <= N4END(N4END'high downto 2);
S2BEG(S2BEG'high - 5 downto 0) <= NULL(NULL'high downto 5);
-- top configuration data daisy chaining
*****

***** R:\WORK\FORTE\FPGA\FABRIC\N_term_tile.vhdl
        Port Map(
                 N1END0  => N1END(0),
                 N1END1  => N1END(1),
                 N1END2  => N1END(2),
                 N2END0  => N2END(0),
                 N2END1  => N2END(1),
                 N2END2  => N2END(2),
                 N4END0  => N4END(0),
                 N4END1  => N4END(1),
                 S1BEG0  => S1BEG(0),
                 S1BEG1  => S1BEG(1),
                 S1BEG2  => S1BEG(2),
                 S1BEG3  => S1BEG(3),
                 S1BEG4  => S1BEG(4),
                 S2BEG0  => S2BEG(5),
                 S2BEG1  => S2BEG(6),
                 S2BEG2  => S2BEG(7),
                 S2BEG3  => S2BEG(8),
                 S2BEG4  => S2BEG(9)             );  

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\N_TERM_TILE.VHDL
        Port Map(
                 N1END0  => N1END(0) ,
                 N1END1  => N1END(1) ,
                 N1END2  => N1END(2) ,
                 N2END0  => N2END(0) ,
                 N2END1  => N2END(1) ,
                 N2END2  => N2END(2) ,
                 N4END0  => N4END(0) ,
                 N4END1  => N4END(1) ,
                 S1BEG0  => S1BEG(0) ,
                 S1BEG1  => S1BEG(1) ,
                 S1BEG2  => S1BEG(2) ,
                 S1BEG3  => S1BEG(3) ,
                 S1BEG4  => S1BEG(4) ,
                 S2BEG0  => S2BEG(5) ,
                 S2BEG1  => S2BEG(6) ,
                 S2BEG2  => S2BEG(7) ,
                 S2BEG3  => S2BEG(8) ,
                 S2BEG4  => S2BEG(9) ,
         -- GLOBAL all primitive pins for configuration (not further parsed)  
                 MODE   => Mode,  
                 CONFin => conf_data(0),  
                 CONFout        => conf_data(1),  
                 CLK => CLK );  

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
        --  EAST
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:NULL destination
_name:E1END  
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:NULL destination
_name:E2END  
        --  SOUTH
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
        --  EAST
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
        --  SOUTH
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destinati
on_name:NULL  
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG d
estination_name:NULL  
        -- global
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
        -- global
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
                  W2BEG4        : out    STD_LOGIC;
                  W2BEG5        : out    STD_LOGIC
        -- global
        );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
                  W2BEG4        : out    STD_LOGIC;
                  W2BEG5        : out    STD_LOGIC;
        -- global
                 MODE   : in     STD_LOGIC;      -- global signal 1: configuration, 0: operation
                 CONFin : in     STD_LOGIC;
                 CONFout        : out    STD_LOGIC;
                 CLK    : in     STD_LOGIC
        );
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal  conf_data       :       STD_LOGIC_VECTOR(0 downto 0);

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
-- internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
signal  conf_data       :       STD_LOGIC_VECTOR(1 downto 0);

*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
-- Cascading of routing for wires spanning more than one tile
NULL(NULL'high - 4 downto 0) <= E2END(E2END'high downto 4);
W2BEG(W2BEG'high - 6 downto 0) <= NULL(NULL'high downto 6);
-- top configuration data daisy chaining
*****

***** R:\WORK\FORTE\FPGA\FABRIC\E_term_tile.vhdl
        Port Map(
                 E1END0  => E1END(0),
                 E1END1  => E1END(1),
                 E1END2  => E1END(2),
                 E1END3  => E1END(3),
                 E2END0  => E2END(0),
                 E2END1  => E2END(1),
                 E2END2  => E2END(2),
                 E2END3  => E2END(3),
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
                 W2BEG5  => W2BEG(11)            );  

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\E_TERM_TILE.VHDL
        Port Map(
                 E1END0  => E1END(0) ,
                 E1END1  => E1END(1) ,
                 E1END2  => E1END(2) ,
                 E1END3  => E1END(3) ,
                 E2END0  => E2END(0) ,
                 E2END1  => E2END(1) ,
                 E2END2  => E2END(2) ,
                 E2END3  => E2END(3) ,
                 W1BEG0  => W1BEG(0) ,
                 W1BEG1  => W1BEG(1) ,
                 W1BEG2  => W1BEG(2) ,
                 W1BEG3  => W1BEG(3) ,
                 W1BEG4  => W1BEG(4) ,
                 W1BEG5  => W1BEG(5) ,
                 W2BEG0  => W2BEG(6) ,
                 W2BEG1  => W2BEG(7) ,
                 W2BEG2  => W2BEG(8) ,
                 W2BEG3  => W2BEG(9) ,
                 W2BEG4  => W2BEG(10) ,
                 W2BEG5  => W2BEG(11) ,
         -- GLOBAL all primitive pins for configuration (not further parsed)  
                 MODE   => Mode,  
                 CONFin => conf_data(0),  
                 CONFout        => conf_data(1),  
                 CLK => CLK );  

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destinatio
n_name:NULL  
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destinatio
n_name:NULL  
                 N4BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:2 X_offset:0 Y_offset:4  source_name:N4BEG destinatio
n_name:NULL  
        --  EAST
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
                 N4BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  2
        --  EAST
*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl
        --  SOUTH
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:NULL destinatio
n_name:S1END  
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:NULL destinatio
n_name:S2END  
        --  WEST
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
        --  SOUTH
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
        --  WEST
*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl
-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
-- Cascading of routing for wires spanning more than one tile
N2BEG(N2BEG'high - 3 downto 0) <= NULL(NULL'high downto 3);
N4BEG(N4BEG'high - 2 downto 0) <= NULL(NULL'high downto 2);
NULL(NULL'high - 5 downto 0) <= S2END(S2END'high downto 5);
-- top configuration data daisy chaining
*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl
        Port Map(
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
                 N1BEG0  => N1BEG(0),
                 N1BEG1  => N1BEG(1),
                 N1BEG2  => N1BEG(2),
                 N2BEG0  => N2BEG(3),
                 N2BEG1  => N2BEG(4),
                 N2BEG2  => N2BEG(5),
                 N4BEG0  => N4BEG(6),
                 N4BEG1  => N4BEG(7),
         -- GLOBAL all primitive pins for configuration (not further parsed)  
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
        Port Map(
                 S1END0  => S1END(0) ,
                 S1END1  => S1END(1) ,
                 S1END2  => S1END(2) ,
                 S1END3  => S1END(3) ,
                 S1END4  => S1END(4) ,
                 S2END0  => S2END(0) ,
                 S2END1  => S2END(1) ,
                 S2END2  => S2END(2) ,
                 S2END3  => S2END(3) ,
                 S2END4  => S2END(4) ,
                 N1BEG0  => N1BEG(0) ,
                 N1BEG1  => N1BEG(1) ,
                 N1BEG2  => N1BEG(2) ,
                 N2BEG0  => N2BEG(3) ,
                 N2BEG1  => N2BEG(4) ,
                 N2BEG2  => N2BEG(5) ,
                 N4BEG0  => N4BEG(6) ,
                 N4BEG1  => N4BEG(7) ,
         -- GLOBAL all primitive pins for configuration (not further parsed)  
*****

***** R:\WORK\FORTE\FPGA\FABRIC\S_term_tile.vhdl
                 CONFout        => conf_data(1),  
                 CLK => CLK   
                 );  

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\S_TERM_TILE.VHDL
                 CONFout        => conf_data(1),  
                 CLK => CLK );  

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destinatio
n_name:NULL  
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destinatio
n_name:NULL  
        --  SOUTH
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
        --  SOUTH
*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl
        --  WEST
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:NULL destinatio
n_name:W1END  
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:NULL de
stination_name:W2END  
        -- global
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
        --  WEST
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
        -- global
*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl
-- Cascading of routing for wires spanning more than one tile
-- top configuration data daisy chaining
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
-- Cascading of routing for wires spanning more than one tile
E2BEG(E2BEG'high - 4 downto 0) <= NULL(NULL'high downto 4);
NULL(NULL'high - 6 downto 0) <= W2END(W2END'high downto 6);
-- top configuration data daisy chaining
*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl
        Port Map(
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
                 E1BEG0  => E1BEG(0),
                 E1BEG1  => E1BEG(1),
                 E1BEG2  => E1BEG(2),
                 E1BEG3  => E1BEG(3),
                 E2BEG0  => E2BEG(4),
                 E2BEG1  => E2BEG(5),
                 E2BEG2  => E2BEG(6),
                 E2BEG3  => E2BEG(7),
         -- GLOBAL all primitive pins for configuration (not further parsed)  
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
        Port Map(
                 W1END0  => W1END(0) ,
                 W1END1  => W1END(1) ,
                 W1END2  => W1END(2) ,
                 W1END3  => W1END(3) ,
                 W1END4  => W1END(4) ,
                 W1END5  => W1END(5) ,
                 W2END0  => W2END(0) ,
                 W2END1  => W2END(1) ,
                 W2END2  => W2END(2) ,
                 W2END3  => W2END(3) ,
                 W2END4  => W2END(4) ,
                 W2END5  => W2END(5) ,
                 E1BEG0  => E1BEG(0) ,
                 E1BEG1  => E1BEG(1) ,
                 E1BEG2  => E1BEG(2) ,
                 E1BEG3  => E1BEG(3) ,
                 E2BEG0  => E2BEG(4) ,
                 E2BEG1  => E2BEG(5) ,
                 E2BEG2  => E2BEG(6) ,
                 E2BEG3  => E2BEG(7) ,
         -- GLOBAL all primitive pins for configuration (not further parsed)  
*****

***** R:\WORK\FORTE\FPGA\FABRIC\W_term_tile.vhdl
                 CONFout        => conf_data(1),  
                 CLK => CLK   
                 );  

***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\W_TERM_TILE.VHDL
                 CONFout        => conf_data(1),  
                 CLK => CLK );  

*****

Comparing files R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl and R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
***** R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destinatio
n_name:N1END  
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destinatio
n_name:N2END  
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:3 X_offset:0 Y_offset:1  source_name:N1BEG destinatio
n_name:N1END  
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:3 X_offset:0 Y_offset:2  source_name:N2BEG destinatio
n_name:N2END  
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destinatio
n_name:E1END  
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destinatio
n_name:E2END  
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:4 X_offset:1 Y_offset:0  source_name:E1BEG destinatio
n_name:E1END  
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:4 X_offset:2 Y_offset:0  source_name:E2BEG destinatio
n_name:E2END  
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destinati
on_name:S1END  
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destinati
on_name:S2END  
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:5 X_offset:0 Y_offset:-1  source_name:S1BEG destinati
on_name:S1END  
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:5 X_offset:0 Y_offset:-2  source_name:S2BEG destinati
on_name:S2END  
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destinati
on_name:W1END  
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG d
estination_name:W2END  
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:6 X_offset:-1 Y_offset:0  source_name:W1BEG destinati
on_name:W1END  
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:6 X_offset:-2 Y_offset:0  source_name:W2BEG d
estination_name:W2END  
        -- Tile IO ports from BELs
                PAD0: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
                PAD1: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
                PAD2: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
                PAD3: inout STD_LOGIC; -- EXTERNAL has to ge to top-level entity not the switch matrix
        -- global
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
        --  NORTH
                 N1BEG  : out   STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
                 N1END  : in    STD_LOGIC_VECTOR( 2 downto 0 );  -- wires:  3
                 N2END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  3
        --  EAST
                 E1BEG  : out   STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2BEG  : out   STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
                 E1END  : in    STD_LOGIC_VECTOR( 3 downto 0 );  -- wires:  4
                 E2END  : in    STD_LOGIC_VECTOR( 7 downto 0 );  -- wires:  4
        --  SOUTH
                 S1BEG  : out   STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2BEG  : out   STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
                 S1END  : in    STD_LOGIC_VECTOR( 4 downto 0 );  -- wires:  5
                 S2END  : in    STD_LOGIC_VECTOR( 9 downto 0 );  -- wires:  5
        --  WEST
                 W1BEG  : out   STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2BEG  : out   STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
                 W1END  : in    STD_LOGIC_VECTOR( 5 downto 0 );  -- wires:  6
                 W2END  : in    STD_LOGIC_VECTOR( 11 downto 0 );         -- wires:  6
        -- global
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl
        -- Pin0
        I0      : in    STD_LOGIC; -- from fabric to external pin
        T0      : in    STD_LOGIC; -- tristate control
        O0      : out   STD_LOGIC; -- from external pin to fabric
        Q0      : out   STD_LOGIC; -- from external pin to fabric (registered)
        PAD0: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
        -- Pin1
        I1      : in    STD_LOGIC; -- from fabric to external pin
    T1  : in    STD_LOGIC; -- tristate control
    O1  : out    STD_LOGIC; -- from external pin to fabric
    Q1  : out    STD_LOGIC; -- from external pin to fabric (registered)
        PAD1: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
        -- Pin2
        I2      : in    STD_LOGIC; -- from fabric to external pin
    T2  : in    STD_LOGIC; -- tristate control
    O2  : out    STD_LOGIC; -- from external pin to fabric
    Q2  : out    STD_LOGIC; -- from external pin to fabric (registered)
        PAD2: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
        -- Pin3
        I3      : in    STD_LOGIC; -- from fabric to external pin
    T3  : in    STD_LOGIC; -- tristate control
    O3  : out    STD_LOGIC; -- from external pin to fabric
    Q3  : out    STD_LOGIC; -- from external pin to fabric (registered)
        PAD3: inout STD_LOGIC; -- EXTERNAL has to ge to top-level component not the switch matrix
        -- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
        MODE    : in     STD_LOGIC;      -- 1 configuration, 0 action
    CONFin    : in      STD_LOGIC;
    CONFout    : out      STD_LOGIC;
    CLK    : in      STD_LOGIC
        );
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
        -- Pin0
        O0      : in    STD_LOGIC; -- fabric to external pin
        T0      : in    STD_LOGIC; -- tristate control
        I0      : out   STD_LOGIC; -- external pin to fabric
        IQ0     : out   STD_LOGIC; -- external pin to fabric (registered)
        -- Pin1
        O1      : in    STD_LOGIC; -- fabric to external pin
    T1  : in    STD_LOGIC; -- tristate control
    I1  : out    STD_LOGIC; -- external pin to fabric
    IQ1 : out    STD_LOGIC; -- external pin to fabric (registered)
        -- Pin2
        O2      : in    STD_LOGIC; -- fabric to external pin
    T2  : in    STD_LOGIC; -- tristate control
    I2  : out    STD_LOGIC; -- external pin to fabric
    IQ2 : out    STD_LOGIC; -- external pin to fabric (registered)
        -- Pin3
        O3      : in    STD_LOGIC; -- fabric to external pin
    T3  : in    STD_LOGIC; -- tristate control
    I3  : out    STD_LOGIC; -- external pin to fabric
    IQ3 : out    STD_LOGIC; -- external pin to fabric (registered)
        -- GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
        CLK     : in     STD_LOGIC
        );
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl
-- BEL ports (e.g., slices)
signal  I0      :STD_LOGIC;
signal  T0      :STD_LOGIC;
signal  I1      :STD_LOGIC;
signal  T1      :STD_LOGIC;
signal  I2      :STD_LOGIC;
signal  T2      :STD_LOGIC;
signal  I3      :STD_LOGIC;
signal  T3      :STD_LOGIC;
signal  O0      :STD_LOGIC;
signal  Q0      :STD_LOGIC;
signal  O1      :STD_LOGIC;
signal  Q1      :STD_LOGIC;
signal  O2      :STD_LOGIC;
signal  Q2      :STD_LOGIC;
signal  O3      :STD_LOGIC;
signal  Q3      :STD_LOGIC;
-- Tile ports (the signals to wire all tile top-level routing signals)
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
-- BEL ports (e.g., slices)
signal  O0      :STD_LOGIC;
signal  T0      :STD_LOGIC;
signal  O1      :STD_LOGIC;
signal  T1      :STD_LOGIC;
signal  O2      :STD_LOGIC;
signal  T2      :STD_LOGIC;
signal  O3      :STD_LOGIC;
signal  T3      :STD_LOGIC;
signal  I0      :STD_LOGIC;
signal  IQ0     :STD_LOGIC;
signal  I1      :STD_LOGIC;
signal  IQ1     :STD_LOGIC;
signal  I2      :STD_LOGIC;
signal  IQ2     :STD_LOGIC;
signal  I3      :STD_LOGIC;
signal  IQ3     :STD_LOGIC;
-- Tile ports (the signals to wire all tile top-level routing signals)
*****

***** R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl
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
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
        Port Map(
                 O0  =>  O0 ,
                 T0  =>  T0 ,
                 O1  =>  O1 ,
                 T1  =>  T1 ,
                 O2  =>  O2 ,
                 T2  =>  T2 ,
                 O3  =>  O3 ,
                 T3  =>  T3 ,
                 I0  =>  I0 ,
                 IQ0  =>  IQ0 ,
                 I1  =>  I1 ,
                 IQ1  =>  IQ1 ,
                 I2  =>  I2 ,
                 IQ2  =>  IQ2 ,
                 I3  =>  I3 ,
                 IQ3  =>  IQ3 ,
         -- GLOBAL all primitive pins for configuration (not further parsed)  
*****

Resync Failed.  Files are too different.
***** R:\WORK\FORTE\FPGA\FABRIC\IO_tile.vhdl
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
                 I0  => O0,
                 IQ0  => Q0,
                 I1  => O1,
                 IQ1  => Q1,
                 I2  => O2,
                 IQ2  => Q2,
                 I3  => O3,
                 IQ3  => Q3,
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
***** R:\WORK\FORTE\FPGA\FABRIC\REGRESSION\IO_TILE.VHDL
        Port Map(
                 N1END0  => N1END(0) ,
                 N1END1  => N1END(1) ,
                 N1END2  => N1END(2) ,
                 N2END0  => N2END(0) ,
                 N2END1  => N2END(1) ,
                 N2END2  => N2END(2) ,
                 E1END0  => E1END(0) ,
                 E1END1  => E1END(1) ,
                 E1END2  => E1END(2) ,
                 E1END3  => E1END(3) ,
                 E2END0  => E2END(0) ,
                 E2END1  => E2END(1) ,
                 E2END2  => E2END(2) ,
                 E2END3  => E2END(3) ,
                 S1END0  => S1END(0) ,
                 S1END1  => S1END(1) ,
                 S1END2  => S1END(2) ,
                 S1END3  => S1END(3) ,
                 S1END4  => S1END(4) ,
                 S2END0  => S2END(0) ,
                 S2END1  => S2END(1) ,
                 S2END2  => S2END(2) ,
                 S2END3  => S2END(3) ,
                 S2END4  => S2END(4) ,
                 W1END0  => W1END(0) ,
                 W1END1  => W1END(1) ,
                 W1END2  => W1END(2) ,
                 W1END3  => W1END(3) ,
                 W1END4  => W1END(4) ,
                 W1END5  => W1END(5) ,
                 W2END0  => W2END(0) ,
                 W2END1  => W2END(1) ,
                 W2END2  => W2END(2) ,
                 W2END3  => W2END(3) ,
                 W2END4  => W2END(4) ,
                 W2END5  => W2END(5) ,
                 I0  => I0 ,
                 IQ0  => IQ0 ,
                 I1  => I1 ,
                 IQ1  => IQ1 ,
                 I2  => I2 ,
                 IQ2  => IQ2 ,
                 I3  => I3 ,
                 IQ3  => IQ3 ,
                 IJ_END0  => IJ_BEG(0) ,
                 IJ_END1  => IJ_BEG(1) ,
                 IJ_END2  => IJ_BEG(2) ,
                 IJ_END3  => IJ_BEG(3) ,
                 IJ_END4  => IJ_BEG(4) ,
                 IJ_END5  => IJ_BEG(5) ,
                 IJ_END6  => IJ_BEG(6) ,
                 IJ_END7  => IJ_BEG(7) ,
                 IJ_END8  => IJ_BEG(8) ,
                 IJ_END9  => IJ_BEG(9) ,
                 IJ_END10  => IJ_BEG(10) ,
                 IJ_END11  => IJ_BEG(11) ,
                 IJ_END12  => IJ_BEG(12) ,
                 OJ_END0  => OJ_BEG(0) ,
                 OJ_END1  => OJ_BEG(1) ,
                 OJ_END2  => OJ_BEG(2) ,
                 OJ_END3  => OJ_BEG(3) ,
                 OJ_END4  => OJ_BEG(4) ,
                 OJ_END5  => OJ_BEG(5) ,
                 OJ_END6  => OJ_BEG(6) ,
                 N1BEG0  => N1BEG(0) ,
                 N1BEG1  => N1BEG(1) ,
                 N1BEG2  => N1BEG(2) ,
                 N2BEG0  => N2BEG(3) ,
                 N2BEG1  => N2BEG(4) ,
                 N2BEG2  => N2BEG(5) ,
                 E1BEG0  => E1BEG(0) ,
                 E1BEG1  => E1BEG(1) ,
                 E1BEG2  => E1BEG(2) ,
                 E1BEG3  => E1BEG(3) ,
                 E2BEG0  => E2BEG(4) ,
                 E2BEG1  => E2BEG(5) ,
                 E2BEG2  => E2BEG(6) ,
                 E2BEG3  => E2BEG(7) ,
                 S1BEG0  => S1BEG(0) ,
                 S1BEG1  => S1BEG(1) ,
                 S1BEG2  => S1BEG(2) ,
                 S1BEG3  => S1BEG(3) ,
                 S1BEG4  => S1BEG(4) ,
                 S2BEG0  => S2BEG(5) ,
                 S2BEG1  => S2BEG(6) ,
                 S2BEG2  => S2BEG(7) ,
                 S2BEG3  => S2BEG(8) ,
                 S2BEG4  => S2BEG(9) ,
                 W1BEG0  => W1BEG(0) ,
                 W1BEG1  => W1BEG(1) ,
                 W1BEG2  => W1BEG(2) ,
                 W1BEG3  => W1BEG(3) ,
                 W1BEG4  => W1BEG(4) ,
                 W1BEG5  => W1BEG(5) ,
                 W2BEG0  => W2BEG(6) ,
                 W2BEG1  => W2BEG(7) ,
                 W2BEG2  => W2BEG(8) ,
                 W2BEG3  => W2BEG(9) ,
                 W2BEG4  => W2BEG(10) ,
*****

