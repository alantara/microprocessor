library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

  -- DECLARAR COMPONENTS E SIGNALS AQUI


  component rom is
    port( 
          clk: in std_logic;
          address: in unsigned(5 downto 0);
          data: out unsigned(15 downto 0) 
        );
  end component;

  signal address : unsigned(5 downto 0) := "000000";
  signal data : unsigned(15 downto 0) := "0000000000000000";

begin

  -- INSTANCIAR COMPONENTE AQUI


  mem : rom port map (clk, address, data);

  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI


    address <= "000000";
    wait for period_time;
    address <= "000001";
    wait for period_time;
    address <= "000010";
    wait for period_time;
    address <= "000011";
    wait for period_time;
    address <= "000100";
    wait for period_time;
    address <= "000101";
    wait for period_time;
    address <= "000110";
    wait for period_time;
    address <= "010100";
    wait for period_time;
    address <= "010101";
    wait for period_time;
    address <= "010110";
    wait for period_time;
    address <= "001010";
    wait for period_time;

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
