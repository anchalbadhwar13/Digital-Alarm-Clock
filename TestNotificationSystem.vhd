LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TestNotificationSystem IS
END TestNotificationSystem;

ARCHITECTURE Behavioral OF TestNotificationSystem IS

   
    COMPONENT AlarmNotification
        PORT (
            CLOCK_50 : IN STD_LOGIC;
            SW : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT;

   
    SIGNAL CLOCK_50 : STD_LOGIC := '0';
    SIGNAL SW : STD_LOGIC_VECTOR(0 DOWNTO 0) := "0";
    SIGNAL HEX5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL HEX4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL HEX3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL LEDR : STD_LOGIC_VECTOR(9 DOWNTO 0);

    CONSTANT clock_period : TIME := 20 ns; 

BEGIN


    UUT: AlarmNotification
        PORT MAP (
            CLOCK_50 => CLOCK_50,
            SW => SW,
            HEX5 => HEX5,
            HEX4 => HEX4,
            HEX3 => HEX3,
            LEDR => LEDR
        );

 


END Behavioral;
