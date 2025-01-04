library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity digital_clock_fsm is
    Port (
        clk     : in STD_LOGIC;                     
      --  reset   : in STD_LOGIC;                     
        w       : in STD_LOGIC_VECTOR(1 downto 0);  
        led     : out STD_LOGIC_VECTOR(2 downto 0) 
 
  );
end digital_clock_fsm;

architecture Behavioral of digital_clock_fsm is


    type state_type is (DISPLAY_TIME, SET_TIME, SET_ALARM); 
    signal state : state_type := DISPLAY_TIME; 
    signal next_state : state_type;  

    signal led_display_time : STD_LOGIC_VECTOR(2 downto 0) := "001"; 
    signal led_set_time     : STD_LOGIC_VECTOR(2 downto 0) := "010"; 
    signal led_set_alarm    : STD_LOGIC_VECTOR(2 downto 0) := "100"; 

begin


    process (clk)
	 --, reset)
    begin
        --if reset = '1' then
         --   state <= DISPLAY_TIME;  
       -- els
		  if rising_edge(clk) then
            state <= next_state;  
        end if;
    end process;

   
    process (state, w)
    begin
        case state is
            when DISPLAY_TIME =>  
                case w is
                    when "00" => next_state <= SET_TIME;     -- Transition to SET_TIME
                    when "01" => next_state <= DISPLAY_TIME; -- Stay in DISPLAY_TIME
                    when "10" => next_state <= SET_ALARM;    -- Transition to SET_ALARM
                    when others => next_state <= SET_TIME;   -- Default case, return to SET_TIME
                end case;

            when SET_TIME =>  
                case w is
                    when "00" => next_state <= SET_TIME;     -- Stay in SET_TIME
                    when "01" => next_state <= DISPLAY_TIME; -- Transition to DISPLAY_TIME
                    when "10" => next_state <= SET_ALARM;    -- Transition to SET_ALARM
                    when others => next_state <= DISPLAY_TIME; -- Default case, return to DISPLAY_TIME
                end case;

            when SET_ALARM => 
                case w is
                    when "00" => next_state <= SET_TIME;    
                    when "01" => next_state <= DISPLAY_TIME;
                    when "10" => next_state <= SET_ALARM;    
                    when others => next_state <= SET_TIME;   
                end case;

            when others =>  
                next_state <= DISPLAY_TIME;  
        end case;
    end process;


    process (state)
    begin
        case state is
            when DISPLAY_TIME => 
                led <= led_display_time;     
            when SET_TIME =>  
                led <= led_set_time;         
            when SET_ALARM =>  
                led <= led_set_alarm;       
            when others =>  
                led <= led_display_time;     
        end case;
    end process;

end Behavioral;
