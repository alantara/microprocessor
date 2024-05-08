library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
  port(wr_en, clk, rst : in std_logic;
      data_in, data_out : out unsigned(7 downto 0));
end;

architecture arq of pc is

signal data : unsigned(7 downto 0) := "00000000";
signal data_p1 : unsigned(7 downto 0) := "00000001";

begin
  process (clk, wr_en)
  begin
    if (rst = '1') then
      data <= "00000000";
    elsif (wr_en = '1' and rising_edge(clk)) then
      data_out <= data_in;
    end if;
  end process;

end architecture;
