LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
  PORT (
    clk : IN STD_LOGIC;
    address : IN unsigned(6 DOWNTO 0);
    data : OUT unsigned(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_rom OF rom IS
  TYPE mem IS ARRAY (0 TO 127) OF unsigned(15 DOWNTO 0);
  CONSTANT content : mem := (

    0 => B"000100000_001_1110",
    1 => B"010101010_010_1111",
    2 => B"000000010_000_0100",

    3 => B"010101010_010_1111",
    4 => B"000101110_001_0100",

    OTHERS => (OTHERS => '0')
  );

  SIGNAL rom_data : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
  PROCESS (clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      rom_data <= content(to_integer(address));
    END IF;
  END PROCESS;

  data <= rom_data;
END ARCHITECTURE;