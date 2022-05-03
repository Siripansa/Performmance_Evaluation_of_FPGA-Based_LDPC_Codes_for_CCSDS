library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity serial is
    Port ( 
	        clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            data_in : in std_logic_vector(31 downto 0);
            enable_in : in std_logic;
            
			data_out : out STD_LOGIC;
			enable_out : out std_logic

			 );
end serial;

architecture Behavioral of serial is
signal cnt : std_logic_vector(12 downto 0);
signal r1024 : STD_LOGIC_VECTOR (1023 downto 0);
signal rs1024 : STD_LOGIC_VECTOR (1023 downto 0);

signal renable_out : std_logic ;
signal shif : std_logic ;



begin
 

u_r1024: process(clk) is
Begin
	if(rising_edge(clk)) then
		if(rst ='0') then
			r1024 <= (others => '0');
		else
			if (enable_in = '1') then
				r1024(1023 downto 0) <= r1024(991 downto 0)  & data_in   ;
			else
				r1024(1023 downto 0) <=r1024(1023 downto 0) ;
			
			end if;
		end if;
	end if;
End Process u_r1024;



enable_out <= renable_out ;

u_shif : process(clk)is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            shif  <=  '0';
        else
            if (cnt = 33) then
                shif  <= '1' ;
            elsif (cnt = 34) then
				shif <= '0' ;
			else
                shif <= shif ;
             end if;
        end if;
   end if;
  end process u_shif;


u_cnt : process(clk) is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            cnt  <= (others => '0');
        else
            if (enable_in = '1') then
                cnt  <= cnt +1 ;
            else
                cnt <= cnt ;
             end if;
        end if;
    end if;
	
 end process u_cnt;

data_out <= rs1024(0);



u_rs1024 : process(clk) is
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            rs1024  <= (others => '0');
        else
            if (shif  = '1') then
                rs1024  <= r1024(1023 downto 0) ;
                   
                
            else
                rs1024 <= '1' & rs1024(1023 downto 1) ;
             end if;
        end if;
    end if;
 end process u_rs1024 ;  





u_renable_out : process(clk,rst)
 begin
    if(rising_edge(clk)) then
        if (rst = '0') then
            renable_out  <= '0';
        else
            if (cnt = 35) then
                renable_out  <= '1' ;
            elsif (cnt = 1058) then
                renable_out <= '0' ;
            end if;
        end if;
    end if;
 end process u_renable_out;  


end architecture;