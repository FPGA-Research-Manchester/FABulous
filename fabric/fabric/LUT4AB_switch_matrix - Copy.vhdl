-- NumberOfConfigBits:344
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity  LUT4AB_switch_matrix  is 
	Port (
		 -- switch matrix inputs
		  N1END0 	: in 	 STD_LOGIC;
		  N1END1 	: in 	 STD_LOGIC;
		  N1END2 	: in 	 STD_LOGIC;
		  N1END3 	: in 	 STD_LOGIC;
		  N2MID0 	: in 	 STD_LOGIC;
		  N2MID1 	: in 	 STD_LOGIC;
		  N2MID2 	: in 	 STD_LOGIC;
		  N2MID3 	: in 	 STD_LOGIC;
		  N2MID4 	: in 	 STD_LOGIC;
		  N2MID5 	: in 	 STD_LOGIC;
		  N2MID6 	: in 	 STD_LOGIC;
		  N2MID7 	: in 	 STD_LOGIC;
		  N2END0 	: in 	 STD_LOGIC;
		  N2END1 	: in 	 STD_LOGIC;
		  N2END2 	: in 	 STD_LOGIC;
		  N2END3 	: in 	 STD_LOGIC;
		  N2END4 	: in 	 STD_LOGIC;
		  N2END5 	: in 	 STD_LOGIC;
		  N2END6 	: in 	 STD_LOGIC;
		  N2END7 	: in 	 STD_LOGIC;
		  N4END0 	: in 	 STD_LOGIC;
		  N4END1 	: in 	 STD_LOGIC;
		  N4END2 	: in 	 STD_LOGIC;
		  N4END3 	: in 	 STD_LOGIC;
		  E1END0 	: in 	 STD_LOGIC;
		  E1END1 	: in 	 STD_LOGIC;
		  E1END2 	: in 	 STD_LOGIC;
		  E1END3 	: in 	 STD_LOGIC;
		  E2MID0 	: in 	 STD_LOGIC;
		  E2MID1 	: in 	 STD_LOGIC;
		  E2MID2 	: in 	 STD_LOGIC;
		  E2MID3 	: in 	 STD_LOGIC;
		  E2MID4 	: in 	 STD_LOGIC;
		  E2MID5 	: in 	 STD_LOGIC;
		  E2MID6 	: in 	 STD_LOGIC;
		  E2MID7 	: in 	 STD_LOGIC;
		  E2END0 	: in 	 STD_LOGIC;
		  E2END1 	: in 	 STD_LOGIC;
		  E2END2 	: in 	 STD_LOGIC;
		  E2END3 	: in 	 STD_LOGIC;
		  E2END4 	: in 	 STD_LOGIC;
		  E2END5 	: in 	 STD_LOGIC;
		  E2END6 	: in 	 STD_LOGIC;
		  E2END7 	: in 	 STD_LOGIC;
		  E6END0 	: in 	 STD_LOGIC;
		  E6END1 	: in 	 STD_LOGIC;
		  S1END0 	: in 	 STD_LOGIC;
		  S1END1 	: in 	 STD_LOGIC;
		  S1END2 	: in 	 STD_LOGIC;
		  S1END3 	: in 	 STD_LOGIC;
		  S2MID0 	: in 	 STD_LOGIC;
		  S2MID1 	: in 	 STD_LOGIC;
		  S2MID2 	: in 	 STD_LOGIC;
		  S2MID3 	: in 	 STD_LOGIC;
		  S2MID4 	: in 	 STD_LOGIC;
		  S2MID5 	: in 	 STD_LOGIC;
		  S2MID6 	: in 	 STD_LOGIC;
		  S2MID7 	: in 	 STD_LOGIC;
		  S2END0 	: in 	 STD_LOGIC;
		  S2END1 	: in 	 STD_LOGIC;
		  S2END2 	: in 	 STD_LOGIC;
		  S2END3 	: in 	 STD_LOGIC;
		  S2END4 	: in 	 STD_LOGIC;
		  S2END5 	: in 	 STD_LOGIC;
		  S2END6 	: in 	 STD_LOGIC;
		  S2END7 	: in 	 STD_LOGIC;
		  S4END0 	: in 	 STD_LOGIC;
		  S4END1 	: in 	 STD_LOGIC;
		  S4END2 	: in 	 STD_LOGIC;
		  S4END3 	: in 	 STD_LOGIC;
		  Ci0 	: in 	 STD_LOGIC;
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
		  LA_O 	: in 	 STD_LOGIC;
		  LA_Co 	: in 	 STD_LOGIC;
		  LB_O 	: in 	 STD_LOGIC;
		  LB_Co 	: in 	 STD_LOGIC;
		  LC_O 	: in 	 STD_LOGIC;
		  LC_Co 	: in 	 STD_LOGIC;
		  LD_O 	: in 	 STD_LOGIC;
		  LD_Co 	: in 	 STD_LOGIC;
		  LE_O 	: in 	 STD_LOGIC;
		  LE_Co 	: in 	 STD_LOGIC;
		  LF_O 	: in 	 STD_LOGIC;
		  LF_Co 	: in 	 STD_LOGIC;
		  LG_O 	: in 	 STD_LOGIC;
		  LG_Co 	: in 	 STD_LOGIC;
		  LH_O 	: in 	 STD_LOGIC;
		  LH_Co 	: in 	 STD_LOGIC;
		  M_AB 	: in 	 STD_LOGIC;
		  M_AD 	: in 	 STD_LOGIC;
		  M_AH 	: in 	 STD_LOGIC;
		  M_EF 	: in 	 STD_LOGIC;
		  N1BEG0 	: out 	 STD_LOGIC;
		  N1BEG1 	: out 	 STD_LOGIC;
		  N1BEG2 	: out 	 STD_LOGIC;
		  N1BEG3 	: out 	 STD_LOGIC;
		  N2BEG0 	: out 	 STD_LOGIC;
		  N2BEG1 	: out 	 STD_LOGIC;
		  N2BEG2 	: out 	 STD_LOGIC;
		  N2BEG3 	: out 	 STD_LOGIC;
		  N2BEG4 	: out 	 STD_LOGIC;
		  N2BEG5 	: out 	 STD_LOGIC;
		  N2BEG6 	: out 	 STD_LOGIC;
		  N2BEG7 	: out 	 STD_LOGIC;
		  N2BEGb0 	: out 	 STD_LOGIC;
		  N2BEGb1 	: out 	 STD_LOGIC;
		  N2BEGb2 	: out 	 STD_LOGIC;
		  N2BEGb3 	: out 	 STD_LOGIC;
		  N2BEGb4 	: out 	 STD_LOGIC;
		  N2BEGb5 	: out 	 STD_LOGIC;
		  N2BEGb6 	: out 	 STD_LOGIC;
		  N2BEGb7 	: out 	 STD_LOGIC;
		  N4BEG0 	: out 	 STD_LOGIC;
		  N4BEG1 	: out 	 STD_LOGIC;
		  N4BEG2 	: out 	 STD_LOGIC;
		  N4BEG3 	: out 	 STD_LOGIC;
		  Co0 	: out 	 STD_LOGIC;
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
		  S1BEG0 	: out 	 STD_LOGIC;
		  S1BEG1 	: out 	 STD_LOGIC;
		  S1BEG2 	: out 	 STD_LOGIC;
		  S1BEG3 	: out 	 STD_LOGIC;
		  S2BEG0 	: out 	 STD_LOGIC;
		  S2BEG1 	: out 	 STD_LOGIC;
		  S2BEG2 	: out 	 STD_LOGIC;
		  S2BEG3 	: out 	 STD_LOGIC;
		  S2BEG4 	: out 	 STD_LOGIC;
		  S2BEG5 	: out 	 STD_LOGIC;
		  S2BEG6 	: out 	 STD_LOGIC;
		  S2BEG7 	: out 	 STD_LOGIC;
		  S2BEGb0 	: out 	 STD_LOGIC;
		  S2BEGb1 	: out 	 STD_LOGIC;
		  S2BEGb2 	: out 	 STD_LOGIC;
		  S2BEGb3 	: out 	 STD_LOGIC;
		  S2BEGb4 	: out 	 STD_LOGIC;
		  S2BEGb5 	: out 	 STD_LOGIC;
		  S2BEGb6 	: out 	 STD_LOGIC;
		  S2BEGb7 	: out 	 STD_LOGIC;
		  S4BEG0 	: out 	 STD_LOGIC;
		  S4BEG1 	: out 	 STD_LOGIC;
		  S4BEG2 	: out 	 STD_LOGIC;
		  S4BEG3 	: out 	 STD_LOGIC;
		  W1BEG0 	: out 	 STD_LOGIC;
		  W1BEG1 	: out 	 STD_LOGIC;
		  W1BEG2 	: out 	 STD_LOGIC;
		  W1BEG3 	: out 	 STD_LOGIC;
		  W2BEG0 	: out 	 STD_LOGIC;
		  W2BEG1 	: out 	 STD_LOGIC;
		  W2BEG2 	: out 	 STD_LOGIC;
		  W2BEG3 	: out 	 STD_LOGIC;
		  W2BEG4 	: out 	 STD_LOGIC;
		  W2BEG5 	: out 	 STD_LOGIC;
		  W2BEG6 	: out 	 STD_LOGIC;
		  W2BEG7 	: out 	 STD_LOGIC;
		  W2BEGb0 	: out 	 STD_LOGIC;
		  W2BEGb1 	: out 	 STD_LOGIC;
		  W2BEGb2 	: out 	 STD_LOGIC;
		  W2BEGb3 	: out 	 STD_LOGIC;
		  W2BEGb4 	: out 	 STD_LOGIC;
		  W2BEGb5 	: out 	 STD_LOGIC;
		  W2BEGb6 	: out 	 STD_LOGIC;
		  W2BEGb7 	: out 	 STD_LOGIC;
		  W6BEG0 	: out 	 STD_LOGIC;
		  W6BEG1 	: out 	 STD_LOGIC;
		  LA_I0 	: out 	 STD_LOGIC;
		  LA_I1 	: out 	 STD_LOGIC;
		  LA_I2 	: out 	 STD_LOGIC;
		  LA_I3 	: out 	 STD_LOGIC;
		  LA_Ci 	: out 	 STD_LOGIC;
		  LB_I0 	: out 	 STD_LOGIC;
		  LB_I1 	: out 	 STD_LOGIC;
		  LB_I2 	: out 	 STD_LOGIC;
		  LB_I3 	: out 	 STD_LOGIC;
		  LB_Ci 	: out 	 STD_LOGIC;
		  LC_I0 	: out 	 STD_LOGIC;
		  LC_I1 	: out 	 STD_LOGIC;
		  LC_I2 	: out 	 STD_LOGIC;
		  LC_I3 	: out 	 STD_LOGIC;
		  LC_Ci 	: out 	 STD_LOGIC;
		  LD_I0 	: out 	 STD_LOGIC;
		  LD_I1 	: out 	 STD_LOGIC;
		  LD_I2 	: out 	 STD_LOGIC;
		  LD_I3 	: out 	 STD_LOGIC;
		  LD_Ci 	: out 	 STD_LOGIC;
		  LE_I0 	: out 	 STD_LOGIC;
		  LE_I1 	: out 	 STD_LOGIC;
		  LE_I2 	: out 	 STD_LOGIC;
		  LE_I3 	: out 	 STD_LOGIC;
		  LE_Ci 	: out 	 STD_LOGIC;
		  LF_I0 	: out 	 STD_LOGIC;
		  LF_I1 	: out 	 STD_LOGIC;
		  LF_I2 	: out 	 STD_LOGIC;
		  LF_I3 	: out 	 STD_LOGIC;
		  LF_Ci 	: out 	 STD_LOGIC;
		  LG_I0 	: out 	 STD_LOGIC;
		  LG_I1 	: out 	 STD_LOGIC;
		  LG_I2 	: out 	 STD_LOGIC;
		  LG_I3 	: out 	 STD_LOGIC;
		  LG_Ci 	: out 	 STD_LOGIC;
		  LH_I0 	: out 	 STD_LOGIC;
		  LH_I1 	: out 	 STD_LOGIC;
		  LH_I2 	: out 	 STD_LOGIC;
		  LH_I3 	: out 	 STD_LOGIC;
		  LH_Ci 	: out 	 STD_LOGIC;
		  A 	: out 	 STD_LOGIC;
		  B 	: out 	 STD_LOGIC;
		  C 	: out 	 STD_LOGIC;
		  D 	: out 	 STD_LOGIC;
		  E 	: out 	 STD_LOGIC;
		  F 	: out 	 STD_LOGIC;
		  G 	: out 	 STD_LOGIC;
		  H 	: out 	 STD_LOGIC;
		  S0 	: out 	 STD_LOGIC;
		  S1 	: out 	 STD_LOGIC;
		  S2 	: out 	 STD_LOGIC;
		  S3 	: out 	 STD_LOGIC;
	-- global
		 MODE	: in 	 STD_LOGIC;	 -- global signal 1: configuration, 0: operation
		 CONFin	: in 	 STD_LOGIC;
		 CONFout	: out 	 STD_LOGIC;
		 CLK	: in 	 STD_LOGIC
	);
