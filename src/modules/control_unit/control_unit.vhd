library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
  port(instr : in unsigned(31 downto 0);
      clk, rst : in std_logic;
      is_jmp : out std_logic);
end;

architecture arq of control_unit is

  component state_machine is 
    port(clk, rst : in std_logic;
         state : out std_logic);
  end component;

  signal opcode: unsigned(3 downto 0) := "0000";

  signal state : std_logic := '0';
  signal instruction : unsigned(31 downto 0) := "00000000000000000000000000000000";
begin
  sm : state_machine port map(clk, rst, state);
  
  instruction <= instr when state ='0' else instruction;

  opcode <= instr(3 downto 0);
  
  is_jmp <= '1' when opcode="1111" else '0';

  
end arq;
