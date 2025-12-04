-- Top Module (Integrates Datapath and Control Unit)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top is
    Port (
        clk      : in STD_LOGIC;
        rst      : in STD_LOGIC;
        ALU_Data : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Top;

architecture Behavioral of Top is

    -- Internal signals connecting Datapath and Control Unit
    signal instr_addr : STD_LOGIC_VECTOR(3 downto 0);
    signal instruction : STD_LOGIC_VECTOR(15 downto 0);
    signal opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal rd_addr, rs_addr, rt_addr : STD_LOGIC_VECTOR(2 downto 0);
    signal immediate : STD_LOGIC_VECTOR(5 downto 0);
    signal alu_src : STD_LOGIC;
    signal reg_write : STD_LOGIC;
    signal immediate_extended : STD_LOGIC_VECTOR(15 downto 0);
    signal rs_data, rt_data : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_result : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_operand_2 : STD_LOGIC_VECTOR(15 downto 0);  -- Output of RTL MUX    

begin

    -- Instantiate Program Counter
    PC_inst: entity work.PC
        port map (
            clk => clk,
            rst => rst,
            next_instr => instr_addr
        );

    -- Instantiate Instruction Memory
    Instr_Mem_inst: entity work.Instruction_Mem
        port map (
            instr_addr => instr_addr,
            instruction => instruction,
            rs_addr => rs_addr,
            rt_addr => rt_addr,
            rd_addr => rd_addr,
            immediate => immediate
        );
        
    -- Instantiate Control Unit
    Control_inst: entity work.Control_Unit
        port map (
            instruction => instruction,
            opcode => opcode,
            alu_src => alu_src,
            reg_write => reg_write
        );        
        
    -- Instantiate Zero Extend module
    ZeroExt_inst: entity work.ZeroExtend
        port map (
            data_in => immediate,
            data_out => immediate_extended
        );

    -- Instantiate RTL MUX (selects between RT data or immediate)
    RTL_MUX_inst: entity work.Mux2to1
        port map (
            input0 => rt_data,
            input1 => immediate_extended,
            sel => alu_src,
            output => alu_operand_2
        );

    -- Instantiate ALU
    ALU_inst: entity work.ALU
        port map (
            op => opcode,
            rs => rs_data,
            rt => alu_operand_2,
            rd => alu_result
        );

    -- Instantiate Register File
    Reg_File_inst: entity work.Register_File
        port map (
            clk => clk,
            rst => rst,
            we => reg_write,
            rd_addr => rd_addr,
            rs_addr => rs_addr,
            rt_addr => rt_addr,
            write_data => alu_result,
            rs_data => rs_data,
            rt_data => rt_data
        );

    -- ALU Output data
    ALU_Data <= alu_result;

end Behavioral;







