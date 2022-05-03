----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:36:09 02/18/2021 
-- Design Name: 
-- Module Name:    sqrtCal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--  fi(x,1,32,28)
--  fract 28 bita
--  int   4  bits
--  sign  1  bit
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sqrtCal is
 generic (count_delay : integer := 25);

    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  -------------------------
			  xstg1_outtm  : out  STD_LOGIC_VECTOR (31 downto 0);
			  xout_tm  : out  STD_LOGIC_VECTOR (31 downto 0);
           delay_tm : out  STD_LOGIC_VECTOR (1 downto 0);
	        ---------------------------
           data_in  : in  STD_LOGIC_VECTOR (31 downto 0);
			  data_out : out  STD_LOGIC_VECTOR (16 downto 0)
			  );
end sqrtCal;

architecture Behavioral of sqrtCal is
  
  component codicCoreStg1 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
   end component codicCoreStg1;
	
	component codicCoreStg2 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
   end component codicCoreStg2;
	
	component codicCoreStg3 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
   end component codicCoreStg3;
	
	component codicCoreStg4 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg4;
	
	component codicCoreStg5 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg5;

	component codicCoreStg6 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg6;

	component codicCoreStg7 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg7;	
	
	component codicCoreStg8 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg8;	
	
	component codicCoreStg9 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg9;	
	
	component codicCoreStg10 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg10;	
	
	component codicCoreStg11 is
   Port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        x_in : in  STD_LOGIC_VECTOR (31 downto 0);
		  y_in : in  STD_LOGIC_VECTOR (31 downto 0);
        x_out : out  STD_LOGIC_VECTOR (31 downto 0);
		  y_out : out  STD_LOGIC_VECTOR (31 downto 0)
		  );
   end component codicCoreStg11;	
	
	
  signal x, y, x_next, y_next : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg1_out, ystg1_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg2_out, ystg2_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg3_out, ystg3_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg4tm_out, ystg4tm_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg4_out, ystg4_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg5_out, ystg5_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg6_out, ystg6_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg7_out, ystg7_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg8_out, ystg8_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg9_out, ystg9_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg10_out, ystg10_out : STD_LOGIC_VECTOR (31 downto 0);
  signal xstg11_out            : STD_LOGIC_VECTOR (31 downto 0);
  signal xstgDiv2, xstgDiv2_next : STD_LOGIC_VECTOR (31 downto 0);
--  constant conts              : STD_LOGIC_VECTOR (31 downto 0):="00010011010100011110100001100000";   --- fi(1.207497,1,32,28)
  constant conts              : STD_LOGIC_VECTOR (16 downto 0):="00010011010100100";   --- fi(1.207497,1,17,13)
  signal sqrtx                : STD_LOGIC_VECTOR (33 downto 0); 
  signal outMUX               : STD_LOGIC_VECTOR (1 downto 0);
  constant optwofive : STD_LOGIC_VECTOR (31 downto 0):="00000000010000000000000000000000";  
  constant onepo     : STD_LOGIC_VECTOR (31 downto 0):="00000001000000000000000000000000";
  signal data_xin  : STD_LOGIC_VECTOR (31 downto 0);
  signal dataxin_forMUX : STD_LOGIC_VECTOR (7 downto 0);
  signal div16xin,div16yin : STD_LOGIC_VECTOR (31 downto 0);
  signal div16xin_next,div16yin_next : STD_LOGIC_VECTOR (31 downto 0);
  signal div4xin,div4yin   : STD_LOGIC_VECTOR (31 downto 0);
  signal div4xin_next,div4yin_next   : STD_LOGIC_VECTOR (31 downto 0);
  signal div1xin,div1yin   : STD_LOGIC_VECTOR (31 downto 0);
  signal div1xin_next,div1yin_next   : STD_LOGIC_VECTOR (31 downto 0);
   type delay_array is array (count_delay downto 0) of STD_LOGIC_VECTOR (1 downto 0);
   signal delay : delay_array;
	
  signal xout           : STD_LOGIC_VECTOR (31 downto 0);
  signal xout_next 	   : STD_LOGIC_VECTOR (16 downto 0);

