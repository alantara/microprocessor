library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor is
  port(
  clk, rst: in std_logic
);  
end entity;

architecture arq of microprocessor is

  component data_register is
    port(
    rs, rd: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    clk, rst, wr_en: in std_logic;
    output: out unsigned(15 downto 0) 
  );
  end component;

  component ula is
    port(
    a, b: in unsigned(15 downto 0);
    opcode: in unsigned(2 downto 0);
    carry_flag: in std_logic;
    zero_out, carry_out, greater_out: out std_logic;
    output: out unsigned(15 downto 0)
  );
  end component;

  component rom is
    port(
          clk : in std_logic;
          address : in unsigned(5 downto 0);
          data : out unsigned(15 downto 0) 
        );
  end component;

  component pc is 
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in unsigned(5 downto 0);
    data_out: out unsigned(5 downto 0)
  );
  end component;

  component plus_one is
    port(
          data_in: in unsigned(5 downto 0);
          data_out: out unsigned(5 downto 0)
        );
  end component;

  component control_unit is 
    port(
    instruction: in unsigned(15 downto 0);
    clk, rst : in std_logic;
    zero_flag, carry_flag, greater_flag: in std_logic;
    pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, zero_clk, carry_clk: out std_logic;
    rst_zero, rst_carry, rst_greater: out std_logic;
    jmp_en, br_en, dr_ld, acc_ld, acc_mv: out std_logic;
    ula_opcode: out unsigned(2 downto 0)
  );
  end component;

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in unsigned(15 downto 0);
    data_out: out unsigned(15 downto 0)
  );
  end component;

  component regb1 is
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in std_logic;
    data_out: out std_logic
  );
  end component;

  --CONTROL UNIT
  signal pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, zero_clk, carry_clk: std_logic := '0';
  signal jmp_en, br_en, dr_ld, acc_ld, acc_mv: std_logic := '0';
  signal ula_opcode: unsigned(2 downto 0) := "000";
  signal rst_zero, rst_carry, rst_greater: std_logic := '0';

  --PC
  signal pc_wr, pc_address: unsigned(5 downto 0) := "000000";

  --PO
  signal po_address: unsigned(5 downto 0) := "000000";

  --BR ADDER
  signal br_address: unsigned(5 downto 0) := "000000";

  --ROM
  signal instruction_fetch, instruction: unsigned(15 downto 0) := "0000000000000000";

  signal imm: unsigned(8 downto 0);
  signal rs: unsigned(2 downto 0);
  signal ext_imm: unsigned(15 downto 0);

  --DR
  signal dr_wr, dr_out: unsigned(15 downto 0) := "0000000000000000";

  --ULA
  signal zero_out, carry_out, greater_out: std_logic := '0';
  signal ula_out: unsigned(15 downto 0) := "0000000000000000";

  signal zero_flag, carry_flag, greater_flag: std_logic := '0';

  --ACCUMULATOR
  signal acc_in, acc_out: unsigned(15 downto 0) := "0000000000000000";

begin

  --CONTROL UNIT
  uc: control_unit port map(instruction, clk, rst, zero_flag, carry_flag, greater_flag, pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, zero_clk, carry_clk, rst_zero, rst_carry, rst_greater, jmp_en, br_en, dr_ld, acc_ld, acc_mv, ula_opcode);

  --PC
  pc_wr<=br_address when br_en='1' else
         ext_imm(5 downto 0) when jmp_en='1' else
         po_address;
  program_counter: pc port map(clk=>pc_clk, rst=>rst, wr_en=>'1', data_in=>pc_wr, data_out=>pc_address);

  --PLUS ONE
  po: plus_one port map(data_in=>pc_address, data_out=>po_address);

  br_address<=pc_address+ext_imm(5 downto 0);

  --ROM
  mem: rom port map(clk=>rom_clk, address=>pc_address, data=>instruction_fetch);

  fetch_reg: regb16 port map(clk=>rom_reg_clk, rst=>rst, wr_en=>'1', data_in=>instruction_fetch, data_out=>instruction);

  imm<=instruction(15 downto 7);
  rs<=instruction(6 downto 4);
  ext_imm<=imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm(8) & imm;

  --DATA REGISTER
  dr_wr<=ext_imm when dr_ld='1' else
         acc_out;
  dr: data_register port map(rs=>rs, rd=>rs, data_wr=>dr_wr, clk=>dr_clk, rst=>rst, wr_en=>'1', output=>dr_out);

  --ULA
  logic: ula port map(a=>dr_out, b=>acc_out, opcode=>ula_opcode, carry_flag=>carry_flag, zero_out=>zero_out, carry_out=>carry_out, greater_out=>greater_out, output=>ula_out);

  zer: regb1 port map(clk=>zero_clk, rst=>rst_zero, wr_en=>'1', data_in=>zero_out, data_out=>zero_flag);
  carr: regb1 port map(clk=>carry_clk, rst=>rst_carry, wr_en=>'1', data_in=>carry_out, data_out=>carry_flag);
  grea: regb1 port map(clk=>carry_clk, rst=>rst_greater, wr_en=>'1', data_in=>greater_out, data_out=>greater_flag);

  --ACCUMULATOR
  acc_in<=ext_imm when acc_ld='1' else
          dr_out when acc_mv='1' else
          ula_out;
  acc: regb16 port map(clk=>acc_clk, rst=>rst, wr_en=>'1', data_in=>acc_in, data_out=>acc_out);

end architecture;
