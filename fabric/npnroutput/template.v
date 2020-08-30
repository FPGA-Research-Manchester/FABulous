module template ();
wire Tile_X0Y8_A_I, Tile_X0Y8_A_T, Tile_X0Y8_A_O, Tile_X0Y8_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y8_A (.O(Tile_X0Y8_A_O), .Q(Tile_X0Y8_A_Q), .I(Tile_X0Y8_A_I), .T(Tile_X0Y8_A_T));

wire Tile_X0Y8_B_I, Tile_X0Y8_B_T, Tile_X0Y8_B_O, Tile_X0Y8_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y8_B (.O(Tile_X0Y8_B_O), .Q(Tile_X0Y8_B_Q), .I(Tile_X0Y8_B_I), .T(Tile_X0Y8_B_T));

wire Tile_X9Y8_OPA_O0, Tile_X9Y8_OPA_O1, Tile_X9Y8_OPA_O2, Tile_X9Y8_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y8_A (.O0(Tile_X9Y8_OPA_O0), .O1(Tile_X9Y8_OPA_O1), .O2(Tile_X9Y8_OPA_O2), .O3(Tile_X9Y8_OPA_O3));

wire Tile_X9Y8_OPB_O0, Tile_X9Y8_OPB_O1, Tile_X9Y8_OPB_O2, Tile_X9Y8_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y8_B (.O0(Tile_X9Y8_OPB_O0), .O1(Tile_X9Y8_OPB_O1), .O2(Tile_X9Y8_OPB_O2), .O3(Tile_X9Y8_OPB_O3));

wire Tile_X9Y8_RES0_I0, Tile_X9Y8_RES0_I1, Tile_X9Y8_RES0_I2, Tile_X9Y8_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y8_C (.I0(Tile_X9Y8_RES0_I0), .I1(Tile_X9Y8_RES0_I1), .I2(Tile_X9Y8_RES0_I2), .I3(Tile_X9Y8_RES0_I3));

wire Tile_X9Y8_RES1_I0, Tile_X9Y8_RES1_I1, Tile_X9Y8_RES1_I2, Tile_X9Y8_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y8_D (.I0(Tile_X9Y8_RES1_I0), .I1(Tile_X9Y8_RES1_I1), .I2(Tile_X9Y8_RES1_I2), .I3(Tile_X9Y8_RES1_I3));

wire Tile_X9Y8_RES2_I0, Tile_X9Y8_RES2_I1, Tile_X9Y8_RES2_I2, Tile_X9Y8_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y8_E (.I0(Tile_X9Y8_RES2_I0), .I1(Tile_X9Y8_RES2_I1), .I2(Tile_X9Y8_RES2_I2), .I3(Tile_X9Y8_RES2_I3));

wire Tile_X0Y7_A_I, Tile_X0Y7_A_T, Tile_X0Y7_A_O, Tile_X0Y7_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y7_A (.O(Tile_X0Y7_A_O), .Q(Tile_X0Y7_A_Q), .I(Tile_X0Y7_A_I), .T(Tile_X0Y7_A_T));

wire Tile_X0Y7_B_I, Tile_X0Y7_B_T, Tile_X0Y7_B_O, Tile_X0Y7_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y7_B (.O(Tile_X0Y7_B_O), .Q(Tile_X0Y7_B_Q), .I(Tile_X0Y7_B_I), .T(Tile_X0Y7_B_T));

wire Tile_X9Y7_OPA_O0, Tile_X9Y7_OPA_O1, Tile_X9Y7_OPA_O2, Tile_X9Y7_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y7_A (.O0(Tile_X9Y7_OPA_O0), .O1(Tile_X9Y7_OPA_O1), .O2(Tile_X9Y7_OPA_O2), .O3(Tile_X9Y7_OPA_O3));

wire Tile_X9Y7_OPB_O0, Tile_X9Y7_OPB_O1, Tile_X9Y7_OPB_O2, Tile_X9Y7_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y7_B (.O0(Tile_X9Y7_OPB_O0), .O1(Tile_X9Y7_OPB_O1), .O2(Tile_X9Y7_OPB_O2), .O3(Tile_X9Y7_OPB_O3));

