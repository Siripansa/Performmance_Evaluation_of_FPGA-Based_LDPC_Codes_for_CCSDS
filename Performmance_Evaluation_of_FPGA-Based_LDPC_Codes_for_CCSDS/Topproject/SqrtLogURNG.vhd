----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:53:30 05/07/2021 
-- Design Name: 
-- Module Name:    SqrtLogURNG - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity SqrtLogURNG is
 Port ( CLK_in : in  STD_LOGIC;
        RST_in : in  STD_LOGIC;
		  
		  MinusXlogOuttm : out  STD_LOGIC_VECTOR (31 downto 0);
		  logOuttm  : out STD_LOGIC_VECTOR(31 downto 0);
		  
		  data_out : out  STD_LOGIC_VECTOR (16 downto 0)
			  );
end SqrtLogURNG;

architecture Behavioral of SqrtLogURNG is

 component minustwoXlog is
    Port ( CLK_IN : in  STD_LOGIC;
           RST_IN : in  STD_LOGIC;
			  ---
--			  dataTolog : in STD_LOGIC_VECTOR(47 downto 0);
--			  logOuttm  : out STD_LOGIC_VECTOR(31 downto 0);
			  ---
           MinusXlogOut_next : out  STD_LOGIC_VECTOR (31 downto 0));
 end component minustwoXlog;

 component sqrtCal 
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
  
  signal MinusXlogOut_next : STD_LOGIC_VECTOR (31 downto 0);
  signal dataTolog    : STD_LOGIC_VECTOR (47 downto 0); 
  signal CLK, RST     : STD_LOGIC;
  
  
begin

   dataTolog<="000110011001100110011001100110011001100110011010";

-- xxFix = fi(xxxx(indexin),0,48,48);
--	000000101000111101011100001010001111010111000011 ---0.01
-- 000001111010111000010100011110101110000101001000 ---0.03
-- 000010100011110101110000101000111101011100001010 ---0.04
-- 000100011110101110000101000111101011100001010010 ---0.07
-- 000110011001100110011001100110011001100110011010 ---0.1
-- 001100110011001100110011001100110011001100110011 ---0.2
-- 010011001100110011001100110011001100110011001101 ---0.3

-- 011001100110011001100110011001100110011001100110 ---0.4
-- 100000000000000000000000000000000000000000000000 ---0.5
-- 100110011001100110011001100110011001100110011010 ---0.6
-- 101100110011001100110011001100110011001100110011 ---0.7
-- 110011001100110011001100110011001100110011001101 ---0.8
-- 111001100110011001100110011001100110011001100110 ---0.9

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

     minustwoXlog_inst :minustwoXlog 
    Port map (
  	   CLK_IN          => CLK_IN,
      RST_IN          => RST_IN,
		
--		dataTolog    => dataTolog,
--		logOuttm     =>logOuttm,
		
      MinusXlogOut_next => MinusXlogOut_next 
	 );
	 
	 -- 
	 MinusXlogOuttm <= MinusXlogOut_next;
 
    sqrtCal_inst: sqrtCal 
    generic map(count_delay => 25)
    Port map ( 
	   CLK         => CLK,
      RST         => RST,
			  -------------------------
	   xstg1_outtm => open,
		xout_tm     => open,
      delay_tm    => open,
	        ---------------------------
      data_in     => MinusXlogOut_next,
		data_out    => data_out
   );

end Behavioral;

