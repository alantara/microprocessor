library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;


architecture arq of tb is
  signal clk, rst: std_logic := '0';
  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';

  component rom is
    port( clk      : in std_logic;
          address : in unsigned(7 downto 0);
          data     : out unsigned(31 downto 0) 
        );
  end component;

  signal address : unsigned(7 downto 0) := "00000000";
  signal data : unsigned(31 downto 0) := "00000000000000000000000000000000";

begin
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

  mem : rom port map (clk => clk, address => address, data => data);

  process
  begin

    address <= "00000000";
    wait for period_time;
    address <= "00000001";
    wait for period_time;
    address <= "00000010";
    wait for period_time;
    address <= "00000011";
    wait for period_time;
    address <= "00000100";
    wait for period_time;
    address <= "00000101";
    wait for period_time;
    address <= "00000110";
    wait for period_time;
    address <= "00000111";
    wait for period_time;
    address <= "00001000";
    wait for period_time;
    address <= "00001001";
    wait for period_time;
    address <= "00001010";
    wait for period_time;

    wait;
  end process;

end architecture;
