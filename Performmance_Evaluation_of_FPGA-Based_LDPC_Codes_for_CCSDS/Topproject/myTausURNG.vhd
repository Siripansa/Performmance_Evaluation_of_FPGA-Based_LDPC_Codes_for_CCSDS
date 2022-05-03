library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity Tausworthe is
Port(
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
	 initials0 : std_logic_vector(31 downto 0);
    initials1 : std_logic_vector(31 downto 0);
	 initials2 : std_logic_vector(31 downto 0);
    data:   out STD_LOGIC_VECTOR (31 downto 0)
);

end  ;

architecture Behavioural of Tausworthe is

    signal s0_next,s1_next,s2_next: std_logic_vector(31 downto 0) := x"00002710"; -- stages
    signal output: std_logic_vector(31 downto 0) := x"00000000";
    signal s0int1,s0int12,s0int21,s0int22: std_logic_vector(31 downto 0) := x"00000000"; -- intermediate signals for s0
    signal s1int1,s1int12,s1int21,s1int22: std_logic_vector(31 downto 0) := x"00000000"; -- intermediate signals for s1   
	signal s2int1,s2int12,s2int21,s2int22: std_logic_vector(31 downto 0) := x"00000000"; -- intermediate signals for s2   
	
	signal b0,b1,b2: std_logic_vector(31 downto 0) := x"00000000"; -- Intermediate b signals for each branch
    signal snext0,snext1,snext2: std_logic_vector(31 downto 0) := x"00000000";
    signal s_out : std_logic_vector(31 downto 0) := x"00000000";


begin


Taus_inst: PROCESS(s0_next,s0int1,s0int12,s0int21,s0int22,
                   s1_next,s1int1,s1int12,s1int21,s1int22,
						 s2_next,s2int1,s2int12,s2int21,s2int22,
						 b0,b1,b2)
    BEGIN
      
        -- For first branch 

        s0int1  <= (s0_next(18 downto 0) & "0000000000000"); -- Shift left by 13 
        s0int12 <= (s0int1 XOR s0_next);
        b0 <= ("0000000000000000000" & s0int12(31 downto 19)); --Shift right by 19
        s0int21 <= (s0_next AND x"FFFFFFFE");
        s0int22 <= (s0int21(19 downto 0) & "000000000000"); --shift left by 12
        snext0  <= (s0int22 XOR b0);

        -- For second branch

        s1int1 <= (s1_next(29 downto 0) & "00"); -- Shift left by 2 
        s1int12<= (s1int1 XOR s1_next);
        b1 <= ("0000000000000000000000000" & s1int12(31 downto 25)); --Shift right by 25
        s1int21 <= (s1_next AND x"FFFFFFF8");
        s1int22 <= (s1int21(27 downto 0) & "0000"); --shift left by 4
        snext1  <= (s1int22 XOR b1);

        -- For third branch

        s2int1 <= (s2_next(28 downto 0) & "000"); -- Shift left by 2 
        s2int12<= (s2int1 XOR s2_next);
        b2 <= ("00000000000" & s2int12(31 downto 11)); --Shift right by 11
        s2int21 <= (s2_next AND x"FFFFFFF0");
        s2int22 <= (s2int21(29 downto 0) & "00"); --shift left by 2
        snext2  <= (s2int22 XOR b2);
  

    END PROCESS;



next_sx: PROCESS(clk,rst,initials0,initials1,initials2)
    BEGIN
      IF (rst='1') THEN
	   s0_next <= initials0;-- x"00002710";
      s1_next <= initials1;--x"00002710"; 
	   s2_next <= initials2;--x"00002710"; 
	  elsif (clk'event and clk='1') then
			s0_next<=snext0;
			s1_next<=snext1;
			s2_next<=snext2;		
	  end if;
 END PROCESS;
--
	s_out <=snext0 xor snext1 xor snext2;
	
next_output: PROCESS(clk,rst)
    BEGIN
      IF (rst='1') THEN
	   data <= (others=>'0');       
	  elsif (clk'event and clk='1') then
			data<=s_out;		
	end if;
 END PROCESS;

    
end Behavioural;  