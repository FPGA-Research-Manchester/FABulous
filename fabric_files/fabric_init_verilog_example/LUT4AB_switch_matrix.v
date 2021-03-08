//NumberOfConfigBits:392
module LUT4AB_switch_matrix (N1END0, N1END1, N1END2, N1END3, N2MID0, N2MID1, N2MID2, N2MID3, N2MID4, N2MID5, N2MID6, N2MID7, N2END0, N2END1, N2END2, N2END3, N2END4, N2END5, N2END6, N2END7, N4END0, N4END1, N4END2, N4END3, Ci0, E1END0, E1END1, E1END2, E1END3, E2MID0, E2MID1, E2MID2, E2MID3, E2MID4, E2MID5, E2MID6, E2MID7, E2END0, E2END1, E2END2, E2END3, E2END4, E2END5, E2END6, E2END7, E6END0, E6END1, S1END0, S1END1, S1END2, S1END3, S2MID0, S2MID1, S2MID2, S2MID3, S2MID4, S2MID5, S2MID6, S2MID7, S2END0, S2END1, S2END2, S2END3, S2END4, S2END5, S2END6, S2END7, S4END0, S4END1, S4END2, S4END3, W1END0, W1END1, W1END2, W1END3, W2MID0, W2MID1, W2MID2, W2MID3, W2MID4, W2MID5, W2MID6, W2MID7, W2END0, W2END1, W2END2, W2END3, W2END4, W2END5, W2END6, W2END7, W6END0, W6END1, LA_O, LA_Co, LB_O, LB_Co, LC_O, LC_Co, LD_O, LD_Co, LE_O, LE_Co, LF_O, LF_Co, LG_O, LG_Co, LH_O, LH_Co, M_AB, M_AD, M_AH, M_EF, J2MID_ABa_END0, J2MID_ABa_END1, J2MID_ABa_END2, J2MID_ABa_END3, J2MID_CDa_END0, J2MID_CDa_END1, J2MID_CDa_END2, J2MID_CDa_END3, J2MID_EFa_END0, J2MID_EFa_END1, J2MID_EFa_END2, J2MID_EFa_END3, J2MID_GHa_END0, J2MID_GHa_END1, J2MID_GHa_END2, J2MID_GHa_END3, J2MID_ABb_END0, J2MID_ABb_END1, J2MID_ABb_END2, J2MID_ABb_END3, J2MID_CDb_END0, J2MID_CDb_END1, J2MID_CDb_END2, J2MID_CDb_END3, J2MID_EFb_END0, J2MID_EFb_END1, J2MID_EFb_END2, J2MID_EFb_END3, J2MID_GHb_END0, J2MID_GHb_END1, J2MID_GHb_END2, J2MID_GHb_END3, J2END_AB_END0, J2END_AB_END1, J2END_AB_END2, J2END_AB_END3, J2END_CD_END0, J2END_CD_END1, J2END_CD_END2, J2END_CD_END3, J2END_EF_END0, J2END_EF_END1, J2END_EF_END2, J2END_EF_END3, J2END_GH_END0, J2END_GH_END1, J2END_GH_END2, J2END_GH_END3, JN2END0, JN2END1, JN2END2, JN2END3, JN2END4, JN2END5, JN2END6, JN2END7, JE2END0, JE2END1, JE2END2, JE2END3, JE2END4, JE2END5, JE2END6, JE2END7, JS2END0, JS2END1, JS2END2, JS2END3, JS2END4, JS2END5, JS2END6, JS2END7, JW2END0, JW2END1, JW2END2, JW2END3, JW2END4, JW2END5, JW2END6, JW2END7, J_l_AB_END0, J_l_AB_END1, J_l_AB_END2, J_l_AB_END3, J_l_CD_END0, J_l_CD_END1, J_l_CD_END2, J_l_CD_END3, J_l_EF_END0, J_l_EF_END1, J_l_EF_END2, J_l_EF_END3, J_l_GH_END0, J_l_GH_END1, J_l_GH_END2, J_l_GH_END3, N1BEG0, N1BEG1, N1BEG2, N1BEG3, N2BEG0, N2BEG1, N2BEG2, N2BEG3, N2BEG4, N2BEG5, N2BEG6, N2BEG7, N2BEGb0, N2BEGb1, N2BEGb2, N2BEGb3, N2BEGb4, N2BEGb5, N2BEGb6, N2BEGb7, N4BEG0, N4BEG1, N4BEG2, N4BEG3, Co0, E1BEG0, E1BEG1, E1BEG2, E1BEG3, E2BEG0, E2BEG1, E2BEG2, E2BEG3, E2BEG4, E2BEG5, E2BEG6, E2BEG7, E2BEGb0, E2BEGb1, E2BEGb2, E2BEGb3, E2BEGb4, E2BEGb5, E2BEGb6, E2BEGb7, E6BEG0, E6BEG1, S1BEG0, S1BEG1, S1BEG2, S1BEG3, S2BEG0, S2BEG1, S2BEG2, S2BEG3, S2BEG4, S2BEG5, S2BEG6, S2BEG7, S2BEGb0, S2BEGb1, S2BEGb2, S2BEGb3, S2BEGb4, S2BEGb5, S2BEGb6, S2BEGb7, S4BEG0, S4BEG1, S4BEG2, S4BEG3, W1BEG0, W1BEG1, W1BEG2, W1BEG3, W2BEG0, W2BEG1, W2BEG2, W2BEG3, W2BEG4, W2BEG5, W2BEG6, W2BEG7, W2BEGb0, W2BEGb1, W2BEGb2, W2BEGb3, W2BEGb4, W2BEGb5, W2BEGb6, W2BEGb7, W6BEG0, W6BEG1, LA_I0, LA_I1, LA_I2, LA_I3, LA_Ci, LB_I0, LB_I1, LB_I2, LB_I3, LB_Ci, LC_I0, LC_I1, LC_I2, LC_I3, LC_Ci, LD_I0, LD_I1, LD_I2, LD_I3, LD_Ci, LE_I0, LE_I1, LE_I2, LE_I3, LE_Ci, LF_I0, LF_I1, LF_I2, LF_I3, LF_Ci, LG_I0, LG_I1, LG_I2, LG_I3, LG_Ci, LH_I0, LH_I1, LH_I2, LH_I3, LH_Ci, A, B, C, D, E, F, G, H, S0, S1, S2, S3, J2MID_ABa_BEG0, J2MID_ABa_BEG1, J2MID_ABa_BEG2, J2MID_ABa_BEG3, J2MID_CDa_BEG0, J2MID_CDa_BEG1, J2MID_CDa_BEG2, J2MID_CDa_BEG3, J2MID_EFa_BEG0, J2MID_EFa_BEG1, J2MID_EFa_BEG2, J2MID_EFa_BEG3, J2MID_GHa_BEG0, J2MID_GHa_BEG1, J2MID_GHa_BEG2, J2MID_GHa_BEG3, J2MID_ABb_BEG0, J2MID_ABb_BEG1, J2MID_ABb_BEG2, J2MID_ABb_BEG3, J2MID_CDb_BEG0, J2MID_CDb_BEG1, J2MID_CDb_BEG2, J2MID_CDb_BEG3, J2MID_EFb_BEG0, J2MID_EFb_BEG1, J2MID_EFb_BEG2, J2MID_EFb_BEG3, J2MID_GHb_BEG0, J2MID_GHb_BEG1, J2MID_GHb_BEG2, J2MID_GHb_BEG3, J2END_AB_BEG0, J2END_AB_BEG1, J2END_AB_BEG2, J2END_AB_BEG3, J2END_CD_BEG0, J2END_CD_BEG1, J2END_CD_BEG2, J2END_CD_BEG3, J2END_EF_BEG0, J2END_EF_BEG1, J2END_EF_BEG2, J2END_EF_BEG3, J2END_GH_BEG0, J2END_GH_BEG1, J2END_GH_BEG2, J2END_GH_BEG3, JN2BEG0, JN2BEG1, JN2BEG2, JN2BEG3, JN2BEG4, JN2BEG5, JN2BEG6, JN2BEG7, JE2BEG0, JE2BEG1, JE2BEG2, JE2BEG3, JE2BEG4, JE2BEG5, JE2BEG6, JE2BEG7, JS2BEG0, JS2BEG1, JS2BEG2, JS2BEG3, JS2BEG4, JS2BEG5, JS2BEG6, JS2BEG7, JW2BEG0, JW2BEG1, JW2BEG2, JW2BEG3, JW2BEG4, JW2BEG5, JW2BEG6, JW2BEG7, J_l_AB_BEG0, J_l_AB_BEG1, J_l_AB_BEG2, J_l_AB_BEG3, J_l_CD_BEG0, J_l_CD_BEG1, J_l_CD_BEG2, J_l_CD_BEG3, J_l_EF_BEG0, J_l_EF_BEG1, J_l_EF_BEG2, J_l_EF_BEG3, J_l_GH_BEG0, J_l_GH_BEG1, J_l_GH_BEG2, J_l_GH_BEG3, ConfigBits);
	parameter NoConfigBits = 392;
	 // switch matrix inputs
	input N1END0;
	input N1END1;
	input N1END2;
	input N1END3;
	input N2MID0;
	input N2MID1;
	input N2MID2;
	input N2MID3;
	input N2MID4;
	input N2MID5;
	input N2MID6;
	input N2MID7;
	input N2END0;
	input N2END1;
	input N2END2;
	input N2END3;
	input N2END4;
	input N2END5;
	input N2END6;
	input N2END7;
	input N4END0;
	input N4END1;
	input N4END2;
	input N4END3;
	input Ci0;
	input E1END0;
	input E1END1;
	input E1END2;
	input E1END3;
	input E2MID0;
	input E2MID1;
	input E2MID2;
	input E2MID3;
	input E2MID4;
	input E2MID5;
	input E2MID6;
	input E2MID7;
	input E2END0;
	input E2END1;
	input E2END2;
	input E2END3;
	input E2END4;
	input E2END5;
	input E2END6;
	input E2END7;
	input E6END0;
	input E6END1;
	input S1END0;
	input S1END1;
	input S1END2;
	input S1END3;
	input S2MID0;
	input S2MID1;
	input S2MID2;
	input S2MID3;
	input S2MID4;
	input S2MID5;
	input S2MID6;
	input S2MID7;
	input S2END0;
	input S2END1;
	input S2END2;
	input S2END3;
	input S2END4;
	input S2END5;
	input S2END6;
	input S2END7;
	input S4END0;
	input S4END1;
	input S4END2;
	input S4END3;
	input W1END0;
	input W1END1;
	input W1END2;
	input W1END3;
	input W2MID0;
	input W2MID1;
	input W2MID2;
	input W2MID3;
	input W2MID4;
	input W2MID5;
	input W2MID6;
	input W2MID7;
	input W2END0;
	input W2END1;
	input W2END2;
	input W2END3;
	input W2END4;
	input W2END5;
	input W2END6;
	input W2END7;
	input W6END0;
	input W6END1;
	input LA_O;
	input LA_Co;
	input LB_O;
	input LB_Co;
	input LC_O;
	input LC_Co;
	input LD_O;
	input LD_Co;
	input LE_O;
	input LE_Co;
	input LF_O;
	input LF_Co;
	input LG_O;
	input LG_Co;
	input LH_O;
	input LH_Co;
	input M_AB;
	input M_AD;
	input M_AH;
	input M_EF;
	input J2MID_ABa_END0;
	input J2MID_ABa_END1;
	input J2MID_ABa_END2;
	input J2MID_ABa_END3;
	input J2MID_CDa_END0;
	input J2MID_CDa_END1;
	input J2MID_CDa_END2;
	input J2MID_CDa_END3;
	input J2MID_EFa_END0;
	input J2MID_EFa_END1;
	input J2MID_EFa_END2;
	input J2MID_EFa_END3;
	input J2MID_GHa_END0;
	input J2MID_GHa_END1;
	input J2MID_GHa_END2;
	input J2MID_GHa_END3;
	input J2MID_ABb_END0;
	input J2MID_ABb_END1;
	input J2MID_ABb_END2;
	input J2MID_ABb_END3;
	input J2MID_CDb_END0;
	input J2MID_CDb_END1;
	input J2MID_CDb_END2;
	input J2MID_CDb_END3;
	input J2MID_EFb_END0;
	input J2MID_EFb_END1;
	input J2MID_EFb_END2;
	input J2MID_EFb_END3;
	input J2MID_GHb_END0;
	input J2MID_GHb_END1;
	input J2MID_GHb_END2;
	input J2MID_GHb_END3;
	input J2END_AB_END0;
	input J2END_AB_END1;
	input J2END_AB_END2;
	input J2END_AB_END3;
	input J2END_CD_END0;
	input J2END_CD_END1;
	input J2END_CD_END2;
	input J2END_CD_END3;
	input J2END_EF_END0;
	input J2END_EF_END1;
	input J2END_EF_END2;
	input J2END_EF_END3;
	input J2END_GH_END0;
	input J2END_GH_END1;
	input J2END_GH_END2;
	input J2END_GH_END3;
	input JN2END0;
	input JN2END1;
	input JN2END2;
	input JN2END3;
	input JN2END4;
	input JN2END5;
	input JN2END6;
	input JN2END7;
	input JE2END0;
	input JE2END1;
	input JE2END2;
	input JE2END3;
	input JE2END4;
	input JE2END5;
	input JE2END6;
	input JE2END7;
	input JS2END0;
	input JS2END1;
	input JS2END2;
	input JS2END3;
	input JS2END4;
	input JS2END5;
	input JS2END6;
	input JS2END7;
	input JW2END0;
	input JW2END1;
	input JW2END2;
	input JW2END3;
	input JW2END4;
	input JW2END5;
	input JW2END6;
	input JW2END7;
	input J_l_AB_END0;
	input J_l_AB_END1;
	input J_l_AB_END2;
	input J_l_AB_END3;
	input J_l_CD_END0;
	input J_l_CD_END1;
	input J_l_CD_END2;
	input J_l_CD_END3;
	input J_l_EF_END0;
	input J_l_EF_END1;
	input J_l_EF_END2;
	input J_l_EF_END3;
	input J_l_GH_END0;
	input J_l_GH_END1;
	input J_l_GH_END2;
	input J_l_GH_END3;
	output N1BEG0;
	output N1BEG1;
	output N1BEG2;
	output N1BEG3;
	output N2BEG0;
	output N2BEG1;
	output N2BEG2;
	output N2BEG3;
	output N2BEG4;
	output N2BEG5;
	output N2BEG6;
	output N2BEG7;
	output N2BEGb0;
	output N2BEGb1;
	output N2BEGb2;
	output N2BEGb3;
	output N2BEGb4;
	output N2BEGb5;
	output N2BEGb6;
	output N2BEGb7;
	output N4BEG0;
	output N4BEG1;
	output N4BEG2;
	output N4BEG3;
	output Co0;
	output E1BEG0;
	output E1BEG1;
	output E1BEG2;
	output E1BEG3;
	output E2BEG0;
	output E2BEG1;
	output E2BEG2;
	output E2BEG3;
	output E2BEG4;
	output E2BEG5;
	output E2BEG6;
	output E2BEG7;
	output E2BEGb0;
	output E2BEGb1;
	output E2BEGb2;
	output E2BEGb3;
	output E2BEGb4;
	output E2BEGb5;
	output E2BEGb6;
	output E2BEGb7;
	output E6BEG0;
	output E6BEG1;
	output S1BEG0;
	output S1BEG1;
	output S1BEG2;
	output S1BEG3;
	output S2BEG0;
	output S2BEG1;
	output S2BEG2;
	output S2BEG3;
	output S2BEG4;
	output S2BEG5;
	output S2BEG6;
	output S2BEG7;
	output S2BEGb0;
	output S2BEGb1;
	output S2BEGb2;
	output S2BEGb3;
	output S2BEGb4;
	output S2BEGb5;
	output S2BEGb6;
	output S2BEGb7;
	output S4BEG0;
	output S4BEG1;
	output S4BEG2;
	output S4BEG3;
	output W1BEG0;
	output W1BEG1;
	output W1BEG2;
	output W1BEG3;
	output W2BEG0;
	output W2BEG1;
	output W2BEG2;
	output W2BEG3;
	output W2BEG4;
	output W2BEG5;
	output W2BEG6;
	output W2BEG7;
	output W2BEGb0;
	output W2BEGb1;
	output W2BEGb2;
	output W2BEGb3;
	output W2BEGb4;
	output W2BEGb5;
	output W2BEGb6;
	output W2BEGb7;
	output W6BEG0;
	output W6BEG1;
	output LA_I0;
	output LA_I1;
	output LA_I2;
	output LA_I3;
	output LA_Ci;
	output LB_I0;
	output LB_I1;
	output LB_I2;
	output LB_I3;
	output LB_Ci;
	output LC_I0;
	output LC_I1;
	output LC_I2;
	output LC_I3;
	output LC_Ci;
	output LD_I0;
	output LD_I1;
	output LD_I2;
	output LD_I3;
	output LD_Ci;
	output LE_I0;
	output LE_I1;
	output LE_I2;
	output LE_I3;
	output LE_Ci;
	output LF_I0;
	output LF_I1;
	output LF_I2;
	output LF_I3;
	output LF_Ci;
	output LG_I0;
	output LG_I1;
	output LG_I2;
	output LG_I3;
	output LG_Ci;
	output LH_I0;
	output LH_I1;
	output LH_I2;
	output LH_I3;
	output LH_Ci;
	output A;
	output B;
	output C;
	output D;
	output E;
	output F;
	output G;
	output H;
	output S0;
	output S1;
	output S2;
	output S3;
	output J2MID_ABa_BEG0;
	output J2MID_ABa_BEG1;
	output J2MID_ABa_BEG2;
	output J2MID_ABa_BEG3;
	output J2MID_CDa_BEG0;
	output J2MID_CDa_BEG1;
	output J2MID_CDa_BEG2;
	output J2MID_CDa_BEG3;
	output J2MID_EFa_BEG0;
	output J2MID_EFa_BEG1;
	output J2MID_EFa_BEG2;
	output J2MID_EFa_BEG3;
	output J2MID_GHa_BEG0;
	output J2MID_GHa_BEG1;
	output J2MID_GHa_BEG2;
	output J2MID_GHa_BEG3;
	output J2MID_ABb_BEG0;
	output J2MID_ABb_BEG1;
	output J2MID_ABb_BEG2;
	output J2MID_ABb_BEG3;
	output J2MID_CDb_BEG0;
	output J2MID_CDb_BEG1;
	output J2MID_CDb_BEG2;
	output J2MID_CDb_BEG3;
	output J2MID_EFb_BEG0;
	output J2MID_EFb_BEG1;
	output J2MID_EFb_BEG2;
	output J2MID_EFb_BEG3;
	output J2MID_GHb_BEG0;
	output J2MID_GHb_BEG1;
	output J2MID_GHb_BEG2;
	output J2MID_GHb_BEG3;
	output J2END_AB_BEG0;
	output J2END_AB_BEG1;
	output J2END_AB_BEG2;
	output J2END_AB_BEG3;
	output J2END_CD_BEG0;
	output J2END_CD_BEG1;
	output J2END_CD_BEG2;
	output J2END_CD_BEG3;
	output J2END_EF_BEG0;
	output J2END_EF_BEG1;
	output J2END_EF_BEG2;
	output J2END_EF_BEG3;
	output J2END_GH_BEG0;
	output J2END_GH_BEG1;
	output J2END_GH_BEG2;
	output J2END_GH_BEG3;
	output JN2BEG0;
	output JN2BEG1;
	output JN2BEG2;
	output JN2BEG3;
	output JN2BEG4;
	output JN2BEG5;
	output JN2BEG6;
	output JN2BEG7;
	output JE2BEG0;
	output JE2BEG1;
	output JE2BEG2;
	output JE2BEG3;
	output JE2BEG4;
	output JE2BEG5;
	output JE2BEG6;
	output JE2BEG7;
	output JS2BEG0;
	output JS2BEG1;
	output JS2BEG2;
	output JS2BEG3;
	output JS2BEG4;
	output JS2BEG5;
	output JS2BEG6;
	output JS2BEG7;
	output JW2BEG0;
	output JW2BEG1;
	output JW2BEG2;
	output JW2BEG3;
	output JW2BEG4;
	output JW2BEG5;
	output JW2BEG6;
	output JW2BEG7;
	output J_l_AB_BEG0;
	output J_l_AB_BEG1;
	output J_l_AB_BEG2;
	output J_l_AB_BEG3;
	output J_l_CD_BEG0;
	output J_l_CD_BEG1;
	output J_l_CD_BEG2;
	output J_l_CD_BEG3;
	output J_l_EF_BEG0;
	output J_l_EF_BEG1;
	output J_l_EF_BEG2;
	output J_l_EF_BEG3;
	output J_l_GH_BEG0;
	output J_l_GH_BEG1;
	output J_l_GH_BEG2;
	output J_l_GH_BEG3;
	//global
	input [NoConfigBits-1:0] ConfigBits;

	parameter GND0 = 1'b0;
	parameter GND = 1'b0;
	parameter VCC0 = 1'b1;
	parameter VCC = 1'b1;
	parameter VDD0 = 1'b1;
	parameter VDD = 1'b1;
	
	wire [4 -1:0]N1BEG0_input;
	wire [4 -1:0]N1BEG1_input;
	wire [4 -1:0]N1BEG2_input;
	wire [4 -1:0]N1BEG3_input;
	wire [1 -1:0]N2BEG0_input;
	wire [1 -1:0]N2BEG1_input;
	wire [1 -1:0]N2BEG2_input;
	wire [1 -1:0]N2BEG3_input;
	wire [1 -1:0]N2BEG4_input;
	wire [1 -1:0]N2BEG5_input;
	wire [1 -1:0]N2BEG6_input;
	wire [1 -1:0]N2BEG7_input;
	wire [1 -1:0]N2BEGb0_input;
	wire [1 -1:0]N2BEGb1_input;
	wire [1 -1:0]N2BEGb2_input;
	wire [1 -1:0]N2BEGb3_input;
	wire [1 -1:0]N2BEGb4_input;
	wire [1 -1:0]N2BEGb5_input;
	wire [1 -1:0]N2BEGb6_input;
	wire [1 -1:0]N2BEGb7_input;
	wire [4 -1:0]N4BEG0_input;
	wire [4 -1:0]N4BEG1_input;
	wire [4 -1:0]N4BEG2_input;
	wire [4 -1:0]N4BEG3_input;
	wire [1 -1:0]Co0_input;
	wire [4 -1:0]E1BEG0_input;
	wire [4 -1:0]E1BEG1_input;
	wire [4 -1:0]E1BEG2_input;
	wire [4 -1:0]E1BEG3_input;
	wire [1 -1:0]E2BEG0_input;
	wire [1 -1:0]E2BEG1_input;
	wire [1 -1:0]E2BEG2_input;
	wire [1 -1:0]E2BEG3_input;
	wire [1 -1:0]E2BEG4_input;
	wire [1 -1:0]E2BEG5_input;
	wire [1 -1:0]E2BEG6_input;
	wire [1 -1:0]E2BEG7_input;
	wire [1 -1:0]E2BEGb0_input;
	wire [1 -1:0]E2BEGb1_input;
	wire [1 -1:0]E2BEGb2_input;
	wire [1 -1:0]E2BEGb3_input;
	wire [1 -1:0]E2BEGb4_input;
	wire [1 -1:0]E2BEGb5_input;
	wire [1 -1:0]E2BEGb6_input;
	wire [1 -1:0]E2BEGb7_input;
	wire [16 -1:0]E6BEG0_input;
	wire [16 -1:0]E6BEG1_input;
	wire [4 -1:0]S1BEG0_input;
	wire [4 -1:0]S1BEG1_input;
	wire [4 -1:0]S1BEG2_input;
	wire [4 -1:0]S1BEG3_input;
	wire [1 -1:0]S2BEG0_input;
	wire [1 -1:0]S2BEG1_input;
	wire [1 -1:0]S2BEG2_input;
	wire [1 -1:0]S2BEG3_input;
	wire [1 -1:0]S2BEG4_input;
	wire [1 -1:0]S2BEG5_input;
	wire [1 -1:0]S2BEG6_input;
	wire [1 -1:0]S2BEG7_input;
	wire [1 -1:0]S2BEGb0_input;
	wire [1 -1:0]S2BEGb1_input;
	wire [1 -1:0]S2BEGb2_input;
	wire [1 -1:0]S2BEGb3_input;
	wire [1 -1:0]S2BEGb4_input;
	wire [1 -1:0]S2BEGb5_input;
	wire [1 -1:0]S2BEGb6_input;
	wire [1 -1:0]S2BEGb7_input;
	wire [4 -1:0]S4BEG0_input;
	wire [4 -1:0]S4BEG1_input;
	wire [4 -1:0]S4BEG2_input;
	wire [4 -1:0]S4BEG3_input;
	wire [4 -1:0]W1BEG0_input;
	wire [4 -1:0]W1BEG1_input;
	wire [4 -1:0]W1BEG2_input;
	wire [4 -1:0]W1BEG3_input;
	wire [1 -1:0]W2BEG0_input;
	wire [1 -1:0]W2BEG1_input;
	wire [1 -1:0]W2BEG2_input;
	wire [1 -1:0]W2BEG3_input;
	wire [1 -1:0]W2BEG4_input;
	wire [1 -1:0]W2BEG5_input;
	wire [1 -1:0]W2BEG6_input;
	wire [1 -1:0]W2BEG7_input;
	wire [1 -1:0]W2BEGb0_input;
	wire [1 -1:0]W2BEGb1_input;
	wire [1 -1:0]W2BEGb2_input;
	wire [1 -1:0]W2BEGb3_input;
	wire [1 -1:0]W2BEGb4_input;
	wire [1 -1:0]W2BEGb5_input;
	wire [1 -1:0]W2BEGb6_input;
	wire [1 -1:0]W2BEGb7_input;
	wire [16 -1:0]W6BEG0_input;
	wire [16 -1:0]W6BEG1_input;
	wire [4 -1:0]LA_I0_input;
	wire [4 -1:0]LA_I1_input;
	wire [4 -1:0]LA_I2_input;
	wire [4 -1:0]LA_I3_input;
	wire [1 -1:0]LA_Ci_input;
	wire [4 -1:0]LB_I0_input;
	wire [4 -1:0]LB_I1_input;
	wire [4 -1:0]LB_I2_input;
	wire [4 -1:0]LB_I3_input;
	wire [1 -1:0]LB_Ci_input;
	wire [4 -1:0]LC_I0_input;
	wire [4 -1:0]LC_I1_input;
	wire [4 -1:0]LC_I2_input;
	wire [4 -1:0]LC_I3_input;
	wire [1 -1:0]LC_Ci_input;
	wire [4 -1:0]LD_I0_input;
	wire [4 -1:0]LD_I1_input;
	wire [4 -1:0]LD_I2_input;
	wire [4 -1:0]LD_I3_input;
	wire [1 -1:0]LD_Ci_input;
	wire [4 -1:0]LE_I0_input;
	wire [4 -1:0]LE_I1_input;
	wire [4 -1:0]LE_I2_input;
	wire [4 -1:0]LE_I3_input;
	wire [1 -1:0]LE_Ci_input;
	wire [4 -1:0]LF_I0_input;
	wire [4 -1:0]LF_I1_input;
	wire [4 -1:0]LF_I2_input;
	wire [4 -1:0]LF_I3_input;
	wire [1 -1:0]LF_Ci_input;
	wire [4 -1:0]LG_I0_input;
	wire [4 -1:0]LG_I1_input;
	wire [4 -1:0]LG_I2_input;
	wire [4 -1:0]LG_I3_input;
	wire [1 -1:0]LG_Ci_input;
	wire [4 -1:0]LH_I0_input;
	wire [4 -1:0]LH_I1_input;
	wire [4 -1:0]LH_I2_input;
	wire [4 -1:0]LH_I3_input;
	wire [1 -1:0]LH_Ci_input;
	wire [1 -1:0]A_input;
	wire [1 -1:0]B_input;
	wire [1 -1:0]C_input;
	wire [1 -1:0]D_input;
	wire [1 -1:0]E_input;
	wire [1 -1:0]F_input;
	wire [1 -1:0]G_input;
	wire [1 -1:0]H_input;
	wire [4 -1:0]S0_input;
	wire [4 -1:0]S1_input;
	wire [4 -1:0]S2_input;
	wire [4 -1:0]S3_input;
	wire [4 -1:0]J2MID_ABa_BEG0_input;
	wire [4 -1:0]J2MID_ABa_BEG1_input;
	wire [4 -1:0]J2MID_ABa_BEG2_input;
	wire [4 -1:0]J2MID_ABa_BEG3_input;
	wire [4 -1:0]J2MID_CDa_BEG0_input;
	wire [4 -1:0]J2MID_CDa_BEG1_input;
	wire [4 -1:0]J2MID_CDa_BEG2_input;
	wire [4 -1:0]J2MID_CDa_BEG3_input;
	wire [4 -1:0]J2MID_EFa_BEG0_input;
	wire [4 -1:0]J2MID_EFa_BEG1_input;
	wire [4 -1:0]J2MID_EFa_BEG2_input;
	wire [4 -1:0]J2MID_EFa_BEG3_input;
	wire [4 -1:0]J2MID_GHa_BEG0_input;
	wire [4 -1:0]J2MID_GHa_BEG1_input;
	wire [4 -1:0]J2MID_GHa_BEG2_input;
	wire [4 -1:0]J2MID_GHa_BEG3_input;
	wire [4 -1:0]J2MID_ABb_BEG0_input;
	wire [4 -1:0]J2MID_ABb_BEG1_input;
	wire [4 -1:0]J2MID_ABb_BEG2_input;
	wire [4 -1:0]J2MID_ABb_BEG3_input;
	wire [4 -1:0]J2MID_CDb_BEG0_input;
	wire [4 -1:0]J2MID_CDb_BEG1_input;
	wire [4 -1:0]J2MID_CDb_BEG2_input;
	wire [4 -1:0]J2MID_CDb_BEG3_input;
	wire [4 -1:0]J2MID_EFb_BEG0_input;
	wire [4 -1:0]J2MID_EFb_BEG1_input;
	wire [4 -1:0]J2MID_EFb_BEG2_input;
	wire [4 -1:0]J2MID_EFb_BEG3_input;
	wire [4 -1:0]J2MID_GHb_BEG0_input;
	wire [4 -1:0]J2MID_GHb_BEG1_input;
	wire [4 -1:0]J2MID_GHb_BEG2_input;
	wire [4 -1:0]J2MID_GHb_BEG3_input;
	wire [4 -1:0]J2END_AB_BEG0_input;
	wire [4 -1:0]J2END_AB_BEG1_input;
	wire [4 -1:0]J2END_AB_BEG2_input;
	wire [4 -1:0]J2END_AB_BEG3_input;
	wire [4 -1:0]J2END_CD_BEG0_input;
	wire [4 -1:0]J2END_CD_BEG1_input;
	wire [4 -1:0]J2END_CD_BEG2_input;
	wire [4 -1:0]J2END_CD_BEG3_input;
	wire [4 -1:0]J2END_EF_BEG0_input;
	wire [4 -1:0]J2END_EF_BEG1_input;
	wire [4 -1:0]J2END_EF_BEG2_input;
	wire [4 -1:0]J2END_EF_BEG3_input;
	wire [4 -1:0]J2END_GH_BEG0_input;
	wire [4 -1:0]J2END_GH_BEG1_input;
	wire [4 -1:0]J2END_GH_BEG2_input;
	wire [4 -1:0]J2END_GH_BEG3_input;
	wire [16 -1:0]JN2BEG0_input;
	wire [16 -1:0]JN2BEG1_input;
	wire [16 -1:0]JN2BEG2_input;
	wire [16 -1:0]JN2BEG3_input;
	wire [16 -1:0]JN2BEG4_input;
	wire [16 -1:0]JN2BEG5_input;
	wire [16 -1:0]JN2BEG6_input;
	wire [16 -1:0]JN2BEG7_input;
	wire [16 -1:0]JE2BEG0_input;
	wire [16 -1:0]JE2BEG1_input;
	wire [16 -1:0]JE2BEG2_input;
	wire [16 -1:0]JE2BEG3_input;
	wire [16 -1:0]JE2BEG4_input;
	wire [16 -1:0]JE2BEG5_input;
	wire [16 -1:0]JE2BEG6_input;
	wire [16 -1:0]JE2BEG7_input;
	wire [16 -1:0]JS2BEG0_input;
	wire [16 -1:0]JS2BEG1_input;
	wire [16 -1:0]JS2BEG2_input;
	wire [16 -1:0]JS2BEG3_input;
	wire [16 -1:0]JS2BEG4_input;
	wire [16 -1:0]JS2BEG5_input;
	wire [16 -1:0]JS2BEG6_input;
	wire [16 -1:0]JS2BEG7_input;
	wire [16 -1:0]JW2BEG0_input;
	wire [16 -1:0]JW2BEG1_input;
	wire [16 -1:0]JW2BEG2_input;
	wire [16 -1:0]JW2BEG3_input;
	wire [16 -1:0]JW2BEG4_input;
	wire [16 -1:0]JW2BEG5_input;
	wire [16 -1:0]JW2BEG6_input;
	wire [16 -1:0]JW2BEG7_input;
	wire [4 -1:0]J_l_AB_BEG0_input;
	wire [4 -1:0]J_l_AB_BEG1_input;
	wire [4 -1:0]J_l_AB_BEG2_input;
	wire [4 -1:0]J_l_AB_BEG3_input;
	wire [4 -1:0]J_l_CD_BEG0_input;
	wire [4 -1:0]J_l_CD_BEG1_input;
	wire [4 -1:0]J_l_CD_BEG2_input;
	wire [4 -1:0]J_l_CD_BEG3_input;
	wire [4 -1:0]J_l_EF_BEG0_input;
	wire [4 -1:0]J_l_EF_BEG1_input;
	wire [4 -1:0]J_l_EF_BEG2_input;
	wire [4 -1:0]J_l_EF_BEG3_input;
	wire [4 -1:0]J_l_GH_BEG0_input;
	wire [4 -1:0]J_l_GH_BEG1_input;
	wire [4 -1:0]J_l_GH_BEG2_input;
	wire [4 -1:0]J_l_GH_BEG3_input;

	wire [2-1:0] DEBUG_select_N1BEG0;
	wire [2-1:0] DEBUG_select_N1BEG1;
	wire [2-1:0] DEBUG_select_N1BEG2;
	wire [2-1:0] DEBUG_select_N1BEG3;
	wire [2-1:0] DEBUG_select_N4BEG0;
	wire [2-1:0] DEBUG_select_N4BEG1;
	wire [2-1:0] DEBUG_select_N4BEG2;
	wire [2-1:0] DEBUG_select_N4BEG3;
	wire [2-1:0] DEBUG_select_E1BEG0;
	wire [2-1:0] DEBUG_select_E1BEG1;
	wire [2-1:0] DEBUG_select_E1BEG2;
	wire [2-1:0] DEBUG_select_E1BEG3;
	wire [4-1:0] DEBUG_select_E6BEG0;
	wire [4-1:0] DEBUG_select_E6BEG1;
	wire [2-1:0] DEBUG_select_S1BEG0;
	wire [2-1:0] DEBUG_select_S1BEG1;
	wire [2-1:0] DEBUG_select_S1BEG2;
	wire [2-1:0] DEBUG_select_S1BEG3;
	wire [2-1:0] DEBUG_select_S4BEG0;
	wire [2-1:0] DEBUG_select_S4BEG1;
	wire [2-1:0] DEBUG_select_S4BEG2;
	wire [2-1:0] DEBUG_select_S4BEG3;
	wire [2-1:0] DEBUG_select_W1BEG0;
	wire [2-1:0] DEBUG_select_W1BEG1;
	wire [2-1:0] DEBUG_select_W1BEG2;
	wire [2-1:0] DEBUG_select_W1BEG3;
	wire [4-1:0] DEBUG_select_W6BEG0;
	wire [4-1:0] DEBUG_select_W6BEG1;
	wire [2-1:0] DEBUG_select_LA_I0;
	wire [2-1:0] DEBUG_select_LA_I1;
	wire [2-1:0] DEBUG_select_LA_I2;
	wire [2-1:0] DEBUG_select_LA_I3;
	wire [2-1:0] DEBUG_select_LB_I0;
	wire [2-1:0] DEBUG_select_LB_I1;
	wire [2-1:0] DEBUG_select_LB_I2;
	wire [2-1:0] DEBUG_select_LB_I3;
	wire [2-1:0] DEBUG_select_LC_I0;
	wire [2-1:0] DEBUG_select_LC_I1;
	wire [2-1:0] DEBUG_select_LC_I2;
	wire [2-1:0] DEBUG_select_LC_I3;
	wire [2-1:0] DEBUG_select_LD_I0;
	wire [2-1:0] DEBUG_select_LD_I1;
	wire [2-1:0] DEBUG_select_LD_I2;
	wire [2-1:0] DEBUG_select_LD_I3;
	wire [2-1:0] DEBUG_select_LE_I0;
	wire [2-1:0] DEBUG_select_LE_I1;
	wire [2-1:0] DEBUG_select_LE_I2;
	wire [2-1:0] DEBUG_select_LE_I3;
	wire [2-1:0] DEBUG_select_LF_I0;
	wire [2-1:0] DEBUG_select_LF_I1;
	wire [2-1:0] DEBUG_select_LF_I2;
	wire [2-1:0] DEBUG_select_LF_I3;
	wire [2-1:0] DEBUG_select_LG_I0;
	wire [2-1:0] DEBUG_select_LG_I1;
	wire [2-1:0] DEBUG_select_LG_I2;
	wire [2-1:0] DEBUG_select_LG_I3;
	wire [2-1:0] DEBUG_select_LH_I0;
	wire [2-1:0] DEBUG_select_LH_I1;
	wire [2-1:0] DEBUG_select_LH_I2;
	wire [2-1:0] DEBUG_select_LH_I3;
	wire [2-1:0] DEBUG_select_S0;
	wire [2-1:0] DEBUG_select_S1;
	wire [2-1:0] DEBUG_select_S2;
	wire [2-1:0] DEBUG_select_S3;
	wire [2-1:0] DEBUG_select_J2MID_ABa_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_ABa_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_ABa_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_ABa_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_CDa_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_CDa_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_CDa_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_CDa_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_EFa_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_EFa_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_EFa_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_EFa_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_GHa_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_GHa_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_GHa_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_GHa_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_ABb_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_ABb_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_ABb_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_ABb_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_CDb_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_CDb_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_CDb_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_CDb_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_EFb_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_EFb_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_EFb_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_EFb_BEG3;
	wire [2-1:0] DEBUG_select_J2MID_GHb_BEG0;
	wire [2-1:0] DEBUG_select_J2MID_GHb_BEG1;
	wire [2-1:0] DEBUG_select_J2MID_GHb_BEG2;
	wire [2-1:0] DEBUG_select_J2MID_GHb_BEG3;
	wire [2-1:0] DEBUG_select_J2END_AB_BEG0;
	wire [2-1:0] DEBUG_select_J2END_AB_BEG1;
	wire [2-1:0] DEBUG_select_J2END_AB_BEG2;
	wire [2-1:0] DEBUG_select_J2END_AB_BEG3;
	wire [2-1:0] DEBUG_select_J2END_CD_BEG0;
	wire [2-1:0] DEBUG_select_J2END_CD_BEG1;
	wire [2-1:0] DEBUG_select_J2END_CD_BEG2;
	wire [2-1:0] DEBUG_select_J2END_CD_BEG3;
	wire [2-1:0] DEBUG_select_J2END_EF_BEG0;
	wire [2-1:0] DEBUG_select_J2END_EF_BEG1;
	wire [2-1:0] DEBUG_select_J2END_EF_BEG2;
	wire [2-1:0] DEBUG_select_J2END_EF_BEG3;
	wire [2-1:0] DEBUG_select_J2END_GH_BEG0;
	wire [2-1:0] DEBUG_select_J2END_GH_BEG1;
	wire [2-1:0] DEBUG_select_J2END_GH_BEG2;
	wire [2-1:0] DEBUG_select_J2END_GH_BEG3;
	wire [4-1:0] DEBUG_select_JN2BEG0;
	wire [4-1:0] DEBUG_select_JN2BEG1;
	wire [4-1:0] DEBUG_select_JN2BEG2;
	wire [4-1:0] DEBUG_select_JN2BEG3;
	wire [4-1:0] DEBUG_select_JN2BEG4;
	wire [4-1:0] DEBUG_select_JN2BEG5;
	wire [4-1:0] DEBUG_select_JN2BEG6;
	wire [4-1:0] DEBUG_select_JN2BEG7;
	wire [4-1:0] DEBUG_select_JE2BEG0;
	wire [4-1:0] DEBUG_select_JE2BEG1;
	wire [4-1:0] DEBUG_select_JE2BEG2;
	wire [4-1:0] DEBUG_select_JE2BEG3;
	wire [4-1:0] DEBUG_select_JE2BEG4;
	wire [4-1:0] DEBUG_select_JE2BEG5;
	wire [4-1:0] DEBUG_select_JE2BEG6;
	wire [4-1:0] DEBUG_select_JE2BEG7;
	wire [4-1:0] DEBUG_select_JS2BEG0;
	wire [4-1:0] DEBUG_select_JS2BEG1;
	wire [4-1:0] DEBUG_select_JS2BEG2;
	wire [4-1:0] DEBUG_select_JS2BEG3;
	wire [4-1:0] DEBUG_select_JS2BEG4;
	wire [4-1:0] DEBUG_select_JS2BEG5;
	wire [4-1:0] DEBUG_select_JS2BEG6;
	wire [4-1:0] DEBUG_select_JS2BEG7;
	wire [4-1:0] DEBUG_select_JW2BEG0;
	wire [4-1:0] DEBUG_select_JW2BEG1;
	wire [4-1:0] DEBUG_select_JW2BEG2;
	wire [4-1:0] DEBUG_select_JW2BEG3;
	wire [4-1:0] DEBUG_select_JW2BEG4;
	wire [4-1:0] DEBUG_select_JW2BEG5;
	wire [4-1:0] DEBUG_select_JW2BEG6;
	wire [4-1:0] DEBUG_select_JW2BEG7;
	wire [2-1:0] DEBUG_select_J_l_AB_BEG0;
	wire [2-1:0] DEBUG_select_J_l_AB_BEG1;
	wire [2-1:0] DEBUG_select_J_l_AB_BEG2;
	wire [2-1:0] DEBUG_select_J_l_AB_BEG3;
	wire [2-1:0] DEBUG_select_J_l_CD_BEG0;
	wire [2-1:0] DEBUG_select_J_l_CD_BEG1;
	wire [2-1:0] DEBUG_select_J_l_CD_BEG2;
	wire [2-1:0] DEBUG_select_J_l_CD_BEG3;
	wire [2-1:0] DEBUG_select_J_l_EF_BEG0;
	wire [2-1:0] DEBUG_select_J_l_EF_BEG1;
	wire [2-1:0] DEBUG_select_J_l_EF_BEG2;
	wire [2-1:0] DEBUG_select_J_l_EF_BEG3;
	wire [2-1:0] DEBUG_select_J_l_GH_BEG0;
	wire [2-1:0] DEBUG_select_J_l_GH_BEG1;
	wire [2-1:0] DEBUG_select_J_l_GH_BEG2;
	wire [2-1:0] DEBUG_select_J_l_GH_BEG3;

