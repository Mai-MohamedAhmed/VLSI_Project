LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--USE IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;
use ieee.numeric_std.all;
ENTITY AF IS  
		PORT(
		  clk,Start,Ack,MoveDone,Rst: in std_logic;
		  StartAddress: in std_logic_vector(11 downto 0);
		  CacheData: in std_logic_vector(7 downto 0);
		  CacheAddress: out std_logic_vector(7 downto 0);
		  DMAAddress: out std_logic_vector(11 downto 0);
		  Mov,Dir,Done: out std_logic
		  
		  );    
END ENTITY AF;


ARCHITECTURE AF_a OF AF IS
component FEM IS  
		PORT (
		clk,Rst1,En1,Rst2,En2,S1,S2,S3,S4: IN  std_logic;
		ARst,AEn,PEn,Prst,ORst,OEn,DirRst,DirEn,CRst,CEn: In std_logic;
    CacheData: In std_logic_vector(7 downto 0);
    CacheAddress: Out std_logic_vector(7 downto 0);
    C1_Out: out std_logic_vector(7 downto 0);
    C2_Out: out std_logic_vector(2 downto 0);
    C_Out: out std_logic_vector(1 downto 0);
    DirOut: out std_logic
		      );    
END component;

component statemachine IS
	PORT( 	C1 :IN std_logic_vector(7 DOWNTO 0);
		C2: IN std_logic_vector(2 DOWNTO 0);
		C5: IN std_logic_vector(1 DOWNTO 0);
		move_done,sign,reset,Ack,clk,start: IN std_logic;
		EnC1,EnC2,EnC5,RstC2,RstC1,RstAccum,DirEn,OldEn,PEn,AEn,S4,mov,Done,DMAstart,OldRst,DirRst ,CRst, PRst: OUT std_logic;
		S1S2S3: OUT std_logic_vector(2 DOWNTO 0));
END component;
signal c1out: std_logic_vector(7 downto 0);
signal c2out: std_logic_vector(2 downto 0);
signal c5out: std_logic_vector(1 downto 0);
signal sign,en1,en2,en5,rst1,rst2,rstA,rstold,rstDir,rstP,enDir,enOld,enP,enA,s4,movsig,donesig,dmasig,dirout,CRst: std_logic;
signal s: std_logic_vector(2 downto 0);

BEGIN
  --Old Rst - dir rst - C rst?
  --reset !
  AF_components: FEM port map (clk,rst1,en1,rst2,en2,s(2),s(1),s(0),s4,rstA,enA,enp,rstP,rstold,enOld,RstDir,enDir,CRst,en5,CacheData,CacheAddress,c1out,c2out,c5out,dirout);
  control: statemachine port map (c1out,c2out,c5out,MoveDone,sign,Rst,Ack,clk,Start,en1,en2,en5,rst2,rst1,rstA,enDir,enOld,enP,enA,s4,movsig,donesig,dmasig,rstold,RstDir,CRst,rstP,s);
    
  DMAAddress <= startAddress;   
  Dir <= dirOut;   
END AF_a;

