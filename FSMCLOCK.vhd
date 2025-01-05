library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSMCLOCK is
    Port (
        clk       : in STD_LOGIC;              -- Clock input signal
       -- reset     : in STD_LOGIC;              -- Reset input signal
        sec_ones  : out STD_LOGIC_VECTOR(3 downto 0); -- Seconds (ones place, 0-9)
        sec_tens  : out STD_LOGIC_VECTOR(3 downto 0); -- Seconds (tens place, 0-5)
        min_ones  : out STD_LOGIC_VECTOR(3 downto 0); -- Minutes (ones place, 0-9)
        min_tens  : out STD_LOGIC_VECTOR(3 downto 0); -- Minutes (tens place, 0-5)
        hour_ones : out STD_LOGIC_VECTOR(3 downto 0); -- Hours (ones place, 0-9)
        hour_tens : out STD_LOGIC_VECTOR(3 downto 0)  -- Hours (tens place, 0-2)
    );
end FSMCLOCK;

architecture Behavioral of FSMCLOCK is
    -- Internal signals for time tracking
    signal sec_ones_reg  : STD_LOGIC_VECTOR(3 downto 0) := "0001"; -- Seconds (ones)
    signal sec_tens_reg  : STD_LOGIC_VECTOR(3 downto 0) := "0100";  -- Seconds (tens)
    signal min_ones_reg  : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- Minutes (ones)
    signal min_tens_reg  : STD_LOGIC_VECTOR(3 downto 0) := "0100";  -- Minutes (tens)
    signal hour_ones_reg : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- Hours (ones)
    signal hour_tens_reg : STD_LOGIC_VECTOR(3 downto 0) := "0001";   -- Hours (tens)
begin
    -- Clock process to handle time increment
    --process(clk, reset)
    process(clk)
	 begin
--        if reset = '1' then
--            -- Reset all time registers to zero
--            sec_ones_reg  <= "0000";
--            sec_tens_reg  <= "0000";
--            min_ones_reg  <= "0000";
--            min_tens_reg  <= "0100";
--            hour_ones_reg <= "0000";
--            hour_tens_reg <= "0000";
--        els
if rising_edge(clk) then
            -- Increment seconds (ones)
            if sec_ones_reg = "1001" then -- If ones digit of seconds is 9
                sec_ones_reg <= "0000";
                -- Increment seconds (tens)
                if sec_tens_reg = "0101" then -- If tens digit of seconds is 5
                    sec_tens_reg <= "0000";
                    -- Increment minutes (ones)
                    if min_ones_reg = "1001" then -- If ones digit of minutes is 9
                        min_ones_reg <= "0000";
                        -- Increment minutes (tens)
                        if min_tens_reg = "0101" then -- If tens digit of minutes is 5
                            min_tens_reg <= "0000";
                            -- Increment hours (ones)
                            if hour_ones_reg = "1001" and hour_tens_reg /= "10" then
                                hour_ones_reg <= "0000";
                                -- Increment hours (tens)
                                if hour_tens_reg = "0010" then -- If hours reach 23
                                    hour_tens_reg <= "0000";    -- Reset hours to 00
                                else
                                    hour_tens_reg <= hour_tens_reg + 1;
                                end if;
                            elsif hour_ones_reg = "0011" and hour_tens_reg = "10" then -- If hours reach 23
                                hour_ones_reg <= "0000";
                                hour_tens_reg <= "0000";    -- Reset hours to 00
                            else
                                hour_ones_reg <= hour_ones_reg + 1;
                            end if;
                        else
                            min_tens_reg <= min_tens_reg + 1;
                        end if;
                    else
                        min_ones_reg <= min_ones_reg + 1;
                    end if;
                else
                    sec_tens_reg <= sec_tens_reg + 1;
                end if;
            else
                sec_ones_reg <= sec_ones_reg + 1;
            end if;
        end if;
    end process;

    -- Output the current time
    sec_ones  <= sec_ones_reg;
    sec_tens  <= sec_tens_reg;
    min_ones  <= min_ones_reg;
    min_tens  <= min_tens_reg;
    hour_ones <= hour_ones_reg;
    hour_tens <= hour_tens_reg;

end Behavioral;
