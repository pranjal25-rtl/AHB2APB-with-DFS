`timescale 1ns / 1ps

module dfs_controller (
    input  wire       clk_in,
    input  wire       rstn,
    input  wire [7:0] activity_level,
    output wire       dfs_clk_out
);

    reg [3:0] counter;
    reg [3:0] threshold;
    reg       dfs_clk_temp;

    always @(posedge clk_in or negedge rstn) begin
        if (!rstn) begin
            counter      <= 4'd0;
            threshold    <= 4'd4;
            dfs_clk_temp <= 1'b0;
        end else begin
          // Assuming max activity_level is 64 (100% utilization)
            if (activity_level > 8'd48)       // > 75% utilization
                threshold <= 4'd2;            // Fast clock (Divide by 4)
            else if (activity_level > 8'd24)  // > 37% utilization
                threshold <= 4'd4;            // Medium clock (Divide by 8)
            else                              // Low utilization
                threshold <= 4'd8;            // Slow clock (Divide by 16)

            if (counter >= threshold - 1'b1) begin
                counter      <= 4'd0;
                dfs_clk_temp <= ~dfs_clk_temp;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

    assign dfs_clk_out = dfs_clk_temp;

endmodule