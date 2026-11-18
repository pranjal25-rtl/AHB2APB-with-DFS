
# ============================================================
# PrimeTime PX Power Analysis - Standard AHB-to-APB Bridge
# Clock frequency: 100 MHz (period = 10 ns)
# Library: SAED32 RVT, ss0p95v125c
# ============================================================

# 1. Set the working directory
# Run this script from your RTL/PrimeTime working directory.

# 2. Read the standard-cell library
set LIB "/home/tops5/Desktop/syn_mdu/tech/db/saed32rvt_ss0p95v125c.db"

set_app_var search_path [list [file dirname $LIB]]
set_app_var target_library [list $LIB]
set_app_var link_library [list "*" $LIB]

read_db $LIB

# 3. Read the synthesized gate-level netlist
# Change the filename if your synthesized netlist has a different name.
read_verilog standard_bridge_gate.v

# 4. Link the design
current_design standard_bridge_top
link_design standard_bridge_top

# 5. Define the operating conditions
set_operating_conditions ss0p95v125c

# 6. Define the 100 MHz clock
# IMPORTANT: clk_in must match the actual top-level clock port.
create_clock -name sys_clk -period 10.0 [get_ports HCLK]

# Optional clock waveform: 50% duty cycle
set_clock_transition 0.1 [get_clocks sys_clk]
set_clock_uncertainty 0.1 [get_clocks sys_clk]

# 7. Check clock and design constraints
check_timing
report_clocks
report_port -verbose [get_ports HCLK]

# 8. Read simulation activity data (SAIF)
# Use this section only if a valid SAIF file is available.
# The hierarchy must match the SAIF INSTANCE structure.
# Uncomment and adjust the filename/hierarchy as needed.
#
# read_saif -input std_bridge.saif \
#     -instance_name tb_std_saif/DUT_STD
#
# Check annotation after reading SAIF:
# report_switching_activity

# 9. If SAIF is not used, set input activity explicitly.
# These are example assumptions, NOT measured activity.
# Prefer representative simulation-derived activity for publication.
#
# set_switching_activity -static_probability 0.5 \
#     -toggle_rate 0.1 [remove_from_collection \
#         [all_inputs] [get_ports HCLK]]

# 10. Calculate averaged power
update_power
report_switching_activity
report_power
report_power -hierarchy

# 11. Save reports
redirect -file standard_clock_report.rpt {
    report_clocks
}

redirect -file standard_timing_check.rpt {
    check_timing
}

redirect -file standard_switching_activity.rpt {
    report_switching_activity
}

redirect -file standard_power_report.rpt {
    report_power
}

redirect -file standard_power_hierarchy.rpt {
    report_power -hierarchy
}

# 12. Finish
puts "Standard bridge power analysis completed."
