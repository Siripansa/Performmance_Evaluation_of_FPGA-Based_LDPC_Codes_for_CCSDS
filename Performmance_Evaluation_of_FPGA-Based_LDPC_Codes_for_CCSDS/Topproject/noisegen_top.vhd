----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:33 06/16/2021 
-- Design Name: 
-- Module Name:    noisegen_top - Behavioral 
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
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity noisegen_top is
    Port ( 
	        CLK_in : in  STD_LOGIC;
           RST_in : in  STD_LOGIC;
			  
			  LED_OUT      : out STD_LOGIC_VECTOR(7 downto 0);
			  SWITCH_IN    : in  std_logic_vector(3 downto 0);	
			  
			  cnt : out STD_LOGIC;
			  data_new : out STD_LOGIC_VECTOR (15 downto 0)
			  
			 );
end noisegen_top;

architecture Behavioral of noisegen_top is

component CLKgen 
   Port ( CLK_IN     : in  STD_LOGIC;
           RST        : in  STD_LOGIC;
			  CLK_FAST   : out STD_LOGIC;
           CLK_SYS    : out STD_LOGIC;
			  CLK_SYS_4ml: out STD_LOGIC;
			  CLK_DATACLK_fs : out STD_LOGIC;
			  CLK_DATACLK_dv : out STD_LOGIC;
           CLK_LOCKED : out  STD_LOGIC
			  );
end component CLKgen;


component twoTausURNGs is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           dataTolog : out  STD_LOGIC_VECTOR (47 downto 0);
           dataTocossin : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component twoTausURNGs;

component LUTsincos is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);   --- it is an index of the LUT 
           
			  ---debug signal -----
			  sl_next1tm      : out  STD_LOGIC_VECTOR (1 downto 0);
			  cosonefour00tm  : out  STD_LOGIC_VECTOR (15 downto 0);
			  cosonefour01tm  : out  STD_LOGIC_VECTOR (15 downto 0);
			  
			  cos : out  STD_LOGIC_VECTOR (15 downto 0);
			  sin : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component LUTsincos;

component logCal_top is
    Port ( CLK : in  STD_LOGIC;
	        RST : in  STD_LOGIC;
           xin : in  STD_LOGIC_VECTOR (47 downto 0);
			  MUXoutSL_out : out  STD_LOGIC;
--			  
			  poly_512_outdm : out   STD_LOGIC_VECTOR (31 downto 0);
			  polyOutdm      : out   STD_LOGIC_VECTOR (31 downto 0);
			  xin_nexttm     : out   STD_LOGIC_VECTOR (47 downto 0);
			  
			  xinp1mul_next1tm  : out  STD_LOGIC_VECTOR (55 downto 0);
			  xinp2_nexttm  : out  STD_LOGIC_VECTOR (55 downto 0);
			  
			  xin_preparetm  : out   STD_LOGIC_VECTOR (55 downto 0);
			  
			  xinp1_tm       : out   STD_LOGIC_VECTOR (55 downto 0);
           CoEf1_next1tm  : out   STD_LOGIC_VECTOR (55 downto 0);
--			  
           logOut : out  STD_LOGIC_VECTOR (31 downto 0) -- fi(x,1,32,24)
			  );
end component logCal_top;


component sqrtCal is
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
end component sqrtCal;



--component ICONinterface
--  PORT (
--    CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0));

--end component;



