library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
  end entity;

architecture a_tb of tb is

  component microprocessor is
    port(
    clk, rst: in std_logic;
    deb_ula: out unsigned(15 downto 0)
  );  
  end component;


  signal reg_sel_a, reg_sel_b,reg_sel_wr, ula_sel: unsigned(2 downto 0) :="000";
  signal sel_imm, wr_en, ula_zero: std_logic := '0';
  signal immediate, deb_ula: unsigned(15 downto 0) := "0000000000000000";

  signal clk, rst: std_logic := '0';

  constant period_time: time := 100 ns;
  signal finished: std_logic := '0';
begin

  uut: microprocessor port map(
                                clk=>clk,
                                rst=>rst,
                                deb_ula=>deb_ula
                              );

  sim_time_proc: process
  begin
    wait for 5 us;
    finished <= '1';
    wait;
  end process;

  clk_proc: process
  begin
    while finished /= '1' loop
      clk <= '0';
      wait for period_time/2;
      clk <= '1';
      wait for period_time/2;
    end loop;
    wait;
  end process;

  process
  begin
    wait;
  end process;
end architecture;
