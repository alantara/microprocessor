library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regb1 is
  port(
  clk, rst, wr_en: in std_logic;
  data_in: in std_logic;
  data_out: out std_logic
);
end entity;

architecture a_regb1 of regb1 is
  signal data: std_logic := '0';

begin
  process(clk, rst, wr_en)
  begin

    if rst='1' then
      data<='0';
    elsif wr_en='1' then
      if rising_edge(clk) then
        data<=data_in;
      end if;
    end if;

  end process;

  data_out <= data;
end architecture;