wire Tile_X9Y7_RES0_I0, Tile_X9Y7_RES0_I1, Tile_X9Y7_RES0_I2, Tile_X9Y7_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y7_C (.I0(Tile_X9Y7_RES0_I0), .I1(Tile_X9Y7_RES0_I1), .I2(Tile_X9Y7_RES0_I2), .I3(Tile_X9Y7_RES0_I3));

wire Tile_X9Y7_RES1_I0, Tile_X9Y7_RES1_I1, Tile_X9Y7_RES1_I2, Tile_X9Y7_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y7_D (.I0(Tile_X9Y7_RES1_I0), .I1(Tile_X9Y7_RES1_I1), .I2(Tile_X9Y7_RES1_I2), .I3(Tile_X9Y7_RES1_I3));

wire Tile_X9Y7_RES2_I0, Tile_X9Y7_RES2_I1, Tile_X9Y7_RES2_I2, Tile_X9Y7_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y7_E (.I0(Tile_X9Y7_RES2_I0), .I1(Tile_X9Y7_RES2_I1), .I2(Tile_X9Y7_RES2_I2), .I3(Tile_X9Y7_RES2_I3));

wire Tile_X0Y6_A_I, Tile_X0Y6_A_T, Tile_X0Y6_A_O, Tile_X0Y6_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y6_A (.O(Tile_X0Y6_A_O), .Q(Tile_X0Y6_A_Q), .I(Tile_X0Y6_A_I), .T(Tile_X0Y6_A_T));

wire Tile_X0Y6_B_I, Tile_X0Y6_B_T, Tile_X0Y6_B_O, Tile_X0Y6_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y6_B (.O(Tile_X0Y6_B_O), .Q(Tile_X0Y6_B_Q), .I(Tile_X0Y6_B_I), .T(Tile_X0Y6_B_T));

wire Tile_X9Y6_OPA_O0, Tile_X9Y6_OPA_O1, Tile_X9Y6_OPA_O2, Tile_X9Y6_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y6_A (.O0(Tile_X9Y6_OPA_O0), .O1(Tile_X9Y6_OPA_O1), .O2(Tile_X9Y6_OPA_O2), .O3(Tile_X9Y6_OPA_O3));

wire Tile_X9Y6_OPB_O0, Tile_X9Y6_OPB_O1, Tile_X9Y6_OPB_O2, Tile_X9Y6_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y6_B (.O0(Tile_X9Y6_OPB_O0), .O1(Tile_X9Y6_OPB_O1), .O2(Tile_X9Y6_OPB_O2), .O3(Tile_X9Y6_OPB_O3));

wire Tile_X9Y6_RES0_I0, Tile_X9Y6_RES0_I1, Tile_X9Y6_RES0_I2, Tile_X9Y6_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y6_C (.I0(Tile_X9Y6_RES0_I0), .I1(Tile_X9Y6_RES0_I1), .I2(Tile_X9Y6_RES0_I2), .I3(Tile_X9Y6_RES0_I3));

wire Tile_X9Y6_RES1_I0, Tile_X9Y6_RES1_I1, Tile_X9Y6_RES1_I2, Tile_X9Y6_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y6_D (.I0(Tile_X9Y6_RES1_I0), .I1(Tile_X9Y6_RES1_I1), .I2(Tile_X9Y6_RES1_I2), .I3(Tile_X9Y6_RES1_I3));

wire Tile_X9Y6_RES2_I0, Tile_X9Y6_RES2_I1, Tile_X9Y6_RES2_I2, Tile_X9Y6_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y6_E (.I0(Tile_X9Y6_RES2_I0), .I1(Tile_X9Y6_RES2_I1), .I2(Tile_X9Y6_RES2_I2), .I3(Tile_X9Y6_RES2_I3));

wire Tile_X0Y5_A_I, Tile_X0Y5_A_T, Tile_X0Y5_A_O, Tile_X0Y5_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y5_A (.O(Tile_X0Y5_A_O), .Q(Tile_X0Y5_A_Q), .I(Tile_X0Y5_A_I), .T(Tile_X0Y5_A_T));

wire Tile_X0Y5_B_I, Tile_X0Y5_B_T, Tile_X0Y5_B_O, Tile_X0Y5_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y5_B (.O(Tile_X0Y5_B_O), .Q(Tile_X0Y5_B_Q), .I(Tile_X0Y5_B_I), .T(Tile_X0Y5_B_T));

