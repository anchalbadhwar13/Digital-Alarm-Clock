library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PreScale is
    Generic (
        WIDTH : integer := 25  
    );
    Port (
        InClock  : in  std_logic;   
        OutClock : out std_logic    
    );
end PreScale;

architecture Behavioral of PreScale is
    signal counter : std_logic_vector(WIDTH-1 downto 0) := (others => '0'); 
begin
    process(InClock)
    begin
        if rising_edge(InClock) then
            counter <= counter + 1;    
        end if;
    end process;

    OutClock <= counter(WIDTH-1);  
end Behavioral;