# Clock constraint for 6.992 ns = 143.01 MHz clock
create_clock -period 6.992 -name sys_clk -waveform {0.000 4.100} [get_ports clk]

