LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_register IS
  PORT (
    rs1, rs2, rd : IN unsigned(2 DOWNTO 0);
    data_wr : IN unsigned(15 DOWNTO 0);
    clk, rst, wr_en : IN STD_LOGIC;
    output1, output2 : OUT unsigned(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_data_register OF data_register IS

  COMPONENT regb16 IS
    PORT (
      clk, rst, wr_en : IN STD_LOGIC;
      data_in : IN unsigned(15 DOWNTO 0);
      data_out : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL d0, d1, d2, d3, d4, d5, d6, d7 : unsigned(15 DOWNTO 0) := "0000000000000000";
  SIGNAL wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7 : STD_LOGIC := '0';

BEGIN

  wr_en1 <= '1' WHEN rd = "001" AND wr_en = '1' ELSE
    '0';
  wr_en2 <= '1' WHEN rd = "010" AND wr_en = '1' ELSE
    '0';
  wr_en3 <= '1' WHEN rd = "011" AND wr_en = '1' ELSE
    '0';
  wr_en4 <= '1' WHEN rd = "100" AND wr_en = '1' ELSE
    '0';
  wr_en5 <= '1' WHEN rd = "101" AND wr_en = '1' ELSE
    '0';
  wr_en6 <= '1' WHEN rd = "110" AND wr_en = '1' ELSE
    '0';
  wr_en7 <= '1' WHEN rd = "111" AND wr_en = '1' ELSE
    '0';

  reg0 : regb16 PORT MAP(clk => '0', rst => '1', wr_en => '0', data_in => "0000000000000000", data_out => d0);
  reg1 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en1, data_in => data_wr, data_out => d1);
  reg2 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en2, data_in => data_wr, data_out => d2);
  reg3 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en3, data_in => data_wr, data_out => d3);
  reg4 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en4, data_in => data_wr, data_out => d4);
  reg5 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en5, data_in => data_wr, data_out => d5);
  reg6 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en6, data_in => data_wr, data_out => d6);
  reg7 : regb16 PORT MAP(clk => clk, rst => rst, wr_en => wr_en7, data_in => data_wr, data_out => d7);

  output1 <= d0 WHEN rs1 = "000" ELSE
    d1 WHEN rs1 = "001" ELSE
    d2 WHEN rs1 = "010" ELSE
    d3 WHEN rs1 = "011" ELSE
    d4 WHEN rs1 = "100" ELSE
    d5 WHEN rs1 = "101" ELSE
    d6 WHEN rs1 = "110" ELSE
    d7 WHEN rs1 = "111" ELSE
    "0000000000000000";

  output2 <= d0 WHEN rs2 = "000" ELSE
    d1 WHEN rs2 = "001" ELSE
    d2 WHEN rs2 = "010" ELSE
    d3 WHEN rs2 = "011" ELSE
    d4 WHEN rs2 = "100" ELSE
    d5 WHEN rs2 = "101" ELSE
    d6 WHEN rs2 = "110" ELSE
    d7 WHEN rs2 = "111" ELSE
    "0000000000000000";

END ARCHITECTURE;