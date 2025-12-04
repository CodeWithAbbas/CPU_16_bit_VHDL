----------------------------------------------------------------------------------
-- Testbench for Top Module (CPU_16bit_Simple_Dual)
-- Tests both R-Type and I-Type instruction execution
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_tb is
end Top_tb;

architecture Behavioral of Top_tb is

    -- Component declaration
    component Top is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ALU_Data : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    -- Test signals
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal ALU_Data : STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Top
        port map (
            clk => clk,
            rst => rst,
            ALU_Data => ALU_Data
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';

        -- Wait for system to stabilize
        wait for clk_period * 5;

        -- Let the CPU run through all 16 instructions
        -- Each instruction takes 1 clock cycle in this simple design
        wait for clk_period * 20;

        -- End simulation
        report "Simulation Complete!" severity note;
        wait;
    end process;

end Behavioral;
