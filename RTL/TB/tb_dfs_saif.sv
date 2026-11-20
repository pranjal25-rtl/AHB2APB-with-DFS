`timescale 1ns/1ps

module tb_dfs_saif;

    logic clk_in = 1'b0;
    logic hrstn  = 1'b0;

    // AHB inputs
    logic        hwrite   = 1'b0;
    logic [1:0]  htrans   = 2'b00;
    logic [31:0] haddr    = 32'b0;
    logic [31:0] hwdata   = 32'b0;
    logic        hreadyin = 1'b1;

    // APB peripheral model
    logic [31:0] prdata = 32'h1234_ABCD;
    logic        pready = 1'b1;

    // DFS outputs
    wire [31:0] dfs_hrdata;
    wire [1:0]  dfs_hresp;
    wire        dfs_hreadyout;
    wire [7:0]  activity_level;
    wire        dfs_clk_out;

    integer errors = 0;
    integer completed = 0;

    // 100 MHz input clock
    always #5 clk_in = ~clk_in;

    // ------------------------------------------------
    // Device under test: DFS bridge
    // ------------------------------------------------
    dfs_top DUT_DFS (
        .clk_in        (clk_in),
        .hrstn         (hrstn),
        .hwrite        (hwrite),
        .htrans        (htrans),
        .haddr         (haddr),
        .hwdata        (hwdata),
        .hreadyin      (hreadyin),
        .prdata        (prdata),
        .pready        (pready),
        .hrdata        (dfs_hrdata),
        .hresp         (dfs_hresp),
        .hreadyout     (dfs_hreadyout),
        .activity_level(activity_level),
        .dfs_clk_out   (dfs_clk_out)
    );

    // ------------------------------------------------
    // Wait for DFS bridge to accept and complete
    // ------------------------------------------------
    task automatic wait_dfs_done(input integer limit);
        integer i;
        bit saw_busy;
        begin
            saw_busy = 1'b0;
            for (i = 0; i < limit; i = i + 1) begin
                @(negedge clk_in);

                if (!dfs_hreadyout)
                    saw_busy = 1'b1;

                if (saw_busy && dfs_hreadyout) begin
                    completed = completed + 1;
                    return;
                end
            end
            $display("ERROR: timeout waiting for DFS bridge");
            errors = errors + 1;
        end
    endtask

    // ------------------------------------------------
    // AHB Write
    // ------------------------------------------------
    task automatic ahb_write(
        input logic [31:0] addr,
        input logic [31:0] data
    );
        begin
            @(negedge clk_in);
            haddr  = addr;
            hwrite = 1'b1;
            htrans = 2'b10;

            @(negedge clk_in);
            hwdata = data;
            htrans = 2'b00;

            wait_dfs_done(2000);

            $display("[%0t] WRITE PASS addr=%h data=%h", $time, addr, data);
        end
    endtask

    // ------------------------------------------------
    // AHB Read
    // ------------------------------------------------
    task automatic ahb_read(input logic [31:0] addr);
        begin
            @(negedge clk_in);
            haddr  = addr;
            hwrite = 1'b0;
            htrans = 2'b10;

            @(negedge clk_in);
            htrans = 2'b00;

            wait_dfs_done(2000);

            if (dfs_hrdata !== 32'h1234_ABCD) begin
                $display("ERROR: unexpected read data %h", dfs_hrdata);
                errors = errors + 1;
            end else begin
                $display("[%0t] READ PASS addr=%h data=%h", $time, addr, dfs_hrdata);
            end
        end
    endtask

    // ------------------------------------------------
    // Main Test
    // ------------------------------------------------
    initial begin
        repeat (5) @(negedge clk_in);
        hrstn = 1'b1;
        repeat (10) @(negedge clk_in);

        ahb_write(32'h8000_0010, 32'hA5A5_1234);
repeat (100) @(negedge clk_in);
        ahb_write(32'h8400_0020, 32'h5A5A_5678);
repeat (100) @(negedge clk_in);
        ahb_write(32'h8800_0030, 32'hDEAD_BEEF);
repeat (100) @(negedge clk_in);
        ahb_read (32'h8000_0050);

        repeat (100) @(negedge clk_in);

        $display("----------------------------------");
        $display("Completed transactions: %0d", completed);
        $display("Errors: %0d", errors);
        if (errors == 0) $display("RESULT: PASS");
        else             $display("RESULT: FAIL");
        $display("----------------------------------");
        $finish;
    end

    // ------------------------------------------------
    // VCD Dump for Power Analysis
    // ------------------------------------------------
    initial begin
        $dumpfile("dfs_bridge.vcd");
        $dumpvars(0, DUT_DFS);
    end

endmodule