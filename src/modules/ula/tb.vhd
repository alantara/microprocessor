library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

-- DECLARAR COMPONENTS E SIGNALS AQUI

  
  signal a, b: unsigned(15 downto 0) := "0000000000000000";
  signal opcode: unsigned(2 downto 0) := "000";
  signal zero: std_logic;
  signal output: unsigned(15 downto 0);

  component ula is
    port(
    a, b: in unsigned(15 downto 0);
    opcode: in unsigned(2 downto 0);
    zero: out std_logic;
    output: out unsigned(15 downto 0)
  );
  end component;


begin

  -- INSTANCIAR COMPONENTE AQUI

  uut: ula port map(a=>a, b=>b, opcode=>opcode, zero=>zero, output=>output);


  process
  begin
    wait for period_time;

    -- COLOCAR CASOS DE TESTE AQUI

    a<="0010011000010100"; b<="0000010000001101"; opcode<= "000"; wait for period_time;
    a<="0010000000100000"; b<="0000000000111100"; opcode<= "001"; wait for period_time;
    a<="0000100100100000"; b<="0000110000010001"; opcode<= "010"; wait for period_time;
    a<="0011010110111100"; b<="0011000110000000"; opcode<= "011"; wait for period_time;
    a<="0000001111000110"; b<="1101000001110001"; opcode<= "100"; wait for period_time;
    a<="0111111000010000"; b<="0001001011000000"; opcode<= "101"; wait for period_time;
    a<="0000000110001100"; b<="0001001000010100"; opcode<= "110"; wait for period_time;
    a<="0000000000111100"; b<="0101100000111000"; opcode<= "111"; wait for period_time;

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
