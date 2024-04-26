library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux8x1b1 is
  port(
  sel: in unsigned(2 downto 0);
  output0, output1, output2, output3, output4, output5, output6, output7: out std_logic
);
end entity;

architecture a_demux8x1b1 of demux8x1b1 is
begin
  output0 <= '1' when sel="000" else
             '0';
  output1 <= '1' when sel="001" else
             '0';
  output2 <= '1' when sel="010" else
             '0';
  output3 <= '1' when sel="011" else
             '0';
  output4 <= '1' when sel="100" else
             '0';
  output5 <= '1' when sel="101" else
             '0';
  output6 <= '1' when sel="110" else
             '0';
  output7 <= '1' when sel="111" else
             '0';
end architecture;
