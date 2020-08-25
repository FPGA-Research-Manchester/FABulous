-- NumberOfConfigBits:392
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_package.all;

entity  LUT4AB_switch_matrix  is 
	Generic ( 
			 NoConfigBits : integer := 392 );
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
		  Ci0 	: in 	 STD_LOGIC;
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
		  J2MID_ABa_END0 	: in 	 STD_LOGIC;
		  J2MID_ABa_END1 	: in 	 STD_LOGIC;
		  J2MID_ABa_END2 	: in 	 STD_LOGIC;
		  J2MID_ABa_END3 	: in 	 STD_LOGIC;
		  J2MID_CDa_END0 	: in 	 STD_LOGIC;
		  J2MID_CDa_END1 	: in 	 STD_LOGIC;
		  J2MID_CDa_END2 	: in 	 STD_LOGIC;
		  J2MID_CDa_END3 	: in 	 STD_LOGIC;
		  J2MID_EFa_END0 	: in 	 STD_LOGIC;
		  J2MID_EFa_END1 	: in 	 STD_LOGIC;
		  J2MID_EFa_END2 	: in 	 STD_LOGIC;
		  J2MID_EFa_END3 	: in 	 STD_LOGIC;
		  J2MID_GHa_END0 	: in 	 STD_LOGIC;
		  J2MID_GHa_END1 	: in 	 STD_LOGIC;
		  J2MID_GHa_END2 	: in 	 STD_LOGIC;
		  J2MID_GHa_END3 	: in 	 STD_LOGIC;
		  J2MID_ABb_END0 	: in 	 STD_LOGIC;
		  J2MID_ABb_END1 	: in 	 STD_LOGIC;
		  J2MID_ABb_END2 	: in 	 STD_LOGIC;
		  J2MID_ABb_END3 	: in 	 STD_LOGIC;
		  J2MID_CDb_END0 	: in 	 STD_LOGIC;
		  J2MID_CDb_END1 	: in 	 STD_LOGIC;
		  J2MID_CDb_END2 	: in 	 STD_LOGIC;
		  J2MID_CDb_END3 	: in 	 STD_LOGIC;
		  J2MID_EFb_END0 	: in 	 STD_LOGIC;
		  J2MID_EFb_END1 	: in 	 STD_LOGIC;
		  J2MID_EFb_END2 	: in 	 STD_LOGIC;
		  J2MID_EFb_END3 	: in 	 STD_LOGIC;
		  J2MID_GHb_END0 	: in 	 STD_LOGIC;
		  J2MID_GHb_END1 	: in 	 STD_LOGIC;
		  J2MID_GHb_END2 	: in 	 STD_LOGIC;
		  J2MID_GHb_END3 	: in 	 STD_LOGIC;
		  J2END_AB_END0 	: in 	 STD_LOGIC;
		  J2END_AB_END1 	: in 	 STD_LOGIC;
		  J2END_AB_END2 	: in 	 STD_LOGIC;
		  J2END_AB_END3 	: in 	 STD_LOGIC;
		  J2END_CD_END0 	: in 	 STD_LOGIC;
		  J2END_CD_END1 	: in 	 STD_LOGIC;
		  J2END_CD_END2 	: in 	 STD_LOGIC;
		  J2END_CD_END3 	: in 	 STD_LOGIC;
		  J2END_EF_END0 	: in 	 STD_LOGIC;
		  J2END_EF_END1 	: in 	 STD_LOGIC;
		  J2END_EF_END2 	: in 	 STD_LOGIC;
		  J2END_EF_END3 	: in 	 STD_LOGIC;
		  J2END_GH_END0 	: in 	 STD_LOGIC;
		  J2END_GH_END1 	: in 	 STD_LOGIC;
		  J2END_GH_END2 	: in 	 STD_LOGIC;
		  J2END_GH_END3 	: in 	 STD_LOGIC;
		  JN2END0 	: in 	 STD_LOGIC;
		  JN2END1 	: in 	 STD_LOGIC;
		  JN2END2 	: in 	 STD_LOGIC;
		  JN2END3 	: in 	 STD_LOGIC;
		  JN2END4 	: in 	 STD_LOGIC;
		  JN2END5 	: in 	 STD_LOGIC;
		  JN2END6 	: in 	 STD_LOGIC;
		  JN2END7 	: in 	 STD_LOGIC;
		  JE2END0 	: in 	 STD_LOGIC;
		  JE2END1 	: in 	 STD_LOGIC;
		  JE2END2 	: in 	 STD_LOGIC;
		  JE2END3 	: in 	 STD_LOGIC;
		  JE2END4 	: in 	 STD_LOGIC;
		  JE2END5 	: in 	 STD_LOGIC;
		  JE2END6 	: in 	 STD_LOGIC;
		  JE2END7 	: in 	 STD_LOGIC;
		  JS2END0 	: in 	 STD_LOGIC;
		  JS2END1 	: in 	 STD_LOGIC;
		  JS2END2 	: in 	 STD_LOGIC;
		  JS2END3 	: in 	 STD_LOGIC;
		  JS2END4 	: in 	 STD_LOGIC;
		  JS2END5 	: in 	 STD_LOGIC;
		  JS2END6 	: in 	 STD_LOGIC;
		  JS2END7 	: in 	 STD_LOGIC;
		  JW2END0 	: in 	 STD_LOGIC;
		  JW2END1 	: in 	 STD_LOGIC;
		  JW2END2 	: in 	 STD_LOGIC;
		  JW2END3 	: in 	 STD_LOGIC;
		  JW2END4 	: in 	 STD_LOGIC;
		  JW2END5 	: in 	 STD_LOGIC;
		  JW2END6 	: in 	 STD_LOGIC;
		  JW2END7 	: in 	 STD_LOGIC;
		  J_l_AB_END0 	: in 	 STD_LOGIC;
		  J_l_AB_END1 	: in 	 STD_LOGIC;
		  J_l_AB_END2 	: in 	 STD_LOGIC;
		  J_l_AB_END3 	: in 	 STD_LOGIC;
		  J_l_CD_END0 	: in 	 STD_LOGIC;
		  J_l_CD_END1 	: in 	 STD_LOGIC;
		  J_l_CD_END2 	: in 	 STD_LOGIC;
		  J_l_CD_END3 	: in 	 STD_LOGIC;
		  J_l_EF_END0 	: in 	 STD_LOGIC;
		  J_l_EF_END1 	: in 	 STD_LOGIC;
		  J_l_EF_END2 	: in 	 STD_LOGIC;
		  J_l_EF_END3 	: in 	 STD_LOGIC;
		  J_l_GH_END0 	: in 	 STD_LOGIC;
		  J_l_GH_END1 	: in 	 STD_LOGIC;
		  J_l_GH_END2 	: in 	 STD_LOGIC;
		  J_l_GH_END3 	: in 	 STD_LOGIC;
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
		  J2MID_ABa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_ABa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_CDa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_EFa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG0 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG1 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG2 	: out 	 STD_LOGIC;
		  J2MID_GHa_BEG3 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_ABb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_CDb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_EFb_BEG3 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG0 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG1 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG2 	: out 	 STD_LOGIC;
		  J2MID_GHb_BEG3 	: out 	 STD_LOGIC;
		  J2END_AB_BEG0 	: out 	 STD_LOGIC;
		  J2END_AB_BEG1 	: out 	 STD_LOGIC;
		  J2END_AB_BEG2 	: out 	 STD_LOGIC;
		  J2END_AB_BEG3 	: out 	 STD_LOGIC;
		  J2END_CD_BEG0 	: out 	 STD_LOGIC;
		  J2END_CD_BEG1 	: out 	 STD_LOGIC;
		  J2END_CD_BEG2 	: out 	 STD_LOGIC;
		  J2END_CD_BEG3 	: out 	 STD_LOGIC;
		  J2END_EF_BEG0 	: out 	 STD_LOGIC;
		  J2END_EF_BEG1 	: out 	 STD_LOGIC;
		  J2END_EF_BEG2 	: out 	 STD_LOGIC;
		  J2END_EF_BEG3 	: out 	 STD_LOGIC;
		  J2END_GH_BEG0 	: out 	 STD_LOGIC;
		  J2END_GH_BEG1 	: out 	 STD_LOGIC;
		  J2END_GH_BEG2 	: out 	 STD_LOGIC;
		  J2END_GH_BEG3 	: out 	 STD_LOGIC;
		  JN2BEG0 	: out 	 STD_LOGIC;
		  JN2BEG1 	: out 	 STD_LOGIC;
		  JN2BEG2 	: out 	 STD_LOGIC;
		  JN2BEG3 	: out 	 STD_LOGIC;
		  JN2BEG4 	: out 	 STD_LOGIC;
		  JN2BEG5 	: out 	 STD_LOGIC;
		  JN2BEG6 	: out 	 STD_LOGIC;
		  JN2BEG7 	: out 	 STD_LOGIC;
		  JE2BEG0 	: out 	 STD_LOGIC;
		  JE2BEG1 	: out 	 STD_LOGIC;
		  JE2BEG2 	: out 	 STD_LOGIC;
		  JE2BEG3 	: out 	 STD_LOGIC;
		  JE2BEG4 	: out 	 STD_LOGIC;
		  JE2BEG5 	: out 	 STD_LOGIC;
		  JE2BEG6 	: out 	 STD_LOGIC;
		  JE2BEG7 	: out 	 STD_LOGIC;
		  JS2BEG0 	: out 	 STD_LOGIC;
		  JS2BEG1 	: out 	 STD_LOGIC;
		  JS2BEG2 	: out 	 STD_LOGIC;
		  JS2BEG3 	: out 	 STD_LOGIC;
		  JS2BEG4 	: out 	 STD_LOGIC;
		  JS2BEG5 	: out 	 STD_LOGIC;
		  JS2BEG6 	: out 	 STD_LOGIC;
		  JS2BEG7 	: out 	 STD_LOGIC;
		  JW2BEG0 	: out 	 STD_LOGIC;
		  JW2BEG1 	: out 	 STD_LOGIC;
		  JW2BEG2 	: out 	 STD_LOGIC;
		  JW2BEG3 	: out 	 STD_LOGIC;
		  JW2BEG4 	: out 	 STD_LOGIC;
		  JW2BEG5 	: out 	 STD_LOGIC;
		  JW2BEG6 	: out 	 STD_LOGIC;
		  JW2BEG7 	: out 	 STD_LOGIC;
		  J_l_AB_BEG0 	: out 	 STD_LOGIC;
		  J_l_AB_BEG1 	: out 	 STD_LOGIC;
		  J_l_AB_BEG2 	: out 	 STD_LOGIC;
		  J_l_AB_BEG3 	: out 	 STD_LOGIC;
		  J_l_CD_BEG0 	: out 	 STD_LOGIC;
		  J_l_CD_BEG1 	: out 	 STD_LOGIC;
		  J_l_CD_BEG2 	: out 	 STD_LOGIC;
		  J_l_CD_BEG3 	: out 	 STD_LOGIC;
		  J_l_EF_BEG0 	: out 	 STD_LOGIC;
		  J_l_EF_BEG1 	: out 	 STD_LOGIC;
		  J_l_EF_BEG2 	: out 	 STD_LOGIC;
		  J_l_EF_BEG3 	: out 	 STD_LOGIC;
		  J_l_GH_BEG0 	: out 	 STD_LOGIC;
		  J_l_GH_BEG1 	: out 	 STD_LOGIC;
		  J_l_GH_BEG2 	: out 	 STD_LOGIC;
		  J_l_GH_BEG3 	: out 	 STD_LOGIC;
	-- global
		 ConfigBits : in 	 STD_LOGIC_VECTOR( NoConfigBits -1 downto 0 )
	);
end entity LUT4AB_switch_matrix ;

architecture Behavioral of  LUT4AB_switch_matrix  is 

constant GND0	 : std_logic := '0';
constant GND	 : std_logic := '0';
constant VCC0	 : std_logic := '1';
constant VCC	 : std_logic := '1';
constant VDD0	 : std_logic := '1';
constant VDD	 : std_logic := '1';
	
signal 	  N1BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N1BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N1BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N1BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  N4BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  N4BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  Co0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E1BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  E1BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  E1BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  E1BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  E2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E6BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  E6BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  S1BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S1BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S1BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S1BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S4BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S4BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W1BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W1BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W1BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W1BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  W2BEG0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEG7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb0_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb1_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb2_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb3_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb4_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb5_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb6_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W2BEGb7_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  W6BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  W6BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  LA_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LA_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LB_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LB_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LC_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LC_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LD_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LD_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LE_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LE_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LF_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LF_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LG_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LG_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  LH_I0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_I3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  LH_Ci_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  A_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  B_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  C_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  D_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  E_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  F_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  G_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  H_input 	:	 std_logic_vector( 1 - 1 downto 0 );
signal 	  S0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  S3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABa_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDa_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFa_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHa_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_ABb_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_CDb_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_EFb_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2MID_GHb_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_AB_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_CD_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_EF_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J2END_GH_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  JN2BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JN2BEG7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JE2BEG7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JS2BEG7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG0_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG1_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG2_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG3_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG4_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG5_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG6_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  JW2BEG7_input 	:	 std_logic_vector( 16 - 1 downto 0 );
signal 	  J_l_AB_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_AB_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_CD_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_EF_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH_BEG0_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH_BEG1_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH_BEG2_input 	:	 std_logic_vector( 4 - 1 downto 0 );
signal 	  J_l_GH_BEG3_input 	:	 std_logic_vector( 4 - 1 downto 0 );

signal DEBUG_select_N1BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N1BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N1BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N1BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N4BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N4BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N4BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_N4BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_E1BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_E1BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_E1BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_E1BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_E6BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_E6BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_S1BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S1BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S1BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S1BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S4BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S4BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S4BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S4BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_W1BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_W1BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_W1BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_W1BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_W6BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_W6BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_LA_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LA_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LA_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LA_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LB_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LB_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LB_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LB_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LC_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LC_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LC_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LC_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LD_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LD_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LD_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LD_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LE_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LE_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LE_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LE_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LF_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LF_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LF_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LF_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LG_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LG_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LG_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LG_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LH_I0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LH_I1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LH_I2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_LH_I3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_S3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABa_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABa_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABa_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABa_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDa_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDa_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDa_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDa_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFa_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFa_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFa_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFa_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHa_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHa_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHa_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHa_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABb_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABb_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABb_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_ABb_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDb_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDb_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDb_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_CDb_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFb_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFb_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFb_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_EFb_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHb_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHb_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHb_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2MID_GHb_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_AB_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_AB_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_AB_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_AB_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_CD_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_CD_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_CD_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_CD_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_EF_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_EF_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_EF_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_EF_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_GH_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_GH_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_GH_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J2END_GH_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_JN2BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG2	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG3	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG4	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG5	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG6	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JN2BEG7	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG2	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG3	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG4	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG5	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG6	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JE2BEG7	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG2	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG3	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG4	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG5	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG6	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JS2BEG7	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG0	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG1	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG2	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG3	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG4	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG5	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG6	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_JW2BEG7	: STD_LOGIC_VECTOR (4 -1 downto 0);
signal DEBUG_select_J_l_AB_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_AB_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_AB_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_AB_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_CD_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_CD_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_CD_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_CD_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_EF_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_EF_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_EF_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_EF_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_GH_BEG0	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_GH_BEG1	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_GH_BEG2	: STD_LOGIC_VECTOR (2 -1 downto 0);
signal DEBUG_select_J_l_GH_BEG3	: STD_LOGIC_VECTOR (2 -1 downto 0);

-- The configuration bits (if any) are just a long shift register

-- This shift register is padded to an even number of flops/latches

begin

-- switch matrix multiplexer  N1BEG0 		MUX-4
N1BEG0_input 	 <= J_l_CD_END1 & JW2END3 & J2MID_CDb_END3 & LC_O after 80 ps;
inst_MUX4PTv4_N1BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> N1BEG0_input(0),
		IN2 	=> N1BEG0_input(1),
		IN3 	=> N1BEG0_input(2),
		IN4 	=> N1BEG0_input(3),
		S1 	=> ConfigBits(0 + 0),
		S2 	=> ConfigBits(0 + 1),
		O  	=> N1BEG0 );

-- switch matrix multiplexer  N1BEG1 		MUX-4
N1BEG1_input 	 <= J_l_EF_END2 & JW2END0 & J2MID_EFb_END0 & LD_O after 80 ps;
inst_MUX4PTv4_N1BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> N1BEG1_input(0),
		IN2 	=> N1BEG1_input(1),
		IN3 	=> N1BEG1_input(2),
		IN4 	=> N1BEG1_input(3),
		S1 	=> ConfigBits(2 + 0),
		S2 	=> ConfigBits(2 + 1),
		O  	=> N1BEG1 );

-- switch matrix multiplexer  N1BEG2 		MUX-4
N1BEG2_input 	 <= J_l_GH_END3 & JW2END1 & J2MID_GHb_END1 & LE_O after 80 ps;
inst_MUX4PTv4_N1BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> N1BEG2_input(0),
		IN2 	=> N1BEG2_input(1),
		IN3 	=> N1BEG2_input(2),
		IN4 	=> N1BEG2_input(3),
		S1 	=> ConfigBits(4 + 0),
		S2 	=> ConfigBits(4 + 1),
		O  	=> N1BEG2 );

-- switch matrix multiplexer  N1BEG3 		MUX-4
N1BEG3_input 	 <= J_l_AB_END0 & JW2END2 & J2MID_ABb_END2 & LF_O after 80 ps;
inst_MUX4PTv4_N1BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> N1BEG3_input(0),
		IN2 	=> N1BEG3_input(1),
		IN3 	=> N1BEG3_input(2),
		IN4 	=> N1BEG3_input(3),
		S1 	=> ConfigBits(6 + 0),
		S2 	=> ConfigBits(6 + 1),
		O  	=> N1BEG3 );

-- switch matrix multiplexer  N2BEG0 		MUX-1
N2BEG0 	 <= 	 JN2END0 ;
-- switch matrix multiplexer  N2BEG1 		MUX-1
N2BEG1 	 <= 	 JN2END1 ;
-- switch matrix multiplexer  N2BEG2 		MUX-1
N2BEG2 	 <= 	 JN2END2 ;
-- switch matrix multiplexer  N2BEG3 		MUX-1
N2BEG3 	 <= 	 JN2END3 ;
-- switch matrix multiplexer  N2BEG4 		MUX-1
N2BEG4 	 <= 	 JN2END4 ;
-- switch matrix multiplexer  N2BEG5 		MUX-1
N2BEG5 	 <= 	 JN2END5 ;
-- switch matrix multiplexer  N2BEG6 		MUX-1
N2BEG6 	 <= 	 JN2END6 ;
-- switch matrix multiplexer  N2BEG7 		MUX-1
N2BEG7 	 <= 	 JN2END7 ;
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
N4BEG0_input 	 <= LE_O & E6END1 & N4END1 & N2END2 after 80 ps;
inst_MUX4PTv4_N4BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> N4BEG0_input(0),
		IN2 	=> N4BEG0_input(1),
		IN3 	=> N4BEG0_input(2),
		IN4 	=> N4BEG0_input(3),
		S1 	=> ConfigBits(8 + 0),
		S2 	=> ConfigBits(8 + 1),
		O  	=> N4BEG0 );