wire Tile_X9Y5_OPA_O0, Tile_X9Y5_OPA_O1, Tile_X9Y5_OPA_O2, Tile_X9Y5_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y5_A (.O0(Tile_X9Y5_OPA_O0), .O1(Tile_X9Y5_OPA_O1), .O2(Tile_X9Y5_OPA_O2), .O3(Tile_X9Y5_OPA_O3));

wire Tile_X9Y5_OPB_O0, Tile_X9Y5_OPB_O1, Tile_X9Y5_OPB_O2, Tile_X9Y5_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y5_B (.O0(Tile_X9Y5_OPB_O0), .O1(Tile_X9Y5_OPB_O1), .O2(Tile_X9Y5_OPB_O2), .O3(Tile_X9Y5_OPB_O3));

wire Tile_X9Y5_RES0_I0, Tile_X9Y5_RES0_I1, Tile_X9Y5_RES0_I2, Tile_X9Y5_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y5_C (.I0(Tile_X9Y5_RES0_I0), .I1(Tile_X9Y5_RES0_I1), .I2(Tile_X9Y5_RES0_I2), .I3(Tile_X9Y5_RES0_I3));

wire Tile_X9Y5_RES1_I0, Tile_X9Y5_RES1_I1, Tile_X9Y5_RES1_I2, Tile_X9Y5_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y5_D (.I0(Tile_X9Y5_RES1_I0), .I1(Tile_X9Y5_RES1_I1), .I2(Tile_X9Y5_RES1_I2), .I3(Tile_X9Y5_RES1_I3));

wire Tile_X9Y5_RES2_I0, Tile_X9Y5_RES2_I1, Tile_X9Y5_RES2_I2, Tile_X9Y5_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y5_E (.I0(Tile_X9Y5_RES2_I0), .I1(Tile_X9Y5_RES2_I1), .I2(Tile_X9Y5_RES2_I2), .I3(Tile_X9Y5_RES2_I3));

wire Tile_X0Y4_A_I, Tile_X0Y4_A_T, Tile_X0Y4_A_O, Tile_X0Y4_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y4_A (.O(Tile_X0Y4_A_O), .Q(Tile_X0Y4_A_Q), .I(Tile_X0Y4_A_I), .T(Tile_X0Y4_A_T));

wire Tile_X0Y4_B_I, Tile_X0Y4_B_T, Tile_X0Y4_B_O, Tile_X0Y4_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y4_B (.O(Tile_X0Y4_B_O), .Q(Tile_X0Y4_B_Q), .I(Tile_X0Y4_B_I), .T(Tile_X0Y4_B_T));

wire Tile_X9Y4_OPA_O0, Tile_X9Y4_OPA_O1, Tile_X9Y4_OPA_O2, Tile_X9Y4_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y4_A (.O0(Tile_X9Y4_OPA_O0), .O1(Tile_X9Y4_OPA_O1), .O2(Tile_X9Y4_OPA_O2), .O3(Tile_X9Y4_OPA_O3));

wire Tile_X9Y4_OPB_O0, Tile_X9Y4_OPB_O1, Tile_X9Y4_OPB_O2, Tile_X9Y4_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y4_B (.O0(Tile_X9Y4_OPB_O0), .O1(Tile_X9Y4_OPB_O1), .O2(Tile_X9Y4_OPB_O2), .O3(Tile_X9Y4_OPB_O3));

wire Tile_X9Y4_RES0_I0, Tile_X9Y4_RES0_I1, Tile_X9Y4_RES0_I2, Tile_X9Y4_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y4_C (.I0(Tile_X9Y4_RES0_I0), .I1(Tile_X9Y4_RES0_I1), .I2(Tile_X9Y4_RES0_I2), .I3(Tile_X9Y4_RES0_I3));

wire Tile_X9Y4_RES1_I0, Tile_X9Y4_RES1_I1, Tile_X9Y4_RES1_I2, Tile_X9Y4_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y4_D (.I0(Tile_X9Y4_RES1_I0), .I1(Tile_X9Y4_RES1_I1), .I2(Tile_X9Y4_RES1_I2), .I3(Tile_X9Y4_RES1_I3));

