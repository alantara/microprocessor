library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1b16 is
  port(
  m0, m1, m2, m3, m4, m5, m6, m7: in unsigned(15 downto 0);
  sel: in unsigned(2 downto 0);
  output: out unsigned(15 downto 0)
);
end entity;

architecture a_mux8x1b16 of mux8x1b16 is
begin
  output <= m0 when sel="000" else
            m1 when sel="001" else
            m2 when sel="010" else
            m3 when sel="011" else
            m4 when sel="100" else
            m5 when sel="101" else
            m6 when sel="110" else
            m7 when sel="111" else
            "0000000000000000";
end architecture;
