----------------------------------------------------------------------------------
-- Simple ALU with 8 operations
-- Based on provided code style
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        op   : in  STD_LOGIC_VECTOR (2 downto 0);      -- 3-bit operation code
        rs   : in  STD_LOGIC_VECTOR (15 downto 0);     -- Source 1
        rt   : in  STD_LOGIC_VECTOR (15 downto 0);     -- Source 2 (Rt : R-Type || immediate data :  I-Type)
        rd   : out STD_LOGIC_VECTOR (15 downto 0)      -- Result
    );
end ALU;

architecture Behavioral of ALU is
    signal result : STD_LOGIC_VECTOR(15 downto 0);
begin

    process(op, rs, rt)
    begin
        if (op = "000") then
            result <= rs + rt;         -- ADD operation || AddImmediate(based on source(rt) selection from RTL Mux)

        elsif (op = "001") then
            result <= rs - rt;         -- SUB operation

        elsif (op = "010") then
            result <= rs and rt;       -- AND operation

        elsif (op = "011") then
            result <= rs or rt;        -- OR operation

        elsif (op = "100") then
            result <= not rs;          -- NOT operation

        elsif (op = "101") then
            result <= rs xor rt;       -- XOR operation

        elsif (op = "110") then
            result <= rs xnor rt;      -- XNOR operation

        elsif (op = "111") then
            result <= rs nor rt;       -- NOR operation 
            
        else
            result <= x"0000";         -- Default
        end if;
    end process;

    -- Output Result of the ALU
    rd <= result;

end Behavioral;
