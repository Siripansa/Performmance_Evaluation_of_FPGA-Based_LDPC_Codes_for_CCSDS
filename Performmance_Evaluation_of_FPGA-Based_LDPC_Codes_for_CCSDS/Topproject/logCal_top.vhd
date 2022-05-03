----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:46 03/08/2021 
-- Design Name: 
-- Module Name:    logCal_top - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity logCal_top is
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
end logCal_top;

architecture Behavioral of logCal_top is

 component CofROM is
    Port (
	   CLK   : in std_logic;
      RST   : in std_logic;
      ADDR  : in std_logic_vector(2 downto 0);
		CoEf1 : out std_logic_vector(55 downto 0);
	   CoEf2 : out std_logic_vector(55 downto 0);
	   CoEf3 : out std_logic_vector(55 downto 0);
		CoEf4 : out std_logic_vector(55 downto 0)
		);
 end component CofROM;
 
 component xinPropare is
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
 end component xinPropare;
 
 component polyCal is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  Ceff1 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff2 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff3 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff4 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp3 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp2 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp1 : in  STD_LOGIC_VECTOR (55 downto 0);
           polyOut : out  STD_LOGIC_VECTOR (47 downto 0);
 			  polydiv512_Out : out  STD_LOGIC_VECTOR (47 downto 0)

			  );
 end component polyCal;

	signal xin_next              : STD_LOGIC_VECTOR (47 downto 0);
	signal xin_prepare           : STD_LOGIC_VECTOR (55 downto 0);
	signal MUXSL,MUXSL_next  	  : STD_LOGIC_VECTOR (2 downto 0);
	signal CoEf1, CoEf2 		 	  : STD_LOGIC_VECTOR (55 downto 0);
   signal CoEf3, CoEf4	 	 	  : STD_LOGIC_VECTOR (55 downto 0);
   signal xinp3, xinp2, xinp1	  : STD_LOGIC_VECTOR (55 downto 0);
	signal CoEf1_next0, CoEf2_next0 : STD_LOGIC_VECTOR (55 downto 0);
	signal CoEf3_next0, CoEf4_next0 : STD_LOGIC_VECTOR (55 downto 0);
   signal CoEf1_next1, CoEf2_next1 : STD_LOGIC_VECTOR (55 downto 0);
	signal CoEf3_next1, CoEf4_next1 : STD_LOGIC_VECTOR (55 downto 0);
	signal polyOut,polydiv512_Out     : STD_LOGIC_VECTOR (47 downto 0);
	signal logOut_tm                : STD_LOGIC_VECTOR (31 downto 0);
	signal MUXSL2_next : STD_LOGIC_VECTOR (5 downto 0);
	signal MUXoutSL    : STD_LOGIC:='0';
 
 
--   	signal xin: STD_LOGIC_VECTOR (39 downto 0):="0001000000000000000000000000000000000000";
 
begin

 
 
 process(CLK,xin)
 begin