// The configuration bits (if any) are just a long shift register

// This shift register is padded to an even number of flops/latches
// switch matrix multiplexer  N1BEG0 		MUX-4
	assign N1BEG0_input = {J_l_CD_END1,JW2END3,J2MID_CDb_END3,LC_O};
	assign N1BEG0 = N1BEG0_input[ConfigBits[1:0]];
 
// switch matrix multiplexer  N1BEG1 		MUX-4
	assign N1BEG1_input = {J_l_EF_END2,JW2END0,J2MID_EFb_END0,LD_O};
	assign N1BEG1 = N1BEG1_input[ConfigBits[3:2]];
 
// switch matrix multiplexer  N1BEG2 		MUX-4
	assign N1BEG2_input = {J_l_GH_END3,JW2END1,J2MID_GHb_END1,LE_O};
	assign N1BEG2 = N1BEG2_input[ConfigBits[5:4]];
 
// switch matrix multiplexer  N1BEG3 		MUX-4
	assign N1BEG3_input = {J_l_AB_END0,JW2END2,J2MID_ABb_END2,LF_O};
	assign N1BEG3 = N1BEG3_input[ConfigBits[7:6]];
 
// switch matrix multiplexer  N2BEG0 		MUX-1
	assign N2BEG0 = JN2END0;
