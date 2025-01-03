library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
	port (
   clk_50: in std_logic;
   clk_1s: out std_logic;
	reset : in std_logic
	);
end clock_divider;

architecture Behavioral of clock_divider is
 signal counter : INTEGER range 0 to 49999999;
    signal clock_divider : STD_LOGIC;
begin
 process(clk_50, reset)
 begin
  --if(rising_edge(clk_50)) then
--   counter <= counter + x"0000001";
--   if(counter>=x"2FAF080") then -- for running on FPGA -- comment when running simulation
--   --if(counter_slow>=x"0000001") then -- for running simulation -- comment when running on FPGA
--    counter <= x"0000000";
--   end if;
--  end if;
-- end process;
-- clk_1s <= '0' when counter < x"17D7840" else '1';
--end Behavioral;
 if reset = '1' then
            counter <= 0;
            clock_divider <= '0';
        elsif rising_edge(clk_50) then
            if counter = 49999999 then
                counter <= 0;
                clock_divider <= NOT clock_divider;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_1s <= clock_divider;
end Behavioral;