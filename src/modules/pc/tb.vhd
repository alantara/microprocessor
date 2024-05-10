library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

-- DECLARAR COMPONENTS E SIGNALS AQUI

  signal wr_en : std_logic := '0';
  signal data_in : unsigned(5 downto 0) := "000000";
  signal data_out : unsigned(5 downto 0);
  

  component pc is 
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in unsigned(5 downto 0);
    data_out: out unsigned(5 downto 0)
  );
  end component;


begin

  -- INSTANCIAR COMPONENTE AQUI

  uut: pc port map(clk, rst, wr_en, data_in, data_out);


  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI
    wr_en<='1'; data_in<="000000"; wait for period_time;
    wr_en<='1'; data_in<="000001"; wait for period_time;
    wr_en<='1'; data_in<="000010"; wait for period_time;
    wr_en<='1'; data_in<="000011"; wait for period_time;
    wr_en<='1'; data_in<="000100"; wait for period_time;

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
