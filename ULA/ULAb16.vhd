library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAb16 is
	port(
		a, b: in unsigned(15 downto 0);
		sel0, sel1, sel2: in std_logic;
		output: out unsigned(15 downto 0)
	    );
end entity;

architecture a_ULAb16 of ULAb16 is


component mux8x1b16 is
	port(
	    	entr0, entr1, entr2, entr3, entr4, entr5, entr6, entr7 : in unsigned(15 downto 0);
		sel0, sel1, sel2 : in std_logic;
		output : out unsigned(15 downto 0)
	    );
end component;


component adderb16 is
	port(
	   	a, b: in unsigned(15 downto 0);
       		add, sub: out unsigned(15 downto 0)	
	    );
end component;

component ushifterb16 is
	port(
	    	a: in unsigned(15 downto 0);
		left, right: out unsigned(15 downto 0)
	    );
end component;

component umultb16 is
	port(
	    	a, b: in unsigned(15 downto 0);
		output: out unsigned(15 downto 0)
	    );
end component;

component logicb16 is
	port(
		a, b: in unsigned(15 downto 0);
		output_not, output_and, output_or: out unsigned(15 downto 0)
	    );
end component;


signal add, sub, left, right, mult, a_not, a_and_b, a_or_b: unsigned(15 downto 0);

begin
	adder: adderb16 port map(
			       		a=>a,
					b=>b,
					add=>add,
					sub=>sub
			       );
	shifter: ushifterb16 port map(
				  	a=>a,
					left=>left,
					right=>right
				  ); 
	
	multp: umultb16 port map(
			       		a=>a,
					b=>b,
					output=>mult
			       );


	logic: logicb16 port map(
					a=>a,
					b=>b,
					output_not=>a_not,
					output_and=>a_and_b,
					output_or=>a_or_b
				);

	mux: mux8x1b16 port map(
			    	entr0=>add,
				entr1=>sub,
				entr2=>left,
				entr3=>right,
				entr4=>mult,
				entr5=>a_not,
				entr6=>a_and_b,
				entr7=>a_or_b,
				sel0=>sel0,
				sel1=>sel1,
				sel2=>sel2,
				output=>output
			    );

end architecture;
