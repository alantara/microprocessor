library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
  port(
  a, b: in unsigned(15 downto 0);
  sel: in unsigned(2 downto 0);
  zero: out std_logic;
  output: out unsigned(15 downto 0)
);
end entity;

architecture a_ULA of ULA is

  component mux8x1b16 is
    port(
    m0, m1, m2, m3, m4, m5, m6, m7: in unsigned(15 downto 0);
    sel: in unsigned(2 downto 0);
    output: out unsigned(15 downto 0)
  );
  end component;

  signal m0, m1, m2, m3, m4, m5, m6, m7, muxr: unsigned(15 downto 0);

  signal multr: unsigned(31 downto 0);
begin

  out_mux: mux8x1b16 port map(
                        m0=>m0,
                        m1=>m1,
                        m2=>m2,
                        m3=>m3,
                        m4=>m4,
                        m5=>m5,
                        m6=>m6,
                        m7=>m7,
                        sel=>sel,
                        output=>muxr
                      );

  m0<=a+b;
  m1<=a-b;

  m2<=a or b;
  m3<=a and b;
  m4<=not a;

  m5<='0' & a(15 downto 1);
  m6<=a(14 downto 0) & '0';

  multr<=a*b;
  m7<=multr(15 downto 0);

  zero<='1' when muxr="0000000000000000" else
        '0';
  output<=muxr;

end architecture;