// switch matrix multiplexer  N2BEG1 		MUX-1
	assign N2BEG1 = JN2END1;
// switch matrix multiplexer  N2BEG2 		MUX-1
	assign N2BEG2 = JN2END2;
// switch matrix multiplexer  N2BEG3 		MUX-1
	assign N2BEG3 = JN2END3;
// switch matrix multiplexer  N2BEG4 		MUX-1
	assign N2BEG4 = JN2END4;
// switch matrix multiplexer  N2BEG5 		MUX-1
	assign N2BEG5 = JN2END5;
// switch matrix multiplexer  N2BEG6 		MUX-1
	assign N2BEG6 = JN2END6;
// switch matrix multiplexer  N2BEG7 		MUX-1
	assign N2BEG7 = JN2END7;
// switch matrix multiplexer  N2BEGb0 		MUX-1
	assign N2BEGb0 = N2MID0;
// switch matrix multiplexer  N2BEGb1 		MUX-1
	assign N2BEGb1 = N2MID1;
// switch matrix multiplexer  N2BEGb2 		MUX-1
	assign N2BEGb2 = N2MID2;
// switch matrix multiplexer  N2BEGb3 		MUX-1
	assign N2BEGb3 = N2MID3;
// switch matrix multiplexer  N2BEGb4 		MUX-1
	assign N2BEGb4 = N2MID4;