--	if (RST='1') then
--	xin_next<=(others=>'0');
--	xin_prepare<=(others=>'0');
	if (CLK'event and CLK='1') then
		xin_next<=xin;
		xin_prepare<="00000000"&xin;--xin(47)&xin(47)&xin(47)&xin(47)&
		             --xin(47)&xin(47)&xin(47)&xin(47)&
					    --xin(47)&xin(47)&xin(47)&xin(47)&
					    --xin(47)&xin(47)&xin(47)&xin(47)&
		             --xin(47 downto 16);
	end if;
 end process;
 
 xin_nexttm <= xin_next;
 xin_preparetm<= xin_prepare;
 
 ---- coefficeint mux  -----------------
process(xin_next)
 begin
	if    (xin_next(47 downto 32)<"0000100000000000") then -- <=0.03125
		MUXSL<="000"; -- 1
	elsif (xin_next(47 downto 32)<"0001000000000000") then -- <=0.0625
		MUXSL<="001"; -- 2
   elsif (xin_next(47 downto 32)<"0010000000000000") then -- <=0.125
		MUXSL<="010"; -- 3		
   elsif (xin_next(47 downto 32)<"0100000000000000") then -- <=0.25
		MUXSL<="011"; -- 4		
   elsif (xin_next(47 downto 32)<"1000000000000000") then -- <=0.5
		MUXSL<="100"; -- 5		
   elsif (xin_next(47 downto 32)<"1100000000000000") then -- <=0.75
		MUXSL<="101"; -- 6	
   else		
	   MUXSL<="110"; -- 7	
	end if;
 end process;
 
 process(CLK,xin)
 begin
	if (CLK'event and CLK='1') then
		MUXSL_next<=MUXSL;
	end if;
 end process;


  
 
 CofROM_inst: CofROM
    Port map (
	   CLK   =>CLK,
      RST   =>RST,
      ADDR  =>MUXSL_next,
		CoEf1 =>CoEf1,
	   CoEf2 =>CoEf2,
	   CoEf3 =>CoEf3,
		CoEf4 =>CoEf4
		);
----- wait xin calculation -----		
		
 process(CLK,xin)
 begin
	if (CLK'event and CLK='1') then
		CoEf1_next0<=CoEf1;
		CoEf2_next0<=CoEf2;
		CoEf3_next0<=CoEf3;
		CoEf4_next0<=CoEf4;
	end if;
 end process;
 process(CLK,xin)
 begin
	if (CLK'event and CLK='1') then
		CoEf1_next1<=CoEf1_next0;
		CoEf2_next1<=CoEf2_next0;
		CoEf3_next1<=CoEf3_next0;
		CoEf4_next1<=CoEf4_next0;
	end if;
 end process;
		
		
  xinPropare_inst: xinPropare 
    Port  map( 
	    CLK   =>CLK,
       RST   =>RST,
       xin   =>xin_prepare,
       xinp3 =>xinp3,
       xinp2 =>xinp2,
       xinp1 =>xinp1,
		 
		 xinp1mul_next1tm =>xinp1mul_next1tm,
       xinp2_nexttm =>xinp2_nexttm
		 );

 xinp1_tm   <=xinp2;
 CoEf1_next1tm<=CoEf1_next0;
		
 polyCal_inst: polyCal
    Port map(
   	CLK   =>CLK,
      RST   =>RST,
		Ceff1 =>CoEf1_next0,
		Ceff2 =>CoEf2_next0,
		Ceff3 =>CoEf3_next0,
		Ceff4 =>CoEf4_next0,
      xinp3 =>xinp3,
      xinp2 =>xinp2,
      xinp1 =>xinp1,
      polyOut =>polyOut,
		polydiv512_Out=>polydiv512_Out
		);		
		
------------------- MUX out ------------------------		

	 ---- waiting MUX signal ------
    process (RST,CLK)
    begin
      if (RST='1') then
		MUXSL2_next<=(others=>'0');
		elsif (CLK'event and CLK='1') then
            for i in 0 to 4 loop
                MUXSL2_next(i+1) <= MUXSL2_next(i);
            end loop;
            MUXSL2_next(0) <= MUXSL(2);
        end if;
    end process;

    MUXoutSL <= MUXSL2_next(5);
	
	 ---- end waiting MUX signal ------
    -- fi(x,1,31,24) --
	 process (polyOut,polydiv512_Out,MUXoutSL)
    begin
	  if (MUXoutSL='0') then
	  logOut_tm<=polyOut(47 downto 16);
	  else
	  logOut_tm<=polydiv512_Out(47 downto 16);
	  end if;
    end process;
	 
	     -- fi(x,1,31,24) --
	 process (RST,CLK)
    begin
	  if (RST='1') then
	  logOut <= (others=>'0');
	  elsif (CLK'event and CLK='1') then
	  logOut <= logOut_tm;	  
	  end if;
    end process;
 
    MUXoutSL_out<=MUXoutSL;
	poly_512_outdm<=polydiv512_Out(47 downto 16);
	polyOutdm<=polyOut(47 downto 16);
 ----
 
 
 
end Behavioral;

