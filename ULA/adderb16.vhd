library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adderb16 is
	port(
	   	a, b: in unsigned(15 downto 0);
       		add, sub: out unsigned(15 downto 0)	
	    );
end entity;

architecture a_adderb16 of adderb16 is
begin
	add <= a+b;
	sub <= a-b;
end architecture;
