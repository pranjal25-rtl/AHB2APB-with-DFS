# AHB2APB Bridge with Dynamic Frequency Scaling (DFS)

This repository contains the RTL design and verification environment for an AMBA AHB to APB bridge integrated with Dynamic Frequency Scaling (DFS). The DFS feature optimizes power consumption by dynamically scaling the APB clock frequency based on the transaction activity level, while safely passing data between the high-frequency AHB domain and the scaled-frequency APB domain.

## 📂 Repository Structure

* **`RTL/`**: Contains the SystemVerilog/Verilog source code for the bridge, including the AHB slave interface, APB master controller, clock domain crossing (CDC) synchronizers, activity monitor, and DFS controller.
* **`Reports/`**: Includes EDA tool outputs such as synthesis, timing (STA), power, and area reports.
* **`scripts/`**: Contains Tcl and automation scripts for simulation, synthesis, and physical design flows.
* **`tech/`**: Contains technology-specific library constraints and node configurations used during synthesis and implementation.
* **`DOCS.md`**: Detailed documentation, including the complete system architecture diagram and module-level descriptions.

## ⚙️ Key Features

* **AMBA Protocol Compliant:** Standard AHB-Lite Master to APB Slave bridging.
* **Dynamic Frequency Scaling (DFS):** Actively monitors bus transaction density and dynamically scales the APB clock to save power during low-activity periods.
* **Robust Clock Domain Crossing (CDC):** Utilizes 2-stage Flip-Flop (2-FF) synchronizers for safe control signal passing between asynchronous clock domains.
* **Low Power Architecture:** Designed for power-sensitive SoC applications requiring flexible peripheral scaling.

## 🚀 Getting Started

### Prerequisites
To simulate or synthesize this design, you will need standard EDA tools (e.g., Synopsys VCS/Design Compiler, Cadence Xcelium/Genus, or open-source alternatives like Verilator/Yosys).

### Running Simulations
*(Add specific commands here based on your environment, e.g.,)*
1. Navigate to the scripts directory: `cd scripts`
2. Run the simulation script: `make sim` or `source run_sim.tcl`

## 📖 Documentation
For a deep dive into the architecture and block diagrams, please refer to [DOCS.md](./DOCS.md).# AHB2APB-with-DFS
