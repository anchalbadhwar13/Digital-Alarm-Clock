library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ResetSystem is
    Port ( clk       : in  STD_LOGIC;
           key       : in  STD_LOGIC_VECTOR(2 downto 1);  
           soft_reset : out STD_LOGIC;
           hard_reset : out STD_LOGIC);
end ResetSystem;

architecture Behavioral of ResetSystem is
    signal soft_reset_reg : STD_LOGIC := '0';
    signal hard_reset_reg : STD_LOGIC := '0';
begin

    
    process(clk)
    begin
        if rising_edge(clk) then
            -- Soft reset when key(2) is pressed (active low)
            if key(2) = '0' then
                soft_reset_reg <= '1';  
            else
                soft_reset_reg <= '0'; 
            end if;

           
            if key(1) = '0' then
                hard_reset_reg <= '1';  
            else
                hard_reset_reg <= '0'; 
            end if;
        end if;
    end process;

    soft_reset <= soft_reset_reg;


    hard_reset <= hard_reset_reg;

end Behavioral;