-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Wed Jul 31 17:00:02 2019
-- Host        : FPGA1 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xadc_wiz_0_sim_netlist.vhdl
-- Design      : xadc_wiz_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx485tffg1157-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream is
  port (
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_reset : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    den_C : out STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    DO : in STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tready : in STD_LOGIC;
    drdy_C : in STD_LOGIC;
    den_o_reg_0 : in STD_LOGIC;
    channel_out : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_resetn : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream is
  signal FIFO18E1_inst_data_i_1_n_0 : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_10_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_11_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_12_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_13_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_7_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_9_n_0\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal almost_full : STD_LOGIC;
  signal busy_o0 : STD_LOGIC;
  signal channel_id : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \channel_id[6]_i_1_n_0\ : STD_LOGIC;
  signal \^den_c\ : STD_LOGIC;
  signal den_o0 : STD_LOGIC;
  signal den_o_i_1_n_0 : STD_LOGIC;
  signal drp_rdwr_status : STD_LOGIC;
  signal drp_rdwr_status_i_1_n_0 : STD_LOGIC;
  signal fifo_empty : STD_LOGIC;
  signal \^m_axis_reset\ : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of state : signal is "yes";
  signal \temp_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_10_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_11_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_7_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_8_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_9_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_7_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_8_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_9_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_10_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_7_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_8_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_9_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_10_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_11_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_7_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_8_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_9_n_0\ : STD_LOGIC;
  signal timer_cntr_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \timer_cntr_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal valid_data_wren_i_1_n_0 : STD_LOGIC;
  signal valid_data_wren_reg_n_0 : STD_LOGIC;
  signal wren_fifo : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_FULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 16 );
  signal NLW_FIFO18E1_inst_data_DOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 5 );
  signal NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of FIFO18E1_inst_data : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of FIFO18E1_inst_data : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of FIFO18E1_inst_data_i_1 : label is "soft_lutpair5";
  attribute CLOCK_DOMAINS of FIFO18E1_inst_tid : label is "INDEPENDENT";
  attribute box_type of FIFO18E1_inst_tid : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \FSM_sequential_state[3]_i_11\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_sequential_state[3]_i_12\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_sequential_state[3]_i_13\ : label is "soft_lutpair0";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM of den_o_i_2 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of drp_rdwr_status_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of m_axis_tvalid_INST_0 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \timer_cntr[0]_i_10\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \timer_cntr[0]_i_11\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \timer_cntr[12]_i_9\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \timer_cntr[8]_i_10\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \timer_cntr[8]_i_11\ : label is "soft_lutpair0";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
  den_C <= \^den_c\;
  m_axis_reset <= \^m_axis_reset\;
FIFO18E1_inst_data: unisim.vcomponents.FIFO18E1
    generic map(
      ALMOST_EMPTY_OFFSET => X"0006",
      ALMOST_FULL_OFFSET => X"03F9",
      DATA_WIDTH => 18,
      DO_REG => 1,
      EN_SYN => false,
      FIFO_MODE => "FIFO18",
      FIRST_WORD_FALL_THROUGH => true,
      INIT => X"000000000",
      IS_RDCLK_INVERTED => '0',
      IS_RDEN_INVERTED => '0',
      IS_RSTREG_INVERTED => '0',
      IS_RST_INVERTED => '0',
      IS_WRCLK_INVERTED => '0',
      IS_WREN_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SRVAL => X"000000000"
    )
        port map (
      ALMOSTEMPTY => NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED,
      ALMOSTFULL => almost_full,
      DI(31 downto 16) => B"0000000000000000",
      DI(15 downto 0) => DO(15 downto 0),
      DIP(3 downto 0) => B"0000",
      DO(31 downto 16) => NLW_FIFO18E1_inst_data_DO_UNCONNECTED(31 downto 16),
      DO(15 downto 0) => m_axis_tdata(15 downto 0),
      DOP(3 downto 0) => NLW_FIFO18E1_inst_data_DOP_UNCONNECTED(3 downto 0),
      EMPTY => fifo_empty,
      FULL => NLW_FIFO18E1_inst_data_FULL_UNCONNECTED,
      RDCLK => s_axis_aclk,
      RDCOUNT(11 downto 0) => NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED(11 downto 0),
      RDEN => FIFO18E1_inst_data_i_1_n_0,
      RDERR => NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED,
      REGCE => '1',
      RST => \^m_axis_reset\,
      RSTREG => \^m_axis_reset\,
      WRCLK => m_axis_aclk,
      WRCOUNT(11 downto 0) => NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED(11 downto 0),
      WREN => wren_fifo,
      WRERR => NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED
    );
