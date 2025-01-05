library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalClock is
    Port (
        clk_50 : in STD_LOGIC;
        reset  : in STD_LOGIC;
        KEY    : in STD_LOGIC_VECTOR(3 downto 0);
        SW     : in STD_LOGIC_VECTOR(9 downto 0);
        LEDR   : out STD_LOGIC_VECTOR(9 downto 0);
        hex0, hex1, hex2, hex3, hex4, hex5 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end DigitalClock;

architecture Behavioral of DigitalClock is
    signal clk_1s : STD_LOGIC;
    signal seco, sect, mino, mint, houro, hourt : STD_LOGIC_VECTOR(3 downto 0);
    signal enable_alarm, soft_reset, hard_reset : STD_LOGIC;

begin
    
    reset_system_inst: entity work.ResetSystem
        port map (
            clk        => clk_50,
            key        => KEY(2 downto 1),
            soft_reset => soft_reset,
            hard_reset => hard_reset
        );

    
    clock_divider_inst: entity work.clock_divider
        port map (
            clk_50 => clk_50,
            clk_1s => clk_1s,
            reset  => hard_reset
        );

   fsm_inst: entity work.digital_clock_fsm
        port map (
            clk   => KEY(0),          
            w     => SW(1 downto 0), 
            led   => LEDR(2 downto 0) 
        );
    clock_logic: process(clk_1s, soft_reset)
    begin
        if soft_reset = '1' then
            seco  <= "0000";
            sect  <= "0000";
            mino  <= "0000";
            mint  <= "0000";
            houro <= "0000";
            hourt <= "0000";
        elsif rising_edge(clk_1s) then
            if seco = "1001" then
                seco <= "0000";
                if sect = "0101" then
                    sect <= "0000";
                    if mino = "1001" then
                        mino <= "0000";
                        if mint = "0101" then
                            mint <= "0000";
                            if houro = "1001" then
                                houro <= "0000";
                                if hourt = "0010" then
                                    hourt <= "0000";
                                else
                                    hourt <= hourt + 1;
                                end if;
                            else
                                houro <= houro + 1;
                            end if;
                        else
                            mint <= mint + 1;
                        end if;
                    else
                        mino <= mino + 1;
                    end if;
                else
                    sect <= sect + 1;
                end if;
            else
                seco <= seco + 1;
            end if;
        end if;
    end process;

  
    process(SW)
    begin
        if SW(4) = '1' then
            enable_alarm <= '1';
        else
            enable_alarm <= '0';
        end if;
    end process;

    alarm_notification_inst: entity work.AlarmNotification
        port map (
            clock        => clk_50,
        --    alarm_trigger => '1', -- Example: Can be replaced with actual logic
            Enable       => enable_alarm,
            red          => LEDR(9 downto 3)
        );

    -- Seven Segment Decoders
    segdecoder_sec_ones: entity work.segdecoder port map (input => seco, output => hex0);
    segdecoder_sec_tens: entity work.segdecoder port map (input => sect, output => hex1);
    segdecoder_min_ones: entity work.segdecoder port map (input => mino, output => hex2);
    segdecoder_min_tens: entity work.segdecoder port map (input => mint, output => hex3);
    segdecoder_hour_ones: entity work.segdecoder port map (input => houro, output => hex4);
    segdecoder_hour_tens: entity work.segdecoder port map (input => hourt, output => hex5);

end Behavioral;

