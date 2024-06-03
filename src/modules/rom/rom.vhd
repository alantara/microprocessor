LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
  PORT (
    clk : IN STD_LOGIC;
    address : IN unsigned(5 DOWNTO 0);
    data : OUT unsigned(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_rom OF rom IS
  TYPE mem IS ARRAY (0 TO 63) OF unsigned(15 DOWNTO 0);
  CONSTANT content : mem := (
    0 => B"000000000_011_1111",

    1 => B"000000000_100_1111",

    2 => B"001111111_111_1111",

    4 => B"000001010_000_0001",

    10 => B"000000000_011_0011",
    11 => B"000000000_100_0100",
    12 => B"000000000_100_0010",

    13 => B"000000001_000_1110",
    14 => B"000000000_011_0100",
    15 => B"000000000_011_0010",

    16 => B"000000000_110_1000",
    17 => B"111111111_110_1111",
    18 => B"111111111_000_1110",
    19 => B"000000000_110_0100",

    20 => B"000000001_000_1110",
    21 => B"000000000_111_0110",
    22 => B"000000000_111_0010",

    23 => B"000000000_000_1000",
    24 => B"000011110_000_1110",
    25 => B"000000000_011_0101",
    26 => B"111110000_000_1011",

    27 => B"000000000_100_0011",
    28 => B"000000000_101_0010",
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