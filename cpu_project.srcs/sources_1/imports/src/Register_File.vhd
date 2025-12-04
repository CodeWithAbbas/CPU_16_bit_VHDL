----------------------------------------------------------------------------------
-- Simple Register File (8 registers, 16-bit each)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        we : in STD_LOGIC;  -- write enable
        rd_addr : in STD_LOGIC_VECTOR (2 downto 0);  -- 3-bit address (8 registers)
        rs_addr : in STD_LOGIC_VECTOR (2 downto 0);  -- 3-bit address
        rt_addr : in STD_LOGIC_VECTOR (2 downto 0);  -- 3-bit address
        write_data : in STD_LOGIC_VECTOR (15 downto 0);  -- 16-bit data to write
        rs_data : out STD_LOGIC_VECTOR (15 downto 0);   -- 16-bit output from rs
        rt_data : out STD_LOGIC_VECTOR (15 downto 0)    -- 16-bit output from rt
    );
end Register_File;

architecture Behavioral of Register_File is
    -- 8 registers, each 16 bits
    type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin

    -- Write process
    process(clk, rst)
    begin
        if rst = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if we = '1' then
                registers(to_integer(unsigned(rd_addr))) <= write_data;
            end if;
        end if;
    end process;

    -- Read process (asynchronous)
    rs_data <= registers(to_integer(unsigned(rs_addr)));
    rt_data <= registers(to_integer(unsigned(rt_addr)));

end Behavioral;
