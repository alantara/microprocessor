library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port(
  a, b: in unsigned(15 downto 0);
  opcode: in unsigned(2 downto 0);
  carry_flag: in std_logic;
  zero_out, carry_out, greater_out: out std_logic;
  output: out unsigned(15 downto 0)
);
end entity;

architecture arq of ula is
  signal m0, m1, m2, m3, m4, m5, m6, m7: unsigned(15 downto 0) := "0000000000000000";
  
  signal carry_soma, carry_sub: std_logic := '0';
  signal a17, b17, soma: unsigned(16 downto 0) := "00000000000000000";
begin

  a17<= '0' & a;
  b17<= '0' & b;
  soma<= a17+b17;
  
  m0<=soma(15 downto 0);
  m1<=a-b;
  m2<=a or b;
  m3<=a and b;
  m4<=not a;
  m5<='0' & a(15 downto 1); -- shift right (a >> 1)
  m6<=a(14 downto 0) & '0'; -- shift left  (a << 1)

  m7<=a-b-1 when carry_flag='1' else
      a-b;

  zero_out<='1' when m1="0000000000000000" else '0';
  carry_soma<=soma(16);

  carry_sub<='0' when b<=a else
             '1';

  carry_out<=carry_soma when opcode="000" else
         carry_sub;

  greater_out<='1' when signed(m1)>"0000000000000000" else
               '0';

  output <= m0 when opcode="000" else
            m1 when opcode="001" else
            m2 when opcode="010" else
            m3 when opcode="011" else
            m4 when opcode="100" else
            m5 when opcode="101" else
            m6 when opcode="110" else
            m7 when opcode="111" else
            "0000000000000000";

end architecture;