begin
----------- initial --------------------------------------
-- first 8 bits are for MUX output to the cordic
--- 00000001-- 

--   optwofive<="00000000010000000000000000000000";--fi(0.25,1,32,24)
 
	input_inst: process(CLK,RST)
	begin
	if (RST='1') then
	data_xin<=(others=>'0');
	elsif (CLK'event and CLK='1') then
		data_xin<=data_in;  --- xin+1 fi(1,1,32,28)		
	end if;
   end process;

  divxni_inst: process(data_xin)
	begin
		div16xin<=data_xin(31)&data_xin(31)&data_xin(31)&data_xin(31)
		          &data_xin(31 downto 4)+optwofive;
		div16yin<=data_xin(31)&data_xin(31)&data_xin(31)&data_xin(31)		          
					 &data_xin(31 downto 4)-optwofive;
      div4xin <=data_xin(31)&data_xin(31)&data_xin(31 downto 2)+optwofive;
		div4yin <=data_xin(31)&data_xin(31)&data_xin(31 downto 2)-optwofive;
		div1xin <=data_xin+onepo;
		div1yin <=data_xin-onepo;
   end process;
	
  nextdivxni_inst: process(CLK)
	begin
	if (CLK'event and CLK='1') then
		div16xin_next<=div16xin;--fi(0.25,1,32,24)
		div16yin_next<=div16yin;--fi(0.25,1,32,24)
      div4xin_next <=div4xin;--fi(0.25,1,32,24)
		div4yin_next <=div4yin;--fi(0.25,1,32,24)
		div1xin_next <=div1xin;
		div1yin_next <=div1yin;
	end if;
   end process;
	
	
	
   inputForMUX_inst: process(CLK,data_in)
	begin
	if (CLK'event and CLK='1') then
		dataxin_forMUX<=data_xin(31 downto 24);   
	end if;
   end process;
	
	muxinput_inst: process(CLK,data_xin)
	begin
		if    dataxin_forMUX>="00001000" then -- 8 to 10
		
		x<=div16xin_next;
		y<=div16yin_next;
		outMUX <= "00";
		elsif dataxin_forMUX>="00000100" then -- 4 to 7.99999
--		                       00000100
		x<=div4xin_next;
		y<=div4yin_next;
		outMUX <= "01";
		elsif dataxin_forMUX>="00000010" then -- 2 to 7.99999
		                       
		x<=div4xin_next;
		y<=div4yin_next;
		outMUX <= "10";
		else     -- 0 to 1.999 
		
		x<=div1xin_next;
		y<=div1yin_next;
		outMUX <= "11";
		end if;
   end process;

	stage_iniRegt_inst: process(CLK)
	begin
		if (CLK'event and CLK='1') then
			x_next<=x;
			y_next<=y;
		end if;
   end process;
------------------------------------------------------------------------
--   x_out<=x_next;
--	y_out<=y_next;

codicCoreStg1_inst:codicCoreStg1
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>x_next,
				y_in  =>y_next,
				x_out =>xstg1_out,
				y_out =>ystg1_out
			  );
	xstg1_outtm<=xstg1_out;		  
			  
codicCoreStg2_inst:codicCoreStg2
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg1_out,
				y_in  =>ystg1_out,
				x_out =>xstg2_out,
				y_out =>ystg2_out
			  );			  
codicCoreStg3_inst:codicCoreStg3
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg2_out,
				y_in  =>ystg2_out,
				x_out =>xstg3_out,
				y_out =>ystg3_out
			  );	
codicCoreStg4tm_inst:codicCoreStg4
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg3_out,
				y_in  =>ystg3_out,
				x_out =>xstg4tm_out,
				y_out =>ystg4tm_out
			  );	