// switch matrix multiplexer  N2BEGb5 		MUX-1
	assign N2BEGb5 = N2MID5;
// switch matrix multiplexer  N2BEGb6 		MUX-1
	assign N2BEGb6 = N2MID6;
// switch matrix multiplexer  N2BEGb7 		MUX-1
	assign N2BEGb7 = N2MID7;
// switch matrix multiplexer  N4BEG0 		MUX-4
	assign N4BEG0_input = {LE_O,E6END1,N4END1,N2END2};
	assign N4BEG0 = N4BEG0_input[ConfigBits[9:8]];
 
// switch matrix multiplexer  N4BEG1 		MUX-4
	assign N4BEG1_input = {LF_O,E6END0,N4END2,N2END3};
	assign N4BEG1 = N4BEG1_input[ConfigBits[11:10]];
 
// switch matrix multiplexer  N4BEG2 		MUX-4
	assign N4BEG2_input = {LG_O,W6END1,N4END3,N2END0};
	assign N4BEG2 = N4BEG2_input[ConfigBits[13:12]];
 
// switch matrix multiplexer  N4BEG3 		MUX-4
	assign N4BEG3_input = {LH_O,W6END0,N4END0,N2END1};
	assign N4BEG3 = N4BEG3_input[ConfigBits[15:14]];
 
// switch matrix multiplexer  Co0 		MUX-1
	assign Co0 = LH_Co;
// switch matrix multiplexer  E1BEG0 		MUX-4
	assign E1BEG0_input = {J_l_CD_END1,JN2END3,J2MID_CDb_END3,LD_O};
	assign E1BEG0 = E1BEG0_input[ConfigBits[17:16]];
 
// switch matrix multiplexer  E1BEG1 		MUX-4
	assign E1BEG1_input = {J_l_EF_END2,JN2END0,J2MID_EFb_END0,LE_O};
	assign E1BEG1 = E1BEG1_input[ConfigBits[19:18]];
 
// switch matrix multiplexer  E1BEG2 		MUX-4
	assign E1BEG2_input = {J_l_GH_END3,JN2END1,J2MID_GHb_END1,LF_O};
	assign E1BEG2 = E1BEG2_input[ConfigBits[21:20]];
 
// switch matrix multiplexer  E1BEG3 		MUX-4
	assign E1BEG3_input = {J_l_AB_END0,JN2END2,J2MID_ABb_END2,LG_O};
	assign E1BEG3 = E1BEG3_input[ConfigBits[23:22]];
 
// switch matrix multiplexer  E2BEG0 		MUX-1
	assign E2BEG0 = JE2END0;
// switch matrix multiplexer  E2BEG1 		MUX-1
	assign E2BEG1 = JE2END1;
// switch matrix multiplexer  E2BEG2 		MUX-1
	assign E2BEG2 = JE2END2;
// switch matrix multiplexer  E2BEG3 		MUX-1
	assign E2BEG3 = JE2END3;
// switch matrix multiplexer  E2BEG4 		MUX-1
	assign E2BEG4 = JE2END4;
// switch matrix multiplexer  E2BEG5 		MUX-1
	assign E2BEG5 = JE2END5;
// switch matrix multiplexer  E2BEG6 		MUX-1
	assign E2BEG6 = JE2END6;
// switch matrix multiplexer  E2BEG7 		MUX-1
	assign E2BEG7 = JE2END7;
// switch matrix multiplexer  E2BEGb0 		MUX-1
	assign E2BEGb0 = E2MID0;
// switch matrix multiplexer  E2BEGb1 		MUX-1
	assign E2BEGb1 = E2MID1;
// switch matrix multiplexer  E2BEGb2 		MUX-1
	assign E2BEGb2 = E2MID2;
// switch matrix multiplexer  E2BEGb3 		MUX-1
	assign E2BEGb3 = E2MID3;
// switch matrix multiplexer  E2BEGb4 		MUX-1
	assign E2BEGb4 = E2MID4;
// switch matrix multiplexer  E2BEGb5 		MUX-1
	assign E2BEGb5 = E2MID5;
// switch matrix multiplexer  E2BEGb6 		MUX-1
	assign E2BEGb6 = E2MID6;
// switch matrix multiplexer  E2BEGb7 		MUX-1
	assign E2BEGb7 = E2MID7;
// switch matrix multiplexer  E6BEG0 		MUX-16
	assign E6BEG0_input = {J2MID_GHb_END1,J2MID_EFb_END1,J2MID_CDb_END1,J2MID_ABb_END1,M_AH,M_AB,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,E1END3};
	assign E6BEG0 = E6BEG0_input[ConfigBits[27:24]];
 
// switch matrix multiplexer  E6BEG1 		MUX-16
	assign E6BEG1_input = {J2MID_GHa_END2,J2MID_EFa_END2,J2MID_CDa_END2,J2MID_ABa_END2,M_EF,M_AD,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,E1END2};
	assign E6BEG1 = E6BEG1_input[ConfigBits[31:28]];
 
// switch matrix multiplexer  S1BEG0 		MUX-4
	assign S1BEG0_input = {J_l_CD_END1,JE2END3,J2MID_CDb_END3,LE_O};
	assign S1BEG0 = S1BEG0_input[ConfigBits[33:32]];
 
// switch matrix multiplexer  S1BEG1 		MUX-4
	assign S1BEG1_input = {J_l_EF_END2,JE2END0,J2MID_EFb_END0,LF_O};
	assign S1BEG1 = S1BEG1_input[ConfigBits[35:34]];
 
// switch matrix multiplexer  S1BEG2 		MUX-4
	assign S1BEG2_input = {J_l_GH_END3,JE2END1,J2MID_GHb_END1,LG_O};
	assign S1BEG2 = S1BEG2_input[ConfigBits[37:36]];
 
// switch matrix multiplexer  S1BEG3 		MUX-4
	assign S1BEG3_input = {J_l_AB_END0,JE2END2,J2MID_ABb_END2,LH_O};
	assign S1BEG3 = S1BEG3_input[ConfigBits[39:38]];
 
// switch matrix multiplexer  S2BEG0 		MUX-1
	assign S2BEG0 = JS2END0;
// switch matrix multiplexer  S2BEG1 		MUX-1
	assign S2BEG1 = JS2END1;
// switch matrix multiplexer  S2BEG2 		MUX-1
	assign S2BEG2 = JS2END2;
// switch matrix multiplexer  S2BEG3 		MUX-1
	assign S2BEG3 = JS2END3;
// switch matrix multiplexer  S2BEG4 		MUX-1
	assign S2BEG4 = JS2END4;
// switch matrix multiplexer  S2BEG5 		MUX-1
	assign S2BEG5 = JS2END5;
// switch matrix multiplexer  S2BEG6 		MUX-1
	assign S2BEG6 = JS2END6;
// switch matrix multiplexer  S2BEG7 		MUX-1
	assign S2BEG7 = JS2END7;
// switch matrix multiplexer  S2BEGb0 		MUX-1
	assign S2BEGb0 = S2MID0;
// switch matrix multiplexer  S2BEGb1 		MUX-1
	assign S2BEGb1 = S2MID1;
// switch matrix multiplexer  S2BEGb2 		MUX-1
	assign S2BEGb2 = S2MID2;
// switch matrix multiplexer  S2BEGb3 		MUX-1
	assign S2BEGb3 = S2MID3;
// switch matrix multiplexer  S2BEGb4 		MUX-1
	assign S2BEGb4 = S2MID4;
// switch matrix multiplexer  S2BEGb5 		MUX-1
	assign S2BEGb5 = S2MID5;
// switch matrix multiplexer  S2BEGb6 		MUX-1
	assign S2BEGb6 = S2MID6;
// switch matrix multiplexer  S2BEGb7 		MUX-1
	assign S2BEGb7 = S2MID7;
// switch matrix multiplexer  S4BEG0 		MUX-4
	assign S4BEG0_input = {LA_O,S4END1,S2END2,E6END1};
	assign S4BEG0 = S4BEG0_input[ConfigBits[41:40]];
 
// switch matrix multiplexer  S4BEG1 		MUX-4
	assign S4BEG1_input = {LB_O,S4END2,S2END3,E6END0};
	assign S4BEG1 = S4BEG1_input[ConfigBits[43:42]];
 
// switch matrix multiplexer  S4BEG2 		MUX-4
	assign S4BEG2_input = {LC_O,W6END1,S4END3,S2END0};
	assign S4BEG2 = S4BEG2_input[ConfigBits[45:44]];
 
// switch matrix multiplexer  S4BEG3 		MUX-4
	assign S4BEG3_input = {LD_O,W6END0,S4END0,S2END1};
	assign S4BEG3 = S4BEG3_input[ConfigBits[47:46]];
 
// switch matrix multiplexer  W1BEG0 		MUX-4
	assign W1BEG0_input = {J_l_CD_END1,JS2END3,J2MID_CDb_END3,LF_O};
	assign W1BEG0 = W1BEG0_input[ConfigBits[49:48]];
 
// switch matrix multiplexer  W1BEG1 		MUX-4
	assign W1BEG1_input = {J_l_EF_END2,JS2END0,J2MID_EFb_END0,LG_O};
	assign W1BEG1 = W1BEG1_input[ConfigBits[51:50]];
 
// switch matrix multiplexer  W1BEG2 		MUX-4
	assign W1BEG2_input = {J_l_GH_END3,JS2END1,J2MID_GHb_END1,LH_O};
	assign W1BEG2 = W1BEG2_input[ConfigBits[53:52]];
 
// switch matrix multiplexer  W1BEG3 		MUX-4
	assign W1BEG3_input = {J_l_AB_END0,JS2END2,J2MID_ABb_END2,LA_O};
	assign W1BEG3 = W1BEG3_input[ConfigBits[55:54]];
 
// switch matrix multiplexer  W2BEG0 		MUX-1
	assign W2BEG0 = W2END0;
// switch matrix multiplexer  W2BEG1 		MUX-1
	assign W2BEG1 = JW2END1;
// switch matrix multiplexer  W2BEG2 		MUX-1
	assign W2BEG2 = JW2END2;