-- switch matrix multiplexer  N4BEG1 		MUX-4
N4BEG1_input 	 <= LF_O & E6END0 & N4END2 & N2END3 after 80 ps;
inst_MUX4PTv4_N4BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> N4BEG1_input(0),
		IN2 	=> N4BEG1_input(1),
		IN3 	=> N4BEG1_input(2),
		IN4 	=> N4BEG1_input(3),
		S1 	=> ConfigBits(10 + 0),
		S2 	=> ConfigBits(10 + 1),
		O  	=> N4BEG1 );

-- switch matrix multiplexer  N4BEG2 		MUX-4
N4BEG2_input 	 <= LG_O & W6END1 & N4END3 & N2END0 after 80 ps;
inst_MUX4PTv4_N4BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> N4BEG2_input(0),
		IN2 	=> N4BEG2_input(1),
		IN3 	=> N4BEG2_input(2),
		IN4 	=> N4BEG2_input(3),
		S1 	=> ConfigBits(12 + 0),
		S2 	=> ConfigBits(12 + 1),
		O  	=> N4BEG2 );

-- switch matrix multiplexer  N4BEG3 		MUX-4
N4BEG3_input 	 <= LH_O & W6END0 & N4END0 & N2END1 after 80 ps;
inst_MUX4PTv4_N4BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> N4BEG3_input(0),
		IN2 	=> N4BEG3_input(1),
		IN3 	=> N4BEG3_input(2),
		IN4 	=> N4BEG3_input(3),
		S1 	=> ConfigBits(14 + 0),
		S2 	=> ConfigBits(14 + 1),
		O  	=> N4BEG3 );

-- switch matrix multiplexer  Co0 		MUX-1
Co0 	 <= 	 LH_Co ;
-- switch matrix multiplexer  E1BEG0 		MUX-4
E1BEG0_input 	 <= J_l_CD_END1 & JN2END3 & J2MID_CDb_END3 & LD_O after 80 ps;
inst_MUX4PTv4_E1BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> E1BEG0_input(0),
		IN2 	=> E1BEG0_input(1),
		IN3 	=> E1BEG0_input(2),
		IN4 	=> E1BEG0_input(3),
		S1 	=> ConfigBits(16 + 0),
		S2 	=> ConfigBits(16 + 1),
		O  	=> E1BEG0 );

-- switch matrix multiplexer  E1BEG1 		MUX-4
E1BEG1_input 	 <= J_l_EF_END2 & JN2END0 & J2MID_EFb_END0 & LE_O after 80 ps;
inst_MUX4PTv4_E1BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> E1BEG1_input(0),
		IN2 	=> E1BEG1_input(1),
		IN3 	=> E1BEG1_input(2),
		IN4 	=> E1BEG1_input(3),
		S1 	=> ConfigBits(18 + 0),
		S2 	=> ConfigBits(18 + 1),
		O  	=> E1BEG1 );

-- switch matrix multiplexer  E1BEG2 		MUX-4
E1BEG2_input 	 <= J_l_GH_END3 & JN2END1 & J2MID_GHb_END1 & LF_O after 80 ps;
inst_MUX4PTv4_E1BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> E1BEG2_input(0),
		IN2 	=> E1BEG2_input(1),
		IN3 	=> E1BEG2_input(2),
		IN4 	=> E1BEG2_input(3),
		S1 	=> ConfigBits(20 + 0),
		S2 	=> ConfigBits(20 + 1),
		O  	=> E1BEG2 );

-- switch matrix multiplexer  E1BEG3 		MUX-4
E1BEG3_input 	 <= J_l_AB_END0 & JN2END2 & J2MID_ABb_END2 & LG_O after 80 ps;
inst_MUX4PTv4_E1BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> E1BEG3_input(0),
		IN2 	=> E1BEG3_input(1),
		IN3 	=> E1BEG3_input(2),
		IN4 	=> E1BEG3_input(3),
		S1 	=> ConfigBits(22 + 0),
		S2 	=> ConfigBits(22 + 1),
		O  	=> E1BEG3 );

-- switch matrix multiplexer  E2BEG0 		MUX-1
E2BEG0 	 <= 	 JE2END0 ;
-- switch matrix multiplexer  E2BEG1 		MUX-1
E2BEG1 	 <= 	 JE2END1 ;
-- switch matrix multiplexer  E2BEG2 		MUX-1
E2BEG2 	 <= 	 JE2END2 ;
-- switch matrix multiplexer  E2BEG3 		MUX-1
E2BEG3 	 <= 	 JE2END3 ;
-- switch matrix multiplexer  E2BEG4 		MUX-1
E2BEG4 	 <= 	 JE2END4 ;
-- switch matrix multiplexer  E2BEG5 		MUX-1
E2BEG5 	 <= 	 JE2END5 ;
-- switch matrix multiplexer  E2BEG6 		MUX-1
E2BEG6 	 <= 	 JE2END6 ;
-- switch matrix multiplexer  E2BEG7 		MUX-1
E2BEG7 	 <= 	 JE2END7 ;
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
-- switch matrix multiplexer  E6BEG0 		MUX-16
E6BEG0_input 	 <= J2MID_GHb_END1 & J2MID_EFb_END1 & J2MID_CDb_END1 & J2MID_ABb_END1 & M_AH & M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & E1END3 after 80 ps;
inst_MUX16PTv2_E6BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> E6BEG0_input(0),
		IN2 	=> E6BEG0_input(1),
		IN3 	=> E6BEG0_input(2),
		IN4 	=> E6BEG0_input(3),
		IN5 	=> E6BEG0_input(4),
		IN6 	=> E6BEG0_input(5),
		IN7 	=> E6BEG0_input(6),
		IN8 	=> E6BEG0_input(7),
		IN9 	=> E6BEG0_input(8),
		IN10 	=> E6BEG0_input(9),
		IN11 	=> E6BEG0_input(10),
		IN12 	=> E6BEG0_input(11),
		IN13 	=> E6BEG0_input(12),
		IN14 	=> E6BEG0_input(13),
		IN15 	=> E6BEG0_input(14),
		IN16 	=> E6BEG0_input(15),
		S1 	=> ConfigBits(24 + 0),
		S2 	=> ConfigBits(24 + 1),
		S3 	=> ConfigBits(24 + 2),
		S4 	=> ConfigBits(24 + 3),
		O  	=> E6BEG0 );

-- switch matrix multiplexer  E6BEG1 		MUX-16
E6BEG1_input 	 <= J2MID_GHa_END2 & J2MID_EFa_END2 & J2MID_CDa_END2 & J2MID_ABa_END2 & M_EF & M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & E1END2 after 80 ps;
inst_MUX16PTv2_E6BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> E6BEG1_input(0),
		IN2 	=> E6BEG1_input(1),
		IN3 	=> E6BEG1_input(2),
		IN4 	=> E6BEG1_input(3),
		IN5 	=> E6BEG1_input(4),
		IN6 	=> E6BEG1_input(5),
		IN7 	=> E6BEG1_input(6),
		IN8 	=> E6BEG1_input(7),
		IN9 	=> E6BEG1_input(8),
		IN10 	=> E6BEG1_input(9),
		IN11 	=> E6BEG1_input(10),
		IN12 	=> E6BEG1_input(11),
		IN13 	=> E6BEG1_input(12),
		IN14 	=> E6BEG1_input(13),
		IN15 	=> E6BEG1_input(14),
		IN16 	=> E6BEG1_input(15),
		S1 	=> ConfigBits(28 + 0),
		S2 	=> ConfigBits(28 + 1),
		S3 	=> ConfigBits(28 + 2),
		S4 	=> ConfigBits(28 + 3),
		O  	=> E6BEG1 );

-- switch matrix multiplexer  S1BEG0 		MUX-4
S1BEG0_input 	 <= J_l_CD_END1 & JE2END3 & J2MID_CDb_END3 & LE_O after 80 ps;
inst_MUX4PTv4_S1BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> S1BEG0_input(0),
		IN2 	=> S1BEG0_input(1),
		IN3 	=> S1BEG0_input(2),
		IN4 	=> S1BEG0_input(3),
		S1 	=> ConfigBits(32 + 0),
		S2 	=> ConfigBits(32 + 1),
		O  	=> S1BEG0 );

-- switch matrix multiplexer  S1BEG1 		MUX-4
S1BEG1_input 	 <= J_l_EF_END2 & JE2END0 & J2MID_EFb_END0 & LF_O after 80 ps;
inst_MUX4PTv4_S1BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> S1BEG1_input(0),
		IN2 	=> S1BEG1_input(1),
		IN3 	=> S1BEG1_input(2),
		IN4 	=> S1BEG1_input(3),
		S1 	=> ConfigBits(34 + 0),
		S2 	=> ConfigBits(34 + 1),
		O  	=> S1BEG1 );

-- switch matrix multiplexer  S1BEG2 		MUX-4
S1BEG2_input 	 <= J_l_GH_END3 & JE2END1 & J2MID_GHb_END1 & LG_O after 80 ps;
inst_MUX4PTv4_S1BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> S1BEG2_input(0),
		IN2 	=> S1BEG2_input(1),
		IN3 	=> S1BEG2_input(2),
		IN4 	=> S1BEG2_input(3),
		S1 	=> ConfigBits(36 + 0),
		S2 	=> ConfigBits(36 + 1),
		O  	=> S1BEG2 );

-- switch matrix multiplexer  S1BEG3 		MUX-4
S1BEG3_input 	 <= J_l_AB_END0 & JE2END2 & J2MID_ABb_END2 & LH_O after 80 ps;
inst_MUX4PTv4_S1BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> S1BEG3_input(0),
		IN2 	=> S1BEG3_input(1),
		IN3 	=> S1BEG3_input(2),
		IN4 	=> S1BEG3_input(3),
		S1 	=> ConfigBits(38 + 0),
		S2 	=> ConfigBits(38 + 1),
		O  	=> S1BEG3 );

-- switch matrix multiplexer  S2BEG0 		MUX-1
S2BEG0 	 <= 	 JS2END0 ;
-- switch matrix multiplexer  S2BEG1 		MUX-1
S2BEG1 	 <= 	 JS2END1 ;
-- switch matrix multiplexer  S2BEG2 		MUX-1
S2BEG2 	 <= 	 JS2END2 ;
-- switch matrix multiplexer  S2BEG3 		MUX-1
S2BEG3 	 <= 	 JS2END3 ;
-- switch matrix multiplexer  S2BEG4 		MUX-1
S2BEG4 	 <= 	 JS2END4 ;
-- switch matrix multiplexer  S2BEG5 		MUX-1
S2BEG5 	 <= 	 JS2END5 ;
-- switch matrix multiplexer  S2BEG6 		MUX-1
S2BEG6 	 <= 	 JS2END6 ;
-- switch matrix multiplexer  S2BEG7 		MUX-1
S2BEG7 	 <= 	 JS2END7 ;
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
S4BEG0_input 	 <= LA_O & S4END1 & S2END2 & E6END1 after 80 ps;
inst_MUX4PTv4_S4BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> S4BEG0_input(0),
		IN2 	=> S4BEG0_input(1),
		IN3 	=> S4BEG0_input(2),
		IN4 	=> S4BEG0_input(3),
		S1 	=> ConfigBits(40 + 0),
		S2 	=> ConfigBits(40 + 1),
		O  	=> S4BEG0 );

-- switch matrix multiplexer  S4BEG1 		MUX-4
S4BEG1_input 	 <= LB_O & S4END2 & S2END3 & E6END0 after 80 ps;
inst_MUX4PTv4_S4BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> S4BEG1_input(0),
		IN2 	=> S4BEG1_input(1),
		IN3 	=> S4BEG1_input(2),
		IN4 	=> S4BEG1_input(3),
		S1 	=> ConfigBits(42 + 0),
		S2 	=> ConfigBits(42 + 1),
		O  	=> S4BEG1 );

-- switch matrix multiplexer  S4BEG2 		MUX-4
S4BEG2_input 	 <= LC_O & W6END1 & S4END3 & S2END0 after 80 ps;
inst_MUX4PTv4_S4BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> S4BEG2_input(0),
		IN2 	=> S4BEG2_input(1),
		IN3 	=> S4BEG2_input(2),
		IN4 	=> S4BEG2_input(3),
		S1 	=> ConfigBits(44 + 0),
		S2 	=> ConfigBits(44 + 1),
		O  	=> S4BEG2 );

-- switch matrix multiplexer  S4BEG3 		MUX-4
S4BEG3_input 	 <= LD_O & W6END0 & S4END0 & S2END1 after 80 ps;
inst_MUX4PTv4_S4BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> S4BEG3_input(0),
		IN2 	=> S4BEG3_input(1),
		IN3 	=> S4BEG3_input(2),
		IN4 	=> S4BEG3_input(3),
		S1 	=> ConfigBits(46 + 0),
		S2 	=> ConfigBits(46 + 1),
		O  	=> S4BEG3 );

-- switch matrix multiplexer  W1BEG0 		MUX-4
W1BEG0_input 	 <= J_l_CD_END1 & JS2END3 & J2MID_CDb_END3 & LF_O after 80 ps;
inst_MUX4PTv4_W1BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> W1BEG0_input(0),
		IN2 	=> W1BEG0_input(1),
		IN3 	=> W1BEG0_input(2),
		IN4 	=> W1BEG0_input(3),
		S1 	=> ConfigBits(48 + 0),
		S2 	=> ConfigBits(48 + 1),
		O  	=> W1BEG0 );

-- switch matrix multiplexer  W1BEG1 		MUX-4
W1BEG1_input 	 <= J_l_EF_END2 & JS2END0 & J2MID_EFb_END0 & LG_O after 80 ps;
inst_MUX4PTv4_W1BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> W1BEG1_input(0),
		IN2 	=> W1BEG1_input(1),
		IN3 	=> W1BEG1_input(2),
		IN4 	=> W1BEG1_input(3),
		S1 	=> ConfigBits(50 + 0),
		S2 	=> ConfigBits(50 + 1),
		O  	=> W1BEG1 );

-- switch matrix multiplexer  W1BEG2 		MUX-4
W1BEG2_input 	 <= J_l_GH_END3 & JS2END1 & J2MID_GHb_END1 & LH_O after 80 ps;
inst_MUX4PTv4_W1BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> W1BEG2_input(0),
		IN2 	=> W1BEG2_input(1),
		IN3 	=> W1BEG2_input(2),
		IN4 	=> W1BEG2_input(3),
		S1 	=> ConfigBits(52 + 0),
		S2 	=> ConfigBits(52 + 1),
		O  	=> W1BEG2 );

-- switch matrix multiplexer  W1BEG3 		MUX-4
W1BEG3_input 	 <= J_l_AB_END0 & JS2END2 & J2MID_ABb_END2 & LA_O after 80 ps;
inst_MUX4PTv4_W1BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> W1BEG3_input(0),
		IN2 	=> W1BEG3_input(1),
		IN3 	=> W1BEG3_input(2),
		IN4 	=> W1BEG3_input(3),
		S1 	=> ConfigBits(54 + 0),
		S2 	=> ConfigBits(54 + 1),
		O  	=> W1BEG3 );

-- switch matrix multiplexer  W2BEG0 		MUX-1
W2BEG0 	 <= 	 W2END0 ;
-- switch matrix multiplexer  W2BEG1 		MUX-1
W2BEG1 	 <= 	 JW2END1 ;
-- switch matrix multiplexer  W2BEG2 		MUX-1
W2BEG2 	 <= 	 JW2END2 ;
-- switch matrix multiplexer  W2BEG3 		MUX-1
W2BEG3 	 <= 	 W2END3 ;
-- switch matrix multiplexer  W2BEG4 		MUX-1
W2BEG4 	 <= 	 W2END4 ;
-- switch matrix multiplexer  W2BEG5 		MUX-1
W2BEG5 	 <= 	 JW2END5 ;
-- switch matrix multiplexer  W2BEG6 		MUX-1
W2BEG6 	 <= 	 JW2END6 ;
-- switch matrix multiplexer  W2BEG7 		MUX-1
W2BEG7 	 <= 	 W2END7 ;
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
-- switch matrix multiplexer  W6BEG0 		MUX-16
W6BEG0_input 	 <= J2MID_GHb_END1 & J2MID_EFb_END1 & J2MID_CDb_END1 & J2MID_ABb_END1 & M_AH & M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & E1END3 after 80 ps;
inst_MUX16PTv2_W6BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> W6BEG0_input(0),
		IN2 	=> W6BEG0_input(1),
		IN3 	=> W6BEG0_input(2),
		IN4 	=> W6BEG0_input(3),
		IN5 	=> W6BEG0_input(4),
		IN6 	=> W6BEG0_input(5),
		IN7 	=> W6BEG0_input(6),
		IN8 	=> W6BEG0_input(7),
		IN9 	=> W6BEG0_input(8),
		IN10 	=> W6BEG0_input(9),
		IN11 	=> W6BEG0_input(10),
		IN12 	=> W6BEG0_input(11),
		IN13 	=> W6BEG0_input(12),
		IN14 	=> W6BEG0_input(13),
		IN15 	=> W6BEG0_input(14),
		IN16 	=> W6BEG0_input(15),
		S1 	=> ConfigBits(56 + 0),
		S2 	=> ConfigBits(56 + 1),
		S3 	=> ConfigBits(56 + 2),
		S4 	=> ConfigBits(56 + 3),
		O  	=> W6BEG0 );

-- switch matrix multiplexer  W6BEG1 		MUX-16
W6BEG1_input 	 <= J2MID_GHa_END2 & J2MID_EFa_END2 & J2MID_CDa_END2 & J2MID_ABa_END2 & M_EF & M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & E1END2 after 80 ps;
inst_MUX16PTv2_W6BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> W6BEG1_input(0),
		IN2 	=> W6BEG1_input(1),
		IN3 	=> W6BEG1_input(2),
		IN4 	=> W6BEG1_input(3),
		IN5 	=> W6BEG1_input(4),
		IN6 	=> W6BEG1_input(5),
		IN7 	=> W6BEG1_input(6),
		IN8 	=> W6BEG1_input(7),
		IN9 	=> W6BEG1_input(8),
		IN10 	=> W6BEG1_input(9),
		IN11 	=> W6BEG1_input(10),
		IN12 	=> W6BEG1_input(11),
		IN13 	=> W6BEG1_input(12),
		IN14 	=> W6BEG1_input(13),
		IN15 	=> W6BEG1_input(14),
		IN16 	=> W6BEG1_input(15),
		S1 	=> ConfigBits(60 + 0),
		S2 	=> ConfigBits(60 + 1),
		S3 	=> ConfigBits(60 + 2),
		S4 	=> ConfigBits(60 + 3),
		O  	=> W6BEG1 );

-- switch matrix multiplexer  LA_I0 		MUX-4
LA_I0_input 	 <= J_l_AB_END0 & J2END_AB_END0 & J2MID_ABb_END0 & J2MID_ABa_END0 after 80 ps;
inst_MUX4PTv4_LA_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LA_I0_input(0),
		IN2 	=> LA_I0_input(1),
		IN3 	=> LA_I0_input(2),
		IN4 	=> LA_I0_input(3),
		S1 	=> ConfigBits(64 + 0),
		S2 	=> ConfigBits(64 + 1),
		O  	=> LA_I0 );

