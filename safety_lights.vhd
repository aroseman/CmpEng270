------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date			: 2/15/2016
-- Lab # and name	: 
-- Student 1		: Andrew Roseman
-- Student 2		: 

-- Description		: Saftey and Vaccinatation warning light control for zoo lab


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity safety_light is port
	( 
		sw_0	: in std_logic		; 	
		sw_15	: in std_logic		;
		btnr_17_reset : in std_logic;
		btnr_18_clock   : in std_logic      ;			
		
--		ns_0  	    : out std_logic		;	
--		ns_1     	: out std_logic		;
		seg_r       : out std_logic;
		seg_m       : out std_logic;
		seg_l       : out std_logic	
	);
end safety_light;
----------------------------------------------------------------------

-- Architecture 
architecture safety_light_a of safety_light is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component dff270_r is port
	(
		 clk 	: in std_logic ;
--		 clken	: in std_logic ;
		 rst 	: in std_logic ;
		 d 	: in std_logic ;
		 q 	: out std_logic
    );
    end component;
    
   
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal nps0 : std_logic ;     
	signal nps1 : std_logic;     
	signal nsw15 : std_logic;     
	
	signal ns0 : std_logic; 
	signal ns1 : std_logic;
	
	signal ps0 : std_logic;
	signal ps1 : std_logic;
	
	signal clk0 : std_logic;
	signal clk1 : std_logic;
	

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	 dff270_a : dff270_r  port map
	(
		 clk => btnr_18_clock ,
--		 clken	: in std_logic ;
		 rst => btnr_17_reset,
		 d	=> ns0,
		 q 	=> ps0
    );
    
    
     dff270_b : dff270_r  port map
        (
             clk => btnr_18_clock ,
    --        clken    : in std_logic ;
             rst => btnr_17_reset ,
             d => ns1 ,
             q => ps1 
        );
        
        
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	nsw15 <= NOT sw_15;
	nps0 <= NOT ps0;
	nps1 <= NOT ps1;
	
	ns0 <= (nps0 AND nps1) OR (ps0 AND ps1) OR (ps0 AND nps1);
	ns1 <= (nps0 AND nps1 AND nsw15) OR (ps0 AND ps1 AND nsw15 AND sw_0) OR (ps0 AND nps1 AND nsw15 AND sw_0);
	
--	d <= ns0;
--	d <= ns1;
	
--	ps0 <= q;
--	ps1 <= q; 	
	
	seg_r <= ps1;
	seg_m <= NOT (ps0 OR ps1);	
	seg_l <= ps0 XOR ps1;
		 
end safety_light_a; -- .same name as the architecture