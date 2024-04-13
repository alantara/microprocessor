library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ushifterb16 is
	port(
	    	a: in unsigned(15 downto 0);
		left, right: out unsigned(15 downto 0)
	    );
end entity;

architecture a_ushifterb16 of ushifterb16 is
begin
	left <= a(14 downto 0) & '0';
	right <= '0' & a(15 downto 1);
end architecture;
