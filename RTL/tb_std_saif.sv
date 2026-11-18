
`timescale 1ns/1ps

module tb_std_saif;

    // ------------------------------------------------
    // Clock and reset
    // ------------------------------------------------
    logic HCLK = 1'b0;
    logic HRESETn = 1'b0;

    always #5 HCLK = ~HCLK;  // 100 MHz clock

    // ------------------------------------------------
    // AHB inputs
    // ------------------------------------------------
    logic        HSEL = 1'b1;
    logic [31:0] HADDR = 32'b0;
    logic [1:0]  HTRANS = 2'b00;
    logic        HWRITE = 1'b0;
    logic [2:0]  HSIZE = 3'b010;
    logic [2:0]  HBURST = 3'b000;
    logic [31:0] HWDATA = 32'b0;
    logic        HREADYIN = 1'b1;

    // ------------------------------------------------
    // AHB outputs
    // ------------------------------------------------
    wire [31:0] HRDATA;
    wire        HREADYOUT;
    wire        HRESP;

    // ------------------------------------------------
    // APB peripheral model
    // ------------------------------------------------
    wire [31:0] PADDR;
    wire [3:0]  PSEL;
    wire        PENABLE;
    wire        PWRITE;
    wire [31:0] PWDATA;

    logic [31:0] PRDATA_WORD = 32'h1234_ABCD;
    logic        PREADY_WORD = 1'b1;

    wire [127:0] PRDATA = {4{PRDATA_WORD}};
    wire [3:0]   PREADY = {4{PREADY_WORD}};
    wire [3:0]   PSLVERR = 4'b0000;

    integer errors = 0;
    integer completed = 0;

    // ------------------------------------------------
    // Standard AHB-to-APB bridge
    // ------------------------------------------------
    standard_bridge_top #(
        .ADDR_WIDTH    (32),
        .DATA_WIDTH    (32),
        .NUM_SLAVES    (4),
        .SLV_ADDR_BITS (26)
    ) DUT_STD (
        .HCLK      (HCLK),
        .HRESETn   (HRESETn),

        .HSEL      (HSEL),
        .HADDR     (HADDR),
        .HTRANS    (HTRANS),
        .HWRITE    (HWRITE),
        .HSIZE     (HSIZE),
        .HBURST    (HBURST),
        .HWDATA    (HWDATA),
        .HREADYIN  (HREADYIN),

        .HRDATA    (HRDATA),
        .HREADYOUT (HREADYOUT),
        .HRESP     (HRESP),

        .PADDR     (PADDR),
        .PSEL      (PSEL),
        .PENABLE   (PENABLE),
        .PWRITE    (PWRITE),
        .PWDATA    (PWDATA),

        .PRDATA    (PRDATA),
        .PREADY    (PREADY),
        .PSLVERR   (PSLVERR)
    );

    // ------------------------------------------------
    // Wait for bridge busy phase followed by completion
    // ------------------------------------------------
    task automatic wait_transfer;
        integer i;
        bit saw_busy;
        bit done;
        begin
            saw_busy = 1'b0;
            done = 1'b0;

            for (i = 0; i < 100 && !done; i = i + 1) begin
                @(negedge HCLK);

                if (!HREADYOUT)
                    saw_busy = 1'b1;

                if (saw_busy && HREADYOUT)
                    done = 1'b1;
            end

            if (done) begin
                completed = completed + 1;
            end else begin
                $display("[%0t] ERROR: transaction timeout", $time);
                errors = errors + 1;
            end
        end
    endtask

    // ------------------------------------------------
    // AHB write transaction
    // ------------------------------------------------
    task automatic ahb_write(
        input logic [31:0] addr,
        input logic [31:0] data
    );
        begin
            @(negedge HCLK);
            HADDR  = addr;
            HWRITE = 1'b1;
            HTRANS = 2'b10;  // NONSEQ

            @(negedge HCLK);
            HTRANS = 2'b00;  // IDLE
            HWDATA = data;

            wait_transfer();

            if (HRESP !== 1'b0) begin
                $display("[%0t] ERROR: write response at %h",
                         $time, addr);
                errors = errors + 1;
            end else begin
                $display("[%0t] WRITE PASS addr=%h data=%h",
                         $time, addr, data);
            end
        end
    endtask

    // ------------------------------------------------
    // AHB read transaction
    // ------------------------------------------------
    task automatic ahb_read(input logic [31:0] addr);
        begin
            @(negedge HCLK);
            HADDR  = addr;
            HWRITE = 1'b0;
            HTRANS = 2'b10;  // NONSEQ

            @(negedge HCLK);
            HTRANS = 2'b00;  // IDLE

            wait_transfer();

            if (HRESP !== 1'b0) begin
                $display("[%0t] ERROR: read response at %h",
                         $time, addr);
                errors = errors + 1;
            end else if (HRDATA !== 32'h1234_ABCD) begin
                $display("[%0t] ERROR: read data=%h expected=1234abcd",
                         $time, HRDATA);
                errors = errors + 1;
            end else begin
                $display("[%0t] READ PASS addr=%h data=%h",
                         $time, addr, HRDATA);
            end
        end
    endtask

    // ------------------------------------------------
    // Main test and SAIF recording
    // ------------------------------------------------
    initial begin
        $display("Starting standard bridge SAIF test");

        // Reset
        repeat (5) @(negedge HCLK);
        HRESETn = 1'b1;

        // Let the design settle before measuring
        repeat (5) @(negedge HCLK);

        // Record only the standard bridge hierarchy
        $set_gate_level_monitoring("rtl_on");
        $set_toggle_region(DUT_STD);
        $toggle_start();

        // Same workload intended for the comparison test
        ahb_write(32'h8000_0010, 32'hA5A5_1234);
        ahb_write(32'h8400_0020, 32'h5A5A_5678);
        ahb_write(32'h8800_0030, 32'hDEAD_BEEF);
        ahb_read (32'h8000_0050);

        // Include idle switching in the measurement
        repeat (100) @(negedge HCLK);

        $toggle_stop();

        $toggle_report("std_bridge.saif", 1.0e-9,
                       "tb_std_saif");

        $display("------------------------------------");
        $display("Completed transactions: %0d", completed);
        $display("Errors: %0d", errors);
        if (errors == 0)
            $display("RESULT: PASS");
        else
            $display("RESULT: FAIL");
        $display("SAIF report requested: std_bridge.saif");
        $display("------------------------------------");

        $finish;
    end

    // Basic APB protocol check
    always @(posedge HCLK) begin
        if (HRESETn && PENABLE && !(|PSEL)) begin
            $display("[%0t] ERROR: PENABLE asserted without PSEL",
                     $time);
            errors = errors + 1;
        end
    end
// VCD waveform dump for power analysis
initial begin
    $dumpfile("std_bridge.vcd");
    $dumpvars(0, DUT_STD);
end
endmodule
