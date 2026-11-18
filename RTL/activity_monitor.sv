`timescale 1ns / 1ps

module activity_monitor (
    input  wire       clk_in,         // Base system clock (Fast)
    input  wire       rstn,           // Active-low reset
    input  wire       valid,          // Valid transaction from AHB slave
    input  wire       hready,         // AHB ready signal
    output reg  [7:0] activity_level  // Dynamic activity output to DFS Controller
);

    // Optimized internal counters (saving 19 flip-flops)
    reg [6:0] activity_count; // 7 bits: max value 64
    reg [5:0] time_window;    // 6 bits: max value 63

    always @(posedge clk_in or negedge rstn) begin
        if (!rstn) begin
            activity_count <= 7'd0;
            time_window    <= 6'd0;
            activity_level <= 8'd80; // Start with mid-level activity
        end else begin
            time_window <= time_window + 1'b1;

            // Increment when valid transaction occurs
            if (valid && hready) begin
                activity_count <= activity_count + 1'b1;
            end

            // Update every 64 cycles (when time_window rolls over to 63)
            if (time_window == 6'd63) begin
                activity_level <= {1'b0, activity_count}; // Pad 7-bit count to 8-bit output
                activity_count <= 7'd0;
                // No need to reset time_window manually, 6-bit register naturally rolls over to 0
            end
        end
    end
endmodule