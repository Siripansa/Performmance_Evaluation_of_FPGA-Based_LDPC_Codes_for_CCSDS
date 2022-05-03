library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;




Entity topBER Is
	Port
	(
		RstB		: in	std_logic;			-- use push button Key0 (active low)
		Clk50		: in	std_logic;
		
		 data_in : in std_logic;
            data_in1 : in std_logic;
            data_in_valid   : in std_logic;
		     data_in1_valid   : in std_logic;
		
		
		data_out : out std_logic_vector(7 downto 0)
		
	);
End Entity topBER;

Architecture rtl Of topBER Is

	

	
	
	Component BER is
    Port ( 
	        clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            data_in : in std_logic;
            data_in1 : in std_logic;
            data_in_valid   : in std_logic;
		     data_in1_valid   : in std_logic;
            
            data_out : out std_logic_vector(7 downto 0) 
            
					 );
	End Component BER;
	
	
	
	
	
    
    

	
	
	
	
	
	
----------------------------------------------------------------------------------
-- Signal declaration
----------------------------------------------------------------------------------
		
--bit	
	signal runiformRandomSequence : std_logic_vector(31 downto 0) ;
	signal rdata_in_valid           : std_logic;
--serial
    signal rserial          : std_logic;
    signal rserialvalid         : std_logic;
    
	
	signal rdata_out           : std_logic_vector(7 downto 0);
--tx
	signal  rTxFfEmpty         : std_logic;

	
Begin
----------------------------------------------------------------------------------
-- Output assignment
----------------------------------------------------------------------------------
	
    
	U_BER : BER
    Port map
	( 
	        clk 		=> Clk50,
            rst 		=> RstB,
            data_in 	=> data_in , 
            data_in1 	=>  data_in1          , 
            data_in_valid  	=> data_in_valid    , --bit
            data_in1_valid  	=> data_in1_valid  ,
		
						
            data_out 	=> data_out
           
	 );
	
	
   

	
			 
			 
	
	
	
	
End Architecture rtl;



