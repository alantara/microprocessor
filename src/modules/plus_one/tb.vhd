library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  constant period_time: time := 100 ns;

  signal data_in: unsigned(7 downto 0) := "00000000";
  signal data_out: unsigned(7 downto 0) := "00000000";

  component plus_one is
    port(
          data_in: in unsigned(7 downto 0);
          data_out: out unsigned(7 downto 0)
        );
  end component;

begin

  uut: plus_one port map(data_in, data_out);

  process
  begin
    data_in<="00000000"; wait for period_time;
    data_in<="00000001"; wait for period_time;
    data_in<="00101010"; wait for period_time;
    data_in<="11111111"; wait for period_time;

    wait;
  end process;
end architecture;
