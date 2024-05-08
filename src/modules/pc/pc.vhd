library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
  port(
  clk, rst, wr_en : in std_logic;
  data_in, data_out : out unsigned(7 downto 0)
);
end;

architecture arq of pc is

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    d_in: in unsigned(15 downto 0);
    d_out: out unsigned(15 downto 0)
  );
  end component;

begin

  reg: regb16 port map(clk, rst, wr_en, d_in=> data_in, d_out=>data_out);

end architecture;