end entity LUT4AB_switch_matrix ;

architecture Behavioral of  LUT4AB_switch_matrix  is 

signal		  J2MID_ABa0 	:  	 STD_LOGIC;
signal		  J2MID_ABa1 	:  	 STD_LOGIC;
signal		  J2MID_ABa2 	:  	 STD_LOGIC;
signal		  J2MID_ABa3 	:  	 STD_LOGIC;
signal		  J2MID_CDa0 	:  	 STD_LOGIC;
signal		  J2MID_CDa1 	:  	 STD_LOGIC;
signal		  J2MID_CDa2 	:  	 STD_LOGIC;
signal		  J2MID_CDa3 	:  	 STD_LOGIC;
signal		  J2MID_EFa0 	:  	 STD_LOGIC;
signal		  J2MID_EFa1 	:  	 STD_LOGIC;
signal		  J2MID_EFa2 	:  	 STD_LOGIC;
signal		  J2MID_EFa3 	:  	 STD_LOGIC;
signal		  J2MID_GHa0 	:  	 STD_LOGIC;
signal		  J2MID_GHa1 	:  	 STD_LOGIC;
signal		  J2MID_GHa2 	:  	 STD_LOGIC;
signal		  J2MID_GHa3 	:  	 STD_LOGIC;
signal		  J2MID_ABb0 	:  	 STD_LOGIC;
signal		  J2MID_ABb1 	:  	 STD_LOGIC;
signal		  J2MID_ABb2 	:  	 STD_LOGIC;
signal		  J2MID_ABb3 	:  	 STD_LOGIC;
signal		  J2MID_CDb0 	:  	 STD_LOGIC;
signal		  J2MID_CDb1 	:  	 STD_LOGIC;
signal		  J2MID_CDb2 	:  	 STD_LOGIC;
signal		  J2MID_CDb3 	:  	 STD_LOGIC;
signal		  J2MID_EFb0 	:  	 STD_LOGIC;
signal		  J2MID_EFb1 	:  	 STD_LOGIC;
signal		  J2MID_EFb2 	:  	 STD_LOGIC;
signal		  J2MID_EFb3 	:  	 STD_LOGIC;
signal		  J2MID_GHb0 	:  	 STD_LOGIC;
signal		  J2MID_GHb1 	:  	 STD_LOGIC;
signal		  J2MID_GHb2 	:  	 STD_LOGIC;
signal		  J2MID_GHb3 	:  	 STD_LOGIC;
signal		  J2END_AB0 	:  	 STD_LOGIC;
signal		  J2END_AB1 	:  	 STD_LOGIC;
signal		  J2END_AB2 	:  	 STD_LOGIC;
signal		  J2END_AB3 	:  	 STD_LOGIC;
signal		  J2END_CD0 	:  	 STD_LOGIC;
signal		  J2END_CD1 	:  	 STD_LOGIC;
signal		  J2END_CD2 	:  	 STD_LOGIC;
signal		  J2END_CD3 	:  	 STD_LOGIC;
signal		  J2END_EF0 	:  	 STD_LOGIC;
signal		  J2END_EF1 	:  	 STD_LOGIC;
signal		  J2END_EF2 	:  	 STD_LOGIC;
signal		  J2END_EF3 	:  	 STD_LOGIC;
signal		  J2END_GH0 	:  	 STD_LOGIC;
signal		  J2END_GH1 	:  	 STD_LOGIC;
signal		  J2END_GH2 	:  	 STD_LOGIC;
signal		  J2END_GH3 	:  	 STD_LOGIC;
signal		  J2N0 	:  	 STD_LOGIC;
signal		  J2N1 	:  	 STD_LOGIC;
signal		  J2N2 	:  	 STD_LOGIC;
signal		  J2N3 	:  	 STD_LOGIC;
signal		  J2N4 	:  	 STD_LOGIC;
signal		  J2N5 	:  	 STD_LOGIC;
signal		  J2N6 	:  	 STD_LOGIC;
signal		  J2N7 	:  	 STD_LOGIC;
signal		  J2E0 	:  	 STD_LOGIC;
signal		  J2E1 	:  	 STD_LOGIC;
signal		  J2E2 	:  	 STD_LOGIC;
signal		  J2E3 	:  	 STD_LOGIC;
signal		  J2E4 	:  	 STD_LOGIC;
signal		  J2E5 	:  	 STD_LOGIC;
signal		  J2E6 	:  	 STD_LOGIC;
signal		  J2E7 	:  	 STD_LOGIC;
signal		  J2S0 	:  	 STD_LOGIC;
signal		  J2S1 	:  	 STD_LOGIC;
signal		  J2S2 	:  	 STD_LOGIC;
signal		  J2S3 	:  	 STD_LOGIC;
signal		  J2S4 	:  	 STD_LOGIC;
signal		  J2S5 	:  	 STD_LOGIC;
signal		  J2S6 	:  	 STD_LOGIC;
signal		  J2S7 	:  	 STD_LOGIC;
signal		  J2W0 	:  	 STD_LOGIC;
signal		  J2W1 	:  	 STD_LOGIC;
signal		  J2W2 	:  	 STD_LOGIC;
signal		  J2W3 	:  	 STD_LOGIC;
signal		  J2W4 	:  	 STD_LOGIC;
signal		  J2W5 	:  	 STD_LOGIC;
signal		  J2W6 	:  	 STD_LOGIC;
signal		  J2W7 	:  	 STD_LOGIC;
signal		  J_l_AB0 	:  	 STD_LOGIC;
signal		  J_l_AB1 	:  	 STD_LOGIC;
signal		  J_l_AB2 	:  	 STD_LOGIC;
signal		  J_l_AB3 	:  	 STD_LOGIC;
signal		  J_l_CD0 	:  	 STD_LOGIC;
signal		  J_l_CD1 	:  	 STD_LOGIC;
signal		  J_l_CD2 	:  	 STD_LOGIC;
signal		  J_l_CD3 	:  	 STD_LOGIC;
signal		  J_l_EF0 	:  	 STD_LOGIC;
signal		  J_l_EF1 	:  	 STD_LOGIC;
signal		  J_l_EF2 	:  	 STD_LOGIC;
signal		  J_l_EF3 	:  	 STD_LOGIC;
signal		  J_l_GH0 	:  	 STD_LOGIC;
signal		  J_l_GH1 	:  	 STD_LOGIC;
signal		  J_l_GH2 	:  	 STD_LOGIC;
signal		  J_l_GH3 	:  	 STD_LOGIC;
signal		  J4END_AB0 	:  	 STD_LOGIC;
signal		  J4END_AB1 	:  	 STD_LOGIC;
signal		  J4END_AB2 	:  	 STD_LOGIC;
signal		  J4END_AB3 	:  	 STD_LOGIC;
signal		  J4END_CD0 	:  	 STD_LOGIC;
signal		  J4END_CD1 	:  	 STD_LOGIC;
signal		  J4END_CD2 	:  	 STD_LOGIC;
signal		  J4END_CD3 	:  	 STD_LOGIC;
signal		  J4END_EF0 	:  	 STD_LOGIC;
signal		  J4END_EF1 	:  	 STD_LOGIC;
signal		  J4END_EF2 	:  	 STD_LOGIC;
signal		  J4END_EF3 	:  	 STD_LOGIC;
signal		  J4END_GH0 	:  	 STD_LOGIC;
signal		  J4END_GH1 	:  	 STD_LOGIC;
signal		  J4END_GH2 	:  	 STD_LOGIC;
signal		  J4END_GH3 	:  	 STD_LOGIC;


