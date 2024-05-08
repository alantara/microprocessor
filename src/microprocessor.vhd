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
    sel_a, sel_b: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    sel_wr: in unsigned(2 downto 0);
    clk, rst, wr_en: in std_logic;
    output_a, output_b: out unsigned(15 downto 0) 
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
          address : in unsigned(7 downto 0);
          data : out unsigned(31 downto 0) 
        );
  end component;

  component pc is 
    port(
    clk, rst, wr_en: in std_logic;
    data_in: in unsigned(7 downto 0);
    data_out: out unsigned(7 downto 0)
  );
  end component;

  component plus_one is
    port(
          data_in: in unsigned(7 downto 0);
          data_out: out unsigned(7 downto 0)
        );
  end component;

  component control_unit is 
    port(
    instruction: in unsigned(31 downto 0);
    clk, rst : in std_logic;
    pc_clk, rom_clk: out std_logic;
    jmp_en: out std_logic
  );
  end component;

  --PC
  signal pc_wr_data:unsigned(7 downto 0) := "00000000";
  
  signal pc_address: unsigned(7 downto 0);

  --PLUS ONE
  signal po_data_out: unsigned(7 downto 0);

  --ROM
  signal instruction: unsigned(31 downto 0);
  
  --UC
  signal pc_clk, rom_clk: std_logic;
  signal jmp_en: std_logic;

begin

  program_counter: pc port map(clk=>pc_clk, rst=>rst, wr_en=>'1', data_in=>pc_wr_data, data_out=>pc_address);
  po: plus_one port map(data_in=>pc_address, data_out=>po_data_out);

  mem: rom port map(clk=>rom_clk, address=>pc_address, data=>instruction);

  uc: control_unit port map(instruction=>instruction, clk=>clk, rst=>rst, pc_clk=>pc_clk, rom_clk=>rom_clk, jmp_en=>jmp_en);

  pc_wr_data<=po_data_out when jmp_en='0' else
              instruction(31 downto 24);
end architecture;
