library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity noisegen_toptb  is

end entity;
architecture Behavioral of noisegen_toptb  is
component noisegen_top Is
  Port ( 
	        CLK_in : in  STD_LOGIC;
           RST_in : in  STD_LOGIC;
			  
			  LED_OUT      : out STD_LOGIC_VECTOR(7 downto 0);
			  SWITCH_IN    : in  std_logic_vector(3 downto 0);	
			  
			  cnt : out STD_LOGIC;
			  data_new : out STD_LOGIC_VECTOR (15 downto 0)
			  
			 );
end component noisegen_top;

constant PERIOD : time := 20 ns;

signal CLK_in : std_logic ;
signal RST_in : std_logic;
signal  LED_OUT      :  STD_LOGIC_VECTOR(7 downto 0);
 signal  SWITCH_IN    :  std_logic_vector(3 downto 0)  := (others => '0')	;
signal  cnt :  STD_LOGIC;
signal data_new :  STD_LOGIC_VECTOR (15 downto 0);
 
 signal TM : integer	range 0 to 65535;
signal TT : integer	range 0 to 65535;

begin 

u2 : noisegen_top
port map (
CLK_in => CLK_in,
RST_in => RST_in,
LED_OUT  => LED_OUT ,
SWITCH_IN => SWITCH_IN,
cnt => cnt,
data_new => data_new
);


u_rst : Process
	Begin
		RST_in	<= '1';
		wait for 20*PERIOD;
		RST_in	<= '0';
		wait;
	End Process u_rst;

	u_Clk : Process
	Begin
		CLK_in	<= '0';
		wait for PERIOD/2;
		CLK_in	<= '1';
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
		
		
		 TM <= 255; wait for 1 ns;
		wait for 20*PERIOD;
		wait;



end process u1;
	
end architecture;