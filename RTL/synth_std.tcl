# ---------------------------------------------------------
# Synopsys Design Compiler: Standard AHB-APB Bridge
# ---------------------------------------------------------

set DESIGN standard_bridge_top
set target_library "/home/tops5/Desktop/syn_mdu/tech/db/saed32rvt_ss0p95v125c.db"

set link_library "* $target_library"
set_app_var target_library $target_library
set_app_var link_library $link_library

# Read RTL (Only the standard bridge is needed)
analyze -format sverilog {standard_bridge_top.sv}

elaborate $DESIGN
current_design $DESIGN
link
check_design

# Base clock: 100 MHz
create_clock -name clk -period 10.0 [get_ports clk]

compile_ultra -no_autoungroup

report_timing -max_paths 20 > std_timing.rpt
report_area > std_area.rpt
report_power > std_power_estimate.rpt

# Export netlist and constraints for PrimeTime
write -format verilog -hierarchy -output std_bridge_gate.v
write_sdc std_bridge.sdc

exit