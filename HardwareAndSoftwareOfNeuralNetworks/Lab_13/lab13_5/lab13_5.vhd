library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity binary_counter_top is
    Port ( CLK : in  STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (3 downto 0));
end binary_counter_top;

architecture Behavioral of binary_counter_top is

signal CLK_DIV : std_logic_vector (2 downto 0);
signal COUNT : std_logic_vector (3 downto 0);
begin

    -- clock divider
    process (CLK)
    begin
        if (CLK'Event and CLK = '1') then
            CLK_DIV <= CLK_DIV + '1';
        end if;
    end process;

    -- counter
    process (CLK_DIV(2))
    begin
        if (CLK_DIV(2)'Event and CLK_DIV(2) = '1') then
            COUNT <= COUNT + '1';
        end if;
    end process;

    -- display the count on the LEDs
    LED <=  COUNT;

end Behavioral;