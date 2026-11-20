###################################################################

# Created by write_sdc on Tue Oct 20 19:13:41 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports clk_in]  -period 10  -waveform {0 5}
create_generated_clock [get_ports dfs_clk_out]  -name dfs_clk  -source [get_ports clk_in]  -divide_by 16
