library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
-- use IEEE.NUMERIC_STD.all;

entity combined_Tausworthe_88 is
	port(
		RstB 								: in std_logic;
		Clk 								: in std_logic;
		sourceValid							: in std_logic;
		sourceReady							: out std_logic;
		sinkReady							: in std_logic;
		sinkValid							: out std_logic;
		
		uniformRandomSequence 				: out std_logic_vector(31 downto 0)
	);
end entity combined_Tausworthe_88;

architecture rtl of combined_Tausworthe_88 is

    signal sFirstInitial					: std_logic_vector(31 downto 0) := x"00002710";
	signal sFirstInitial1					: std_logic_vector(31 downto 0) := (others => '0');
	signal sFirstInitial2					: std_logic_vector(31 downto 0) := (others => '0');
	signal sFirstInitial3					: std_logic_vector(31 downto 0) := (others => '0');
	signal sSecondInitial					: std_logic_vector(31 downto 0) := x"00002710";
	signal sSecondInitial1					: std_logic_vector(31 downto 0) := (others => '0');
	signal sSecondInitial2					: std_logic_vector(31 downto 0) := (others => '0');
	signal sSecondInitial3					: std_logic_vector(31 downto 0) := (others => '0');
	signal sThirdInitial					: std_logic_vector(31 downto 0) := x"00002710";
	signal sThirdInitial1					: std_logic_vector(31 downto 0) := (others => '0');
	signal sThirdInitial2					: std_logic_vector(31 downto 0) := (others => '0');
	signal sThirdInitial3					: std_logic_vector(31 downto 0) := (others => '0');
	signal sFirstConstant					: std_logic_vector(31 downto 0) := x"FFFFFFFE";
	signal sSecondConstant					: std_logic_vector(31 downto 0) := x"FFFFFFF8";
	signal sThirdConstant					: std_logic_vector(31 downto 0) := x"FFFFFFF0";
	signal sRegister1						: std_logic_vector(31 downto 0) := (others => '0');
	signal sRegister2						: std_logic_vector(31 downto 0) := (others => '0');
	signal sRegister3						: std_logic_vector(31 downto 0) := (others => '0');
	signal sUniformRandomSequence1			: std_logic_vector(31 downto 0) := (others => '0');
	signal sUniformRandomSequence2			: std_logic_vector(31 downto 0) := (others => '0');
	signal sUniformRandomSequence3			: std_logic_vector(31 downto 0) := (others => '0');
	signal sStage							: integer := 0;

	signal sSourceValid						: std_logic := '0';
	signal sSourceReady						: std_logic := '1';
	signal sSinkReady						: std_logic := '0';
	signal sSinkValid						: std_logic := '0';