-- switch matrix multiplexer  LA_I1 		MUX-4
LA_I1_input 	 <= J_l_AB_END1 & J2END_AB_END1 & J2MID_ABb_END1 & J2MID_ABa_END1 after 80 ps;
inst_MUX4PTv4_LA_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LA_I1_input(0),
		IN2 	=> LA_I1_input(1),
		IN3 	=> LA_I1_input(2),
		IN4 	=> LA_I1_input(3),
		S1 	=> ConfigBits(66 + 0),
		S2 	=> ConfigBits(66 + 1),
		O  	=> LA_I1 );

-- switch matrix multiplexer  LA_I2 		MUX-4
LA_I2_input 	 <= J_l_AB_END2 & J2END_AB_END2 & J2MID_ABb_END2 & J2MID_ABa_END2 after 80 ps;
inst_MUX4PTv4_LA_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LA_I2_input(0),
		IN2 	=> LA_I2_input(1),
		IN3 	=> LA_I2_input(2),
		IN4 	=> LA_I2_input(3),
		S1 	=> ConfigBits(68 + 0),
		S2 	=> ConfigBits(68 + 1),
		O  	=> LA_I2 );

-- switch matrix multiplexer  LA_I3 		MUX-4
LA_I3_input 	 <= J_l_AB_END3 & J2END_AB_END3 & J2MID_ABb_END3 & J2MID_ABa_END3 after 80 ps;
inst_MUX4PTv4_LA_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LA_I3_input(0),
		IN2 	=> LA_I3_input(1),
		IN3 	=> LA_I3_input(2),
		IN4 	=> LA_I3_input(3),
		S1 	=> ConfigBits(70 + 0),
		S2 	=> ConfigBits(70 + 1),
		O  	=> LA_I3 );

-- switch matrix multiplexer  LA_Ci 		MUX-1
LA_Ci 	 <= 	 Ci0 ;
-- switch matrix multiplexer  LB_I0 		MUX-4
LB_I0_input 	 <= J_l_AB_END0 & J2END_AB_END0 & J2MID_ABb_END0 & J2MID_ABa_END0 after 80 ps;
inst_MUX4PTv4_LB_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LB_I0_input(0),
		IN2 	=> LB_I0_input(1),
		IN3 	=> LB_I0_input(2),
		IN4 	=> LB_I0_input(3),
		S1 	=> ConfigBits(72 + 0),
		S2 	=> ConfigBits(72 + 1),
		O  	=> LB_I0 );

-- switch matrix multiplexer  LB_I1 		MUX-4
LB_I1_input 	 <= J_l_AB_END1 & J2END_AB_END1 & J2MID_ABb_END1 & J2MID_ABa_END1 after 80 ps;
inst_MUX4PTv4_LB_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LB_I1_input(0),
		IN2 	=> LB_I1_input(1),
		IN3 	=> LB_I1_input(2),
		IN4 	=> LB_I1_input(3),
		S1 	=> ConfigBits(74 + 0),
		S2 	=> ConfigBits(74 + 1),
		O  	=> LB_I1 );

-- switch matrix multiplexer  LB_I2 		MUX-4
LB_I2_input 	 <= J_l_AB_END2 & J2END_AB_END2 & J2MID_ABb_END2 & J2MID_ABa_END2 after 80 ps;
inst_MUX4PTv4_LB_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LB_I2_input(0),
		IN2 	=> LB_I2_input(1),
		IN3 	=> LB_I2_input(2),
		IN4 	=> LB_I2_input(3),
		S1 	=> ConfigBits(76 + 0),
		S2 	=> ConfigBits(76 + 1),
		O  	=> LB_I2 );

-- switch matrix multiplexer  LB_I3 		MUX-4
LB_I3_input 	 <= J_l_AB_END3 & J2END_AB_END3 & J2MID_ABb_END3 & J2MID_ABa_END3 after 80 ps;
inst_MUX4PTv4_LB_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LB_I3_input(0),
		IN2 	=> LB_I3_input(1),
		IN3 	=> LB_I3_input(2),
		IN4 	=> LB_I3_input(3),
		S1 	=> ConfigBits(78 + 0),
		S2 	=> ConfigBits(78 + 1),
		O  	=> LB_I3 );

-- switch matrix multiplexer  LB_Ci 		MUX-1
LB_Ci 	 <= 	 LA_Co ;
-- switch matrix multiplexer  LC_I0 		MUX-4
LC_I0_input 	 <= J_l_CD_END0 & J2END_CD_END0 & J2MID_CDb_END0 & J2MID_CDa_END0 after 80 ps;
inst_MUX4PTv4_LC_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LC_I0_input(0),
		IN2 	=> LC_I0_input(1),
		IN3 	=> LC_I0_input(2),
		IN4 	=> LC_I0_input(3),
		S1 	=> ConfigBits(80 + 0),
		S2 	=> ConfigBits(80 + 1),
		O  	=> LC_I0 );

-- switch matrix multiplexer  LC_I1 		MUX-4
LC_I1_input 	 <= J_l_CD_END1 & J2END_CD_END1 & J2MID_CDb_END1 & J2MID_CDa_END1 after 80 ps;
inst_MUX4PTv4_LC_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LC_I1_input(0),
		IN2 	=> LC_I1_input(1),
		IN3 	=> LC_I1_input(2),
		IN4 	=> LC_I1_input(3),
		S1 	=> ConfigBits(82 + 0),
		S2 	=> ConfigBits(82 + 1),
		O  	=> LC_I1 );

-- switch matrix multiplexer  LC_I2 		MUX-4
LC_I2_input 	 <= J_l_CD_END2 & J2END_CD_END2 & J2MID_CDb_END2 & J2MID_CDa_END2 after 80 ps;
inst_MUX4PTv4_LC_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LC_I2_input(0),
		IN2 	=> LC_I2_input(1),
		IN3 	=> LC_I2_input(2),
		IN4 	=> LC_I2_input(3),
		S1 	=> ConfigBits(84 + 0),
		S2 	=> ConfigBits(84 + 1),
		O  	=> LC_I2 );

-- switch matrix multiplexer  LC_I3 		MUX-4
LC_I3_input 	 <= J_l_CD_END3 & J2END_CD_END3 & J2MID_CDb_END3 & J2MID_CDa_END3 after 80 ps;
inst_MUX4PTv4_LC_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LC_I3_input(0),
		IN2 	=> LC_I3_input(1),
		IN3 	=> LC_I3_input(2),
		IN4 	=> LC_I3_input(3),
		S1 	=> ConfigBits(86 + 0),
		S2 	=> ConfigBits(86 + 1),
		O  	=> LC_I3 );

-- switch matrix multiplexer  LC_Ci 		MUX-1
LC_Ci 	 <= 	 LB_Co ;
-- switch matrix multiplexer  LD_I0 		MUX-4
LD_I0_input 	 <= J_l_CD_END0 & J2END_CD_END0 & J2MID_CDb_END0 & J2MID_CDa_END0 after 80 ps;
inst_MUX4PTv4_LD_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LD_I0_input(0),
		IN2 	=> LD_I0_input(1),
		IN3 	=> LD_I0_input(2),
		IN4 	=> LD_I0_input(3),
		S1 	=> ConfigBits(88 + 0),
		S2 	=> ConfigBits(88 + 1),
		O  	=> LD_I0 );

-- switch matrix multiplexer  LD_I1 		MUX-4
LD_I1_input 	 <= J_l_CD_END1 & J2END_CD_END1 & J2MID_CDb_END1 & J2MID_CDa_END1 after 80 ps;
inst_MUX4PTv4_LD_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LD_I1_input(0),
		IN2 	=> LD_I1_input(1),
		IN3 	=> LD_I1_input(2),
		IN4 	=> LD_I1_input(3),
		S1 	=> ConfigBits(90 + 0),
		S2 	=> ConfigBits(90 + 1),
		O  	=> LD_I1 );

-- switch matrix multiplexer  LD_I2 		MUX-4
LD_I2_input 	 <= J_l_CD_END2 & J2END_CD_END2 & J2MID_CDb_END2 & J2MID_CDa_END2 after 80 ps;
inst_MUX4PTv4_LD_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LD_I2_input(0),
		IN2 	=> LD_I2_input(1),
		IN3 	=> LD_I2_input(2),
		IN4 	=> LD_I2_input(3),
		S1 	=> ConfigBits(92 + 0),
		S2 	=> ConfigBits(92 + 1),
		O  	=> LD_I2 );

-- switch matrix multiplexer  LD_I3 		MUX-4
LD_I3_input 	 <= J_l_CD_END3 & J2END_CD_END3 & J2MID_CDb_END3 & J2MID_CDa_END3 after 80 ps;
inst_MUX4PTv4_LD_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LD_I3_input(0),
		IN2 	=> LD_I3_input(1),
		IN3 	=> LD_I3_input(2),
		IN4 	=> LD_I3_input(3),
		S1 	=> ConfigBits(94 + 0),
		S2 	=> ConfigBits(94 + 1),
		O  	=> LD_I3 );

-- switch matrix multiplexer  LD_Ci 		MUX-1
LD_Ci 	 <= 	 LC_Co ;
-- switch matrix multiplexer  LE_I0 		MUX-4
LE_I0_input 	 <= J_l_EF_END0 & J2END_EF_END0 & J2MID_EFb_END0 & J2MID_EFa_END0 after 80 ps;
inst_MUX4PTv4_LE_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LE_I0_input(0),
		IN2 	=> LE_I0_input(1),
		IN3 	=> LE_I0_input(2),
		IN4 	=> LE_I0_input(3),
		S1 	=> ConfigBits(96 + 0),
		S2 	=> ConfigBits(96 + 1),
		O  	=> LE_I0 );

-- switch matrix multiplexer  LE_I1 		MUX-4
LE_I1_input 	 <= J_l_EF_END1 & J2END_EF_END1 & J2MID_EFb_END1 & J2MID_EFa_END1 after 80 ps;
inst_MUX4PTv4_LE_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LE_I1_input(0),
		IN2 	=> LE_I1_input(1),
		IN3 	=> LE_I1_input(2),
		IN4 	=> LE_I1_input(3),
		S1 	=> ConfigBits(98 + 0),
		S2 	=> ConfigBits(98 + 1),
		O  	=> LE_I1 );

-- switch matrix multiplexer  LE_I2 		MUX-4
LE_I2_input 	 <= J_l_EF_END2 & J2END_EF_END2 & J2MID_EFb_END2 & J2MID_EFa_END2 after 80 ps;
inst_MUX4PTv4_LE_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LE_I2_input(0),
		IN2 	=> LE_I2_input(1),
		IN3 	=> LE_I2_input(2),
		IN4 	=> LE_I2_input(3),
		S1 	=> ConfigBits(100 + 0),
		S2 	=> ConfigBits(100 + 1),
		O  	=> LE_I2 );

-- switch matrix multiplexer  LE_I3 		MUX-4
LE_I3_input 	 <= J_l_EF_END3 & J2END_EF_END3 & J2MID_EFb_END3 & J2MID_EFa_END3 after 80 ps;
inst_MUX4PTv4_LE_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LE_I3_input(0),
		IN2 	=> LE_I3_input(1),
		IN3 	=> LE_I3_input(2),
		IN4 	=> LE_I3_input(3),
		S1 	=> ConfigBits(102 + 0),
		S2 	=> ConfigBits(102 + 1),
		O  	=> LE_I3 );

-- switch matrix multiplexer  LE_Ci 		MUX-1
LE_Ci 	 <= 	 LD_Co ;
-- switch matrix multiplexer  LF_I0 		MUX-4
LF_I0_input 	 <= J_l_EF_END0 & J2END_EF_END0 & J2MID_EFb_END0 & J2MID_EFa_END0 after 80 ps;
inst_MUX4PTv4_LF_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LF_I0_input(0),
		IN2 	=> LF_I0_input(1),
		IN3 	=> LF_I0_input(2),
		IN4 	=> LF_I0_input(3),
		S1 	=> ConfigBits(104 + 0),
		S2 	=> ConfigBits(104 + 1),
		O  	=> LF_I0 );

-- switch matrix multiplexer  LF_I1 		MUX-4
LF_I1_input 	 <= J_l_EF_END1 & J2END_EF_END1 & J2MID_EFb_END1 & J2MID_EFa_END1 after 80 ps;
inst_MUX4PTv4_LF_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LF_I1_input(0),
		IN2 	=> LF_I1_input(1),
		IN3 	=> LF_I1_input(2),
		IN4 	=> LF_I1_input(3),
		S1 	=> ConfigBits(106 + 0),
		S2 	=> ConfigBits(106 + 1),
		O  	=> LF_I1 );

-- switch matrix multiplexer  LF_I2 		MUX-4
LF_I2_input 	 <= J_l_EF_END2 & J2END_EF_END2 & J2MID_EFb_END2 & J2MID_EFa_END2 after 80 ps;
inst_MUX4PTv4_LF_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LF_I2_input(0),
		IN2 	=> LF_I2_input(1),
		IN3 	=> LF_I2_input(2),
		IN4 	=> LF_I2_input(3),
		S1 	=> ConfigBits(108 + 0),
		S2 	=> ConfigBits(108 + 1),
		O  	=> LF_I2 );

-- switch matrix multiplexer  LF_I3 		MUX-4
LF_I3_input 	 <= J_l_EF_END3 & J2END_EF_END3 & J2MID_EFb_END3 & J2MID_EFa_END3 after 80 ps;
inst_MUX4PTv4_LF_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LF_I3_input(0),
		IN2 	=> LF_I3_input(1),
		IN3 	=> LF_I3_input(2),
		IN4 	=> LF_I3_input(3),
		S1 	=> ConfigBits(110 + 0),
		S2 	=> ConfigBits(110 + 1),
		O  	=> LF_I3 );

-- switch matrix multiplexer  LF_Ci 		MUX-1
LF_Ci 	 <= 	 LE_Co ;
-- switch matrix multiplexer  LG_I0 		MUX-4
LG_I0_input 	 <= J_l_GH_END0 & J2END_GH_END0 & J2MID_GHb_END0 & J2MID_GHa_END0 after 80 ps;
inst_MUX4PTv4_LG_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LG_I0_input(0),
		IN2 	=> LG_I0_input(1),
		IN3 	=> LG_I0_input(2),
		IN4 	=> LG_I0_input(3),
		S1 	=> ConfigBits(112 + 0),
		S2 	=> ConfigBits(112 + 1),
		O  	=> LG_I0 );

-- switch matrix multiplexer  LG_I1 		MUX-4
LG_I1_input 	 <= J_l_GH_END1 & J2END_GH_END1 & J2MID_GHb_END1 & J2MID_GHa_END1 after 80 ps;
inst_MUX4PTv4_LG_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LG_I1_input(0),
		IN2 	=> LG_I1_input(1),
		IN3 	=> LG_I1_input(2),
		IN4 	=> LG_I1_input(3),
		S1 	=> ConfigBits(114 + 0),
		S2 	=> ConfigBits(114 + 1),
		O  	=> LG_I1 );

-- switch matrix multiplexer  LG_I2 		MUX-4
LG_I2_input 	 <= J_l_GH_END2 & J2END_GH_END2 & J2MID_GHb_END2 & J2MID_GHa_END2 after 80 ps;
inst_MUX4PTv4_LG_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LG_I2_input(0),
		IN2 	=> LG_I2_input(1),
		IN3 	=> LG_I2_input(2),
		IN4 	=> LG_I2_input(3),
		S1 	=> ConfigBits(116 + 0),
		S2 	=> ConfigBits(116 + 1),
		O  	=> LG_I2 );

-- switch matrix multiplexer  LG_I3 		MUX-4
LG_I3_input 	 <= J_l_GH_END3 & J2END_GH_END3 & J2MID_GHb_END3 & J2MID_GHa_END3 after 80 ps;
inst_MUX4PTv4_LG_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LG_I3_input(0),
		IN2 	=> LG_I3_input(1),
		IN3 	=> LG_I3_input(2),
		IN4 	=> LG_I3_input(3),
		S1 	=> ConfigBits(118 + 0),
		S2 	=> ConfigBits(118 + 1),
		O  	=> LG_I3 );

-- switch matrix multiplexer  LG_Ci 		MUX-1
LG_Ci 	 <= 	 LF_Co ;
-- switch matrix multiplexer  LH_I0 		MUX-4
LH_I0_input 	 <= J_l_GH_END0 & J2END_GH_END0 & J2MID_GHb_END0 & J2MID_GHa_END0 after 80 ps;
inst_MUX4PTv4_LH_I0 : MUX4PTv4
	 Port Map(
		IN1 	=> LH_I0_input(0),
		IN2 	=> LH_I0_input(1),
		IN3 	=> LH_I0_input(2),
		IN4 	=> LH_I0_input(3),
		S1 	=> ConfigBits(120 + 0),
		S2 	=> ConfigBits(120 + 1),
		O  	=> LH_I0 );

-- switch matrix multiplexer  LH_I1 		MUX-4
LH_I1_input 	 <= J_l_GH_END1 & J2END_GH_END1 & J2MID_GHb_END1 & J2MID_GHa_END1 after 80 ps;
inst_MUX4PTv4_LH_I1 : MUX4PTv4
	 Port Map(
		IN1 	=> LH_I1_input(0),
		IN2 	=> LH_I1_input(1),
		IN3 	=> LH_I1_input(2),
		IN4 	=> LH_I1_input(3),
		S1 	=> ConfigBits(122 + 0),
		S2 	=> ConfigBits(122 + 1),
		O  	=> LH_I1 );

-- switch matrix multiplexer  LH_I2 		MUX-4
LH_I2_input 	 <= J_l_GH_END2 & J2END_GH_END2 & J2MID_GHb_END2 & J2MID_GHa_END2 after 80 ps;
inst_MUX4PTv4_LH_I2 : MUX4PTv4
	 Port Map(
		IN1 	=> LH_I2_input(0),
		IN2 	=> LH_I2_input(1),
		IN3 	=> LH_I2_input(2),
		IN4 	=> LH_I2_input(3),
		S1 	=> ConfigBits(124 + 0),
		S2 	=> ConfigBits(124 + 1),
		O  	=> LH_I2 );

-- switch matrix multiplexer  LH_I3 		MUX-4
LH_I3_input 	 <= J_l_GH_END3 & J2END_GH_END3 & J2MID_GHb_END3 & J2MID_GHa_END3 after 80 ps;
inst_MUX4PTv4_LH_I3 : MUX4PTv4
	 Port Map(
		IN1 	=> LH_I3_input(0),
		IN2 	=> LH_I3_input(1),
		IN3 	=> LH_I3_input(2),
		IN4 	=> LH_I3_input(3),
		S1 	=> ConfigBits(126 + 0),
		S2 	=> ConfigBits(126 + 1),
		O  	=> LH_I3 );

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
S0_input 	 <= JW2END4 & JS2END4 & JE2END4 & JN2END4 after 80 ps;
inst_MUX4PTv4_S0 : MUX4PTv4
	 Port Map(
		IN1 	=> S0_input(0),
		IN2 	=> S0_input(1),
		IN3 	=> S0_input(2),
		IN4 	=> S0_input(3),
		S1 	=> ConfigBits(128 + 0),
		S2 	=> ConfigBits(128 + 1),
		O  	=> S0 );

-- switch matrix multiplexer  S1 		MUX-4
S1_input 	 <= JW2END5 & JS2END5 & JE2END5 & JN2END5 after 80 ps;
inst_MUX4PTv4_S1 : MUX4PTv4
	 Port Map(
		IN1 	=> S1_input(0),
		IN2 	=> S1_input(1),
		IN3 	=> S1_input(2),
		IN4 	=> S1_input(3),
		S1 	=> ConfigBits(130 + 0),
		S2 	=> ConfigBits(130 + 1),
		O  	=> S1 );

