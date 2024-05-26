library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
  port(
  instruction: in unsigned(15 downto 0);
  clk, rst : in std_logic;
  zero_flag, carry_flag, greater_flag: in std_logic;
  pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, zero_clk, carry_clk: out std_logic;
  rst_zero, rst_carry, rst_greater: out std_logic;
  jmp_en, br_en, dr_ld, acc_ld, acc_mv: out std_logic;
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
  signal rs: unsigned(2 downto 0); 
begin
  opcode <= instruction(3 downto 0);
  rs <= instruction(6 downto 4);
  
  sm : state_machine port map(clk, rst, state);
  
  pc_clk<='1' when state = "010" else
          '0';
  rom_clk<='1' when state = "000" else
           '0';
  rom_reg_clk<='1' when state = "001" else
               '0';

  jmp_en <= '1' when opcode="0001" else
            '0';
  br_en <= '1' when opcode="1001" and zero_flag='1' else
           '1' when opcode="1010" and greater_flag='0' else
           '1' when opcode="1011" and greater_flag='1' else
           '0';


  dr_ld<='1' when opcode="1111" else
         '0';
  acc_ld<='1' when opcode="1110" else
          '0';
  acc_mv<='1' when opcode="0010" else
          '1' when opcode="0011" else
          '0';
            
  ula_opcode<="000" when opcode="0100" else
              "001" when opcode="0101" else
              "000";

  zero_clk<='1' when opcode="0100" and state="010" else
            '1' when opcode="0101" and state="010" else
            '1' when opcode="0111" and state="010" else
            '0';
  carry_clk<='1' when opcode="0100" and state="010" else
             '1' when opcode="0101" and state="010" else
             '1' when opcode="0111" and state="010" else
             '0';

  rst_zero<='1' when opcode="1000" and rs="000" else
            '0';
  rst_carry<='1' when opcode="1000" and rs="001" else
            '0';
  rst_greater<='1' when opcode="1000" and rs="010" else
             '0';

  dr_clk<='1' when opcode="0010" and state="010" else
          '1' when opcode="1111" and state="010" else
          '0';
  acc_clk<='1' when opcode="0011" and state="010" else
           '1' when opcode="0100" and state="010" else
           '1' when opcode="0101" and state="010" else
           '1' when opcode="0111" and state="010" else
           '1' when opcode="1110" and state="010" else
           '0';

end a_control_unit;
