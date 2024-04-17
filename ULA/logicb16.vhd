library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logicb16 is
	port(
		a, b: in unsigned(15 downto 0);
		output_not, output_and, output_or: out unsigned(15 downto 0)
	    );
end entity;

architecture a_logicb16 of logicb16 is
begin
	output_not <= not a;
	output_and <= a and b;
	output_or  <= a or b;
end architecture;
