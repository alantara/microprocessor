LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS END;

ARCHITECTURE arq OF tb IS
  SIGNAL clk, rst : STD_LOGIC := '0';
  CONSTANT period_time : TIME := 100 ns;
  SIGNAL finished : STD_LOGIC := '0';

  -- DECLARE COMPONENTS AND SIGNALS HERE
  SIGNAL wr_en : STD_LOGIC := '0';
  SIGNAL data_in : STD_LOGIC := '0';
  SIGNAL data_out : STD_LOGIC := '0';

  COMPONENT regb1 IS
    PORT (
      clk, rst, wr_en : IN STD_LOGIC;
      data_in : IN STD_LOGIC;
      data_out : OUT STD_LOGIC
    );
  END COMPONENT;

BEGIN

  -- COMPONENT HERE
  uut : regb1 PORT MAP(clk, rst, wr_en, data_in, data_out);

  PROCESS
  BEGIN
    rst <= '1';
    WAIT FOR period_time;
    rst <= '0';

    -- TEST CASES HERE
    wr_en <= '1';
    data_in <= '1';
    WAIT FOR period_time;
    wr_en <= '1';
    data_in <= '0';
    WAIT FOR period_time;
    wr_en <= '1';
    data_in <= '1';
    WAIT FOR period_time;

    WAIT;
  END PROCESS;

  --DEFAULT PROCESSES

  sim_time_proc : PROCESS
  BEGIN
    WAIT FOR 5 us;
    finished <= '1';
    WAIT;
  END PROCESS;

  clk_proc : PROCESS
  BEGIN
    WHILE finished /= '1' LOOP
      clk <= '0';
      WAIT FOR period_time/2;
      clk <= '1';
      WAIT FOR period_time/2;
    END LOOP;
    WAIT;
  END PROCESS;
END ARCHITECTURE;