-- switch matrix multiplexer  S2 		MUX-4
S2_input 	 <= JW2END6 & JS2END6 & JE2END6 & JN2END6 after 80 ps;
inst_MUX4PTv4_S2 : MUX4PTv4
	 Port Map(
		IN1 	=> S2_input(0),
		IN2 	=> S2_input(1),
		IN3 	=> S2_input(2),
		IN4 	=> S2_input(3),
		S1 	=> ConfigBits(132 + 0),
		S2 	=> ConfigBits(132 + 1),
		O  	=> S2 );

-- switch matrix multiplexer  S3 		MUX-4
S3_input 	 <= JW2END7 & JS2END7 & JE2END7 & JN2END7 after 80 ps;
inst_MUX4PTv4_S3 : MUX4PTv4
	 Port Map(
		IN1 	=> S3_input(0),
		IN2 	=> S3_input(1),
		IN3 	=> S3_input(2),
		IN4 	=> S3_input(3),
		S1 	=> ConfigBits(134 + 0),
		S2 	=> ConfigBits(134 + 1),
		O  	=> S3 );

-- switch matrix multiplexer  J2MID_ABa_BEG0 		MUX-4
J2MID_ABa_BEG0_input 	 <= JN2END3 & W2MID6 & S2MID6 & N2MID6 after 80 ps;
inst_MUX4PTv4_J2MID_ABa_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABa_BEG0_input(0),
		IN2 	=> J2MID_ABa_BEG0_input(1),
		IN3 	=> J2MID_ABa_BEG0_input(2),
		IN4 	=> J2MID_ABa_BEG0_input(3),
		S1 	=> ConfigBits(136 + 0),
		S2 	=> ConfigBits(136 + 1),
		O  	=> J2MID_ABa_BEG0 );

-- switch matrix multiplexer  J2MID_ABa_BEG1 		MUX-4
J2MID_ABa_BEG1_input 	 <= JE2END3 & W2MID2 & S2MID2 & E2MID2 after 80 ps;
inst_MUX4PTv4_J2MID_ABa_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABa_BEG1_input(0),
		IN2 	=> J2MID_ABa_BEG1_input(1),
		IN3 	=> J2MID_ABa_BEG1_input(2),
		IN4 	=> J2MID_ABa_BEG1_input(3),
		S1 	=> ConfigBits(138 + 0),
		S2 	=> ConfigBits(138 + 1),
		O  	=> J2MID_ABa_BEG1 );

-- switch matrix multiplexer  J2MID_ABa_BEG2 		MUX-4
J2MID_ABa_BEG2_input 	 <= JS2END3 & W2MID4 & E2MID4 & N2MID4 after 80 ps;
inst_MUX4PTv4_J2MID_ABa_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABa_BEG2_input(0),
		IN2 	=> J2MID_ABa_BEG2_input(1),
		IN3 	=> J2MID_ABa_BEG2_input(2),
		IN4 	=> J2MID_ABa_BEG2_input(3),
		S1 	=> ConfigBits(140 + 0),
		S2 	=> ConfigBits(140 + 1),
		O  	=> J2MID_ABa_BEG2 );

-- switch matrix multiplexer  J2MID_ABa_BEG3 		MUX-4
J2MID_ABa_BEG3_input 	 <= JW2END3 & S2MID0 & E2MID0 & N2MID0 after 80 ps;
inst_MUX4PTv4_J2MID_ABa_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABa_BEG3_input(0),
		IN2 	=> J2MID_ABa_BEG3_input(1),
		IN3 	=> J2MID_ABa_BEG3_input(2),
		IN4 	=> J2MID_ABa_BEG3_input(3),
		S1 	=> ConfigBits(142 + 0),
		S2 	=> ConfigBits(142 + 1),
		O  	=> J2MID_ABa_BEG3 );

-- switch matrix multiplexer  J2MID_CDa_BEG0 		MUX-4
J2MID_CDa_BEG0_input 	 <= JN2END4 & W2MID6 & S2MID6 & E2MID6 after 80 ps;
inst_MUX4PTv4_J2MID_CDa_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDa_BEG0_input(0),
		IN2 	=> J2MID_CDa_BEG0_input(1),
		IN3 	=> J2MID_CDa_BEG0_input(2),
		IN4 	=> J2MID_CDa_BEG0_input(3),
		S1 	=> ConfigBits(144 + 0),
		S2 	=> ConfigBits(144 + 1),
		O  	=> J2MID_CDa_BEG0 );

-- switch matrix multiplexer  J2MID_CDa_BEG1 		MUX-4
J2MID_CDa_BEG1_input 	 <= JE2END4 & W2MID2 & E2MID2 & N2MID2 after 80 ps;
inst_MUX4PTv4_J2MID_CDa_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDa_BEG1_input(0),
		IN2 	=> J2MID_CDa_BEG1_input(1),
		IN3 	=> J2MID_CDa_BEG1_input(2),
		IN4 	=> J2MID_CDa_BEG1_input(3),
		S1 	=> ConfigBits(146 + 0),
		S2 	=> ConfigBits(146 + 1),
		O  	=> J2MID_CDa_BEG1 );

-- switch matrix multiplexer  J2MID_CDa_BEG2 		MUX-4
J2MID_CDa_BEG2_input 	 <= JS2END4 & S2MID4 & E2MID4 & N2MID4 after 80 ps;
inst_MUX4PTv4_J2MID_CDa_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDa_BEG2_input(0),
		IN2 	=> J2MID_CDa_BEG2_input(1),
		IN3 	=> J2MID_CDa_BEG2_input(2),
		IN4 	=> J2MID_CDa_BEG2_input(3),
		S1 	=> ConfigBits(148 + 0),
		S2 	=> ConfigBits(148 + 1),
		O  	=> J2MID_CDa_BEG2 );

-- switch matrix multiplexer  J2MID_CDa_BEG3 		MUX-4
J2MID_CDa_BEG3_input 	 <= JW2END4 & W2MID0 & S2MID0 & N2MID0 after 80 ps;
inst_MUX4PTv4_J2MID_CDa_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDa_BEG3_input(0),
		IN2 	=> J2MID_CDa_BEG3_input(1),
		IN3 	=> J2MID_CDa_BEG3_input(2),
		IN4 	=> J2MID_CDa_BEG3_input(3),
		S1 	=> ConfigBits(150 + 0),
		S2 	=> ConfigBits(150 + 1),
		O  	=> J2MID_CDa_BEG3 );

-- switch matrix multiplexer  J2MID_EFa_BEG0 		MUX-4
J2MID_EFa_BEG0_input 	 <= JN2END5 & W2MID6 & E2MID6 & N2MID6 after 80 ps;
inst_MUX4PTv4_J2MID_EFa_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFa_BEG0_input(0),
		IN2 	=> J2MID_EFa_BEG0_input(1),
		IN3 	=> J2MID_EFa_BEG0_input(2),
		IN4 	=> J2MID_EFa_BEG0_input(3),
		S1 	=> ConfigBits(152 + 0),
		S2 	=> ConfigBits(152 + 1),
		O  	=> J2MID_EFa_BEG0 );

-- switch matrix multiplexer  J2MID_EFa_BEG1 		MUX-4
J2MID_EFa_BEG1_input 	 <= JE2END5 & S2MID2 & E2MID2 & N2MID2 after 80 ps;
inst_MUX4PTv4_J2MID_EFa_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFa_BEG1_input(0),
		IN2 	=> J2MID_EFa_BEG1_input(1),
		IN3 	=> J2MID_EFa_BEG1_input(2),
		IN4 	=> J2MID_EFa_BEG1_input(3),
		S1 	=> ConfigBits(154 + 0),
		S2 	=> ConfigBits(154 + 1),
		O  	=> J2MID_EFa_BEG1 );

-- switch matrix multiplexer  J2MID_EFa_BEG2 		MUX-4
J2MID_EFa_BEG2_input 	 <= JS2END5 & W2MID4 & S2MID4 & N2MID4 after 80 ps;
inst_MUX4PTv4_J2MID_EFa_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFa_BEG2_input(0),
		IN2 	=> J2MID_EFa_BEG2_input(1),
		IN3 	=> J2MID_EFa_BEG2_input(2),
		IN4 	=> J2MID_EFa_BEG2_input(3),
		S1 	=> ConfigBits(156 + 0),
		S2 	=> ConfigBits(156 + 1),
		O  	=> J2MID_EFa_BEG2 );

-- switch matrix multiplexer  J2MID_EFa_BEG3 		MUX-4
J2MID_EFa_BEG3_input 	 <= JW2END5 & W2MID0 & S2MID0 & E2MID0 after 80 ps;
inst_MUX4PTv4_J2MID_EFa_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFa_BEG3_input(0),
		IN2 	=> J2MID_EFa_BEG3_input(1),
		IN3 	=> J2MID_EFa_BEG3_input(2),
		IN4 	=> J2MID_EFa_BEG3_input(3),
		S1 	=> ConfigBits(158 + 0),
		S2 	=> ConfigBits(158 + 1),
		O  	=> J2MID_EFa_BEG3 );

-- switch matrix multiplexer  J2MID_GHa_BEG0 		MUX-4
J2MID_GHa_BEG0_input 	 <= JN2END6 & S2MID6 & E2MID6 & N2MID6 after 80 ps;
inst_MUX4PTv4_J2MID_GHa_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHa_BEG0_input(0),
		IN2 	=> J2MID_GHa_BEG0_input(1),
		IN3 	=> J2MID_GHa_BEG0_input(2),
		IN4 	=> J2MID_GHa_BEG0_input(3),
		S1 	=> ConfigBits(160 + 0),
		S2 	=> ConfigBits(160 + 1),
		O  	=> J2MID_GHa_BEG0 );

-- switch matrix multiplexer  J2MID_GHa_BEG1 		MUX-4
J2MID_GHa_BEG1_input 	 <= JE2END6 & W2MID2 & S2MID2 & N2MID2 after 80 ps;
inst_MUX4PTv4_J2MID_GHa_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHa_BEG1_input(0),
		IN2 	=> J2MID_GHa_BEG1_input(1),
		IN3 	=> J2MID_GHa_BEG1_input(2),
		IN4 	=> J2MID_GHa_BEG1_input(3),
		S1 	=> ConfigBits(162 + 0),
		S2 	=> ConfigBits(162 + 1),
		O  	=> J2MID_GHa_BEG1 );

-- switch matrix multiplexer  J2MID_GHa_BEG2 		MUX-4
J2MID_GHa_BEG2_input 	 <= JS2END6 & W2MID4 & S2MID4 & E2MID4 after 80 ps;
inst_MUX4PTv4_J2MID_GHa_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHa_BEG2_input(0),
		IN2 	=> J2MID_GHa_BEG2_input(1),
		IN3 	=> J2MID_GHa_BEG2_input(2),
		IN4 	=> J2MID_GHa_BEG2_input(3),
		S1 	=> ConfigBits(164 + 0),
		S2 	=> ConfigBits(164 + 1),
		O  	=> J2MID_GHa_BEG2 );

-- switch matrix multiplexer  J2MID_GHa_BEG3 		MUX-4
J2MID_GHa_BEG3_input 	 <= JW2END6 & W2MID0 & E2MID0 & N2MID0 after 80 ps;
inst_MUX4PTv4_J2MID_GHa_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHa_BEG3_input(0),
		IN2 	=> J2MID_GHa_BEG3_input(1),
		IN3 	=> J2MID_GHa_BEG3_input(2),
		IN4 	=> J2MID_GHa_BEG3_input(3),
		S1 	=> ConfigBits(166 + 0),
		S2 	=> ConfigBits(166 + 1),
		O  	=> J2MID_GHa_BEG3 );

-- switch matrix multiplexer  J2MID_ABb_BEG0 		MUX-4
J2MID_ABb_BEG0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7 after 80 ps;
inst_MUX4PTv4_J2MID_ABb_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABb_BEG0_input(0),
		IN2 	=> J2MID_ABb_BEG0_input(1),
		IN3 	=> J2MID_ABb_BEG0_input(2),
		IN4 	=> J2MID_ABb_BEG0_input(3),
		S1 	=> ConfigBits(168 + 0),
		S2 	=> ConfigBits(168 + 1),
		O  	=> J2MID_ABb_BEG0 );

-- switch matrix multiplexer  J2MID_ABb_BEG1 		MUX-4
J2MID_ABb_BEG1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3 after 80 ps;
inst_MUX4PTv4_J2MID_ABb_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABb_BEG1_input(0),
		IN2 	=> J2MID_ABb_BEG1_input(1),
		IN3 	=> J2MID_ABb_BEG1_input(2),
		IN4 	=> J2MID_ABb_BEG1_input(3),
		S1 	=> ConfigBits(170 + 0),
		S2 	=> ConfigBits(170 + 1),
		O  	=> J2MID_ABb_BEG1 );

-- switch matrix multiplexer  J2MID_ABb_BEG2 		MUX-4
J2MID_ABb_BEG2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5 after 80 ps;
inst_MUX4PTv4_J2MID_ABb_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABb_BEG2_input(0),
		IN2 	=> J2MID_ABb_BEG2_input(1),
		IN3 	=> J2MID_ABb_BEG2_input(2),
		IN4 	=> J2MID_ABb_BEG2_input(3),
		S1 	=> ConfigBits(172 + 0),
		S2 	=> ConfigBits(172 + 1),
		O  	=> J2MID_ABb_BEG2 );

-- switch matrix multiplexer  J2MID_ABb_BEG3 		MUX-4
J2MID_ABb_BEG3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1 after 80 ps;
inst_MUX4PTv4_J2MID_ABb_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_ABb_BEG3_input(0),
		IN2 	=> J2MID_ABb_BEG3_input(1),
		IN3 	=> J2MID_ABb_BEG3_input(2),
		IN4 	=> J2MID_ABb_BEG3_input(3),
		S1 	=> ConfigBits(174 + 0),
		S2 	=> ConfigBits(174 + 1),
		O  	=> J2MID_ABb_BEG3 );

-- switch matrix multiplexer  J2MID_CDb_BEG0 		MUX-4
J2MID_CDb_BEG0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7 after 80 ps;
inst_MUX4PTv4_J2MID_CDb_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDb_BEG0_input(0),
		IN2 	=> J2MID_CDb_BEG0_input(1),
		IN3 	=> J2MID_CDb_BEG0_input(2),
		IN4 	=> J2MID_CDb_BEG0_input(3),
		S1 	=> ConfigBits(176 + 0),
		S2 	=> ConfigBits(176 + 1),
		O  	=> J2MID_CDb_BEG0 );

-- switch matrix multiplexer  J2MID_CDb_BEG1 		MUX-4
J2MID_CDb_BEG1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3 after 80 ps;
inst_MUX4PTv4_J2MID_CDb_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDb_BEG1_input(0),
		IN2 	=> J2MID_CDb_BEG1_input(1),
		IN3 	=> J2MID_CDb_BEG1_input(2),
		IN4 	=> J2MID_CDb_BEG1_input(3),
		S1 	=> ConfigBits(178 + 0),
		S2 	=> ConfigBits(178 + 1),
		O  	=> J2MID_CDb_BEG1 );

-- switch matrix multiplexer  J2MID_CDb_BEG2 		MUX-4
J2MID_CDb_BEG2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5 after 80 ps;
inst_MUX4PTv4_J2MID_CDb_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDb_BEG2_input(0),
		IN2 	=> J2MID_CDb_BEG2_input(1),
		IN3 	=> J2MID_CDb_BEG2_input(2),
		IN4 	=> J2MID_CDb_BEG2_input(3),
		S1 	=> ConfigBits(180 + 0),
		S2 	=> ConfigBits(180 + 1),
		O  	=> J2MID_CDb_BEG2 );

-- switch matrix multiplexer  J2MID_CDb_BEG3 		MUX-4
J2MID_CDb_BEG3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1 after 80 ps;
inst_MUX4PTv4_J2MID_CDb_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_CDb_BEG3_input(0),
		IN2 	=> J2MID_CDb_BEG3_input(1),
		IN3 	=> J2MID_CDb_BEG3_input(2),
		IN4 	=> J2MID_CDb_BEG3_input(3),
		S1 	=> ConfigBits(182 + 0),
		S2 	=> ConfigBits(182 + 1),
		O  	=> J2MID_CDb_BEG3 );

-- switch matrix multiplexer  J2MID_EFb_BEG0 		MUX-4
J2MID_EFb_BEG0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7 after 80 ps;
inst_MUX4PTv4_J2MID_EFb_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFb_BEG0_input(0),
		IN2 	=> J2MID_EFb_BEG0_input(1),
		IN3 	=> J2MID_EFb_BEG0_input(2),
		IN4 	=> J2MID_EFb_BEG0_input(3),
		S1 	=> ConfigBits(184 + 0),
		S2 	=> ConfigBits(184 + 1),
		O  	=> J2MID_EFb_BEG0 );

-- switch matrix multiplexer  J2MID_EFb_BEG1 		MUX-4
J2MID_EFb_BEG1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3 after 80 ps;
inst_MUX4PTv4_J2MID_EFb_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFb_BEG1_input(0),
		IN2 	=> J2MID_EFb_BEG1_input(1),
		IN3 	=> J2MID_EFb_BEG1_input(2),
		IN4 	=> J2MID_EFb_BEG1_input(3),
		S1 	=> ConfigBits(186 + 0),
		S2 	=> ConfigBits(186 + 1),
		O  	=> J2MID_EFb_BEG1 );

-- switch matrix multiplexer  J2MID_EFb_BEG2 		MUX-4
J2MID_EFb_BEG2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5 after 80 ps;
inst_MUX4PTv4_J2MID_EFb_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFb_BEG2_input(0),
		IN2 	=> J2MID_EFb_BEG2_input(1),
		IN3 	=> J2MID_EFb_BEG2_input(2),
		IN4 	=> J2MID_EFb_BEG2_input(3),
		S1 	=> ConfigBits(188 + 0),
		S2 	=> ConfigBits(188 + 1),
		O  	=> J2MID_EFb_BEG2 );

-- switch matrix multiplexer  J2MID_EFb_BEG3 		MUX-4
J2MID_EFb_BEG3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1 after 80 ps;
inst_MUX4PTv4_J2MID_EFb_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_EFb_BEG3_input(0),
		IN2 	=> J2MID_EFb_BEG3_input(1),
		IN3 	=> J2MID_EFb_BEG3_input(2),
		IN4 	=> J2MID_EFb_BEG3_input(3),
		S1 	=> ConfigBits(190 + 0),
		S2 	=> ConfigBits(190 + 1),
		O  	=> J2MID_EFb_BEG3 );

-- switch matrix multiplexer  J2MID_GHb_BEG0 		MUX-4
J2MID_GHb_BEG0_input 	 <= W2MID7 & S2MID7 & E2MID7 & N2MID7 after 80 ps;
inst_MUX4PTv4_J2MID_GHb_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHb_BEG0_input(0),
		IN2 	=> J2MID_GHb_BEG0_input(1),
		IN3 	=> J2MID_GHb_BEG0_input(2),
		IN4 	=> J2MID_GHb_BEG0_input(3),
		S1 	=> ConfigBits(192 + 0),
		S2 	=> ConfigBits(192 + 1),
		O  	=> J2MID_GHb_BEG0 );

