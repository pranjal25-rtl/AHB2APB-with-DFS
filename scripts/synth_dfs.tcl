
# ---------------------------------------------------------
# Synopsys Design Compiler: DFS AHB-APB Bridge
# ---------------------------------------------------------

set DESIGN dfs_top

# SAED32 library
set target_library \
    "/home/tops5/Desktop/syn_mdu/tech/db/saed32rvt_ss0p95v125c.db"

if {![file exists $target_library]} {
    error "Target library not found: $target_library"
}

set link_library "* $target_library"

# Library setup
set_app_var target_library $target_library
set_app_var link_library $link_library

# Read RTL
analyze -format sverilog {
    activity_monitor.sv
    sync_2ff.sv
    dfs_controller.sv
    AHB_slave.sv
    APB_controller.sv
    dfs_top.sv
}

elaborate $DESIGN
current_design $DESIGN
link
check_design

# Base clock: 100 MHz
create_clock -name clk_in -period 10.0 [get_ports clk_in]

# Define the dynamic clock (Worst-case 1:1 ratio for timing closure)
create_generated_clock -name dfs_clk -source [get_ports clk_in] -divide_by 1 [get_pins DFS_GEN/dfs_clk_out]
# Input/output timing constraints should be added when the
# intended external interface timing is known.

# Compile
compile_ultra

# Reports
report_timing -max_paths 20 > dfs_timing.rpt
report_area > dfs_area.rpt
report_reference > dfs_cells.rpt

# Export netlist and constraints
write -format verilog -hierarchy -output dfs_top_gate.v
write_sdc dfs_top.sdc

exit
