library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity umultb16 is
	port(
	    	a, b: in unsigned(15 downto 0);
		output: out unsigned(15 downto 0)
	    );
end entity;

architecture a_umultb16 of umultb16 is
signal tmpmultb32: unsigned(31 downto 0);

begin
	tmpmultb32 <= a*b;
	output <= tmpmultb32(15 downto 0);
end architecture;
