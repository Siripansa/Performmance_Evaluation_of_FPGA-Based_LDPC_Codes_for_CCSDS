----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:38 03/09/2021 
-- Design Name: 
-- Module Name:    polyCal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- fi(x,1,48,32)
-- --y=p1*x^3+p2*x^2+p3*x+p4
-- ymul1=p1*x^3
-- ymul2=p2*x^2
-- ymul3=p3*x
-- yplus1=ymul1+ymul2;
-- yplus2=ymul3+p4;
-- y=yplus1+yplus2;
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity polyCal is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  Ceff1 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff2 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff3 : in  STD_LOGIC_VECTOR (55 downto 0);
			  Ceff4 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp3 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp2 : in  STD_LOGIC_VECTOR (55 downto 0);
           xinp1 : in  STD_LOGIC_VECTOR (55 downto 0);
           polyOut      : out  STD_LOGIC_VECTOR (47 downto 0);
			  polydiv512_Out : out  STD_LOGIC_VECTOR (47 downto 0)
			  );
end polyCal;

architecture Behavioral of polyCal is

  signal ymul1,ymul2,ymul3: STD_LOGIC_VECTOR (56*2-1 downto 0);
  signal ymul1_next,ymul2_next,ymul3_next: STD_LOGIC_VECTOR (55 downto 0);
  signal yplus1_next,yplus2_next			  : STD_LOGIC_VECTOR (55 downto 0);
  --signal yplus1_512_next,yplus2_512_next	  : STD_LOGIC_VECTOR (47 downto 0);
  signal yplus1,yplus2          : STD_LOGIC_VECTOR (55 downto 0); 
--  signal yplus1_512, yplus2_512 : STD_LOGIC_VECTOR (47 downto 0);
  signal Ceff4_next             : STD_LOGIC_VECTOR (55 downto 0);
  signal y                      : STD_LOGIC_VECTOR (55 downto 0);
--  
--  signal Ceff1 : STD_LOGIC_VECTOR (55 downto 0):="01011010101111100000000000000000000000000000000000000000";
--  signal Ceff2 : STD_LOGIC_VECTOR (55 downto 0):="11110111110001111011001100110011001100110011001100110011";
--  signal Ceff3 : STD_LOGIC_VECTOR (55 downto 0):="00000000010100010100101000111101011100001010001111010111";
--  signal Ceff4 : STD_LOGIC_VECTOR (55 downto 0):="11111111111111010001001100111001110000001110101111101110";
--  signal xinp3 : STD_LOGIC_VECTOR (55 downto 0):="00000000000000000000000000010000110001101111011110100001";
--  signal xinp2 : STD_LOGIC_VECTOR (55 downto 0):="00000000000000000000011010001101101110001011101011000111";
--  signal xinp1 : STD_LOGIC_VECTOR (55 downto 0):="00000000000000101000111101011100001010001111010111000011";
 
  --signal ymul1_512_next,ymul2_512_next  : STD_LOGIC_VECTOR (47 downto 0);
  --signal ymul3_512_next                 : STD_LOGIC_VECTOR (47 downto 0); 
  --

begin
 
  ymul1<=Ceff1*xinp3;
  ymul2<=Ceff2*xinp2;
  ymul3<=Ceff3*xinp1;
  
  process(RST,CLK,ymul1,ymul2,ymul3,Ceff4)
  begin
	if (RST='1') then	    		
	   ymul1_next<=(others=>'0');
	   ymul2_next<=(others=>'0');
	   ymul3_next<=(others=>'0');
	   
--	   ymul1_512_next<=(others=>'0');
--	   ymul2_512_next<=(others=>'0');
--	   ymul3_512_next<=(others=>'0');
	   Ceff4_next    <=(others=>'0');
	   
	elsif (CLK'event and CLK='1') then
		ymul1_next<=ymul1(103 downto 48);	  --87+10 downto 40+10
	   ymul2_next<=ymul2(103 downto 48);
		ymul3_next<=ymul3(103 downto 48);
		
--		ymul1_512_next<=ymul1(79-9 downto 32-9);	
--	    ymul2_512_next<=ymul2(79-9 downto 32-9);
--		ymul3_512_next<=ymul3(79-9 downto 32-9);
		
		Ceff4_next<=Ceff4;
	end if;
  end process;
  
  yplus1<=ymul1_next+ymul2_next;
  yplus2<=ymul3_next+Ceff4_next;
  
--  yplus1_512<=ymul1_512_next+ymul2_512_next;
--  yplus2_512<=ymul3_512_next+Ceff4_next;
  
  
  process(RST,CLK,yplus1,yplus2)
  begin
	if (RST='1') then	    
	   yplus1_next<=(others=>'0');	
	   yplus2_next<=(others=>'0');
--	   yplus1_512_next<=(others=>'0');	
--	   yplus2_512_next<=(others=>'0');
	elsif (CLK'event and CLK='1') then
	   yplus1_next<=yplus1;	
	   yplus2_next<=yplus2;
--	   yplus1_512_next<=yplus1_512;	
--	   yplus2_512_next<=yplus2_512;
	end if;
  end process;
  
  y    <=yplus1_next+yplus2_next;
--  y_512<=yplus1_512_next+yplus2_512_next;
  process(RST,CLK,yplus1,yplus2)
  begin
	if (RST='1') then
	    polyOut<=(others=>'0');
		polydiv512_Out<=(others=>'0');
	elsif (CLK'event and CLK='1') then
		polyOut<=y(46 downto 0)&'0';	
      polydiv512_Out<=y(55 downto 8);--y(0)&y(0)&y(0)&y(0)&y(0)&y(0)&y(0)&y(0)&y(0);
	end if;
  end process;
  

end Behavioral;

