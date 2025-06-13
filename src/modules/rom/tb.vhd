LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS END;

ARCHITECTURE arq OF tb IS
  SIGNAL clk, rst : STD_LOGIC := '0';
  CONSTANT period_time : TIME := 100 ns;
  SIGNAL finished : STD_LOGIC := '0';

  -- DECLARE COMPONENTS AND SIGNALS HERE
  COMPONENT rom IS
    PORT (
      clk : IN STD_LOGIC;
      address : IN unsigned(5 DOWNTO 0);
      data : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL address : unsigned(5 DOWNTO 0) := "000000";
  SIGNAL data : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

  -- COMPONENT HERE
  mem : rom PORT MAP(clk, address, data);

  PROCESS
  BEGIN
    WAIT FOR period_time;

    -- TEST CASES HERE
    address <= "000000";
    WAIT FOR period_time;
    address <= "000001";
    WAIT FOR period_time;
    address <= "000010";
    WAIT FOR period_time;
    address <= "000011";
    WAIT FOR period_time;
    address <= "000100";
    WAIT FOR period_time;
    address <= "000101";
    WAIT FOR period_time;
    address <= "000110";
    WAIT FOR period_time;
    address <= "010100";
    WAIT FOR period_time;
    address <= "010101";
    WAIT FOR period_time;
    address <= "010110";
    WAIT FOR period_time;
    address <= "001010";
    WAIT FOR period_time;

    WAIT;
  END PROCESS;
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

  rst_proc : PROCESS
  BEGIN
    rst <= '1';
    WAIT FOR period_time;
    rst <= '0';
    WAIT;
  END PROCESS;
END ARCHITECTURE;