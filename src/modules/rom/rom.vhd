library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
   port( clk      : in std_logic;
         address : in unsigned(7 downto 0);
         data     : out unsigned(11 downto 0) 
   );
end entity;

architecture a_rom of rom is
   type mem is array (0 to 255) of unsigned(11 downto 0);
   constant content : mem := (
      -- address => conteudo
      0  => "000000000010", -- 0x002
      1  => "100000000000", -- 0x800
      2  => "000000000000",
      3  => "000000000000",
      4  => "100000000000", -- 0x800
      5  => "000000000010", -- 0x002
      6  => "111100000011", -- 0xF03
      7  => "000000000010", -- 0x002
      8  => "000000001010", -- 0x00A
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
