LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
  PORT (
    clk, rst : IN STD_LOGIC
  );
END ENTITY;

ARCHITECTURE a_processador OF processador IS

  COMPONENT control_unit IS
    PORT (
      clk, rst : IN STD_LOGIC;
      instruction : IN unsigned(15 DOWNTO 0);
      zero_flag, carry_flag, greater_flag : IN STD_LOGIC;
      pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, flags_clk : OUT STD_LOGIC;
      zero_rst, carry_rst, greater_rst : OUT STD_LOGIC;
      dr_ld, dr_mv, acc_ld, acc_mv, jmp_en, br_en : OUT STD_LOGIC;
      ula_opcode : OUT unsigned(1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT regb1 IS
    PORT (
      clk, rst, wr_en : IN STD_LOGIC;
      data_in : IN STD_LOGIC;
      data_out : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT regb6 IS
    PORT (
      clk, rst, wr_en : IN STD_LOGIC;
      data_in : IN unsigned(5 DOWNTO 0);
      data_out : OUT unsigned(5 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT regb16 IS
    PORT (
      clk, rst, wr_en : IN STD_LOGIC;
      data_in : IN unsigned(15 DOWNTO 0);
      data_out : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT rom IS
    PORT (
      clk : IN STD_LOGIC;
      address : IN unsigned(5 DOWNTO 0);
      data : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT data_register IS
    PORT (
      rs, rd : IN unsigned(2 DOWNTO 0);
      data_wr : IN unsigned(15 DOWNTO 0);
      clk, rst, wr_en : IN STD_LOGIC;
      output : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT ula IS
    PORT (
      a, b : IN unsigned(15 DOWNTO 0);
      borrow : IN STD_LOGIC;
      opcode : IN unsigned(1 DOWNTO 0);
      zero_flag, carry_flag, greater_flag : OUT STD_LOGIC;
      output : OUT unsigned(15 DOWNTO 0)
    );
  END COMPONENT;

  --SIGNALS 
  --uc
  SIGNAL pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, flags_clk : STD_LOGIC;
  SIGNAL zero_rst, carry_rst, greater_rst : STD_LOGIC;
  SIGNAL dr_ld, dr_mv, acc_ld, acc_mv, jmp_en, br_en : STD_LOGIC;
  SIGNAL ula_opcode : unsigned(1 DOWNTO 0);

  --flags
  SIGNAL carry_flag, zero_flag, greater_flag : STD_LOGIC;

  --pc
  SIGNAL pc_in, address : unsigned(5 DOWNTO 0);

  --rom
  SIGNAL instruction_fetch, instruction : unsigned(15 DOWNTO 0);

  SIGNAL opcode : unsigned(3 DOWNTO 0);
  SIGNAL r : unsigned(2 DOWNTO 0);
  SIGNAL imm : unsigned(8 DOWNTO 0);

  SIGNAL ext_imm : unsigned (15 DOWNTO 0);

  --data register
  SIGNAL dr_in, dr_out : unsigned(15 DOWNTO 0);

  --acc
  SIGNAL acc_in, acc_out : unsigned(15 DOWNTO 0);

  --ula
  SIGNAL ula_carry, ula_zero, ula_greater : STD_LOGIC;
  SIGNAL ula_out : unsigned(15 DOWNTO 0);

BEGIN
  uc : control_unit PORT MAP(clk, rst, instruction, zero_flag, carry_flag, greater_flag, pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, flags_clk, zero_rst, carry_rst, greater_rst, dr_ld, dr_mv, acc_ld, acc_mv, jmp_en, br_en, ula_opcode);

  carry : regb1 PORT MAP(clk => flags_clk, rst => carry_rst, wr_en => '1', data_in => ula_carry, data_out => carry_flag);
  zero : regb1 PORT MAP(clk => flags_clk, rst => zero_rst, wr_en => '1', data_in => ula_zero, data_out => zero_flag);
  greater : regb1 PORT MAP(clk => flags_clk, rst => greater_rst, wr_en => '1', data_in => ula_greater, data_out => greater_flag);

  --PC
  pc_in <= ext_imm(5 DOWNTO 0) WHEN jmp_en = '1' ELSE
    address + ext_imm(5 DOWNTO 0) WHEN br_en = '1' ELSE
    address + 1;
  pc : regb6 PORT MAP(clk => pc_clk, rst => rst, wr_en => '1', data_in => pc_in, data_out => address);

  --ROM
  mem : rom PORT MAP(clk => rom_clk, address => address, data => instruction_fetch);
  memr : regb16 PORT MAP(clk => rom_reg_clk, rst => rst, wr_en => '1', data_in => instruction_fetch, data_out => instruction);

  opcode <= instruction(3 DOWNTO 0);
  r <= instruction(6 DOWNTO 4);
  imm <= instruction(15 DOWNTO 7);

  ext_imm <= imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm;

  --DR
  dr_in <= ext_imm WHEN dr_ld = '1' ELSE
    acc_out WHEN dr_mv = '1' ELSE
    "0000000000000000";
  dr : data_register PORT MAP(rs => r, rd => r, data_wr => dr_in, clk => dr_clk, rst => rst, wr_en => '1', output => dr_out);

  --ACC
  acc_in <= ext_imm WHEN acc_ld = '1' ELSE
    dr_out WHEN acc_mv = '1' ELSE
    ula_out;
  acc : regb16 PORT MAP(clk => acc_clk, rst => rst, wr_en => '1', data_in => acc_in, data_out => acc_out);

  --ULA
  ul : ula PORT MAP(a => dr_out, b => acc_out, borrow => carry_flag, opcode => ula_opcode, carry_flag => ula_carry, zero_flag => ula_zero, greater_flag => ula_greater, output => ula_out);

END ARCHITECTURE;