codicCoreStg4_inst:codicCoreStg4 --- repead stg
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg4tm_out,
				y_in  =>ystg4tm_out,
				x_out =>xstg4_out,
				y_out =>ystg4_out
			  );				  
codicCoreStg5_inst:codicCoreStg5
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg4_out,
				y_in  =>ystg4_out,
				x_out =>xstg5_out,
				y_out =>ystg5_out
			  );	
codicCoreStg6_inst:codicCoreStg6
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg5_out,
				y_in  =>ystg5_out,
				x_out =>xstg6_out,
				y_out =>ystg6_out
			  );	
codicCoreStg7_inst:codicCoreStg7
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg6_out,
				y_in  =>ystg6_out,
				x_out =>xstg7_out,
				y_out =>ystg7_out
			  );	
codicCoreStg8_inst:codicCoreStg8
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg7_out,
				y_in  =>ystg7_out,
				x_out =>xstg8_out,
				y_out =>ystg8_out
			  );				  
codicCoreStg9_inst:codicCoreStg9
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg8_out,
				y_in  =>ystg8_out,
				x_out =>xstg9_out,
				y_out =>ystg9_out
			  );	
codicCoreStg10_inst:codicCoreStg10
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg9_out,
				y_in  =>ystg9_out,
				x_out =>xstg10_out,
				y_out =>ystg10_out
			  );	

codicCoreStg11_inst:codicCoreStg11
   Port map(
				CLK   =>CLK,
				RST   =>RST,
				x_in  =>xstg10_out,
				y_in  =>ystg10_out,
				x_out =>xstg11_out,
				y_out =>open
			  );	


  delay(0)(0)<=outMUX(0);
  delay(0)(1)<=outMUX(1);

OUTERLOOP: FOR i IN 1 TO count_delay generate
   delayMUX_inst: process(CLK,RST)
	begin
	if (RST='1') then
	delay(i)<=(others=>'0');
	elsif (CLK'event and CLK='1') then
		delay(i)<=delay(i-1); 
	end if;
   end process;

end generate;

--   xstgDiv2<= xstg9_out(31)&xstg9_out(31 downto 1);
	
	
--	stage1_xstgDiv2Regt_inst: process(CLK,RST)
--	begin
--	if (RST='1') then
--		   xstgDiv2_next<=(others=>'0');			
--	elsif(CLK'event and CLK='1') then
--			xstgDiv2_next<=xstgDiv2;			
--	end if;		
--   end process;


   xout_tm<=xstg11_out;
   delay_tm<=delay(count_delay);
	
	
   muxout_inst: process(xstg11_out,delay(count_delay))
	begin
		if    delay(count_delay)="00" then -- 8 to 10
		--   xout = x .* (2 .^2);
		xout <= xstg11_out(29 downto 0)&"00";
		
		
		elsif delay(count_delay)="01" then -- 2 to 7.99999
		--   xout = x .* (2 .^1);
		xout <= xstg11_out(30 downto 0)&'0';
		
		
		elsif delay(count_delay)="10" then -- 2 to 7.99999
		--   xout = x .* (2 .^1);
		xout <= xstg11_out(30 downto 0)&'0';
		
		
		else     -- 0 to 1.999 
		 -- xout = x /2;
		xout <= xstg11_out(31)&xstg11_out(31 downto 1);
		end if;
   end process;
	
	
   xoutNExt_inst: process(CLK,xout)
	begin
	if(CLK'event and CLK='1') then
			xout_next<=xout(27 downto 11);			--- xoutdm=fi(xoutfull,1,17,13);
	end if;		
   end process;	
	
	



   sqrtx<=xout_next*conts;
	
	
	outRegt_inst: process(CLK,RST)
	begin
	if (RST='1') then
		   data_out<=(others=>'0');			
	elsif(CLK'event and CLK='1') then
			data_out<=sqrtx(29 downto 13);			
	end if;		
   end process;
		  
end Behavioral;