-- switch matrix multiplexer  J2MID_GHb_BEG1 		MUX-4
J2MID_GHb_BEG1_input 	 <= W2MID3 & S2MID3 & E2MID3 & N2MID3 after 80 ps;
inst_MUX4PTv4_J2MID_GHb_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHb_BEG1_input(0),
		IN2 	=> J2MID_GHb_BEG1_input(1),
		IN3 	=> J2MID_GHb_BEG1_input(2),
		IN4 	=> J2MID_GHb_BEG1_input(3),
		S1 	=> ConfigBits(194 + 0),
		S2 	=> ConfigBits(194 + 1),
		O  	=> J2MID_GHb_BEG1 );

-- switch matrix multiplexer  J2MID_GHb_BEG2 		MUX-4
J2MID_GHb_BEG2_input 	 <= W2MID5 & S2MID5 & E2MID5 & N2MID5 after 80 ps;
inst_MUX4PTv4_J2MID_GHb_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHb_BEG2_input(0),
		IN2 	=> J2MID_GHb_BEG2_input(1),
		IN3 	=> J2MID_GHb_BEG2_input(2),
		IN4 	=> J2MID_GHb_BEG2_input(3),
		S1 	=> ConfigBits(196 + 0),
		S2 	=> ConfigBits(196 + 1),
		O  	=> J2MID_GHb_BEG2 );

-- switch matrix multiplexer  J2MID_GHb_BEG3 		MUX-4
J2MID_GHb_BEG3_input 	 <= W2MID1 & S2MID1 & E2MID1 & N2MID1 after 80 ps;
inst_MUX4PTv4_J2MID_GHb_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2MID_GHb_BEG3_input(0),
		IN2 	=> J2MID_GHb_BEG3_input(1),
		IN3 	=> J2MID_GHb_BEG3_input(2),
		IN4 	=> J2MID_GHb_BEG3_input(3),
		S1 	=> ConfigBits(198 + 0),
		S2 	=> ConfigBits(198 + 1),
		O  	=> J2MID_GHb_BEG3 );

-- switch matrix multiplexer  J2END_AB_BEG0 		MUX-4
J2END_AB_BEG0_input 	 <= W2END6 & S2END6 & E2END6 & N2END6 after 80 ps;
inst_MUX4PTv4_J2END_AB_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_AB_BEG0_input(0),
		IN2 	=> J2END_AB_BEG0_input(1),
		IN3 	=> J2END_AB_BEG0_input(2),
		IN4 	=> J2END_AB_BEG0_input(3),
		S1 	=> ConfigBits(200 + 0),
		S2 	=> ConfigBits(200 + 1),
		O  	=> J2END_AB_BEG0 );

-- switch matrix multiplexer  J2END_AB_BEG1 		MUX-4
J2END_AB_BEG1_input 	 <= W2END2 & S2END2 & E2END2 & N2END2 after 80 ps;
inst_MUX4PTv4_J2END_AB_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_AB_BEG1_input(0),
		IN2 	=> J2END_AB_BEG1_input(1),
		IN3 	=> J2END_AB_BEG1_input(2),
		IN4 	=> J2END_AB_BEG1_input(3),
		S1 	=> ConfigBits(202 + 0),
		S2 	=> ConfigBits(202 + 1),
		O  	=> J2END_AB_BEG1 );

-- switch matrix multiplexer  J2END_AB_BEG2 		MUX-4
J2END_AB_BEG2_input 	 <= W2END4 & S2END4 & E2END4 & N2END4 after 80 ps;
inst_MUX4PTv4_J2END_AB_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_AB_BEG2_input(0),
		IN2 	=> J2END_AB_BEG2_input(1),
		IN3 	=> J2END_AB_BEG2_input(2),
		IN4 	=> J2END_AB_BEG2_input(3),
		S1 	=> ConfigBits(204 + 0),
		S2 	=> ConfigBits(204 + 1),
		O  	=> J2END_AB_BEG2 );

-- switch matrix multiplexer  J2END_AB_BEG3 		MUX-4
J2END_AB_BEG3_input 	 <= W2END0 & S2END0 & E2END0 & N2END0 after 80 ps;
inst_MUX4PTv4_J2END_AB_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_AB_BEG3_input(0),
		IN2 	=> J2END_AB_BEG3_input(1),
		IN3 	=> J2END_AB_BEG3_input(2),
		IN4 	=> J2END_AB_BEG3_input(3),
		S1 	=> ConfigBits(206 + 0),
		S2 	=> ConfigBits(206 + 1),
		O  	=> J2END_AB_BEG3 );

-- switch matrix multiplexer  J2END_CD_BEG0 		MUX-4
J2END_CD_BEG0_input 	 <= W2END6 & S2END6 & E2END6 & N2END6 after 80 ps;
inst_MUX4PTv4_J2END_CD_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_CD_BEG0_input(0),
		IN2 	=> J2END_CD_BEG0_input(1),
		IN3 	=> J2END_CD_BEG0_input(2),
		IN4 	=> J2END_CD_BEG0_input(3),
		S1 	=> ConfigBits(208 + 0),
		S2 	=> ConfigBits(208 + 1),
		O  	=> J2END_CD_BEG0 );

-- switch matrix multiplexer  J2END_CD_BEG1 		MUX-4
J2END_CD_BEG1_input 	 <= W2END2 & S2END2 & E2END2 & N2END2 after 80 ps;
inst_MUX4PTv4_J2END_CD_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_CD_BEG1_input(0),
		IN2 	=> J2END_CD_BEG1_input(1),
		IN3 	=> J2END_CD_BEG1_input(2),
		IN4 	=> J2END_CD_BEG1_input(3),
		S1 	=> ConfigBits(210 + 0),
		S2 	=> ConfigBits(210 + 1),
		O  	=> J2END_CD_BEG1 );

-- switch matrix multiplexer  J2END_CD_BEG2 		MUX-4
J2END_CD_BEG2_input 	 <= W2END4 & S2END4 & E2END4 & N2END4 after 80 ps;
inst_MUX4PTv4_J2END_CD_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_CD_BEG2_input(0),
		IN2 	=> J2END_CD_BEG2_input(1),
		IN3 	=> J2END_CD_BEG2_input(2),
		IN4 	=> J2END_CD_BEG2_input(3),
		S1 	=> ConfigBits(212 + 0),
		S2 	=> ConfigBits(212 + 1),
		O  	=> J2END_CD_BEG2 );

-- switch matrix multiplexer  J2END_CD_BEG3 		MUX-4
J2END_CD_BEG3_input 	 <= W2END0 & S2END0 & E2END0 & N2END0 after 80 ps;
inst_MUX4PTv4_J2END_CD_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_CD_BEG3_input(0),
		IN2 	=> J2END_CD_BEG3_input(1),
		IN3 	=> J2END_CD_BEG3_input(2),
		IN4 	=> J2END_CD_BEG3_input(3),
		S1 	=> ConfigBits(214 + 0),
		S2 	=> ConfigBits(214 + 1),
		O  	=> J2END_CD_BEG3 );

-- switch matrix multiplexer  J2END_EF_BEG0 		MUX-4
J2END_EF_BEG0_input 	 <= W2END7 & S2END7 & E2END7 & N2END7 after 80 ps;
inst_MUX4PTv4_J2END_EF_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_EF_BEG0_input(0),
		IN2 	=> J2END_EF_BEG0_input(1),
		IN3 	=> J2END_EF_BEG0_input(2),
		IN4 	=> J2END_EF_BEG0_input(3),
		S1 	=> ConfigBits(216 + 0),
		S2 	=> ConfigBits(216 + 1),
		O  	=> J2END_EF_BEG0 );

-- switch matrix multiplexer  J2END_EF_BEG1 		MUX-4
J2END_EF_BEG1_input 	 <= W2END3 & S2END3 & E2END3 & N2END3 after 80 ps;
inst_MUX4PTv4_J2END_EF_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_EF_BEG1_input(0),
		IN2 	=> J2END_EF_BEG1_input(1),
		IN3 	=> J2END_EF_BEG1_input(2),
		IN4 	=> J2END_EF_BEG1_input(3),
		S1 	=> ConfigBits(218 + 0),
		S2 	=> ConfigBits(218 + 1),
		O  	=> J2END_EF_BEG1 );

-- switch matrix multiplexer  J2END_EF_BEG2 		MUX-4
J2END_EF_BEG2_input 	 <= W2END5 & S2END5 & E2END5 & N2END5 after 80 ps;
inst_MUX4PTv4_J2END_EF_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_EF_BEG2_input(0),
		IN2 	=> J2END_EF_BEG2_input(1),
		IN3 	=> J2END_EF_BEG2_input(2),
		IN4 	=> J2END_EF_BEG2_input(3),
		S1 	=> ConfigBits(220 + 0),
		S2 	=> ConfigBits(220 + 1),
		O  	=> J2END_EF_BEG2 );

-- switch matrix multiplexer  J2END_EF_BEG3 		MUX-4
J2END_EF_BEG3_input 	 <= W2END1 & S2END1 & E2END1 & N2END1 after 80 ps;
inst_MUX4PTv4_J2END_EF_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_EF_BEG3_input(0),
		IN2 	=> J2END_EF_BEG3_input(1),
		IN3 	=> J2END_EF_BEG3_input(2),
		IN4 	=> J2END_EF_BEG3_input(3),
		S1 	=> ConfigBits(222 + 0),
		S2 	=> ConfigBits(222 + 1),
		O  	=> J2END_EF_BEG3 );

-- switch matrix multiplexer  J2END_GH_BEG0 		MUX-4
J2END_GH_BEG0_input 	 <= W2END7 & S2END7 & E2END7 & N2END7 after 80 ps;
inst_MUX4PTv4_J2END_GH_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_GH_BEG0_input(0),
		IN2 	=> J2END_GH_BEG0_input(1),
		IN3 	=> J2END_GH_BEG0_input(2),
		IN4 	=> J2END_GH_BEG0_input(3),
		S1 	=> ConfigBits(224 + 0),
		S2 	=> ConfigBits(224 + 1),
		O  	=> J2END_GH_BEG0 );

-- switch matrix multiplexer  J2END_GH_BEG1 		MUX-4
J2END_GH_BEG1_input 	 <= W2END3 & S2END3 & E2END3 & N2END3 after 80 ps;
inst_MUX4PTv4_J2END_GH_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_GH_BEG1_input(0),
		IN2 	=> J2END_GH_BEG1_input(1),
		IN3 	=> J2END_GH_BEG1_input(2),
		IN4 	=> J2END_GH_BEG1_input(3),
		S1 	=> ConfigBits(226 + 0),
		S2 	=> ConfigBits(226 + 1),
		O  	=> J2END_GH_BEG1 );

-- switch matrix multiplexer  J2END_GH_BEG2 		MUX-4
J2END_GH_BEG2_input 	 <= W2END5 & S2END5 & E2END5 & N2END5 after 80 ps;
inst_MUX4PTv4_J2END_GH_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_GH_BEG2_input(0),
		IN2 	=> J2END_GH_BEG2_input(1),
		IN3 	=> J2END_GH_BEG2_input(2),
		IN4 	=> J2END_GH_BEG2_input(3),
		S1 	=> ConfigBits(228 + 0),
		S2 	=> ConfigBits(228 + 1),
		O  	=> J2END_GH_BEG2 );

-- switch matrix multiplexer  J2END_GH_BEG3 		MUX-4
J2END_GH_BEG3_input 	 <= W2END1 & S2END1 & E2END1 & N2END1 after 80 ps;
inst_MUX4PTv4_J2END_GH_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J2END_GH_BEG3_input(0),
		IN2 	=> J2END_GH_BEG3_input(1),
		IN3 	=> J2END_GH_BEG3_input(2),
		IN4 	=> J2END_GH_BEG3_input(3),
		S1 	=> ConfigBits(230 + 0),
		S2 	=> ConfigBits(230 + 1),
		O  	=> J2END_GH_BEG3 );

-- switch matrix multiplexer  JN2BEG0 		MUX-16
JN2BEG0_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S2END1 & E6END1 & E2END1 & E1END3 & N4END1 & N2END1 after 80 ps;
inst_MUX16PTv2_JN2BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG0_input(0),
		IN2 	=> JN2BEG0_input(1),
		IN3 	=> JN2BEG0_input(2),
		IN4 	=> JN2BEG0_input(3),
		IN5 	=> JN2BEG0_input(4),
		IN6 	=> JN2BEG0_input(5),
		IN7 	=> JN2BEG0_input(6),
		IN8 	=> JN2BEG0_input(7),
		IN9 	=> JN2BEG0_input(8),
		IN10 	=> JN2BEG0_input(9),
		IN11 	=> JN2BEG0_input(10),
		IN12 	=> JN2BEG0_input(11),
		IN13 	=> JN2BEG0_input(12),
		IN14 	=> JN2BEG0_input(13),
		IN15 	=> JN2BEG0_input(14),
		IN16 	=> JN2BEG0_input(15),
		S1 	=> ConfigBits(232 + 0),
		S2 	=> ConfigBits(232 + 1),
		S3 	=> ConfigBits(232 + 2),
		S4 	=> ConfigBits(232 + 3),
		O  	=> JN2BEG0 );

-- switch matrix multiplexer  JN2BEG1 		MUX-16
JN2BEG1_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S2END2 & E6END0 & E2END2 & E1END0 & N4END2 & N2END2 after 80 ps;
inst_MUX16PTv2_JN2BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG1_input(0),
		IN2 	=> JN2BEG1_input(1),
		IN3 	=> JN2BEG1_input(2),
		IN4 	=> JN2BEG1_input(3),
		IN5 	=> JN2BEG1_input(4),
		IN6 	=> JN2BEG1_input(5),
		IN7 	=> JN2BEG1_input(6),
		IN8 	=> JN2BEG1_input(7),
		IN9 	=> JN2BEG1_input(8),
		IN10 	=> JN2BEG1_input(9),
		IN11 	=> JN2BEG1_input(10),
		IN12 	=> JN2BEG1_input(11),
		IN13 	=> JN2BEG1_input(12),
		IN14 	=> JN2BEG1_input(13),
		IN15 	=> JN2BEG1_input(14),
		IN16 	=> JN2BEG1_input(15),
		S1 	=> ConfigBits(236 + 0),
		S2 	=> ConfigBits(236 + 1),
		S3 	=> ConfigBits(236 + 2),
		S4 	=> ConfigBits(236 + 3),
		O  	=> JN2BEG1 );

-- switch matrix multiplexer  JN2BEG2 		MUX-16
JN2BEG2_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S2END3 & E6END1 & E2END3 & E1END1 & N4END3 & N2END3 after 80 ps;
inst_MUX16PTv2_JN2BEG2 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG2_input(0),
		IN2 	=> JN2BEG2_input(1),
		IN3 	=> JN2BEG2_input(2),
		IN4 	=> JN2BEG2_input(3),
		IN5 	=> JN2BEG2_input(4),
		IN6 	=> JN2BEG2_input(5),
		IN7 	=> JN2BEG2_input(6),
		IN8 	=> JN2BEG2_input(7),
		IN9 	=> JN2BEG2_input(8),
		IN10 	=> JN2BEG2_input(9),
		IN11 	=> JN2BEG2_input(10),
		IN12 	=> JN2BEG2_input(11),
		IN13 	=> JN2BEG2_input(12),
		IN14 	=> JN2BEG2_input(13),
		IN15 	=> JN2BEG2_input(14),
		IN16 	=> JN2BEG2_input(15),
		S1 	=> ConfigBits(240 + 0),
		S2 	=> ConfigBits(240 + 1),
		S3 	=> ConfigBits(240 + 2),
		S4 	=> ConfigBits(240 + 3),
		O  	=> JN2BEG2 );

-- switch matrix multiplexer  JN2BEG3 		MUX-16
JN2BEG3_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S2END4 & E6END0 & E2END4 & E1END2 & N4END0 & N2END4 after 80 ps;
inst_MUX16PTv2_JN2BEG3 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG3_input(0),
		IN2 	=> JN2BEG3_input(1),
		IN3 	=> JN2BEG3_input(2),
		IN4 	=> JN2BEG3_input(3),
		IN5 	=> JN2BEG3_input(4),
		IN6 	=> JN2BEG3_input(5),
		IN7 	=> JN2BEG3_input(6),
		IN8 	=> JN2BEG3_input(7),
		IN9 	=> JN2BEG3_input(8),
		IN10 	=> JN2BEG3_input(9),
		IN11 	=> JN2BEG3_input(10),
		IN12 	=> JN2BEG3_input(11),
		IN13 	=> JN2BEG3_input(12),
		IN14 	=> JN2BEG3_input(13),
		IN15 	=> JN2BEG3_input(14),
		IN16 	=> JN2BEG3_input(15),
		S1 	=> ConfigBits(244 + 0),
		S2 	=> ConfigBits(244 + 1),
		S3 	=> ConfigBits(244 + 2),
		S4 	=> ConfigBits(244 + 3),
		O  	=> JN2BEG3 );

-- switch matrix multiplexer  JN2BEG4 		MUX-16
JN2BEG4_input 	 <= M_AB & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END5 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1 after 80 ps;
inst_MUX16PTv2_JN2BEG4 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG4_input(0),
		IN2 	=> JN2BEG4_input(1),
		IN3 	=> JN2BEG4_input(2),
		IN4 	=> JN2BEG4_input(3),
		IN5 	=> JN2BEG4_input(4),
		IN6 	=> JN2BEG4_input(5),
		IN7 	=> JN2BEG4_input(6),
		IN8 	=> JN2BEG4_input(7),
		IN9 	=> JN2BEG4_input(8),
		IN10 	=> JN2BEG4_input(9),
		IN11 	=> JN2BEG4_input(10),
		IN12 	=> JN2BEG4_input(11),
		IN13 	=> JN2BEG4_input(12),
		IN14 	=> JN2BEG4_input(13),
		IN15 	=> JN2BEG4_input(14),
		IN16 	=> JN2BEG4_input(15),
		S1 	=> ConfigBits(248 + 0),
		S2 	=> ConfigBits(248 + 1),
		S3 	=> ConfigBits(248 + 2),
		S4 	=> ConfigBits(248 + 3),
		O  	=> JN2BEG4 );

-- switch matrix multiplexer  JN2BEG5 		MUX-16
JN2BEG5_input 	 <= M_AD & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END6 & S1END2 & E2END6 & E1END2 & N2END6 & N1END2 after 80 ps;
inst_MUX16PTv2_JN2BEG5 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG5_input(0),
		IN2 	=> JN2BEG5_input(1),
		IN3 	=> JN2BEG5_input(2),
		IN4 	=> JN2BEG5_input(3),
		IN5 	=> JN2BEG5_input(4),
		IN6 	=> JN2BEG5_input(5),
		IN7 	=> JN2BEG5_input(6),
		IN8 	=> JN2BEG5_input(7),
		IN9 	=> JN2BEG5_input(8),
		IN10 	=> JN2BEG5_input(9),
		IN11 	=> JN2BEG5_input(10),
		IN12 	=> JN2BEG5_input(11),
		IN13 	=> JN2BEG5_input(12),
		IN14 	=> JN2BEG5_input(13),
		IN15 	=> JN2BEG5_input(14),
		IN16 	=> JN2BEG5_input(15),
		S1 	=> ConfigBits(252 + 0),
		S2 	=> ConfigBits(252 + 1),
		S3 	=> ConfigBits(252 + 2),
		S4 	=> ConfigBits(252 + 3),
		O  	=> JN2BEG5 );

