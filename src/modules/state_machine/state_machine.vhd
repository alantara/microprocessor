library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is 
  port(
  clk, rst : in std_logic;
  state : out unsigned(1 downto 0)
);
end entity;

architecture a_state_machine of state_machine is

  signal machine_state: unsigned(1 downto 0) := "00";

begin
  process(clk)
  begin
    if rst='1' then 
      machine_state<="00";
    elsif rising_edge(clk) then
      if machine_state="10" then
        machine_state<="00";
      else
        machine_state<=machine_state+1;
      end if;
    end if;
  end process;
  state<=machine_state;
end architecture;
