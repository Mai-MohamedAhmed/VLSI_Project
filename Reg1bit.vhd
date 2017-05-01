LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Reg1bit IS
	PORT( Clk,Rst : IN std_logic;
	       En : IN std_logic;
		  d : IN  std_logic;
		  q : OUT std_logic);
END entity Reg1bit;

ARCHITECTURE a_Reg OF Reg1bit IS
	BEGIN
		PROCESS (Clk,Rst)
			BEGIN
				IF Rst = '1' THEN
					q <= '0';
				ELSIF rising_edge(Clk) and En='1' THEN
					q <= d;
				END IF;
		END PROCESS;
END a_Reg;


