library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
   signal clk, rst: std_logic := '0';
   constant period_time: time := 100 ns;
   signal finished: std_logic := '0';

  component pc is 
    port(wr_en, clk, rst : in std_logic;
    data_in, data_out : out unsigned(7 downto 0));
  end component;

  signal data_in, data_out : unsigned(7 downto 0) := "00000000";
  signal wr_en : std_logic := '0';

begin
   sim_time_proc: process
   begin
     wait for 5 us;
     finished <= '1';
     wait;
   end process;

   clk_proc: process
   begin
     while finished /= '1' loop
       clk <= '0';
       wait for period_time/2;
       clk <= '1';
       wait for period_time/2;
     end loop;
     wait;
   end process;
   
   program_counter : pc port map(wr_en, clk, rst, data_in, data_out);

   process
   begin
  
     rst <= '1'; wait for period_time; rst <= '0';
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wr_en <= '1';
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     rst <= '1';
     wait for period_time;
     wr_en <= '0';
     wait for period_time;
     wait for period_time;
     wr_en <= '1';
     wait for period_time;
     wait for period_time;
     wait for period_time;
     rst <= '0';
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wait for period_time;
     wr_en <= '0';

   wait;
end process;

end architecture;