begin

	sSourceValid <= sourceValid;
    sourceReady <= sSourceReady;
	sSinkReady <= sinkReady;
	sinkValid <= sSinkValid;

	transceiveData : process(Clk) is
    begin
        if (rising_edge(Clk)) then
            if (RstB = '0') then
                sSourceReady <= '1';
                sSinkValid <= '0';
            else
                -- if (sSinkValid = '0' and sSourceReady = '0') then
                --     sSinkValid <= '1';
                --     uniformRandomSequence <= sLFSR;
                -- end if;

                -- if (sSinkValid = '1' and sSinkReady = '1') then
                --     sSourceReady <= '1';
                --     sSinkValid <= '0';
                -- end if;

                -- if (sSourceValid = '1' and sSourceReady = '1') then
                --     sSourceReady <= '0';
                -- end if;

				if (sSourceValid = '1') then
                    sSinkValid <= '1';
                    uniformRandomSequence <= sUniformRandomSequence1 xor sUniformRandomSequence2 xor sUniformRandomSequence3;
                end if;
            end if;
        end if;
    end process transceiveData;

	holdValue : process(Clk) is
	begin
		if (rising_edge(Clk)) then
			if (RstB = '0') then
				sUniformRandomSequence1 <= (others => '0');
				sUniformRandomSequence2 <= (others => '0');
				sUniformRandomSequence3 <= (others => '0');
			else
				if (sStage = 0) then
					sUniformRandomSequence1 <= sFirstInitial;
					sUniformRandomSequence2 <= sSecondInitial;
					sUniformRandomSequence3 <= sThirdInitial;
				end if;
			end if;
		end if;
	end process holdValue;

	stageCount : process(Clk) is
	begin
		if (rising_edge(Clk)) then
			if (RstB = '0') then
				sStage <= 0;
			else
				if (sStage >= 2) then
					sStage <= 0;
				else
					sStage <= sStage + 1;
				end if;
			end if;
		end if;
	end process stageCount;

    combinedTauswortheGenerator : process(Clk) is
    begin
        if (rising_edge(Clk)) then
            if (RstB = '0') then
                sFirstInitial <= x"00002710";
				sSecondInitial <= x"00002710";
				sThirdInitial <= x"00002710";
            else   -- need first 6 clocks before provide first uniform random sequence
				sFirstInitial1  <= (sFirstInitial(18 downto 0) & "0000000000000") xor sFirstInitial;   -- shift left by 13 
				sRegister1 <= ("0000000000000000000" & sFirstInitial1(31 downto 19));   -- shift right by 19
				sFirstInitial2 <= (sFirstInitial and sFirstConstant);
				sFirstInitial3 <= (sFirstInitial2(19 downto 0) & "000000000000");   -- shift left by 12
				sFirstInitial  <= (sFirstInitial3 xor sRegister1);

				sSecondInitial1  <= (sSecondInitial(29 downto 0) & "00") xor sSecondInitial;   -- shift left by 2 
				sRegister2 <= ("0000000000000000000000000" & sSecondInitial1(31 downto 25));   -- shift right by 25
				sSecondInitial2 <= (sSecondInitial and sSecondConstant);
				sSecondInitial3 <= (sSecondInitial2(27 downto 0) & "0000");   -- shift left by 4
				sSecondInitial  <= (sSecondInitial3 xor sRegister2);

				sThirdInitial1  <= (sThirdInitial(28 downto 0) & "000") xor sThirdInitial;   -- shift left by 3 
				sRegister3 <= ("00000000000" & sThirdInitial1(31 downto 11));   -- shift right by 11
				sThirdInitial2 <= (sThirdInitial and sThirdConstant);
				sThirdInitial3 <= (sThirdInitial2(14 downto 0) & "00000000000000000");   -- shift left by 17
				sThirdInitial  <= (sThirdInitial3 xor sRegister3);

				-- sFirstInitial1  <= (sFirstInitial(18 downto 0) & "0000000000000");   -- shift left by 13 
				-- sFirstInitial2 <= (sFirstInitial1 xor sFirstInitial);
				-- sRegister1 <= ("0000000000000000000" & sFirstInitial2(31 downto 19));   -- shift right by 19
				-- sFirstInitial3 <= (sFirstInitial and sFirstConstant);
				-- sFirstInitial4 <= (sFirstInitial3(19 downto 0) & "000000000000");   -- shift left by 12
				-- sFirstInitial  <= (sFirstInitial4 xor sRegister1);

				-- sSecondInitial1  <= (sSecondInitial(29 downto 0) & "00");   -- shift left by 2 
				-- sSecondInitial2 <= (sSecondInitial1 xor sSecondInitial);
				-- sRegister2 <= ("0000000000000000000000000" & sSecondInitial2(31 downto 25));   -- shift right by 25
				-- sSecondInitial3 <= (sSecondInitial and sSecondConstant);
				-- sSecondInitial4 <= (sSecondInitial3(27 downto 0) & "0000");   -- shift left by 4
				-- sSecondInitial  <= (sSecondInitial4 xor sRegister2);

				-- sThirdInitial1  <= (sThirdInitial(28 downto 0) & "000");   -- shift left by 3 
				-- sThirdInitial2 <= (sThirdInitial1 xor sThirdInitial);
				-- sRegister3 <= ("00000000000" & sThirdInitial2(31 downto 11));   -- shift right by 11
				-- sThirdInitial3 <= (sThirdInitial and sThirdConstant);
				-- sThirdInitial4 <= (sThirdInitial3(14 downto 0) & "00000000000000000");   -- shift left by 17
				-- sThirdInitial  <= (sThirdInitial4 xor sRegister3);
            end if;
        end if;
    end process combinedTauswortheGenerator;

end architecture rtl;
	