----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:09 06/10/2021 
-- Design Name: 
-- Module Name:    CLKgen - Behavioral 
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

entity CLKgen is
   Port ( CLK_IN     : in  STD_LOGIC;
           RST        : in  STD_LOGIC;
			  CLK_FAST   : out STD_LOGIC;
           CLK_SYS    : out STD_LOGIC;
			  CLK_SYS_4ml: out STD_LOGIC;
			  CLK_DATACLK_fs : out STD_LOGIC;
			  CLK_DATACLK_dv : out STD_LOGIC;
           CLK_LOCKED : out  STD_LOGIC
			  );
end CLKgen;

architecture Behavioral of CLKgen is

  signal CLK1_OUT,CLK2_OUT,CLK3_OUT,CLK4_OUT,CLK0_OUT : std_logic;
  signal CLK_MMCM,CLKFB_IN,CLKFB_OUT : std_logic;
  
  
begin

---- input ---------------------------------
   IBUFG_inst : IBUFG
   generic map (
      IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for refernced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O => CLK_MMCM, -- Clock buffer output
      I => CLK_IN  -- Clock buffer input (connect directly to top-level port)
   );
---- output ---------------------------------
BUFGDATAclkFast_inst : BUFG
   port map (
      O => CLK_DATACLK_fs, -- 1-bit Clock buffer output
      I => CLK0_OUT  -- 1-bit Clock buffer input
   );	
BUFGCLKFAST_inst : BUFG
   port map (
      O => CLK_FAST, -- 1-bit Clock buffer output
      I => CLK1_OUT  -- 1-bit Clock buffer input
   );			
	
BUFGCLKSYSTEM_inst : BUFG --CLK_DATACLK
   port map (
      O => CLK_SYS, -- 1-bit Clock buffer output
      I => CLK2_OUT  -- 1-bit Clock buffer input
   );		

BUFGCLKSYS2dv_inst : BUFG --CLK_DATACLK
   port map (
      O => CLK_SYS_4ml, -- 1-bit Clock buffer output
      I => CLK3_OUT  -- 1-bit Clock buffer input
		);	

BUFGDATACLKdv_inst : BUFG --CLK_DATACLK
   port map (
      O => CLK_DATACLK_dv, -- 1-bit Clock buffer output
      I => CLK4_OUT  -- 1-bit Clock buffer input
		);			
--- CLK Feed back -------------------------------	
  BUFGCLKFB_inst : BUFG
   port map (
      O => CLKFB_IN, -- 1-bit Clock buffer output
      I => CLKFB_OUT  -- 1-bit Clock buffer input
   );	
	
-- clk 200 MHz
MMCM_BASE_inst : MMCM_BASE
   generic map (
      BANDWIDTH => "OPTIMIZED",  -- Jitter programming (HIGH,LOW,OPTIMIZED)
      CLKFBOUT_MULT_F=> 43.0,    -- Multiply value for all CLKOUT (5.0-64.0).  -- 25
      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB (0.00-360.00).
      CLKIN1_PERIOD  => 5.0,      -- Input clock period in nS to ps resolution (i.e. 33.333 is 33 MHz).
      -- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      CLKOUT1_DIVIDE => 11,   ---CLK_FAST    -- 10 for 100, 3 for 400MHz 
      CLKOUT2_DIVIDE => 11*2,   ---CLK_SYS   
      CLKOUT3_DIVIDE => 4,   ---CLK_SYS_4ml   
      CLKOUT4_DIVIDE => 4,    ---CLK_DATACLK_dv  
      CLKOUT5_DIVIDE => 4,    ---
      CLKOUT6_DIVIDE => 1,
      CLKOUT0_DIVIDE_F => 10.750,   -- Divide amount for CLKOUT0 (1.000-128.000).
      -- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      CLKOUT2_DUTY_CYCLE => 0.5,
      CLKOUT3_DUTY_CYCLE => 0.5,
      CLKOUT4_DUTY_CYCLE => 0.5,
      CLKOUT5_DUTY_CYCLE => 0.5,
      CLKOUT6_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 0.0,
      CLKOUT2_PHASE => 0.0,
      CLKOUT3_PHASE => 0.0,
      CLKOUT4_PHASE => 0.0,
      CLKOUT5_PHASE => 0.0,
      CLKOUT6_PHASE => 0.0,
      CLKOUT4_CASCADE => FALSE,  -- Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)
      CLOCK_HOLD => FALSE,       -- Hold VCO Frequency (TRUE/FALSE)
      DIVCLK_DIVIDE => 8,        -- Master division value (1-80)
      REF_JITTER1 => 0.0,        -- Reference input jitter in UI (0.000-0.999).
      STARTUP_WAIT => FALSE      -- Not supported. Must be set to FALSE.
   )
   port map (
      -- Clock Outputs: 1-bit (each) User configurable clock outputs
      CLKOUT0  => CLK0_OUT, -- for CLKDATA fast clk 
      CLKOUT0B => open,--CLKOUT0B,   -- 1-bit Inverted CLKOUT0 output
      CLKOUT1  => CLK1_OUT, -- for DATA fast clk
      CLKOUT1B => open,--CLKOUT1B,   -- 1-bit Inverted CLKOUT1 output
      CLKOUT2  => CLK2_OUT, --  for System CLK
      CLKOUT2B => open,--CLKOUT2B,   -- 1-bit Inverted CLKOUT2 output
      CLKOUT3  => CLK3_OUT,  -- for System 2 dv clk
      CLKOUT3B => open,--CLKOUT3B,   -- 1-bit Inverted CLKOUT3 output
      CLKOUT4  => CLK4_OUT,  -- for CLKDATA dv CLK
      CLKOUT5  => open,--CLKOUT5,     -- 1-bit CLKOUT5 output
      CLKOUT6  => open,--CLKOUT6,     -- 1-bit CLKOUT6 output
      -- Feedback Clocks: 1-bit (each) Clock feedback ports
      CLKFBOUT  => CLKFB_OUT,   -- 1-bit Feedback clock output
      CLKFBOUTB => open,--CLKFB_OUT, -- 1-bit Inverted CLKFBOUT output
      -- Status Port: 1-bit (each) MMCM status ports
      LOCKED    => CLK_LOCKED,       -- 1-bit LOCK output
      -- Clock Input: 1-bit (each) Clock input
      CLKIN1    => CLK_MMCM,--CLKIN1,
      -- Control Ports: 1-bit (each) MMCM control ports
      PWRDWN    => '0',       -- 1-bit Power-down input
      RST       => RST,             -- 1-bit Reset input
      -- Feedback Clocks: 1-bit (each) Clock feedback ports
      CLKFBIN   => CLKFB_IN      -- 1-bit Feedback clock input
   );


end Behavioral;

