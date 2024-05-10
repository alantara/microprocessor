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
    rs1, rs2: in unsigned(2 downto 0);
    data_wr: in unsigned(15 downto 0);
    rd: in unsigned(2 downto 0);
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
    pc_clk, rom_clk: out std_logic;
    jmp_en: out std_logic
  );
  end component;

  --PC
  signal pc_wr_data:unsigned(5 downto 0) := "000000";
  signal pc_address: unsigned(5 downto 0) := "000000";

  --PLUS ONE
  signal po_data_out: unsigned(5 downto 0);

  --ROM
  signal instruction: unsigned(15 downto 0) := "0000000000000000";
  
  --UC
  signal pc_clk, rom_clk: std_logic := '0';
  signal jmp_en: std_logic := '0';

  signal immediate : unsigned(5 downto 0) := "000000";

  signal output_ula, output_reg_a, output_reg_b, output_mux_ula: unsigned(15 downto 0) := "0000000000000000";

begin

  program_counter: pc port map(clk=>pc_clk, rst=>rst, wr_en=>'1', data_in=>pc_wr_data, data_out=>pc_address);

  pc_wr_data<=po_data_out when jmp_en='0' else instruction(15 downto 10);

  po: plus_one port map(data_in=>pc_address, data_out=>po_data_out);

  mem: rom port map(clk=>rom_clk, address=>pc_address, data=>instruction);

  data_reg: data_register port map(
                                    rs2=>instruction(12 downto 10),
                                    rs1=>instruction(9 downto 7),
                                    data_wr=>output_ula,
                                    rd=>instruction(6 downto 4),
                                    clk=>clk,
                                    rst=>rst,
                                    wr_en=>'1',
                                    output_a=>output_reg_a,
                                    output_b=>output_reg_b
                                  );

  ula2: ula port map(
                      a=>output_reg_a,
                      b=>output_mux_ula,
                      opcode=>"000",
                      output=>output_ula
                    );

  uc: control_unit port map(instruction, clk, rst, pc_clk, rom_clk, jmp_en);

  immediate <= instruction(15 downto 10);

end architecture;