signal 	  N4BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2N0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2N7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2E7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2S7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J2W7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J_l_AB0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH3_input 	:	 std_logic_vector( 4 - 1 downto 0 );

-- The configuration bits (if any) are just a long shift register
signal 	 ConfigBits :	 unsigned( 344-1 downto 0 );

begin

-- the configuration bits shift register                                    
process(CLK)                                                                
begin                                                                       
	if CLK'event and CLK='1' then                                        
		if mode='1' then	--configuration mode                             
			ConfigBits <= CONFin & ConfigBits(ConfigBits'high downto 1);   
		end if;                                                             
	end if;                                                                 
end process;                                                                
CONFout <= ConfigBits(ConfigBits'high);                                    
 

-- switch matrix multiplexer  N1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG0
-- switch matrix multiplexer  N1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG1
-- switch matrix multiplexer  N1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG2
-- switch matrix multiplexer  N1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-N1BEG3
-- switch matrix multiplexer  N2BEG0 		MUX-1
N2BEG0 	 <= 	 J2N0 ;
-- switch matrix multiplexer  N2BEG1 		MUX-1
N2BEG1 	 <= 	 J2N1 ;
-- switch matrix multiplexer  N2BEG2 		MUX-1
N2BEG2 	 <= 	 J2N2 ;
-- switch matrix multiplexer  N2BEG3 		MUX-1
N2BEG3 	 <= 	 J2N3 ;
-- switch matrix multiplexer  N2BEG4 		MUX-1
N2BEG4 	 <= 	 J2N4 ;
-- switch matrix multiplexer  N2BEG5 		MUX-1
N2BEG5 	 <= 	 J2N5 ;
-- switch matrix multiplexer  N2BEG6 		MUX-1
N2BEG6 	 <= 	 J2N6 ;
-- switch matrix multiplexer  N2BEG7 		MUX-1
N2BEG7 	 <= 	 J2N7 ;
-- switch matrix multiplexer  N2BEGb0 		MUX-1
N2BEGb0 	 <= 	 N2MID0 ;
-- switch matrix multiplexer  N2BEGb1 		MUX-1
N2BEGb1 	 <= 	 N2MID1 ;
-- switch matrix multiplexer  N2BEGb2 		MUX-1
N2BEGb2 	 <= 	 N2MID2 ;
-- switch matrix multiplexer  N2BEGb3 		MUX-1
N2BEGb3 	 <= 	 N2MID3 ;
-- switch matrix multiplexer  N2BEGb4 		MUX-1
N2BEGb4 	 <= 	 N2MID4 ;
-- switch matrix multiplexer  N2BEGb5 		MUX-1
N2BEGb5 	 <= 	 N2MID5 ;
-- switch matrix multiplexer  N2BEGb6 		MUX-1
N2BEGb6 	 <= 	 N2MID6 ;
-- switch matrix multiplexer  N2BEGb7 		MUX-1
N2BEGb7 	 <= 	 N2MID7 ;
-- switch matrix multiplexer  N4BEG0 		MUX-4
N4BEG0_input 	 <= LE_O & E6END1 & N4END1 & N2END2;
N4BEG0	<= N4BEG0_input(TO_INTEGER(ConfigBits(1 downto 0)));
 
-- switch matrix multiplexer  N4BEG1 		MUX-4
N4BEG1_input 	 <= LF_O & E6END0 & N4END2 & N2END3;
N4BEG1	<= N4BEG1_input(TO_INTEGER(ConfigBits(3 downto 2)));
 
-- switch matrix multiplexer  N4BEG2 		MUX-4
N4BEG2_input 	 <= LG_O & W6END1 & N4END3 & N2END0;
N4BEG2	<= N4BEG2_input(TO_INTEGER(ConfigBits(5 downto 4)));
 
-- switch matrix multiplexer  N4BEG3 		MUX-4
N4BEG3_input 	 <= LH_O & W6END1 & N4END0 & N2END1;
N4BEG3	<= N4BEG3_input(TO_INTEGER(ConfigBits(7 downto 6)));
 
-- switch matrix multiplexer  Co0 		MUX-1
Co0 	 <= 	 LH_Co ;
-- switch matrix multiplexer  E1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG0
-- switch matrix multiplexer  E1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG1
-- switch matrix multiplexer  E1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG2
-- switch matrix multiplexer  E1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-E1BEG3
-- switch matrix multiplexer  E2BEG0 		MUX-1
E2BEG0 	 <= 	 J2E0 ;
-- switch matrix multiplexer  E2BEG1 		MUX-1
E2BEG1 	 <= 	 J2E1 ;
-- switch matrix multiplexer  E2BEG2 		MUX-1
E2BEG2 	 <= 	 J2E2 ;
-- switch matrix multiplexer  E2BEG3 		MUX-1
E2BEG3 	 <= 	 J2E3 ;
-- switch matrix multiplexer  E2BEG4 		MUX-1
E2BEG4 	 <= 	 J2E4 ;
-- switch matrix multiplexer  E2BEG5 		MUX-1
E2BEG5 	 <= 	 J2E5 ;
-- switch matrix multiplexer  E2BEG6 		MUX-1
E2BEG6 	 <= 	 J2E6 ;
-- switch matrix multiplexer  E2BEG7 		MUX-1
E2BEG7 	 <= 	 J2E7 ;
-- switch matrix multiplexer  E2BEGb0 		MUX-1
E2BEGb0 	 <= 	 E2MID0 ;
-- switch matrix multiplexer  E2BEGb1 		MUX-1
E2BEGb1 	 <= 	 E2MID1 ;
-- switch matrix multiplexer  E2BEGb2 		MUX-1
E2BEGb2 	 <= 	 E2MID2 ;
-- switch matrix multiplexer  E2BEGb3 		MUX-1
E2BEGb3 	 <= 	 E2MID3 ;
-- switch matrix multiplexer  E2BEGb4 		MUX-1
E2BEGb4 	 <= 	 E2MID4 ;
-- switch matrix multiplexer  E2BEGb5 		MUX-1
E2BEGb5 	 <= 	 E2MID5 ;
-- switch matrix multiplexer  E2BEGb6 		MUX-1
E2BEGb6 	 <= 	 E2MID6 ;
-- switch matrix multiplexer  E2BEGb7 		MUX-1
E2BEGb7 	 <= 	 E2MID7 ;
-- switch matrix multiplexer  E6BEG0 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG0
-- switch matrix multiplexer  E6BEG1 		MUX-0
-- WARNING unused multiplexer MUX-E6BEG1
-- switch matrix multiplexer  S1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG0
-- switch matrix multiplexer  S1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG1
-- switch matrix multiplexer  S1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG2
-- switch matrix multiplexer  S1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-S1BEG3
-- switch matrix multiplexer  S2BEG0 		MUX-1
S2BEG0 	 <= 	 J2S0 ;
-- switch matrix multiplexer  S2BEG1 		MUX-1
S2BEG1 	 <= 	 J2S1 ;
-- switch matrix multiplexer  S2BEG2 		MUX-1
S2BEG2 	 <= 	 J2S2 ;
-- switch matrix multiplexer  S2BEG3 		MUX-1
S2BEG3 	 <= 	 J2S3 ;
-- switch matrix multiplexer  S2BEG4 		MUX-1
S2BEG4 	 <= 	 J2S4 ;
-- switch matrix multiplexer  S2BEG5 		MUX-1
S2BEG5 	 <= 	 J2S5 ;
-- switch matrix multiplexer  S2BEG6 		MUX-1
S2BEG6 	 <= 	 J2S6 ;
-- switch matrix multiplexer  S2BEG7 		MUX-1
S2BEG7 	 <= 	 J2S7 ;
-- switch matrix multiplexer  S2BEGb0 		MUX-1
S2BEGb0 	 <= 	 S2MID0 ;
-- switch matrix multiplexer  S2BEGb1 		MUX-1
S2BEGb1 	 <= 	 S2MID1 ;
-- switch matrix multiplexer  S2BEGb2 		MUX-1
S2BEGb2 	 <= 	 S2MID2 ;
-- switch matrix multiplexer  S2BEGb3 		MUX-1
S2BEGb3 	 <= 	 S2MID3 ;
-- switch matrix multiplexer  S2BEGb4 		MUX-1
S2BEGb4 	 <= 	 S2MID4 ;
-- switch matrix multiplexer  S2BEGb5 		MUX-1
S2BEGb5 	 <= 	 S2MID5 ;
-- switch matrix multiplexer  S2BEGb6 		MUX-1
S2BEGb6 	 <= 	 S2MID6 ;
-- switch matrix multiplexer  S2BEGb7 		MUX-1
S2BEGb7 	 <= 	 S2MID7 ;
-- switch matrix multiplexer  S4BEG0 		MUX-4
S4BEG0_input 	 <= LA_O & S4END1 & S2END2 & E6END1;
S4BEG0	<= S4BEG0_input(TO_INTEGER(ConfigBits(9 downto 8)));
 
-- switch matrix multiplexer  S4BEG1 		MUX-4
S4BEG1_input 	 <= LB_O & S4END2 & S2END3 & E6END0;
S4BEG1	<= S4BEG1_input(TO_INTEGER(ConfigBits(11 downto 10)));
 
-- switch matrix multiplexer  S4BEG2 		MUX-4
S4BEG2_input 	 <= LC_O & W6END1 & S4END3 & S2END0;
S4BEG2	<= S4BEG2_input(TO_INTEGER(ConfigBits(13 downto 12)));
 
-- switch matrix multiplexer  S4BEG3 		MUX-4
S4BEG3_input 	 <= LD_O & W6END1 & S4END0 & S2END1;
S4BEG3	<= S4BEG3_input(TO_INTEGER(ConfigBits(15 downto 14)));
 
-- switch matrix multiplexer  W1BEG0 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG0
-- switch matrix multiplexer  W1BEG1 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG1
-- switch matrix multiplexer  W1BEG2 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG2
-- switch matrix multiplexer  W1BEG3 		MUX-0
-- WARNING unused multiplexer MUX-W1BEG3
-- switch matrix multiplexer  W2BEG0 		MUX-1
W2BEG0 	 <= 	 J2W0 ;
-- switch matrix multiplexer  W2BEG1 		MUX-1
W2BEG1 	 <= 	 J2W1 ;
-- switch matrix multiplexer  W2BEG2 		MUX-1
W2BEG2 	 <= 	 J2W2 ;
-- switch matrix multiplexer  W2BEG3 		MUX-1
W2BEG3 	 <= 	 J2W3 ;
-- switch matrix multiplexer  W2BEG4 		MUX-1
W2BEG4 	 <= 	 J2W4 ;
-- switch matrix multiplexer  W2BEG5 		MUX-1
W2BEG5 	 <= 	 J2W5 ;
-- switch matrix multiplexer  W2BEG6 		MUX-1
W2BEG6 	 <= 	 J2W6 ;
-- switch matrix multiplexer  W2BEG7 		MUX-1
W2BEG7 	 <= 	 J2W7 ;
-- switch matrix multiplexer  W2BEGb0 		MUX-1
W2BEGb0 	 <= 	 W2MID0 ;
-- switch matrix multiplexer  W2BEGb1 		MUX-1
W2BEGb1 	 <= 	 W2MID1 ;
-- switch matrix multiplexer  W2BEGb2 		MUX-1
W2BEGb2 	 <= 	 W2MID2 ;
-- switch matrix multiplexer  W2BEGb3 		MUX-1
W2BEGb3 	 <= 	 W2MID3 ;
-- switch matrix multiplexer  W2BEGb4 		MUX-1
W2BEGb4 	 <= 	 W2MID4 ;
-- switch matrix multiplexer  W2BEGb5 		MUX-1
W2BEGb5 	 <= 	 W2MID5 ;
-- switch matrix multiplexer  W2BEGb6 		MUX-1
W2BEGb6 	 <= 	 W2MID6 ;
-- switch matrix multiplexer  W2BEGb7 		MUX-1
W2BEGb7 	 <= 	 W2MID7 ;
-- switch matrix multiplexer  W6BEG0 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG0
-- switch matrix multiplexer  W6BEG1 		MUX-0
-- WARNING unused multiplexer MUX-W6BEG1
-- switch matrix multiplexer  LA_I0 		MUX-4
LA_I0_input 	 <= J_l_AB0 & J2END_AB0 & J2MID_ABb0 & J2MID_ABa0;
LA_I0	<= LA_I0_input(TO_INTEGER(ConfigBits(17 downto 16)));
 
-- switch matrix multiplexer  LA_I1 		MUX-4
LA_I1_input 	 <= J_l_AB1 & J2END_AB1 & J2MID_ABb1 & J2MID_ABa1;
LA_I1	<= LA_I1_input(TO_INTEGER(ConfigBits(19 downto 18)));
 
-- switch matrix multiplexer  LA_I2 		MUX-4
LA_I2_input 	 <= J_l_AB2 & J2END_AB2 & J2MID_ABb2 & J2MID_ABa2;
LA_I2	<= LA_I2_input(TO_INTEGER(ConfigBits(21 downto 20)));
 
-- switch matrix multiplexer  LA_I3 		MUX-4
LA_I3_input 	 <= J_l_AB3 & J2END_AB3 & J2MID_ABb3 & J2MID_ABa3;
LA_I3	<= LA_I3_input(TO_INTEGER(ConfigBits(23 downto 22)));
 
-- switch matrix multiplexer  LA_Ci 		MUX-1
LA_Ci 	 <= 	 Ci0 ;
-- switch matrix multiplexer  LB_I0 		MUX-4
LB_I0_input 	 <= J4END_AB0 & J2END_AB0 & J2MID_ABb0 & J2MID_ABa0;
LB_I0	<= LB_I0_input(TO_INTEGER(ConfigBits(25 downto 24)));
 
-- switch matrix multiplexer  LB_I1 		MUX-4
LB_I1_input 	 <= J4END_AB1 & J2END_AB1 & J2MID_ABb1 & J2MID_ABa1;
LB_I1	<= LB_I1_input(TO_INTEGER(ConfigBits(27 downto 26)));
 
-- switch matrix multiplexer  LB_I2 		MUX-4
LB_I2_input 	 <= J4END_AB2 & J2END_AB2 & J2MID_ABb2 & J2MID_ABa2;
LB_I2	<= LB_I2_input(TO_INTEGER(ConfigBits(29 downto 28)));
 
-- switch matrix multiplexer  LB_I3 		MUX-4
LB_I3_input 	 <= J4END_AB3 & J2END_AB3 & J2MID_ABb3 & J2MID_ABa3;
LB_I3	<= LB_I3_input(TO_INTEGER(ConfigBits(31 downto 30)));
 
-- switch matrix multiplexer  LB_Ci 		MUX-1
LB_Ci 	 <= 	 LA_Co ;
-- switch matrix multiplexer  LC_I0 		MUX-4
LC_I0_input 	 <= J_l_CD0 & J2END_CD0 & J2MID_CDb0 & J2MID_CDa0;
LC_I0	<= LC_I0_input(TO_INTEGER(ConfigBits(33 downto 32)));
 
-- switch matrix multiplexer  LC_I1 		MUX-4
LC_I1_input 	 <= J_l_CD1 & J2END_CD1 & J2MID_CDb1 & J2MID_CDa1;
LC_I1	<= LC_I1_input(TO_INTEGER(ConfigBits(35 downto 34)));
 
-- switch matrix multiplexer  LC_I2 		MUX-4
LC_I2_input 	 <= J_l_CD2 & J2END_CD2 & J2MID_CDb2 & J2MID_CDa2;
LC_I2	<= LC_I2_input(TO_INTEGER(ConfigBits(37 downto 36)));
 
-- switch matrix multiplexer  LC_I3 		MUX-4
LC_I3_input 	 <= J_l_CD3 & J2END_CD3 & J2MID_CDb3 & J2MID_CDa3;
LC_I3	<= LC_I3_input(TO_INTEGER(ConfigBits(39 downto 38)));
 
-- switch matrix multiplexer  LC_Ci 		MUX-1
LC_Ci 	 <= 	 LB_Co ;
-- switch matrix multiplexer  LD_I0 		MUX-4
LD_I0_input 	 <= J4END_CD0 & J2END_CD0 & J2MID_CDb0 & J2MID_CDa0;
LD_I0	<= LD_I0_input(TO_INTEGER(ConfigBits(41 downto 40)));
 
-- switch matrix multiplexer  LD_I1 		MUX-4
LD_I1_input 	 <= J4END_CD1 & J2END_CD1 & J2MID_CDb1 & J2MID_CDa1;
LD_I1	<= LD_I1_input(TO_INTEGER(ConfigBits(43 downto 42)));
 
-- switch matrix multiplexer  LD_I2 		MUX-4
LD_I2_input 	 <= J4END_CD2 & J2END_CD2 & J2MID_CDb2 & J2MID_CDa2;
LD_I2	<= LD_I2_input(TO_INTEGER(ConfigBits(45 downto 44)));
 
-- switch matrix multiplexer  LD_I3 		MUX-4
LD_I3_input 	 <= J4END_CD3 & J2END_CD3 & J2MID_CDb3 & J2MID_CDa3;
LD_I3	<= LD_I3_input(TO_INTEGER(ConfigBits(47 downto 46)));
 
-- switch matrix multiplexer  LD_Ci 		MUX-1
LD_Ci 	 <= 	 LC_Co ;
-- switch matrix multiplexer  LE_I0 		MUX-4
LE_I0_input 	 <= J_l_EF0 & J2END_EF0 & J2MID_EFb0 & J2MID_EFa0;
LE_I0	<= LE_I0_input(TO_INTEGER(ConfigBits(49 downto 48)));
 
-- switch matrix multiplexer  LE_I1 		MUX-4
LE_I1_input 	 <= J_l_EF1 & J2END_EF1 & J2MID_EFb1 & J2MID_EFa1;
LE_I1	<= LE_I1_input(TO_INTEGER(ConfigBits(51 downto 50)));
 
-- switch matrix multiplexer  LE_I2 		MUX-4
LE_I2_input 	 <= J_l_EF2 & J2END_EF2 & J2MID_EFb2 & J2MID_EFa2;
LE_I2	<= LE_I2_input(TO_INTEGER(ConfigBits(53 downto 52)));
 
-- switch matrix multiplexer  LE_I3 		MUX-4
LE_I3_input 	 <= J_l_EF3 & J2END_EF3 & J2MID_EFb3 & J2MID_EFa3;
LE_I3	<= LE_I3_input(TO_INTEGER(ConfigBits(55 downto 54)));
 
-- switch matrix multiplexer  LE_Ci 		MUX-1
LE_Ci 	 <= 	 LD_Co ;
-- switch matrix multiplexer  LF_I0 		MUX-4
LF_I0_input 	 <= J4END_EF0 & J2END_EF0 & J2MID_EFb0 & J2MID_EFa0;
LF_I0	<= LF_I0_input(TO_INTEGER(ConfigBits(57 downto 56)));
 
-- switch matrix multiplexer  LF_I1 		MUX-4
LF_I1_input 	 <= J4END_EF1 & J2END_EF1 & J2MID_EFb1 & J2MID_EFa1;
LF_I1	<= LF_I1_input(TO_INTEGER(ConfigBits(59 downto 58)));
 
-- switch matrix multiplexer  LF_I2 		MUX-4
LF_I2_input 	 <= J4END_EF2 & J2END_EF2 & J2MID_EFb2 & J2MID_EFa2;
LF_I2	<= LF_I2_input(TO_INTEGER(ConfigBits(61 downto 60)));
 
-- switch matrix multiplexer  LF_I3 		MUX-4
LF_I3_input 	 <= J4END_EF3 & J2END_EF3 & J2MID_EFb3 & J2MID_EFa3;
LF_I3	<= LF_I3_input(TO_INTEGER(ConfigBits(63 downto 62)));
 
-- switch matrix multiplexer  LF_Ci 		MUX-1
LF_Ci 	 <= 	 LE_Co ;
-- switch matrix multiplexer  LG_I0 		MUX-4
LG_I0_input 	 <= J_l_GH0 & J2END_GH0 & J2MID_GHb0 & J2MID_GHa0;
LG_I0	<= LG_I0_input(TO_INTEGER(ConfigBits(65 downto 64)));
 
-- switch matrix multiplexer  LG_I1 		MUX-4
LG_I1_input 	 <= J_l_GH1 & J2END_GH1 & J2MID_GHb1 & J2MID_GHa1;
LG_I1	<= LG_I1_input(TO_INTEGER(ConfigBits(67 downto 66)));
 
-- switch matrix multiplexer  LG_I2 		MUX-4
LG_I2_input 	 <= J_l_GH2 & J2END_GH2 & J2MID_GHb2 & J2MID_GHa2;
LG_I2	<= LG_I2_input(TO_INTEGER(ConfigBits(69 downto 68)));
 
-- switch matrix multiplexer  LG_I3 		MUX-4
LG_I3_input 	 <= J_l_GH3 & J2END_GH3 & J2MID_GHb3 & J2MID_GHa3;
LG_I3	<= LG_I3_input(TO_INTEGER(ConfigBits(71 downto 70)));
 
-- switch matrix multiplexer  LG_Ci 		MUX-1
LG_Ci 	 <= 	 LF_Co ;
-- switch matrix multiplexer  LH_I0 		MUX-4
LH_I0_input 	 <= J4END_GH0 & J2END_GH0 & J2MID_GHb0 & J2MID_GHa0;
LH_I0	<= LH_I0_input(TO_INTEGER(ConfigBits(73 downto 72)));
 
-- switch matrix multiplexer  LH_I1 		MUX-4
LH_I1_input 	 <= J4END_GH1 & J2END_GH1 & J2MID_GHb1 & J2MID_GHa1;
LH_I1	<= LH_I1_input(TO_INTEGER(ConfigBits(75 downto 74)));
 
-- switch matrix multiplexer  LH_I2 		MUX-4
LH_I2_input 	 <= J4END_GH2 & J2END_GH2 & J2MID_GHb2 & J2MID_GHa2;
LH_I2	<= LH_I2_input(TO_INTEGER(ConfigBits(77 downto 76)));
 
-- switch matrix multiplexer  LH_I3 		MUX-4
LH_I3_input 	 <= J4END_GH3 & J2END_GH3 & J2MID_GHb3 & J2MID_GHa3;
LH_I3	<= LH_I3_input(TO_INTEGER(ConfigBits(79 downto 78)));
 
-- switch matrix multiplexer  LH_Ci 		MUX-1
LH_Ci 	 <= 	 LG_Co ;
-- switch matrix multiplexer  A 		MUX-1
A 	 <= 	 LA_O ;
-- switch matrix multiplexer  B 		MUX-1
B 	 <= 	 LB_O ;
-- switch matrix multiplexer  C 		MUX-1
C 	 <= 	 LC_O ;
-- switch matrix multiplexer  D 		MUX-1
D 	 <= 	 LD_O ;
-- switch matrix multiplexer  E 		MUX-1
E 	 <= 	 LE_O ;
-- switch matrix multiplexer  F 		MUX-1
F 	 <= 	 LF_O ;
-- switch matrix multiplexer  G 		MUX-1
G 	 <= 	 LG_O ;
-- switch matrix multiplexer  H 		MUX-1
H 	 <= 	 LH_O ;
-- switch matrix multiplexer  S0 		MUX-4
S0_input 	 <= J2W4 & J2S4 & J2E4 & J2N4;
S0	<= S0_input(TO_INTEGER(ConfigBits(81 downto 80)));
 
-- switch matrix multiplexer  S1 		MUX-4
S1_input 	 <= J2W5 & J2S5 & J2E5 & J2N5;
S1	<= S1_input(TO_INTEGER(ConfigBits(83 downto 82)));
 
-- switch matrix multiplexer  S2 		MUX-4
S2_input 	 <= J2W6 & J2S6 & J2E6 & J2N6;
S2	<= S2_input(TO_INTEGER(ConfigBits(85 downto 84)));
 
-- switch matrix multiplexer  S3 		MUX-4
S3_input 	 <= J2W7 & J2S7 & J2E7 & J2N7;
S3	<= S3_input(TO_INTEGER(ConfigBits(87 downto 86)));
 
-- switch matrix multiplexer  J2MID_ABa0 		MUX-4
J2MID_ABa0_input 	 <= J2N3 & W2MID6 & S2MID6 & N2MID6;
J2MID_ABa0	<= J2MID_ABa0_input(TO_INTEGER(ConfigBits(89 downto 88)));
 
-- switch matrix multiplexer  J2MID_ABa1 		MUX-4
J2MID_ABa1_input 	 <= J2E3 & W2MID2 & S2MID2 & E2MID2;
J2MID_ABa1	<= J2MID_ABa1_input(TO_INTEGER(ConfigBits(91 downto 90)));
 
-- switch matrix multiplexer  J2MID_ABa2 		MUX-4
J2MID_ABa2_input 	 <= J2S3 & W2MID4 & E2MID4 & N2MID4;
J2MID_ABa2	<= J2MID_ABa2_input(TO_INTEGER(ConfigBits(93 downto 92)));
 
-- switch matrix multiplexer  J2MID_ABa3 		MUX-4
J2MID_ABa3_input 	 <= J2W3 & S2MID0 & E2MID0 & N2MID0;
J2MID_ABa3	<= J2MID_ABa3_input(TO_INTEGER(ConfigBits(95 downto 94)));
 
-- switch matrix multiplexer  J2MID_CDa0 		MUX-4
J2MID_CDa0_input 	 <= J2N4 & W2MID6 & S2MID6 & E2MID6;
J2MID_CDa0	<= J2MID_CDa0_input(TO_INTEGER(ConfigBits(97 downto 96)));
 
-- switch matrix multiplexer  J2MID_CDa1 		MUX-4
J2MID_CDa1_input 	 <= J2E4 & W2MID2 & E2MID2 & N2MID2;
J2MID_CDa1	<= J2MID_CDa1_input(TO_INTEGER(ConfigBits(99 downto 98)));
 
-- switch matrix multiplexer  J2MID_CDa2 		MUX-4
J2MID_CDa2_input 	 <= J2S4 & S2MID4 & E2MID4 & N2MID4;
J2MID_CDa2	<= J2MID_CDa2_input(TO_INTEGER(ConfigBits(101 downto 100)));
 
-- switch matrix multiplexer  J2MID_CDa3 		MUX-4
J2MID_CDa3_input 	 <= J2W4 & W2MID0 & S2MID0 & N2MID0;
J2MID_CDa3	<= J2MID_CDa3_input(TO_INTEGER(ConfigBits(103 downto 102)));
 
-- switch matrix multiplexer  J2MID_EFa0 		MUX-4
J2MID_EFa0_input 	 <= J2N5 & W2MID6 & E2MID6 & N2MID6;
J2MID_EFa0	<= J2MID_EFa0_input(TO_INTEGER(ConfigBits(105 downto 104)));
 
-- switch matrix multiplexer  J2MID_EFa1 		MUX-4
J2MID_EFa1_input 	 <= J2E5 & S2MID2 & E2MID2 & N2MID2;
J2MID_EFa1	<= J2MID_EFa1_input(TO_INTEGER(ConfigBits(107 downto 106)));
 
-- switch matrix multiplexer  J2MID_EFa2 		MUX-4
J2MID_EFa2_input 	 <= J2S5 & W2MID4 & S2MID4 & N2MID4;
J2MID_EFa2	<= J2MID_EFa2_input(TO_INTEGER(ConfigBits(109 downto 108)));
 
-- switch matrix multiplexer  J2MID_EFa3 		MUX-4
J2MID_EFa3_input 	 <= J2W5 & W2MID0 & S2MID0 & E2MID0;
J2MID_EFa3	<= J2MID_EFa3_input(TO_INTEGER(ConfigBits(111 downto 110)));
 
-- switch matrix multiplexer  J2MID_GHa0 		MUX-4
J2MID_GHa0_input 	 <= J2N6 & S2MID6 & E2MID6 & N2MID6;
J2MID_GHa0	<= J2MID_GHa0_input(TO_INTEGER(ConfigBits(113 downto 112)));
 
-- switch matrix multiplexer  J2MID_GHa1 		MUX-4
J2MID_GHa1_input 	 <= J2E6 & W2MID2 & S2MID2 & N2MID2;
J2MID_GHa1	<= J2MID_GHa1_input(TO_INTEGER(ConfigBits(115 downto 114)));
 
-- switch matrix multiplexer  J2MID_GHa2 		MUX-4
J2MID_GHa2_input 	 <= J2S6 & W2MID4 & S2MID4 & E2MID4;
J2MID_GHa2	<= J2MID_GHa2_input(TO_INTEGER(ConfigBits(117 downto 116)));
 
-- switch matrix multiplexer  J2MID_GHa3 		MUX-4
J2MID_GHa3_input 	 <= J2W6 & W2MID0 & E2MID0 & N2MID0;
J2MID_GHa3	<= J2MID_GHa3_input(TO_INTEGER(ConfigBits(119 downto 118)));
 
-- switch matrix multiplexer  J2MID_ABb0 		MUX-4
J2MID_ABb0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7;
J2MID_ABb0	<= J2MID_ABb0_input(TO_INTEGER(ConfigBits(121 downto 120)));
 
-- switch matrix multiplexer  J2MID_ABb1 		MUX-4
J2MID_ABb1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3;
J2MID_ABb1	<= J2MID_ABb1_input(TO_INTEGER(ConfigBits(123 downto 122)));
 
-- switch matrix multiplexer  J2MID_ABb2 		MUX-4
J2MID_ABb2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5;
J2MID_ABb2	<= J2MID_ABb2_input(TO_INTEGER(ConfigBits(125 downto 124)));
 
-- switch matrix multiplexer  J2MID_ABb3 		MUX-4
J2MID_ABb3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1;
J2MID_ABb3	<= J2MID_ABb3_input(TO_INTEGER(ConfigBits(127 downto 126)));
 
-- switch matrix multiplexer  J2MID_CDb0 		MUX-4
J2MID_CDb0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7;
J2MID_CDb0	<= J2MID_CDb0_input(TO_INTEGER(ConfigBits(129 downto 128)));
 
-- switch matrix multiplexer  J2MID_CDb1 		MUX-4
J2MID_CDb1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3;
J2MID_CDb1	<= J2MID_CDb1_input(TO_INTEGER(ConfigBits(131 downto 130)));
 
-- switch matrix multiplexer  J2MID_CDb2 		MUX-4
J2MID_CDb2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5;
J2MID_CDb2	<= J2MID_CDb2_input(TO_INTEGER(ConfigBits(133 downto 132)));
 
-- switch matrix multiplexer  J2MID_CDb3 		MUX-4
J2MID_CDb3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1;
J2MID_CDb3	<= J2MID_CDb3_input(TO_INTEGER(ConfigBits(135 downto 134)));
 
-- switch matrix multiplexer  J2MID_EFb0 		MUX-4
J2MID_EFb0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7;
J2MID_EFb0	<= J2MID_EFb0_input(TO_INTEGER(ConfigBits(137 downto 136)));
 
-- switch matrix multiplexer  J2MID_EFb1 		MUX-4
J2MID_EFb1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3;
J2MID_EFb1	<= J2MID_EFb1_input(TO_INTEGER(ConfigBits(139 downto 138)));
 
-- switch matrix multiplexer  J2MID_EFb2 		MUX-4
J2MID_EFb2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5;
J2MID_EFb2	<= J2MID_EFb2_input(TO_INTEGER(ConfigBits(141 downto 140)));
 
-- switch matrix multiplexer  J2MID_EFb3 		MUX-4
J2MID_EFb3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1;
J2MID_EFb3	<= J2MID_EFb3_input(TO_INTEGER(ConfigBits(143 downto 142)));
 
-- switch matrix multiplexer  J2MID_GHb0 		MUX-4
J2MID_GHb0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7;
J2MID_GHb0	<= J2MID_GHb0_input(TO_INTEGER(ConfigBits(145 downto 144)));
 
-- switch matrix multiplexer  J2MID_GHb1 		MUX-4
J2MID_GHb1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3;
J2MID_GHb1	<= J2MID_GHb1_input(TO_INTEGER(ConfigBits(147 downto 146)));
 
-- switch matrix multiplexer  J2MID_GHb2 		MUX-4
J2MID_GHb2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5;
J2MID_GHb2	<= J2MID_GHb2_input(TO_INTEGER(ConfigBits(149 downto 148)));
 
-- switch matrix multiplexer  J2MID_GHb3 		MUX-4
J2MID_GHb3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1;
J2MID_GHb3	<= J2MID_GHb3_input(TO_INTEGER(ConfigBits(151 downto 150)));
 
-- switch matrix multiplexer  J2END_AB0 		MUX-4
J2END_AB0_input 	 <= W2END6 & S2END6 & E2END6 & N2END6;
J2END_AB0	<= J2END_AB0_input(TO_INTEGER(ConfigBits(153 downto 152)));
 
-- switch matrix multiplexer  J2END_AB1 		MUX-4
J2END_AB1_input 	 <= W2END2 & S2END2 & E2END2 & N2END2;
J2END_AB1	<= J2END_AB1_input(TO_INTEGER(ConfigBits(155 downto 154)));
 
-- switch matrix multiplexer  J2END_AB2 		MUX-4
J2END_AB2_input 	 <= W2END4 & S2END4 & E2END4 & N2END4;
J2END_AB2	<= J2END_AB2_input(TO_INTEGER(ConfigBits(157 downto 156)));
 
-- switch matrix multiplexer  J2END_AB3 		MUX-4
J2END_AB3_input 	 <= W2END0 & S2END0 & E2END0 & N2END0;
J2END_AB3	<= J2END_AB3_input(TO_INTEGER(ConfigBits(159 downto 158)));
 
-- switch matrix multiplexer  J2END_CD0 		MUX-4
J2END_CD0_input 	 <= W2END6 & S2END6 & E2END6 & N2END6;
J2END_CD0	<= J2END_CD0_input(TO_INTEGER(ConfigBits(161 downto 160)));
 
-- switch matrix multiplexer  J2END_CD1 		MUX-4
J2END_CD1_input 	 <= W2END2 & S2END2 & E2END2 & N2END2;
J2END_CD1	<= J2END_CD1_input(TO_INTEGER(ConfigBits(163 downto 162)));
 
-- switch matrix multiplexer  J2END_CD2 		MUX-4
J2END_CD2_input 	 <= W2END4 & S2END4 & E2END4 & N2END4;
J2END_CD2	<= J2END_CD2_input(TO_INTEGER(ConfigBits(165 downto 164)));
 
-- switch matrix multiplexer  J2END_CD3 		MUX-4
J2END_CD3_input 	 <= W2END0 & S2END0 & E2END0 & N2END0;
J2END_CD3	<= J2END_CD3_input(TO_INTEGER(ConfigBits(167 downto 166)));
 
-- switch matrix multiplexer  J2END_EF0 		MUX-4
J2END_EF0_input 	 <= W2END7 & S2END7 & E2END7 & N2END7;
J2END_EF0	<= J2END_EF0_input(TO_INTEGER(ConfigBits(169 downto 168)));
 
-- switch matrix multiplexer  J2END_EF1 		MUX-4
J2END_EF1_input 	 <= W2END3 & S2END3 & E2END3 & N2END3;
J2END_EF1	<= J2END_EF1_input(TO_INTEGER(ConfigBits(171 downto 170)));
 
-- switch matrix multiplexer  J2END_EF2 		MUX-4
J2END_EF2_input 	 <= W2END5 & S2END5 & E2END5 & N2END5;
J2END_EF2	<= J2END_EF2_input(TO_INTEGER(ConfigBits(173 downto 172)));
 
-- switch matrix multiplexer  J2END_EF3 		MUX-4
J2END_EF3_input 	 <= W2END1 & S2END1 & E2END1 & N2END1;
J2END_EF3	<= J2END_EF3_input(TO_INTEGER(ConfigBits(175 downto 174)));
 
-- switch matrix multiplexer  J2END_GH0 		MUX-4
J2END_GH0_input 	 <= W2END7 & S2END7 & E2END7 & N2END7;
J2END_GH0	<= J2END_GH0_input(TO_INTEGER(ConfigBits(177 downto 176)));
 
-- switch matrix multiplexer  J2END_GH1 		MUX-4
J2END_GH1_input 	 <= W2END3 & S2END3 & E2END3 & N2END3;
J2END_GH1	<= J2END_GH1_input(TO_INTEGER(ConfigBits(179 downto 178)));
 
-- switch matrix multiplexer  J2END_GH2 		MUX-4
J2END_GH2_input 	 <= W2END5 & S2END5 & E2END5 & N2END5;
J2END_GH2	<= J2END_GH2_input(TO_INTEGER(ConfigBits(181 downto 180)));
 
-- switch matrix multiplexer  J2END_GH3 		MUX-4
J2END_GH3_input 	 <= W2END1 & S2END1 & E2END1 & N2END1;
J2END_GH3	<= J2END_GH3_input(TO_INTEGER(ConfigBits(183 downto 182)));
 
-- switch matrix multiplexer  J2N0 		MUX-16
J2N0_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S2END1 & E6END1 & E2END1 & E1END3 & N4END1 & N2END1;
J2N0	<= J2N0_input(TO_INTEGER(ConfigBits(187 downto 184)));
 
-- switch matrix multiplexer  J2N1 		MUX-16
J2N1_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S2END2 & E6END0 & E2END2 & E1END0 & N4END2 & N2END2;
J2N1	<= J2N1_input(TO_INTEGER(ConfigBits(191 downto 188)));
 
-- switch matrix multiplexer  J2N2 		MUX-16
J2N2_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S2END3 & E6END1 & E2END3 & E1END1 & N4END3 & N2END3;
J2N2	<= J2N2_input(TO_INTEGER(ConfigBits(195 downto 192)));
 
-- switch matrix multiplexer  J2N3 		MUX-16
J2N3_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S2END4 & E6END0 & E2END4 & E1END2 & N4END0 & N2END4;
J2N3	<= J2N3_input(TO_INTEGER(ConfigBits(199 downto 196)));
 
-- switch matrix multiplexer  J2N4 		MUX-16
J2N4_input 	 <= M_AB & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END5 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1;
J2N4	<= J2N4_input(TO_INTEGER(ConfigBits(203 downto 200)));
 
-- switch matrix multiplexer  J2N5 		MUX-16
J2N5_input 	 <= M_AD & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END6 & S1END2 & E2END6 & E1END2 & N2END6 & N1END2;
J2N5	<= J2N5_input(TO_INTEGER(ConfigBits(207 downto 204)));
 
-- switch matrix multiplexer  J2N6 		MUX-16
J2N6_input 	 <= M_AH & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END7 & S1END3 & E2END7 & E1END3 & N2END7 & N1END3;
J2N6	<= J2N6_input(TO_INTEGER(ConfigBits(211 downto 208)));
 
-- switch matrix multiplexer  J2N7 		MUX-16
J2N7_input 	 <= M_EF & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END0 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0;
J2N7	<= J2N7_input(TO_INTEGER(ConfigBits(215 downto 212)));
 
-- switch matrix multiplexer  J2E0 		MUX-16
J2E0_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S2END1 & E6END1 & E2END1 & N4END1 & N2END1 & N1END3;
J2E0	<= J2E0_input(TO_INTEGER(ConfigBits(219 downto 216)));
 
-- switch matrix multiplexer  J2E1 		MUX-16
J2E1_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S2END2 & E6END0 & E2END2 & N4END2 & N2END2 & N1END0;
J2E1	<= J2E1_input(TO_INTEGER(ConfigBits(223 downto 220)));
 
-- switch matrix multiplexer  J2E2 		MUX-16
J2E2_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S2END3 & E6END1 & E2END3 & N4END3 & N2END3 & N1END1;
J2E2	<= J2E2_input(TO_INTEGER(ConfigBits(227 downto 224)));
 
-- switch matrix multiplexer  J2E3 		MUX-16
J2E3_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S2END4 & E6END0 & E2END4 & N4END0 & N2END4 & N1END2;
J2E3	<= J2E3_input(TO_INTEGER(ConfigBits(231 downto 228)));
 
-- switch matrix multiplexer  J2E4 		MUX-16
J2E4_input 	 <= M_EF & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END1 & S2END5 & S1END3 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1;
J2E4	<= J2E4_input(TO_INTEGER(ConfigBits(235 downto 232)));
 
-- switch matrix multiplexer  J2E5 		MUX-16
J2E5_input 	 <= M_AB & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & S2END6 & S1END2 & S1END0 & E2END6 & E1END2 & N2END6 & N1END2;
J2E5	<= J2E5_input(TO_INTEGER(ConfigBits(239 downto 236)));
 
-- switch matrix multiplexer  J2E6 		MUX-16
J2E6_input 	 <= M_AD & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & S2END7 & S1END3 & S1END1 & E2END7 & E1END3 & N2END7 & N1END3;
J2E6	<= J2E6_input(TO_INTEGER(ConfigBits(243 downto 240)));
 
-- switch matrix multiplexer  J2E7 		MUX-16
J2E7_input 	 <= M_AH & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END0 & S2END0 & S1END2 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0;
J2E7	<= J2E7_input(TO_INTEGER(ConfigBits(247 downto 244)));
 
-- switch matrix multiplexer  J2S0 		MUX-16
J2S0_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S4END1 & S2END1 & E6END1 & E2END1 & E1END3 & N2END1;
J2S0	<= J2S0_input(TO_INTEGER(ConfigBits(251 downto 248)));
 
-- switch matrix multiplexer  J2S1 		MUX-16
J2S1_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S4END2 & S2END2 & E6END0 & E2END2 & E1END0 & N2END2;
J2S1	<= J2S1_input(TO_INTEGER(ConfigBits(255 downto 252)));
 
-- switch matrix multiplexer  J2S2 		MUX-16
J2S2_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S4END3 & S2END3 & E6END1 & E2END3 & E1END1 & N2END3;
J2S2	<= J2S2_input(TO_INTEGER(ConfigBits(259 downto 256)));
 
-- switch matrix multiplexer  J2S3 		MUX-16
J2S3_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S4END0 & S2END4 & E6END0 & E2END4 & E1END2 & N2END4;
J2S3	<= J2S3_input(TO_INTEGER(ConfigBits(263 downto 260)));
 
-- switch matrix multiplexer  J2S4 		MUX-16
J2S4_input 	 <= M_AH & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END5 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1;
J2S4	<= J2S4_input(TO_INTEGER(ConfigBits(267 downto 264)));
 
-- switch matrix multiplexer  J2S5 		MUX-16
J2S5_input 	 <= M_EF & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END6 & S1END2 & E2END6 & E1END2 & N2END6 & N1END2;
J2S5	<= J2S5_input(TO_INTEGER(ConfigBits(271 downto 268)));
 
-- switch matrix multiplexer  J2S6 		MUX-16
J2S6_input 	 <= M_AB & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END7 & S1END3 & E2END7 & E1END3 & N2END7 & N1END3;
J2S6	<= J2S6_input(TO_INTEGER(ConfigBits(275 downto 272)));
 
-- switch matrix multiplexer  J2S7 		MUX-16
J2S7_input 	 <= M_AD & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END0 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0;
J2S7	<= J2S7_input(TO_INTEGER(ConfigBits(279 downto 276)));
 
-- switch matrix multiplexer  J2W0 		MUX-16
J2W0_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S4END1 & S2END1 & E6END1 & E2END1 & N2END1 & N1END3;
J2W0	<= J2W0_input(TO_INTEGER(ConfigBits(283 downto 280)));
 
-- switch matrix multiplexer  J2W1 		MUX-16
J2W1_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S4END2 & S2END2 & E6END0 & E2END2 & N2END2 & N1END0;
J2W1	<= J2W1_input(TO_INTEGER(ConfigBits(287 downto 284)));
 
-- switch matrix multiplexer  J2W2 		MUX-16
J2W2_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S4END3 & S2END3 & E6END1 & E2END3 & N2END3 & N1END1;
J2W2	<= J2W2_input(TO_INTEGER(ConfigBits(291 downto 288)));
 
-- switch matrix multiplexer  J2W3 		MUX-16
J2W3_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S4END0 & S2END4 & E6END0 & E2END4 & N2END4 & N1END2;
J2W3	<= J2W3_input(TO_INTEGER(ConfigBits(295 downto 292)));
 
-- switch matrix multiplexer  J2W4 		MUX-16
J2W4_input 	 <= M_AD & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END1 & S2END5 & S1END3 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1;
J2W4	<= J2W4_input(TO_INTEGER(ConfigBits(299 downto 296)));
 
-- switch matrix multiplexer  J2W5 		MUX-16
J2W5_input 	 <= M_AH & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & S2END6 & S1END2 & S1END0 & E2END6 & E1END2 & N2END6 & N1END2;
J2W5	<= J2W5_input(TO_INTEGER(ConfigBits(303 downto 300)));
 
-- switch matrix multiplexer  J2W6 		MUX-16
J2W6_input 	 <= M_EF & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & S2END7 & S1END3 & S1END1 & E2END7 & E1END3 & N2END7 & N1END3;
J2W6	<= J2W6_input(TO_INTEGER(ConfigBits(307 downto 304)));
 
-- switch matrix multiplexer  J2W7 		MUX-16
J2W7_input 	 <= M_AB & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END0 & S2END0 & S1END2 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0;
J2W7	<= J2W7_input(TO_INTEGER(ConfigBits(311 downto 308)));
 
-- switch matrix multiplexer  J_l_AB0 		MUX-4
J_l_AB0_input 	 <= J2N1 & W2END3 & S4END3 & N4END3;
J_l_AB0	<= J_l_AB0_input(TO_INTEGER(ConfigBits(313 downto 312)));
 
-- switch matrix multiplexer  J_l_AB1 		MUX-4
J_l_AB1_input 	 <= J2E1 & W2END2 & S4END2 & E2END2;
J_l_AB1	<= J_l_AB1_input(TO_INTEGER(ConfigBits(315 downto 314)));
 
-- switch matrix multiplexer  J_l_AB2 		MUX-4
J_l_AB2_input 	 <= J2S1 & W6END1 & E6END1 & N4END1;
J_l_AB2	<= J_l_AB2_input(TO_INTEGER(ConfigBits(317 downto 316)));
 
-- switch matrix multiplexer  J_l_AB3 		MUX-4
J_l_AB3_input 	 <= J2W1 & S4END0 & E6END0 & N4END0;
J_l_AB3	<= J_l_AB3_input(TO_INTEGER(ConfigBits(319 downto 318)));
 
-- switch matrix multiplexer  J_l_CD0 		MUX-4
J_l_CD0_input 	 <= J2N2 & W2END3 & S4END3 & E2END3;
J_l_CD0	<= J_l_CD0_input(TO_INTEGER(ConfigBits(321 downto 320)));
 
-- switch matrix multiplexer  J_l_CD1 		MUX-4
J_l_CD1_input 	 <= J2E2 & W2END2 & E2END2 & N4END2;
J_l_CD1	<= J_l_CD1_input(TO_INTEGER(ConfigBits(323 downto 322)));
 
-- switch matrix multiplexer  J_l_CD2 		MUX-4
J_l_CD2_input 	 <= J2S2 & S4END1 & E6END1 & N4END1;
J_l_CD2	<= J_l_CD2_input(TO_INTEGER(ConfigBits(325 downto 324)));
 
-- switch matrix multiplexer  J_l_CD3 		MUX-4
J_l_CD3_input 	 <= J2W2 & W6END0 & S4END0 & N4END0;
J_l_CD3	<= J_l_CD3_input(TO_INTEGER(ConfigBits(327 downto 326)));
 
-- switch matrix multiplexer  J_l_EF0 		MUX-4
J_l_EF0_input 	 <= J2N3 & W2END3 & E2END3 & N4END3;
J_l_EF0	<= J_l_EF0_input(TO_INTEGER(ConfigBits(329 downto 328)));
 
-- switch matrix multiplexer  J_l_EF1 		MUX-4
J_l_EF1_input 	 <= J2E3 & S4END2 & E2END2 & N4END2;
J_l_EF1	<= J_l_EF1_input(TO_INTEGER(ConfigBits(331 downto 330)));
 
-- switch matrix multiplexer  J_l_EF2 		MUX-4
J_l_EF2_input 	 <= J2S3 & W6END1 & S4END1 & N4END1;
J_l_EF2	<= J_l_EF2_input(TO_INTEGER(ConfigBits(333 downto 332)));
 
-- switch matrix multiplexer  J_l_EF3 		MUX-4
J_l_EF3_input 	 <= J2W3 & W6END0 & S4END0 & E6END0;
J_l_EF3	<= J_l_EF3_input(TO_INTEGER(ConfigBits(335 downto 334)));
 
-- switch matrix multiplexer  J_l_GH0 		MUX-4
J_l_GH0_input 	 <= J2N4 & S4END3 & E2END3 & N4END3;
J_l_GH0	<= J_l_GH0_input(TO_INTEGER(ConfigBits(337 downto 336)));
 
-- switch matrix multiplexer  J_l_GH1 		MUX-4
J_l_GH1_input 	 <= J2E4 & W2END2 & S4END2 & N4END2;
J_l_GH1	<= J_l_GH1_input(TO_INTEGER(ConfigBits(339 downto 338)));
 
-- switch matrix multiplexer  J_l_GH2 		MUX-4
J_l_GH2_input 	 <= J2S4 & W6END1 & S4END1 & E6END1;
J_l_GH2	<= J_l_GH2_input(TO_INTEGER(ConfigBits(341 downto 340)));
 
-- switch matrix multiplexer  J_l_GH3 		MUX-4
J_l_GH3_input 	 <= J2W4 & W6END0 & E6END0 & N4END0;
J_l_GH3	<= J_l_GH3_input(TO_INTEGER(ConfigBits(343 downto 342)));
 
-- switch matrix multiplexer  J4END_AB0 		MUX-0
-- WARNING unused multiplexer MUX-J4END_AB0
-- switch matrix multiplexer  J4END_AB1 		MUX-0
-- WARNING unused multiplexer MUX-J4END_AB1
-- switch matrix multiplexer  J4END_AB2 		MUX-0
-- WARNING unused multiplexer MUX-J4END_AB2
-- switch matrix multiplexer  J4END_AB3 		MUX-0
-- WARNING unused multiplexer MUX-J4END_AB3
-- switch matrix multiplexer  J4END_CD0 		MUX-0
-- WARNING unused multiplexer MUX-J4END_CD0
-- switch matrix multiplexer  J4END_CD1 		MUX-0
-- WARNING unused multiplexer MUX-J4END_CD1
-- switch matrix multiplexer  J4END_CD2 		MUX-0
-- WARNING unused multiplexer MUX-J4END_CD2
-- switch matrix multiplexer  J4END_CD3 		MUX-0
-- WARNING unused multiplexer MUX-J4END_CD3
-- switch matrix multiplexer  J4END_EF0 		MUX-0
-- WARNING unused multiplexer MUX-J4END_EF0
-- switch matrix multiplexer  J4END_EF1 		MUX-0
-- WARNING unused multiplexer MUX-J4END_EF1
-- switch matrix multiplexer  J4END_EF2 		MUX-0
-- WARNING unused multiplexer MUX-J4END_EF2
-- switch matrix multiplexer  J4END_EF3 		MUX-0
-- WARNING unused multiplexer MUX-J4END_EF3
-- switch matrix multiplexer  J4END_GH0 		MUX-0
-- WARNING unused multiplexer MUX-J4END_GH0
-- switch matrix multiplexer  J4END_GH1 		MUX-0
-- WARNING unused multiplexer MUX-J4END_GH1
-- switch matrix multiplexer  J4END_GH2 		MUX-0
-- WARNING unused multiplexer MUX-J4END_GH2
-- switch matrix multiplexer  J4END_GH3 		MUX-0
-- WARNING unused multiplexer MUX-J4END_GH3

end architecture Behavioral;