// switch matrix multiplexer  W2BEG3 		MUX-1
	assign W2BEG3 = W2END3;
// switch matrix multiplexer  W2BEG4 		MUX-1
	assign W2BEG4 = W2END4;
// switch matrix multiplexer  W2BEG5 		MUX-1
	assign W2BEG5 = JW2END5;
// switch matrix multiplexer  W2BEG6 		MUX-1
	assign W2BEG6 = JW2END6;
// switch matrix multiplexer  W2BEG7 		MUX-1
	assign W2BEG7 = W2END7;
// switch matrix multiplexer  W2BEGb0 		MUX-1
	assign W2BEGb0 = W2MID0;
// switch matrix multiplexer  W2BEGb1 		MUX-1
	assign W2BEGb1 = W2MID1;
// switch matrix multiplexer  W2BEGb2 		MUX-1
	assign W2BEGb2 = W2MID2;
// switch matrix multiplexer  W2BEGb3 		MUX-1
	assign W2BEGb3 = W2MID3;
// switch matrix multiplexer  W2BEGb4 		MUX-1
	assign W2BEGb4 = W2MID4;
// switch matrix multiplexer  W2BEGb5 		MUX-1
	assign W2BEGb5 = W2MID5;
// switch matrix multiplexer  W2BEGb6 		MUX-1
	assign W2BEGb6 = W2MID6;
// switch matrix multiplexer  W2BEGb7 		MUX-1
	assign W2BEGb7 = W2MID7;
// switch matrix multiplexer  W6BEG0 		MUX-16
	assign W6BEG0_input = {J2MID_GHb_END1,J2MID_EFb_END1,J2MID_CDb_END1,J2MID_ABb_END1,M_AH,M_AB,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,E1END3};
	assign W6BEG0 = W6BEG0_input[ConfigBits[59:56]];
 
// switch matrix multiplexer  W6BEG1 		MUX-16
	assign W6BEG1_input = {J2MID_GHa_END2,J2MID_EFa_END2,J2MID_CDa_END2,J2MID_ABa_END2,M_EF,M_AD,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,E1END2};
	assign W6BEG1 = W6BEG1_input[ConfigBits[63:60]];
 
// switch matrix multiplexer  LA_I0 		MUX-4
	assign LA_I0_input = {J_l_AB_END0,J2END_AB_END0,J2MID_ABb_END0,J2MID_ABa_END0};
	assign LA_I0 = LA_I0_input[ConfigBits[65:64]];
 
// switch matrix multiplexer  LA_I1 		MUX-4
	assign LA_I1_input = {J_l_AB_END1,J2END_AB_END1,J2MID_ABb_END1,J2MID_ABa_END1};
	assign LA_I1 = LA_I1_input[ConfigBits[67:66]];
 
// switch matrix multiplexer  LA_I2 		MUX-4
	assign LA_I2_input = {J_l_AB_END2,J2END_AB_END2,J2MID_ABb_END2,J2MID_ABa_END2};
	assign LA_I2 = LA_I2_input[ConfigBits[69:68]];
 
// switch matrix multiplexer  LA_I3 		MUX-4
	assign LA_I3_input = {J_l_AB_END3,J2END_AB_END3,J2MID_ABb_END3,J2MID_ABa_END3};
	assign LA_I3 = LA_I3_input[ConfigBits[71:70]];
 
// switch matrix multiplexer  LA_Ci 		MUX-1
	assign LA_Ci = Ci0;
// switch matrix multiplexer  LB_I0 		MUX-4
	assign LB_I0_input = {J_l_AB_END0,J2END_AB_END0,J2MID_ABb_END0,J2MID_ABa_END0};
	assign LB_I0 = LB_I0_input[ConfigBits[73:72]];
 
// switch matrix multiplexer  LB_I1 		MUX-4
	assign LB_I1_input = {J_l_AB_END1,J2END_AB_END1,J2MID_ABb_END1,J2MID_ABa_END1};
	assign LB_I1 = LB_I1_input[ConfigBits[75:74]];
 
// switch matrix multiplexer  LB_I2 		MUX-4
	assign LB_I2_input = {J_l_AB_END2,J2END_AB_END2,J2MID_ABb_END2,J2MID_ABa_END2};
	assign LB_I2 = LB_I2_input[ConfigBits[77:76]];
 
// switch matrix multiplexer  LB_I3 		MUX-4
	assign LB_I3_input = {J_l_AB_END3,J2END_AB_END3,J2MID_ABb_END3,J2MID_ABa_END3};
	assign LB_I3 = LB_I3_input[ConfigBits[79:78]];
 
// switch matrix multiplexer  LB_Ci 		MUX-1
	assign LB_Ci = LA_Co;
// switch matrix multiplexer  LC_I0 		MUX-4
	assign LC_I0_input = {J_l_CD_END0,J2END_CD_END0,J2MID_CDb_END0,J2MID_CDa_END0};
	assign LC_I0 = LC_I0_input[ConfigBits[81:80]];
 
// switch matrix multiplexer  LC_I1 		MUX-4
	assign LC_I1_input = {J_l_CD_END1,J2END_CD_END1,J2MID_CDb_END1,J2MID_CDa_END1};
	assign LC_I1 = LC_I1_input[ConfigBits[83:82]];
 
// switch matrix multiplexer  LC_I2 		MUX-4
	assign LC_I2_input = {J_l_CD_END2,J2END_CD_END2,J2MID_CDb_END2,J2MID_CDa_END2};
	assign LC_I2 = LC_I2_input[ConfigBits[85:84]];
 
// switch matrix multiplexer  LC_I3 		MUX-4
	assign LC_I3_input = {J_l_CD_END3,J2END_CD_END3,J2MID_CDb_END3,J2MID_CDa_END3};
	assign LC_I3 = LC_I3_input[ConfigBits[87:86]];
 
// switch matrix multiplexer  LC_Ci 		MUX-1
	assign LC_Ci = LB_Co;
// switch matrix multiplexer  LD_I0 		MUX-4
	assign LD_I0_input = {J_l_CD_END0,J2END_CD_END0,J2MID_CDb_END0,J2MID_CDa_END0};
	assign LD_I0 = LD_I0_input[ConfigBits[89:88]];
 
// switch matrix multiplexer  LD_I1 		MUX-4
	assign LD_I1_input = {J_l_CD_END1,J2END_CD_END1,J2MID_CDb_END1,J2MID_CDa_END1};
	assign LD_I1 = LD_I1_input[ConfigBits[91:90]];
 
// switch matrix multiplexer  LD_I2 		MUX-4
	assign LD_I2_input = {J_l_CD_END2,J2END_CD_END2,J2MID_CDb_END2,J2MID_CDa_END2};
	assign LD_I2 = LD_I2_input[ConfigBits[93:92]];
 
// switch matrix multiplexer  LD_I3 		MUX-4
	assign LD_I3_input = {J_l_CD_END3,J2END_CD_END3,J2MID_CDb_END3,J2MID_CDa_END3};
	assign LD_I3 = LD_I3_input[ConfigBits[95:94]];
 
// switch matrix multiplexer  LD_Ci 		MUX-1
	assign LD_Ci = LC_Co;
// switch matrix multiplexer  LE_I0 		MUX-4
	assign LE_I0_input = {J_l_EF_END0,J2END_EF_END0,J2MID_EFb_END0,J2MID_EFa_END0};
	assign LE_I0 = LE_I0_input[ConfigBits[97:96]];
 
// switch matrix multiplexer  LE_I1 		MUX-4
	assign LE_I1_input = {J_l_EF_END1,J2END_EF_END1,J2MID_EFb_END1,J2MID_EFa_END1};
	assign LE_I1 = LE_I1_input[ConfigBits[99:98]];
 
// switch matrix multiplexer  LE_I2 		MUX-4
	assign LE_I2_input = {J_l_EF_END2,J2END_EF_END2,J2MID_EFb_END2,J2MID_EFa_END2};
	assign LE_I2 = LE_I2_input[ConfigBits[101:100]];
 
// switch matrix multiplexer  LE_I3 		MUX-4
	assign LE_I3_input = {J_l_EF_END3,J2END_EF_END3,J2MID_EFb_END3,J2MID_EFa_END3};
	assign LE_I3 = LE_I3_input[ConfigBits[103:102]];
 
// switch matrix multiplexer  LE_Ci 		MUX-1
	assign LE_Ci = LD_Co;
// switch matrix multiplexer  LF_I0 		MUX-4
	assign LF_I0_input = {J_l_EF_END0,J2END_EF_END0,J2MID_EFb_END0,J2MID_EFa_END0};
	assign LF_I0 = LF_I0_input[ConfigBits[105:104]];
 
// switch matrix multiplexer  LF_I1 		MUX-4
	assign LF_I1_input = {J_l_EF_END1,J2END_EF_END1,J2MID_EFb_END1,J2MID_EFa_END1};
	assign LF_I1 = LF_I1_input[ConfigBits[107:106]];
 
// switch matrix multiplexer  LF_I2 		MUX-4
	assign LF_I2_input = {J_l_EF_END2,J2END_EF_END2,J2MID_EFb_END2,J2MID_EFa_END2};
	assign LF_I2 = LF_I2_input[ConfigBits[109:108]];
 
// switch matrix multiplexer  LF_I3 		MUX-4
	assign LF_I3_input = {J_l_EF_END3,J2END_EF_END3,J2MID_EFb_END3,J2MID_EFa_END3};
	assign LF_I3 = LF_I3_input[ConfigBits[111:110]];
 
// switch matrix multiplexer  LF_Ci 		MUX-1
	assign LF_Ci = LE_Co;
// switch matrix multiplexer  LG_I0 		MUX-4
	assign LG_I0_input = {J_l_GH_END0,J2END_GH_END0,J2MID_GHb_END0,J2MID_GHa_END0};
	assign LG_I0 = LG_I0_input[ConfigBits[113:112]];
 
// switch matrix multiplexer  LG_I1 		MUX-4
	assign LG_I1_input = {J_l_GH_END1,J2END_GH_END1,J2MID_GHb_END1,J2MID_GHa_END1};
	assign LG_I1 = LG_I1_input[ConfigBits[115:114]];
 
// switch matrix multiplexer  LG_I2 		MUX-4
	assign LG_I2_input = {J_l_GH_END2,J2END_GH_END2,J2MID_GHb_END2,J2MID_GHa_END2};
	assign LG_I2 = LG_I2_input[ConfigBits[117:116]];
 
// switch matrix multiplexer  LG_I3 		MUX-4
	assign LG_I3_input = {J_l_GH_END3,J2END_GH_END3,J2MID_GHb_END3,J2MID_GHa_END3};
	assign LG_I3 = LG_I3_input[ConfigBits[119:118]];
 
// switch matrix multiplexer  LG_Ci 		MUX-1
	assign LG_Ci = LF_Co;
// switch matrix multiplexer  LH_I0 		MUX-4
	assign LH_I0_input = {J_l_GH_END0,J2END_GH_END0,J2MID_GHb_END0,J2MID_GHa_END0};
	assign LH_I0 = LH_I0_input[ConfigBits[121:120]];
 
// switch matrix multiplexer  LH_I1 		MUX-4
	assign LH_I1_input = {J_l_GH_END1,J2END_GH_END1,J2MID_GHb_END1,J2MID_GHa_END1};
	assign LH_I1 = LH_I1_input[ConfigBits[123:122]];
 
// switch matrix multiplexer  LH_I2 		MUX-4
	assign LH_I2_input = {J_l_GH_END2,J2END_GH_END2,J2MID_GHb_END2,J2MID_GHa_END2};
	assign LH_I2 = LH_I2_input[ConfigBits[125:124]];
 
// switch matrix multiplexer  LH_I3 		MUX-4
	assign LH_I3_input = {J_l_GH_END3,J2END_GH_END3,J2MID_GHb_END3,J2MID_GHa_END3};
	assign LH_I3 = LH_I3_input[ConfigBits[127:126]];
 
// switch matrix multiplexer  LH_Ci 		MUX-1
	assign LH_Ci = LG_Co;
// switch matrix multiplexer  A 		MUX-1
	assign A = LA_O;
// switch matrix multiplexer  B 		MUX-1
	assign B = LB_O;
// switch matrix multiplexer  C 		MUX-1
	assign C = LC_O;
// switch matrix multiplexer  D 		MUX-1
	assign D = LD_O;
// switch matrix multiplexer  E 		MUX-1
	assign E = LE_O;
// switch matrix multiplexer  F 		MUX-1
	assign F = LF_O;
// switch matrix multiplexer  G 		MUX-1
	assign G = LG_O;
// switch matrix multiplexer  H 		MUX-1
	assign H = LH_O;
// switch matrix multiplexer  S0 		MUX-4
	assign S0_input = {JW2END4,JS2END4,JE2END4,JN2END4};
	assign S0 = S0_input[ConfigBits[129:128]];
 
// switch matrix multiplexer  S1 		MUX-4
	assign S1_input = {JW2END5,JS2END5,JE2END5,JN2END5};
	assign S1 = S1_input[ConfigBits[131:130]];
 
// switch matrix multiplexer  S2 		MUX-4
	assign S2_input = {JW2END6,JS2END6,JE2END6,JN2END6};
	assign S2 = S2_input[ConfigBits[133:132]];
 
// switch matrix multiplexer  S3 		MUX-4
	assign S3_input = {JW2END7,JS2END7,JE2END7,JN2END7};
	assign S3 = S3_input[ConfigBits[135:134]];
 
// switch matrix multiplexer  J2MID_ABa_BEG0 		MUX-4
	assign J2MID_ABa_BEG0_input = {JN2END3,W2MID6,S2MID6,N2MID6};
	assign J2MID_ABa_BEG0 = J2MID_ABa_BEG0_input[ConfigBits[137:136]];
 
// switch matrix multiplexer  J2MID_ABa_BEG1 		MUX-4
	assign J2MID_ABa_BEG1_input = {JE2END3,W2MID2,S2MID2,E2MID2};
	assign J2MID_ABa_BEG1 = J2MID_ABa_BEG1_input[ConfigBits[139:138]];
 
