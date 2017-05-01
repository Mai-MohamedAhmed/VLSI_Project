LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--USE IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;
use ieee.numeric_std.all;
ENTITY Trial IS  
		PORT (
		  clk: in std_logic;
		  Rst: in std_logic
		--a: in std_logic_vector(7 downto 0);
		--b: in std_logic_vector(7 downto 0);
		--c: out std_logic_vector(7 downto 0)
		      );    
END ENTITY Trial;


ARCHITECTURE c_a OF Trial IS
  component counter IS  
  GENERIC(n : positive);
		PORT (
		clk,Rst,En: IN  std_logic;
		q: OUT std_logic_vector(n-1 DOWNTO 0)
--q: out std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0)
		      );    
END component;

--signal POut: std_logic_vector(7 downto 0);
--signal sign : std_logic;
signal EnSig : std_logic;
signal C1Out: std_logic_vector(2 downto 0);
signal rst1,rst2: std_logic;
--signal temp: std_logic_vector(2 downto 0);
BEGIN
 --rst1 <= '1' when C1Out = "101"
 -- else '0';
 --rst2 <= Rst or rst1;   
  count: counter generic map (3) port map(clk,Rst,EnSig,C1Out);
  --temp <= "100";
--POut <= std_logic_vector(unsigned(a)-unsigned(b));
--sign <= POut(7);
--c<=POut; 
END c_a;

