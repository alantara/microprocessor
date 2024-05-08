library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

  -- DECLARAR COMPONENTS E SIGNALS AQUI
  
  signal sel_a, sel_b: unsigned(2 downto 0) := "000";
  signal data_wr: unsigned(15 downto 0) := "0000000000000000";
  signal sel_wr: unsigned(2 downto 0) := "000";
  signal wr_en: std_logic := '0';
  signal output_a, output_b: unsigned(15 downto 0); 


  component data_register is
    port(
    sel_a, sel_b: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    sel_wr: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a, output_b: out unsigned(15 downto 0)
  );
  end component;

begin

  -- INSTANCIAR COMPONENTE AQUI

  uut: data_register port map(sel_a=>sel_a, sel_b=>sel_b, data_wr=>data_wr, sel_wr=>sel_wr, clk=>clk, rst=>rst, wr_en=>wr_en, output_a=>output_a, output_b=>output_b);

  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI

    -- registra valores nos registradores
    sel_a<="000"; sel_b<="000"; data_wr<="0010000101101001"; sel_wr<="000"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0010101101101101"; sel_wr<="001"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0010110101101011"; sel_wr<="010"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0011111101111101"; sel_wr<="011"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0110010101101001"; sel_wr<="100"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="1110101101101101"; sel_wr<="101"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0010110111101011"; sel_wr<="110"; wr_en<='1'; wait for period_time;
    sel_a<="000"; sel_b<="000"; data_wr<="0010110101101111"; sel_wr<="111"; wr_en<='1'; wait for period_time;

    -- le os valores de cada registrador
    sel_a<="000"; sel_b<="001"; data_wr<="0000000000000000"; sel_wr<="000"; wr_en<='0'; wait for period_time;
    sel_a<="010"; sel_b<="011"; data_wr<="0000000000000000"; sel_wr<="000"; wr_en<='0'; wait for period_time;
    sel_a<="100"; sel_b<="101"; data_wr<="0000000000000000"; sel_wr<="000"; wr_en<='0'; wait for period_time;
    sel_a<="110"; sel_b<="111"; data_wr<="0000000000000000"; sel_wr<="000"; wr_en<='0'; wait for period_time;

    wait;
  end process;


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

  rst_proc: process
  begin
    rst<='1';
    wait for period_time;
    rst<='0';
    wait;
  end process;
end architecture;
