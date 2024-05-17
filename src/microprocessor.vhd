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
    rs1: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    rd: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a: out unsigned(15 downto 0) 
  );
  end component;

  component ula is
    port(
    a, b: in unsigned(15 downto 0);
    opcode: in unsigned(2 downto 0);
    zero: out std_logic;
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
    pc_clk, rom_clk, rom_reg_clk, dr_clk: out std_logic;
    jmp_en: out std_logic;
    ula_opcode: out unsigned(2 downto 0);
    ula_imm: out std_logic;
    dr_ld, dr_mv: out std_logic
  );
  end component;

  component regb16 is
    port(
    clk, rst, wr_en: in std_logic;
    d_in: in unsigned(15 downto 0);
    d_out: out unsigned(15 downto 0)
  );
  end component;



  --CONTROL UNIT
  signal pc_clk, rom_clk, rom_reg_clk, dr_clk, acc_clk, jmp_en: std_logic := '0';
  signal ula_opcode: unsigned(2 downto 0) := "000";
  signal ula_imm: std_logic := '0';
  signal dr_ld, dr_mv: std_logic :='0';
  
  --PC
  signal pc_wr_data : unsigned(5 downto 0) := "000000";
  signal pc_address : unsigned(5 downto 0) := "000000";

  --PO
  signal po_address : unsigned(5 downto 0) := "000000";

  --ROM
  signal instruction_fetch, instruction : unsigned(15 downto 0) := "0000000000000000";
  signal rd, rs1, rs2: unsigned(2 downto 0) := "000";
  signal imm: unsigned(5 downto 0) := "000000";
  signal super_imm: unsigned(8 downto 0) := "000000000";
  signal ext_imm, ext_super_imm: unsigned(15 downto 0) := "0000000000000000";

  --DATA REGISTER
  signal dr_wr_data: unsigned(15 downto 0) := "0000000000000000";
  signal dr_out_a, dr_out_b: unsigned(15 downto 0) := "0000000000000000";

  --ULA
  signal ula_b, ula_out: unsigned(15 downto 0) := "0000000000000000";
  signal zero_flag: std_logic := '0';

  --ACCUMULATOR
  signal acc_in, acc_out: unsigned(15 downto 0) := "0000000000000000";

begin

  --CONTROL UNIT
  uc: control_unit port map(instruction=>instruction, clk=>clk, rst=>rst, pc_clk=>pc_clk, rom_clk=>rom_clk, rom_reg_clk=>rom_reg_clk, dr_clk=>dr_clk, jmp_en=>jmp_en, ula_opcode=>ula_opcode, ula_imm=>ula_imm, dr_ld=>dr_ld, dr_mv=>dr_mv);

  --PC
  pc_wr_data<=po_address when jmp_en='0' else
              imm;
  program_counter: pc port map(clk=>pc_clk, rst=>rst, wr_en=>'1', data_in=>pc_wr_data, data_out=>pc_address);

  --PLUS ONE
  po: plus_one port map(data_in=>pc_address, data_out=>po_address);

  --ROM
  mem: rom port map(clk=>rom_clk, address=>pc_address, data=>instruction_fetch);

  fetch_reg: regb16 port map(clk=>rom_reg_clk, rst=>rst, wr_en=>'1', d_in=>instruction_fetch, d_out=>instruction);

  rd<=instruction(6 downto 4);
  rs1<=instruction(9 downto 7);
  imm<=instruction(15 downto 10);
  super_imm<=instruction(15 downto 7);
  ext_imm<="0000000000" & imm;
  ext_super_imm<="0000000" & super_imm;

  --DATA REGISTER
  dr_wr_data<=ext_super_imm when dr_ld='1' else
              ula_out;
  dr: data_register port map(rs1=>rs1, data_wr=>dr_wr_data, rd=>rd, clk=>dr_clk, rst=>rst, wr_en=>'1', output_a=>dr_out_a);

  --ULA
  logic: ula port map(a=>dr_out_a, b=>acc_out, opcode=>ula_opcode, zero=>zero_flag, output=>ula_out);

  --ACCUMULATOR
  acc_in<=ext_imm when TODO else
          dr_out_a when TODO else
          ula_out;
  acc: regb16 port map(clk=>acc_clk, rst=>rst, wr_en=>'1', d_in=>acc_in, d_out=>acc_out);

end architecture;
