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

    0 => B"010101010_001_1111", -- LD R1, 0x00AA
    1 => B"000101000_010_1111", -- LD R2, 0x0028

    2 => B"001000010_001_1001", -- ADDI R1, 0x0042
    3 => B"000000000_011_0010", -- MOV R3, A
    4 => B"001010011_010_1001", -- ADDI R2, 0x0053
    5 => B"000000000_100_0010", -- MOV R4, A

    6 => B"001110111_001_1101", -- SUBI R1, 0x0077
    7 => B"000000000_101_0010", -- MOV R5, A
    8 => B"000001011_010_1001", -- ADDI R2, 0x000B
    9 => B"000000000_110_0010", -- MOV R6, A

    10 => B"000000100_011_1010", -- CMP R3, R4
    11 => B"000000110_101_1010", -- CMP R5, R6

    12 => B"001010011_001_1101", -- SUBI R1, 0x0053
    13 => B"000000000_011_0010", -- MOV R3, A
    14 => B"001010011_010_1001", -- ADDI R2, 0x0053
    15 => B"000000000_100_0010", -- MOV R4, A

    16 => B"010110011_010_1101", -- SUBI R2, 0x00B3
    17 => B"000000000_010_0110", -- SUBB A, R2
    18 => B"000000000_111_0010", -- MOV R7, A

    19 => B"000000100_011_1010", -- CMP R3, R4

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