// switch matrix multiplexer  J2MID_ABa_BEG2 		MUX-4
	assign J2MID_ABa_BEG2_input = {JS2END3,W2MID4,E2MID4,N2MID4};
	assign J2MID_ABa_BEG2 = J2MID_ABa_BEG2_input[ConfigBits[141:140]];
 
// switch matrix multiplexer  J2MID_ABa_BEG3 		MUX-4
	assign J2MID_ABa_BEG3_input = {JW2END3,S2MID0,E2MID0,N2MID0};
	assign J2MID_ABa_BEG3 = J2MID_ABa_BEG3_input[ConfigBits[143:142]];
 
// switch matrix multiplexer  J2MID_CDa_BEG0 		MUX-4
	assign J2MID_CDa_BEG0_input = {JN2END4,W2MID6,S2MID6,E2MID6};
	assign J2MID_CDa_BEG0 = J2MID_CDa_BEG0_input[ConfigBits[145:144]];
 
// switch matrix multiplexer  J2MID_CDa_BEG1 		MUX-4
	assign J2MID_CDa_BEG1_input = {JE2END4,W2MID2,E2MID2,N2MID2};
	assign J2MID_CDa_BEG1 = J2MID_CDa_BEG1_input[ConfigBits[147:146]];
 
// switch matrix multiplexer  J2MID_CDa_BEG2 		MUX-4
	assign J2MID_CDa_BEG2_input = {JS2END4,S2MID4,E2MID4,N2MID4};
	assign J2MID_CDa_BEG2 = J2MID_CDa_BEG2_input[ConfigBits[149:148]];
 
// switch matrix multiplexer  J2MID_CDa_BEG3 		MUX-4
	assign J2MID_CDa_BEG3_input = {JW2END4,W2MID0,S2MID0,N2MID0};
	assign J2MID_CDa_BEG3 = J2MID_CDa_BEG3_input[ConfigBits[151:150]];
 
// switch matrix multiplexer  J2MID_EFa_BEG0 		MUX-4
	assign J2MID_EFa_BEG0_input = {JN2END5,W2MID6,E2MID6,N2MID6};
	assign J2MID_EFa_BEG0 = J2MID_EFa_BEG0_input[ConfigBits[153:152]];
 
// switch matrix multiplexer  J2MID_EFa_BEG1 		MUX-4
	assign J2MID_EFa_BEG1_input = {JE2END5,S2MID2,E2MID2,N2MID2};
	assign J2MID_EFa_BEG1 = J2MID_EFa_BEG1_input[ConfigBits[155:154]];
 
// switch matrix multiplexer  J2MID_EFa_BEG2 		MUX-4
	assign J2MID_EFa_BEG2_input = {JS2END5,W2MID4,S2MID4,N2MID4};
	assign J2MID_EFa_BEG2 = J2MID_EFa_BEG2_input[ConfigBits[157:156]];
 
// switch matrix multiplexer  J2MID_EFa_BEG3 		MUX-4
	assign J2MID_EFa_BEG3_input = {JW2END5,W2MID0,S2MID0,E2MID0};
	assign J2MID_EFa_BEG3 = J2MID_EFa_BEG3_input[ConfigBits[159:158]];
 
// switch matrix multiplexer  J2MID_GHa_BEG0 		MUX-4
	assign J2MID_GHa_BEG0_input = {JN2END6,S2MID6,E2MID6,N2MID6};
	assign J2MID_GHa_BEG0 = J2MID_GHa_BEG0_input[ConfigBits[161:160]];
 
// switch matrix multiplexer  J2MID_GHa_BEG1 		MUX-4
	assign J2MID_GHa_BEG1_input = {JE2END6,W2MID2,S2MID2,N2MID2};
	assign J2MID_GHa_BEG1 = J2MID_GHa_BEG1_input[ConfigBits[163:162]];
 
// switch matrix multiplexer  J2MID_GHa_BEG2 		MUX-4
	assign J2MID_GHa_BEG2_input = {JS2END6,W2MID4,S2MID4,E2MID4};
	assign J2MID_GHa_BEG2 = J2MID_GHa_BEG2_input[ConfigBits[165:164]];
 
// switch matrix multiplexer  J2MID_GHa_BEG3 		MUX-4
	assign J2MID_GHa_BEG3_input = {JW2END6,W2MID0,E2MID0,N2MID0};
	assign J2MID_GHa_BEG3 = J2MID_GHa_BEG3_input[ConfigBits[167:166]];
 
// switch matrix multiplexer  J2MID_ABb_BEG0 		MUX-4
	assign J2MID_ABb_BEG0_input = {W2MID7,S2MID7,E2MID7,N2MID7};
	assign J2MID_ABb_BEG0 = J2MID_ABb_BEG0_input[ConfigBits[169:168]];
 
// switch matrix multiplexer  J2MID_ABb_BEG1 		MUX-4
	assign J2MID_ABb_BEG1_input = {W2MID3,S2MID3,E2MID3,N2MID3};
	assign J2MID_ABb_BEG1 = J2MID_ABb_BEG1_input[ConfigBits[171:170]];
 
// switch matrix multiplexer  J2MID_ABb_BEG2 		MUX-4
	assign J2MID_ABb_BEG2_input = {W2MID5,S2MID5,E2MID5,N2MID5};
	assign J2MID_ABb_BEG2 = J2MID_ABb_BEG2_input[ConfigBits[173:172]];
 
// switch matrix multiplexer  J2MID_ABb_BEG3 		MUX-4
	assign J2MID_ABb_BEG3_input = {W2MID1,S2MID1,E2MID1,N2MID1};
	assign J2MID_ABb_BEG3 = J2MID_ABb_BEG3_input[ConfigBits[175:174]];
 
// switch matrix multiplexer  J2MID_CDb_BEG0 		MUX-4
	assign J2MID_CDb_BEG0_input = {W2MID7,S2MID7,E2MID7,N2MID7};
	assign J2MID_CDb_BEG0 = J2MID_CDb_BEG0_input[ConfigBits[177:176]];
 
// switch matrix multiplexer  J2MID_CDb_BEG1 		MUX-4
	assign J2MID_CDb_BEG1_input = {W2MID3,S2MID3,E2MID3,N2MID3};
	assign J2MID_CDb_BEG1 = J2MID_CDb_BEG1_input[ConfigBits[179:178]];
 
// switch matrix multiplexer  J2MID_CDb_BEG2 		MUX-4
	assign J2MID_CDb_BEG2_input = {W2MID5,S2MID5,E2MID5,N2MID5};
	assign J2MID_CDb_BEG2 = J2MID_CDb_BEG2_input[ConfigBits[181:180]];
 
// switch matrix multiplexer  J2MID_CDb_BEG3 		MUX-4
	assign J2MID_CDb_BEG3_input = {W2MID1,S2MID1,E2MID1,N2MID1};
	assign J2MID_CDb_BEG3 = J2MID_CDb_BEG3_input[ConfigBits[183:182]];
 
// switch matrix multiplexer  J2MID_EFb_BEG0 		MUX-4
	assign J2MID_EFb_BEG0_input = {W2MID7,S2MID7,E2MID7,N2MID7};
	assign J2MID_EFb_BEG0 = J2MID_EFb_BEG0_input[ConfigBits[185:184]];
 
// switch matrix multiplexer  J2MID_EFb_BEG1 		MUX-4
	assign J2MID_EFb_BEG1_input = {W2MID3,S2MID3,E2MID3,N2MID3};
	assign J2MID_EFb_BEG1 = J2MID_EFb_BEG1_input[ConfigBits[187:186]];
 
// switch matrix multiplexer  J2MID_EFb_BEG2 		MUX-4
	assign J2MID_EFb_BEG2_input = {W2MID5,S2MID5,E2MID5,N2MID5};
	assign J2MID_EFb_BEG2 = J2MID_EFb_BEG2_input[ConfigBits[189:188]];
 
// switch matrix multiplexer  J2MID_EFb_BEG3 		MUX-4
	assign J2MID_EFb_BEG3_input = {W2MID1,S2MID1,E2MID1,N2MID1};
	assign J2MID_EFb_BEG3 = J2MID_EFb_BEG3_input[ConfigBits[191:190]];
 
// switch matrix multiplexer  J2MID_GHb_BEG0 		MUX-4
	assign J2MID_GHb_BEG0_input = {W2MID7,S2MID7,E2MID7,N2MID7};
	assign J2MID_GHb_BEG0 = J2MID_GHb_BEG0_input[ConfigBits[193:192]];
 
// switch matrix multiplexer  J2MID_GHb_BEG1 		MUX-4
	assign J2MID_GHb_BEG1_input = {W2MID3,S2MID3,E2MID3,N2MID3};
	assign J2MID_GHb_BEG1 = J2MID_GHb_BEG1_input[ConfigBits[195:194]];
 
// switch matrix multiplexer  J2MID_GHb_BEG2 		MUX-4
	assign J2MID_GHb_BEG2_input = {W2MID5,S2MID5,E2MID5,N2MID5};
	assign J2MID_GHb_BEG2 = J2MID_GHb_BEG2_input[ConfigBits[197:196]];
 
// switch matrix multiplexer  J2MID_GHb_BEG3 		MUX-4
	assign J2MID_GHb_BEG3_input = {W2MID1,S2MID1,E2MID1,N2MID1};
	assign J2MID_GHb_BEG3 = J2MID_GHb_BEG3_input[ConfigBits[199:198]];
 
// switch matrix multiplexer  J2END_AB_BEG0 		MUX-4
	assign J2END_AB_BEG0_input = {W2END6,S2END6,E2END6,N2END6};
	assign J2END_AB_BEG0 = J2END_AB_BEG0_input[ConfigBits[201:200]];
 
// switch matrix multiplexer  J2END_AB_BEG1 		MUX-4
	assign J2END_AB_BEG1_input = {W2END2,S2END2,E2END2,N2END2};
	assign J2END_AB_BEG1 = J2END_AB_BEG1_input[ConfigBits[203:202]];
 
// switch matrix multiplexer  J2END_AB_BEG2 		MUX-4
	assign J2END_AB_BEG2_input = {W2END4,S2END4,E2END4,N2END4};
	assign J2END_AB_BEG2 = J2END_AB_BEG2_input[ConfigBits[205:204]];
 
// switch matrix multiplexer  J2END_AB_BEG3 		MUX-4
	assign J2END_AB_BEG3_input = {W2END0,S2END0,E2END0,N2END0};
	assign J2END_AB_BEG3 = J2END_AB_BEG3_input[ConfigBits[207:206]];
 
// switch matrix multiplexer  J2END_CD_BEG0 		MUX-4
	assign J2END_CD_BEG0_input = {W2END6,S2END6,E2END6,N2END6};
	assign J2END_CD_BEG0 = J2END_CD_BEG0_input[ConfigBits[209:208]];
 
// switch matrix multiplexer  J2END_CD_BEG1 		MUX-4
	assign J2END_CD_BEG1_input = {W2END2,S2END2,E2END2,N2END2};
	assign J2END_CD_BEG1 = J2END_CD_BEG1_input[ConfigBits[211:210]];
 
// switch matrix multiplexer  J2END_CD_BEG2 		MUX-4
	assign J2END_CD_BEG2_input = {W2END4,S2END4,E2END4,N2END4};
	assign J2END_CD_BEG2 = J2END_CD_BEG2_input[ConfigBits[213:212]];
 
// switch matrix multiplexer  J2END_CD_BEG3 		MUX-4
	assign J2END_CD_BEG3_input = {W2END0,S2END0,E2END0,N2END0};
	assign J2END_CD_BEG3 = J2END_CD_BEG3_input[ConfigBits[215:214]];
 
// switch matrix multiplexer  J2END_EF_BEG0 		MUX-4
	assign J2END_EF_BEG0_input = {W2END7,S2END7,E2END7,N2END7};
	assign J2END_EF_BEG0 = J2END_EF_BEG0_input[ConfigBits[217:216]];
 
// switch matrix multiplexer  J2END_EF_BEG1 		MUX-4
	assign J2END_EF_BEG1_input = {W2END3,S2END3,E2END3,N2END3};
	assign J2END_EF_BEG1 = J2END_EF_BEG1_input[ConfigBits[219:218]];
 
// switch matrix multiplexer  J2END_EF_BEG2 		MUX-4
	assign J2END_EF_BEG2_input = {W2END5,S2END5,E2END5,N2END5};
	assign J2END_EF_BEG2 = J2END_EF_BEG2_input[ConfigBits[221:220]];
 
// switch matrix multiplexer  J2END_EF_BEG3 		MUX-4
	assign J2END_EF_BEG3_input = {W2END1,S2END1,E2END1,N2END1};
	assign J2END_EF_BEG3 = J2END_EF_BEG3_input[ConfigBits[223:222]];
 
// switch matrix multiplexer  J2END_GH_BEG0 		MUX-4
	assign J2END_GH_BEG0_input = {W2END7,S2END7,E2END7,N2END7};
	assign J2END_GH_BEG0 = J2END_GH_BEG0_input[ConfigBits[225:224]];
 
// switch matrix multiplexer  J2END_GH_BEG1 		MUX-4
	assign J2END_GH_BEG1_input = {W2END3,S2END3,E2END3,N2END3};
	assign J2END_GH_BEG1 = J2END_GH_BEG1_input[ConfigBits[227:226]];
 
// switch matrix multiplexer  J2END_GH_BEG2 		MUX-4
	assign J2END_GH_BEG2_input = {W2END5,S2END5,E2END5,N2END5};
	assign J2END_GH_BEG2 = J2END_GH_BEG2_input[ConfigBits[229:228]];
 
// switch matrix multiplexer  J2END_GH_BEG3 		MUX-4
	assign J2END_GH_BEG3_input = {W2END1,S2END1,E2END1,N2END1};
	assign J2END_GH_BEG3 = J2END_GH_BEG3_input[ConfigBits[231:230]];
 
// switch matrix multiplexer  JN2BEG0 		MUX-16
	assign JN2BEG0_input = {M_AB,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,W6END1,W2END1,S2END1,E6END1,E2END1,E1END3,N4END1,N2END1};
	assign JN2BEG0 = JN2BEG0_input[ConfigBits[235:232]];
 
