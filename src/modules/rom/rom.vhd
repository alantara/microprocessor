library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  port( 
        clk      : in std_logic;
        address : in unsigned(5 downto 0);
        data     : out unsigned(15 downto 0) 
      );
end entity;

architecture a_rom of rom is
  type mem is array (0 to 63) of unsigned(15 downto 0);
  constant content : mem := (
  0  => B"000000101_011_1111", --LD R3, 0x5
  1  => B"000001000_100_1111", --LD R4, 0x8
  2  => B"000000000_011_0011", --MOV A, R3
  3  => B"000000000_100_0100", --ADD A, R4
  4  => B"000000000_101_0010", --MOV R5, A
  5  => B"111111111111_0000", --LD A, -1
  6  => B"000000000_101_0100", --ADD A, R5
  7  => B"000000000_101_0010", --MOV R5, A
  8  => B"000000010100_0001", --JMP 20
  9  => B"000000000_101_1111", --LD R5, 0x0
  20 => B"000000000_101_0011", --MV A, R5
  21 => B"000000000_011_0010", --MV R3, A
  22 => B"000000000010_0001", --JMP 2
  23 => B"000000000_011_1111", --LD R3, 0x0

  others => (others=>'0')
);

signal rom_data: unsigned(15 downto 0) := "0000000000000000";

begin
  process(clk)
  begin
    if(rising_edge(clk)) then
      rom_data <= content(to_integer(address));
    end if;
  end process;

  data<=rom_data;
end architecture;
