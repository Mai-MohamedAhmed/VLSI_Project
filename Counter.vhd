LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

ENTITY counter IS  
  GENERIC(n : natural:=2);
		PORT (
		clk,Rst,En: IN  std_logic;
		q: OUT std_logic_vector(n-1 DOWNTO 0)
--q: out std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0)
		      );    
END ENTITY counter;


ARCHITECTURE c_a OF counter IS
signal prev: std_logic_vector(n-1 downto 0);
BEGIN
  process(clk,Rst,En)
    --variable count: std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0) :=(others =>'0');
    begin
     if(Rst = '1') then
        --prev <= prev - prev;
        prev <= (others=>'0');
      elsif(rising_edge(clk) and En='1') then 
        if En = '1' then
          prev <= prev + 1;
        end if;
      end if;
    end process;
    q <= prev;
    
END c_a;