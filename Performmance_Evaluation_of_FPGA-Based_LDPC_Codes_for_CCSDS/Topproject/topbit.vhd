library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;




Entity topbit Is
	Port
	(
		RstB		: in	std_logic;			-- use push button Key0 (active low)
		Clk50		: in	std_logic;
		
		sourceValid			: in std_logic;
		
		
		output : out STD_LOGIC;
		enable_out : out STD_LOGIC
		
	);
End Entity topbit;

Architecture rtl Of topbit Is

	

	Component combined_Tausworthe_88 Is
	Port
	(
		RstB 								: in std_logic;
		Clk 								: in std_logic;
		sourceValid							: in std_logic;
		
		sourceReady							: out std_logic;
		sinkValid							: out std_logic;
		uniformRandomSequence 				: out std_logic_vector(31 downto 0)
	);
	End Component combined_Tausworthe_88;
	
	Component serial Is
	Port
	(
	   clk : in  STD_LOGIC;                                    
       rst : in  STD_LOGIC;                                 
       data_in : in std_logic_vector(31 downto 0);          
       enable_in : in std_logic;                            
                                                        
       data_out : out STD_LOGIC;                                     
       serial_out : out std_logic     
                                   

	);
	End Component serial;
	
	
	Component encode_dummy is
    Port ( clk          : in STD_LOGIC;
           rst          : in STD_LOGIC;
           
           encode_in :in STD_LOGIC;
           encode_valid : in STD_LOGIC;
           
           encode_out :out STD_LOGIC;
           out_valid  :out STD_LOGIC
           
           
           );
    End Component encode_dummy;
    
  
	
	
	
----------------------------------------------------------------------------------
-- Signal declaration
----------------------------------------------------------------------------------
		
	
	signal rsinkValid		: std_logic;
	signal runiformRandomSequence : std_logic_vector(31 downto 0);
	signal rdata_out           : STD_LOGIC;
	signal  renable_out           : std_logic;
	signal rstart              : std_logic;
    signal rRst              : std_logic;
	
Begin
----------------------------------------------------------------------------------
-- Output assignment
----------------------------------------------------------------------------------
	
    
	
	
	u_combined_Tausworthe_88: combined_Tausworthe_88
	Port map
	(
		RstB 					 => RstB ,
		Clk 					 => Clk50 ,
		sourceValid				 => sourceValid ,	
		sourceReady				 => open ,
		
		sinkValid				 => rsinkValid,
								 
		uniformRandomSequence    => runiformRandomSequence
		
		
	);
	
	U_serial : serial
	Port map 
	(
		clk 			=> Clk50 ,
        rst 			=> RstB ,
        data_in 		=> runiformRandomSequence,
        enable_in 		=> rsinkValid,
        data_out		=> rdata_out  ,
		serial_out 		=> renable_out  
		
	   
	
	);
	
	
	u_encode_dummy :  encode_dummy 
    Port map
    (       clk         => Clk50 ,
           rst          => RstB ,
                        
           encode_in    => rdata_out  ,
           encode_valid => renable_out  ,
                        
           encode_out   => output,
           out_valid    => enable_out
           
           
     );
    
           
   
    
 
	
	
			 
			 
	
	
	
	
End Architecture rtl;



