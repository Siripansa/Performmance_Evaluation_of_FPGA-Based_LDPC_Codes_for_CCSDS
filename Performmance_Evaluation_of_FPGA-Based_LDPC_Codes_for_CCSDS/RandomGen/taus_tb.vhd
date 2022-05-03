library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity taus_tb is

end entity;
architecture Behavioral of taus_tb is
component combined_Tausworthe_88 Is
  Port ( 
	   		RstB 								: in std_logic;
		Clk 								: in std_logic;
		sourceValid							: in std_logic;
		sourceReady							: out std_logic;
		sinkReady							: in std_logic;
		sinkValid							: out std_logic;
		
		uniformRandomSequence 				: out std_logic_vector(31 downto 0)
--			  data_out : out STD_LOGIC_VECTOR (16 downto 0)
			  
			 );
end component combined_Tausworthe_88;

constant PERIOD : time := 20 ns;

signal RstB 								:  std_logic;
signal		Clk 								:  std_logic;
signal		sourceValid							:  std_logic;
signal		sourceReady							:  std_logic;
signal		sinkReady							:  std_logic;
signal		sinkValid							:  std_logic;
		
signal		uniformRandomSequence 				:  std_logic_vector(31 downto 0);
 
 signal TM : integer	range 0 to 65535;
signal TT : integer	range 0 to 65535;

begin 

u2 : combined_Tausworthe_88
port map (
RstB => RstB,
Clk => Clk,
sourceValid  => sourceValid ,
sourceReady => sourceReady,
sinkReady => sinkReady,
sinkValid => sinkValid,
uniformRandomSequence => uniformRandomSequence

);


u_rst : Process
	Begin
		RstB	<= '0';
		wait for 20*PERIOD;
		RstB	<= '1';
		wait;
	End Process u_rst;

	u_Clk : Process
	Begin
		Clk	<= '1';
		wait for PERIOD/2;
		Clk	<= '0';
		wait for PERIOD/2;
	End Process u_Clk;
	
	u1 : process
begin
	-------------------------------------------
		-- TM=0 : Reset and Initial Value
		-------------------------------------------
		TM <= 0; TT <= 0; wait for 10 ns;
		Report "TM=" & integer'image(TM) & " TT=" & integer'image(TT); 
	
		
		wait for 10*PERIOD;

		-------------------------------------------
		-- TM=1 : Senddata
		-------------------------------------------	
		TM <= 1; TT <= 0; wait for 1 ns;
		Report "TM=" & integer'image(TM) & " TT=" & integer'image(TT); 
		 wait until rising_edge(clk);
		sourceValid	<= '1';
		 TM <= 255; wait for 1 ns;
		wait for 20*PERIOD;
		wait;



end process u1;
	
end architecture;