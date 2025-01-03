LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY AlarmNotification IS
    PORT (
        clock       : IN STD_LOGIC;
   --     alarm_trigger : IN STD_LOGIC;         
        Enable      : IN STD_LOGIC;           
--        Seg0        : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  
--        Seg1        : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  
        red         : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   
    );
END AlarmNotification;

ARCHITECTURE Behavioral OF AlarmNotification IS

    SIGNAL clock_div  : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');  
    SIGNAL flash     : STD_LOGIC := '0';                         
  --  SIGNAL alarm_display : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";  
  --  SIGNAL decoded_alarm : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011011";           
  --  SIGNAL blank      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";  
    
    COMPONENT PreScale
        GENERIC (
            WIDTH : integer := 25  
        );
        PORT (
            InClock : IN STD_LOGIC;  
            OutClock : OUT STD_LOGIC  
        );
    END COMPONENT;
    
  --  COMPONENT segdecoder
  --      PORT (
  --          input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  
  --          output : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  
  --      );
  --  END COMPONENT;

BEGIN
   
   -- SegDecoder_alarm: SegDecoder PORT MAP(input => alarm_display, output => decoded_alarm);
    ClockDivider: PreScale
        GENERIC MAP (WIDTH => 25) 
        PORT MAP (
            InClock => clock,    -- Main clock input
            OutClock => flash    -- Output flashing signal
        );

   
    PROCESS(flash, Enable)
    BEGIN
        IF Enable = '1' THEN
           -- IF alarm_trigger = '1' THEN  
                IF flash = '1' THEN
                  
                    --Seg0 <= decoded_alarm;   
                    --Seg1 <= decoded_alarm;   
                    red <= (OTHERS => '1');  
                ELSE
                
                    ---Seg0 <= blank;
                    --Seg1 <= blank;
                    red <= (OTHERS => '0'); 
                END IF;
            --ELSE
               
                --Seg0 <= blank;
                --Seg1 <= blank;
                red <= (OTHERS => '0');  
            --END IF;
        ELSE
            
            --Seg0 <= blank;
            --Seg1 <= blank;
            red <= (OTHERS => '0');  
        END IF;
    END PROCESS;

END Behavioral;