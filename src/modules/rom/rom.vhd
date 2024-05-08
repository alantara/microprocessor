library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  port( 
        clk      : in std_logic;
        address : in unsigned(7 downto 0);
        data     : out unsigned(31 downto 0) 
      );
end entity;

architecture a_rom of rom is
  type mem is array (0 to 255) of unsigned(31 downto 0);
  constant content : mem := (
      -- address => conteudo
  0  => "00000001000001000000000000000111", -- 0x01040007 | Pula para endereco 1
  1  => "10000000000000000000000000000000", -- 0x80000000
  2  => "00000110000000000000000000001111", -- 0x0600000F | Pula para endereco 6
  3  => "00000110000000000000000000000110", -- 0x06000006
  4  => "00000000000000000000000000000000", -- 0x00000000
  5  => "00000000001000000000000001111110", -- 0x0020007E
  6  => "11110000001100000000000000000000", -- 0xF0300000
  7  => "00000000001000000000000000000000", -- 0x00200000
  8  => "00000100000000000000000000000111", -- 0x04000007 | RETORNA PARA ENDERECO 4 (LOOP)
                                            -- abaixo: casos omissos => (zero em todos os bits)
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
