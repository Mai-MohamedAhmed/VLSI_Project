LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Cache IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(7 DOWNTO 0);
		datain  : IN  std_logic_vector(7 DOWNTO 0);
		dataout : OUT std_logic_vector(7 DOWNTO 0));
END ENTITY Cache;

ARCHITECTURE mem_a OF Cache IS

	TYPE mem_type IS ARRAY(0 TO 255) OF std_logic_vector(7 DOWNTO 0);
	SIGNAL mem : mem_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						mem(to_integer(unsigned(address))) <= datain;
					end if;
				END IF;
		END PROCESS;
		dataout <= mem(to_integer(unsigned(address)));
END mem_a;



