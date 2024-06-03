LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY control_unit IS
  PORT (
    clk, rst : IN STD_LOGIC;
    instruction : IN unsigned(15 DOWNTO 0);
    zero_flag, carry_flag, greater_flag : IN STD_LOGIC;
    pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, flags_clk : OUT STD_LOGIC;
    zero_rst, carry_rst, greater_rst : OUT STD_LOGIC;
    dr_ld, dr_mv, acc_ld, acc_mv, jmp_en, br_en : OUT STD_LOGIC;
    ula_opcode : OUT unsigned(1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_control_unit OF control_unit IS

  COMPONENT state_machine IS
    PORT (
      clk, rst : IN STD_LOGIC;
      state : OUT unsigned(1 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL state : unsigned(1 DOWNTO 0) := "00";

  SIGNAL if_clk, id_clk, exe_clk : STD_LOGIC;

  SIGNAL opcode : unsigned(3 DOWNTO 0);
  SIGNAL r : unsigned(2 DOWNTO 0);

BEGIN
  st : state_machine PORT MAP(clk => clk, rst => rst, state => state);

  if_clk <= '1' WHEN state = "00" ELSE
    '0';
  id_clk <= '1' WHEN state = "01" ELSE
    '0';
  exe_clk <= '1' WHEN state = "10" ELSE
    '0';

  opcode <= instruction(3 DOWNTO 0);
  r <= instruction(6 DOWNTO 4);

  pc_clk <= '1' WHEN exe_clk = '1' ELSE
    '0';
  rom_clk <= '1' WHEN if_clk = '1' ELSE
    '0';
  rom_reg_clk <= '1' WHEN id_clk = '1' ELSE
    '0';
  dr_clk <= '1' WHEN exe_clk = '1' AND opcode = "0010" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "1111" ELSE
    '0';
  acc_clk <= '1' WHEN exe_clk = '1' AND opcode = "0100" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "0101" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "0110" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "0011" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "1110" ELSE
    '0';
  flags_clk <= '1' WHEN exe_clk = '1' AND opcode = "0100" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "0101" ELSE
    '1' WHEN exe_clk = '1' AND opcode = "0110" ELSE
    '0'; --DUVIDOSO

  zero_rst <= '1' WHEN exe_clk = '1' AND opcode = "1000" AND r = "000" ELSE
    '0';
  carry_rst <= '1' WHEN exe_clk = '1' AND opcode = "1000" AND r = "001" ELSE
    '0';
  greater_rst <= '1' WHEN exe_clk = '1' AND opcode = "1000" AND r = "010" ELSE
    '0';

  dr_ld <= '1' WHEN opcode = "1111" ELSE
    '0';
  dr_mv <= '1' WHEN opcode = "0010" ELSE
    '0';
  acc_ld <= '1' WHEN opcode = "1110" ELSE
    '0';
  acc_mv <= '1' WHEN opcode = "0011" ELSE
    '0';
  jmp_en <= '1' WHEN opcode = "0001" ELSE
    '0';
  br_en <= '1' WHEN opcode = "1001" AND zero_flag = '1' ELSE
    '1' WHEN opcode = "1010" AND zero_flag = '0' ELSE
    '1' WHEN opcode = "1011" AND zero_flag = '0' AND greater_flag = '0' ELSE
    '1' WHEN opcode = "1100" AND greater_flag = '1' ELSE
    '0';

  ula_opcode <= "00" WHEN opcode = "0100" ELSE
    "01" WHEN opcode = "0101" ELSE
    "10" WHEN opcode = "0110" ELSE
    "00";

END ARCHITECTURE;