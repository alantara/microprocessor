library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_register is
  port(
  rs, rd: in unsigned(2 downto 0);
  data_wr: in unsigned(15 downto 0);
  clk, rst, wr_en: in std_logic;
  output: out unsigned(15 downto 0) 
);
end entity;

architecture arq of data_register is

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in unsigned(15 downto 0);
    data_out: out unsigned(15 downto 0)
  );
  end component;

  signal d0, d1, d2, d3, d4, d5, d6, d7: unsigned(15 downto 0) := "0000000000000000";
  signal sel_wr_en1, sel_wr_en2, sel_wr_en3, sel_wr_en4, sel_wr_en5, sel_wr_en6, sel_wr_en7: std_logic;
  signal wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;

begin

  sel_wr_en1<= '1' when rd = "001" else '0';
  sel_wr_en2<= '1' when rd = "010" else '0';
  sel_wr_en3<= '1' when rd = "011" else '0';
  sel_wr_en4<= '1' when rd = "100" else '0';
  sel_wr_en5<= '1' when rd = "101" else '0';
  sel_wr_en6<= '1' when rd = "110" else '0';
  sel_wr_en7<= '1' when rd = "111" else '0';
  
  wr_en1<= sel_wr_en1 and wr_en;
  wr_en2<= sel_wr_en2 and wr_en;
  wr_en3<= sel_wr_en3 and wr_en;
  wr_en4<= sel_wr_en4 and wr_en;
  wr_en5<= sel_wr_en5 and wr_en;
  wr_en6<= sel_wr_en6 and wr_en;
  wr_en7<= sel_wr_en7 and wr_en;

  reg0: regb16 port map(clk=>'0', rst=>'1', wr_en=>'0',    data_in=>"0000000000000000", data_out=>d0);
  reg1: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en1, data_in=>data_wr,            data_out=>d1);
  reg2: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en2, data_in=>data_wr,            data_out=>d2);
  reg3: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en3, data_in=>data_wr,            data_out=>d3);
  reg4: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en4, data_in=>data_wr,            data_out=>d4);
  reg5: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en5, data_in=>data_wr,            data_out=>d5);
  reg6: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en6, data_in=>data_wr,            data_out=>d6);
  reg7: regb16 port map(clk=>clk, rst=>rst, wr_en=>wr_en7, data_in=>data_wr,            data_out=>d7);
    

  output <= d0 when rs = "000" else
            d1 when rs = "001" else
            d2 when rs= "010" else
            d3 when rs = "011" else
            d4 when rs = "100" else
            d5 when rs = "101" else
            d6 when rs = "110" else
            d7 when rs = "111" else
            "0000000000000000";

end architecture;
