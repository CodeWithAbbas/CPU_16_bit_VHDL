-- Simple Control Unit - Decodes R-Type and I-Type instructions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control_Unit is
    Port (
        instruction : in STD_LOGIC_VECTOR (15 downto 0);   -- Full 16-bit instruction
        -- Decoded fields
        opcode      : out STD_LOGIC_VECTOR (2 downto 0);   -- 3-bit opcode
        -- Control signals
        alu_src     : out STD_LOGIC;                       -- 0=R-Type, 1=I-Type
        reg_write   : out STD_LOGIC                        -- Write enable for register file
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
    signal format_type: std_logic; -- '0' for R-Type, '1' for I-Type

begin

    -- Extract format bit
    format_type <= instruction(15);

    -- Extract opcode (same location for both formats)
    opcode <= instruction(14 downto 12);

    -- Conditional extraction based on format
    process(format_type, instruction)
    begin
        if format_type = '0' then
            alu_src <= '0';  -- This is for R-Format. Use RT from register file
        else
            alu_src <= '1';  -- This is for I-Format. Use immediate value passed in instruction
        end if;
    end process;

    -- Register write enable (always 1 for our simple CPU)
    reg_write <= '1';

end Behavioral;
