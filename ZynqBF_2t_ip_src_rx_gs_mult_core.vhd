-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_rx_bram.vhd
-- Created: 2019-02-08 23:33:52
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_rx_bram
-- Source Path: ZynqBF_2tx_fpga/channel_estimator/rx_bram
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ZynqBF_2t_ip_src_ZynqBF_2tx_fpga_pkg.ALL;

LIBRARY UNISIM;
use UNISIM.vcomponents.all;

LIBRARY UNIMACRO;
use UNIMACRO.vcomponents.all;

ENTITY ZynqBF_2t_ip_src_rx_gs_mult_core IS
  GENERIC( NDSP                           :   integer := 64);   -- number of DSPs to use for multiply-accumulate
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        en                                :   IN    std_logic;  -- enable for MACC
        rxi                               :   IN    vector_of_std_logic_vector16(0 TO (NDSP-1));  -- rx i data for the multipy-accumulator
        rxq                               :   IN    vector_of_std_logic_vector16(0 TO (NDSP-1));  -- rx q data for the multipy-accumulator
        gsi                               :   IN    vector_of_std_logic_vector16(0 TO (NDSP-1));  -- gs i data for the multipy-accumulator
        gsq                               :   IN    vector_of_std_logic_vector16(0 TO (NDSP-1))   -- gs q data for the multipy-accumulator
        );
END ZynqBF_2t_ip_src_rx_gs_mult_core;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_rx_gs_mult_core IS

  component rx_gs_mult_dsp
    port(
        CLK : in STD_LOGIC;
        A : in STD_LOGIC_VECTOR(15 downto 0);
        B : in STD_LOGIC_VECTOR(15 downto 0);
        C : in STD_LOGIC_VECTOR(31 downto 0);
        P : out STD_LOGIC_VECTOR(31 downto 0);
        CEA4 : in STD_LOGIC;
        CEB4 : in STD_LOGIC;
        CEC4 : in STD_LOGIC;
        CEC5 : in STD_LOGIC
    );
  end component;

  -- Signals
  -- signal macc_p:                std_logic_vector(31 downto 0);
  -- signal macc_a:                std_logic_vector(15 downto 0);
  -- signal macc_b:                std_logic_vector(15 downto 0);
  -- signal macc_c:                std_logic_vector(31 downto 0);
  
  signal macc_p:                vector_of_signed32(0 to (NDSP-1));
  signal macc_a:                vector_of_signed16(0 to (NDSP-1));
  signal macc_b:                vector_of_signed16(0 to (NDSP-1));
  signal macc_c:                vector_of_signed32(0 to (NDSP-1));
  signal macc_m:                vector_of_signed32(0 to (NDSP-1));
  
  -- signal macc_p_d1:             std_logic_vector(31 downto 0);
  -- signal macc_p_d2:             std_logic_vector(31 downto 0);
  -- signal macc_p_d3:             std_logic_vector(31 downto 0);
  
  signal en_dreg:               std_logic_vector(2 downto 0);
  signal en_d1:                 std_logic;
  signal en_d2:                 std_logic;
  signal en_d3:                 std_logic;
  
BEGIN
   
  register_inputs : process(clk)
  begin
    if clk'event and clk = '1' then
        if reset = '1' then
            for i in 0 to (NDSP-1) loop
                macc_a(i) <= (others => '0');
                macc_b(i) <= (others => '0');
            end loop;
        elsif enb = '1' and en = '1' then
            for i in 0 to (NDSP-1) loop
                macc_a(i) <= signed(rxi(i));
                macc_b(i) <= signed(gsi(i));
            end loop;
        end if;
    end if;
  end process;
  
  calc_mult : process(clk)
  begin
    if clk'event and clk = '1' then
        if reset = '1' then
            for i in 0 to (NDSP-1) loop
                macc_m(i) <= (others => '0');
            end loop;
        elsif enb = '1' and en_d1 = '1' then
            for i in 0 to (NDSP-1) loop
                macc_m(i) <= macc_a(i) * macc_b(i);
            end loop;
        end if;
    end if;
  end process;
  
  -- register_c : process(clk)
  -- begin
    -- if clk'event and clk = '1' then
        -- if reset = '1' then
            -- macc_c <= (others => '0');
        -- elsif enb = '1' and en_d1 = '1' then
            -- macc_c <= macc_p;
        -- end if;
    -- end if;
  -- end process;
  
  macc_c <= macc_p;
  
  register_p : process(clk)
  begin
    if clk'event and clk = '1' then
        if reset = '1' then
            for i in 0 to (NDSP-1) loop
                macc_p(i) <= (others => '0');
            end loop;
        elsif enb = '1' and en_d2 = '1' then
            for i in 0 to (NDSP-1) loop
                macc_p(i) <= macc_m(i) + macc_c(i);
            end loop;
        elsif en_d2 = '0' then
            macc_p(i) <= (others => '0');
        end if;
    end if;
  end process;
    
  
  -- macc_c <= macc_p;
  
  
  
  -- test_dsp_slice : rx_gs_mult_dsp
  -- PORT MAP(
    -- clk => clk,
    -- a => macc_a,
    -- b => macc_b,
    -- c => macc_c,
    -- p => macc_p,
    -- cea4 => en_i,
    -- ceb4 => en_i,
    -- cec4 => en_i,
    -- cec5 => '1'
  -- );
  
  
    
  -- test_macc : MACC_MACRO
  -- GENERIC MAP(
    -- DEVICE => "7SERIES",
    -- LATENCY => 3,
    -- WIDTH_A => 16,
    -- WIDTH_B => 16,
    -- WIDTH_P => 32
  -- )
  -- PORT MAP (
    -- clk => clk,
    -- rst => reset,
    -- ce => en_i,
    -- a => macc_a,
    -- b => macc_b,
    -- p => macc_p,
    -- load => en_i,
    -- load_data => macc_load_in,
    -- addsub => '1',
    -- carryin => '0'
  -- );
  
  enable_delay_process : process(clk)
  begin
    if clk'event and clk = '1' then
        if reset = '1' then
            en_dreg <= "000";
        elsif enb = '1' then
            en_dreg <= en_dreg(1 downto 0) & en;
        end if;
    end if;
  end process;
  
  en_d1 <= en_dreg(0);
  en_d2 <= en_dreg(1);
  en_d3 <= en_dreg(2);
  

END rtl;

