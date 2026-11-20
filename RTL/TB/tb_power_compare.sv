
`timescale 1ns/1ps

module tb_power_compare;

    logic clk_in = 1'b0;
    logic hrstn  = 1'b0;

    // Shared AHB inputs
    logic        hwrite   = 1'b0;
    logic [1:0]  htrans   = 2'b00;
    logic [31:0] haddr    = 32'b0;
    logic [31:0] hwdata   = 32'b0;
    logic        hreadyin = 1'b1;

    // Shared APB peripheral model
    logic [31:0] prdata = 32'h1234_ABCD;
    logic        pready = 1'b1;

    // DFS outputs
    wire [31:0] dfs_hrdata;
    wire [1:0]  dfs_hresp;
    wire        dfs_hreadyout;
    wire [7:0]  activity_level;
    wire        dfs_clk_out;

    // Standard bridge outputs
    wire [31:0] std_hrdata;
    wire        std_hresp;
    wire        std_hreadyout;

    integer errors = 0;
    integer completed = 0;

    // 100 MHz input clock
    always #5 clk_in = ~clk_in;

    // ------------------------------------------------
    // Device under test 1: DFS bridge
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
    // Wait for both bridges to accept and complete
    // a transaction. Timeout prevents a stuck test.
    // ------------------------------------------------
    task automatic wait_both_done(input integer limit);
        integer i;
        bit saw_dfs_busy;
        bit saw_std_busy;
        begin
            saw_dfs_busy = 1'b0;
            saw_std_busy = 1'b0;

            for (i = 0; i < limit; i = i + 1) begin
                @(negedge clk_in);

                if (!dfs_hreadyout)
                    saw_dfs_busy = 1'b1;

                if (!std_hreadyout)
                    saw_std_busy = 1'b1;

                if (saw_dfs_busy && saw_std_busy &&
                    dfs_hreadyout && std_hreadyout) begin
                    completed = completed + 1;
                    return;
                end
            end

            $display("ERROR: timeout waiting for both bridges");
            $display("DFS ready=%b, STD ready=%b",
                     dfs_hreadyout, std_hreadyout);
            errors = errors + 1;
        end
    endtask

    // ------------------------------------------------
    // Drive one AHB write. Address/control are held
    // for an address phase; data is driven next.
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

            wait_both_done(500);

            $display("[%0t] WRITE addr=%h data=%h DFS_ready=%b STD_ready=%b",
                     $time, addr, data,
                     dfs_hreadyout, std_hreadyout);
        end
    endtask

    // ------------------------------------------------
    // Drive one AHB read
    // ------------------------------------------------
    task automatic ahb_read(input logic [31:0] addr);
        begin
            @(negedge clk_in);
            haddr  = addr;
            hwrite = 1'b0;
            htrans = 2'b10;

            @(negedge clk_in);
            htrans = 2'b00;

            wait_both_done(500);

            if (dfs_hrdata !== std_hrdata) begin
                $display("ERROR: read mismatch DFS=%h STD=%h",
                         dfs_hrdata, std_hrdata);
                errors = errors + 1;
            end
            else if (dfs_hrdata !== 32'h1234_ABCD) begin
                $display("ERROR: unexpected read data %h", dfs_hrdata);
                errors = errors + 1;
            end
            else begin
                $display("[%0t] READ PASS addr=%h data=%h",
                         $time, addr, dfs_hrdata);
            end
        end
    endtask

    // ------------------------------------------------
    // Test and SAIF recording
    // ------------------------------------------------
    initial begin
        // Keep this path aligned with actual instance names.
        $set_gate_level_monitoring("rtl_on");
        $set_toggle_region(DUT_DFS);
        $set_toggle_region(DUT_STD);

        repeat (5) @(negedge clk_in);
        hrstn = 1'b1;

        // Let reset settle before recording.
        repeat (10) @(negedge clk_in);

        $toggle_start();

        ahb_write(32'h8000_0010, 32'hA5A5_1234);
        ahb_write(32'h8400_0020, 32'h5A5A_5678);
        ahb_write(32'h8800_0030, 32'hDEAD_BEEF);
        ahb_read (32'h8000_0050);

        // Measure idle switching too.
        repeat (100) @(negedge clk_in);

        $toggle_stop();

        $toggle_report("dfs_bridge.saif", 1.0e-9,
                       "tb_power_compare.DUT_DFS");
        $toggle_report("std_bridge.saif", 1.0e-9,
                       "tb_power_compare.DUT_STD");

        $display("----------------------------------");
        $display("Completed transactions: %0d", completed);
        $display("Errors: %0d", errors);
        $display("----------------------------------");

        if (errors == 0)
            $display("RESULT: PASS");
        else
            $display("RESULT: FAIL");

        $finish;
    end
// VCD waveform dump for power analysis
    initial begin
        $dumpfile("dfs_bridge.vcd");
        $dumpvars(0, DUT_DFS); // Change DUT_DFS to your exact instance name if different
    end
endmodule
