library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity BER is
    Port ( 
	        clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            data_in : in std_logic;
            data_in_valid : in std_logic;
            
            data_in1 : in std_logic;
            data_in1_valid : in std_logic;
            
            
            data_out : out std_logic_vector(7 downto 0) ;
            TxFfEmpty : out std_logic
            
					 );
end BER;

architecture Behavioral of BER is 
signal rdata : std_logic;
signal rTxFfEmpty  : std_logic;
signal rcnt : std_logic_vector(7 downto 0);
signal cntValid  : std_logic_vector(10 downto 0);



begin
u_data : process(clk)
begin
if(rising_edge(clk)) then
        if (rst = '0') then
            rdata <= '0';
        else
            rdata <= data_in xor data_in1;
        end if;
  end if;

end process u_data;
u_cnt : process(clk)
begin
if(rising_edge(clk)) then
        if (rst = '0') then
            rcnt <= (others => '0');
        else
            if(rdata= '1') then
                rcnt <= rcnt + 1;
            else
                rcnt <=rcnt;
            end if;
        end if;
  end if;

end process u_cnt;

u_cntValid : process(clk)
begin
if(rising_edge(clk)) then
        if (rst = '0') then
            cntValid <= (others => '0');
        else
            if(data_in_valid = '1' and data_in_valid ='1') then
                cntValid <= cntValid + 1;
            else
                cntValid <=cntValid;
            end if;
        end if;
  end if;
 end process u_cntValid;
 
 u_TxFfEmpty: process(clk)
begin
if(rising_edge(clk)) then
        if (rst = '0') then
            rTxFfEmpty <= '1';
        else
            if(cntValid= 27) then --follow length data
                rTxFfEmpty <= '0';
            else
                rTxFfEmpty <= rTxFfEmpty ;
            end if;
        end if;
  end if;
 end process u_TxFfEmpty;
 
 
TxFfEmpty<=rTxFfEmpty ;

data_out <= rcnt;




	

end architecture;