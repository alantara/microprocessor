LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY regb1 IS
  PORT (
    clk, rst, wr_en : IN STD_LOGIC;
    data_in : IN STD_LOGIC;
    data_out : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE a_regb1 OF regb1 IS
  SIGNAL data : STD_LOGIC := '0';

BEGIN
  PROCESS (clk, rst, wr_en)
  BEGIN

    IF rst = '1' THEN
      data <= '0';
    ELSIF wr_en = '1' THEN
      IF rising_edge(clk) THEN
        data <= data_in;
      END IF;
    END IF;

  END PROCESS;

  data_out <= data;
END ARCHITECTURE;