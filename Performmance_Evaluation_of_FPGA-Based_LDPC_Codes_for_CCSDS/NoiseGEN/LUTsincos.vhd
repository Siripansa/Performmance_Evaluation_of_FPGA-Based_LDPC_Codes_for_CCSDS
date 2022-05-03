----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:29:16 05/22/2021 
-- Design Name: 
-- Module Name:    LUTsincos - Behavioral 
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


use work.LUTcosonefour.all;
--use work.LUTcosonefour1.all;
--use work.LUTcosonefour2.all;
--use work.LUTsinonefour.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LUTsincos is
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
end LUTsincos;

architecture Behavioral of LUTsincos is

   signal sl,sl_next, sl_next1, sl_next2        : std_logic_vector(1 downto 0); 
   signal revertIndex, revertIndex_next         : std_logic_vector(13 downto 0); 
	signal dataindex,dataindex_next              : std_logic_vector(13 downto 0); 
	signal revertdataindex, revertdataindex_next : std_logic_vector(13 downto 0); 
	signal Index_next                            : std_logic_vector(15 downto 0); 
	signal cosonefourTM,cosonefourmt             : std_logic_vector(15 downto 0); 
	signal cosonefourtm_next,cosonefourmt_next   : std_logic_vector(15 downto 0); 
	
	signal minuscosonefourtm,minuscosonefourmt   : std_logic_vector(15 downto 0); 
	signal cosonefour00, cosonefour01            : std_logic_vector(15 downto 0);  
	signal cosonefour10, cosonefour11            : std_logic_vector(15 downto 0); 
--	signal sinonefour00, sinonefour01            : std_logic_vector(15 downto 0);  
--	signal sinonefour10, sinonefour11            : std_logic_vector(15 downto 0); 
	
	signal costm, sintm                          : std_logic_vector(15 downto 0); 

begin

  
  ShfRgIndex_inst: process (CLK, RST, data_in)
  begin
  if RST='1' then
  Index_next <= (others=>'0');
  elsif clk'event and clk='1' then
    index_next <= data_in;
  end if;
  end process;
  
  
  ----------- revert index --------------------------------
  revertIndex_inst: process (data_in)
  begin
    revertIndex <= "11111111111111" - data_in(13 downto 0);
  end process;
	
  ShfRgrevertIndex_inst: process (CLK, RST, revertIndex)
  begin
  if RST='1' then
  revertIndex_next <= (others=>'0');
  elsif clk'event and clk='1' then
    revertIndex_next <= revertIndex;
  end if;
  end process;
  
  
  --- repare select index ---------------------------------------------
  
  selectdataindex_inst: process(CLK, RST, index_next, revertIndex_next)
  begin
     sl        <= index_next(15 downto 14);
     dataindex <= index_next(13 downto 0);
	  revertdataindex <= revertIndex_next;  
  end process;
  
  ShfRgIndex0_inst: process (CLK, RST, data_in)
  begin
  if RST='1' then
  sl_next              <= (others=>'0');
  dataindex_next       <= (others=>'0');
  revertdataindex_next <= (others=>'0');
  elsif clk'event and clk='1' then
     sl_next              <= sl;
     dataindex_next       <= dataindex;
	  revertdataindex_next <= revertdataindex;  
  end if;
  end process;
  
--  ---------------- LUT mapping -------------------------------------	
--  process (CLK,RST,dataindex_next)
--  begin
--  if RST='1' then
--  cosonefourTM <= (others=>'0');
--  cosonefourMT <= (others=>'0');
----  elsif clk'event and clk='1' then
--  else
--   if dataindex_next<="10000000000000" then
     cosonefourTM <=  cosonefour(conv_integer(dataindex_next));
	  cosonefourMT <=  cosonefour(conv_integer(revertdataindex_next)); --   
