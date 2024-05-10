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
  0  => B"000101_000_011_1000", -- addi r3, zero, 5      0x1438
  1  => B"001000_000_100_1000", -- addi r4, zero, 8      0x2048
  2  => B"000_011_100_101_0001", -- add r5, r4, r3       0x0E51
  3  => B"000001_101_101_1001", -- subi r5, r5, 1        0x06D9
  4  => B"010100_000000_1111", -- jmp 20                 0x500F
  5  => B"000_000_000_101_0000", -- add r5, zero, zero   0x0050
  20  => B"000_011_000_101_0000", -- add r5, zero, r3     0x0C50
  21 => B"000010_000000_1111", -- jmp 2                  0x080F
  22  => B"000_000_000_011_0000", -- add r3, zero, zero   0x0030
  23  => B"0000000000000000", -- nop                      0x0000
  -- fluxo esperado:
  -- 0x1438 => 0x2048 => 0x0E51 => 0x06D9 => 0x500F => 0x0C50 => 0x080F
  -- loop: 0x0E51 até 0x080F
  others => (others=>'0')
);
begin
  process(clk)
  begin
    if(rising_edge(clk)) then
      data <= content(to_integer(address));
    end if;
  end process;
end architecture;
