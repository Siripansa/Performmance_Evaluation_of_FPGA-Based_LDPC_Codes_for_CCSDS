----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:02:50 05/06/2021 
-- Design Name: 
-- Module Name:    minustwoXlog - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity minustwoXlog is
    Port ( CLK_IN : in  STD_LOGIC;
           RST_IN : in  STD_LOGIC;
           MinusXlogOut_next : out  STD_LOGIC_VECTOR (31 downto 0));
end minustwoXlog;

architecture Behavioral of minustwoXlog is

 

	component logCal_top is
    Port ( CLK : in  STD_LOGIC;
	        RST : in  STD_LOGIC;
           xin : in  STD_LOGIC_VECTOR (47 downto 0);
			  MUXoutSL_out : out  STD_LOGIC;
--			  
--			  poly_512_outdm : out   STD_LOGIC_VECTOR (31 downto 0);
--			  polyOutdm      : out   STD_LOGIC_VECTOR (31 downto 0);
--			  xin_nexttm     : out   STD_LOGIC_VECTOR (47 downto 0);
--			  
--			  xinp1mul_next1tm  : out  STD_LOGIC_VECTOR (55 downto 0);
--			  xinp2_nexttm  : out  STD_LOGIC_VECTOR (55 downto 0);
--			  
--			  xin_preparetm  : out   STD_LOGIC_VECTOR (55 downto 0);
--			  
--			  xinp1_tm       : out   STD_LOGIC_VECTOR (55 downto 0);
--           CoEf1_next1tm  : out   STD_LOGIC_VECTOR (55 downto 0);
--			  
           logOut : out  STD_LOGIC_VECTOR (31 downto 0) -- fi(x,1,32,24)
			  );
	end component logCal_top;
	
	component twoTausURNGs is
   Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           dataTolog : out  STD_LOGIC_VECTOR (47 downto 0);
           dataTocossin : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
   end component twoTausURNGs;
	
	signal dataTolog          : STD_LOGIC_VECTOR(47 downto 0);
	signal logOut,logOut_next : STD_LOGIC_VECTOR(31 downto 0);
	signal MinusXlogOut :  STD_LOGIC_VECTOR (31 downto 0);
	
	
	signal CLK,RST:  STD_LOGIC;
   



begin


   BUFG_inst : BUFG
   port map (
      O => CLK, -- 1-bit output: Clock buffer output
      I => CLK_in  -- 1-bit input: Clock buffer input
   );
	
--	

reset_inst : ibuf
    generic map (
      IOSTANDARD => "LVCMOS25")
    port map (
      o => RST,
      i => RST_IN); -- logic '1'
		
		


 twoTausURNGs_inst : twoTausURNGs
   Port map
	( CLK          => CLK,
     RST          => RST,
     dataTolog    => dataTolog,
     dataTocossin => open
	 );

 logCal_top_inst:  logCal_top
    Port map 
	 ( 
	        CLK               =>CLK,
	        RST               =>RST,
           xin               =>dataTolog,
			  
--			  MUXoutSL_out      =>open,--			  
--			  poly_512_outdm    =>open,
--			  polyOutdm         =>open,
--			  xin_nexttm        =>open,			  
--			  xinp1mul_next1tm  =>open,
--			  xinp2_nexttm      =>open,			  
--			  xin_preparetm     =>open,			  
--			  xinp1_tm          =>open,
--           CoEf1_next1tm     =>open,--			  
			  
           logOut           =>logOut
	 );
	 
	
	---
   process(CLK)
	begin
	if (CLK'event and CLK='1') then
	logOut_next<=logOut;
	end if;
	end process;
	
	
	TwoComplements: process(logOut)
	begin
	MinusXlogOut<= (not (logOut_next)) +'1';
	end process;
	
	
	process(CLK,RST)
	begin
	if (RST='1') then
	MinusXlogOut_next<=(others=>'0');
	elsif (CLK'event and CLK='1') then
	MinusXlogOut_next<=MinusXlogOut(30 downto 0)&'0';
	end if;
	end process;

end Behavioral;

