library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tff is 
  port(
  clk, rst : in std_logic;
  data : out std_logic
);
end entity;

architecture a_tff of tff is

signal state : std_logic := '0';

begin
  process (rst, clk)
  begin
    if (rst = '1') then
      state <= '0';
    elsif rising_edge(clk) then
      state <= not state;
    end if;
  end process;

  data <= state;

end architecture;
