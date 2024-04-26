library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DATAREGISTER is
  port(
  sel_a, sel_b: in unsigned(2 downto 0);
  data_wr: in unsigned(15 downto 0);
  sel_wr: in unsigned(2 downto 0);
  clk, rst, wr_en: in std_logic;
  output_a, output_b: out unsigned(15 downto 0) 
);
end entity;

architecture a_DATAREGISTER of DATAREGISTER is

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    d_in: in unsigned(15 downto 0);
    d_out: out unsigned(15 downto 0)
  );
  end component;

  component mux8x1b16 is
    port(
    m0, m1, m2, m3, m4, m5, m6, m7: in unsigned(15 downto 0);
    sel: in unsigned(2 downto 0);
    output: out unsigned(15 downto 0)
  );
  end component;

  component demux8x1b1 is
    port(
          sel: in unsigned(2 downto 0);
    output0, output1, output2, output3, output4, output5, output6, output7: out std_logic
  );
  end component;

  signal d0, d1, d2, d3, d4, d5, d6, d7: unsigned(15 downto 0);
  signal wr_sel1, wr_sel2, wr_sel3, wr_sel4, wr_sel5, wr_sel6, wr_sel7: std_logic;
  signal wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;

begin

  reg0: regb16 port map(
                      clk=>'0',
                      rst=>'1',
                      wr_en=>'0',
                      d_in=>"0000000000000000",
                      d_out=>d0
                    );

  reg1: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en1,
                      d_in=>data_wr,
                      d_out=>d1
                    );
  
  reg2: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en2,
                      d_in=>data_wr,
                      d_out=>d2
                    );

  reg3: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en3,
                      d_in=>data_wr,
                      d_out=>d3
                    );

  reg4: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en4,
                      d_in=>data_wr,
                      d_out=>d4
                    );

  reg5: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en5,
                      d_in=>data_wr,
                      d_out=>d5
                    );

  reg6: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en6,
                      d_in=>data_wr,
                      d_out=>d6
                    );

  reg7: regb16 port map(
                      clk=>clk,
                      rst=>rst,
                      wr_en=>wr_en7,
                      d_in=>data_wr,
                      d_out=>d7
                    );

  wr_demux: demux8x1b1 port map(
                                 sel=>sel_wr,
                                 output1=>wr_sel1,
                                 output2=>wr_sel2,
                                 output3=>wr_sel3,
                                 output4=>wr_sel4,
                                 output5=>wr_sel5,
                                 output6=>wr_sel6,
                                 output7=>wr_sel7
                               );
  
  wr_en1<=wr_sel1 and wr_en;
  wr_en2<=wr_sel2 and wr_en;
  wr_en3<=wr_sel3 and wr_en;
  wr_en4<=wr_sel4 and wr_en;
  wr_en5<=wr_sel5 and wr_en;
  wr_en6<=wr_sel6 and wr_en;
  wr_en7<=wr_sel7 and wr_en;

  out_mux1: mux8x1b16 port map(
                                m0=>d0,
                                m1=>d1,
                                m2=>d2,
                                m3=>d3,
                                m4=>d4,
                                m5=>d5,
                                m6=>d6,
                                m7=>d7,
                                sel=>sel_a,
                                output=>output_a
                              );

  out_mux2: mux8x1b16 port map(
                                m0=>d0,
                                m1=>d1,
                                m2=>d2,
                                m3=>d3,
                                m4=>d4,
                                m5=>d5,
                                m6=>d6,
                                m7=>d7,
                                sel=>sel_b,
                                output=>output_b
                              );

end architecture;
