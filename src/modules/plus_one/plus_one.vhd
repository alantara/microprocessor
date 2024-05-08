library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity plus_one is
  port(
  data_in: in unsigned(15 downto 0);
  data_out: out unsigned(15 downto 0)
);
end entity;

architecture a_plus_one of plus_one is

begin
  data_out <= data_in + 1;
end architecture;
