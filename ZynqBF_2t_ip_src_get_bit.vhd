-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_get_bit.vhd
-- Created: 2019-02-08 23:33:51
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_get_bit
-- Source Path: ZynqBF_2tx_fpga/channel_estimator/peakdetect_ch1/correlator1/rx_ram_i/get_bit
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ZynqBF_2t_ip_src_get_bit IS
  PORT( u                                 :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        ind                               :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        y                                 :   OUT   std_logic
        );
END ZynqBF_2t_ip_src_get_bit;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_get_bit IS

  -- Signals
  SIGNAL u_unsigned                       : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL ind_unsigned                     : unsigned(8 DOWNTO 0);  -- ufix9

BEGIN
  u_unsigned <= unsigned(u);

  ind_unsigned <= unsigned(ind);

  get_bit_output : PROCESS (ind_unsigned, u_unsigned)
    VARIABLE c : std_logic;
    VARIABLE bit_idx : unsigned(7 DOWNTO 0);
    VARIABLE sub_temp : signed(16 DOWNTO 0);
  BEGIN
    c := '0';
    --MATLAB Function 'channel_estimator/peakdetect_ch1/correlator1/rx_ram_i/get_bit'
    IF (ind_unsigned >= to_unsigned(16#001#, 9)) AND (ind_unsigned <= to_unsigned(16#040#, 9)) THEN 
      sub_temp := signed(resize(ind_unsigned, 17)) - to_signed(16#00001#, 17);
      IF (sub_temp(16) = '0') AND (sub_temp(15 DOWNTO 8) /= "00000000") THEN 
        bit_idx := "11111111";
      ELSIF sub_temp(16) = '1' THEN 
        bit_idx := "00000000";
      ELSE 
        bit_idx := unsigned(sub_temp(7 DOWNTO 0));
      END IF;
      c := u_unsigned(to_integer(bit_idx));
    END IF;
    IF c /= '0' THEN 
      y <= '1';
    ELSE 
      y <= '0';
    END IF;
  END PROCESS get_bit_output;


END rtl;