// switch matrix multiplexer  JN2BEG1 		MUX-16
	assign JN2BEG1_input = {M_AD,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LA_O,W6END0,W2END2,S2END2,E6END0,E2END2,E1END0,N4END2,N2END2};
	assign JN2BEG1 = JN2BEG1_input[ConfigBits[239:236]];
 
// switch matrix multiplexer  JN2BEG2 		MUX-16
	assign JN2BEG2_input = {M_AH,LH_O,LG_O,LF_O,LE_O,LD_O,LB_O,LA_O,W6END1,W2END3,S2END3,E6END1,E2END3,E1END1,N4END3,N2END3};
	assign JN2BEG2 = JN2BEG2_input[ConfigBits[243:240]];
 
// switch matrix multiplexer  JN2BEG3 		MUX-16
	assign JN2BEG3_input = {M_EF,LH_O,LG_O,LF_O,LE_O,LC_O,LB_O,LA_O,W6END0,W2END4,S2END4,E6END0,E2END4,E1END2,N4END0,N2END4};
	assign JN2BEG3 = JN2BEG3_input[ConfigBits[247:244]];
 
// switch matrix multiplexer  JN2BEG4 		MUX-16
	assign JN2BEG4_input = {M_AB,LH_O,LG_O,LF_O,LD_O,LC_O,LB_O,LA_O,W1END3,W1END1,S2END5,S1END1,E2END5,E1END1,N2END5,N1END1};
	assign JN2BEG4 = JN2BEG4_input[ConfigBits[251:248]];
 
// switch matrix multiplexer  JN2BEG5 		MUX-16
	assign JN2BEG5_input = {M_AD,LH_O,LG_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,W1END0,S2END6,S1END2,E2END6,E1END2,N2END6,N1END2};
	assign JN2BEG5 = JN2BEG5_input[ConfigBits[255:252]];
 
// switch matrix multiplexer  JN2BEG6 		MUX-16
	assign JN2BEG6_input = {M_AH,LH_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,W1END1,S2END7,S1END3,E2END7,E1END3,N2END7,N1END3};
	assign JN2BEG6 = JN2BEG6_input[ConfigBits[259:256]];
 
// switch matrix multiplexer  JN2BEG7 		MUX-16
	assign JN2BEG7_input = {M_EF,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,W1END0,S2END0,S1END0,E2END0,E1END0,N2END0,N1END0};
	assign JN2BEG7 = JN2BEG7_input[ConfigBits[263:260]];
 
// switch matrix multiplexer  JE2BEG0 		MUX-16
	assign JE2BEG0_input = {M_EF,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,W6END1,W2END1,S2END1,E6END1,E2END1,N4END1,N2END1,N1END3};
	assign JE2BEG0 = JE2BEG0_input[ConfigBits[267:264]];
 
// switch matrix multiplexer  JE2BEG1 		MUX-16
	assign JE2BEG1_input = {M_AB,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LA_O,W6END0,W2END2,S2END2,E6END0,E2END2,N4END2,N2END2,N1END0};
	assign JE2BEG1 = JE2BEG1_input[ConfigBits[271:268]];
 
// switch matrix multiplexer  JE2BEG2 		MUX-16
	assign JE2BEG2_input = {M_AD,LH_O,LG_O,LF_O,LE_O,LD_O,LB_O,LA_O,W6END1,W2END3,S2END3,E6END1,E2END3,N4END3,N2END3,N1END1};
	assign JE2BEG2 = JE2BEG2_input[ConfigBits[275:272]];
 
// switch matrix multiplexer  JE2BEG3 		MUX-16
	assign JE2BEG3_input = {M_AH,LH_O,LG_O,LF_O,LE_O,LC_O,LB_O,LA_O,W6END0,W2END4,S2END4,E6END0,E2END4,N4END0,N2END4,N1END2};
	assign JE2BEG3 = JE2BEG3_input[ConfigBits[279:276]];
 
// switch matrix multiplexer  JE2BEG4 		MUX-16
	assign JE2BEG4_input = {M_EF,LH_O,LG_O,LF_O,LD_O,LC_O,LB_O,LA_O,W1END1,S2END5,S1END3,S1END1,E2END5,E1END1,N2END5,N1END1};
	assign JE2BEG4 = JE2BEG4_input[ConfigBits[283:280]];
 
// switch matrix multiplexer  JE2BEG5 		MUX-16
	assign JE2BEG5_input = {M_AB,LH_O,LG_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,S2END6,S1END2,S1END0,E2END6,E1END2,N2END6,N1END2};
	assign JE2BEG5 = JE2BEG5_input[ConfigBits[287:284]];
 
// switch matrix multiplexer  JE2BEG6 		MUX-16
	assign JE2BEG6_input = {M_AD,LH_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,S2END7,S1END3,S1END1,E2END7,E1END3,N2END7,N1END3};
	assign JE2BEG6 = JE2BEG6_input[ConfigBits[291:288]];
 
// switch matrix multiplexer  JE2BEG7 		MUX-16
	assign JE2BEG7_input = {M_AH,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END0,S2END0,S1END2,S1END0,E2END0,E1END0,N2END0,N1END0};
	assign JE2BEG7 = JE2BEG7_input[ConfigBits[295:292]];
 
// switch matrix multiplexer  JS2BEG0 		MUX-16
	assign JS2BEG0_input = {M_AH,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,W6END1,W2END1,S4END1,S2END1,E6END1,E2END1,E1END3,N2END1};
	assign JS2BEG0 = JS2BEG0_input[ConfigBits[299:296]];
 
// switch matrix multiplexer  JS2BEG1 		MUX-16
	assign JS2BEG1_input = {M_EF,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LA_O,W6END0,W2END2,S4END2,S2END2,E6END0,E2END2,E1END0,N2END2};
	assign JS2BEG1 = JS2BEG1_input[ConfigBits[303:300]];
 
// switch matrix multiplexer  JS2BEG2 		MUX-16
	assign JS2BEG2_input = {M_AB,LH_O,LG_O,LF_O,LE_O,LD_O,LB_O,LA_O,W6END1,W2END3,S4END3,S2END3,E6END1,E2END3,E1END1,N2END3};
	assign JS2BEG2 = JS2BEG2_input[ConfigBits[307:304]];
 
// switch matrix multiplexer  JS2BEG3 		MUX-16
	assign JS2BEG3_input = {M_AD,LH_O,LG_O,LF_O,LE_O,LC_O,LB_O,LA_O,W6END0,W2END4,S4END0,S2END4,E6END0,E2END4,E1END2,N2END4};
	assign JS2BEG3 = JS2BEG3_input[ConfigBits[311:308]];
 
// switch matrix multiplexer  JS2BEG4 		MUX-16
	assign JS2BEG4_input = {M_AH,LH_O,LG_O,LF_O,LD_O,LC_O,LB_O,LA_O,W1END3,W1END1,S2END5,S1END1,E2END5,E1END1,N2END5,N1END1};
	assign JS2BEG4 = JS2BEG4_input[ConfigBits[315:312]];
 
// switch matrix multiplexer  JS2BEG5 		MUX-16
	assign JS2BEG5_input = {M_EF,LH_O,LG_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,W1END0,S2END6,S1END2,E2END6,E1END2,N2END6,N1END2};
	assign JS2BEG5 = JS2BEG5_input[ConfigBits[319:316]];
 
// switch matrix multiplexer  JS2BEG6 		MUX-16
	assign JS2BEG6_input = {M_AB,LH_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,W1END1,S2END7,S1END3,E2END7,E1END3,N2END7,N1END3};
	assign JS2BEG6 = JS2BEG6_input[ConfigBits[323:320]];
 
// switch matrix multiplexer  JS2BEG7 		MUX-16
	assign JS2BEG7_input = {M_AD,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,W1END0,S2END0,S1END0,E2END0,E1END0,N2END0,N1END0};
	assign JS2BEG7 = JS2BEG7_input[ConfigBits[327:324]];
 
// switch matrix multiplexer  JW2BEG0 		MUX-16
	assign JW2BEG0_input = {M_AD,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,W6END1,W2END1,S4END1,S2END1,E6END1,E2END1,N2END1,N1END3};
	assign JW2BEG0 = JW2BEG0_input[ConfigBits[331:328]];
 
// switch matrix multiplexer  JW2BEG1 		MUX-16
	assign JW2BEG1_input = {M_AH,LH_O,LG_O,LF_O,LE_O,LD_O,LC_O,LA_O,W6END0,W2END2,S4END2,S2END2,E6END0,E2END2,N2END2,N1END0};
	assign JW2BEG1 = JW2BEG1_input[ConfigBits[335:332]];
 
// switch matrix multiplexer  JW2BEG2 		MUX-16
	assign JW2BEG2_input = {M_EF,LH_O,LG_O,LF_O,LE_O,LD_O,LB_O,LA_O,W6END1,W2END3,S4END3,S2END3,E6END1,E2END3,N2END3,N1END1};
	assign JW2BEG2 = JW2BEG2_input[ConfigBits[339:336]];
 
// switch matrix multiplexer  JW2BEG3 		MUX-16
	assign JW2BEG3_input = {M_AB,LH_O,LG_O,LF_O,LE_O,LC_O,LB_O,LA_O,W6END0,W2END4,S4END0,S2END4,E6END0,E2END4,N2END4,N1END2};
	assign JW2BEG3 = JW2BEG3_input[ConfigBits[343:340]];
 
// switch matrix multiplexer  JW2BEG4 		MUX-16
	assign JW2BEG4_input = {M_AD,LH_O,LG_O,LF_O,LD_O,LC_O,LB_O,LA_O,W1END1,S2END5,S1END3,S1END1,E2END5,E1END1,N2END5,N1END1};
	assign JW2BEG4 = JW2BEG4_input[ConfigBits[347:344]];
 
// switch matrix multiplexer  JW2BEG5 		MUX-16
	assign JW2BEG5_input = {M_AH,LH_O,LG_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END2,S2END6,S1END2,S1END0,E2END6,E1END2,N2END6,N1END2};
	assign JW2BEG5 = JW2BEG5_input[ConfigBits[351:348]];
 
// switch matrix multiplexer  JW2BEG6 		MUX-16
	assign JW2BEG6_input = {M_EF,LH_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END3,S2END7,S1END3,S1END1,E2END7,E1END3,N2END7,N1END3};
	assign JW2BEG6 = JW2BEG6_input[ConfigBits[355:352]];
 
// switch matrix multiplexer  JW2BEG7 		MUX-16
	assign JW2BEG7_input = {M_AB,LG_O,LF_O,LE_O,LD_O,LC_O,LB_O,LA_O,W1END0,S2END0,S1END2,S1END0,E2END0,E1END0,N2END0,N1END0};
	assign JW2BEG7 = JW2BEG7_input[ConfigBits[359:356]];
 
// switch matrix multiplexer  J_l_AB_BEG0 		MUX-4
	assign J_l_AB_BEG0_input = {JN2END1,W2END3,S4END3,N4END3};
	assign J_l_AB_BEG0 = J_l_AB_BEG0_input[ConfigBits[361:360]];
 
// switch matrix multiplexer  J_l_AB_BEG1 		MUX-4
	assign J_l_AB_BEG1_input = {JE2END1,W2END7,S4END2,E2END2};
	assign J_l_AB_BEG1 = J_l_AB_BEG1_input[ConfigBits[363:362]];
 
// switch matrix multiplexer  J_l_AB_BEG2 		MUX-4
	assign J_l_AB_BEG2_input = {JS2END1,W6END1,E6END1,N4END1};
	assign J_l_AB_BEG2 = J_l_AB_BEG2_input[ConfigBits[365:364]];
 
// switch matrix multiplexer  J_l_AB_BEG3 		MUX-4
	assign J_l_AB_BEG3_input = {JW2END1,S4END0,E6END0,N4END0};
	assign J_l_AB_BEG3 = J_l_AB_BEG3_input[ConfigBits[367:366]];
 
// switch matrix multiplexer  J_l_CD_BEG0 		MUX-4
	assign J_l_CD_BEG0_input = {JN2END2,W2END3,S4END3,E2END3};
	assign J_l_CD_BEG0 = J_l_CD_BEG0_input[ConfigBits[369:368]];
 
// switch matrix multiplexer  J_l_CD_BEG1 		MUX-4
	assign J_l_CD_BEG1_input = {JE2END2,W2END7,E2END2,N4END2};
	assign J_l_CD_BEG1 = J_l_CD_BEG1_input[ConfigBits[371:370]];
 
// switch matrix multiplexer  J_l_CD_BEG2 		MUX-4
	assign J_l_CD_BEG2_input = {JS2END2,S4END1,E6END1,N4END1};
	assign J_l_CD_BEG2 = J_l_CD_BEG2_input[ConfigBits[373:372]];
 
// switch matrix multiplexer  J_l_CD_BEG3 		MUX-4
	assign J_l_CD_BEG3_input = {JW2END2,W6END0,S4END0,N4END0};
	assign J_l_CD_BEG3 = J_l_CD_BEG3_input[ConfigBits[375:374]];
 
// switch matrix multiplexer  J_l_EF_BEG0 		MUX-4
	assign J_l_EF_BEG0_input = {JN2END3,W2END3,E2END3,N4END3};
	assign J_l_EF_BEG0 = J_l_EF_BEG0_input[ConfigBits[377:376]];
 
// switch matrix multiplexer  J_l_EF_BEG1 		MUX-4
	assign J_l_EF_BEG1_input = {JE2END3,S4END2,E2END2,N4END2};
	assign J_l_EF_BEG1 = J_l_EF_BEG1_input[ConfigBits[379:378]];
 
// switch matrix multiplexer  J_l_EF_BEG2 		MUX-4
	assign J_l_EF_BEG2_input = {JS2END3,W2END4,S4END1,N4END1};
	assign J_l_EF_BEG2 = J_l_EF_BEG2_input[ConfigBits[381:380]];
 
// switch matrix multiplexer  J_l_EF_BEG3 		MUX-4
	assign J_l_EF_BEG3_input = {JW2END3,W2END0,S4END0,E6END0};
	assign J_l_EF_BEG3 = J_l_EF_BEG3_input[ConfigBits[383:382]];
 
