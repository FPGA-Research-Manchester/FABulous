// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Wed Jul 31 17:00:02 2019
// Host        : FPGA1 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xadc_wiz_0_sim_netlist.v
// Design      : xadc_wiz_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream
   (m_axis_tdata,
    m_axis_reset,
    m_axis_tid,
    Q,
    den_C,
    m_axis_tvalid,
    temp_out,
    s_axis_aclk,
    m_axis_aclk,
    DO,
    m_axis_tready,
    drdy_C,
    den_o_reg_0,
    channel_out,
    m_axis_resetn);
  output [15:0]m_axis_tdata;
  output m_axis_reset;
  output [4:0]m_axis_tid;
  output [5:0]Q;
  output den_C;
  output m_axis_tvalid;
  output [11:0]temp_out;
  input s_axis_aclk;
  input m_axis_aclk;
  input [15:0]DO;
  input m_axis_tready;
  input drdy_C;
  input den_o_reg_0;
  input [4:0]channel_out;
  input m_axis_resetn;

  wire [15:0]DO;
  wire FIFO18E1_inst_data_i_1_n_0;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[2]_i_1_n_0 ;
  wire \FSM_sequential_state[2]_i_2_n_0 ;
  wire \FSM_sequential_state[3]_i_10_n_0 ;
  wire \FSM_sequential_state[3]_i_11_n_0 ;
  wire \FSM_sequential_state[3]_i_12_n_0 ;
  wire \FSM_sequential_state[3]_i_13_n_0 ;
  wire \FSM_sequential_state[3]_i_1_n_0 ;
  wire \FSM_sequential_state[3]_i_2_n_0 ;
  wire \FSM_sequential_state[3]_i_3_n_0 ;
  wire \FSM_sequential_state[3]_i_4_n_0 ;
  wire \FSM_sequential_state[3]_i_5_n_0 ;
  wire \FSM_sequential_state[3]_i_6_n_0 ;
  wire \FSM_sequential_state[3]_i_7_n_0 ;
  wire \FSM_sequential_state[3]_i_9_n_0 ;
  wire [5:0]Q;
  wire almost_full;
  wire busy_o0;
  wire [6:0]channel_id;
  wire \channel_id[6]_i_1_n_0 ;
  wire [4:0]channel_out;
  wire den_C;
  wire den_o0;
  wire den_o_i_1_n_0;
  wire den_o_reg_0;
  wire drdy_C;
  wire drp_rdwr_status;
  wire drp_rdwr_status_i_1_n_0;
  wire fifo_empty;
  wire m_axis_aclk;
  wire m_axis_reset;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire s_axis_aclk;
  (* RTL_KEEP = "yes" *) wire [3:0]state;
  wire [11:0]temp_out;
  wire \temp_out[11]_i_1_n_0 ;
  wire \timer_cntr[0]_i_10_n_0 ;
  wire \timer_cntr[0]_i_11_n_0 ;
  wire \timer_cntr[0]_i_2_n_0 ;
  wire \timer_cntr[0]_i_3_n_0 ;
  wire \timer_cntr[0]_i_4_n_0 ;
  wire \timer_cntr[0]_i_5_n_0 ;
  wire \timer_cntr[0]_i_6_n_0 ;
  wire \timer_cntr[0]_i_7_n_0 ;
  wire \timer_cntr[0]_i_8_n_0 ;
  wire \timer_cntr[0]_i_9_n_0 ;
  wire \timer_cntr[12]_i_2_n_0 ;
  wire \timer_cntr[12]_i_3_n_0 ;
  wire \timer_cntr[12]_i_4_n_0 ;
  wire \timer_cntr[12]_i_5_n_0 ;
  wire \timer_cntr[12]_i_6_n_0 ;
  wire \timer_cntr[12]_i_7_n_0 ;
  wire \timer_cntr[12]_i_8_n_0 ;
  wire \timer_cntr[12]_i_9_n_0 ;
  wire \timer_cntr[4]_i_10_n_0 ;
  wire \timer_cntr[4]_i_2_n_0 ;
  wire \timer_cntr[4]_i_3_n_0 ;
  wire \timer_cntr[4]_i_4_n_0 ;
  wire \timer_cntr[4]_i_5_n_0 ;
  wire \timer_cntr[4]_i_6_n_0 ;
  wire \timer_cntr[4]_i_7_n_0 ;
  wire \timer_cntr[4]_i_8_n_0 ;
  wire \timer_cntr[4]_i_9_n_0 ;
  wire \timer_cntr[8]_i_10_n_0 ;
  wire \timer_cntr[8]_i_11_n_0 ;
  wire \timer_cntr[8]_i_2_n_0 ;
  wire \timer_cntr[8]_i_3_n_0 ;
  wire \timer_cntr[8]_i_4_n_0 ;
  wire \timer_cntr[8]_i_5_n_0 ;
  wire \timer_cntr[8]_i_6_n_0 ;
  wire \timer_cntr[8]_i_7_n_0 ;
  wire \timer_cntr[8]_i_8_n_0 ;
  wire \timer_cntr[8]_i_9_n_0 ;
  wire [15:0]timer_cntr_reg;
  wire \timer_cntr_reg[0]_i_1_n_0 ;
  wire \timer_cntr_reg[0]_i_1_n_1 ;
  wire \timer_cntr_reg[0]_i_1_n_2 ;
  wire \timer_cntr_reg[0]_i_1_n_3 ;
  wire \timer_cntr_reg[0]_i_1_n_4 ;
  wire \timer_cntr_reg[0]_i_1_n_5 ;
  wire \timer_cntr_reg[0]_i_1_n_6 ;
  wire \timer_cntr_reg[0]_i_1_n_7 ;
  wire \timer_cntr_reg[12]_i_1_n_1 ;
  wire \timer_cntr_reg[12]_i_1_n_2 ;
  wire \timer_cntr_reg[12]_i_1_n_3 ;
  wire \timer_cntr_reg[12]_i_1_n_4 ;
  wire \timer_cntr_reg[12]_i_1_n_5 ;
  wire \timer_cntr_reg[12]_i_1_n_6 ;
  wire \timer_cntr_reg[12]_i_1_n_7 ;
  wire \timer_cntr_reg[4]_i_1_n_0 ;
  wire \timer_cntr_reg[4]_i_1_n_1 ;
  wire \timer_cntr_reg[4]_i_1_n_2 ;
  wire \timer_cntr_reg[4]_i_1_n_3 ;
  wire \timer_cntr_reg[4]_i_1_n_4 ;
  wire \timer_cntr_reg[4]_i_1_n_5 ;
  wire \timer_cntr_reg[4]_i_1_n_6 ;
  wire \timer_cntr_reg[4]_i_1_n_7 ;
  wire \timer_cntr_reg[8]_i_1_n_0 ;
  wire \timer_cntr_reg[8]_i_1_n_1 ;
  wire \timer_cntr_reg[8]_i_1_n_2 ;
  wire \timer_cntr_reg[8]_i_1_n_3 ;
  wire \timer_cntr_reg[8]_i_1_n_4 ;
  wire \timer_cntr_reg[8]_i_1_n_5 ;
  wire \timer_cntr_reg[8]_i_1_n_6 ;
  wire \timer_cntr_reg[8]_i_1_n_7 ;
  wire valid_data_wren_i_1_n_0;
  wire valid_data_wren_reg_n_0;
  wire wren_fifo;
  wire NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_FULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED;
  wire [31:16]NLW_FIFO18E1_inst_data_DO_UNCONNECTED;
  wire [3:0]NLW_FIFO18E1_inst_data_DOP_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED;
  wire [31:5]NLW_FIFO18E1_inst_tid_DO_UNCONNECTED;
  wire [3:0]NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED;
  wire [3:3]\NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  FIFO18E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0006),
    .ALMOST_FULL_OFFSET(13'h03F9),
    .DATA_WIDTH(18),
    .DO_REG(1),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO18"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(36'h000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(36'h000000000)) 
    FIFO18E1_inst_data
       (.ALMOSTEMPTY(NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(almost_full),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,DO}),
        .DIP({1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_FIFO18E1_inst_data_DO_UNCONNECTED[31:16],m_axis_tdata}),
        .DOP(NLW_FIFO18E1_inst_data_DOP_UNCONNECTED[3:0]),
        .EMPTY(fifo_empty),
        .FULL(NLW_FIFO18E1_inst_data_FULL_UNCONNECTED),
        .RDCLK(s_axis_aclk),
        .RDCOUNT(NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED[11:0]),
        .RDEN(FIFO18E1_inst_data_i_1_n_0),
        .RDERR(NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(m_axis_reset),
        .RSTREG(m_axis_reset),
        .WRCLK(m_axis_aclk),
        .WRCOUNT(NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED[11:0]),
        .WREN(wren_fifo),
        .WRERR(NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    FIFO18E1_inst_data_i_1
       (.I0(m_axis_tready),
        .I1(fifo_empty),
        .O(FIFO18E1_inst_data_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    FIFO18E1_inst_data_i_2
       (.I0(m_axis_resetn),
        .O(m_axis_reset));
  LUT2 #(
    .INIT(4'h8)) 
    FIFO18E1_inst_data_i_3
       (.I0(drdy_C),
        .I1(valid_data_wren_reg_n_0),
        .O(wren_fifo));
  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  FIFO18E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0006),
    .ALMOST_FULL_OFFSET(13'h03F9),
    .DATA_WIDTH(18),
    .DO_REG(1),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO18"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(36'h000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(36'h000000000)) 
    FIFO18E1_inst_tid
       (.ALMOSTEMPTY(NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q[5],1'b0,Q[4:0]}),
        .DIP({1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_FIFO18E1_inst_tid_DO_UNCONNECTED[31:5],m_axis_tid}),
        .DOP(NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED[3:0]),
        .EMPTY(NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED),
        .FULL(NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED),
        .RDCLK(s_axis_aclk),
        .RDCOUNT(NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED[11:0]),
        .RDEN(FIFO18E1_inst_data_i_1_n_0),
        .RDERR(NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(m_axis_reset),
        .RSTREG(m_axis_reset),
        .WRCLK(m_axis_aclk),
        .WRCOUNT(NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED[11:0]),
        .WREN(wren_fifo),
        .WRERR(NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED));
  LUT6 #(
    .INIT(64'hFFFF0F0F53500F0F)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(busy_o0),
        .I1(state[3]),
        .I2(state[0]),
        .I3(\FSM_sequential_state[3]_i_9_n_0 ),
        .I4(state[1]),
        .I5(state[2]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00F60000)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(DO[15]),
        .I1(DO[14]),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[1]),
        .I5(state[0]),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAABAAAAAAAEEEE)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(\FSM_sequential_state[2]_i_2_n_0 ),
        .I1(state[2]),
        .I2(busy_o0),
        .I3(state[0]),
        .I4(state[3]),
        .I5(state[1]),
        .O(\FSM_sequential_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(DO[15]),
        .I3(DO[14]),
        .I4(state[3]),
        .I5(state[1]),
        .O(\FSM_sequential_state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEEFFFFFFEA)) 
    \FSM_sequential_state[3]_i_1 
       (.I0(\FSM_sequential_state[3]_i_3_n_0 ),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(\FSM_sequential_state[3]_i_5_n_0 ),
        .I3(channel_id[6]),
        .I4(\FSM_sequential_state[3]_i_6_n_0 ),
        .I5(\FSM_sequential_state[3]_i_7_n_0 ),
        .O(\FSM_sequential_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_state[3]_i_10 
       (.I0(timer_cntr_reg[11]),
        .I1(timer_cntr_reg[12]),
        .I2(timer_cntr_reg[13]),
        .I3(timer_cntr_reg[14]),
        .I4(den_o_reg_0),
        .I5(timer_cntr_reg[15]),
        .O(\FSM_sequential_state[3]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_state[3]_i_11 
       (.I0(timer_cntr_reg[4]),
        .I1(drp_rdwr_status),
        .I2(timer_cntr_reg[6]),
        .I3(timer_cntr_reg[5]),
        .O(\FSM_sequential_state[3]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_state[3]_i_12 
       (.I0(timer_cntr_reg[10]),
        .I1(timer_cntr_reg[9]),
        .I2(timer_cntr_reg[8]),
        .I3(timer_cntr_reg[7]),
        .O(\FSM_sequential_state[3]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    \FSM_sequential_state[3]_i_13 
       (.I0(timer_cntr_reg[0]),
        .I1(timer_cntr_reg[1]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[3]),
        .O(\FSM_sequential_state[3]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF50000FF0300)) 
    \FSM_sequential_state[3]_i_2 
       (.I0(busy_o0),
        .I1(\FSM_sequential_state[3]_i_9_n_0 ),
        .I2(state[2]),
        .I3(state[1]),
        .I4(state[3]),
        .I5(state[0]),
        .O(\FSM_sequential_state[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h13005D4C)) 
    \FSM_sequential_state[3]_i_3 
       (.I0(state[3]),
        .I1(state[0]),
        .I2(state[2]),
        .I3(drdy_C),
        .I4(state[1]),
        .O(\FSM_sequential_state[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[3]_i_4 
       (.I0(state[0]),
        .I1(state[3]),
        .O(\FSM_sequential_state[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFF8000)) 
    \FSM_sequential_state[3]_i_5 
       (.I0(\FSM_sequential_state[3]_i_10_n_0 ),
        .I1(\FSM_sequential_state[3]_i_11_n_0 ),
        .I2(\FSM_sequential_state[3]_i_12_n_0 ),
        .I3(\FSM_sequential_state[3]_i_13_n_0 ),
        .I4(busy_o0),
        .I5(state[2]),
        .O(\FSM_sequential_state[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \FSM_sequential_state[3]_i_6 
       (.I0(\FSM_sequential_state[3]_i_13_n_0 ),
        .I1(\FSM_sequential_state[3]_i_12_n_0 ),
        .I2(\FSM_sequential_state[3]_i_11_n_0 ),
        .I3(\FSM_sequential_state[3]_i_10_n_0 ),
        .I4(state[2]),
        .I5(state[1]),
        .O(\FSM_sequential_state[3]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_sequential_state[3]_i_7 
       (.I0(\FSM_sequential_state[3]_i_13_n_0 ),
        .I1(\FSM_sequential_state[3]_i_12_n_0 ),
        .I2(\FSM_sequential_state[3]_i_11_n_0 ),
        .I3(\FSM_sequential_state[3]_i_10_n_0 ),
        .I4(state[2]),
        .O(\FSM_sequential_state[3]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[3]_i_8 
       (.I0(den_o_reg_0),
        .I1(channel_out[4]),
        .O(busy_o0));
  LUT2 #(
    .INIT(4'h6)) 
    \FSM_sequential_state[3]_i_9 
       (.I0(DO[14]),
        .I1(DO[15]),
        .O(\FSM_sequential_state[3]_i_9_n_0 ));
  (* KEEP = "yes" *) 
  FDCE \FSM_sequential_state_reg[0] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]));
  (* KEEP = "yes" *) 
  FDCE \FSM_sequential_state_reg[1] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]));
  (* KEEP = "yes" *) 
  FDCE \FSM_sequential_state_reg[2] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[2]_i_1_n_0 ),
        .Q(state[2]));
  (* KEEP = "yes" *) 
  FDCE \FSM_sequential_state_reg[3] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[3]_i_2_n_0 ),
        .Q(state[3]));
  LUT5 #(
    .INIT(32'h55015701)) 
    \channel_id[0]_i_1 
       (.I0(state[3]),
        .I1(state[1]),
        .I2(state[2]),
        .I3(channel_out[0]),
        .I4(state[0]),
        .O(channel_id[0]));
  LUT5 #(
    .INIT(32'h11FD0000)) 
    \channel_id[1]_i_1 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(channel_out[1]),
        .O(channel_id[1]));
  LUT5 #(
    .INIT(32'h11FD0000)) 
    \channel_id[2]_i_1 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(channel_out[2]),
        .O(channel_id[2]));
  LUT5 #(
    .INIT(32'h1F00110C)) 
    \channel_id[3]_i_1 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[3]),
        .I3(channel_out[3]),
        .I4(state[1]),
        .O(channel_id[3]));
  LUT6 #(
    .INIT(64'h1F001F00110C1D00)) 
    \channel_id[4]_i_1 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[3]),
        .I3(channel_out[4]),
        .I4(channel_out[3]),
        .I5(state[1]),
        .O(channel_id[4]));
  LUT4 #(
    .INIT(16'h1F10)) 
    \channel_id[6]_i_1 
       (.I0(state[1]),
        .I1(state[2]),
        .I2(state[3]),
        .I3(state[0]),
        .O(\channel_id[6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \channel_id[6]_i_2 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[3]),
        .O(channel_id[6]));
  FDCE \channel_id_reg[0] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[0]),
        .Q(Q[0]));
  FDCE \channel_id_reg[1] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[1]),
        .Q(Q[1]));
  FDCE \channel_id_reg[2] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[2]),
        .Q(Q[2]));
  FDCE \channel_id_reg[3] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[3]),
        .Q(Q[3]));
  FDCE \channel_id_reg[4] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[4]),
        .Q(Q[4]));
  FDCE \channel_id_reg[6] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[6]),
        .Q(Q[5]));
  LUT6 #(
    .INIT(64'hEFEFCC08232F0008)) 
    den_o_i_1
       (.I0(den_o0),
        .I1(state[3]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[0]),
        .I5(den_C),
        .O(den_o_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    den_o_i_2
       (.I0(den_o_reg_0),
        .I1(almost_full),
        .O(den_o0));
  FDCE den_o_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(den_o_i_1_n_0),
        .Q(den_C));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    drp_rdwr_status_i_1
       (.I0(almost_full),
        .I1(den_o_reg_0),
        .I2(drdy_C),
        .I3(drp_rdwr_status),
        .O(drp_rdwr_status_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    drp_rdwr_status_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(drp_rdwr_status_i_1_n_0),
        .Q(drp_rdwr_status));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT1 #(
    .INIT(2'h1)) 
    m_axis_tvalid_INST_0
       (.I0(fifo_empty),
        .O(m_axis_tvalid));
  LUT5 #(
    .INIT(32'h00000080)) 
    \temp_out[11]_i_1 
       (.I0(drdy_C),
        .I1(state[1]),
        .I2(state[3]),
        .I3(state[2]),
        .I4(state[0]),
        .O(\temp_out[11]_i_1_n_0 ));
  FDCE \temp_out_reg[0] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[4]),
        .Q(temp_out[0]));
  FDCE \temp_out_reg[10] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[14]),
        .Q(temp_out[10]));
  FDCE \temp_out_reg[11] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[15]),
        .Q(temp_out[11]));
  FDCE \temp_out_reg[1] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[5]),
        .Q(temp_out[1]));
  FDCE \temp_out_reg[2] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[6]),
        .Q(temp_out[2]));
  FDCE \temp_out_reg[3] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[7]),
        .Q(temp_out[3]));
  FDCE \temp_out_reg[4] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[8]),
        .Q(temp_out[4]));
  FDCE \temp_out_reg[5] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[9]),
        .Q(temp_out[5]));
  FDCE \temp_out_reg[6] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[10]),
        .Q(temp_out[6]));
  FDCE \temp_out_reg[7] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[11]),
        .Q(temp_out[7]));
  FDCE \temp_out_reg[8] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[12]),
        .Q(temp_out[8]));
  FDCE \temp_out_reg[9] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(DO[13]),
        .Q(temp_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00010000)) 
    \timer_cntr[0]_i_10 
       (.I0(timer_cntr_reg[12]),
        .I1(timer_cntr_reg[13]),
        .I2(timer_cntr_reg[14]),
        .I3(timer_cntr_reg[15]),
        .I4(\timer_cntr[12]_i_9_n_0 ),
        .O(\timer_cntr[0]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \timer_cntr[0]_i_11 
       (.I0(timer_cntr_reg[7]),
        .I1(timer_cntr_reg[6]),
        .I2(timer_cntr_reg[5]),
        .I3(timer_cntr_reg[4]),
        .O(\timer_cntr[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00020000)) 
    \timer_cntr[0]_i_2 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(timer_cntr_reg[2]),
        .I2(timer_cntr_reg[0]),
        .I3(timer_cntr_reg[1]),
        .I4(\timer_cntr[0]_i_11_n_0 ),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[0]_i_3 
       (.I0(timer_cntr_reg[2]),
        .O(\timer_cntr[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[0]_i_4 
       (.I0(timer_cntr_reg[1]),
        .O(\timer_cntr[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[0]_i_5 
       (.I0(timer_cntr_reg[0]),
        .O(\timer_cntr[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[0]_i_6 
       (.I0(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h3333333133333333)) 
    \timer_cntr[0]_i_7 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(timer_cntr_reg[2]),
        .I2(timer_cntr_reg[3]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[1]),
        .I5(\timer_cntr[0]_i_11_n_0 ),
        .O(\timer_cntr[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFD0000FFFF)) 
    \timer_cntr[0]_i_8 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(timer_cntr_reg[2]),
        .I2(timer_cntr_reg[3]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[1]),
        .I5(\timer_cntr[0]_i_11_n_0 ),
        .O(\timer_cntr[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h00FF00FD00FF00FF)) 
    \timer_cntr[0]_i_9 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(timer_cntr_reg[2]),
        .I2(timer_cntr_reg[3]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[1]),
        .I5(\timer_cntr[0]_i_11_n_0 ),
        .O(\timer_cntr[0]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[12]_i_2 
       (.I0(timer_cntr_reg[14]),
        .O(\timer_cntr[12]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[12]_i_3 
       (.I0(timer_cntr_reg[13]),
        .O(\timer_cntr[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[12]_i_4 
       (.I0(timer_cntr_reg[12]),
        .O(\timer_cntr[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00FE00FF00FF00FF)) 
    \timer_cntr[12]_i_5 
       (.I0(timer_cntr_reg[12]),
        .I1(timer_cntr_reg[13]),
        .I2(timer_cntr_reg[14]),
        .I3(timer_cntr_reg[15]),
        .I4(\timer_cntr[12]_i_9_n_0 ),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0F0E0F0F0F0F0F0F)) 
    \timer_cntr[12]_i_6 
       (.I0(timer_cntr_reg[12]),
        .I1(timer_cntr_reg[13]),
        .I2(timer_cntr_reg[14]),
        .I3(timer_cntr_reg[15]),
        .I4(\timer_cntr[12]_i_9_n_0 ),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h3332333333333333)) 
    \timer_cntr[12]_i_7 
       (.I0(timer_cntr_reg[12]),
        .I1(timer_cntr_reg[13]),
        .I2(timer_cntr_reg[14]),
        .I3(timer_cntr_reg[15]),
        .I4(\timer_cntr[12]_i_9_n_0 ),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[12]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h5554555555555555)) 
    \timer_cntr[12]_i_8 
       (.I0(timer_cntr_reg[12]),
        .I1(timer_cntr_reg[13]),
        .I2(timer_cntr_reg[14]),
        .I3(timer_cntr_reg[15]),
        .I4(\timer_cntr[12]_i_9_n_0 ),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[12]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \timer_cntr[12]_i_9 
       (.I0(timer_cntr_reg[11]),
        .I1(timer_cntr_reg[10]),
        .I2(timer_cntr_reg[9]),
        .I3(timer_cntr_reg[8]),
        .O(\timer_cntr[12]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \timer_cntr[4]_i_10 
       (.I0(timer_cntr_reg[1]),
        .I1(timer_cntr_reg[0]),
        .I2(timer_cntr_reg[3]),
        .I3(timer_cntr_reg[2]),
        .O(\timer_cntr[4]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000008)) 
    \timer_cntr[4]_i_2 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(\timer_cntr[4]_i_10_n_0 ),
        .I2(timer_cntr_reg[4]),
        .I3(timer_cntr_reg[5]),
        .I4(timer_cntr_reg[6]),
        .I5(timer_cntr_reg[7]),
        .O(\timer_cntr[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000008)) 
    \timer_cntr[4]_i_3 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(\timer_cntr[4]_i_10_n_0 ),
        .I2(timer_cntr_reg[4]),
        .I3(timer_cntr_reg[5]),
        .I4(timer_cntr_reg[7]),
        .I5(timer_cntr_reg[6]),
        .O(\timer_cntr[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000008)) 
    \timer_cntr[4]_i_4 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(\timer_cntr[4]_i_10_n_0 ),
        .I2(timer_cntr_reg[4]),
        .I3(timer_cntr_reg[6]),
        .I4(timer_cntr_reg[7]),
        .I5(timer_cntr_reg[5]),
        .O(\timer_cntr[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[4]_i_5 
       (.I0(timer_cntr_reg[4]),
        .O(\timer_cntr[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[4]_i_6 
       (.I0(timer_cntr_reg[7]),
        .O(\timer_cntr[4]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[4]_i_7 
       (.I0(timer_cntr_reg[6]),
        .O(\timer_cntr[4]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[4]_i_8 
       (.I0(timer_cntr_reg[5]),
        .O(\timer_cntr[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0F0F0F0F0F0F0F07)) 
    \timer_cntr[4]_i_9 
       (.I0(\timer_cntr[0]_i_10_n_0 ),
        .I1(\timer_cntr[4]_i_10_n_0 ),
        .I2(timer_cntr_reg[4]),
        .I3(timer_cntr_reg[5]),
        .I4(timer_cntr_reg[6]),
        .I5(timer_cntr_reg[7]),
        .O(\timer_cntr[4]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \timer_cntr[8]_i_10 
       (.I0(timer_cntr_reg[15]),
        .I1(timer_cntr_reg[14]),
        .I2(timer_cntr_reg[13]),
        .I3(timer_cntr_reg[12]),
        .O(\timer_cntr[8]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00010000)) 
    \timer_cntr[8]_i_11 
       (.I0(timer_cntr_reg[2]),
        .I1(timer_cntr_reg[3]),
        .I2(timer_cntr_reg[0]),
        .I3(timer_cntr_reg[1]),
        .I4(\timer_cntr[0]_i_11_n_0 ),
        .O(\timer_cntr[8]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[8]_i_2 
       (.I0(timer_cntr_reg[11]),
        .O(\timer_cntr[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \timer_cntr[8]_i_3 
       (.I0(timer_cntr_reg[10]),
        .O(\timer_cntr[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00020000)) 
    \timer_cntr[8]_i_4 
       (.I0(\timer_cntr[8]_i_10_n_0 ),
        .I1(timer_cntr_reg[8]),
        .I2(timer_cntr_reg[10]),
        .I3(timer_cntr_reg[11]),
        .I4(\timer_cntr[8]_i_11_n_0 ),
        .I5(timer_cntr_reg[9]),
        .O(\timer_cntr[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00020000)) 
    \timer_cntr[8]_i_5 
       (.I0(\timer_cntr[8]_i_10_n_0 ),
        .I1(timer_cntr_reg[9]),
        .I2(timer_cntr_reg[10]),
        .I3(timer_cntr_reg[11]),
        .I4(\timer_cntr[8]_i_11_n_0 ),
        .I5(timer_cntr_reg[8]),
        .O(\timer_cntr[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFD0000FFFF)) 
    \timer_cntr[8]_i_6 
       (.I0(\timer_cntr[8]_i_10_n_0 ),
        .I1(timer_cntr_reg[8]),
        .I2(timer_cntr_reg[9]),
        .I3(timer_cntr_reg[10]),
        .I4(timer_cntr_reg[11]),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00FF00FD00FF00FF)) 
    \timer_cntr[8]_i_7 
       (.I0(\timer_cntr[8]_i_10_n_0 ),
        .I1(timer_cntr_reg[8]),
        .I2(timer_cntr_reg[9]),
        .I3(timer_cntr_reg[10]),
        .I4(timer_cntr_reg[11]),
        .I5(\timer_cntr[8]_i_11_n_0 ),
        .O(\timer_cntr[8]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[8]_i_8 
       (.I0(timer_cntr_reg[9]),
        .O(\timer_cntr[8]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[8]_i_9 
       (.I0(timer_cntr_reg[8]),
        .O(\timer_cntr[8]_i_9_n_0 ));
  FDCE \timer_cntr_reg[0] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_7 ),
        .Q(timer_cntr_reg[0]));
  CARRY4 \timer_cntr_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\timer_cntr_reg[0]_i_1_n_0 ,\timer_cntr_reg[0]_i_1_n_1 ,\timer_cntr_reg[0]_i_1_n_2 ,\timer_cntr_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timer_cntr[0]_i_2_n_0 ,\timer_cntr[0]_i_3_n_0 ,\timer_cntr[0]_i_4_n_0 ,\timer_cntr[0]_i_5_n_0 }),
        .O({\timer_cntr_reg[0]_i_1_n_4 ,\timer_cntr_reg[0]_i_1_n_5 ,\timer_cntr_reg[0]_i_1_n_6 ,\timer_cntr_reg[0]_i_1_n_7 }),
        .S({\timer_cntr[0]_i_6_n_0 ,\timer_cntr[0]_i_7_n_0 ,\timer_cntr[0]_i_8_n_0 ,\timer_cntr[0]_i_9_n_0 }));
  FDCE \timer_cntr_reg[10] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_5 ),
        .Q(timer_cntr_reg[10]));
  FDCE \timer_cntr_reg[11] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_4 ),
        .Q(timer_cntr_reg[11]));
  FDCE \timer_cntr_reg[12] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_7 ),
        .Q(timer_cntr_reg[12]));
  CARRY4 \timer_cntr_reg[12]_i_1 
       (.CI(\timer_cntr_reg[8]_i_1_n_0 ),
        .CO({\NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED [3],\timer_cntr_reg[12]_i_1_n_1 ,\timer_cntr_reg[12]_i_1_n_2 ,\timer_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\timer_cntr[12]_i_2_n_0 ,\timer_cntr[12]_i_3_n_0 ,\timer_cntr[12]_i_4_n_0 }),
        .O({\timer_cntr_reg[12]_i_1_n_4 ,\timer_cntr_reg[12]_i_1_n_5 ,\timer_cntr_reg[12]_i_1_n_6 ,\timer_cntr_reg[12]_i_1_n_7 }),
        .S({\timer_cntr[12]_i_5_n_0 ,\timer_cntr[12]_i_6_n_0 ,\timer_cntr[12]_i_7_n_0 ,\timer_cntr[12]_i_8_n_0 }));
  FDCE \timer_cntr_reg[13] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_6 ),
        .Q(timer_cntr_reg[13]));
  FDCE \timer_cntr_reg[14] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_5 ),
        .Q(timer_cntr_reg[14]));
  FDCE \timer_cntr_reg[15] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_4 ),
        .Q(timer_cntr_reg[15]));
  FDCE \timer_cntr_reg[1] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_6 ),
        .Q(timer_cntr_reg[1]));
  FDCE \timer_cntr_reg[2] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_5 ),
        .Q(timer_cntr_reg[2]));
  FDCE \timer_cntr_reg[3] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_4 ),
        .Q(timer_cntr_reg[3]));
  FDCE \timer_cntr_reg[4] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_7 ),
        .Q(timer_cntr_reg[4]));
  CARRY4 \timer_cntr_reg[4]_i_1 
       (.CI(\timer_cntr_reg[0]_i_1_n_0 ),
        .CO({\timer_cntr_reg[4]_i_1_n_0 ,\timer_cntr_reg[4]_i_1_n_1 ,\timer_cntr_reg[4]_i_1_n_2 ,\timer_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timer_cntr[4]_i_2_n_0 ,\timer_cntr[4]_i_3_n_0 ,\timer_cntr[4]_i_4_n_0 ,\timer_cntr[4]_i_5_n_0 }),
        .O({\timer_cntr_reg[4]_i_1_n_4 ,\timer_cntr_reg[4]_i_1_n_5 ,\timer_cntr_reg[4]_i_1_n_6 ,\timer_cntr_reg[4]_i_1_n_7 }),
        .S({\timer_cntr[4]_i_6_n_0 ,\timer_cntr[4]_i_7_n_0 ,\timer_cntr[4]_i_8_n_0 ,\timer_cntr[4]_i_9_n_0 }));
  FDCE \timer_cntr_reg[5] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_6 ),
        .Q(timer_cntr_reg[5]));
  FDCE \timer_cntr_reg[6] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_5 ),
        .Q(timer_cntr_reg[6]));
  FDCE \timer_cntr_reg[7] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_4 ),
        .Q(timer_cntr_reg[7]));
  FDCE \timer_cntr_reg[8] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_7 ),
        .Q(timer_cntr_reg[8]));
  CARRY4 \timer_cntr_reg[8]_i_1 
       (.CI(\timer_cntr_reg[4]_i_1_n_0 ),
        .CO({\timer_cntr_reg[8]_i_1_n_0 ,\timer_cntr_reg[8]_i_1_n_1 ,\timer_cntr_reg[8]_i_1_n_2 ,\timer_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timer_cntr[8]_i_2_n_0 ,\timer_cntr[8]_i_3_n_0 ,\timer_cntr[8]_i_4_n_0 ,\timer_cntr[8]_i_5_n_0 }),
        .O({\timer_cntr_reg[8]_i_1_n_4 ,\timer_cntr_reg[8]_i_1_n_5 ,\timer_cntr_reg[8]_i_1_n_6 ,\timer_cntr_reg[8]_i_1_n_7 }),
        .S({\timer_cntr[8]_i_6_n_0 ,\timer_cntr[8]_i_7_n_0 ,\timer_cntr[8]_i_8_n_0 ,\timer_cntr[8]_i_9_n_0 }));
  FDCE \timer_cntr_reg[9] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_6 ),
        .Q(timer_cntr_reg[9]));
  LUT6 #(
    .INIT(64'hFCFFFFFC00000008)) 
    valid_data_wren_i_1
       (.I0(drdy_C),
        .I1(state[1]),
        .I2(state[2]),
        .I3(state[0]),
        .I4(state[3]),
        .I5(valid_data_wren_reg_n_0),
        .O(valid_data_wren_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    valid_data_wren_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(valid_data_wren_i_1_n_0),
        .Q(valid_data_wren_reg_n_0));
endmodule

(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (s_axis_aclk,
    m_axis_aclk,
    m_axis_resetn,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tid,
    m_axis_tready,
    busy_out,
    channel_out,
    eoc_out,
    eos_out,
    ot_out,
    vccaux_alarm_out,
    vccint_alarm_out,
    user_temp_alarm_out,
    alarm_out,
    temp_out,
    vp_in,
    vn_in);
  input s_axis_aclk;
  input m_axis_aclk;
  input m_axis_resetn;
  output [15:0]m_axis_tdata;
  output m_axis_tvalid;
  output [4:0]m_axis_tid;
  input m_axis_tready;
  output busy_out;
  output [4:0]channel_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output vccaux_alarm_out;
  output vccint_alarm_out;
  output user_temp_alarm_out;
  output alarm_out;
  output [11:0]temp_out;
  input vp_in;
  input vn_in;

  wire alarm_out;
  wire busy_out;
  wire [4:0]channel_out;
  wire eoc_out;
  wire eos_out;
  wire m_axis_aclk;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire ot_out;
  wire s_axis_aclk;
  wire [11:0]temp_out;
  wire user_temp_alarm_out;
  wire vccaux_alarm_out;
  wire vccint_alarm_out;
  wire vn_in;
  wire vp_in;
  wire [6:3]NLW_U0_alarm_out_UNCONNECTED;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc U0
       (.alarm_out({alarm_out,NLW_U0_alarm_out_UNCONNECTED[6:3],vccaux_alarm_out,vccint_alarm_out,user_temp_alarm_out}),
        .busy_out(busy_out),
        .channel_out(channel_out),
        .eoc_out(eoc_out),
        .eos_out(eos_out),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_resetn(m_axis_resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .ot_out(ot_out),
        .s_axis_aclk(s_axis_aclk),
        .temp_out(temp_out),
        .vn_in(vn_in),
        .vp_in(vp_in));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc
   (s_axis_aclk,
    m_axis_aclk,
    m_axis_resetn,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tid,
    m_axis_tready,
    busy_out,
    channel_out,
    eoc_out,
    eos_out,
    ot_out,
    alarm_out,
    temp_out,
    vp_in,
    vn_in);
  input s_axis_aclk;
  input m_axis_aclk;
  input m_axis_resetn;
  output [15:0]m_axis_tdata;
  output m_axis_tvalid;
  output [4:0]m_axis_tid;
  input m_axis_tready;
  output busy_out;
  output [4:0]channel_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output [7:0]alarm_out;
  output [11:0]temp_out;
  input vp_in;
  input vn_in;

  wire [7:0]alarm_out;
  wire busy_out;
  wire [4:0]channel_out;
  wire eoc_out;
  wire eos_out;
  wire m_axis_aclk;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire ot_out;
  wire s_axis_aclk;
  wire [11:0]temp_out;
  wire vn_in;
  wire vp_in;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp AXI_XADC_CORE_I
       (.alarm_out(alarm_out),
        .busy_out(busy_out),
        .channel_out(channel_out),
        .eoc_out(eoc_out),
        .eos_out(eos_out),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_resetn(m_axis_resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .ot_out(ot_out),
        .s_axis_aclk(s_axis_aclk),
        .temp_out(temp_out),
        .vn_in(vn_in),
        .vp_in(vp_in));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp
   (m_axis_tdata,
    m_axis_tid,
    channel_out,
    busy_out,
    eoc_out,
    eos_out,
    ot_out,
    alarm_out,
    temp_out,
    m_axis_tvalid,
    m_axis_tready,
    s_axis_aclk,
    m_axis_aclk,
    vn_in,
    vp_in,
    m_axis_resetn);
  output [15:0]m_axis_tdata;
  output [4:0]m_axis_tid;
  output [4:0]channel_out;
  output busy_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output [7:0]alarm_out;
  output [11:0]temp_out;
  output m_axis_tvalid;
  input m_axis_tready;
  input s_axis_aclk;
  input m_axis_aclk;
  input vn_in;
  input vp_in;
  input m_axis_resetn;

  wire [7:0]alarm_out;
  wire busy_out;
  wire [4:0]channel_out;
  wire [6:0]daddr_C;
  wire den_C;
  wire [15:0]do_C;
  wire drdy_C;
  wire eoc_out;
  wire eos_out;
  wire m_axis_aclk;
  wire m_axis_reset;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire ot_out;
  wire s_axis_aclk;
  wire [11:0]temp_out;
  wire vn_in;
  wire vp_in;
  wire NLW_XADC_INST_JTAGBUSY_UNCONNECTED;
  wire NLW_XADC_INST_JTAGLOCKED_UNCONNECTED;
  wire NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED;
  wire [4:0]NLW_XADC_INST_MUXADDR_UNCONNECTED;

  (* box_type = "PRIMITIVE" *) 
  XADC #(
    .INIT_40(16'h0000),
    .INIT_41(16'h31A0),
    .INIT_42(16'h0400),
    .INIT_43(16'h0000),
    .INIT_44(16'h0000),
    .INIT_45(16'h0000),
    .INIT_46(16'h0000),
    .INIT_47(16'h0000),
    .INIT_48(16'h0100),
    .INIT_49(16'h0000),
    .INIT_4A(16'h0000),
    .INIT_4B(16'h0000),
    .INIT_4C(16'h0000),
    .INIT_4D(16'h0000),
    .INIT_4E(16'h0000),
    .INIT_4F(16'h0000),
    .INIT_50(16'hB5ED),
    .INIT_51(16'h57E4),
    .INIT_52(16'hA147),
    .INIT_53(16'hCA33),
    .INIT_54(16'hA93A),
    .INIT_55(16'h52C6),
    .INIT_56(16'h9555),
    .INIT_57(16'hAE4E),
    .INIT_58(16'h5999),
    .INIT_59(16'h0000),
    .INIT_5A(16'h0000),
    .INIT_5B(16'h0000),
    .INIT_5C(16'h5111),
    .INIT_5D(16'h0000),
    .INIT_5E(16'h0000),
    .INIT_5F(16'h0000),
    .IS_CONVSTCLK_INVERTED(1'b0),
    .IS_DCLK_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SIM_MONITOR_FILE("design.txt")) 
    XADC_INST
       (.ALM(alarm_out),
        .BUSY(busy_out),
        .CHANNEL(channel_out),
        .CONVST(1'b0),
        .CONVSTCLK(1'b0),
        .DADDR({daddr_C[6],1'b0,daddr_C[4:0]}),
        .DCLK(m_axis_aclk),
        .DEN(den_C),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(do_C),
        .DRDY(drdy_C),
        .DWE(1'b0),
        .EOC(eoc_out),
        .EOS(eos_out),
        .JTAGBUSY(NLW_XADC_INST_JTAGBUSY_UNCONNECTED),
        .JTAGLOCKED(NLW_XADC_INST_JTAGLOCKED_UNCONNECTED),
        .JTAGMODIFIED(NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED),
        .MUXADDR(NLW_XADC_INST_MUXADDR_UNCONNECTED[4:0]),
        .OT(ot_out),
        .RESET(m_axis_reset),
        .VAUXN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .VAUXP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .VN(vn_in),
        .VP(vp_in));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream drp_to_axi4stream_inst
       (.DO(do_C),
        .Q({daddr_C[6],daddr_C[4:0]}),
        .channel_out(channel_out),
        .den_C(den_C),
        .den_o_reg_0(eoc_out),
        .drdy_C(drdy_C),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_reset(m_axis_reset),
        .m_axis_resetn(m_axis_resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axis_aclk(s_axis_aclk),
        .temp_out(temp_out));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
