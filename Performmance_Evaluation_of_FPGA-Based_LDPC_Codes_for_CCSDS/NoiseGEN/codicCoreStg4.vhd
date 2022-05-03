----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:41 02/19/2021 
-- Design Name:    Puntsri
-- Module Name:    codicCoreStg4 - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity codicCoreStg4 is
Port ( CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
	  );
end codicCoreStg4;

architecture Behavioral of codicCoreStg4 is

  signal xn1, yn1           : STD_LOGIC_VECTOR (31 downto 0);
  signal x1p, y1p, x1m, y1m : STD_LOGIC_VECTOR (31 downto 0);
  signal x1m_next, y1m_next : STD_LOGIC_VECTOR (31 downto 0);
  signal x1p_next,y1p_next  : STD_LOGIC_VECTOR (31 downto 0);
  signal x_next, y_next     : STD_LOGIC_VECTOR (31 downto 0);
  signal y_next1            : STD_LOGIC_VECTOR (31 downto 0);
  signal xout, yout         : STD_LOGIC_VECTOR (31 downto 0);
  signal xout_mux,yout_mux  : STD_LOGIC_VECTOR (31 downto 0);


begin

   ------------- stg begin -------------------------------------		
	xn1<=y_in(31)&y_in(31)&y_in(31)&y_in(31)&y_in(31 downto 4);   --- x = y/16
   yn1<=x_in(31)&x_in(31)&x_in(31)&x_in(31)&x_in(31 downto 4);   --- y = x/16
		
	stage1_plus_inst: process(xn1,yn1,x_in,y_in)
	begin
		x1p<=x_in+xn1;
		y1p<=y_in+yn1;
	end process;
	
	stage1_plusRegt_inst: process(CLK,RST)
	begin
	   if (RST='1') then
		   x1p_next<=(others=>'0');
			y1p_next<=(others=>'0');
		elsif (CLK'event and CLK='1') then
			x1p_next<=x1p;
			y1p_next<=y1p;
		end if;		
   end process;
	
	stage1_minus_inst: process(xn1,yn1,x_in,y_in)
	begin
		x1m<=x_in-xn1;
		y1m<=y_in-yn1;
	end process;
	
	stage1_minusRegt_inst: process(CLK,RST)
	begin
	if (RST='1') then
		   x1m_next<=(others=>'0');
			y1m_next<=(others=>'0');
	elsif(CLK'event and CLK='1') then
			x1m_next<=x1m;
			y1m_next<=y1m;
	end if;		
   end process;
	
	
	stage_iniRegt1_inst: process(CLK)
	begin
		if (CLK'event and CLK='1') then
			y_next1<=y_in;
		end if;
   end process;
	
	
	stage1_muxout_inst: process(y_next1(31),x1p_next,y1p_next,x1m_next,y1m_next)
	begin
		if (y_next1(31)='1') then
		xout_mux<=x1p_next;
		yout_mux<=y1p_next;
		else
		xout_mux<=x1m_next;
		yout_mux<=y1m_next;
		end if;
	 end process;
	 
	 
	stage_outRegt_inst: process(CLK,RST)
	begin
	   if (RST='1') then
		   x_out<=(others=>'0');
			y_out<=(others=>'0');
		elsif (CLK'event and CLK='1') then
			x_out<=xout_mux;
			y_out<=yout_mux;
		end if;		
   end process;

end Behavioral;