// switch matrix multiplexer  J_l_GH_BEG0 		MUX-4
	assign J_l_GH_BEG0_input = {JN2END4,S4END3,E2END3,N4END3};
	assign J_l_GH_BEG0 = J_l_GH_BEG0_input[ConfigBits[385:384]];
 
// switch matrix multiplexer  J_l_GH_BEG1 		MUX-4
	assign J_l_GH_BEG1_input = {JE2END4,W2END2,S4END2,N4END2};
	assign J_l_GH_BEG1 = J_l_GH_BEG1_input[ConfigBits[387:386]];
 
// switch matrix multiplexer  J_l_GH_BEG2 		MUX-4
	assign J_l_GH_BEG2_input = {JS2END4,W2END4,S4END1,E6END1};
	assign J_l_GH_BEG2 = J_l_GH_BEG2_input[ConfigBits[389:388]];
 
// switch matrix multiplexer  J_l_GH_BEG3 		MUX-4
	assign J_l_GH_BEG3_input = {JW2END4,W2END0,E6END0,N4END0};
	assign J_l_GH_BEG3 = J_l_GH_BEG3_input[ConfigBits[391:390]];
 
	assign DEBUG_select_N1BEG0 = ConfigBits[1:0];
	assign DEBUG_select_N1BEG1 = ConfigBits[3:2];
	assign DEBUG_select_N1BEG2 = ConfigBits[5:4];
	assign DEBUG_select_N1BEG3 = ConfigBits[7:6];
	assign DEBUG_select_N4BEG0 = ConfigBits[9:8];
	assign DEBUG_select_N4BEG1 = ConfigBits[11:10];
	assign DEBUG_select_N4BEG2 = ConfigBits[13:12];
	assign DEBUG_select_N4BEG3 = ConfigBits[15:14];
	assign DEBUG_select_E1BEG0 = ConfigBits[17:16];
	assign DEBUG_select_E1BEG1 = ConfigBits[19:18];
	assign DEBUG_select_E1BEG2 = ConfigBits[21:20];
	assign DEBUG_select_E1BEG3 = ConfigBits[23:22];
	assign DEBUG_select_E6BEG0 = ConfigBits[27:24];
	assign DEBUG_select_E6BEG1 = ConfigBits[31:28];
	assign DEBUG_select_S1BEG0 = ConfigBits[33:32];
	assign DEBUG_select_S1BEG1 = ConfigBits[35:34];
	assign DEBUG_select_S1BEG2 = ConfigBits[37:36];
	assign DEBUG_select_S1BEG3 = ConfigBits[39:38];
	assign DEBUG_select_S4BEG0 = ConfigBits[41:40];
	assign DEBUG_select_S4BEG1 = ConfigBits[43:42];
	assign DEBUG_select_S4BEG2 = ConfigBits[45:44];
	assign DEBUG_select_S4BEG3 = ConfigBits[47:46];
	assign DEBUG_select_W1BEG0 = ConfigBits[49:48];
	assign DEBUG_select_W1BEG1 = ConfigBits[51:50];
	assign DEBUG_select_W1BEG2 = ConfigBits[53:52];
	assign DEBUG_select_W1BEG3 = ConfigBits[55:54];
	assign DEBUG_select_W6BEG0 = ConfigBits[59:56];
	assign DEBUG_select_W6BEG1 = ConfigBits[63:60];
	assign DEBUG_select_LA_I0 = ConfigBits[65:64];
	assign DEBUG_select_LA_I1 = ConfigBits[67:66];
	assign DEBUG_select_LA_I2 = ConfigBits[69:68];
	assign DEBUG_select_LA_I3 = ConfigBits[71:70];
	assign DEBUG_select_LB_I0 = ConfigBits[73:72];
	assign DEBUG_select_LB_I1 = ConfigBits[75:74];
	assign DEBUG_select_LB_I2 = ConfigBits[77:76];
	assign DEBUG_select_LB_I3 = ConfigBits[79:78];
	assign DEBUG_select_LC_I0 = ConfigBits[81:80];
	assign DEBUG_select_LC_I1 = ConfigBits[83:82];
	assign DEBUG_select_LC_I2 = ConfigBits[85:84];
	assign DEBUG_select_LC_I3 = ConfigBits[87:86];
	assign DEBUG_select_LD_I0 = ConfigBits[89:88];
	assign DEBUG_select_LD_I1 = ConfigBits[91:90];
	assign DEBUG_select_LD_I2 = ConfigBits[93:92];
	assign DEBUG_select_LD_I3 = ConfigBits[95:94];
	assign DEBUG_select_LE_I0 = ConfigBits[97:96];
	assign DEBUG_select_LE_I1 = ConfigBits[99:98];
	assign DEBUG_select_LE_I2 = ConfigBits[101:100];
	assign DEBUG_select_LE_I3 = ConfigBits[103:102];
	assign DEBUG_select_LF_I0 = ConfigBits[105:104];
	assign DEBUG_select_LF_I1 = ConfigBits[107:106];
	assign DEBUG_select_LF_I2 = ConfigBits[109:108];
	assign DEBUG_select_LF_I3 = ConfigBits[111:110];
	assign DEBUG_select_LG_I0 = ConfigBits[113:112];
	assign DEBUG_select_LG_I1 = ConfigBits[115:114];
	assign DEBUG_select_LG_I2 = ConfigBits[117:116];
	assign DEBUG_select_LG_I3 = ConfigBits[119:118];
	assign DEBUG_select_LH_I0 = ConfigBits[121:120];
	assign DEBUG_select_LH_I1 = ConfigBits[123:122];
	assign DEBUG_select_LH_I2 = ConfigBits[125:124];
	assign DEBUG_select_LH_I3 = ConfigBits[127:126];
	assign DEBUG_select_S0 = ConfigBits[129:128];
	assign DEBUG_select_S1 = ConfigBits[131:130];
	assign DEBUG_select_S2 = ConfigBits[133:132];
	assign DEBUG_select_S3 = ConfigBits[135:134];
	assign DEBUG_select_J2MID_ABa_BEG0 = ConfigBits[137:136];
	assign DEBUG_select_J2MID_ABa_BEG1 = ConfigBits[139:138];
	assign DEBUG_select_J2MID_ABa_BEG2 = ConfigBits[141:140];
	assign DEBUG_select_J2MID_ABa_BEG3 = ConfigBits[143:142];
	assign DEBUG_select_J2MID_CDa_BEG0 = ConfigBits[145:144];
	assign DEBUG_select_J2MID_CDa_BEG1 = ConfigBits[147:146];
	assign DEBUG_select_J2MID_CDa_BEG2 = ConfigBits[149:148];
	assign DEBUG_select_J2MID_CDa_BEG3 = ConfigBits[151:150];
	assign DEBUG_select_J2MID_EFa_BEG0 = ConfigBits[153:152];
	assign DEBUG_select_J2MID_EFa_BEG1 = ConfigBits[155:154];
	assign DEBUG_select_J2MID_EFa_BEG2 = ConfigBits[157:156];
	assign DEBUG_select_J2MID_EFa_BEG3 = ConfigBits[159:158];
	assign DEBUG_select_J2MID_GHa_BEG0 = ConfigBits[161:160];
	assign DEBUG_select_J2MID_GHa_BEG1 = ConfigBits[163:162];
	assign DEBUG_select_J2MID_GHa_BEG2 = ConfigBits[165:164];
	assign DEBUG_select_J2MID_GHa_BEG3 = ConfigBits[167:166];
	assign DEBUG_select_J2MID_ABb_BEG0 = ConfigBits[169:168];
	assign DEBUG_select_J2MID_ABb_BEG1 = ConfigBits[171:170];
	assign DEBUG_select_J2MID_ABb_BEG2 = ConfigBits[173:172];
	assign DEBUG_select_J2MID_ABb_BEG3 = ConfigBits[175:174];
	assign DEBUG_select_J2MID_CDb_BEG0 = ConfigBits[177:176];
	assign DEBUG_select_J2MID_CDb_BEG1 = ConfigBits[179:178];
	assign DEBUG_select_J2MID_CDb_BEG2 = ConfigBits[181:180];
	assign DEBUG_select_J2MID_CDb_BEG3 = ConfigBits[183:182];
	assign DEBUG_select_J2MID_EFb_BEG0 = ConfigBits[185:184];
	assign DEBUG_select_J2MID_EFb_BEG1 = ConfigBits[187:186];
	assign DEBUG_select_J2MID_EFb_BEG2 = ConfigBits[189:188];
	assign DEBUG_select_J2MID_EFb_BEG3 = ConfigBits[191:190];
	assign DEBUG_select_J2MID_GHb_BEG0 = ConfigBits[193:192];
	assign DEBUG_select_J2MID_GHb_BEG1 = ConfigBits[195:194];
	assign DEBUG_select_J2MID_GHb_BEG2 = ConfigBits[197:196];
	assign DEBUG_select_J2MID_GHb_BEG3 = ConfigBits[199:198];
	assign DEBUG_select_J2END_AB_BEG0 = ConfigBits[201:200];
	assign DEBUG_select_J2END_AB_BEG1 = ConfigBits[203:202];
	assign DEBUG_select_J2END_AB_BEG2 = ConfigBits[205:204];
	assign DEBUG_select_J2END_AB_BEG3 = ConfigBits[207:206];
	assign DEBUG_select_J2END_CD_BEG0 = ConfigBits[209:208];
	assign DEBUG_select_J2END_CD_BEG1 = ConfigBits[211:210];
	assign DEBUG_select_J2END_CD_BEG2 = ConfigBits[213:212];
	assign DEBUG_select_J2END_CD_BEG3 = ConfigBits[215:214];
	assign DEBUG_select_J2END_EF_BEG0 = ConfigBits[217:216];
	assign DEBUG_select_J2END_EF_BEG1 = ConfigBits[219:218];
	assign DEBUG_select_J2END_EF_BEG2 = ConfigBits[221:220];
	assign DEBUG_select_J2END_EF_BEG3 = ConfigBits[223:222];
	assign DEBUG_select_J2END_GH_BEG0 = ConfigBits[225:224];
	assign DEBUG_select_J2END_GH_BEG1 = ConfigBits[227:226];
	assign DEBUG_select_J2END_GH_BEG2 = ConfigBits[229:228];
	assign DEBUG_select_J2END_GH_BEG3 = ConfigBits[231:230];
	assign DEBUG_select_JN2BEG0 = ConfigBits[235:232];
	assign DEBUG_select_JN2BEG1 = ConfigBits[239:236];
	assign DEBUG_select_JN2BEG2 = ConfigBits[243:240];
	assign DEBUG_select_JN2BEG3 = ConfigBits[247:244];
	assign DEBUG_select_JN2BEG4 = ConfigBits[251:248];
	assign DEBUG_select_JN2BEG5 = ConfigBits[255:252];
	assign DEBUG_select_JN2BEG6 = ConfigBits[259:256];
	assign DEBUG_select_JN2BEG7 = ConfigBits[263:260];
	assign DEBUG_select_JE2BEG0 = ConfigBits[267:264];
	assign DEBUG_select_JE2BEG1 = ConfigBits[271:268];
	assign DEBUG_select_JE2BEG2 = ConfigBits[275:272];
	assign DEBUG_select_JE2BEG3 = ConfigBits[279:276];
	assign DEBUG_select_JE2BEG4 = ConfigBits[283:280];
	assign DEBUG_select_JE2BEG5 = ConfigBits[287:284];
	assign DEBUG_select_JE2BEG6 = ConfigBits[291:288];
	assign DEBUG_select_JE2BEG7 = ConfigBits[295:292];
	assign DEBUG_select_JS2BEG0 = ConfigBits[299:296];
	assign DEBUG_select_JS2BEG1 = ConfigBits[303:300];
	assign DEBUG_select_JS2BEG2 = ConfigBits[307:304];
	assign DEBUG_select_JS2BEG3 = ConfigBits[311:308];
	assign DEBUG_select_JS2BEG4 = ConfigBits[315:312];
	assign DEBUG_select_JS2BEG5 = ConfigBits[319:316];
	assign DEBUG_select_JS2BEG6 = ConfigBits[323:320];
	assign DEBUG_select_JS2BEG7 = ConfigBits[327:324];
	assign DEBUG_select_JW2BEG0 = ConfigBits[331:328];
	assign DEBUG_select_JW2BEG1 = ConfigBits[335:332];
	assign DEBUG_select_JW2BEG2 = ConfigBits[339:336];
	assign DEBUG_select_JW2BEG3 = ConfigBits[343:340];
	assign DEBUG_select_JW2BEG4 = ConfigBits[347:344];
	assign DEBUG_select_JW2BEG5 = ConfigBits[351:348];
	assign DEBUG_select_JW2BEG6 = ConfigBits[355:352];
	assign DEBUG_select_JW2BEG7 = ConfigBits[359:356];
	assign DEBUG_select_J_l_AB_BEG0 = ConfigBits[361:360];
	assign DEBUG_select_J_l_AB_BEG1 = ConfigBits[363:362];
	assign DEBUG_select_J_l_AB_BEG2 = ConfigBits[365:364];
	assign DEBUG_select_J_l_AB_BEG3 = ConfigBits[367:366];
	assign DEBUG_select_J_l_CD_BEG0 = ConfigBits[369:368];
	assign DEBUG_select_J_l_CD_BEG1 = ConfigBits[371:370];
	assign DEBUG_select_J_l_CD_BEG2 = ConfigBits[373:372];
	assign DEBUG_select_J_l_CD_BEG3 = ConfigBits[375:374];
	assign DEBUG_select_J_l_EF_BEG0 = ConfigBits[377:376];
	assign DEBUG_select_J_l_EF_BEG1 = ConfigBits[379:378];
	assign DEBUG_select_J_l_EF_BEG2 = ConfigBits[381:380];
	assign DEBUG_select_J_l_EF_BEG3 = ConfigBits[383:382];
	assign DEBUG_select_J_l_GH_BEG0 = ConfigBits[385:384];
	assign DEBUG_select_J_l_GH_BEG1 = ConfigBits[387:386];
	assign DEBUG_select_J_l_GH_BEG2 = ConfigBits[389:388];
	assign DEBUG_select_J_l_GH_BEG3 = ConfigBits[391:390];

endmodule
