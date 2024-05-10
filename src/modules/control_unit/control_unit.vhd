library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
  port(
  instruction: in unsigned(15 downto 0);
  clk, rst : in std_logic;
  pc_clk, rom_clk, dr_clk: out std_logic;
  jmp_en: out std_logic;
  ula_opcode: out unsigned(2 downto 0);
  ula_imm: out std_logic
);
end;

architecture a_control_unit of control_unit is

  component state_machine is 
    port(
    clk, rst : in std_logic;
    state : out unsigned(1 downto 0)
  );
  end component;

  signal state: unsigned(1 downto 0);
  signal opcode: unsigned(3 downto 0); 
  
begin
  opcode <= instruction(3 downto 0);
  
  
  sm : state_machine port map(clk, rst, state);
  
  pc_clk<='1' when state = "000" else
          '0';
  rom_clk<='1' when state = "001" else
           '0';
  dr_clk<='1' when state = "010" else
           '0';

  
  jmp_en <= '1' when opcode="1111" else
            '0';

  ula_opcode<="000";
  ula_imm<='0';

end a_control_unit;
