LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
  PORT (
    a, b : IN unsigned(15 DOWNTO 0);
    borrow : IN STD_LOGIC;
    opcode : IN unsigned(1 DOWNTO 0);
    zero_flag, carry_flag, greater_flag : OUT STD_LOGIC;
    output : OUT unsigned(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE a_ula OF ula IS

  SIGNAL m, m0, m1, m2, m3 : unsigned(15 DOWNTO 0) := "0000000000000000";

  SIGNAL carry_sum, carry_sub : STD_LOGIC;
  SIGNAL a17, b17, sum17 : unsigned(16 DOWNTO 0) := "00000000000000000";

BEGIN

  --Carry Sum
  a17 <= '0' & a;
  b17 <= '0' & b;
  sum17 <= a17 + b17;
  carry_sum <= sum17(16);

  --Carry Sub
  carry_sub <= '0' WHEN b <= a ELSE
    '1';

  --ula Flags
  carry_flag <= carry_sum WHEN opcode = "00" ELSE
    carry_sub WHEN opcode = "01" ELSE
    '0';
  zero_flag <= '1' WHEN m = "0000000000000000" ELSE
    '0';
  greater_flag <= '1' WHEN signed(m) > "0000000000000000" ELSE
    '0';

  --Default Operations
  m0 <= a + b;
  m1 <= a - b;
  m2 <= a - b - 1 WHEN borrow = '1' ELSE
    a - b;
  m3 <= a NAND b;

  m <= m0 WHEN opcode = "00" ELSE
    m1 WHEN opcode = "01" ELSE
    m2 WHEN opcode = "10" ELSE
    m3 WHEN opcode = "11" ELSE
    "0000000000000000";

  output <= m;

END ARCHITECTURE;