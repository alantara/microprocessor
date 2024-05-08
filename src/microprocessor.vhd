library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor is
  port(
  reg_sel_a, reg_sel_b, reg_sel_wr: in unsigned(2 downto 0);
  ula_sel: in unsigned(2 downto 0);
  sel_imm: in std_logic;
  immediate: in unsigned(15 downto 0);
  clk, rst, wr_en: in std_logic;
  ula_zero: out std_logic;
  deb_ula: out unsigned(15 downto 0)
);  
end entity;

architecture arq of microprocessor is

  component data_register is
    port(
    sel_a, sel_b: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    sel_wr: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a, output_b: out unsigned(15 downto 0) 
  );
  end component;

  component ula is
    port(
    a, b: in unsigned(15 downto 0);
    opcode: in unsigned(2 downto 0);
    zero: out std_logic;
    output: out unsigned(15 downto 0)
  );
  end component;

  signal output_ula, output_reg_a, output_reg_b, output_mux_ula: unsigned(15 downto 0);

begin

  data_reg: data_register port map(
                              sel_a=>reg_sel_a,
                              sel_b=>reg_sel_b,
                              data_wr=>output_ula,
                              sel_wr=>reg_sel_wr,
                              clk=>clk,
                              rst=>rst,
                              wr_en=>wr_en,
                              output_a=>output_reg_a,
                              output_b=>output_reg_b
                            );

  ula2: ula port map(
                     a=>output_reg_a,
                     b=>output_mux_ula,
                     opcode=>ula_sel,
                     zero=>ula_zero,
                     output=>output_ula
                   );

  output_mux_ula <= output_reg_b when sel_imm = '0' else
                    immediate when sel_imm = '1' else
                    output_reg_b;

  deb_ula <= output_ula;
end architecture;