--component ILAout
--  PORT (
--    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
--    CLK : IN STD_LOGIC;
--    TRIG0 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
--    TRIG1 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
--    TRIG2 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
--    TRIG3 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
--	 TRIG4 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
--    TRIG5 : IN STD_LOGIC_VECTOR(17 DOWNTO 0)
--	 );
--end component;




	
 signal dataTolog	: STD_LOGIC_VECTOR (47 downto 0);
 signal dataToCos : STD_LOGIC_VECTOR (15 downto 0);
 signal cos_out	: STD_LOGIC_VECTOR (15 downto 0);
 signal sin_out	: STD_LOGIC_VECTOR (15 downto 0);
 
 
 signal MinusXlogOut : STD_LOGIC_VECTOR (31 downto 0);
 
 signal rcnt : std_logic;
 
 signal   LED                   :STD_LOGIC_VECTOR(7 downto 0);
 signal   SWITCH                :STD_LOGIC_VECTOR(3 downto 0);
 signal   RST                   :std_logic;  
 signal   CLK_SYS               :std_logic;  
 signal   CLKgen_LOCKED         :std_logic;  
 
 signal   data_out              :STD_LOGIC_VECTOR (16 downto 0);
 signal   logOut, logout_next   :STD_LOGIC_VECTOR (31 downto 0);
 signal   MinusXlogOut_next     :STD_LOGIC_VECTOR (31 downto 0); 
 signal   noiseouttmR            :STD_LOGIC_VECTOR (33 downto 0); 
 signal   noiseouttmI            :STD_LOGIC_VECTOR (33 downto 0); 
 signal   noiseoutR_next         :STD_LOGIC_VECTOR (15 downto 0); 
 signal   noiseoutI_next         :STD_LOGIC_VECTOR (15 downto 0); 

 signal   PRBS_SEL	           :STD_LOGIC_VECTOR(1 downto 0);
 signal   SL 	                 :STD_LOGIC_VECTOR(1 downto 0);
 
 signal   CONTROL_ILA           :STD_LOGIC_VECTOR(35 DOWNTO 0);
 signal   tem_a                 :std_logic_vector(17 downto 0);
 signal   tem_b                 :std_logic_vector(17 downto 0);
 signal   tem_c                 :std_logic_vector(17 downto 0);
 signal   tem_d                 :std_logic_vector(17 downto 0);
 signal   tem_e                 :std_logic_vector(17 downto 0);
 
begin

 

 CLKgen_inst: CLKgen
   Port map 
	      ( CLK_IN           =>CLK_in,
           RST              =>RST,
			  CLK_FAST         =>open,
           CLK_SYS          =>CLK_SYS,
			  CLK_SYS_4ml      =>open,
			  CLK_DATACLK_fs   =>open,
			  CLK_DATACLK_dv   =>open,
           CLK_LOCKED       =>CLKgen_LOCKED
			  );
			  
			  
			  
			  
reset_inst : ibuf
    generic map (
      IOSTANDARD => "LVCMOS25")
    port map (
      o => RST,
      i => RST_IN); -- logic '1'

switch_loop : for i in 3 downto 0 generate
    switch_inst : IBUF
      port map (
        O => SWITCH(i),      -- Buffer output
        I => SWITCH_IN(i));  -- Buffer input (connect directly to top-level port)
end generate switch_loop;


  PRBS_SEL(0)       <= SWITCH(0);
  PRBS_SEL(1)       <= SWITCH(1);
  SL(0)             <= SWITCH(2);
  SL(1)             <= SWITCH(3);
--  PRT_SEL(0)        <= SWITCH(3);


--PRT_SEL(0)  <= SWITCH(4);
---- LED --------------------------------
led_loop : for i in 7 downto 0 generate
led_inst : obuf
      generic map (
        IOSTANDARD => "LVCMOS25",
        DRIVE      => 24,
        SLEW       => "FAST")
      port map (
        o => LED_out(i),
        i => LED(i));--LED(i));
end generate;		

  LED(0)      <= CLKgen_LOCKED;
  LED(1)      <= '0';
  LED(2)      <= '0';
  LED(3)      <= '0';
  LED(4)      <= SL(0);
  LED(5)      <= SL(1);
  LED(6)      <= PRBS_SEL(0);
  LED(7)      <= PRBS_SEL(1);
  
  
  
  

  twoTausURNGs_inst : twoTausURNGs
   Port map
	( CLK          => CLK_SYS,
     RST          => RST,
     dataTolog    => dataTolog,
     dataTocossin => dataToCos
	 );

 LUTsincos_inst: LUTsincos
    Port map
	 ( CLK => CLK_SYS,
      RST => RST,
      data_in => dataToCos,
           
			  ---debug signal -----
	   sl_next1tm      =>open,
		cosonefour00tm  =>open,
		cosonefour01tm  =>open,
			  
		cos =>cos_out,
		sin =>sin_out
--			  sin : out  STD_LOGIC_VECTOR (15 downto 0)
	);

