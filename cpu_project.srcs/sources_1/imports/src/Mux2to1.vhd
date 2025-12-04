----------------------------------------------------------------------------------
-- 2-to-1 Multiplexer (16-bit)
-- Selects between two 16-bit inputs based on select signal
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1 is
    Port (
        input0 : in STD_LOGIC_VECTOR (15 downto 0);
        input1 : in STD_LOGIC_VECTOR (15 downto 0);
        sel : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Mux2to1;

architecture Behavioral of Mux2to1 is
begin
    output <= input0 when sel = '0' else input1;
end Behavioral;
