library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

Entity TxSerial Is
Port(
	RstB		: in	std_logic;
	Clk			: in	std_logic;
	
	TxFfEmpty	: in	std_logic;
	TxFfRdData	: in	std_logic_vector( 7 downto 0 );
	TxFfRdEn	: out	std_logic;
	
	SerDataOut	: out	std_logic
);
End Entity TxSerial;

Architecture rtl Of TxSerial Is

----------------------------------------------------------------------------------
-- Constant declaration
----------------------------------------------------------------------------------
	constant 	cBaudCnt	: integer := 108 ;	 --Baud Rate = 921,600 from 100 MHz Clk --CpuClk = 100 MHz



----------------------------------------------------------------------------------
-- Signal declaration
----------------------------------------------------------------------------------
	type		SerStateType	is
								(
									stIdle	,
									stRdReq	,
									stWtData,
									stWtEnd
								);
	signal	rState	:	SerStateType;
	
	signal		rTxFfRdEn	:	std_logic_vector( 1 downto 0);
	signal		rSerData	:	std_logic_vector( 9 downto 0);
	signal		rBaudCnt	:	std_logic_vector( 9 downto 0);
	signal		rBaudEnd	: 	std_logic;
	signal 		rDataCnt	:	std_logic_vector( 3 downto 0);

Begin

----------------------------------------------------------------------------------
-- Output assignment
----------------------------------------------------------------------------------
	TxFfRdEn	<= rTxFfRdEn(1);
	SerDataOut	<= rSerData(0);

----------------------------------------------------------------------------------
-- DFF 
----------------------------------------------------------------------------------
    
	----- State Machine  -----
	u_rState : Process (Clk) Is
	Begin
		if ( rising_edge(Clk) ) then
			if ( RstB='0' ) then
				rState		<= stIdle;
			else
				case ( rState ) is				
					-- Idle
					when stIdle		=>	
						if ( TxFfEmpty ='0' ) then
							rState	<= stRdReq;							
						else
							rState	<= stIdle;
						end if;
					-- Read	Req
					when stRdReq	=>
							rState	<= stWtData;
					-- Write Data
					when stWtData	=>
						if	(rTxFfRdEn(1) = '1' ) then
							rState	<= stWtEnd;
						else
							rState	<= stWtData;
						end if;
					-- Write End
					when stWtEnd	=>
						if ( rDataCnt = "1001" and rBaudEnd = '1' ) then
							rState	<= stIdle;
						else
							rState	<= stWtEnd;
						end if;
				end case;
			end if;
		end if;
	End Process u_rState;
	
	----- Read Enable -----
	u_rTxFfRdEn	:	Process	(Clk) is
	Begin
		if ( rising_edge(Clk)	) then
			if ( RstB = '0' ) then
				rTxFfRdEn	<= "00" ;
			else
				rTxFfRdEn(1)	<= rTxFfRdEn(0);	----- Shift bit0 to bit1
				if	( rState = stRdReq ) then		----- Read Enable = 1 next Clk 
					rTxFfRdEn(0)	<= '1' ;
				else
					rTxFfRdEn(0)	<= '0' ;
				end if;
			end if;
		end if;
	End Process u_rTxFfRdEn;
	
	----- Ser Data + Start & End bit-----
	u_rSerData	:	Process	(Clk) is
	Begin
		if	( rising_edge(Clk) ) then
			if	( RstB = '0' ) then
				rSerData	<=	(others => '1');	----- Not Started
			else
				if	( rTxFfRdEn(1) = '1')  then
					rSerData(9)				<=	'1' ;		----- Stop Bit 	( at MSB - Right )
					rSerData(8 downto 1)	<= TxFfRdData;	----- Data
					rSerData(0)				<=  '0'	;		----- Start 	( at LSB - Left)
				elsif	( rBaudEnd = '1' ) then
					rSerData				<= '1' & rSerData(9 downto 1);	----- shift
				else
					rSerData				<= rSerData;	----- Hold
				end if;
			end if;
		end if;
	
	End Process	u_rSerData;
	
	----- Data Count (Shift) -----
	u_rDataCnt	: 	Process (Clk) is
	Begin
		if rising_edge(Clk)	then
			if	( RstB = '0' ) then
				rDataCnt	<= "0000";
			else
				if	( rBaudEnd = '1' ) then ----- Count Data when DataEnd
					if ( rDataCnt = "1001")	then
						rDataCnt <= "0000";
					else
						rDataCnt <= rDataCnt + 1;
					end if;
				else
					rDataCnt <= rDataCnt;
				end if;
			end if;
		end if;	
	End Process u_rDataCnt;
	
	----- Baud Count  -----
	u_rBuadCnt	:	Process	(Clk) is
	Begin	
		if ( rising_edge(Clk) ) then
			if	(RstB = '0') then
				rBaudCnt	<=	conv_std_logic_vector(cBaudCnt, 10); 
		else	
				if ( rState = stWtEnd ) then
					if	( rBaudCnt = 1 ) then
						rBaudCnt	<=	conv_std_logic_vector(cBaudCnt, 10);
					else
						rBaudCnt	<=	rBaudCnt - 1;
					end if;
				else
					rBaudCnt		<= rBaudCnt;
				end if;
			end if;
		end if;
	End Process u_rBuadCnt;
	
	----- Baud End -----
	u_rBuadEnd	:	Process	(Clk) is
	Begin
		if ( rising_edge(Clk) ) then
			if	(RstB = '0') then
				rBaudEnd	<=	'0';
			else
				if	( rBaudCnt = 2) then
					rBaudEnd	<=	'1';
				else
					rBaudEnd	<=	'0';
				end if;
			end if;	
		end if;
	End Process u_rBuadEnd;
	
End Architecture rtl;