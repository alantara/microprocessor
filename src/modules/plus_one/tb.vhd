library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is end;

architecture arq of tb is
  constant period_time: time := 100 ns;

-- DECLARAR COMPONENTS E SIGNALS AQUI

  signal data_in: unsigned(15 downto 0) := "0000000000000000";
  signal data_out: unsigned(15 downto 0);

  component plus_one is
    port(
          data_in: in unsigned(15 downto 0);
          data_out: out unsigned(15 downto 0)
        );
  end component;

begin

  -- INSTANCIAR COMPONENTE AQUI

  uut: plus_one port map(data_in, data_out);


  process
  begin
    -- COLOCAR CASOS DE TESTE AQUI
    data_in<="0000000000000000"; wait for period_time;
    data_in<="0000000110100100"; wait for period_time;
    data_in<="0010101001001111"; wait for period_time;
    data_in<="1111111111111111"; wait for period_time;

    wait;
  end process;
end architecture;
