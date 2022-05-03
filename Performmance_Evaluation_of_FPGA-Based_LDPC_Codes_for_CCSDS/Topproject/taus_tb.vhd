library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity taus_tb is

end entity;
architecture Behavioral of taus_tb is
		
component topbit Is
	Port
	(
		RstB		: in	std_logic;			-- use push button Key0 (active low)
		Clk50		: in	std_logic;
		
		sourceValid			: in std_logic;
		
		
		output         : out STD_LOGIC ;
		enable_out            : out STD_LOGIC
		
	);
End component topbit;

		


constant PERIOD : time := 20 ns;









signal RstB		: 	std_logic;			-- use push button Key0 (active low)   
signal  Clk50		: 	std_logic;                                         
                                                               
signal sourceValid			:  std_logic;                                  
                                                               
                                                               
signal output         : STD_LOGIC;         
signal enable_out            : STD_LOGIC    ;                      
                                                               






 
 signal TM : integer	range 0 to 65535;
signal TT : integer	range 0 to 65535;

begin 

u2 : topbit
port map 
(
RstB		    =>    RstB, 
 Clk50		    =>   Clk50,
              
sourceValid	    => sourceValid	,
             
             
output      => output  ,
enable_out    => enable_out 



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
		Clk50	<= '1';
		wait for PERIOD/2;
		Clk50	<= '0';
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
		wait until rising_edge(clk50);
		sourceValid	<= '1';
		
		
		
		TM <= 255; wait for 1 ns;
		wait for 20*PERIOD;
		wait;



end process u1;
	
end architecture;