FIFO18E1_inst_data_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => m_axis_tready,
      I1 => fifo_empty,
      O => FIFO18E1_inst_data_i_1_n_0
    );
FIFO18E1_inst_data_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => m_axis_resetn,
      O => \^m_axis_reset\
    );
FIFO18E1_inst_data_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => drdy_C,
      I1 => valid_data_wren_reg_n_0,
      O => wren_fifo
    );
FIFO18E1_inst_tid: unisim.vcomponents.FIFO18E1
    generic map(
      ALMOST_EMPTY_OFFSET => X"0006",
      ALMOST_FULL_OFFSET => X"03F9",
      DATA_WIDTH => 18,
      DO_REG => 1,
      EN_SYN => false,
      FIFO_MODE => "FIFO18",
      FIRST_WORD_FALL_THROUGH => true,
      INIT => X"000000000",
      IS_RDCLK_INVERTED => '0',
      IS_RDEN_INVERTED => '0',
      IS_RSTREG_INVERTED => '0',
      IS_RST_INVERTED => '0',
      IS_WRCLK_INVERTED => '0',
      IS_WREN_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SRVAL => X"000000000"
    )
        port map (
      ALMOSTEMPTY => NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED,
      ALMOSTFULL => NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED,
      DI(31 downto 7) => B"0000000000000000000000000",
      DI(6) => \^q\(5),
      DI(5) => '0',
      DI(4 downto 0) => \^q\(4 downto 0),
      DIP(3 downto 0) => B"0000",
      DO(31 downto 5) => NLW_FIFO18E1_inst_tid_DO_UNCONNECTED(31 downto 5),
      DO(4 downto 0) => m_axis_tid(4 downto 0),
      DOP(3 downto 0) => NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED(3 downto 0),
      EMPTY => NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED,
      FULL => NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED,
      RDCLK => s_axis_aclk,
      RDCOUNT(11 downto 0) => NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED(11 downto 0),
      RDEN => FIFO18E1_inst_data_i_1_n_0,
      RDERR => NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED,
      REGCE => '1',
      RST => \^m_axis_reset\,
      RSTREG => \^m_axis_reset\,
      WRCLK => m_axis_aclk,
      WRCOUNT(11 downto 0) => NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED(11 downto 0),
      WREN => wren_fifo,
      WRERR => NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED
    );
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0F0F53500F0F"
    )
        port map (
      I0 => busy_o0,
      I1 => state(3),
      I2 => state(0),
      I3 => \FSM_sequential_state[3]_i_9_n_0\,
      I4 => state(1),
      I5 => state(2),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF00F60000"
    )
        port map (
      I0 => DO(15),
      I1 => DO(14),
      I2 => state(2),
      I3 => state(3),
      I4 => state(1),
      I5 => state(0),
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABAAAAAAAEEEE"
    )
        port map (
      I0 => \FSM_sequential_state[2]_i_2_n_0\,
      I1 => state(2),
      I2 => busy_o0,
      I3 => state(0),
      I4 => state(3),
      I5 => state(1),
      O => \FSM_sequential_state[2]_i_1_n_0\
    );
\FSM_sequential_state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000001000000000"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => DO(15),
      I3 => DO(14),
      I4 => state(3),
      I5 => state(1),
      O => \FSM_sequential_state[2]_i_2_n_0\
    );
\FSM_sequential_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFEEFFFFFFEA"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_3_n_0\,
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => \FSM_sequential_state[3]_i_5_n_0\,
      I3 => channel_id(6),
      I4 => \FSM_sequential_state[3]_i_6_n_0\,
      I5 => \FSM_sequential_state[3]_i_7_n_0\,
      O => \FSM_sequential_state[3]_i_1_n_0\
    );
\FSM_sequential_state[3]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => timer_cntr_reg(11),
      I1 => timer_cntr_reg(12),
      I2 => timer_cntr_reg(13),
      I3 => timer_cntr_reg(14),
      I4 => den_o_reg_0,
      I5 => timer_cntr_reg(15),
      O => \FSM_sequential_state[3]_i_10_n_0\
    );
\FSM_sequential_state[3]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(4),
      I1 => drp_rdwr_status,
      I2 => timer_cntr_reg(6),
      I3 => timer_cntr_reg(5),
      O => \FSM_sequential_state[3]_i_11_n_0\
    );
