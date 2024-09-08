LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY regb16 IS
  PORT (
    clk, rst, wr_en : IN STD_LOGIC;
    data_in : IN unsigned(15 DOWNTO 0);
    data_out : OUT unsigned(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_regb16 OF regb16 IS
  SIGNAL data : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
  PROCESS (clk, rst, wr_en)
  BEGIN

    IF rst = '1' THEN
      data <= "0000000000000000";
    ELSIF wr_en = '1' THEN
      IF rising_edge(clk) THEN
        data <= data_in;
      END IF;
    END IF;

  END PROCESS;

  data_out <= data;
END ARCHITECTURE;