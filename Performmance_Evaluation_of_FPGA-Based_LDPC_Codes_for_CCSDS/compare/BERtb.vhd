library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity BERtb is

end entity;
architecture Behavioral of BERtb is
component  BER Is
   Port ( 
	        Clk : in  STD_LOGIC;
            Rst : in  STD_LOGIC;
            
            data_in : in std_logic;
			data_in1 : in std_logic;
			data_in_valid : in std_logic;
			data_in1_valid : in std_logic;
		
		
			data_out : out std_logic_vector(7 downto 0)
			 );
end component  BER ;

constant PERIOD : time := 20 ns;

signal Clk 			: std_logic:='1';
signal Rst			: std_logic;
signal data_in 		:  std_logic;
signal data_in1 	:  std_logic;
signal data_in_valid : std_logic; 
signal data_in1_valid : std_logic; 
signal data_out : std_logic_vector(7 downto 0);	


	
signal TM : integer	range 0 to 65535;
signal TT : integer	range 0 to 65535;
	
begin

u2 : BER
port map 
(
Clk 		=> Clk		,
Rst 		=> Rst 		,
data_in 	=> data_in 	,
data_in1    => data_in1 ,
data_in_valid    => data_in_valid  ,
data_in1_valid  => data_in1_valid  ,
data_out =>data_out
);

u_rst : Process
	Begin
		rst	<= '0';
		wait for 20*PERIOD;
		rst	<= '1';
		wait;
	End Process u_rst;

	u_Clk : Process
	Begin
		clk		<= '1';
		wait for PERIOD/2;
		clk		<= '0';
		wait for PERIOD/2;
	End Process u_Clk;
	
	u1 : process
begin
	-------------------------------------------
		-- TM=0 : Reset and Initial Value
		-------------------------------------------
		TM <= 0; TT <= 0; wait for 10 ns;
		Report "TM=" & integer'image(TM) & " TT=" & integer'image(TT); 
		data_in	<= '0';
		data_in1	<= '0';
		data_in_valid  <= '0';
		data_in1_valid  <= '0';
		
		wait for 10*PERIOD;

		-------------------------------------------
		-- TM=1 : Senddata
		-------------------------------------------	
		TM <= 1; TT <= 0; wait for 1 ns;
		Report "TM=" & integer'image(TM) & " TT=" & integer'image(TT); 
wait until rising_edge(rst);
		data_in	<= '1';
		data_in1 <= '1';
		data_in_valid  <= '1';
		data_in1_valid  <= '1';
wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '1';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
        data_in	<= '1';
		data_in1 <= '1';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
        data_in	<= '1';
		data_in1 <= '1';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';
wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '0';
		data_in1 <= '0';

wait until rising_edge(clk);
		data_in	<= '1';
		data_in1 <= '1';

wait until rising_edge(clk);

data_in_valid  <= '0';
data_in1_valid  <= '0';

 TM <= 255; wait for 1 ns;
		wait for 20*PERIOD;
		wait;



end process u1;
	
end architecture;