\FSM_sequential_state[3]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(10),
      I1 => timer_cntr_reg(9),
      I2 => timer_cntr_reg(8),
      I3 => timer_cntr_reg(7),
      O => \FSM_sequential_state[3]_i_12_n_0\
    );
\FSM_sequential_state[3]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => timer_cntr_reg(0),
      I1 => timer_cntr_reg(1),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(3),
      O => \FSM_sequential_state[3]_i_13_n_0\
    );
\FSM_sequential_state[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF50000FF0300"
    )
        port map (
      I0 => busy_o0,
      I1 => \FSM_sequential_state[3]_i_9_n_0\,
      I2 => state(2),
      I3 => state(1),
      I4 => state(3),
      I5 => state(0),
      O => \FSM_sequential_state[3]_i_2_n_0\
    );
\FSM_sequential_state[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"13005D4C"
    )
        port map (
      I0 => state(3),
      I1 => state(0),
      I2 => state(2),
      I3 => drdy_C,
      I4 => state(1),
      O => \FSM_sequential_state[3]_i_3_n_0\
    );
\FSM_sequential_state[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => state(0),
      I1 => state(3),
      O => \FSM_sequential_state[3]_i_4_n_0\
    );
\FSM_sequential_state[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFF8000"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_10_n_0\,
      I1 => \FSM_sequential_state[3]_i_11_n_0\,
      I2 => \FSM_sequential_state[3]_i_12_n_0\,
      I3 => \FSM_sequential_state[3]_i_13_n_0\,
      I4 => busy_o0,
      I5 => state(2),
      O => \FSM_sequential_state[3]_i_5_n_0\
    );
\FSM_sequential_state[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000008000"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_13_n_0\,
      I1 => \FSM_sequential_state[3]_i_12_n_0\,
      I2 => \FSM_sequential_state[3]_i_11_n_0\,
      I3 => \FSM_sequential_state[3]_i_10_n_0\,
      I4 => state(2),
      I5 => state(1),
      O => \FSM_sequential_state[3]_i_6_n_0\
    );
\FSM_sequential_state[3]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_13_n_0\,
      I1 => \FSM_sequential_state[3]_i_12_n_0\,
      I2 => \FSM_sequential_state[3]_i_11_n_0\,
      I3 => \FSM_sequential_state[3]_i_10_n_0\,
      I4 => state(2),
      O => \FSM_sequential_state[3]_i_7_n_0\
    );
\FSM_sequential_state[3]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => den_o_reg_0,
      I1 => channel_out(4),
      O => busy_o0
    );
\FSM_sequential_state[3]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => DO(14),
      I1 => DO(15),
      O => \FSM_sequential_state[3]_i_9_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => state(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => state(1)
    );
\FSM_sequential_state_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[2]_i_1_n_0\,
      Q => state(2)
    );
\FSM_sequential_state_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[3]_i_2_n_0\,
      Q => state(3)
    );
\channel_id[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55015701"
    )
        port map (
      I0 => state(3),
      I1 => state(1),
      I2 => state(2),
      I3 => channel_out(0),
      I4 => state(0),
      O => channel_id(0)
    );
\channel_id[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11FD0000"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(1),
      I3 => state(3),
      I4 => channel_out(1),
      O => channel_id(1)
    );
\channel_id[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11FD0000"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(1),
      I3 => state(3),
      I4 => channel_out(2),
      O => channel_id(2)
    );
\channel_id[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1F00110C"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(3),
      I3 => channel_out(3),
      I4 => state(1),
      O => channel_id(3)
    );
\channel_id[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1F001F00110C1D00"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(3),
      I3 => channel_out(4),
      I4 => channel_out(3),
      I5 => state(1),
      O => channel_id(4)
    );
\channel_id[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1F10"
    )
        port map (
      I0 => state(1),
      I1 => state(2),
      I2 => state(3),
      I3 => state(0),
      O => \channel_id[6]_i_1_n_0\
    );
\channel_id[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(3),
      O => channel_id(6)
    );
\channel_id_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(0),
      Q => \^q\(0)
    );
\channel_id_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(1),
      Q => \^q\(1)
    );
\channel_id_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(2),
      Q => \^q\(2)
    );
\channel_id_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(3),
      Q => \^q\(3)
    );
\channel_id_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(4),
      Q => \^q\(4)
    );
\channel_id_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => channel_id(6),
      Q => \^q\(5)
    );
