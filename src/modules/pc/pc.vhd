library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
  port(
  clk, rst, wr_en: in std_logic;
  data_in: in unsigned(5 downto 0);
  data_out: out unsigned(5 downto 0)
);
end entity;

architecture arq of pc is

signal data : unsigned(5 downto 0) := "000000";

begin
  process (clk, wr_en)
  begin
    if (rst = '1') then
      data <= "000000";
    elsif (wr_en = '1' and rising_edge(clk)) then
      data <= data_in;
    end if;
  end process;

  data_out<= data;
end architecture;
