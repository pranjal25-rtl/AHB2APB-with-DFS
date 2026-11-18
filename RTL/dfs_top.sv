`timescale 1ns / 1ps

module dfs_top (
    input  wire        clk_in,
    input  wire        hrstn,
    input  wire        hwrite,
    input  wire [1:0]  htrans,
    input  wire [31:0] haddr,
    input  wire [31:0] hwdata,
    input  wire        hreadyin,
    input  wire [31:0] prdata,
    input  wire        pready,
    
    output wire [31:0] hrdata,
    output wire [1:0]  hresp,
    output wire        hreadyout,
    output wire [7:0]  activity_level,
    output wire        dfs_clk_out
);

    wire        apb_req_raw, apb_req_sync;
    wire        apb_ack_raw, apb_ack_sync;
    wire [31:0] haddr1;
    wire [31:0] hwdata1;
    wire        hwritereg;
    wire [2:0]  tempselx;
    wire        valid;
    wire [31:0] prdata_latched;

    // 1. AHB Slave
    AHB_slave u_ahb_slave (
        .clk            (clk_in),
        .hrstn          (hrstn),
        .hwrite         (hwrite),
        .hreadyin       (hreadyin),
        .htrans         (htrans),
        .haddr          (haddr),
        .hwdata         (hwdata),
        
        .prdata         (prdata),           
        .prdata_latched (prdata_latched),   
        
        .haddr1         (haddr1),
        .hwdata1        (hwdata1),
        .tempselx       (tempselx),
        .valid          (valid),
        .hwritereg      (hwritereg),
        
        .ahb_req        (apb_req_raw),
        .ahb_ack        (apb_ack_sync), 
        
        .hresp          (hresp),
        .hreadyout      (hreadyout),
        .hrdata         (hrdata)
    );

    // 2. DFS Controller
    dfs_controller u_dfs_ctrl (
        .clk_in         (clk_in),
        .rstn           (hrstn),
        .activity_level (activity_level),
        .dfs_clk_out    (dfs_clk_out)
    );

    // 3. Activity Monitor
    activity_monitor u_act_mon (
        .clk_in         (clk_in),           
        .rstn           (hrstn),
        .valid          (valid),
        .hready(hreadyout),
        .activity_level (activity_level)
    );

    // CDC SYNCHRONIZERS (Fixed Port Names)
    sync_2ff u_sync_req (
        .clk            (dfs_clk_out),
        .rstn           (hrstn),
        .async_in       (apb_req_raw),
        .sync_out       (apb_req_sync)
    );

    sync_2ff u_sync_ack (
        .clk            (clk_in),
        .rstn           (hrstn),
        .async_in       (apb_ack_raw),
        .sync_out       (apb_ack_sync)
    );

    // 4. APB Controller
    APB_controller u_apb_ctrl (
        .clk            (dfs_clk_out),
        .hrstn          (hrstn),
        .apb_req        (apb_req_sync), 
        .apb_ack        (apb_ack_raw),  
        .haddr1         (haddr1),
        .hwdata1        (hwdata1),
        .hwritereg      (hwritereg),
        .tempselx       (tempselx),
        .prdata         (prdata),
        .pready         (pready),
        
        .prdata_latched (prdata_latched),
        
        .pwrite         (),
        .penable        (),
        .pselx          (),
        .pwdata         (),
        .paddr          ()
    );

endmodule