den_o_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEFCC08232F0008"
    )
        port map (
      I0 => den_o0,
      I1 => state(3),
      I2 => state(1),
      I3 => state(2),
      I4 => state(0),
      I5 => \^den_c\,
      O => den_o_i_1_n_0
    );
den_o_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => den_o_reg_0,
      I1 => almost_full,
      O => den_o0
    );
den_o_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => den_o_i_1_n_0,
      Q => \^den_c\
    );
drp_rdwr_status_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F44"
    )
        port map (
      I0 => almost_full,
      I1 => den_o_reg_0,
      I2 => drdy_C,
      I3 => drp_rdwr_status,
      O => drp_rdwr_status_i_1_n_0
    );
drp_rdwr_status_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => drp_rdwr_status_i_1_n_0,
      Q => drp_rdwr_status
    );
m_axis_tvalid_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_empty,
      O => m_axis_tvalid
    );
\temp_out[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000080"
    )
        port map (
      I0 => drdy_C,
      I1 => state(1),
      I2 => state(3),
      I3 => state(2),
      I4 => state(0),
      O => \temp_out[11]_i_1_n_0\
    );
\temp_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(4),
      Q => temp_out(0)
    );
\temp_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(14),
      Q => temp_out(10)
    );
\temp_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(15),
      Q => temp_out(11)
    );
\temp_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(5),
      Q => temp_out(1)
    );
\temp_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(6),
      Q => temp_out(2)
    );
\temp_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(7),
      Q => temp_out(3)
    );
\temp_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(8),
      Q => temp_out(4)
    );
\temp_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(9),
      Q => temp_out(5)
    );
\temp_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(10),
      Q => temp_out(6)
    );
\temp_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(11),
      Q => temp_out(7)
    );
\temp_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(12),
      Q => temp_out(8)
    );
\temp_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => DO(13),
      Q => temp_out(9)
    );
\timer_cntr[0]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => timer_cntr_reg(13),
      I2 => timer_cntr_reg(14),
      I3 => timer_cntr_reg(15),
      I4 => \timer_cntr[12]_i_9_n_0\,
      O => \timer_cntr[0]_i_10_n_0\
    );
\timer_cntr[0]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(7),
      I1 => timer_cntr_reg(6),
      I2 => timer_cntr_reg(5),
      I3 => timer_cntr_reg(4),
      O => \timer_cntr[0]_i_11_n_0\
    );
\timer_cntr[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00020000"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => timer_cntr_reg(2),
      I2 => timer_cntr_reg(0),
      I3 => timer_cntr_reg(1),
      I4 => \timer_cntr[0]_i_11_n_0\,
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_2_n_0\
    );
\timer_cntr[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(2),
      O => \timer_cntr[0]_i_3_n_0\
    );
\timer_cntr[0]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(1),
      O => \timer_cntr[0]_i_4_n_0\
    );
\timer_cntr[0]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(0),
      O => \timer_cntr[0]_i_5_n_0\
    );
\timer_cntr[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_6_n_0\
    );
\timer_cntr[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3333333133333333"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => timer_cntr_reg(2),
      I2 => timer_cntr_reg(3),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(1),
      I5 => \timer_cntr[0]_i_11_n_0\,
      O => \timer_cntr[0]_i_7_n_0\
    );
\timer_cntr[0]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFD0000FFFF"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => timer_cntr_reg(2),
      I2 => timer_cntr_reg(3),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(1),
      I5 => \timer_cntr[0]_i_11_n_0\,
      O => \timer_cntr[0]_i_8_n_0\
    );
\timer_cntr[0]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FF00FD00FF00FF"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => timer_cntr_reg(2),
      I2 => timer_cntr_reg(3),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(1),
      I5 => \timer_cntr[0]_i_11_n_0\,
      O => \timer_cntr[0]_i_9_n_0\
    );
\timer_cntr[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(14),
      O => \timer_cntr[12]_i_2_n_0\
    );
\timer_cntr[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(13),
      O => \timer_cntr[12]_i_3_n_0\
    );
\timer_cntr[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(12),
      O => \timer_cntr[12]_i_4_n_0\
    );
\timer_cntr[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FE00FF00FF00FF"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => timer_cntr_reg(13),
      I2 => timer_cntr_reg(14),
      I3 => timer_cntr_reg(15),
      I4 => \timer_cntr[12]_i_9_n_0\,
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[12]_i_5_n_0\
    );
