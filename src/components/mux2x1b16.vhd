library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1b16 is
  port(
  m0, m1: in unsigned(15 downto 0);
  sel: in std_logic;
  output: out unsigned(15 downto 0)
);
end entity;

architecture a_mux2x1b16 of mux2x1b16 is
begin
  output <= m0 when sel='0' else
            m1 when sel='1' else
            "0000000000000000";
end architecture;