-- switch matrix multiplexer  JN2BEG6 		MUX-16
JN2BEG6_input 	 <= M_AH & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END7 & S1END3 & E2END7 & E1END3 & N2END7 & N1END3 after 80 ps;
inst_MUX16PTv2_JN2BEG6 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG6_input(0),
		IN2 	=> JN2BEG6_input(1),
		IN3 	=> JN2BEG6_input(2),
		IN4 	=> JN2BEG6_input(3),
		IN5 	=> JN2BEG6_input(4),
		IN6 	=> JN2BEG6_input(5),
		IN7 	=> JN2BEG6_input(6),
		IN8 	=> JN2BEG6_input(7),
		IN9 	=> JN2BEG6_input(8),
		IN10 	=> JN2BEG6_input(9),
		IN11 	=> JN2BEG6_input(10),
		IN12 	=> JN2BEG6_input(11),
		IN13 	=> JN2BEG6_input(12),
		IN14 	=> JN2BEG6_input(13),
		IN15 	=> JN2BEG6_input(14),
		IN16 	=> JN2BEG6_input(15),
		S1 	=> ConfigBits(256 + 0),
		S2 	=> ConfigBits(256 + 1),
		S3 	=> ConfigBits(256 + 2),
		S4 	=> ConfigBits(256 + 3),
		O  	=> JN2BEG6 );

-- switch matrix multiplexer  JN2BEG7 		MUX-16
JN2BEG7_input 	 <= M_EF & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END0 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0 after 80 ps;
inst_MUX16PTv2_JN2BEG7 : MUX16PTv2
	 Port Map(
		IN1 	=> JN2BEG7_input(0),
		IN2 	=> JN2BEG7_input(1),
		IN3 	=> JN2BEG7_input(2),
		IN4 	=> JN2BEG7_input(3),
		IN5 	=> JN2BEG7_input(4),
		IN6 	=> JN2BEG7_input(5),
		IN7 	=> JN2BEG7_input(6),
		IN8 	=> JN2BEG7_input(7),
		IN9 	=> JN2BEG7_input(8),
		IN10 	=> JN2BEG7_input(9),
		IN11 	=> JN2BEG7_input(10),
		IN12 	=> JN2BEG7_input(11),
		IN13 	=> JN2BEG7_input(12),
		IN14 	=> JN2BEG7_input(13),
		IN15 	=> JN2BEG7_input(14),
		IN16 	=> JN2BEG7_input(15),
		S1 	=> ConfigBits(260 + 0),
		S2 	=> ConfigBits(260 + 1),
		S3 	=> ConfigBits(260 + 2),
		S4 	=> ConfigBits(260 + 3),
		O  	=> JN2BEG7 );

-- switch matrix multiplexer  JE2BEG0 		MUX-16
JE2BEG0_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S2END1 & E6END1 & E2END1 & N4END1 & N2END1 & N1END3 after 80 ps;
inst_MUX16PTv2_JE2BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG0_input(0),
		IN2 	=> JE2BEG0_input(1),
		IN3 	=> JE2BEG0_input(2),
		IN4 	=> JE2BEG0_input(3),
		IN5 	=> JE2BEG0_input(4),
		IN6 	=> JE2BEG0_input(5),
		IN7 	=> JE2BEG0_input(6),
		IN8 	=> JE2BEG0_input(7),
		IN9 	=> JE2BEG0_input(8),
		IN10 	=> JE2BEG0_input(9),
		IN11 	=> JE2BEG0_input(10),
		IN12 	=> JE2BEG0_input(11),
		IN13 	=> JE2BEG0_input(12),
		IN14 	=> JE2BEG0_input(13),
		IN15 	=> JE2BEG0_input(14),
		IN16 	=> JE2BEG0_input(15),
		S1 	=> ConfigBits(264 + 0),
		S2 	=> ConfigBits(264 + 1),
		S3 	=> ConfigBits(264 + 2),
		S4 	=> ConfigBits(264 + 3),
		O  	=> JE2BEG0 );

-- switch matrix multiplexer  JE2BEG1 		MUX-16
JE2BEG1_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S2END2 & E6END0 & E2END2 & N4END2 & N2END2 & N1END0 after 80 ps;
inst_MUX16PTv2_JE2BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG1_input(0),
		IN2 	=> JE2BEG1_input(1),
		IN3 	=> JE2BEG1_input(2),
		IN4 	=> JE2BEG1_input(3),
		IN5 	=> JE2BEG1_input(4),
		IN6 	=> JE2BEG1_input(5),
		IN7 	=> JE2BEG1_input(6),
		IN8 	=> JE2BEG1_input(7),
		IN9 	=> JE2BEG1_input(8),
		IN10 	=> JE2BEG1_input(9),
		IN11 	=> JE2BEG1_input(10),
		IN12 	=> JE2BEG1_input(11),
		IN13 	=> JE2BEG1_input(12),
		IN14 	=> JE2BEG1_input(13),
		IN15 	=> JE2BEG1_input(14),
		IN16 	=> JE2BEG1_input(15),
		S1 	=> ConfigBits(268 + 0),
		S2 	=> ConfigBits(268 + 1),
		S3 	=> ConfigBits(268 + 2),
		S4 	=> ConfigBits(268 + 3),
		O  	=> JE2BEG1 );

-- switch matrix multiplexer  JE2BEG2 		MUX-16
JE2BEG2_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S2END3 & E6END1 & E2END3 & N4END3 & N2END3 & N1END1 after 80 ps;
inst_MUX16PTv2_JE2BEG2 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG2_input(0),
		IN2 	=> JE2BEG2_input(1),
		IN3 	=> JE2BEG2_input(2),
		IN4 	=> JE2BEG2_input(3),
		IN5 	=> JE2BEG2_input(4),
		IN6 	=> JE2BEG2_input(5),
		IN7 	=> JE2BEG2_input(6),
		IN8 	=> JE2BEG2_input(7),
		IN9 	=> JE2BEG2_input(8),
		IN10 	=> JE2BEG2_input(9),
		IN11 	=> JE2BEG2_input(10),
		IN12 	=> JE2BEG2_input(11),
		IN13 	=> JE2BEG2_input(12),
		IN14 	=> JE2BEG2_input(13),
		IN15 	=> JE2BEG2_input(14),
		IN16 	=> JE2BEG2_input(15),
		S1 	=> ConfigBits(272 + 0),
		S2 	=> ConfigBits(272 + 1),
		S3 	=> ConfigBits(272 + 2),
		S4 	=> ConfigBits(272 + 3),
		O  	=> JE2BEG2 );

-- switch matrix multiplexer  JE2BEG3 		MUX-16
JE2BEG3_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S2END4 & E6END0 & E2END4 & N4END0 & N2END4 & N1END2 after 80 ps;
inst_MUX16PTv2_JE2BEG3 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG3_input(0),
		IN2 	=> JE2BEG3_input(1),
		IN3 	=> JE2BEG3_input(2),
		IN4 	=> JE2BEG3_input(3),
		IN5 	=> JE2BEG3_input(4),
		IN6 	=> JE2BEG3_input(5),
		IN7 	=> JE2BEG3_input(6),
		IN8 	=> JE2BEG3_input(7),
		IN9 	=> JE2BEG3_input(8),
		IN10 	=> JE2BEG3_input(9),
		IN11 	=> JE2BEG3_input(10),
		IN12 	=> JE2BEG3_input(11),
		IN13 	=> JE2BEG3_input(12),
		IN14 	=> JE2BEG3_input(13),
		IN15 	=> JE2BEG3_input(14),
		IN16 	=> JE2BEG3_input(15),
		S1 	=> ConfigBits(276 + 0),
		S2 	=> ConfigBits(276 + 1),
		S3 	=> ConfigBits(276 + 2),
		S4 	=> ConfigBits(276 + 3),
		O  	=> JE2BEG3 );

-- switch matrix multiplexer  JE2BEG4 		MUX-16
JE2BEG4_input 	 <= M_EF & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END1 & S2END5 & S1END3 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1 after 80 ps;
inst_MUX16PTv2_JE2BEG4 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG4_input(0),
		IN2 	=> JE2BEG4_input(1),
		IN3 	=> JE2BEG4_input(2),
		IN4 	=> JE2BEG4_input(3),
		IN5 	=> JE2BEG4_input(4),
		IN6 	=> JE2BEG4_input(5),
		IN7 	=> JE2BEG4_input(6),
		IN8 	=> JE2BEG4_input(7),
		IN9 	=> JE2BEG4_input(8),
		IN10 	=> JE2BEG4_input(9),
		IN11 	=> JE2BEG4_input(10),
		IN12 	=> JE2BEG4_input(11),
		IN13 	=> JE2BEG4_input(12),
		IN14 	=> JE2BEG4_input(13),
		IN15 	=> JE2BEG4_input(14),
		IN16 	=> JE2BEG4_input(15),
		S1 	=> ConfigBits(280 + 0),
		S2 	=> ConfigBits(280 + 1),
		S3 	=> ConfigBits(280 + 2),
		S4 	=> ConfigBits(280 + 3),
		O  	=> JE2BEG4 );

-- switch matrix multiplexer  JE2BEG5 		MUX-16
JE2BEG5_input 	 <= M_AB & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & S2END6 & S1END2 & S1END0 & E2END6 & E1END2 & N2END6 & N1END2 after 80 ps;
inst_MUX16PTv2_JE2BEG5 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG5_input(0),
		IN2 	=> JE2BEG5_input(1),
		IN3 	=> JE2BEG5_input(2),
		IN4 	=> JE2BEG5_input(3),
		IN5 	=> JE2BEG5_input(4),
		IN6 	=> JE2BEG5_input(5),
		IN7 	=> JE2BEG5_input(6),
		IN8 	=> JE2BEG5_input(7),
		IN9 	=> JE2BEG5_input(8),
		IN10 	=> JE2BEG5_input(9),
		IN11 	=> JE2BEG5_input(10),
		IN12 	=> JE2BEG5_input(11),
		IN13 	=> JE2BEG5_input(12),
		IN14 	=> JE2BEG5_input(13),
		IN15 	=> JE2BEG5_input(14),
		IN16 	=> JE2BEG5_input(15),
		S1 	=> ConfigBits(284 + 0),
		S2 	=> ConfigBits(284 + 1),
		S3 	=> ConfigBits(284 + 2),
		S4 	=> ConfigBits(284 + 3),
		O  	=> JE2BEG5 );

-- switch matrix multiplexer  JE2BEG6 		MUX-16
JE2BEG6_input 	 <= M_AD & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & S2END7 & S1END3 & S1END1 & E2END7 & E1END3 & N2END7 & N1END3 after 80 ps;
inst_MUX16PTv2_JE2BEG6 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG6_input(0),
		IN2 	=> JE2BEG6_input(1),
		IN3 	=> JE2BEG6_input(2),
		IN4 	=> JE2BEG6_input(3),
		IN5 	=> JE2BEG6_input(4),
		IN6 	=> JE2BEG6_input(5),
		IN7 	=> JE2BEG6_input(6),
		IN8 	=> JE2BEG6_input(7),
		IN9 	=> JE2BEG6_input(8),
		IN10 	=> JE2BEG6_input(9),
		IN11 	=> JE2BEG6_input(10),
		IN12 	=> JE2BEG6_input(11),
		IN13 	=> JE2BEG6_input(12),
		IN14 	=> JE2BEG6_input(13),
		IN15 	=> JE2BEG6_input(14),
		IN16 	=> JE2BEG6_input(15),
		S1 	=> ConfigBits(288 + 0),
		S2 	=> ConfigBits(288 + 1),
		S3 	=> ConfigBits(288 + 2),
		S4 	=> ConfigBits(288 + 3),
		O  	=> JE2BEG6 );

-- switch matrix multiplexer  JE2BEG7 		MUX-16
JE2BEG7_input 	 <= M_AH & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END0 & S2END0 & S1END2 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0 after 80 ps;
inst_MUX16PTv2_JE2BEG7 : MUX16PTv2
	 Port Map(
		IN1 	=> JE2BEG7_input(0),
		IN2 	=> JE2BEG7_input(1),
		IN3 	=> JE2BEG7_input(2),
		IN4 	=> JE2BEG7_input(3),
		IN5 	=> JE2BEG7_input(4),
		IN6 	=> JE2BEG7_input(5),
		IN7 	=> JE2BEG7_input(6),
		IN8 	=> JE2BEG7_input(7),
		IN9 	=> JE2BEG7_input(8),
		IN10 	=> JE2BEG7_input(9),
		IN11 	=> JE2BEG7_input(10),
		IN12 	=> JE2BEG7_input(11),
		IN13 	=> JE2BEG7_input(12),
		IN14 	=> JE2BEG7_input(13),
		IN15 	=> JE2BEG7_input(14),
		IN16 	=> JE2BEG7_input(15),
		S1 	=> ConfigBits(292 + 0),
		S2 	=> ConfigBits(292 + 1),
		S3 	=> ConfigBits(292 + 2),
		S4 	=> ConfigBits(292 + 3),
		O  	=> JE2BEG7 );

-- switch matrix multiplexer  JS2BEG0 		MUX-16
JS2BEG0_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S4END1 & S2END1 & E6END1 & E2END1 & E1END3 & N2END1 after 80 ps;
inst_MUX16PTv2_JS2BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG0_input(0),
		IN2 	=> JS2BEG0_input(1),
		IN3 	=> JS2BEG0_input(2),
		IN4 	=> JS2BEG0_input(3),
		IN5 	=> JS2BEG0_input(4),
		IN6 	=> JS2BEG0_input(5),
		IN7 	=> JS2BEG0_input(6),
		IN8 	=> JS2BEG0_input(7),
		IN9 	=> JS2BEG0_input(8),
		IN10 	=> JS2BEG0_input(9),
		IN11 	=> JS2BEG0_input(10),
		IN12 	=> JS2BEG0_input(11),
		IN13 	=> JS2BEG0_input(12),
		IN14 	=> JS2BEG0_input(13),
		IN15 	=> JS2BEG0_input(14),
		IN16 	=> JS2BEG0_input(15),
		S1 	=> ConfigBits(296 + 0),
		S2 	=> ConfigBits(296 + 1),
		S3 	=> ConfigBits(296 + 2),
		S4 	=> ConfigBits(296 + 3),
		O  	=> JS2BEG0 );

-- switch matrix multiplexer  JS2BEG1 		MUX-16
JS2BEG1_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S4END2 & S2END2 & E6END0 & E2END2 & E1END0 & N2END2 after 80 ps;
inst_MUX16PTv2_JS2BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG1_input(0),
		IN2 	=> JS2BEG1_input(1),
		IN3 	=> JS2BEG1_input(2),
		IN4 	=> JS2BEG1_input(3),
		IN5 	=> JS2BEG1_input(4),
		IN6 	=> JS2BEG1_input(5),
		IN7 	=> JS2BEG1_input(6),
		IN8 	=> JS2BEG1_input(7),
		IN9 	=> JS2BEG1_input(8),
		IN10 	=> JS2BEG1_input(9),
		IN11 	=> JS2BEG1_input(10),
		IN12 	=> JS2BEG1_input(11),
		IN13 	=> JS2BEG1_input(12),
		IN14 	=> JS2BEG1_input(13),
		IN15 	=> JS2BEG1_input(14),
		IN16 	=> JS2BEG1_input(15),
		S1 	=> ConfigBits(300 + 0),
		S2 	=> ConfigBits(300 + 1),
		S3 	=> ConfigBits(300 + 2),
		S4 	=> ConfigBits(300 + 3),
		O  	=> JS2BEG1 );

-- switch matrix multiplexer  JS2BEG2 		MUX-16
JS2BEG2_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S4END3 & S2END3 & E6END1 & E2END3 & E1END1 & N2END3 after 80 ps;
inst_MUX16PTv2_JS2BEG2 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG2_input(0),
		IN2 	=> JS2BEG2_input(1),
		IN3 	=> JS2BEG2_input(2),
		IN4 	=> JS2BEG2_input(3),
		IN5 	=> JS2BEG2_input(4),
		IN6 	=> JS2BEG2_input(5),
		IN7 	=> JS2BEG2_input(6),
		IN8 	=> JS2BEG2_input(7),
		IN9 	=> JS2BEG2_input(8),
		IN10 	=> JS2BEG2_input(9),
		IN11 	=> JS2BEG2_input(10),
		IN12 	=> JS2BEG2_input(11),
		IN13 	=> JS2BEG2_input(12),
		IN14 	=> JS2BEG2_input(13),
		IN15 	=> JS2BEG2_input(14),
		IN16 	=> JS2BEG2_input(15),
		S1 	=> ConfigBits(304 + 0),
		S2 	=> ConfigBits(304 + 1),
		S3 	=> ConfigBits(304 + 2),
		S4 	=> ConfigBits(304 + 3),
		O  	=> JS2BEG2 );

-- switch matrix multiplexer  JS2BEG3 		MUX-16
JS2BEG3_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S4END0 & S2END4 & E6END0 & E2END4 & E1END2 & N2END4 after 80 ps;
inst_MUX16PTv2_JS2BEG3 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG3_input(0),
		IN2 	=> JS2BEG3_input(1),
		IN3 	=> JS2BEG3_input(2),
		IN4 	=> JS2BEG3_input(3),
		IN5 	=> JS2BEG3_input(4),
		IN6 	=> JS2BEG3_input(5),
		IN7 	=> JS2BEG3_input(6),
		IN8 	=> JS2BEG3_input(7),
		IN9 	=> JS2BEG3_input(8),
		IN10 	=> JS2BEG3_input(9),
		IN11 	=> JS2BEG3_input(10),
		IN12 	=> JS2BEG3_input(11),
		IN13 	=> JS2BEG3_input(12),
		IN14 	=> JS2BEG3_input(13),
		IN15 	=> JS2BEG3_input(14),
		IN16 	=> JS2BEG3_input(15),
		S1 	=> ConfigBits(308 + 0),
		S2 	=> ConfigBits(308 + 1),
		S3 	=> ConfigBits(308 + 2),
		S4 	=> ConfigBits(308 + 3),
		O  	=> JS2BEG3 );

-- switch matrix multiplexer  JS2BEG4 		MUX-16
JS2BEG4_input 	 <= M_AH & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END5 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1 after 80 ps;
inst_MUX16PTv2_JS2BEG4 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG4_input(0),
		IN2 	=> JS2BEG4_input(1),
		IN3 	=> JS2BEG4_input(2),
		IN4 	=> JS2BEG4_input(3),
		IN5 	=> JS2BEG4_input(4),
		IN6 	=> JS2BEG4_input(5),
		IN7 	=> JS2BEG4_input(6),
		IN8 	=> JS2BEG4_input(7),
		IN9 	=> JS2BEG4_input(8),
		IN10 	=> JS2BEG4_input(9),
		IN11 	=> JS2BEG4_input(10),
		IN12 	=> JS2BEG4_input(11),
		IN13 	=> JS2BEG4_input(12),
		IN14 	=> JS2BEG4_input(13),
		IN15 	=> JS2BEG4_input(14),
		IN16 	=> JS2BEG4_input(15),
		S1 	=> ConfigBits(312 + 0),
		S2 	=> ConfigBits(312 + 1),
		S3 	=> ConfigBits(312 + 2),
		S4 	=> ConfigBits(312 + 3),
		O  	=> JS2BEG4 );

