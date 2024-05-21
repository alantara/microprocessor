library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regb16 is
  port(
  clk, rst, wr_en: in std_logic;
  data_in: in unsigned(15 downto 0);
  data_out: out unsigned(15 downto 0)
);
end entity;

architecture a_regb16 of regb16 is
  signal data: unsigned(15 downto 0) := "0000000000000000";

begin
  process(clk, rst, wr_en)
  begin

    if rst='1' then
      data<="0000000000000000";
    elsif wr_en='1' then
      if rising_edge(clk) then
        data<=data_in;
      end if;
    end if;

  end process;

  data_out <= data;
end architecture;
