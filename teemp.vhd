LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use ieee.numeric_std.all;
ENTITY absDiff IS
	
	PORT( 
		  A,B : IN  std_logic_vector(7 DOWNTO 0);
		  Q : OUT std_logic_vector(7 DOWNTO 0));
END absDiff;

ARCHITECTURE t OF absDiff IS
component my_nadder IS
       GENERIC (n : integer := 16);
PORT(a,b : IN std_logic_vector(n-1  DOWNTO 0);
             cin : IN std_logic;  
            s : OUT std_logic_vector(n-1 DOWNTO 0);  
           cout : OUT std_logic);
END component;
signal Contrast,bcomp,resComp,contComp: std_logic_vector(7 DOWNTO 0);
signal c1,c2: std_logic;
	BEGIN
Bcomp<=not B;
contComp<=not contrast;
add: my_nadder generic map (8 ) port map (A,Bcomp,'1',contrast,c1); --add 2's complement
add2: my_nadder generic map (8 ) port map (contComp,(others=>'0'),'1',resComp,c2);--2's complement of result
process(c1,resComp,contrast)
begin
 		 if (c1='0') then
			Q<=resComp;
		else Q<=contrast;
		end if;
end process;
END t;
