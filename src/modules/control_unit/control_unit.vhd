library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
  port(
  instruction: in unsigned(15 downto 0);
  clk, rst : in std_logic;
  pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk: out std_logic;
  jmp_en, dr_ld, acc_ld, acc_mv: out std_logic;
  ula_opcode: out unsigned(2 downto 0)
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
  
  pc_clk<='1' when state = "010" else
          '0';
  rom_clk<='1' when state = "000" else
           '0';
  rom_reg_clk<='1' when state = "001" else
               '0';

  jmp_en <= '1' when opcode="0001" else
            '0';


  dr_ld<='1' when opcode="1111" else
         '0';
  acc_ld<='1' when opcode="0000" else
          '0';
  acc_mv<='1' when opcode="0010" else
          '1' when opcode="0011" else
          '0';
            
  ula_opcode<="000" when opcode="0100" else
              "001" when opcode="0101" else
              "000";

  dr_clk<='1' when opcode="0010" and state="010" else
          '1' when opcode="1111" and state="010" else
          '0';
  acc_clk<='1' when opcode="0011" and state="010" else
           '1' when opcode="0100" and state="010" else
           '1' when opcode="0101" and state="010" else
           '1' when opcode="0111" and state="010" else
           '1' when opcode="0000" and state="010" else
           '0';

end a_control_unit;
