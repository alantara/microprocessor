library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

  component control_unit is 
    port(instr : in unsigned(31 downto 0);
    clk, rst : in std_logic;
    is_jmp : out std_logic);
  end component;

  signal instr : unsigned(31 downto 0) := "00000000000000000000000000000000";
  signal is_jmp : std_logic := '0';

begin

  cu : control_unit port map (instr, clk, rst, is_jmp);

  process
  begin
    wait for period_time;

    instr <= "00000000000000000000000000000000";
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    instr <= "00000000000000000000000000001111"; -- opcode for JUMP
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    instr <= "00001110000000000000000000001011";
    wait for period_time;
    wait for period_time;
    wait for period_time;
    instr <= "00000000000000000000000000001111"; -- opcode for JUMP
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
    wait for period_time;
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
