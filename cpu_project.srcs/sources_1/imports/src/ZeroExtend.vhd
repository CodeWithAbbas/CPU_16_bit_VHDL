----------------------------------------------------------------------------------
-- Zero Extend Module
-- Extends 6-bit unsigned immediate to 16-bit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ZeroExtend is
    Port (
        data_in : in STD_LOGIC_VECTOR (5 downto 0);
        data_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end ZeroExtend;

architecture Behavioral of ZeroExtend is
begin
    data_out <= "0000000000" & data_in;
end Behavioral;
