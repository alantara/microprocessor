library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity;

architecture a_tb of tb is

component ULAb16 is
	port(
		a, b: in unsigned(15 downto 0);
		sel0, sel1, sel2: in std_logic;
		output: out unsigned(15 downto 0);
		zero: out std_logic
	);
end component;

signal a, b, output: unsigned(15 downto 0);
signal sel0, sel1, sel2, zero: std_logic;

begin

	uut: ULAb16 port map(
			 	a=>a,
				b=>b,
				sel0=>sel0,
				sel1=>sel1,
				sel2=>sel2,
				output=>output,
				zero=>zero
			 );

process
begin
	--ADD
	a<="0000000010010000";b<="0010001001001000";sel2<='0';sel1<='0';sel0<='0';wait for 50 ns;
	a<="1100100100000000";b<="1010010010000000";sel2<='0';sel1<='0';sel0<='0';wait for 50 ns;
	
	--SUB
	a<="0001001100010000";b<="0000001100100000";sel2<='0';sel1<='0';sel0<='1';wait for 50 ns;
	a<="0000000000001000";b<="0000001100100000";sel2<='0';sel1<='0';sel0<='1';wait for 50 ns;

	--SHIFT LEFT
	a<="0000010000100100";b<="0001000000100000";sel2<='0';sel1<='1';sel0<='0';wait for 50 ns;
	a<="1000100100100000";b<="0001000000100000";sel2<='0';sel1<='1';sel0<='0';wait for 50 ns;
	
	--SHIFT RIGHT
	a<="1000000000100001";b<="0001000000100000";sel2<='0';sel1<='1';sel0<='1';wait for 50 ns;
	a<="1000100000100100";b<="0001000000100000";sel2<='0';sel1<='1';sel0<='1';wait for 50 ns;

	--MULT
	a<="0000000000100001";b<="0000000001100110";sel2<='1';sel1<='0';sel0<='0';wait for 50 ns;
	a<="1000100000100100";b<="0001000000100000";sel2<='1';sel1<='0';sel0<='0';wait for 50 ns;

	--NOT
	a<="0000000000100001";b<="0000000001100110";sel2<='1';sel1<='0';sel0<='1';wait for 50 ns;
	a<="1000100000100100";b<="0001000000100000";sel2<='1';sel1<='0';sel0<='1';wait for 50 ns;

	--AND
	a<="0000000000100001";b<="0000000001100110";sel2<='1';sel1<='1';sel0<='0';wait for 50 ns;
	a<="1000100000100100";b<="0001000000100000";sel2<='1';sel1<='1';sel0<='0';wait for 50 ns;

	--OR
	a<="0000000000100001";b<="0000000001100110";sel2<='1';sel1<='1';sel0<='1';wait for 50 ns;
	a<="1000100000100100";b<="0001000000100000";sel2<='1';sel1<='1';sel0<='1';wait for 50 ns;

	--ZERO
	a<="0000000000100001";b<="0000000000100001";sel2<='0';sel1<='0';sel0<='1';wait for 50 ns;
	a<="0000000000000001";b<="0000000000100001";sel2<='0';sel1<='1';sel0<='1';wait for 50 ns;


	wait;
end process;

end architecture;
