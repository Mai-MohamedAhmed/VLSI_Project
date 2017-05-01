library ieee;
use ieee.std_logic_1164.all;

ENTITY statemachine IS
	PORT( 	C1 :IN std_logic_vector(7 DOWNTO 0);
		C2: IN std_logic_vector(2 DOWNTO 0);
		C5: IN std_logic_vector(1 DOWNTO 0);
		move_done,sign,reset,Ack,clk,start: IN std_logic;
		EnC1,EnC2,EnC5,RstC2,RstC1,RstAccum,DirEn,OldEn,PEn,AEn,S4,mov,Done,DMAstart,OldRst,DirRst,CRst,PRst: OUT std_logic;
		S1S2S3: OUT std_logic_vector(2 DOWNTO 0));
END statemachine;

ARCHITECTURE SM OF statemachine IS

type state_type is (s0,s1,s2,pixel,inc,dec,add16,sub16,end_compute,compare,move,wait_move,finish);
signal state: state_type;
signal flag: std_logic;

begin 

state_proc:process (clk,reset)
begin 
	if reset='1' then
		state<=s0;
	elsif rising_edge(clk) then
		case state is
		  when s0 =>
		    flag<='0';
		    CRst<='1';
		    PRst <= '1';
		    DirRst<='1';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='1';
				RstC1<='1';
				DirEn<='0';
				OldEn<='0';
				OldRst<='1';
				PEn<='0';
				AEn<='0';
				S4<='0';
				Done<='0';
				mov<='0';
				DMAstart<='0';
				S1S2S3<="000";
				if start<='1' then
					state<=s1;
					else state<=s0;
				end if;
				
			when s1 =>
			  flag<='0';
			  		    CRst<='0';
			  		    PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='1';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				S4<='0';
				Done<='0';
				mov<='0';
				DMAstart<='0';
				S1S2S3<="000";
				if Ack='1' then
					state<=s2;
				else state<=s1;
				end if;
			when s2 =>
			  if flag='0' then 
			  RstC1<='1';
			  flag<='1';
				else RstC1 <= '0';
				 end if;
			  
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='1';
				EnC2<='1';
				EnC5<='0';
				RstC2<='1';
				
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				S4<='0';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="000";
				state<=pixel;
			when pixel=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='1';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='1';
				AEn<='0';
				S4<='0';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="001";
				state<=inc;
			when inc=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='1';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='1';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="000";
				if C1(3 downto 0) ="1111" then
					S4<='1';
				else S4<='0';
				end if;
				state<=dec;
			when dec=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='1';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='1';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="010";
				state<=add16;
				if C1(3 downto 0) ="0000" then
					S4<='1';
				else S4<='0';
				end if;
				
			when add16=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='1';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='1';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="100";
				if C1(7 downto 4) ="1111" then
					S4<='1';
				else S4<='0';
				end if;
				state<=sub16;
			when sub16=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='1';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='1';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="110";
				if C1(7 downto 4) ="0000" then
					S4<='1';
				else S4<='0';
				end if;
				if C1<"11111111" then
					state<=s2;
				elsif C1="11111111" then
					state<=end_compute;
				end if;
			when end_compute=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='1';
				RstC2<='0';
				RstC1<='1';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="000";
				state<=compare;
			when compare=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='0';
				RstC1<='1';
				DirEn<='1';
				OldEn<='1';
				PEn<='0';
				AEn<='0';
				mov<='0';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="000";
				if sign='1' and C5="11" then
					state<=finish;
				elsif C5<"11" then
					state<=move;
				end if;
			when move=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				mov<='1';
				Done<='0';
				DMAstart<='0';
				S1S2S3<="000";
				state<=wait_move;
			when wait_move=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				mov<='0';
				Done<='0';
				S1S2S3<="000";
				if move_done='0' then
					state<=wait_move;
				else 
					DMAstart<='1';
					state<=s1;
				end if;
			when finish=>
			  flag<='1';
			  CRst<='0';
			  PRst <= '0';
		    DirRst<='0';
			  OldRst<='0';
				RstAccum<='0';
				EnC1<='0';
				EnC2<='0';
				EnC5<='0';
				RstC2<='0';
				RstC1<='0';
				DirEn<='0';
				OldEn<='0';
				PEn<='0';
				AEn<='0';
				mov<='0';
				DMAstart<='0';
				S1S2S3<="000";
				Done<='1';
		end case;
	end if;
end process;

END SM;
