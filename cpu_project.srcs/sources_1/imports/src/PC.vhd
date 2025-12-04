----------------------------------------------------------------------------------
-- Simple Program Counter
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        next_instr : out STD_LOGIC_VECTOR (3 downto 0)  -- 4-bit address (16 locations)
    );
end PC;

architecture Behavioral of PC is
    signal current_signal : std_logic_vector(3 downto 0) := "0000";
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_signal <= "0000";
        elsif rising_edge(clk) then
            current_signal <= std_logic_vector(unsigned(current_signal) + to_unsigned(1, 4));  -- Increment by 1
        end if;
    end process;

    next_instr <= current_signal;

end Behavioral;