-- switch matrix multiplexer  JS2BEG5 		MUX-16
JS2BEG5_input 	 <= M_EF & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END6 & S1END2 & E2END6 & E1END2 & N2END6 & N1END2 after 80 ps;
inst_MUX16PTv2_JS2BEG5 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG5_input(0),
		IN2 	=> JS2BEG5_input(1),
		IN3 	=> JS2BEG5_input(2),
		IN4 	=> JS2BEG5_input(3),
		IN5 	=> JS2BEG5_input(4),
		IN6 	=> JS2BEG5_input(5),
		IN7 	=> JS2BEG5_input(6),
		IN8 	=> JS2BEG5_input(7),
		IN9 	=> JS2BEG5_input(8),
		IN10 	=> JS2BEG5_input(9),
		IN11 	=> JS2BEG5_input(10),
		IN12 	=> JS2BEG5_input(11),
		IN13 	=> JS2BEG5_input(12),
		IN14 	=> JS2BEG5_input(13),
		IN15 	=> JS2BEG5_input(14),
		IN16 	=> JS2BEG5_input(15),
		S1 	=> ConfigBits(316 + 0),
		S2 	=> ConfigBits(316 + 1),
		S3 	=> ConfigBits(316 + 2),
		S4 	=> ConfigBits(316 + 3),
		O  	=> JS2BEG5 );

-- switch matrix multiplexer  JS2BEG6 		MUX-16
JS2BEG6_input 	 <= M_AB & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & W1END1 & S2END7 & S1END3 & E2END7 & E1END3 & N2END7 & N1END3 after 80 ps;
inst_MUX16PTv2_JS2BEG6 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG6_input(0),
		IN2 	=> JS2BEG6_input(1),
		IN3 	=> JS2BEG6_input(2),
		IN4 	=> JS2BEG6_input(3),
		IN5 	=> JS2BEG6_input(4),
		IN6 	=> JS2BEG6_input(5),
		IN7 	=> JS2BEG6_input(6),
		IN8 	=> JS2BEG6_input(7),
		IN9 	=> JS2BEG6_input(8),
		IN10 	=> JS2BEG6_input(9),
		IN11 	=> JS2BEG6_input(10),
		IN12 	=> JS2BEG6_input(11),
		IN13 	=> JS2BEG6_input(12),
		IN14 	=> JS2BEG6_input(13),
		IN15 	=> JS2BEG6_input(14),
		IN16 	=> JS2BEG6_input(15),
		S1 	=> ConfigBits(320 + 0),
		S2 	=> ConfigBits(320 + 1),
		S3 	=> ConfigBits(320 + 2),
		S4 	=> ConfigBits(320 + 3),
		O  	=> JS2BEG6 );

-- switch matrix multiplexer  JS2BEG7 		MUX-16
JS2BEG7_input 	 <= M_AD & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & W1END0 & S2END0 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0 after 80 ps;
inst_MUX16PTv2_JS2BEG7 : MUX16PTv2
	 Port Map(
		IN1 	=> JS2BEG7_input(0),
		IN2 	=> JS2BEG7_input(1),
		IN3 	=> JS2BEG7_input(2),
		IN4 	=> JS2BEG7_input(3),
		IN5 	=> JS2BEG7_input(4),
		IN6 	=> JS2BEG7_input(5),
		IN7 	=> JS2BEG7_input(6),
		IN8 	=> JS2BEG7_input(7),
		IN9 	=> JS2BEG7_input(8),
		IN10 	=> JS2BEG7_input(9),
		IN11 	=> JS2BEG7_input(10),
		IN12 	=> JS2BEG7_input(11),
		IN13 	=> JS2BEG7_input(12),
		IN14 	=> JS2BEG7_input(13),
		IN15 	=> JS2BEG7_input(14),
		IN16 	=> JS2BEG7_input(15),
		S1 	=> ConfigBits(324 + 0),
		S2 	=> ConfigBits(324 + 1),
		S3 	=> ConfigBits(324 + 2),
		S4 	=> ConfigBits(324 + 3),
		O  	=> JS2BEG7 );

-- switch matrix multiplexer  JW2BEG0 		MUX-16
JW2BEG0_input 	 <= M_AD & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & W6END1 & W2END1 & S4END1 & S2END1 & E6END1 & E2END1 & N2END1 & N1END3 after 80 ps;
inst_MUX16PTv2_JW2BEG0 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG0_input(0),
		IN2 	=> JW2BEG0_input(1),
		IN3 	=> JW2BEG0_input(2),
		IN4 	=> JW2BEG0_input(3),
		IN5 	=> JW2BEG0_input(4),
		IN6 	=> JW2BEG0_input(5),
		IN7 	=> JW2BEG0_input(6),
		IN8 	=> JW2BEG0_input(7),
		IN9 	=> JW2BEG0_input(8),
		IN10 	=> JW2BEG0_input(9),
		IN11 	=> JW2BEG0_input(10),
		IN12 	=> JW2BEG0_input(11),
		IN13 	=> JW2BEG0_input(12),
		IN14 	=> JW2BEG0_input(13),
		IN15 	=> JW2BEG0_input(14),
		IN16 	=> JW2BEG0_input(15),
		S1 	=> ConfigBits(328 + 0),
		S2 	=> ConfigBits(328 + 1),
		S3 	=> ConfigBits(328 + 2),
		S4 	=> ConfigBits(328 + 3),
		O  	=> JW2BEG0 );

-- switch matrix multiplexer  JW2BEG1 		MUX-16
JW2BEG1_input 	 <= M_AH & LH_O & LG_O & LF_O & LE_O & LD_O & LC_O & LA_O & W6END0 & W2END2 & S4END2 & S2END2 & E6END0 & E2END2 & N2END2 & N1END0 after 80 ps;
inst_MUX16PTv2_JW2BEG1 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG1_input(0),
		IN2 	=> JW2BEG1_input(1),
		IN3 	=> JW2BEG1_input(2),
		IN4 	=> JW2BEG1_input(3),
		IN5 	=> JW2BEG1_input(4),
		IN6 	=> JW2BEG1_input(5),
		IN7 	=> JW2BEG1_input(6),
		IN8 	=> JW2BEG1_input(7),
		IN9 	=> JW2BEG1_input(8),
		IN10 	=> JW2BEG1_input(9),
		IN11 	=> JW2BEG1_input(10),
		IN12 	=> JW2BEG1_input(11),
		IN13 	=> JW2BEG1_input(12),
		IN14 	=> JW2BEG1_input(13),
		IN15 	=> JW2BEG1_input(14),
		IN16 	=> JW2BEG1_input(15),
		S1 	=> ConfigBits(332 + 0),
		S2 	=> ConfigBits(332 + 1),
		S3 	=> ConfigBits(332 + 2),
		S4 	=> ConfigBits(332 + 3),
		O  	=> JW2BEG1 );

-- switch matrix multiplexer  JW2BEG2 		MUX-16
JW2BEG2_input 	 <= M_EF & LH_O & LG_O & LF_O & LE_O & LD_O & LB_O & LA_O & W6END1 & W2END3 & S4END3 & S2END3 & E6END1 & E2END3 & N2END3 & N1END1 after 80 ps;
inst_MUX16PTv2_JW2BEG2 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG2_input(0),
		IN2 	=> JW2BEG2_input(1),
		IN3 	=> JW2BEG2_input(2),
		IN4 	=> JW2BEG2_input(3),
		IN5 	=> JW2BEG2_input(4),
		IN6 	=> JW2BEG2_input(5),
		IN7 	=> JW2BEG2_input(6),
		IN8 	=> JW2BEG2_input(7),
		IN9 	=> JW2BEG2_input(8),
		IN10 	=> JW2BEG2_input(9),
		IN11 	=> JW2BEG2_input(10),
		IN12 	=> JW2BEG2_input(11),
		IN13 	=> JW2BEG2_input(12),
		IN14 	=> JW2BEG2_input(13),
		IN15 	=> JW2BEG2_input(14),
		IN16 	=> JW2BEG2_input(15),
		S1 	=> ConfigBits(336 + 0),
		S2 	=> ConfigBits(336 + 1),
		S3 	=> ConfigBits(336 + 2),
		S4 	=> ConfigBits(336 + 3),
		O  	=> JW2BEG2 );

-- switch matrix multiplexer  JW2BEG3 		MUX-16
JW2BEG3_input 	 <= M_AB & LH_O & LG_O & LF_O & LE_O & LC_O & LB_O & LA_O & W6END0 & W2END4 & S4END0 & S2END4 & E6END0 & E2END4 & N2END4 & N1END2 after 80 ps;
inst_MUX16PTv2_JW2BEG3 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG3_input(0),
		IN2 	=> JW2BEG3_input(1),
		IN3 	=> JW2BEG3_input(2),
		IN4 	=> JW2BEG3_input(3),
		IN5 	=> JW2BEG3_input(4),
		IN6 	=> JW2BEG3_input(5),
		IN7 	=> JW2BEG3_input(6),
		IN8 	=> JW2BEG3_input(7),
		IN9 	=> JW2BEG3_input(8),
		IN10 	=> JW2BEG3_input(9),
		IN11 	=> JW2BEG3_input(10),
		IN12 	=> JW2BEG3_input(11),
		IN13 	=> JW2BEG3_input(12),
		IN14 	=> JW2BEG3_input(13),
		IN15 	=> JW2BEG3_input(14),
		IN16 	=> JW2BEG3_input(15),
		S1 	=> ConfigBits(340 + 0),
		S2 	=> ConfigBits(340 + 1),
		S3 	=> ConfigBits(340 + 2),
		S4 	=> ConfigBits(340 + 3),
		O  	=> JW2BEG3 );

-- switch matrix multiplexer  JW2BEG4 		MUX-16
JW2BEG4_input 	 <= M_AD & LH_O & LG_O & LF_O & LD_O & LC_O & LB_O & LA_O & W1END1 & S2END5 & S1END3 & S1END1 & E2END5 & E1END1 & N2END5 & N1END1 after 80 ps;
inst_MUX16PTv2_JW2BEG4 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG4_input(0),
		IN2 	=> JW2BEG4_input(1),
		IN3 	=> JW2BEG4_input(2),
		IN4 	=> JW2BEG4_input(3),
		IN5 	=> JW2BEG4_input(4),
		IN6 	=> JW2BEG4_input(5),
		IN7 	=> JW2BEG4_input(6),
		IN8 	=> JW2BEG4_input(7),
		IN9 	=> JW2BEG4_input(8),
		IN10 	=> JW2BEG4_input(9),
		IN11 	=> JW2BEG4_input(10),
		IN12 	=> JW2BEG4_input(11),
		IN13 	=> JW2BEG4_input(12),
		IN14 	=> JW2BEG4_input(13),
		IN15 	=> JW2BEG4_input(14),
		IN16 	=> JW2BEG4_input(15),
		S1 	=> ConfigBits(344 + 0),
		S2 	=> ConfigBits(344 + 1),
		S3 	=> ConfigBits(344 + 2),
		S4 	=> ConfigBits(344 + 3),
		O  	=> JW2BEG4 );

-- switch matrix multiplexer  JW2BEG5 		MUX-16
JW2BEG5_input 	 <= M_AH & LH_O & LG_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END2 & S2END6 & S1END2 & S1END0 & E2END6 & E1END2 & N2END6 & N1END2 after 80 ps;
inst_MUX16PTv2_JW2BEG5 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG5_input(0),
		IN2 	=> JW2BEG5_input(1),
		IN3 	=> JW2BEG5_input(2),
		IN4 	=> JW2BEG5_input(3),
		IN5 	=> JW2BEG5_input(4),
		IN6 	=> JW2BEG5_input(5),
		IN7 	=> JW2BEG5_input(6),
		IN8 	=> JW2BEG5_input(7),
		IN9 	=> JW2BEG5_input(8),
		IN10 	=> JW2BEG5_input(9),
		IN11 	=> JW2BEG5_input(10),
		IN12 	=> JW2BEG5_input(11),
		IN13 	=> JW2BEG5_input(12),
		IN14 	=> JW2BEG5_input(13),
		IN15 	=> JW2BEG5_input(14),
		IN16 	=> JW2BEG5_input(15),
		S1 	=> ConfigBits(348 + 0),
		S2 	=> ConfigBits(348 + 1),
		S3 	=> ConfigBits(348 + 2),
		S4 	=> ConfigBits(348 + 3),
		O  	=> JW2BEG5 );

-- switch matrix multiplexer  JW2BEG6 		MUX-16
JW2BEG6_input 	 <= M_EF & LH_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END3 & S2END7 & S1END3 & S1END1 & E2END7 & E1END3 & N2END7 & N1END3 after 80 ps;
inst_MUX16PTv2_JW2BEG6 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG6_input(0),
		IN2 	=> JW2BEG6_input(1),
		IN3 	=> JW2BEG6_input(2),
		IN4 	=> JW2BEG6_input(3),
		IN5 	=> JW2BEG6_input(4),
		IN6 	=> JW2BEG6_input(5),
		IN7 	=> JW2BEG6_input(6),
		IN8 	=> JW2BEG6_input(7),
		IN9 	=> JW2BEG6_input(8),
		IN10 	=> JW2BEG6_input(9),
		IN11 	=> JW2BEG6_input(10),
		IN12 	=> JW2BEG6_input(11),
		IN13 	=> JW2BEG6_input(12),
		IN14 	=> JW2BEG6_input(13),
		IN15 	=> JW2BEG6_input(14),
		IN16 	=> JW2BEG6_input(15),
		S1 	=> ConfigBits(352 + 0),
		S2 	=> ConfigBits(352 + 1),
		S3 	=> ConfigBits(352 + 2),
		S4 	=> ConfigBits(352 + 3),
		O  	=> JW2BEG6 );

-- switch matrix multiplexer  JW2BEG7 		MUX-16
JW2BEG7_input 	 <= M_AB & LG_O & LF_O & LE_O & LD_O & LC_O & LB_O & LA_O & W1END0 & S2END0 & S1END2 & S1END0 & E2END0 & E1END0 & N2END0 & N1END0 after 80 ps;
inst_MUX16PTv2_JW2BEG7 : MUX16PTv2
	 Port Map(
		IN1 	=> JW2BEG7_input(0),
		IN2 	=> JW2BEG7_input(1),
		IN3 	=> JW2BEG7_input(2),
		IN4 	=> JW2BEG7_input(3),
		IN5 	=> JW2BEG7_input(4),
		IN6 	=> JW2BEG7_input(5),
		IN7 	=> JW2BEG7_input(6),
		IN8 	=> JW2BEG7_input(7),
		IN9 	=> JW2BEG7_input(8),
		IN10 	=> JW2BEG7_input(9),
		IN11 	=> JW2BEG7_input(10),
		IN12 	=> JW2BEG7_input(11),
		IN13 	=> JW2BEG7_input(12),
		IN14 	=> JW2BEG7_input(13),
		IN15 	=> JW2BEG7_input(14),
		IN16 	=> JW2BEG7_input(15),
		S1 	=> ConfigBits(356 + 0),
		S2 	=> ConfigBits(356 + 1),
		S3 	=> ConfigBits(356 + 2),
		S4 	=> ConfigBits(356 + 3),
		O  	=> JW2BEG7 );

-- switch matrix multiplexer  J_l_AB_BEG0 		MUX-4
J_l_AB_BEG0_input 	 <= JN2END1 & W2END3 & S4END3 & N4END3 after 80 ps;
inst_MUX4PTv4_J_l_AB_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_AB_BEG0_input(0),
		IN2 	=> J_l_AB_BEG0_input(1),
		IN3 	=> J_l_AB_BEG0_input(2),
		IN4 	=> J_l_AB_BEG0_input(3),
		S1 	=> ConfigBits(360 + 0),
		S2 	=> ConfigBits(360 + 1),
		O  	=> J_l_AB_BEG0 );

-- switch matrix multiplexer  J_l_AB_BEG1 		MUX-4
J_l_AB_BEG1_input 	 <= JE2END1 & W2END7 & S4END2 & E2END2 after 80 ps;
inst_MUX4PTv4_J_l_AB_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_AB_BEG1_input(0),
		IN2 	=> J_l_AB_BEG1_input(1),
		IN3 	=> J_l_AB_BEG1_input(2),
		IN4 	=> J_l_AB_BEG1_input(3),
		S1 	=> ConfigBits(362 + 0),
		S2 	=> ConfigBits(362 + 1),
		O  	=> J_l_AB_BEG1 );

-- switch matrix multiplexer  J_l_AB_BEG2 		MUX-4
J_l_AB_BEG2_input 	 <= JS2END1 & W6END1 & E6END1 & N4END1 after 80 ps;
inst_MUX4PTv4_J_l_AB_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_AB_BEG2_input(0),
		IN2 	=> J_l_AB_BEG2_input(1),
		IN3 	=> J_l_AB_BEG2_input(2),
		IN4 	=> J_l_AB_BEG2_input(3),
		S1 	=> ConfigBits(364 + 0),
		S2 	=> ConfigBits(364 + 1),
		O  	=> J_l_AB_BEG2 );

-- switch matrix multiplexer  J_l_AB_BEG3 		MUX-4
J_l_AB_BEG3_input 	 <= JW2END1 & S4END0 & E6END0 & N4END0 after 80 ps;
inst_MUX4PTv4_J_l_AB_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_AB_BEG3_input(0),
		IN2 	=> J_l_AB_BEG3_input(1),
		IN3 	=> J_l_AB_BEG3_input(2),
		IN4 	=> J_l_AB_BEG3_input(3),
		S1 	=> ConfigBits(366 + 0),
		S2 	=> ConfigBits(366 + 1),
		O  	=> J_l_AB_BEG3 );

-- switch matrix multiplexer  J_l_CD_BEG0 		MUX-4
J_l_CD_BEG0_input 	 <= JN2END2 & W2END3 & S4END3 & E2END3 after 80 ps;
inst_MUX4PTv4_J_l_CD_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_CD_BEG0_input(0),
		IN2 	=> J_l_CD_BEG0_input(1),
		IN3 	=> J_l_CD_BEG0_input(2),
		IN4 	=> J_l_CD_BEG0_input(3),
		S1 	=> ConfigBits(368 + 0),
		S2 	=> ConfigBits(368 + 1),
		O  	=> J_l_CD_BEG0 );

-- switch matrix multiplexer  J_l_CD_BEG1 		MUX-4
J_l_CD_BEG1_input 	 <= JE2END2 & W2END7 & E2END2 & N4END2 after 80 ps;
inst_MUX4PTv4_J_l_CD_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_CD_BEG1_input(0),
		IN2 	=> J_l_CD_BEG1_input(1),
		IN3 	=> J_l_CD_BEG1_input(2),
		IN4 	=> J_l_CD_BEG1_input(3),
		S1 	=> ConfigBits(370 + 0),
		S2 	=> ConfigBits(370 + 1),
		O  	=> J_l_CD_BEG1 );

-- switch matrix multiplexer  J_l_CD_BEG2 		MUX-4
J_l_CD_BEG2_input 	 <= JS2END2 & S4END1 & E6END1 & N4END1 after 80 ps;
inst_MUX4PTv4_J_l_CD_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_CD_BEG2_input(0),
		IN2 	=> J_l_CD_BEG2_input(1),
		IN3 	=> J_l_CD_BEG2_input(2),
		IN4 	=> J_l_CD_BEG2_input(3),
		S1 	=> ConfigBits(372 + 0),
		S2 	=> ConfigBits(372 + 1),
		O  	=> J_l_CD_BEG2 );

