LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY control_unit IS
  PORT (
    clk, rst : IN STD_LOGIC;
    instruction : IN unsigned(15 DOWNTO 0);
    zero_flag, carry_flag, greater_flag : IN STD_LOGIC;
    if_clk, id_clk, preexe_clk, exe_clk, dr_wr_en, acc_wr_en, flags_wr_en, ram_wr_en, addr_ram_wr_en : OUT STD_LOGIC;
    zero_rst, carry_rst, greater_rst : OUT STD_LOGIC;
    dr_ld, dr_mv, dr_lw, dr_ram, acc_ld, acc_mv, lu_en, jmp_en, br_en : OUT STD_LOGIC;
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

  SIGNAL opcode : unsigned(3 DOWNTO 0);
  SIGNAL r : unsigned(2 DOWNTO 0);

BEGIN
  st : state_machine PORT MAP(clk => clk, rst => rst, state => state);

  if_clk <= '1' WHEN state = "00" ELSE
    '0';
  id_clk <= '1' WHEN state = "01" ELSE
    '0';
  preexe_clk <= '1' WHEN state = "10" ELSE
    '0';
  exe_clk <= '1' WHEN state = "11" ELSE
    '0';

  opcode <= instruction(3 DOWNTO 0);
  r <= instruction(6 DOWNTO 4);

  dr_wr_en <= '1' WHEN opcode = "0010" ELSE
    '1' WHEN opcode = "1000" ELSE
    '1' WHEN opcode = "1001" ELSE
    '1' WHEN opcode = "1111" ELSE
    '0';
  acc_wr_en <= '1' WHEN opcode = "0100" ELSE
    '1' WHEN opcode = "0101" ELSE
    '1' WHEN opcode = "0110" ELSE
    '1' WHEN opcode = "0011" ELSE
    '1' WHEN opcode = "1110" ELSE
    '0';
  flags_wr_en <= '1' WHEN opcode = "0100" ELSE
    '1' WHEN opcode = "0101" ELSE
    '1' WHEN opcode = "0110" ELSE
    '0';
  ram_wr_en <= '1' WHEN opcode = "0111" ELSE
    '0';
  addr_ram_wr_en <= '1' WHEN opcode = "0111" ELSE
    '1' WHEN opcode = "1000" ELSE
    '0';

  zero_rst <= '1' WHEN state = "11" AND opcode = "1101" AND r = "000" ELSE
    '0';
  carry_rst <= '1' WHEN state = "11" AND opcode = "1101" AND r = "001" ELSE
    '0';
  greater_rst <= '1' WHEN state = "11" AND opcode = "1101" AND r = "010" ELSE
    '0';

  dr_ld <= '1' WHEN opcode = "1111" ELSE
    '0';
  dr_mv <= '1' WHEN opcode = "0010" ELSE
    '0';
  dr_lw <= '1' WHEN opcode = "1000" ELSE
    '0';
  dr_ram <= '1' WHEN state = "01" AND opcode = "0111" ELSE
    '1' WHEN state = "01" AND opcode = "1000" ELSE
    '0';
  acc_ld <= '1' WHEN opcode = "1110" ELSE
    '0';
  acc_mv <= '1' WHEN opcode = "0011" ELSE
    '0';
  lu_en <= '1' WHEN opcode = "1001" ELSE
    '0';
  jmp_en <= '1' WHEN opcode = "0001" ELSE
    '0';
  br_en <= '1' WHEN opcode = "1100" AND r = "000" AND zero_flag = '1' ELSE
    '1' WHEN opcode = "1100" AND r = "111" AND zero_flag = '0' ELSE
    '1' WHEN opcode = "1100" AND r = "101" AND zero_flag = '0' AND greater_flag = '0' ELSE
    '1' WHEN opcode = "1100" AND r = "010" AND greater_flag = '1' ELSE
    '0';

  ula_opcode <= "00" WHEN opcode = "0100" ELSE
    "01" WHEN opcode = "0101" ELSE
    "10" WHEN opcode = "0110" ELSE
    "00";

END ARCHITECTURE;