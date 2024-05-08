library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port(
  a, b: in unsigned(15 downto 0);
  opcode: in unsigned(2 downto 0);
  zero: out std_logic;
  output: out unsigned(15 downto 0)
);
end entity;

architecture arq of ula is
  signal m0, m1, m2, m3, m4, m5, m6, m7: unsigned(15 downto 0) := "0000000000000000";
  signal multr: unsigned(31 downto 0) := "00000000000000000000000000000000";
begin

  m0<=a+b;
  m1<=a-b;
  m2<=a or b;
  m3<=a and b;
  m4<=not a;
  m5<='0' & a(15 downto 1); -- shift right (a >> 1)
  m6<=a(14 downto 0) & '0'; -- shift left  (a << 1)

  multr<=a*b;
  m7<=multr(15 downto 0);

  zero<='1' when m1="0000000000000000" else '0';

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
