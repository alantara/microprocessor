library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

-- DECLARAR COMPONENTS E SIGNALS AQUI


  component microprocessor is
    port(
    clk, rst: in std_logic
  );  
  end component;

begin

  -- INSTANCIAR COMPONENTE AQUI

  
  uut: microprocessor port map(clk, rst);

  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI


    wait;
  end process;


  sim_time_proc: process
  begin
    wait for 10 us;
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
