LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine IS
  PORT (
    clk, rst : IN STD_LOGIC;
    state : OUT unsigned(1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_state_machine OF state_machine IS

  SIGNAL machine_state : unsigned(1 DOWNTO 0) := "00";

BEGIN
  PROCESS (clk)
  BEGIN
    IF rst = '1' THEN
      machine_state <= "00";
    ELSIF rising_edge(clk) THEN
      IF machine_state = "11" THEN
        machine_state <= "00";
      ELSE
        machine_state <= machine_state + 1;
      END IF;
    END IF;
  END PROCESS;

  state <= machine_state;

END ARCHITECTURE;