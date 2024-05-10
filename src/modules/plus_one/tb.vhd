library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  constant period_time: time := 100 ns;

  signal data_in: unsigned(5 downto 0) := "000000";
  signal data_out: unsigned(5 downto 0) := "000000";

  component plus_one is
    port(
          data_in: in unsigned(5 downto 0);
          data_out: out unsigned(5 downto 0)
        );
  end component;

begin

  uut: plus_one port map(data_in, data_out);

  process
  begin
    data_in<="000000"; wait for period_time;
    data_in<="000001"; wait for period_time;
    data_in<="101010"; wait for period_time;
    data_in<="111111"; wait for period_time;

    wait;
  end process;
end architecture;
