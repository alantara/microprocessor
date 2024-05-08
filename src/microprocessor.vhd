library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor is
  port(
  clk, rst: in std_logic;
  deb_ula: out unsigned(15 downto 0)
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
    port(clk : in std_logic;
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
    port(instr : in unsigned(31 downto 0);
    clk, rst : in std_logic;
    is_jmp : out std_logic);
  end component;

  signal output_ula, output_reg_a, output_reg_b, output_mux_ula: unsigned(15 downto 0) := "0000000000000000";

  signal address : unsigned(7 downto 0) := "00000000";
  signal instruction : unsigned(31 downto 0) := "00000000000000000000000000000000";
  signal out_pc_mux, pc_mux_in0, pc_mux_in1  : unsigned(7 downto 0) := "00000000";
  signal is_jmp : std_logic := '0';
  signal immediate : unsigned(15 downto 0) := "0000000000000000";

begin

  data_reg: data_register port map(
                                    sel_a=>instruction(15 downto 13),
                                    sel_b=>instruction(12 downto 10),
                                    data_wr=>output_ula,
                                    sel_wr=>instruction(9 downto 7),
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

  immediate <= instruction(31 downto 16);

  output_mux_ula <= output_reg_b; 

  cu : control_unit port map(clk => clk, rst => rst, is_jmp => is_jmp, instr => instruction);
  
  rm : rom port map(clk, address, data => instruction);

  pc_mux_in1 <= immediate(7 downto 0);
  out_pc_mux <= pc_mux_in0 when is_jmp='0' else pc_mux_in1;


  p : pc port map(clk, rst, wr_en => '1', data_in => out_pc_mux, data_out => address);

  p1 : plus_one port map (data_in => address, data_out => pc_mux_in0);

  deb_ula <= output_ula;
end architecture;
