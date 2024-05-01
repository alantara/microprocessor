library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
  end entity;

architecture a_tb of tb is

  component microprocessor is
    port(
    reg_sel_a, reg_sel_b, reg_sel_wr: in unsigned(2 downto 0);
    ula_sel: in unsigned(2 downto 0);
    sel_imm: in std_logic;
    immediate: in unsigned(15 downto 0);
    clk, rst, wr_en: in std_logic;
    ula_zero: out std_logic;
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
                                reg_sel_a=>reg_sel_a,
                                reg_sel_b=>reg_sel_b,
                                reg_sel_wr=>reg_sel_wr,
                                ula_sel=>ula_sel,
                                sel_imm=>sel_imm,
                                immediate=>immediate,
                                clk=>clk,
                                rst=>rst,
                                wr_en=>wr_en,
                                ula_zero=>ula_zero,
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
    rst<='1'; wait for period_time;
    rst<='0'; wait for period_time;

    --addi r1, zero, 0x1001
    reg_sel_a<="000"; sel_imm<='1'; immediate <= "0001000000000001"; ula_sel<="000"; wait for period_time;

    reg_sel_wr<="001"; wr_en<='1'; wait for period_time;
    sel_imm<='0'; wr_en<='0';
    
    --add r3, zero, 0x10A1
    reg_sel_a<="000"; sel_imm<='1'; immediate <= "0001000010100001"; ula_sel<="000"; wait for period_time;

    reg_sel_wr<="011"; wr_en<='1'; wait for period_time;
    sel_imm<='0'; wr_en<='0';

    --add r4, r1, r2
    reg_sel_a<="001"; reg_sel_b<="011"; ula_sel<="000"; wait for period_time;

    reg_sel_wr<="100"; wr_en<='1'; wait for period_time;
    wr_en<='0';

    --See sum, or, not
    reg_sel_a<="001"; reg_sel_b<="011"; ula_sel<="000"; wait for period_time;
    reg_sel_a<="001"; reg_sel_b<="011"; ula_sel<="010"; wait for period_time;
    reg_sel_a<="001"; reg_sel_b<="011"; ula_sel<="100"; wait for period_time;

    reg_sel_a<="100"; reg_sel_b<="011"; ula_sel<="000"; wait for period_time;
    reg_sel_a<="001"; reg_sel_b<="011"; ula_sel<="001"; wait for period_time;
    reg_sel_a<="100"; reg_sel_b<="100"; ula_sel<="001"; wait for period_time;
    wait;
  end process;
end architecture;
