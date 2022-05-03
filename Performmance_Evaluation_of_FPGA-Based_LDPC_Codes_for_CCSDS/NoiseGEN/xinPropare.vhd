----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:55 03/15/2021 
-- Design Name: 
-- Module Name:    xinPropare - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xinPropare is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           xin : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp3 : out  STD_LOGIC_VECTOR (55 downto 0);
           xinp2 : out  STD_LOGIC_VECTOR (55 downto 0);
           xinp1 : out  STD_LOGIC_VECTOR (55 downto 0);
			  --
			  xinp1mul_next1tm  : out  STD_LOGIC_VECTOR (55 downto 0);
           xinp2_nexttm  : out  STD_LOGIC_VECTOR (55 downto 0)
			  );
end xinPropare;

architecture Behavioral of xinPropare is

   signal xinp2_tm,xinp3_tm		  : STD_LOGIC_VECTOR (111 downto 0);
	signal xinp1_next1              : STD_LOGIC_VECTOR (55 downto 0);	
	signal xinp2_next               : STD_LOGIC_VECTOR (55 downto 0);
	signal xinp3_next,xinp2_next1   : STD_LOGIC_VECTOR (55 downto 0);
	signal xinp1_next2              : STD_LOGIC_VECTOR (55 downto 0);
	
	-- signal xin: STD_LOGIC_VECTOR (55 downto 0):="00000000000000101000111101011100001010001111010111000011";
begin


-- xin^3, xin^2 and xin calculation from now -----------------------

  xinp2_tm<=xin*xin;
  process(RST,CLK,xinp2_tm,xin)
  begin
  if (RST='1') then
      xinp2_next  <= (others=>'0');
		xinp1_next1 <= (others=>'0');
  elsif (CLK'event and CLK='1') then
		xinp2_next  <= xinp2_tm(103 downto 48); -- 56 bits 93+10 downto 38+10
		xinp1_next1 <= xin;							-- 48 bits
  end if;
  end process;
  
  xinp1mul_next1tm<=xinp1_next1;
  xinp2_nexttm<=xinp2_next;
  
  xinp3_tm   <=xinp2_next*xinp1_next1;
  process(RST,CLK,xinp3_tm,xinp2_next,xinp1_next1)
  begin
  if (RST='1') then
      xinp3_next  <= (others=>'0');
		xinp2_next1 <= (others=>'0');
		xinp1_next2 <= (others=>'0');
  elsif  (CLK'event and CLK='1') then
		xinp3_next     <= xinp3_tm(103 downto 48);  -- 48 bits
		xinp2_next1    <= xinp2_next;
		xinp1_next2  	<= xinp1_next1; 
  end if;
  end process;
  
  
  
  process(RST,CLK,xinp3_tm,xinp2_next,xinp1_next1)
  begin
  if (RST='1') then
      xinp3  <= (others=>'0');
		xinp2 <= (others=>'0');
		xinp1 <= (others=>'0');
  elsif (CLK'event and CLK='1') then
		xinp3        <= xinp3_next;
		xinp2        <= xinp2_next1;
		xinp1        <= xinp1_next2; 
  end if;
  end process;

end Behavioral;

