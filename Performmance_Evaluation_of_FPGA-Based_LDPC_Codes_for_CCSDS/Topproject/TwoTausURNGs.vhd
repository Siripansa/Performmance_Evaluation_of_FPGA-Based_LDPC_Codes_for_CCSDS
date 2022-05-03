----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:46 05/03/2021 
-- Design Name: 
-- Module Name:    twoTausURNGs - Behavioral 
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

entity twoTausURNGs is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           dataTolog : out  STD_LOGIC_VECTOR (47 downto 0);
           dataTocossin : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end twoTausURNGs;

architecture Behavioral of twoTausURNGs is


  component Tausworthe is
  Port(
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
	 initials0 : std_logic_vector(31 downto 0);
    initials1 : std_logic_vector(31 downto 0);
	 initials2 : std_logic_vector(31 downto 0);
    data:   out STD_LOGIC_VECTOR (31 downto 0)
  );
  end component;

  signal data_out1 : STD_LOGIC_VECTOR (31 downto 0);
  signal data_out2 : STD_LOGIC_VECTOR (31 downto 0);
  

  constant initials00 : STD_LOGIC_VECTOR (31 downto 0):=x"00002710";
  constant initials01 : STD_LOGIC_VECTOR (31 downto 0):=x"00002710";
  constant initials02 : STD_LOGIC_VECTOR (31 downto 0):=x"00002710";
  
  constant initials10 : STD_LOGIC_VECTOR (31 downto 0):=x"00001000";                                                              
  constant initials11 : STD_LOGIC_VECTOR (31 downto 0):=x"00002000";
  constant initials12 : STD_LOGIC_VECTOR (31 downto 0):=x"00003000";
begin


  First_inst: Tausworthe 
  Port map(
    clk       => clk,
    rst       => rst,
	 initials0 => initials00,
    initials1 => initials01,
	 initials2 => initials02,
    data      => data_out1
  );
  
  Second_inst: Tausworthe 
  Port map(
    clk       => clk,
    rst       => rst,
	 initials0 => initials10,
    initials1 => initials11,
	 initials2 => initials12,
    data      => data_out2
  );
  
  process(CLK,rst)
  begin
  if rst='1' then
  dataTolog    <=(others=>'0');
  dataTocossin <=(others=>'0');
  elsif (CLK'event and CLK='1') then
  dataTolog    <= data_out1&data_out2(31 downto 16);
  dataTocossin <= data_out2(15 downto 0);
  end if;
  end process;

end Behavioral;