\timer_cntr[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0E0F0F0F0F0F0F"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => timer_cntr_reg(13),
      I2 => timer_cntr_reg(14),
      I3 => timer_cntr_reg(15),
      I4 => \timer_cntr[12]_i_9_n_0\,
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[12]_i_6_n_0\
    );
\timer_cntr[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3332333333333333"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => timer_cntr_reg(13),
      I2 => timer_cntr_reg(14),
      I3 => timer_cntr_reg(15),
      I4 => \timer_cntr[12]_i_9_n_0\,
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[12]_i_7_n_0\
    );
\timer_cntr[12]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5554555555555555"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => timer_cntr_reg(13),
      I2 => timer_cntr_reg(14),
      I3 => timer_cntr_reg(15),
      I4 => \timer_cntr[12]_i_9_n_0\,
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[12]_i_8_n_0\
    );
\timer_cntr[12]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(11),
      I1 => timer_cntr_reg(10),
      I2 => timer_cntr_reg(9),
      I3 => timer_cntr_reg(8),
      O => \timer_cntr[12]_i_9_n_0\
    );
\timer_cntr[4]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(1),
      I1 => timer_cntr_reg(0),
      I2 => timer_cntr_reg(3),
      I3 => timer_cntr_reg(2),
      O => \timer_cntr[4]_i_10_n_0\
    );
\timer_cntr[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000008"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => \timer_cntr[4]_i_10_n_0\,
      I2 => timer_cntr_reg(4),
      I3 => timer_cntr_reg(5),
      I4 => timer_cntr_reg(6),
      I5 => timer_cntr_reg(7),
      O => \timer_cntr[4]_i_2_n_0\
    );
\timer_cntr[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000008"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => \timer_cntr[4]_i_10_n_0\,
      I2 => timer_cntr_reg(4),
      I3 => timer_cntr_reg(5),
      I4 => timer_cntr_reg(7),
      I5 => timer_cntr_reg(6),
      O => \timer_cntr[4]_i_3_n_0\
    );
\timer_cntr[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000008"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => \timer_cntr[4]_i_10_n_0\,
      I2 => timer_cntr_reg(4),
      I3 => timer_cntr_reg(6),
      I4 => timer_cntr_reg(7),
      I5 => timer_cntr_reg(5),
      O => \timer_cntr[4]_i_4_n_0\
    );
\timer_cntr[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(4),
      O => \timer_cntr[4]_i_5_n_0\
    );
\timer_cntr[4]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(7),
      O => \timer_cntr[4]_i_6_n_0\
    );
\timer_cntr[4]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(6),
      O => \timer_cntr[4]_i_7_n_0\
    );
\timer_cntr[4]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(5),
      O => \timer_cntr[4]_i_8_n_0\
    );
\timer_cntr[4]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0F0F0F0F0F0F07"
    )
        port map (
      I0 => \timer_cntr[0]_i_10_n_0\,
      I1 => \timer_cntr[4]_i_10_n_0\,
      I2 => timer_cntr_reg(4),
      I3 => timer_cntr_reg(5),
      I4 => timer_cntr_reg(6),
      I5 => timer_cntr_reg(7),
      O => \timer_cntr[4]_i_9_n_0\
    );
\timer_cntr[8]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => timer_cntr_reg(15),
      I1 => timer_cntr_reg(14),
      I2 => timer_cntr_reg(13),
      I3 => timer_cntr_reg(12),
      O => \timer_cntr[8]_i_10_n_0\
    );
\timer_cntr[8]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => timer_cntr_reg(2),
      I1 => timer_cntr_reg(3),
      I2 => timer_cntr_reg(0),
      I3 => timer_cntr_reg(1),
      I4 => \timer_cntr[0]_i_11_n_0\,
      O => \timer_cntr[8]_i_11_n_0\
    );
\timer_cntr[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(11),
      O => \timer_cntr[8]_i_2_n_0\
    );
\timer_cntr[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => timer_cntr_reg(10),
      O => \timer_cntr[8]_i_3_n_0\
    );
\timer_cntr[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00020000"
    )
        port map (
      I0 => \timer_cntr[8]_i_10_n_0\,
      I1 => timer_cntr_reg(8),
      I2 => timer_cntr_reg(10),
      I3 => timer_cntr_reg(11),
      I4 => \timer_cntr[8]_i_11_n_0\,
      I5 => timer_cntr_reg(9),
      O => \timer_cntr[8]_i_4_n_0\
    );