wire Tile_X9Y4_RES2_I0, Tile_X9Y4_RES2_I1, Tile_X9Y4_RES2_I2, Tile_X9Y4_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y4_E (.I0(Tile_X9Y4_RES2_I0), .I1(Tile_X9Y4_RES2_I1), .I2(Tile_X9Y4_RES2_I2), .I3(Tile_X9Y4_RES2_I3));

wire Tile_X0Y3_A_I, Tile_X0Y3_A_T, Tile_X0Y3_A_O, Tile_X0Y3_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y3_A (.O(Tile_X0Y3_A_O), .Q(Tile_X0Y3_A_Q), .I(Tile_X0Y3_A_I), .T(Tile_X0Y3_A_T));

wire Tile_X0Y3_B_I, Tile_X0Y3_B_T, Tile_X0Y3_B_O, Tile_X0Y3_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y3_B (.O(Tile_X0Y3_B_O), .Q(Tile_X0Y3_B_Q), .I(Tile_X0Y3_B_I), .T(Tile_X0Y3_B_T));

wire Tile_X9Y3_OPA_O0, Tile_X9Y3_OPA_O1, Tile_X9Y3_OPA_O2, Tile_X9Y3_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y3_A (.O0(Tile_X9Y3_OPA_O0), .O1(Tile_X9Y3_OPA_O1), .O2(Tile_X9Y3_OPA_O2), .O3(Tile_X9Y3_OPA_O3));

wire Tile_X9Y3_OPB_O0, Tile_X9Y3_OPB_O1, Tile_X9Y3_OPB_O2, Tile_X9Y3_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y3_B (.O0(Tile_X9Y3_OPB_O0), .O1(Tile_X9Y3_OPB_O1), .O2(Tile_X9Y3_OPB_O2), .O3(Tile_X9Y3_OPB_O3));

wire Tile_X9Y3_RES0_I0, Tile_X9Y3_RES0_I1, Tile_X9Y3_RES0_I2, Tile_X9Y3_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y3_C (.I0(Tile_X9Y3_RES0_I0), .I1(Tile_X9Y3_RES0_I1), .I2(Tile_X9Y3_RES0_I2), .I3(Tile_X9Y3_RES0_I3));

wire Tile_X9Y3_RES1_I0, Tile_X9Y3_RES1_I1, Tile_X9Y3_RES1_I2, Tile_X9Y3_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y3_D (.I0(Tile_X9Y3_RES1_I0), .I1(Tile_X9Y3_RES1_I1), .I2(Tile_X9Y3_RES1_I2), .I3(Tile_X9Y3_RES1_I3));

wire Tile_X9Y3_RES2_I0, Tile_X9Y3_RES2_I1, Tile_X9Y3_RES2_I2, Tile_X9Y3_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y3_E (.I0(Tile_X9Y3_RES2_I0), .I1(Tile_X9Y3_RES2_I1), .I2(Tile_X9Y3_RES2_I2), .I3(Tile_X9Y3_RES2_I3));

wire Tile_X0Y2_A_I, Tile_X0Y2_A_T, Tile_X0Y2_A_O, Tile_X0Y2_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y2_A (.O(Tile_X0Y2_A_O), .Q(Tile_X0Y2_A_Q), .I(Tile_X0Y2_A_I), .T(Tile_X0Y2_A_T));

wire Tile_X0Y2_B_I, Tile_X0Y2_B_T, Tile_X0Y2_B_O, Tile_X0Y2_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y2_B (.O(Tile_X0Y2_B_O), .Q(Tile_X0Y2_B_Q), .I(Tile_X0Y2_B_I), .T(Tile_X0Y2_B_T));

wire Tile_X9Y2_OPA_O0, Tile_X9Y2_OPA_O1, Tile_X9Y2_OPA_O2, Tile_X9Y2_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y2_A (.O0(Tile_X9Y2_OPA_O0), .O1(Tile_X9Y2_OPA_O1), .O2(Tile_X9Y2_OPA_O2), .O3(Tile_X9Y2_OPA_O3));

wire Tile_X9Y2_OPB_O0, Tile_X9Y2_OPB_O1, Tile_X9Y2_OPB_O2, Tile_X9Y2_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y2_B (.O0(Tile_X9Y2_OPB_O0), .O1(Tile_X9Y2_OPB_O1), .O2(Tile_X9Y2_OPB_O2), .O3(Tile_X9Y2_OPB_O3));

