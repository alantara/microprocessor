library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
  port(
  instruction: in unsigned(31 downto 0);
  clk, rst : in std_logic;
  pc_clk, rom_clk: out std_logic;
  jmp_en: out std_logic
);
end;

architecture a_control_unit of control_unit is

  component state_machine is 
    port(
    clk, rst : in std_logic;
    state : out std_logic
  );
  end component;

  signal state: std_logic;
  signal opcode: unsigned(2 downto 0); 
  
begin

  sm : state_machine port map(clk, rst, state);
  
  pc_clk<='1' when state = '1' else
          '0';
  rom_clk<='1' when state = '0' else
           '0';


  opcode <= instruction(2 downto 0);
  jmp_en <= '1' when opcode="111" else
            '0';

end a_control_unit;