\timer_cntr[8]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00020000"
    )
        port map (
      I0 => \timer_cntr[8]_i_10_n_0\,
      I1 => timer_cntr_reg(9),
      I2 => timer_cntr_reg(10),
      I3 => timer_cntr_reg(11),
      I4 => \timer_cntr[8]_i_11_n_0\,
      I5 => timer_cntr_reg(8),
      O => \timer_cntr[8]_i_5_n_0\
    );
\timer_cntr[8]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFD0000FFFF"
    )
        port map (
      I0 => \timer_cntr[8]_i_10_n_0\,
      I1 => timer_cntr_reg(8),
      I2 => timer_cntr_reg(9),
      I3 => timer_cntr_reg(10),
      I4 => timer_cntr_reg(11),
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[8]_i_6_n_0\
    );
\timer_cntr[8]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FF00FD00FF00FF"
    )
        port map (
      I0 => \timer_cntr[8]_i_10_n_0\,
      I1 => timer_cntr_reg(8),
      I2 => timer_cntr_reg(9),
      I3 => timer_cntr_reg(10),
      I4 => timer_cntr_reg(11),
      I5 => \timer_cntr[8]_i_11_n_0\,
      O => \timer_cntr[8]_i_7_n_0\
    );
\timer_cntr[8]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(9),
      O => \timer_cntr[8]_i_8_n_0\
    );
\timer_cntr[8]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(8),
      O => \timer_cntr[8]_i_9_n_0\
    );
\timer_cntr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[0]_i_1_n_7\,
      Q => timer_cntr_reg(0)
    );
\timer_cntr_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timer_cntr_reg[0]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[0]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[0]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \timer_cntr[0]_i_2_n_0\,
      DI(2) => \timer_cntr[0]_i_3_n_0\,
      DI(1) => \timer_cntr[0]_i_4_n_0\,
      DI(0) => \timer_cntr[0]_i_5_n_0\,
      O(3) => \timer_cntr_reg[0]_i_1_n_4\,
      O(2) => \timer_cntr_reg[0]_i_1_n_5\,
      O(1) => \timer_cntr_reg[0]_i_1_n_6\,
      O(0) => \timer_cntr_reg[0]_i_1_n_7\,
      S(3) => \timer_cntr[0]_i_6_n_0\,
      S(2) => \timer_cntr[0]_i_7_n_0\,
      S(1) => \timer_cntr[0]_i_8_n_0\,
      S(0) => \timer_cntr[0]_i_9_n_0\
    );
\timer_cntr_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[8]_i_1_n_5\,
      Q => timer_cntr_reg(10)
    );
\timer_cntr_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[8]_i_1_n_4\,
      Q => timer_cntr_reg(11)
    );
\timer_cntr_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[12]_i_1_n_7\,
      Q => timer_cntr_reg(12)
    );
\timer_cntr_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[8]_i_1_n_0\,
      CO(3) => \NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \timer_cntr_reg[12]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[12]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \timer_cntr[12]_i_2_n_0\,
      DI(1) => \timer_cntr[12]_i_3_n_0\,
      DI(0) => \timer_cntr[12]_i_4_n_0\,
      O(3) => \timer_cntr_reg[12]_i_1_n_4\,
      O(2) => \timer_cntr_reg[12]_i_1_n_5\,
      O(1) => \timer_cntr_reg[12]_i_1_n_6\,
      O(0) => \timer_cntr_reg[12]_i_1_n_7\,
      S(3) => \timer_cntr[12]_i_5_n_0\,
      S(2) => \timer_cntr[12]_i_6_n_0\,
      S(1) => \timer_cntr[12]_i_7_n_0\,
      S(0) => \timer_cntr[12]_i_8_n_0\
    );
\timer_cntr_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[12]_i_1_n_6\,
      Q => timer_cntr_reg(13)
    );
\timer_cntr_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[12]_i_1_n_5\,
      Q => timer_cntr_reg(14)
    );
\timer_cntr_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[12]_i_1_n_4\,
      Q => timer_cntr_reg(15)
    );
\timer_cntr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[0]_i_1_n_6\,
      Q => timer_cntr_reg(1)
    );
\timer_cntr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[0]_i_1_n_5\,
      Q => timer_cntr_reg(2)
    );
\timer_cntr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[0]_i_1_n_4\,
      Q => timer_cntr_reg(3)
    );
\timer_cntr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[4]_i_1_n_7\,
      Q => timer_cntr_reg(4)
    );
