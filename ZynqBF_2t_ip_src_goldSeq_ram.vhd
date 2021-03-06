-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_gold_sequences.vhd
-- Created: 2019-02-08 23:33:51
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_goldSeq1
-- Source Path: ZynqBF_2tx_fpga/channel_estimator/peakdetect_ch1/correlator1/gold_sequences
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ZynqBF_2t_ip_src_ZynqBF_2tx_fpga_pkg.ALL;

ENTITY ZynqBF_2t_ip_src_goldSeq_ram IS
  GENERIC(
        CHANNEL                           :   integer := 1      -- number of gold sequences to use
        );
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        addr                              :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        dout                              :   OUT   vector_of_std_logic_vector16(0 to 63)
        );
END ZynqBF_2t_ip_src_goldSeq_ram;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_goldSeq_ram IS

    component gsram1
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram2
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram3
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram4
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram5
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram6
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram7
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;
    
    component gsram8
    port(
        clka:           in std_logic;
        wea:            in std_logic_vector(0 downto 0);
        addra:          in std_logic_vector(5 downto 0);
        dina:           in std_logic_vector(1023 downto 0);
        douta:          out std_logic_vector(1023 downto 0)
    );
    end component;

    signal we:          std_logic_vector(0 downto 0);
    signal dout_i:      std_logic_vector(1023 downto 0);
        
BEGIN
  
    we(0) <= '0';
    
    gen_gs1: if CHANNEL = 1 generate
        u_gsram1: gsram1
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs2: if CHANNEL = 2 generate
        u_gsram1: gsram2
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs3: if CHANNEL = 3 generate
        u_gsram1: gsram3
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs4: if CHANNEL = 4 generate
        u_gsram1: gsram4
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs5: if CHANNEL = 5 generate
        u_gsram1: gsram5
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs6: if CHANNEL = 6 generate
        u_gsram1: gsram6
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs7: if CHANNEL = 7 generate
        u_gsram1: gsram7
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    gen_gs8: if CHANNEL = 8 generate
        u_gsram1: gsram8
        port map(
            clka => clk,
            wea => we,
            addra => addr,
            dina => (others => '0'),
            douta => dout_i
        );
    end generate;
    
    register_outputs: process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                dout <= (others => (others => '0'));
            elsif enb = '1' then
                for i in 0 to 63 loop
                    dout(i) <= dout_i((16*i+15) downto (16*i));
                end loop;
            end if;
        end if;
    end process;


END rtl;

