library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits is
	port(clk, rst, wr_en : in std_logic;
		 data_in : in unsigned(15 downto 0);
		 data_out : out unsigned(15 downto 0));
end;


architecture arq of reg16bits is
signal reg: unsigned(15 downto 0);
begin
	process(clk, rst, wr_en)
	begin
		if rst='1' then
			reg <= "0000000000000000";
		elsif wr_en = '1' then
			if rising_edge(clk) then
				reg <= data_in;
			end if;
		end if;
	end process;

	data_out <= reg;
end;