\timer_cntr_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[0]_i_1_n_0\,
      CO(3) => \timer_cntr_reg[4]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[4]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[4]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \timer_cntr[4]_i_2_n_0\,
      DI(2) => \timer_cntr[4]_i_3_n_0\,
      DI(1) => \timer_cntr[4]_i_4_n_0\,
      DI(0) => \timer_cntr[4]_i_5_n_0\,
      O(3) => \timer_cntr_reg[4]_i_1_n_4\,
      O(2) => \timer_cntr_reg[4]_i_1_n_5\,
      O(1) => \timer_cntr_reg[4]_i_1_n_6\,
      O(0) => \timer_cntr_reg[4]_i_1_n_7\,
      S(3) => \timer_cntr[4]_i_6_n_0\,
      S(2) => \timer_cntr[4]_i_7_n_0\,
      S(1) => \timer_cntr[4]_i_8_n_0\,
      S(0) => \timer_cntr[4]_i_9_n_0\
    );
\timer_cntr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[4]_i_1_n_6\,
      Q => timer_cntr_reg(5)
    );
\timer_cntr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[4]_i_1_n_5\,
      Q => timer_cntr_reg(6)
    );
\timer_cntr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[4]_i_1_n_4\,
      Q => timer_cntr_reg(7)
    );
\timer_cntr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[8]_i_1_n_7\,
      Q => timer_cntr_reg(8)
    );
\timer_cntr_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[4]_i_1_n_0\,
      CO(3) => \timer_cntr_reg[8]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[8]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[8]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \timer_cntr[8]_i_2_n_0\,
      DI(2) => \timer_cntr[8]_i_3_n_0\,
      DI(1) => \timer_cntr[8]_i_4_n_0\,
      DI(0) => \timer_cntr[8]_i_5_n_0\,
      O(3) => \timer_cntr_reg[8]_i_1_n_4\,
      O(2) => \timer_cntr_reg[8]_i_1_n_5\,
      O(1) => \timer_cntr_reg[8]_i_1_n_6\,
      O(0) => \timer_cntr_reg[8]_i_1_n_7\,
      S(3) => \timer_cntr[8]_i_6_n_0\,
      S(2) => \timer_cntr[8]_i_7_n_0\,
      S(1) => \timer_cntr[8]_i_8_n_0\,
      S(0) => \timer_cntr[8]_i_9_n_0\
    );
\timer_cntr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \timer_cntr_reg[8]_i_1_n_6\,
      Q => timer_cntr_reg(9)
    );
valid_data_wren_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCFFFFFC00000008"
    )
        port map (
      I0 => drdy_C,
      I1 => state(1),
      I2 => state(2),
      I3 => state(0),
      I4 => state(3),
      I5 => valid_data_wren_reg_n_0,
      O => valid_data_wren_i_1_n_0
    );
