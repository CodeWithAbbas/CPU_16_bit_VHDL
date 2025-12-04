----------------------------------------------------------------------------------
-- Simple Instruction Memory with R-Type and I-Type instructions
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Mem is
    Port (
        instr_addr   : in STD_LOGIC_VECTOR (3 downto 0);    -- Address (0-15)
        instruction  : out STD_LOGIC_VECTOR (15 downto 0);  -- Full 16-bit instruction
        rs_addr      : out STD_LOGIC_VECTOR (2 downto 0);   -- Source register 1
        rt_addr      : out STD_LOGIC_VECTOR (2 downto 0);   -- Source register 2        
        rd_addr      : out STD_LOGIC_VECTOR (2 downto 0);   -- Destination register (R-Type)
        immediate    : out STD_LOGIC_VECTOR (5 downto 0)    -- Immediate value (I-Type)        
    );
end Instruction_Mem;

architecture Behavioral of Instruction_Mem is
    -- Array of 16 instructions, each 16 bits
    type instruction_set is array (0 to 15) of std_logic_vector (15 downto 0);
    signal format_type: std_logic; -- '0' for R-Type, '1' for I-Type

    -- Instruction formats:
    -- R-Type: [0 | op(3) | rd(3) | rs(3) | rt(3) | unused(3)]
    -- I-Type: [1 | op(3) | rs(3) | rt(3) | imm(6)]

    constant instr : instruction_set := (
        -- Mix of R-Type and I-Type instructions
        "0000001010011000",  -- Address 0:  ADD R1, R2, R3   (R-Type)
        "0001010011100000",  -- Address 1:  SUB R2, R3, R4   (R-Type)
        "1000001010000101",  -- Address 2:  ADDI R1, R2, 5   (I-Type)
        "0010011100101000",  -- Address 3:  AND R3, R4, R5   (R-Type)
        "0111001010011000",  -- Address 4:  NOR R1, R2, R3   (R-Type)
        "0011100101110000",  -- Address 5:  OR R4, R5, R6    (R-Type)
        "0101101110111000",  -- Address 6:  XOR R5, R6, R7   (R-Type)
        "0100110111000000",  -- Address 7:  NOT R6, R7       (R-Type)
        "0110111001010000",  -- Address 8:  XNOR R7, R1, R2  (R-Type)
        "1000101110001111",  -- Address 9:  ADDI R5, R6, 15  (I-Type)
        "0010010011100000",  -- Address 10: AND R2, R3, R4   (R-Type)
        "1000010011010100",  -- Address 11: ADDI R2, R3, 20  (I-Type)
        "0101001010011000",  -- Address 12: XOR R1, R2, R3   (R-Type)
        "0011110111001000",  -- Address 13: OR R6, R7, R1    (R-Type)
        "0111111001011000",  -- Address 14: NOR R7, R1, R3   (R-Type)
        "0100100101000000"   -- Address 15: NOT R4, R5       (R-Type)
    );

begin
    -- Output the full 16-bit instruction
    instruction <= instr(to_integer(unsigned(instr_addr)));
    
    -- Fetching format type to check R format or I Format
    format_type <= instr (to_integer(unsigned (instr_addr))) (15);
    
    -- Conditional extraction based on format
    process(format_type, instr_addr)
    begin
        if format_type = '0' then
            -- R-Type format: [0 | op(3) | rd(3) | rs(3) | rt(3) | unused(3)]
            
            --Output  rd
            rd_addr <= instr (to_integer(unsigned (instr_addr))) (11 downto 9);
            
            --Output rs
            rs_addr <= instr (to_integer(unsigned (instr_addr))) (8 downto 6);
            
            --Output rt
            rt_addr <= instr (to_integer(unsigned (instr_addr))) (5 downto 3);
            
            immediate <= (others => '0');  -- Not used in R-Type
        else
            -- I-Type format: [1 | op(3) | rs(3) | rt(3) | imm(6)]
            
             --Output rs
            rs_addr <= instr (to_integer(unsigned (instr_addr))) (11 downto 9); -- In I-Type, RS acts as destination
            
            --Output rt
            rt_addr <= instr (to_integer(unsigned (instr_addr))) (8 downto 6); -- RT is source
            
            --Output immediate data
            immediate <= instr (to_integer(unsigned (instr_addr))) (5 downto 0); --immediate data 
          
        end if;
    end process;    

end Behavioral;
