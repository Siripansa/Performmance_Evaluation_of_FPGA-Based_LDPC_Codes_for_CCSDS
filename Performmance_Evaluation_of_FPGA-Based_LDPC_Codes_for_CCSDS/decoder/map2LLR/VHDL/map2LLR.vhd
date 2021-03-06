-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity map2LLR is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    Lch_Q_address0 : OUT STD_LOGIC_VECTOR (10 downto 0);
    Lch_Q_ce0 : OUT STD_LOGIC;
    Lch_Q_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    Lvn_address0 : OUT STD_LOGIC_VECTOR (12 downto 0);
    Lvn_ce0 : OUT STD_LOGIC;
    Lvn_we0 : OUT STD_LOGIC;
    Lvn_d0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of map2LLR is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "map2LLR,hls_ip_2019_1,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg484-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.508000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=14,HLS_SYN_DSP=0,HLS_SYN_FF=261,HLS_SYN_LUT=304,HLS_VERSION=2019_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (6 downto 0) := "0000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (6 downto 0) := "0000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (6 downto 0) := "0001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (6 downto 0) := "0010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (6 downto 0) := "0100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (6 downto 0) := "1000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv12_0 : STD_LOGIC_VECTOR (11 downto 0) := "000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv12_A00 : STD_LOGIC_VECTOR (11 downto 0) := "101000000000";
    constant ap_const_lv12_1 : STD_LOGIC_VECTOR (11 downto 0) := "000000000001";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv32_1E00 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000001111000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_CS_fsm : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal col_inx_address0 : STD_LOGIC_VECTOR (12 downto 0);
    signal col_inx_ce0 : STD_LOGIC;
    signal col_inx_q0 : STD_LOGIC_VECTOR (11 downto 0);
    signal i_2_fu_152_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal i_2_reg_245 : STD_LOGIC_VECTOR (11 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal tmp_fu_158_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_reg_250 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln28_fu_146_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln31_fu_166_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln31_reg_254 : STD_LOGIC_VECTOR (63 downto 0);
    signal j_2_reg_271 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal i_fu_183_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal i_reg_279 : STD_LOGIC_VECTOR (11 downto 0);
    signal tmp_1_reg_285 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln47_fu_177_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal empty_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal empty_5_reg_295 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal sext_ln51_fu_208_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal sext_ln51_reg_303 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal icmp_ln49_fu_202_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal j_3_fu_236_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state7 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state7 : signal is "none";
    signal empty_address0 : STD_LOGIC_VECTOR (11 downto 0);
    signal empty_ce0 : STD_LOGIC;
    signal empty_we0 : STD_LOGIC;
    signal empty_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_0_reg_111 : STD_LOGIC_VECTOR (11 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal i_1_reg_122 : STD_LOGIC_VECTOR (11 downto 0);
    signal j1_0_reg_133 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln54_fu_197_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal icmp_ln51_fu_213_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal j_fu_40 : STD_LOGIC_VECTOR (31 downto 0);
    signal b_fu_225_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (6 downto 0);

    component map2LLR_col_inx IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (12 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (11 downto 0) );
    end component;


    component map2LLR_empty IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (11 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        q0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin
    col_inx_U : component map2LLR_col_inx
    generic map (
        DataWidth => 12,
        AddressRange => 7680,
        AddressWidth => 13)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => col_inx_address0,
        ce0 => col_inx_ce0,
        q0 => col_inx_q0);

    empty_U : component map2LLR_empty
    generic map (
        DataWidth => 32,
        AddressRange => 2560,
        AddressWidth => 12)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => empty_address0,
        ce0 => empty_ce0,
        we0 => empty_we0,
        d0 => empty_d0,
        q0 => empty_q0);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    i_0_reg_111_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                i_0_reg_111 <= i_2_reg_245;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                i_0_reg_111 <= ap_const_lv12_0;
            end if; 
        end if;
    end process;

    i_1_reg_122_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln49_fu_202_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state6))) then 
                i_1_reg_122 <= i_reg_279;
            elsif (((icmp_ln28_fu_146_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                i_1_reg_122 <= ap_const_lv12_0;
            end if; 
        end if;
    end process;

    j1_0_reg_133_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
                j1_0_reg_133 <= j_2_reg_271;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
                j1_0_reg_133 <= j_3_fu_236_p2;
            end if; 
        end if;
    end process;

    j_fu_40_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln51_fu_213_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state7))) then 
                j_fu_40 <= b_fu_225_p2;
            elsif (((icmp_ln28_fu_146_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                j_fu_40 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state5)) then
                empty_5_reg_295 <= empty_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                i_2_reg_245 <= i_2_fu_152_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then
                i_reg_279 <= i_fu_183_p2;
                j_2_reg_271 <= j_fu_40;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln49_fu_202_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state6))) then
                sext_ln51_reg_303 <= sext_ln51_fu_208_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln47_fu_177_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                tmp_1_reg_285 <= i_1_reg_122(11 downto 11);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln28_fu_146_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                tmp_reg_250 <= i_0_reg_111(11 downto 11);
                    zext_ln31_reg_254(11 downto 0) <= zext_ln31_fu_166_p1(11 downto 0);
            end if;
        end if;
    end process;
    zext_ln31_reg_254(63 downto 12) <= "0000000000000000000000000000000000000000000000000000";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, icmp_ln28_fu_146_p2, ap_CS_fsm_state4, icmp_ln47_fu_177_p2, ap_CS_fsm_state6, icmp_ln49_fu_202_p2)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln28_fu_146_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state2;
            when ap_ST_fsm_state4 => 
                if (((icmp_ln47_fu_177_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                if (((icmp_ln49_fu_202_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state6))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_state7;
                end if;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when others =>  
                ap_NS_fsm <= "XXXXXXX";
        end case;
    end process;
    Lch_Q_address0 <= zext_ln31_fu_166_p1(11 - 1 downto 0);

    Lch_Q_ce0_assign_proc : process(ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            Lch_Q_ce0 <= ap_const_logic_1;
        else 
            Lch_Q_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    Lvn_address0 <= sext_ln51_reg_303(13 - 1 downto 0);

    Lvn_ce0_assign_proc : process(ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            Lvn_ce0 <= ap_const_logic_1;
        else 
            Lvn_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    Lvn_d0 <= 
        ap_const_lv32_1 when (tmp_1_reg_285(0) = '1') else 
        empty_5_reg_295;

    Lvn_we0_assign_proc : process(ap_CS_fsm_state7, icmp_ln51_fu_213_p2)
    begin
        if (((icmp_ln51_fu_213_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state7))) then 
            Lvn_we0 <= ap_const_logic_1;
        else 
            Lvn_we0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
    ap_CS_fsm_state6 <= ap_CS_fsm(5);
    ap_CS_fsm_state7 <= ap_CS_fsm(6);

    ap_done_assign_proc : process(ap_CS_fsm_state4, icmp_ln47_fu_177_p2)
    begin
        if (((icmp_ln47_fu_177_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state4, icmp_ln47_fu_177_p2)
    begin
        if (((icmp_ln47_fu_177_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    b_fu_225_p2 <= std_logic_vector(unsigned(j_fu_40) + unsigned(ap_const_lv32_1));
    col_inx_address0 <= sext_ln51_fu_208_p1(13 - 1 downto 0);

    col_inx_ce0_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            col_inx_ce0 <= ap_const_logic_1;
        else 
            col_inx_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    empty_address0_assign_proc : process(ap_CS_fsm_state2, zext_ln31_fu_166_p1, zext_ln31_reg_254, ap_CS_fsm_state4, ap_CS_fsm_state3, zext_ln54_fu_197_p1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            empty_address0 <= zext_ln54_fu_197_p1(12 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            empty_address0 <= zext_ln31_reg_254(12 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            empty_address0 <= zext_ln31_fu_166_p1(12 - 1 downto 0);
        else 
            empty_address0 <= "XXXXXXXXXXXX";
        end if; 
    end process;


    empty_ce0_assign_proc : process(ap_CS_fsm_state2, ap_CS_fsm_state4, ap_CS_fsm_state3)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state2) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            empty_ce0 <= ap_const_logic_1;
        else 
            empty_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    empty_d0_assign_proc : process(Lch_Q_q0, ap_CS_fsm_state2, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            empty_d0 <= Lch_Q_q0;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            empty_d0 <= ap_const_lv32_0;
        else 
            empty_d0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    empty_we0_assign_proc : process(ap_CS_fsm_state2, tmp_fu_158_p3, tmp_reg_250, icmp_ln28_fu_146_p2, ap_CS_fsm_state3)
    begin
        if ((((icmp_ln28_fu_146_p2 = ap_const_lv1_0) and (tmp_fu_158_p3 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2)) or ((tmp_reg_250 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3)))) then 
            empty_we0 <= ap_const_logic_1;
        else 
            empty_we0 <= ap_const_logic_0;
        end if; 
    end process;

    i_2_fu_152_p2 <= std_logic_vector(unsigned(i_0_reg_111) + unsigned(ap_const_lv12_1));
    i_fu_183_p2 <= std_logic_vector(unsigned(i_1_reg_122) + unsigned(ap_const_lv12_1));
    icmp_ln28_fu_146_p2 <= "1" when (i_0_reg_111 = ap_const_lv12_A00) else "0";
    icmp_ln47_fu_177_p2 <= "1" when (i_1_reg_122 = ap_const_lv12_A00) else "0";
    icmp_ln49_fu_202_p2 <= "1" when (signed(j1_0_reg_133) < signed(ap_const_lv32_1E00)) else "0";
    icmp_ln51_fu_213_p2 <= "1" when (col_inx_q0 = i_reg_279) else "0";
    j_3_fu_236_p2 <= std_logic_vector(signed(j1_0_reg_133) + signed(ap_const_lv32_1));
        sext_ln51_fu_208_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(j1_0_reg_133),64));

    tmp_fu_158_p3 <= i_0_reg_111(11 downto 11);
    zext_ln31_fu_166_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_0_reg_111),64));
    zext_ln54_fu_197_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_1_reg_122),64));
end behav;
