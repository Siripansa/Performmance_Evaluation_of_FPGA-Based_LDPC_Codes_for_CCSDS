----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2022 05:11:10 PM
-- Design Name: 
-- Module Name: encode_dummy - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encode_dummy is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           encode_in :in STD_LOGIC;
           encode_valid : in STD_LOGIC;
           
           encode_out :out STD_LOGIC;
           out_valid  :out STD_LOGIC
           
           
           );
end encode_dummy;

architecture Behavioral of encode_dummy is

signal rencode_out :STD_LOGIC_VECTOR(1023 downto 0);
signal rs2048 :STD_LOGIC_VECTOR(2047 downto 0);
signal shif : std_logic ;
signal cnt : std_logic_vector(100 downto 0);
signal cntsh : std_logic_vector(100 downto 0);
begin

encode_out<= rs2048(0) ;

u_rs2048 : process(clk) is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            rs2048  <= (others => '0');
        else
            if (shif  = '1') then
                rs2048 <= rencode_out(1023 downto 0) & "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
                   
                
            else
                rs2048 <= '1' & rs2048 (2047 downto 1) ;
             end if;
        end if;
    end if;
 end process u_rs2048 ; 

u_encode_out:	Process	(Clk) is
	Begin
		if ( rising_edge(Clk)	) then
			if ( Rst = '0' ) then
				rencode_out	<=	(others => '0');
			else
			     if (encode_valid = '1') then
				    rencode_out	<= rencode_out(1022 downto 0) & encode_in;	
				else
				    rencode_out(1023 downto 0) <= rencode_out(1023 downto 0) ;
			
			end if;
			end if;
		end if;
	End Process u_encode_out;
	
u_shif : process(clk)is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            shif  <=  '0';
        else
            if (cnt = 1059) then
                shif  <= '1' ;
            elsif (cnt = 1060) then
				shif <= '0' ;
			else
                shif <= shif ;
             end if;
        end if;
   end if;
 
 End Process u_shif;
 
 u_cnt : process(clk) is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            cnt  <= (others => '0');
        else
				if ( cnt = 4096 ) then
						cnt <= (others => '0');
				elsif ( encode_valid = '1' ) then
						cnt <= cnt +1 ;
					
				else
						cnt <= cnt+1;
				End if;
			End if;
    end if;
	
 end process u_cnt;
 
 
 
 u_out_valid  : process(clk) is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            out_valid   <= '0';
        else
				if ( cnt = 1060 ) then
						out_valid  <= '1';
				elsif ( cnt = 3108 ) then
						out_valid  <= '0';
				End if;
			End if;
    end if;
	
 end process u_out_valid ;

end Behavioral;