valid_data_wren_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => valid_data_wren_i_1_n_0,
      Q => valid_data_wren_reg_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp is
  port (
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    busy_out : out STD_LOGIC;
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    vn_in : in STD_LOGIC;
    vp_in : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp is
  signal \^channel_out\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal daddr_C : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal den_C : STD_LOGIC;
  signal do_C : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal drdy_C : STD_LOGIC;
  signal \^eoc_out\ : STD_LOGIC;
  signal m_axis_reset : STD_LOGIC;
  signal NLW_XADC_INST_JTAGBUSY_UNCONNECTED : STD_LOGIC;
  signal NLW_XADC_INST_JTAGLOCKED_UNCONNECTED : STD_LOGIC;
  signal NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED : STD_LOGIC;
  signal NLW_XADC_INST_MUXADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute box_type : string;
  attribute box_type of XADC_INST : label is "PRIMITIVE";
begin
  channel_out(4 downto 0) <= \^channel_out\(4 downto 0);
  eoc_out <= \^eoc_out\;
XADC_INST: unisim.vcomponents.XADC
    generic map(
      INIT_40 => X"0000",
      INIT_41 => X"31A0",
      INIT_42 => X"0400",
      INIT_43 => X"0000",
      INIT_44 => X"0000",
      INIT_45 => X"0000",
      INIT_46 => X"0000",
      INIT_47 => X"0000",
      INIT_48 => X"0100",
      INIT_49 => X"0000",
      INIT_4A => X"0000",
      INIT_4B => X"0000",
      INIT_4C => X"0000",
      INIT_4D => X"0000",
      INIT_4E => X"0000",
      INIT_4F => X"0000",
      INIT_50 => X"B5ED",
      INIT_51 => X"57E4",
      INIT_52 => X"A147",
      INIT_53 => X"CA33",
      INIT_54 => X"A93A",
      INIT_55 => X"52C6",
      INIT_56 => X"9555",
      INIT_57 => X"AE4E",
      INIT_58 => X"5999",
      INIT_59 => X"0000",
      INIT_5A => X"0000",
      INIT_5B => X"0000",
      INIT_5C => X"5111",
      INIT_5D => X"0000",
      INIT_5E => X"0000",
      INIT_5F => X"0000",
      IS_CONVSTCLK_INVERTED => '0',
      IS_DCLK_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SIM_MONITOR_FILE => "design.txt"
    )
        port map (
      ALM(7 downto 0) => alarm_out(7 downto 0),
      BUSY => busy_out,
      CHANNEL(4 downto 0) => \^channel_out\(4 downto 0),
      CONVST => '0',
      CONVSTCLK => '0',
      DADDR(6) => daddr_C(6),
      DADDR(5) => '0',
      DADDR(4 downto 0) => daddr_C(4 downto 0),
      DCLK => m_axis_aclk,
      DEN => den_C,
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => do_C(15 downto 0),
      DRDY => drdy_C,
      DWE => '0',
      EOC => \^eoc_out\,
      EOS => eos_out,
      JTAGBUSY => NLW_XADC_INST_JTAGBUSY_UNCONNECTED,
      JTAGLOCKED => NLW_XADC_INST_JTAGLOCKED_UNCONNECTED,
      JTAGMODIFIED => NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED,
      MUXADDR(4 downto 0) => NLW_XADC_INST_MUXADDR_UNCONNECTED(4 downto 0),
      OT => ot_out,
      RESET => m_axis_reset,
      VAUXN(15 downto 0) => B"0000000000000000",
      VAUXP(15 downto 0) => B"0000000000000000",
      VN => vn_in,
      VP => vp_in
    );
drp_to_axi4stream_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_drp_to_axi4stream
     port map (
      DO(15 downto 0) => do_C(15 downto 0),
      Q(5) => daddr_C(6),
      Q(4 downto 0) => daddr_C(4 downto 0),
      channel_out(4 downto 0) => \^channel_out\(4 downto 0),
      den_C => den_C,
      den_o_reg_0 => \^eoc_out\,
      drdy_C => drdy_C,
      m_axis_aclk => m_axis_aclk,
      m_axis_reset => m_axis_reset,
      m_axis_resetn => m_axis_resetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      s_axis_aclk => s_axis_aclk,
      temp_out(11 downto 0) => temp_out(11 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc is
  port (
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_tready : in STD_LOGIC;
    busy_out : out STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc is
begin
AXI_XADC_CORE_I: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_xadc_core_drp
     port map (
      alarm_out(7 downto 0) => alarm_out(7 downto 0),
      busy_out => busy_out,
      channel_out(4 downto 0) => channel_out(4 downto 0),
      eoc_out => eoc_out,
      eos_out => eos_out,
      m_axis_aclk => m_axis_aclk,
      m_axis_resetn => m_axis_resetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      ot_out => ot_out,
      s_axis_aclk => s_axis_aclk,
      temp_out(11 downto 0) => temp_out(11 downto 0),
      vn_in => vn_in,
      vp_in => vp_in
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_tready : in STD_LOGIC;
    busy_out : out STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    vccaux_alarm_out : out STD_LOGIC;
    vccint_alarm_out : out STD_LOGIC;
    user_temp_alarm_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC;
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal NLW_U0_alarm_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 3 );
begin
U0: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xadc_wiz_0_axi_xadc
     port map (
      alarm_out(7) => alarm_out,
      alarm_out(6 downto 3) => NLW_U0_alarm_out_UNCONNECTED(6 downto 3),
      alarm_out(2) => vccaux_alarm_out,
      alarm_out(1) => vccint_alarm_out,
      alarm_out(0) => user_temp_alarm_out,
      busy_out => busy_out,
      channel_out(4 downto 0) => channel_out(4 downto 0),
      eoc_out => eoc_out,
      eos_out => eos_out,
      m_axis_aclk => m_axis_aclk,
      m_axis_resetn => m_axis_resetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      ot_out => ot_out,
      s_axis_aclk => s_axis_aclk,
      temp_out(11 downto 0) => temp_out(11 downto 0),
      vn_in => vn_in,
      vp_in => vp_in
    );
end STRUCTURE;
