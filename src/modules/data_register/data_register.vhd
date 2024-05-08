library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_register is
  port(
  sel_a, sel_b: in unsigned(2 downto 0);
  data_wr: in unsigned(15 downto 0);
  sel_wr: in unsigned(2 downto 0);
  clk, rst, wr_en: in std_logic;
  output_a, output_b: out unsigned(15 downto 0) 
);
end entity;

architecture arq of data_register is

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    d_in: in unsigned(15 downto 0);
    d_out: out unsigned(15 downto 0)
  );
  end component;

  signal d0, d1, d2, d3, d4, d5, d6, d7: unsigned(15 downto 0);
  signal sel_wr_en1, sel_wr_en2, sel_wr_en3, sel_wr_en4, sel_wr_en5, sel_wr_en6, sel_wr_en7: std_logic;
  signal wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;

begin

  sel_wr_en1<= '1' when sel_wr = "001" else
               '0';
  sel_wr_en2<= '1' when sel_wr = "010" else
               '0';
  sel_wr_en3<= '1' when sel_wr = "011" else
               '0';
  sel_wr_en4<= '1' when sel_wr = "100" else
               '0';
  sel_wr_en5<= '1' when sel_wr = "101" else
               '0';
  sel_wr_en6<= '1' when sel_wr = "110" else
               '0';
  sel_wr_en7<= '1' when sel_wr = "111" else
               '0';
  
  wr_en1<= sel_wr_en1 and wr_en;
  wr_en2<= sel_wr_en2 and wr_en;
  wr_en3<= sel_wr_en3 and wr_en;
  wr_en4<= sel_wr_en4 and wr_en;
  wr_en5<= sel_wr_en5 and wr_en;
  wr_en6<= sel_wr_en6 and wr_en;
  wr_en7<= sel_wr_en7 and wr_en;

  reg0: regb16 port map(clk=>'0', rst=>'1', wr_en=>'0', d_in=>"0000000000000000", d_out=>d0);
  reg1: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en1, d_in=>data_wr, d_out=>d1);
  reg2: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en2, d_in=>data_wr, d_out=>d2);
  reg3: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en3, d_in=>data_wr, d_out=>d3);
  reg4: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en4, d_in=>data_wr, d_out=>d4);
  reg5: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en5, d_in=>data_wr, d_out=>d5);
  reg6: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en6, d_in=>data_wr, d_out=>d6);
  reg7: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en7, d_in=>data_wr, d_out=>d7);
    

  output_a <= d0 when sel_a = "000" else
              d1 when sel_a = "001" else
              d2 when sel_a = "010" else
              d3 when sel_a = "011" else
              d4 when sel_a = "100" else
              d5 when sel_a = "101" else
              d6 when sel_a = "110" else
              d7 when sel_a = "111" else
              "0000000000000000";

  output_b <= d0 when sel_b = "000" else
              d1 when sel_b = "001" else
              d2 when sel_b = "010" else
              d3 when sel_b = "011" else
              d4 when sel_b = "100" else
              d5 when sel_b = "101" else
              d6 when sel_b = "110" else
              d7 when sel_b = "111" else
              "0000000000000000";

end architecture;
