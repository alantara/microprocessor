LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY regb6 IS
  PORT (
    clk, rst, wr_en : IN STD_LOGIC;
    data_in : IN unsigned(5 DOWNTO 0);
    data_out : OUT unsigned(5 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_regb6 OF regb6 IS

  SIGNAL data : unsigned(5 DOWNTO 0) := "000000";

BEGIN
  PROCESS (clk, wr_en)
  BEGIN
    IF (rst = '1') THEN
      data <= "000000";
    ELSIF (wr_en = '1' AND rising_edge(clk)) THEN
      data <= data_in;
    END IF;
  END PROCESS;

  data_out <= data;
END ARCHITECTURE;