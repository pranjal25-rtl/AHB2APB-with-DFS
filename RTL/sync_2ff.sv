module sync_2ff (
    input  wire clk,
    input  wire rstn,
    input  wire async_in,
    output reg  sync_out
);
    reg q1;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            q1       <= 1'b0;
            sync_out <= 1'b0;
        end else begin
            q1       <= async_in;
            sync_out <= q1;
        end
    end
endmodule