logCal_top_inst:  logCal_top
    Port map 
	 ( 
	        CLK               =>CLK_SYS,
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
   process(CLK_SYS)
	begin
	if (CLK_SYS'event and CLK_SYS='1') then
	logOut_next<=logOut;
	end if;
	end process;
	
	
	TwoComplements: process(logOut,logout_next)
	begin
	MinusXlogOut<= (not (logOut_next)) +'1';
	end process;
	
	
	process(CLK_SYS,RST)
	begin
	if (RST='1') then
	MinusXlogOut_next<=(others=>'0');
	elsif (CLK_SYS'event and CLK_SYS='1') then
	MinusXlogOut_next<=MinusXlogOut(30 downto 0)&'0';
	end if;
	end process;
	
	
	
 
   sqrtCal_inst: sqrtCal 
    generic map(count_delay => 25)
    Port map ( 
	   CLK         => CLK_SYS,
      RST         => RST,
			  -------------------------
	   xstg1_outtm => open,
		xout_tm     => open,
      delay_tm    => open,
	        ---------------------------
      data_in     => MinusXlogOut_next,
		data_out    => data_out
   );
	


	noiseouttmR<=data_out*(cos_out(15)&cos_out(15)&cos_out(15)&cos_out(15  downto 2));
	noiseouttmI<=data_out*(sin_out(15)&sin_out(15)&sin_out(15)&sin_out(15  downto 2));
   noiseout_inst :process(CLK_SYS,RST)
	begin
	if (RST='1') then
	noiseoutR_next<=(others=>'0');
	noiseoutI_next<=(others=>'0');
	rcnt <= '0';
	elsif (CLK_SYS'event and CLK_SYS='1') then
	noiseoutR_next<=noiseouttmR(33 downto 18);
	noiseoutI_next<=noiseouttmI(33 downto 18);
	rcnt <= '1';
	end if;
	end process;
--	data_new <= noiseoutR_next;
	data_new <= noiseoutI_next;
	cnt <= rcnt;
--	process(CLK_SYS,RST)
--   begin
--   if (RST='1') then
--		tem_a<=(others=>'0');
--		tem_b<=(others=>'0');
--		tem_c<=(others=>'0');
--		tem_d<=(others=>'0');
--		tem_e<=(others=>'0');
--	elsif (CLK_SYS'event and CLK_SYS='1') then		
--				tem_a<=data_out(16)&data_out;
--			   tem_b<=cos_out(15)&cos_out(15)&cos_out;
--				tem_c<=dataTolog(47 downto 30);
--				tem_d<=noiseoutR_next(15)&noiseoutR_next(15)&noiseoutR_next;
--				tem_e<=noiseoutI_next(15)&noiseoutI_next(15)&noiseoutI_next;
--   end if;
--   end process;	

--U_ICONinterfaceILA : ICONinterface
--  port map (
--    CONTROL0 => CONTROL_ILA);
	 
--U_ILAout : ILAout
--  PORT map(
--    CONTROL => CONTROL_ILA,
--    CLK     => CLK_SYS,
--    TRIG0   => tem_a,  -- 0:17
--    TRIG1   => tem_b,  -- 18:35 
--    TRIG2   => tem_c,  -- 36:53
--    TRIG3   => tem_d,  -- 54:71
--	 TRIG4   => tem_e, -- 72:89
--	 TRIG5   => tem_b  -- 90:107
--	 );
	
	

end Behavioral;

