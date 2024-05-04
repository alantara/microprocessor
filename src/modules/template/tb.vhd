library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
   signal clk, rst: std_logic := '0';
   constant period_time: time := 100 ns;
   signal finished: std_logic := '0';

  -- DECLARAR COMPONENTS E SIGNALS AQUI

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
   
   -- INSTANCIAR COMPONENTE AQUI

   process
   begin
   
   -- COLOCAR CASOS DE TESTE AQUI

   wait;
end process;

end architecture;
