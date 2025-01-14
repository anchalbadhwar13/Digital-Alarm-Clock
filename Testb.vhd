--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--
--ENTITY Testb IS
--    PORT (
--        KEY  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);    -- Clock input (KEY)
--        SW   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);   -- Switch input (SW)
--        LEDR : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- 7-bit LED indicator for FSM states
--    );
--END Testb;
--
--ARCHITECTURE Behavioral OF Testb IS
--
--BEGIN
--
--    -- Instantiate the digital clock FSM entity (UUT)
--    UUT: ENTITY work.digital_clock_fsm
--        PORT MAP (
--            clk => KEY(0),          -- Clock input connected to KEY(0)
--            reset => '0',           -- Assume no reset signal here for simplicity
--            w => SW(1 DOWNTO 0),    -- Switch input connected to SW(1 DOWNTO 0)
--            led => LEDR             -- LED output for state indication
--        );
--
--END Behavioral;
