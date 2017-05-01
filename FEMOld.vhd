LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--USE IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;
use ieee.numeric_std.all;
ENTITY FEM IS  
		PORT (
		clk,Rst1,En1,Rst2,En2,S1,S2,S3,S4: IN  std_logic;
		ARst,AEn,PEn,PRst,ORst,OEn,DirRst,DirEn,CRst,CEn: In std_logic;
    CacheData: In std_logic_vector(7 downto 0);
    CacheAddress: Out std_logic_vector(7 downto 0);
    C1_Out: out std_logic_vector(7 downto 0);
    C2_Out: out std_logic_vector(2 downto 0);
    C_Out: out std_logic_vector(1 downto 0);
    DirOut: out std_logic
		      );    
END ENTITY FEM;


ARCHITECTURE f_a OF FEM IS
  component counter IS  
  GENERIC(n : positive);
		PORT (
		clk,Rst,En: IN  std_logic;
    q: out std_logic_vector(natural(ceil(log2(real(n))))-1 downto 0)
		      );    
END component;

component mux4 IS 
	 GENERIC (n : integer := 16);
	PORT ( a,b,c,d: IN  std_logic_vector (n-1 DOWNTO 0);
		   s : IN std_logic_vector (1 downto 0);
		   y : OUT std_logic_vector (n-1 DOWNTO 0));
END component;

component mux2 IS  
 GENERIC (n : integer := 16);
		PORT (a, b: IN  std_logic_vector(n-1 DOWNTO 0);
			S0: in std_logic;
		      x       : OUT std_logic_vector(n-1 DOWNTO 0));    
END component;

component mux2_bit IS  
		PORT (a, b: IN  std_logic;
			s0: in std_logic;
		      x: OUT std_logic);    
END component;

component Reg1bit IS
	PORT( Clk,Rst : IN std_logic;
	       En : IN std_logic;
		  d : IN  std_logic;
		  q : OUT std_logic);
END component;

Component Reg IS
	GENERIC ( n : integer := 16);
	PORT( Clk,Rst : IN std_logic;
	       En : IN std_logic;
		  d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END component;


Signal C1Out,AdjAdd,CacheAdd1,AdjData,Contrast: std_logic_vector(7 downto 0);
signal Inc,Dec,Add16,Sub16: std_logic_vector(7 downto 0);
signal AIn, AOut, OOut,diff: std_logic_vector(17 downto 0); 
signal select1 : std_logic_vector(1 downto 0);
signal POut: std_logic_vector(7 downto 0);
signal sign,DirOutSig,InvDir,MOut: std_logic;
BEGIN
  C1 : counter generic map (8) port map(clk,Rst1,En1,C1Out);
  C1_Out <= C1Out;
  Inc <= std_logic_vector(unsigned(c1Out)+1);
  Dec <= std_logic_vector(unsigned(c1Out)-1);
  Add16 <= std_logic_vector(unsigned(c1Out)+16);
  Sub16 <= std_logic_vector(unsigned(c1Out)-16);
  Select1 <= S2&S1;
  mux_1: mux4 generic map (8) port map(Inc,Dec,Add16,Sub16,Select1,AdjAdd);
  mux_2: mux2 generic map (8) port map(AdjAdd,C1Out,S3,CacheAdd1); 
  mux_3: mux2 generic map (8) port map(CacheAdd1,(others=>'0'),S4,CacheAddress); 
 -----------------------------------------------------------------------------------
  C2 : counter generic map (3) port map(clk,Rst2,En2,C2_Out);
 ------------------------------------------------------------------------------------
  Pixel: Reg generic map (8) port map(clk,PRst,PEn,CacheData,POut);
  mux_4: mux2 generic map (8) port map(CacheData,(others=>'0'),S4,AdjData);
  Contrast <= std_logic_vector(abs(signed(POut)- signed(AdjData)));
  AIn <= std_logic_vector(unsigned(AOut)+ unsigned(Contrast));
  Accum: Reg generic map (18) port map(clk,ARst,AEn,AIn,AOut);
  ---------------------------------------------------------------------------------------
  Old_Contrast: Reg generic map (18) port map(clk,ORst,OEn,AOut,OOut);
  diff <= std_logic_vector(unsigned(AOut)-unsigned(OOut));
  sign <= diff(17);
  -------------------------------------------------------------------------------
  InvDir <= not DirOutSig;
  muxDir : mux2_bit port map(DirOutSig,InvDir,sign,MOut);
  Dir: Reg1bit port map(clk,DirRst,DirEn,MOut,DirOutSig);
  DirOut <= DirOutSig;
  ---------------------------------------------------------------------------------
  Count: counter generic map (2) port map(clk,CRst,CEn,C_Out);
  -------------------------------------------------------------------------------
     
     
END f_a;