library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1b16 is
	port(
	    	entr0, entr1, entr2, entr3, entr4, entr5, entr6, entr7 : in unsigned(15 downto 0);
		sel0, sel1, sel2 : in std_logic;
		output : out unsigned(15 downto 0)
	    );
end entity;

architecture a_mux8x1b16 of mux8x1b16 is
begin
	output <= entr0 when sel2='0' and sel1='0' and sel0='0' else
		  entr1 when sel2='0' and sel1='0' and sel0='1' else
		  entr2 when sel2='0' and sel1='1' and sel0='0' else
		  entr3 when sel2='0' and sel1='1' and sel0='1' else
		  entr4 when sel2='1' and sel1='0' and sel0='0' else
		  entr5 when sel2='1' and sel1='0' and sel0='1' else
		  entr6 when sel2='1' and sel1='1' and sel0='0' else
		  entr7 when sel2='1' and sel1='1' and sel0='1' else
		  "0000000000000000";
end architecture;
