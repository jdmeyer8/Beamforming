-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_correlator_en_block.vhd
-- Created: 2019-02-08 23:33:51
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_correlator_en_block
-- Source Path: ZynqBF_2tx_fpga/channel_estimator/peakdetect_ch2/correlator2/correlator_en
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ZynqBF_2t_ip_src_correlator_en_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        valid                             :   IN    std_logic;
        done                              :   IN    std_logic;
        addri                             :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        start                             :   OUT   std_logic;
        en                                :   OUT   std_logic;
        gs_addr                           :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
        rx_addr                           :   OUT   std_logic_vector(9 DOWNTO 0)  -- ufix10
        );
END ZynqBF_2t_ip_src_correlator_en_block;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_correlator_en_block IS

  -- Signals
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL Delay3_out1                      : std_logic;
  SIGNAL corr_state_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL corr_addr_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL addri_unsigned                   : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Sum_out1                         : unsigned(9 DOWNTO 0);  -- ufix10

BEGIN
  Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay1_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay1_out1 <= valid;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay3_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay3_out1 <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 1
  corr_state_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        corr_state_out1 <= to_unsigned(16#00#, 6);
      ELSIF enb = '1' THEN
        IF done = '1' THEN 
          corr_state_out1 <= to_unsigned(16#00#, 6);
        ELSIF Delay1_out1 = '1' THEN 
          IF corr_state_out1 >= to_unsigned(16#01#, 6) THEN 
            corr_state_out1 <= to_unsigned(16#00#, 6);
          ELSE 
            corr_state_out1 <= corr_state_out1 + to_unsigned(16#01#, 6);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS corr_state_process;


  
  Compare_To_Constant_out1 <= '1' WHEN corr_state_out1 = to_unsigned(16#01#, 6) ELSE
      '0';

  Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay2_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay2_out1 <= Compare_To_Constant_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 63
  corr_addr_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        corr_addr_out1 <= to_unsigned(16#00#, 6);
      ELSIF enb = '1' THEN
        IF valid = '1' THEN 
          corr_addr_out1 <= to_unsigned(16#00#, 6);
        ELSIF Delay2_out1 = '1' THEN 
          corr_addr_out1 <= corr_addr_out1 + to_unsigned(16#01#, 6);
        END IF;
      END IF;
    END IF;
  END PROCESS corr_addr_process;


  gs_addr <= std_logic_vector(corr_addr_out1);

  addri_unsigned <= unsigned(addri);

  Sum_out1 <= resize(corr_addr_out1, 10) + resize(addri_unsigned, 10);

  rx_addr <= std_logic_vector(Sum_out1);

  start <= Delay3_out1;

  en <= Delay2_out1;

END rtl;

