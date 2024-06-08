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
    --CRIVO para 0x4AD0

    --LOADA N em R1
    0 => B"000000000_001_1001", --LU R1, 0x004A ------
    1 => B"001100001_000_1110", --LD A, 0x00D0  ------
    2 => B"000000000_001_0100", --ADD A, R1
    3 => B"000000000_001_0010", --MOV R1, A

    --INICIALIZA RAM PARA 0 E 1 = 0
    5 => B"000000000_011_1111", --LD R3, 0
    6 => B"000000011_000_0111", --SW R0, R3
    7 => B"000000001_011_1111", --LD R3, 1
    8 => B"000000011_000_0111", --SW R0, R3

    --SETA RAM = 1 PARA TODOS OS NUMEROS DE 2 A N
    9 => B"000000001_010_1111", --LD R2, 1
    10 => B"000000001_011_1111", --LD R3, 1
    11 => B"000000001_000_1110", --LD A, 1      : X
    12 => B"000000000_011_0100", --ADD A, R3
    13 => B"000000000_011_0010", --MOV R3, A
    14 => B"000000011_010_0111", --SW R2, R3
    15 => B"000000000_000_1101", --CLR Z
    16 => B"000000000_001_0011", --MOV A, R1
    17 => B"000000000_011_0101", --SUB A, R3
    18 => B"111111001_111_1100", --JB 7, X  / BNE X

    19 => B"000000000_101_1111", --LD R5, 0    <------ FLAG COMPLETED

    --CRIVO ALGORITIMO
    20 => B"000000001_010_1111", --LD R2, 1
    21 => B"000000001_000_1110", --LD A, 1     : Y
    22 => B"000000000_010_0100", --ADD A, R2
    23 => B"000000000_010_0010", --MOV R2, A
    24 => B"000000000_000_1101", --CLR Z
    25 => B"000000000_001_0011", --MOV A, R1
    26 => B"000000000_010_0101", --SUB A, R2
    27 => B"000010111_010_1100", --JB 2, END  /  BGT END
    28 => B"000000010_011_1000", --LW R3, R2
    29 => B"000000000_000_1101", --CLR Z
    30 => B"000000000_000_0011", --MOV A, R0
    31 => B"000000000_011_0101", --SUB R3, A
    32 => B"111110101_000_1100", --JB 0, Y  / BEQ Y
    33 => B"000000000_010_0011", --MOV A, R2
    34 => B"000000000_100_0010", --MOV R4, A
    35 => B"000000000_010_0011", --MOV A, R2      : Z
    36 => B"000000000_100_0100", --ADD A, R4
    37 => B"000000000_100_0010", --MOV R4, A
    38 => B"000000000_000_1101", --CLR Z
    39 => B"000000000_001_0011", --MOV A, R1
    40 => B"000000000_100_0101", --SUB R4, A
    41 => B"111101100_010_1100", --JB 2, Y  /  BGT Y
    42 => B"000000100_000_0111", --SW R0, R4
    43 => B"000100011_000_0001", --JMP Z

    50 => B"000000000_000_0000", --NOP      : END
    51 => B"111101101_101_1111", --LD R5, 0x01ED
    52 => B"000000001_110_1000", --LW R6, R1

    --LAB 7
    --0 => B"011111111_001_1111", --LD R1, 0x00FF
    --1 => B"111111111_010_1111", --LD R2, 0x01FF
    --2 => B"010101111_011_1111", --LD R3, 0x00AF
    --3 => B"000011110_100_1111", --LD R4, 0x001E
    --4 => B"101011000_101_1111", --LD R5, 0x0158
    --5 => B"000000000_000_0000", --NOP
    --6 => B"000100001_110_1111", --LD R6, 0x0021
    --7 => B"000000000_000_0000", --NOP
    --8 => B"000101001_111_1111", --LD R7, 0x0029
    --9 => B"000000111_001_0111", --SW R1, R7
    --10 => B"000101010_111_1111", --LD R7, 0x002A
    --11 => B"000000111_010_0111", --SW R2, R7
    --12 => B"000101100_111_1111", --LD R7, 0x002C
    --13 => B"000000111_011_0111", --SW R3, R7
    --14 => B"000101111_111_1111", --LD R7, 0x002F
    --15 => B"000000111_100_0111", --SW R4, R7
    --16 => B"000110101_111_1111", --LD R7, 0x0035
    --17 => B"000000111_101_0111", --SW R5, R7
    --18 => B"000000000_000_0000", --NOP
    --19 => B"000000000_001_1111", --LD R1, 0x0000
    --20 => B"000000000_000_0000", --NOP
    --21 => B"000000001_000_1110", --LD A, 0x0001
    --22 => B"000000000_110_0100", --ADD A, R6
    --23 => B"000000000_110_0010", --MOV R6, A
    --24 => B"000000110_001_1000", --LW R1, R6
    --25 => B"000000000_000_1101", --CLR Z
    --26 => B"000110101_000_1110", --LD A, 0x0035
    --27 => B"000000000_110_0101", --SUB A, R6
    --28 => B"111111001_000_1010", --BNE 0xF9
    --29 => B"000000000_000_0000", --NOP
    --30 => B"000000000_001_0011", --MOV A, R1
    --31 => B"000000000_011_0100", --ADD A, R3
    --32 => B"000000000_100_0010", --MOV R4, A

    --LAB 6
    --0 => B"000000000_011_1111", --LD R3, 0x0000
    --1 => B"000000000_100_1111", --LD R4, 0x0000
    --2 => B"000000000_011_0011", --MOV A, R3
    --3 => B"000000000_100_0100", --ADD R4, A
    --4 => B"000000000_100_0010", --MOV R4, A
    --5 => B"000000001_000_1110", --LD A, 1
    --6 => B"000000000_011_0100", --ADD R3, A
    --7 => B"000000000_011_0010", --MOV R3, A
    --8 => B"000000000_000_1101", --CLR Z
    --9 => B"000011110_000_1110", --LD A, 0x001E
    --10 => B"000000000_011_0101", --SUB R3, A
    --11 => B"111110111_000_1011", --BLT 0x31312
    --12 => B"000000000_100_0011", --MOV A, R4
    --13 => B"000000000_101_0010", --MOV R5, A
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