wire Tile_X9Y2_RES0_I0, Tile_X9Y2_RES0_I1, Tile_X9Y2_RES0_I2, Tile_X9Y2_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y2_C (.I0(Tile_X9Y2_RES0_I0), .I1(Tile_X9Y2_RES0_I1), .I2(Tile_X9Y2_RES0_I2), .I3(Tile_X9Y2_RES0_I3));

wire Tile_X9Y2_RES1_I0, Tile_X9Y2_RES1_I1, Tile_X9Y2_RES1_I2, Tile_X9Y2_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y2_D (.I0(Tile_X9Y2_RES1_I0), .I1(Tile_X9Y2_RES1_I1), .I2(Tile_X9Y2_RES1_I2), .I3(Tile_X9Y2_RES1_I3));

wire Tile_X9Y2_RES2_I0, Tile_X9Y2_RES2_I1, Tile_X9Y2_RES2_I2, Tile_X9Y2_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y2_E (.I0(Tile_X9Y2_RES2_I0), .I1(Tile_X9Y2_RES2_I1), .I2(Tile_X9Y2_RES2_I2), .I3(Tile_X9Y2_RES2_I3));

wire Tile_X0Y1_A_I, Tile_X0Y1_A_T, Tile_X0Y1_A_O, Tile_X0Y1_A_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y1_A (.O(Tile_X0Y1_A_O), .Q(Tile_X0Y1_A_Q), .I(Tile_X0Y1_A_I), .T(Tile_X0Y1_A_T));

wire Tile_X0Y1_B_I, Tile_X0Y1_B_T, Tile_X0Y1_B_O, Tile_X0Y1_B_Q;
(* keep *) IO_1_bidirectional_frame_config_pass Tile_X0Y1_B (.O(Tile_X0Y1_B_O), .Q(Tile_X0Y1_B_Q), .I(Tile_X0Y1_B_I), .T(Tile_X0Y1_B_T));

wire Tile_X9Y1_OPA_O0, Tile_X9Y1_OPA_O1, Tile_X9Y1_OPA_O2, Tile_X9Y1_OPA_O3;
(* keep *) InPass4_frame_config Tile_X9Y1_A (.O0(Tile_X9Y1_OPA_O0), .O1(Tile_X9Y1_OPA_O1), .O2(Tile_X9Y1_OPA_O2), .O3(Tile_X9Y1_OPA_O3));

wire Tile_X9Y1_OPB_O0, Tile_X9Y1_OPB_O1, Tile_X9Y1_OPB_O2, Tile_X9Y1_OPB_O3;
(* keep *) InPass4_frame_config Tile_X9Y1_B (.O0(Tile_X9Y1_OPB_O0), .O1(Tile_X9Y1_OPB_O1), .O2(Tile_X9Y1_OPB_O2), .O3(Tile_X9Y1_OPB_O3));

wire Tile_X9Y1_RES0_I0, Tile_X9Y1_RES0_I1, Tile_X9Y1_RES0_I2, Tile_X9Y1_RES0_I3;
(* keep *) OutPass4_frame_config Tile_X9Y1_C (.I0(Tile_X9Y1_RES0_I0), .I1(Tile_X9Y1_RES0_I1), .I2(Tile_X9Y1_RES0_I2), .I3(Tile_X9Y1_RES0_I3));

wire Tile_X9Y1_RES1_I0, Tile_X9Y1_RES1_I1, Tile_X9Y1_RES1_I2, Tile_X9Y1_RES1_I3;
(* keep *) OutPass4_frame_config Tile_X9Y1_D (.I0(Tile_X9Y1_RES1_I0), .I1(Tile_X9Y1_RES1_I1), .I2(Tile_X9Y1_RES1_I2), .I3(Tile_X9Y1_RES1_I3));

wire Tile_X9Y1_RES2_I0, Tile_X9Y1_RES2_I1, Tile_X9Y1_RES2_I2, Tile_X9Y1_RES2_I3;
(* keep *) OutPass4_frame_config Tile_X9Y1_E (.I0(Tile_X9Y1_RES2_I0), .I1(Tile_X9Y1_RES2_I1), .I2(Tile_X9Y1_RES2_I2), .I3(Tile_X9Y1_RES2_I3));

endmodule