--	  else
--	  cosonefourTM <=  cosonefour2(conv_integer(dataindex_next));
--	  cosonefourMT <=  cosonefour2(conv_integer(revertdataindex_next)); --   
--	end if;
----     cosonefourMT <=  sinonefour(conv_integer(revertdataindex_next)); --   
--  end if;
--  end process;
  

  
  
  ShfRgLUT_inst: process (CLK, RST, data_in)
  begin
  if RST='1' then
  cosonefourTM_next <= (others=>'0');
  cosonefourMT_next <= (others=>'0');
  elsif clk'event and clk='1' then
     cosonefourTM_next <= cosonefourTM;
	  cosonefourMT_next <= cosonefourMT;
  end if;
  end process;
  
  
  	Minuscosonefour_inst: process(cosonefourTM_next,cosonefourMT_next)
	begin
	MinuscosonefourTM<= (not (cosonefourTM_next)) +'1';
	MinuscosonefourMT<= (not (cosonefourMT_next)) +'1';
	end process;
	
	
 --- please see matlab file F:\ProJect\2564\NoiseGenKMITL\matlab\noiseGen\myNoiseGen.m -- 
  ShfRgCosLUT_inst: process (CLK, RST, cosonefourTM_next,
                             MinuscosonefourMT,MinuscosonefourTM,cosonefourMT_next)
  begin
  if RST='1' then
  cosonefour00 <= (others=>'0');
  cosonefour01 <= (others=>'0');
  cosonefour10 <= (others=>'0');
  cosonefour11 <= (others=>'0');
  elsif clk'event and clk='1' then
     cosonefour00 <= cosonefourTM_next;
     cosonefour01 <= MinuscosonefourMT;
     cosonefour10 <= MinuscosonefourTM;
     cosonefour11 <= cosonefourMT_next;
  end if;
  end process;
  
--  ShfRgSinLUT_inst: process (CLK, RST, cosonefourTM_next,
--                             MinuscosonefourMT,MinuscosonefourTM,cosonefourMT_next)
--  begin
--  if RST='1' then
--  sinonefour00 <= (others=>'0');
--  sinonefour01 <= (others=>'0');
--  sinonefour10 <= (others=>'0');
--  sinonefour11 <= (others=>'0');
--  elsif clk'event and clk='1' then
--     sinonefour00 <= cosonefourMT_next;
--     sinonefour01 <= cosonefourTM_next;
--     sinonefour10 <= MinuscosonefourMT;
--     sinonefour11 <= MinuscosonefourTM;
--  end if;
--  end process;
  
  ------ wat sl signal -----
  ShfRgIndex1_inst: process (CLK, RST, sl_next)
  begin
  if RST='1' then
  sl_next1 <= (others=>'0');
  elsif clk'event and clk='1' then
     sl_next1              <= sl_next;
  end if;
  end process;
  
  ShfRgIndex2_inst: process (CLK, RST, sl_next1)
  begin
  if RST='1' then
  sl_next2 <= (others=>'0');
  elsif clk'event and clk='1' then
     sl_next2              <= sl_next1;
  end if;
  end process;

  
  --- debug signal 
  sl_next1tm   <= sl_next2;
  cosonefour00tm <= cosonefour00;
  cosonefour01tm <= cosonefour01;
  
  
  slprocess_inst: process(sl_next2,cosonefour00,cosonefour01,
                          cosonefour10,cosonefour11)--,
--								  sinonefour00,sinonefour01,
--								  sinonefour10,sinonefour11)
  begin
  if     sl_next2="00" then
   costm <= cosonefour00;
	sintm <= cosonefour11;
  elsif  sl_next2="01" then
   costm <= cosonefour01;
	sintm <= cosonefour00;
  elsif  sl_next2="10" then
   costm <= cosonefour10;
	sintm <= cosonefour01; 
  else
   costm <= cosonefour11;
	sintm <= cosonefour10;
  end if;
  end process;
  
    ShfRgout_inst: process (CLK, RST, costm, sintm)
  begin
  if RST='1' then
  cos <= (others=>'0');
  sin <= (others=>'0');
  elsif clk'event and clk='1' then
     cos <= costm;
	  sin <= sintm;
  end if;
  end process;

end Behavioral;

