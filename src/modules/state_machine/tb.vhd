LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS END;

ARCHITECTURE arq OF tb IS
  SIGNAL clk, rst : STD_LOGIC := '0';
  CONSTANT period_time : TIME := 100 ns;
  SIGNAL finished : STD_LOGIC := '0';

  -- DECLARE COMPONENTS AND SIGNALS HERE

  SIGNAL state : unsigned(1 DOWNTO 0) := "00";

  COMPONENT state_machine IS
    PORT (
      clk, rst : IN STD_LOGIC;
      state : OUT unsigned(1 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  -- COMPONENT HERE
  sm : state_machine PORT MAP(clk, rst, state);

  PROCESS
  BEGIN
    rst <= '1';
    WAIT FOR period_time;
    rst <= '0';

    -- TEST CASES HERE

    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    rst <= '1';
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    rst <= '0';
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    rst <= '1';
    WAIT FOR period_time;
    WAIT FOR period_time;
    WAIT FOR period_time;
    rst <= '0';

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