----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:46 03/08/2021 
-- Design Name: 
-- Module Name:    CofROM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- fi(p,1,48,40).';
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CofROM is
    Port (
	   CLK  : in std_logic;
      RST   : in std_logic;
      ADDR : in std_logic_vector(2 downto 0);
		CoEf1 : out std_logic_vector(55 downto 0);
	   CoEf2 : out std_logic_vector(55 downto 0);
	   CoEf3 : out std_logic_vector(55 downto 0);
		CoEf4 : out std_logic_vector(55 downto 0)
		);
end CofROM;


architecture CofROM of CofROM is

    type rom_type is array (0 to 27) of std_logic_vector (55 downto 0);                  
    constant  ROM : rom_type:= (X"5ABE0000000000", X"F7C7B333333333", X"00514A3D70A3D7",X"FFFD1339C0EBEE",   -- 1 p/512    pFi=fi(p,1,56,48).';
	 	 
	                             X"06D74CCCCCCCCD", X"FE92251EB851EC", X"002169FBE76C8B",X"FFFD86F9DB22D1",   -- 2 p/512										  
										  
										  X"00DA8B851EB852", X"FFA4A3D70A3D71", X"0010B28F5C28F6",X"FFFDDFC504816F",   -- 3 p/512										  
										  
									     X"001B5083126E98", X"FFE9299999999A", X"00085916872B02",X"FFFE387FCB923A",   -- 4 p/512											  
										  
                                X"06D404EA4A8C15", X"F494FDF3B645A2", X"0859096BB98C7E",X"FD227525460AA6",   -- 5										  
										  
									     X"01671DE69AD42C", X"FC113A92A30553", X"04DF34D6A161E5",X"FDADCC63F14120",   -- 6										  
										  
                                X"008122FAD6CB53", X"FE045A1CAC0831", X"0374538EF34D6A",X"FE062B6AE7D567"    -- 7
									  );    

									  

    signal CoEf1_tm, CoEf2_tm, CoEf3_tm, CoEf4_tm : std_logic_vector(55 downto 0);

begin


	 
	 process (RST,ADDR)
    begin
        if     (ADDR="000")  then           
		      CoEf1_tm <= ROM(0);
				CoEf2_tm <= ROM(1);
				CoEf3_tm <= ROM(2);
				CoEf4_tm <= ROM(3);
		  elsif  (ADDR="001")  then 
    		  CoEf1_tm <= ROM(4);
			  CoEf2_tm <= ROM(5);
			  CoEf3_tm <= ROM(6);
			  CoEf4_tm <= ROM(7);
		  elsif  (ADDR="010")  then 
		     CoEf1_tm <= ROM(8);
			  CoEf2_tm <= ROM(9);
			  CoEf3_tm <= ROM(10);
			  CoEf4_tm <= ROM(11);
		  elsif  (ADDR="011")  then 
		     CoEf1_tm <= ROM(12);
			  CoEf2_tm <= ROM(13);
			  CoEf3_tm <= ROM(14);
			  CoEf4_tm <= ROM(15);
		  elsif  (ADDR="100")  then 
		  	  CoEf1_tm <= ROM(16);
			  CoEf2_tm <= ROM(17);
			  CoEf3_tm <= ROM(18);
			  CoEf4_tm <= ROM(19);
		  elsif  (ADDR="101")  then 
		     CoEf1_tm <= ROM(20);
			  CoEf2_tm <= ROM(21);
			  CoEf3_tm <= ROM(22);
			  CoEf4_tm <= ROM(23);
		  else  --(110)
           CoEf1_tm <= ROM(24);
			  CoEf2_tm <= ROM(25);
			  CoEf3_tm <= ROM(26);
           CoEf4_tm <= ROM(27);			  
        end if;
    end process;

    process (CLK,RST)
    begin
        if (RST='1') then
	        CoEf1 <= (others=>'0');
			  CoEf2 <= (others=>'0');
			  CoEf3 <= (others=>'0');
           CoEf4 <= (others=>'0');			  
		  elsif (CLK'event and CLK = '1') then
           CoEf1 <= CoEf1_tm;
			  CoEf2 <= CoEf2_tm;
			  CoEf3 <= CoEf3_tm; 
			  CoEf4 <= CoEf4_tm; 
        end if;
    end process;


end CofROM;

