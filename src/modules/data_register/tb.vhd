LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS END;

ARCHITECTURE arq OF tb IS
  SIGNAL clk, rst : STD_LOGIC := '0';
  CONSTANT period_time : TIME := 100 ns;
  SIGNAL finished : STD_LOGIC := '0';

  -- DECLARE COMPONENTS AND SIGNALS HERE
  SIGNAL rs, rd : unsigned(2 DOWNTO 0) := "000";
  SIGNAL data_wr : unsigned(15 DOWNTO 0) := "0000000000000000";
  SIGNAL wr_en : STD_LOGIC := '0';
  SIGNAL output : unsigned(15 DOWNTO 0);

  COMPONENT data_register IS
    PORT (
      rs, rd : IN unsigned(2 DOWNTO 0);
      data_wr : IN unsigned(15 DOWNTO 0);
      clk, rst, wr_en : IN STD_LOGIC;
      output : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  -- COMPONENT HERE

  uut : data_register PORT MAP(rs, rd, data_wr, clk, rst, wr_en, output);

  PROCESS
  BEGIN
    rst <= '1';
    WAIT FOR period_time;
    rst <= '0';

    -- TEST CASES HERE

    -- registra valores nos registradores
    wr_en <= '1';

    data_wr <= "0010000101101001";
    rd <= "000";
    WAIT FOR period_time;
    data_wr <= "0010100101101001";
    rd <= "001";
    WAIT FOR period_time;
    data_wr <= "0010010101101001";
    rd <= "010";
    WAIT FOR period_time;
    data_wr <= "0000000101001001";
    rd <= "011";
    WAIT FOR period_time;
    data_wr <= "0000000101101011";
    rd <= "100";
    WAIT FOR period_time;
    data_wr <= "0010000100000000";
    rd <= "101";
    WAIT FOR period_time;
    data_wr <= "0011100101101001";
    rd <= "110";
    WAIT FOR period_time;
    data_wr <= "0011111101101001";
    rd <= "111";
    WAIT FOR period_time;

    -- le os valores de cada registrador
    wr_en <= '0';

    rs <= "000";
    WAIT FOR period_time;
    rs <= "001";
    WAIT FOR period_time;
    rs <= "010";
    WAIT FOR period_time;
    rs <= "011";
    WAIT FOR period_time;
    rs <= "100";
    WAIT FOR period_time;
    rs <= "101";
    WAIT FOR period_time;
    rs <= "110";
    WAIT FOR period_time;
    rs <= "111";
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