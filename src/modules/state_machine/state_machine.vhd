library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is 
  port(clk, rst : in std_logic;
      state : out std_logic);
end;

architecture arq of state_machine is

component tff is 
  port(clk, rst : in std_logic;
      data : out std_logic);
end component;

signal state_tff : std_logic := '0';

begin
  ff : tff port map(clk, rst, data => state_tff);
  state <= state_tff;
end architecture;