-- switch matrix multiplexer  J_l_CD_BEG3 		MUX-4
J_l_CD_BEG3_input 	 <= JW2END2 & W6END0 & S4END0 & N4END0 after 80 ps;
inst_MUX4PTv4_J_l_CD_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_CD_BEG3_input(0),
		IN2 	=> J_l_CD_BEG3_input(1),
		IN3 	=> J_l_CD_BEG3_input(2),
		IN4 	=> J_l_CD_BEG3_input(3),
		S1 	=> ConfigBits(374 + 0),
		S2 	=> ConfigBits(374 + 1),
		O  	=> J_l_CD_BEG3 );

-- switch matrix multiplexer  J_l_EF_BEG0 		MUX-4
J_l_EF_BEG0_input 	 <= JN2END3 & W2END3 & E2END3 & N4END3 after 80 ps;
inst_MUX4PTv4_J_l_EF_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_EF_BEG0_input(0),
		IN2 	=> J_l_EF_BEG0_input(1),
		IN3 	=> J_l_EF_BEG0_input(2),
		IN4 	=> J_l_EF_BEG0_input(3),
		S1 	=> ConfigBits(376 + 0),
		S2 	=> ConfigBits(376 + 1),
		O  	=> J_l_EF_BEG0 );

-- switch matrix multiplexer  J_l_EF_BEG1 		MUX-4
J_l_EF_BEG1_input 	 <= JE2END3 & S4END2 & E2END2 & N4END2 after 80 ps;
inst_MUX4PTv4_J_l_EF_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_EF_BEG1_input(0),
		IN2 	=> J_l_EF_BEG1_input(1),
		IN3 	=> J_l_EF_BEG1_input(2),
		IN4 	=> J_l_EF_BEG1_input(3),
		S1 	=> ConfigBits(378 + 0),
		S2 	=> ConfigBits(378 + 1),
		O  	=> J_l_EF_BEG1 );

-- switch matrix multiplexer  J_l_EF_BEG2 		MUX-4
J_l_EF_BEG2_input 	 <= JS2END3 & W2END4 & S4END1 & N4END1 after 80 ps;
inst_MUX4PTv4_J_l_EF_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_EF_BEG2_input(0),
		IN2 	=> J_l_EF_BEG2_input(1),
		IN3 	=> J_l_EF_BEG2_input(2),
		IN4 	=> J_l_EF_BEG2_input(3),
		S1 	=> ConfigBits(380 + 0),
		S2 	=> ConfigBits(380 + 1),
		O  	=> J_l_EF_BEG2 );

-- switch matrix multiplexer  J_l_EF_BEG3 		MUX-4
J_l_EF_BEG3_input 	 <= JW2END3 & W2END0 & S4END0 & E6END0 after 80 ps;
inst_MUX4PTv4_J_l_EF_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_EF_BEG3_input(0),
		IN2 	=> J_l_EF_BEG3_input(1),
		IN3 	=> J_l_EF_BEG3_input(2),
		IN4 	=> J_l_EF_BEG3_input(3),
		S1 	=> ConfigBits(382 + 0),
		S2 	=> ConfigBits(382 + 1),
		O  	=> J_l_EF_BEG3 );

-- switch matrix multiplexer  J_l_GH_BEG0 		MUX-4
J_l_GH_BEG0_input 	 <= JN2END4 & S4END3 & E2END3 & N4END3 after 80 ps;
inst_MUX4PTv4_J_l_GH_BEG0 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_GH_BEG0_input(0),
		IN2 	=> J_l_GH_BEG0_input(1),
		IN3 	=> J_l_GH_BEG0_input(2),
		IN4 	=> J_l_GH_BEG0_input(3),
		S1 	=> ConfigBits(384 + 0),
		S2 	=> ConfigBits(384 + 1),
		O  	=> J_l_GH_BEG0 );

-- switch matrix multiplexer  J_l_GH_BEG1 		MUX-4
J_l_GH_BEG1_input 	 <= JE2END4 & W2END2 & S4END2 & N4END2 after 80 ps;
inst_MUX4PTv4_J_l_GH_BEG1 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_GH_BEG1_input(0),
		IN2 	=> J_l_GH_BEG1_input(1),
		IN3 	=> J_l_GH_BEG1_input(2),
		IN4 	=> J_l_GH_BEG1_input(3),
		S1 	=> ConfigBits(386 + 0),
		S2 	=> ConfigBits(386 + 1),
		O  	=> J_l_GH_BEG1 );

-- switch matrix multiplexer  J_l_GH_BEG2 		MUX-4
J_l_GH_BEG2_input 	 <= JS2END4 & W2END4 & S4END1 & E6END1 after 80 ps;
inst_MUX4PTv4_J_l_GH_BEG2 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_GH_BEG2_input(0),
		IN2 	=> J_l_GH_BEG2_input(1),
		IN3 	=> J_l_GH_BEG2_input(2),
		IN4 	=> J_l_GH_BEG2_input(3),
		S1 	=> ConfigBits(388 + 0),
		S2 	=> ConfigBits(388 + 1),
		O  	=> J_l_GH_BEG2 );

-- switch matrix multiplexer  J_l_GH_BEG3 		MUX-4
J_l_GH_BEG3_input 	 <= JW2END4 & W2END0 & E6END0 & N4END0 after 80 ps;
inst_MUX4PTv4_J_l_GH_BEG3 : MUX4PTv4
	 Port Map(
		IN1 	=> J_l_GH_BEG3_input(0),
		IN2 	=> J_l_GH_BEG3_input(1),
		IN3 	=> J_l_GH_BEG3_input(2),
		IN4 	=> J_l_GH_BEG3_input(3),
		S1 	=> ConfigBits(390 + 0),
		S2 	=> ConfigBits(390 + 1),
		O  	=> J_l_GH_BEG3 );



DEBUG_select_N1BEG0	<= ConfigBits(1 downto 0);
DEBUG_select_N1BEG1	<= ConfigBits(3 downto 2);
DEBUG_select_N1BEG2	<= ConfigBits(5 downto 4);
DEBUG_select_N1BEG3	<= ConfigBits(7 downto 6);
DEBUG_select_N4BEG0	<= ConfigBits(9 downto 8);
DEBUG_select_N4BEG1	<= ConfigBits(11 downto 10);
DEBUG_select_N4BEG2	<= ConfigBits(13 downto 12);
DEBUG_select_N4BEG3	<= ConfigBits(15 downto 14);
DEBUG_select_E1BEG0	<= ConfigBits(17 downto 16);
DEBUG_select_E1BEG1	<= ConfigBits(19 downto 18);
DEBUG_select_E1BEG2	<= ConfigBits(21 downto 20);
DEBUG_select_E1BEG3	<= ConfigBits(23 downto 22);
DEBUG_select_E6BEG0	<= ConfigBits(27 downto 24);
DEBUG_select_E6BEG1	<= ConfigBits(31 downto 28);
DEBUG_select_S1BEG0	<= ConfigBits(33 downto 32);
DEBUG_select_S1BEG1	<= ConfigBits(35 downto 34);
DEBUG_select_S1BEG2	<= ConfigBits(37 downto 36);
DEBUG_select_S1BEG3	<= ConfigBits(39 downto 38);
DEBUG_select_S4BEG0	<= ConfigBits(41 downto 40);
DEBUG_select_S4BEG1	<= ConfigBits(43 downto 42);
DEBUG_select_S4BEG2	<= ConfigBits(45 downto 44);
DEBUG_select_S4BEG3	<= ConfigBits(47 downto 46);
DEBUG_select_W1BEG0	<= ConfigBits(49 downto 48);
DEBUG_select_W1BEG1	<= ConfigBits(51 downto 50);
DEBUG_select_W1BEG2	<= ConfigBits(53 downto 52);
DEBUG_select_W1BEG3	<= ConfigBits(55 downto 54);
DEBUG_select_W6BEG0	<= ConfigBits(59 downto 56);
DEBUG_select_W6BEG1	<= ConfigBits(63 downto 60);
DEBUG_select_LA_I0	<= ConfigBits(65 downto 64);
DEBUG_select_LA_I1	<= ConfigBits(67 downto 66);
DEBUG_select_LA_I2	<= ConfigBits(69 downto 68);
DEBUG_select_LA_I3	<= ConfigBits(71 downto 70);
DEBUG_select_LB_I0	<= ConfigBits(73 downto 72);
DEBUG_select_LB_I1	<= ConfigBits(75 downto 74);
DEBUG_select_LB_I2	<= ConfigBits(77 downto 76);
DEBUG_select_LB_I3	<= ConfigBits(79 downto 78);
DEBUG_select_LC_I0	<= ConfigBits(81 downto 80);
DEBUG_select_LC_I1	<= ConfigBits(83 downto 82);
DEBUG_select_LC_I2	<= ConfigBits(85 downto 84);
DEBUG_select_LC_I3	<= ConfigBits(87 downto 86);
DEBUG_select_LD_I0	<= ConfigBits(89 downto 88);
DEBUG_select_LD_I1	<= ConfigBits(91 downto 90);
DEBUG_select_LD_I2	<= ConfigBits(93 downto 92);
DEBUG_select_LD_I3	<= ConfigBits(95 downto 94);
DEBUG_select_LE_I0	<= ConfigBits(97 downto 96);
DEBUG_select_LE_I1	<= ConfigBits(99 downto 98);
DEBUG_select_LE_I2	<= ConfigBits(101 downto 100);
DEBUG_select_LE_I3	<= ConfigBits(103 downto 102);
DEBUG_select_LF_I0	<= ConfigBits(105 downto 104);
DEBUG_select_LF_I1	<= ConfigBits(107 downto 106);
DEBUG_select_LF_I2	<= ConfigBits(109 downto 108);
DEBUG_select_LF_I3	<= ConfigBits(111 downto 110);
DEBUG_select_LG_I0	<= ConfigBits(113 downto 112);
DEBUG_select_LG_I1	<= ConfigBits(115 downto 114);
DEBUG_select_LG_I2	<= ConfigBits(117 downto 116);
DEBUG_select_LG_I3	<= ConfigBits(119 downto 118);
DEBUG_select_LH_I0	<= ConfigBits(121 downto 120);
DEBUG_select_LH_I1	<= ConfigBits(123 downto 122);
DEBUG_select_LH_I2	<= ConfigBits(125 downto 124);
DEBUG_select_LH_I3	<= ConfigBits(127 downto 126);
DEBUG_select_S0	<= ConfigBits(129 downto 128);
DEBUG_select_S1	<= ConfigBits(131 downto 130);
DEBUG_select_S2	<= ConfigBits(133 downto 132);
DEBUG_select_S3	<= ConfigBits(135 downto 134);
DEBUG_select_J2MID_ABa_BEG0	<= ConfigBits(137 downto 136);
DEBUG_select_J2MID_ABa_BEG1	<= ConfigBits(139 downto 138);
DEBUG_select_J2MID_ABa_BEG2	<= ConfigBits(141 downto 140);
DEBUG_select_J2MID_ABa_BEG3	<= ConfigBits(143 downto 142);
DEBUG_select_J2MID_CDa_BEG0	<= ConfigBits(145 downto 144);
DEBUG_select_J2MID_CDa_BEG1	<= ConfigBits(147 downto 146);
DEBUG_select_J2MID_CDa_BEG2	<= ConfigBits(149 downto 148);
DEBUG_select_J2MID_CDa_BEG3	<= ConfigBits(151 downto 150);
DEBUG_select_J2MID_EFa_BEG0	<= ConfigBits(153 downto 152);
DEBUG_select_J2MID_EFa_BEG1	<= ConfigBits(155 downto 154);
DEBUG_select_J2MID_EFa_BEG2	<= ConfigBits(157 downto 156);
DEBUG_select_J2MID_EFa_BEG3	<= ConfigBits(159 downto 158);
DEBUG_select_J2MID_GHa_BEG0	<= ConfigBits(161 downto 160);
DEBUG_select_J2MID_GHa_BEG1	<= ConfigBits(163 downto 162);
DEBUG_select_J2MID_GHa_BEG2	<= ConfigBits(165 downto 164);
DEBUG_select_J2MID_GHa_BEG3	<= ConfigBits(167 downto 166);
DEBUG_select_J2MID_ABb_BEG0	<= ConfigBits(169 downto 168);
DEBUG_select_J2MID_ABb_BEG1	<= ConfigBits(171 downto 170);
DEBUG_select_J2MID_ABb_BEG2	<= ConfigBits(173 downto 172);
DEBUG_select_J2MID_ABb_BEG3	<= ConfigBits(175 downto 174);
DEBUG_select_J2MID_CDb_BEG0	<= ConfigBits(177 downto 176);
DEBUG_select_J2MID_CDb_BEG1	<= ConfigBits(179 downto 178);
DEBUG_select_J2MID_CDb_BEG2	<= ConfigBits(181 downto 180);
DEBUG_select_J2MID_CDb_BEG3	<= ConfigBits(183 downto 182);
DEBUG_select_J2MID_EFb_BEG0	<= ConfigBits(185 downto 184);
DEBUG_select_J2MID_EFb_BEG1	<= ConfigBits(187 downto 186);
DEBUG_select_J2MID_EFb_BEG2	<= ConfigBits(189 downto 188);
DEBUG_select_J2MID_EFb_BEG3	<= ConfigBits(191 downto 190);
DEBUG_select_J2MID_GHb_BEG0	<= ConfigBits(193 downto 192);
DEBUG_select_J2MID_GHb_BEG1	<= ConfigBits(195 downto 194);
DEBUG_select_J2MID_GHb_BEG2	<= ConfigBits(197 downto 196);
DEBUG_select_J2MID_GHb_BEG3	<= ConfigBits(199 downto 198);
DEBUG_select_J2END_AB_BEG0	<= ConfigBits(201 downto 200);
DEBUG_select_J2END_AB_BEG1	<= ConfigBits(203 downto 202);
DEBUG_select_J2END_AB_BEG2	<= ConfigBits(205 downto 204);
DEBUG_select_J2END_AB_BEG3	<= ConfigBits(207 downto 206);
DEBUG_select_J2END_CD_BEG0	<= ConfigBits(209 downto 208);
DEBUG_select_J2END_CD_BEG1	<= ConfigBits(211 downto 210);
DEBUG_select_J2END_CD_BEG2	<= ConfigBits(213 downto 212);
DEBUG_select_J2END_CD_BEG3	<= ConfigBits(215 downto 214);
DEBUG_select_J2END_EF_BEG0	<= ConfigBits(217 downto 216);
DEBUG_select_J2END_EF_BEG1	<= ConfigBits(219 downto 218);
DEBUG_select_J2END_EF_BEG2	<= ConfigBits(221 downto 220);
DEBUG_select_J2END_EF_BEG3	<= ConfigBits(223 downto 222);
DEBUG_select_J2END_GH_BEG0	<= ConfigBits(225 downto 224);
DEBUG_select_J2END_GH_BEG1	<= ConfigBits(227 downto 226);
DEBUG_select_J2END_GH_BEG2	<= ConfigBits(229 downto 228);
DEBUG_select_J2END_GH_BEG3	<= ConfigBits(231 downto 230);
DEBUG_select_JN2BEG0	<= ConfigBits(235 downto 232);
DEBUG_select_JN2BEG1	<= ConfigBits(239 downto 236);
DEBUG_select_JN2BEG2	<= ConfigBits(243 downto 240);
DEBUG_select_JN2BEG3	<= ConfigBits(247 downto 244);
DEBUG_select_JN2BEG4	<= ConfigBits(251 downto 248);
DEBUG_select_JN2BEG5	<= ConfigBits(255 downto 252);
DEBUG_select_JN2BEG6	<= ConfigBits(259 downto 256);
DEBUG_select_JN2BEG7	<= ConfigBits(263 downto 260);
DEBUG_select_JE2BEG0	<= ConfigBits(267 downto 264);
DEBUG_select_JE2BEG1	<= ConfigBits(271 downto 268);
DEBUG_select_JE2BEG2	<= ConfigBits(275 downto 272);
DEBUG_select_JE2BEG3	<= ConfigBits(279 downto 276);
DEBUG_select_JE2BEG4	<= ConfigBits(283 downto 280);
DEBUG_select_JE2BEG5	<= ConfigBits(287 downto 284);
DEBUG_select_JE2BEG6	<= ConfigBits(291 downto 288);
DEBUG_select_JE2BEG7	<= ConfigBits(295 downto 292);
DEBUG_select_JS2BEG0	<= ConfigBits(299 downto 296);
DEBUG_select_JS2BEG1	<= ConfigBits(303 downto 300);
DEBUG_select_JS2BEG2	<= ConfigBits(307 downto 304);
DEBUG_select_JS2BEG3	<= ConfigBits(311 downto 308);
DEBUG_select_JS2BEG4	<= ConfigBits(315 downto 312);
DEBUG_select_JS2BEG5	<= ConfigBits(319 downto 316);
DEBUG_select_JS2BEG6	<= ConfigBits(323 downto 320);
DEBUG_select_JS2BEG7	<= ConfigBits(327 downto 324);
DEBUG_select_JW2BEG0	<= ConfigBits(331 downto 328);
DEBUG_select_JW2BEG1	<= ConfigBits(335 downto 332);
DEBUG_select_JW2BEG2	<= ConfigBits(339 downto 336);
DEBUG_select_JW2BEG3	<= ConfigBits(343 downto 340);
DEBUG_select_JW2BEG4	<= ConfigBits(347 downto 344);
DEBUG_select_JW2BEG5	<= ConfigBits(351 downto 348);
DEBUG_select_JW2BEG6	<= ConfigBits(355 downto 352);
DEBUG_select_JW2BEG7	<= ConfigBits(359 downto 356);
DEBUG_select_J_l_AB_BEG0	<= ConfigBits(361 downto 360);
DEBUG_select_J_l_AB_BEG1	<= ConfigBits(363 downto 362);
DEBUG_select_J_l_AB_BEG2	<= ConfigBits(365 downto 364);
DEBUG_select_J_l_AB_BEG3	<= ConfigBits(367 downto 366);
DEBUG_select_J_l_CD_BEG0	<= ConfigBits(369 downto 368);
DEBUG_select_J_l_CD_BEG1	<= ConfigBits(371 downto 370);
DEBUG_select_J_l_CD_BEG2	<= ConfigBits(373 downto 372);
DEBUG_select_J_l_CD_BEG3	<= ConfigBits(375 downto 374);
DEBUG_select_J_l_EF_BEG0	<= ConfigBits(377 downto 376);
DEBUG_select_J_l_EF_BEG1	<= ConfigBits(379 downto 378);
DEBUG_select_J_l_EF_BEG2	<= ConfigBits(381 downto 380);
DEBUG_select_J_l_EF_BEG3	<= ConfigBits(383 downto 382);
DEBUG_select_J_l_GH_BEG0	<= ConfigBits(385 downto 384);
DEBUG_select_J_l_GH_BEG1	<= ConfigBits(387 downto 386);
DEBUG_select_J_l_GH_BEG2	<= ConfigBits(389 downto 388);
DEBUG_select_J_l_GH_BEG3	<= ConfigBits(391 downto 390);

end architecture Behavioral;

