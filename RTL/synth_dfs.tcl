# =======================================================================
# Design Compiler Synthesis Script: synth_dfs.tcl
# =======================================================================

# 1. Setup Libraries
set search_path ". /home/tops5/Desktop/AHB2APB/tech/db/"
# Note: Ensure "saed32rvt_tt1v25c.db" is the exact filename in your db folder.
set target_library "saed32rvt_ss0p95v125c.db"
set link_library "* $target_library"

# 2. Read RTL Files
analyze -format sverilog {dfs_top.sv dfs_controller.sv AHB_slave.sv APB_controller.sv sync_2ff.sv activity_monitor.sv}
elaborate dfs_top
current_design dfs_top
link

# 3. Apply Constraints (100 MHz clock)
create_clock -name clk_in -period 10 [get_ports clk_in]

# 4. Synthesize Design
compile_ultra -no_autoungroup

# Note: If compile_ultra throws a license error, replace it with just: compile

# 5. Generate the SAIF Name Map for PrimeTime (CRITICAL)
saif_map -type pt -write_map pt_namemap.tcl

# 6. Write the Gate-Level Netlist
write -format verilog -hierarchy -output dfs_top_gate.v

puts "=================================================================="
puts "Synthesis Complete! Netlist and SAIF Namemap generated."
puts "=================================================================="
quit