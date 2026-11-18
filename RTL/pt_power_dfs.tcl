# =======================================================================
# PrimeTime PX Script: pt_power_dfs.tcl
# =======================================================================

# 1. Enable Power Analysis
set power_enable_analysis true
set power_analysis_mode averaged

# 2. Set Technology Libraries 
# (Update these paths to match your exact SAED32 lab installation path)
set search_path ". /home/tops5/Desktop/AHB2APB/tech/db/" 
set link_library "* saed32rvt_ss0p95v125c.db"

# 3. Read the Gate-Level Netlist
read_verilog dfs_top_gate.v
current_design dfs_top
link

# 4. Set Clock Constraints (100 MHz = 10ns period)
create_clock -name clk_in -period 10 [get_ports clk_in]

# 5. Apply RTL-to-Gate Name Mapping
# This ensures 100% annotation by fixing the DC register renaming
source pt_namemap.tcl

# 6. Read Switching Activity (SAIF)
# The strip_path matches your new split testbench hierarchy
read_saif -strip_path tb_dfs_saif/DUT_DFS dfs_bridge.saif

# 8. Calculate and Export Power
update_power
report_power -hierarchy > report_power_dfs.txt

puts "=================================================================="
puts "PrimeTime DFS Power Extraction Complete!"
puts "Check 'report_power_dfs.txt' for final microwatt numbers."
puts "Check 'annotation_coverage_dfs.rpt' to verify >95% leaf cell coverage."
puts "=================================================================="
quit