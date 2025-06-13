LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS END;

ARCHITECTURE arq OF tb IS
  SIGNAL clk, rst : STD_LOGIC := '0';
  CONSTANT period_time : TIME := 100 ns;
  SIGNAL finished : STD_LOGIC := '0';

  -- DECLARE COMPONENTS AND SIGNALS HERE

  SIGNAL a, b : unsigned(15 DOWNTO 0) := "0000000000000000";
  SIGNAL borrow : STD_LOGIC := '0';
  SIGNAL opcode : unsigned(1 DOWNTO 0) := "00";
  SIGNAL carry_flag, zero_flag, greater_flag : STD_LOGIC := '0';
  SIGNAL output : unsigned (15 DOWNTO 0) := "0000000000000000";

  COMPONENT ula IS
    PORT (
      a, b : IN unsigned(15 DOWNTO 0);
      borrow : IN STD_LOGIC;
      opcode : IN unsigned(1 DOWNTO 0);
      zero_flag, carry_flag, greater_flag : OUT STD_LOGIC;
      output : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  -- COMPONENT HERE

  uut : ula PORT MAP(a, b, borrow, opcode, carry_flag, zero_flag, greater_flag, output);

  PROCESS
  BEGIN
    rst <= '1';
    WAIT FOR period_time;
    rst <= '0';

    -- TEST CASES HERE

    a <= "0000000000000001";
    b <= "0000000000000001";
    borrow <= '0';
    opcode <= "00";
    WAIT FOR period_time;
    a <= "0000000000000001";
    b <= "0000000000010001";
    borrow <= '1';
    opcode <= "00";
    WAIT FOR period_time;
    a <= "0000000000000001";
    b <= "0000000000000001";
    borrow <= '0';
    opcode <= "01";
    WAIT FOR period_time;
    a <= "0000000000000001";
    b <= "0000001100010001";
    borrow <= '1';
    opcode <= "01";
    WAIT FOR period_time;
    a <= "0000000000000010";
    b <= "0000000000000001";
    borrow <= '1';
    opcode <= "10";
    WAIT FOR period_time;
    a <= "1000000000000001";
    b <= "1111111111111111";
    borrow <= '0';
    opcode <= "00";
    WAIT FOR period_time;
    a <= "0000000000000001";
    b <= "0000000000000001";
    borrow <= '0';
    opcode <= "11";
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