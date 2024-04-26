library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
  end entity;

architecture a_tb of tb is

  component DATAREGISTER is
    port(
    sel_a, sel_b: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    sel_wr: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a, output_b: out unsigned(15 downto 0) 
  );
  end component;

  signal sel_a, sel_b: unsigned(2 downto 0) := "000";
  signal data_wr: unsigned(15 downto 0) := "0000000000000000";
  signal sel_wr: unsigned(2 downto 0) := "000";
  signal output_a, output_b: unsigned(15 downto 0);

  signal clk, rst, wr_en: std_logic := '0';

  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';
begin

  uut: DATAREGISTER port map(
                              sel_a=>sel_a,
                              sel_b=>sel_b,
                              data_wr=>data_wr,
                              sel_wr=>sel_wr,
                              clk=>clk,
                              rst=>rst,
                              wr_en=>wr_en,
                              output_a=>output_a,
                              output_b=>output_b
                            );

  sim_time_proc: process
  begin
    wait for 5 us;
    finished <= '1';
    wait;
  end process;

  clk_proc: process
  begin
    while finished /= '1' loop
      clk <= '0';
      wait for period_time/2;
      clk <= '1';
      wait for period_time/2;
    end loop;
    wait;
  end process;

  process
  begin
    rst<='1'; wait for period_time;
    rst<='0'; wait for period_time;
    
    sel_wr<="001"; data_wr<="0000000000000001"; wr_en<='1'; wait for period_time;
    sel_wr<="010"; data_wr<="0000000000000010"; wr_en<='1'; wait for period_time;
    sel_wr<="011"; data_wr<="0000000000000011"; wr_en<='1'; wait for period_time;
    sel_wr<="100"; data_wr<="0000000000000100"; wr_en<='1'; wait for period_time;
    sel_wr<="101"; data_wr<="0000000000000101"; wr_en<='1'; wait for period_time;
    sel_wr<="110"; data_wr<="0000000000000110"; wr_en<='1'; wait for period_time;
    sel_wr<="111"; data_wr<="0000000000000111"; wr_en<='0'; wait for period_time;

    wr_en <= '0'; wait for period_time;

    sel_a<="000"; sel_b<="111"; data_wr<="0000000000000001"; wait for period_time;
    sel_a<="001"; sel_b<="110"; data_wr<="0000000000000001"; wait for period_time;
    sel_a<="010"; sel_b<="101"; data_wr<="0000000000000010"; wait for period_time;
    sel_a<="011"; sel_b<="100"; data_wr<="0000000000000011"; wait for period_time;
    sel_a<="100"; sel_b<="011"; data_wr<="0000000000000100"; wait for period_time;
    sel_a<="101"; sel_b<="010"; data_wr<="0000000000000101"; wait for period_time;
    sel_a<="110"; sel_b<="001"; data_wr<="0000000000000110"; wait for period_time;
    sel_a<="111"; sel_b<="000"; data_wr<="0000000000000111"; wait for period_time;
   
    sel_wr<="111"; data_wr<="0000000000000111"; wr_en<='1'; wait for period_time;
    sel_a<="111"; data_wr<="0000000000000111"; wait for period_time;

    wait;
  end process;
end architecture;
