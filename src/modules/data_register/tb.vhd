library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

  -- DECLARAR COMPONENTS E SIGNALS AQUI
  
  signal rs1, rs2: unsigned(2 downto 0) := "000";
  signal data_wr: unsigned(15 downto 0) := "0000000000000000";
  signal rd: unsigned(2 downto 0) := "000";
  signal wr_en: std_logic := '0';
  signal output_a, output_b: unsigned(15 downto 0); 


  component data_register is
    port(
    rs1, rs2: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    rd: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a, output_b: out unsigned(15 downto 0)
  );
  end component;

begin

  -- INSTANCIAR COMPONENTE AQUI

  uut: data_register port map(rs1, rs2, data_wr, rd, clk, rst, wr_en, output_a, output_b);

  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI

    -- registra valores nos registradores
    rs1<="000"; rs2<="000"; data_wr<="0010000101101001"; rd<="000"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0010101101101101"; rd<="001"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0010110101101011"; rd<="010"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0011111101111101"; rd<="011"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0110010101101001"; rd<="100"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="1110101101101101"; rd<="101"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0010110111101011"; rd<="110"; wr_en<='1'; wait for period_time;
    rs1<="000"; rs2<="000"; data_wr<="0010110101101111"; rd<="111"; wr_en<='1'; wait for period_time;

    -- le os valores de cada registrador
    rs1<="000"; rs2<="001"; data_wr<="0000000000000000"; rd<="000"; wr_en<='0'; wait for period_time;
    rs1<="010"; rs2<="011"; data_wr<="0000000000000000"; rd<="000"; wr_en<='0'; wait for period_time;
    rs1<="100"; rs2<="101"; data_wr<="0000000000000000"; rd<="000"; wr_en<='0'; wait for period_time;
    rs1<="110"; rs2<="111"; data_wr<="0000000000000000"; rd<="000"; wr_en<='0'; wait for period_time;

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
