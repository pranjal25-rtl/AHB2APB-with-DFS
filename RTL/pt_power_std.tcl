# ---------------------------------------------------------
# Synopsys PrimeTime PX: Standard Bridge Power Analysis
# ---------------------------------------------------------
set power_enable_analysis true
set power_analysis_mode averaged

# 1. Load the SAED32 Library
set target_library "/home/tops5/Desktop/syn_mdu/tech/db/saed32rvt_ss0p95v125c.db"
set link_library "* $target_library"

# 2. Read the Gate-Level Netlist and Constraints
read_verilog std_bridge_gate.v
current_design standard_bridge_top
link
read_sdc std_bridge.sdc

# 3. Read the Switching Activity (SAIF) from your simulation
read_saif -strip_path tb_power_compare/DUT_STD std_bridge.saif

# 4. Generate the Power Report
report_power -hierarchy > report_power_std.txt

exit