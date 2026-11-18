/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Wed Oct 21 17:04:26 2026
/////////////////////////////////////////////////////////////


module AHB_slave ( clk, hrstn, hwrite, hreadyin, htrans, haddr, hwdata, prdata, 
        prdata_latched, haddr1, hwdata1, tempselx, valid, hwritereg, ahb_req, 
        ahb_ack, hresp, hreadyout, hrdata );
  input [1:0] htrans;
  input [31:0] haddr;
  input [31:0] hwdata;
  input [31:0] prdata;
  input [31:0] prdata_latched;
  output [31:0] haddr1;
  output [31:0] hwdata1;
  output [2:0] tempselx;
  output [1:0] hresp;
  output [31:0] hrdata;
  input clk, hrstn, hwrite, hreadyin, ahb_ack;
  output valid, hwritereg, ahb_req, hreadyout;
  wire   N4, N16, n10, n11, n12, n13, n14, n2, n3, n4, n5, n6, n7, n8, n9, n15
;
  wire   [1:0] state;
  assign hrdata[31] = prdata_latched[31];
  assign hrdata[30] = prdata_latched[30];
  assign hrdata[29] = prdata_latched[29];
  assign hrdata[28] = prdata_latched[28];
  assign hrdata[27] = prdata_latched[27];
  assign hrdata[26] = prdata_latched[26];
  assign hrdata[25] = prdata_latched[25];
  assign hrdata[24] = prdata_latched[24];
  assign hrdata[23] = prdata_latched[23];
  assign hrdata[22] = prdata_latched[22];
  assign hrdata[21] = prdata_latched[21];
  assign hrdata[20] = prdata_latched[20];
  assign hrdata[19] = prdata_latched[19];
  assign hrdata[18] = prdata_latched[18];
  assign hrdata[17] = prdata_latched[17];
  assign hrdata[16] = prdata_latched[16];
  assign hrdata[15] = prdata_latched[15];
  assign hrdata[14] = prdata_latched[14];
  assign hrdata[13] = prdata_latched[13];
  assign hrdata[12] = prdata_latched[12];
  assign hrdata[11] = prdata_latched[11];
  assign hrdata[10] = prdata_latched[10];
  assign hrdata[9] = prdata_latched[9];
  assign hrdata[8] = prdata_latched[8];
  assign hrdata[7] = prdata_latched[7];
  assign hrdata[6] = prdata_latched[6];
  assign hrdata[5] = prdata_latched[5];
  assign hrdata[4] = prdata_latched[4];
  assign hrdata[3] = prdata_latched[3];
  assign hrdata[2] = prdata_latched[2];
  assign hrdata[1] = prdata_latched[1];
  assign hrdata[0] = prdata_latched[0];
  assign N4 = haddr[31];
  assign valid = N16;

  DFFARX1_RVT \state_reg[0]  ( .D(n14), .CLK(clk), .RSTB(hrstn), .Q(state[0]), 
        .QN(n15) );
  DFFARX1_RVT \state_reg[1]  ( .D(n13), .CLK(clk), .RSTB(hrstn), .Q(state[1]), 
        .QN(n9) );
  DFFARX1_RVT ahb_req_reg ( .D(n11), .CLK(clk), .RSTB(hrstn), .Q(ahb_req) );
  DFFASX1_RVT hreadyout_reg ( .D(n12), .CLK(clk), .SETB(hrstn), .Q(hreadyout)
         );
  DFFARX1_RVT hwritereg_reg ( .D(n10), .CLK(clk), .RSTB(hrstn), .Q(hwritereg)
         );
  INVX0_RVT U3 ( .A(haddr[30]), .Y(n2) );
  AND2X1_RVT U4 ( .A1(haddr[26]), .A2(haddr[27]), .Y(n4) );
  NAND4X0_RVT U5 ( .A1(htrans[1]), .A2(N4), .A3(hreadyin), .A4(n2), .Y(n3) );
  NOR4X1_RVT U6 ( .A1(n4), .A2(haddr[29]), .A3(haddr[28]), .A4(n3), .Y(N16) );
  NAND2X0_RVT U7 ( .A1(N16), .A2(n9), .Y(n6) );
  OA21X1_RVT U8 ( .A1(ahb_ack), .A2(n9), .A3(n15), .Y(n5) );
  MUX21X1_RVT U9 ( .A1(hreadyout), .A2(n6), .S0(n5), .Y(n12) );
  NAND3X0_RVT U10 ( .A1(N16), .A2(n15), .A3(n9), .Y(n7) );
  MUX21X1_RVT U11 ( .A1(hwrite), .A2(hwritereg), .S0(n7), .Y(n10) );
  NAND2X0_RVT U12 ( .A1(state[1]), .A2(ahb_ack), .Y(n8) );
  NAND2X0_RVT U13 ( .A1(n7), .A2(n8), .Y(n14) );
  AO222X1_RVT U14 ( .A1(state[0]), .A2(ahb_ack), .A3(state[0]), .A4(n9), .A5(
        state[1]), .A6(n15), .Y(n13) );
  AO222X1_RVT U15 ( .A1(state[0]), .A2(ahb_req), .A3(state[0]), .A4(n9), .A5(
        ahb_req), .A6(n8), .Y(n11) );
endmodule


module dfs_controller ( clk_in, rstn, activity_level, dfs_clk_out );
  input [7:0] activity_level;
  input clk_in, rstn;
  output dfs_clk_out;
  wire   N8, N9, N10, N22, N23, N24, N25, n16, n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n17, n18, n19;
  wire   [3:0] counter;
  wire   [3:0] threshold;

  DFFARX1_RVT \threshold_reg[3]  ( .D(N10), .CLK(clk_in), .RSTB(rstn), .Q(
        threshold[3]) );
  DFFARX1_RVT \threshold_reg[1]  ( .D(N8), .CLK(clk_in), .RSTB(rstn), .Q(
        threshold[1]) );
  DFFARX1_RVT \counter_reg[0]  ( .D(N22), .CLK(clk_in), .RSTB(rstn), .Q(
        counter[0]) );
  DFFARX1_RVT \counter_reg[1]  ( .D(N23), .CLK(clk_in), .RSTB(rstn), .Q(
        counter[1]) );
  DFFARX1_RVT \counter_reg[2]  ( .D(N24), .CLK(clk_in), .RSTB(rstn), .Q(
        counter[2]), .QN(n19) );
  DFFARX1_RVT \counter_reg[3]  ( .D(N25), .CLK(clk_in), .RSTB(rstn), .Q(
        counter[3]) );
  DFFARX1_RVT dfs_clk_temp_reg ( .D(n16), .CLK(clk_in), .RSTB(rstn), .Q(
        dfs_clk_out) );
  DFFASX1_RVT \threshold_reg[2]  ( .D(N9), .CLK(clk_in), .SETB(rstn), .Q(
        threshold[2]) );
  OR2X1_RVT U3 ( .A1(activity_level[6]), .A2(n3), .Y(N8) );
  AND2X1_RVT U4 ( .A1(activity_level[5]), .A2(activity_level[4]), .Y(n2) );
  OR3X1_RVT U5 ( .A1(activity_level[0]), .A2(activity_level[1]), .A3(
        activity_level[2]), .Y(n12) );
  OR2X1_RVT U6 ( .A1(n12), .A2(activity_level[3]), .Y(n1) );
  AND2X1_RVT U7 ( .A1(n2), .A2(n1), .Y(n3) );
  NAND2X0_RVT U8 ( .A1(counter[0]), .A2(counter[1]), .Y(n14) );
  INVX0_RVT U9 ( .A(n14), .Y(n17) );
  OA22X1_RVT U10 ( .A1(threshold[1]), .A2(n17), .A3(counter[0]), .A4(
        counter[1]), .Y(n6) );
  OA22X1_RVT U11 ( .A1(n6), .A2(counter[2]), .A3(threshold[2]), .A4(
        threshold[1]), .Y(n5) );
  NAND2X0_RVT U12 ( .A1(threshold[2]), .A2(threshold[1]), .Y(n4) );
  AO22X1_RVT U13 ( .A1(n6), .A2(counter[2]), .A3(n5), .A4(n4), .Y(n9) );
  OR2X1_RVT U14 ( .A1(threshold[2]), .A2(threshold[1]), .Y(n7) );
  HADDX1_RVT U15 ( .A0(threshold[3]), .B0(n7), .SO(n8) );
  AO222X1_RVT U16 ( .A1(counter[3]), .A2(n9), .A3(counter[3]), .A4(n8), .A5(n9), .A6(n8), .Y(n18) );
  INVX0_RVT U17 ( .A(n18), .Y(n15) );
  AND2X1_RVT U18 ( .A1(n14), .A2(n15), .Y(n11) );
  OR2X1_RVT U19 ( .A1(counter[1]), .A2(counter[0]), .Y(n10) );
  AND2X1_RVT U20 ( .A1(n11), .A2(n10), .Y(N23) );
  AND3X1_RVT U21 ( .A1(activity_level[3]), .A2(activity_level[4]), .A3(n12), 
        .Y(n13) );
  NOR3X0_RVT U22 ( .A1(activity_level[6]), .A2(activity_level[5]), .A3(n13), 
        .Y(N10) );
  NOR2X0_RVT U23 ( .A1(n18), .A2(counter[0]), .Y(N22) );
  OA221X1_RVT U24 ( .A1(counter[2]), .A2(n17), .A3(n19), .A4(n14), .A5(n15), 
        .Y(N24) );
  OA221X1_RVT U25 ( .A1(counter[3]), .A2(counter[2]), .A3(counter[3]), .A4(n17), .A5(n15), .Y(N25) );
  NOR2X0_RVT U26 ( .A1(N10), .A2(N8), .Y(N9) );
  HADDX1_RVT U27 ( .A0(dfs_clk_out), .B0(n18), .SO(n16) );
endmodule


module activity_monitor ( clk_in, rstn, valid, hready, activity_level );
  output [7:0] activity_level;
  input clk_in, rstn, valid, hready;
  wire   N4, N5, N6, N7, N8, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n1, n2, n3, n4, n5, n6, n7, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48;
  wire   [5:0] time_window;
  wire   [6:0] activity_count;

  DFFARX1_RVT \time_window_reg[5]  ( .D(N8), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[5]) );
  DFFARX1_RVT \time_window_reg[4]  ( .D(N7), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[4]) );
  DFFARX1_RVT \time_window_reg[3]  ( .D(N6), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[3]) );
  DFFARX1_RVT \time_window_reg[2]  ( .D(N5), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[2]) );
  DFFARX1_RVT \time_window_reg[1]  ( .D(N4), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[1]) );
  DFFARX1_RVT \time_window_reg[0]  ( .D(n48), .CLK(clk_in), .RSTB(rstn), .Q(
        time_window[0]), .QN(n48) );
  DFFARX1_RVT \activity_count_reg[0]  ( .D(n21), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[0]), .QN(n42) );
  DFFARX1_RVT \activity_count_reg[1]  ( .D(n20), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[1]) );
  DFFARX1_RVT \activity_count_reg[2]  ( .D(n19), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[2]), .QN(n45) );
  DFFARX1_RVT \activity_count_reg[3]  ( .D(n18), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[3]), .QN(n44) );
  DFFARX1_RVT \activity_count_reg[4]  ( .D(n17), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[4]), .QN(n46) );
  DFFARX1_RVT \activity_count_reg[5]  ( .D(n16), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[5]), .QN(n43) );
  DFFARX1_RVT \activity_count_reg[6]  ( .D(n15), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_count[6]), .QN(n47) );
  DFFARX1_RVT \activity_level_reg[0]  ( .D(n14), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_level[0]) );
  DFFARX1_RVT \activity_level_reg[1]  ( .D(n13), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_level[1]) );
  DFFARX1_RVT \activity_level_reg[2]  ( .D(n12), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_level[2]) );
  DFFARX1_RVT \activity_level_reg[3]  ( .D(n11), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_level[3]) );
  DFFARX1_RVT \activity_level_reg[5]  ( .D(n10), .CLK(clk_in), .RSTB(rstn), 
        .Q(activity_level[5]) );
  DFFASX1_RVT \activity_level_reg[4]  ( .D(n9), .CLK(clk_in), .SETB(rstn), .Q(
        activity_level[4]) );
  DFFASX1_RVT \activity_level_reg[6]  ( .D(n8), .CLK(clk_in), .SETB(rstn), .Q(
        activity_level[6]) );
  INVX0_RVT U3 ( .A(n24), .Y(n34) );
  INVX0_RVT U4 ( .A(n6), .Y(n7) );
  NAND4X0_RVT U5 ( .A1(time_window[0]), .A2(time_window[1]), .A3(
        time_window[2]), .A4(time_window[3]), .Y(n2) );
  INVX0_RVT U6 ( .A(n2), .Y(n1) );
  NAND2X0_RVT U7 ( .A1(n1), .A2(time_window[4]), .Y(n6) );
  OA21X1_RVT U8 ( .A1(n1), .A2(time_window[4]), .A3(n6), .Y(N7) );
  NAND3X0_RVT U9 ( .A1(time_window[0]), .A2(time_window[1]), .A3(
        time_window[2]), .Y(n4) );
  INVX0_RVT U10 ( .A(n4), .Y(n3) );
  OA21X1_RVT U11 ( .A1(n3), .A2(time_window[3]), .A3(n2), .Y(N6) );
  OA221X1_RVT U12 ( .A1(time_window[2]), .A2(time_window[1]), .A3(
        time_window[2]), .A4(time_window[0]), .A5(n4), .Y(N5) );
  NAND2X0_RVT U13 ( .A1(time_window[0]), .A2(time_window[1]), .Y(n5) );
  OA21X1_RVT U14 ( .A1(time_window[0]), .A2(time_window[1]), .A3(n5), .Y(N4)
         );
  NAND2X0_RVT U15 ( .A1(n7), .A2(time_window[5]), .Y(n40) );
  OA21X1_RVT U16 ( .A1(n7), .A2(time_window[5]), .A3(n40), .Y(N8) );
  NAND2X0_RVT U17 ( .A1(hready), .A2(valid), .Y(n37) );
  NAND2X0_RVT U18 ( .A1(n40), .A2(n37), .Y(n23) );
  INVX0_RVT U19 ( .A(n23), .Y(n28) );
  NAND3X0_RVT U20 ( .A1(hready), .A2(valid), .A3(n40), .Y(n24) );
  AO22X1_RVT U21 ( .A1(activity_count[0]), .A2(n28), .A3(n42), .A4(n34), .Y(
        n21) );
  NAND2X0_RVT U22 ( .A1(n34), .A2(n42), .Y(n22) );
  NAND2X0_RVT U23 ( .A1(n23), .A2(n22), .Y(n26) );
  NOR2X0_RVT U24 ( .A1(n24), .A2(activity_count[1]), .Y(n27) );
  AO22X1_RVT U25 ( .A1(activity_count[1]), .A2(n26), .A3(n27), .A4(
        activity_count[0]), .Y(n20) );
  AND3X1_RVT U26 ( .A1(activity_count[1]), .A2(n34), .A3(activity_count[0]), 
        .Y(n25) );
  AO222X1_RVT U27 ( .A1(activity_count[2]), .A2(n27), .A3(activity_count[2]), 
        .A4(n26), .A5(n25), .A6(n45), .Y(n19) );
  NAND3X0_RVT U28 ( .A1(activity_count[2]), .A2(activity_count[1]), .A3(
        activity_count[0]), .Y(n29) );
  AOI21X1_RVT U29 ( .A1(n29), .A2(n34), .A3(n28), .Y(n31) );
  NAND2X0_RVT U30 ( .A1(n34), .A2(n44), .Y(n30) );
  OAI22X1_RVT U31 ( .A1(n31), .A2(n44), .A3(n30), .A4(n29), .Y(n18) );
  AND4X1_RVT U32 ( .A1(activity_count[2]), .A2(activity_count[1]), .A3(
        activity_count[0]), .A4(activity_count[3]), .Y(n33) );
  NAND2X0_RVT U33 ( .A1(n31), .A2(n30), .Y(n32) );
  OA222X1_RVT U34 ( .A1(activity_count[4]), .A2(n34), .A3(activity_count[4]), 
        .A4(n33), .A5(n46), .A6(n32), .Y(n17) );
  NAND2X0_RVT U35 ( .A1(activity_count[4]), .A2(n33), .Y(n36) );
  OA21X1_RVT U36 ( .A1(n37), .A2(n36), .A3(n40), .Y(n35) );
  AND3X1_RVT U37 ( .A1(n34), .A2(activity_count[4]), .A3(n33), .Y(n39) );
  AO22X1_RVT U38 ( .A1(activity_count[5]), .A2(n35), .A3(n43), .A4(n39), .Y(
        n16) );
  AO222X1_RVT U39 ( .A1(n40), .A2(n43), .A3(n40), .A4(n37), .A5(n40), .A6(n36), 
        .Y(n38) );
  OA222X1_RVT U40 ( .A1(activity_count[6]), .A2(activity_count[5]), .A3(
        activity_count[6]), .A4(n39), .A5(n47), .A6(n38), .Y(n15) );
  INVX0_RVT U41 ( .A(n40), .Y(n41) );
  AO22X1_RVT U42 ( .A1(n41), .A2(activity_count[0]), .A3(n40), .A4(
        activity_level[0]), .Y(n14) );
  AO22X1_RVT U43 ( .A1(n41), .A2(activity_count[1]), .A3(n40), .A4(
        activity_level[1]), .Y(n13) );
  AO22X1_RVT U44 ( .A1(n41), .A2(activity_count[2]), .A3(n40), .A4(
        activity_level[2]), .Y(n12) );
  AO22X1_RVT U45 ( .A1(n41), .A2(activity_count[3]), .A3(n40), .A4(
        activity_level[3]), .Y(n11) );
  AO22X1_RVT U46 ( .A1(n41), .A2(activity_count[5]), .A3(n40), .A4(
        activity_level[5]), .Y(n10) );
  AO22X1_RVT U47 ( .A1(n41), .A2(activity_count[4]), .A3(n40), .A4(
        activity_level[4]), .Y(n9) );
  AO22X1_RVT U48 ( .A1(n41), .A2(activity_count[6]), .A3(n40), .A4(
        activity_level[6]), .Y(n8) );
endmodule


module sync_2ff_1 ( clk, rstn, async_in, sync_out );
  input clk, rstn, async_in;
  output sync_out;
  wire   q1;

  DFFARX1_RVT q1_reg ( .D(async_in), .CLK(clk), .RSTB(rstn), .Q(q1) );
  DFFARX1_RVT sync_out_reg ( .D(q1), .CLK(clk), .RSTB(rstn), .Q(sync_out) );
endmodule


module APB_controller ( clk, hrstn, apb_req, apb_ack, haddr1, hwdata1, 
        hwritereg, tempselx, prdata, pready, prdata_latched, pwrite, penable, 
        pselx, pwdata, paddr );
  input [31:0] haddr1;
  input [31:0] hwdata1;
  input [2:0] tempselx;
  input [31:0] prdata;
  output [31:0] prdata_latched;
  output [2:0] pselx;
  output [31:0] pwdata;
  output [31:0] paddr;
  input clk, hrstn, apb_req, hwritereg, pready;
  output apb_ack, pwrite, penable;
  wire   n1, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n2, n3, n4, n5, n6, n7,
         n8, n9, n46, n47, n48, n49, n50, n51, n52;
  wire   [2:0] state;

  DFFARX1_RVT \state_reg[0]  ( .D(n44), .CLK(n52), .RSTB(hrstn), .Q(state[0]), 
        .QN(n48) );
  DFFARX1_RVT \state_reg[1]  ( .D(n43), .CLK(n52), .RSTB(hrstn), .Q(state[1]), 
        .QN(n49) );
  DFFARX1_RVT apb_ack_reg ( .D(n42), .CLK(n52), .RSTB(hrstn), .Q(apb_ack) );
  DFFARX1_RVT pwrite_reg ( .D(n45), .CLK(n52), .RSTB(hrstn), .Q(n1), .QN(n50)
         );
  DFFARX1_RVT \prdata_latched_reg[0]  ( .D(n41), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[0]) );
  DFFARX1_RVT \prdata_latched_reg[1]  ( .D(n40), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[1]) );
  DFFARX1_RVT \prdata_latched_reg[2]  ( .D(n39), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[2]) );
  DFFARX1_RVT \prdata_latched_reg[3]  ( .D(n38), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[3]) );
  DFFARX1_RVT \prdata_latched_reg[4]  ( .D(n37), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[4]) );
  DFFARX1_RVT \prdata_latched_reg[5]  ( .D(n36), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[5]) );
  DFFARX1_RVT \prdata_latched_reg[6]  ( .D(n35), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[6]) );
  DFFARX1_RVT \prdata_latched_reg[7]  ( .D(n34), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[7]) );
  DFFARX1_RVT \prdata_latched_reg[8]  ( .D(n33), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[8]) );
  DFFARX1_RVT \prdata_latched_reg[9]  ( .D(n32), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[9]) );
  DFFARX1_RVT \prdata_latched_reg[10]  ( .D(n31), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[10]) );
  DFFARX1_RVT \prdata_latched_reg[11]  ( .D(n30), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[11]) );
  DFFARX1_RVT \prdata_latched_reg[12]  ( .D(n29), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[12]) );
  DFFARX1_RVT \prdata_latched_reg[13]  ( .D(n28), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[13]) );
  DFFARX1_RVT \prdata_latched_reg[14]  ( .D(n27), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[14]) );
  DFFARX1_RVT \prdata_latched_reg[15]  ( .D(n26), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[15]) );
  DFFARX1_RVT \prdata_latched_reg[16]  ( .D(n25), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[16]) );
  DFFARX1_RVT \prdata_latched_reg[17]  ( .D(n24), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[17]) );
  DFFARX1_RVT \prdata_latched_reg[18]  ( .D(n23), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[18]) );
  DFFARX1_RVT \prdata_latched_reg[19]  ( .D(n22), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[19]) );
  DFFARX1_RVT \prdata_latched_reg[20]  ( .D(n21), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[20]) );
  DFFARX1_RVT \prdata_latched_reg[21]  ( .D(n20), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[21]) );
  DFFARX1_RVT \prdata_latched_reg[22]  ( .D(n19), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[22]) );
  DFFARX1_RVT \prdata_latched_reg[23]  ( .D(n18), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[23]) );
  DFFARX1_RVT \prdata_latched_reg[24]  ( .D(n17), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[24]) );
  DFFARX1_RVT \prdata_latched_reg[25]  ( .D(n16), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[25]) );
  DFFARX1_RVT \prdata_latched_reg[26]  ( .D(n15), .CLK(clk), .RSTB(hrstn), .Q(
        prdata_latched[26]) );
  DFFARX1_RVT \prdata_latched_reg[27]  ( .D(n14), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[27]) );
  DFFARX1_RVT \prdata_latched_reg[28]  ( .D(n13), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[28]) );
  DFFARX1_RVT \prdata_latched_reg[29]  ( .D(n12), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[29]) );
  DFFARX1_RVT \prdata_latched_reg[30]  ( .D(n11), .CLK(n51), .RSTB(hrstn), .Q(
        prdata_latched[30]) );
  DFFARX1_RVT \prdata_latched_reg[31]  ( .D(n10), .CLK(n52), .RSTB(hrstn), .Q(
        prdata_latched[31]) );
  INVX0_RVT U3 ( .A(n47), .Y(n8) );
  INVX0_RVT U4 ( .A(n47), .Y(n46) );
  MUX21X1_RVT U5 ( .A1(hwritereg), .A2(n1), .S0(n2), .Y(n45) );
  NAND3X0_RVT U6 ( .A1(apb_req), .A2(n48), .A3(n49), .Y(n2) );
  NAND2X0_RVT U7 ( .A1(state[1]), .A2(apb_req), .Y(n4) );
  NAND2X0_RVT U8 ( .A1(apb_req), .A2(n49), .Y(n3) );
  MUX21X1_RVT U9 ( .A1(n4), .A2(n3), .S0(n48), .Y(n6) );
  NAND3X0_RVT U10 ( .A1(pready), .A2(n48), .A3(state[1]), .Y(n5) );
  NAND2X0_RVT U11 ( .A1(n6), .A2(n5), .Y(n44) );
  NBUFFX2_RVT U12 ( .A(clk), .Y(n51) );
  NBUFFX2_RVT U13 ( .A(clk), .Y(n52) );
  AO222X1_RVT U14 ( .A1(state[0]), .A2(apb_req), .A3(state[0]), .A4(n49), .A5(
        state[1]), .A6(n48), .Y(n43) );
  OA221X1_RVT U15 ( .A1(apb_ack), .A2(pready), .A3(apb_ack), .A4(n48), .A5(n43), .Y(n42) );
  NAND4X0_RVT U16 ( .A1(state[1]), .A2(pready), .A3(n48), .A4(n50), .Y(n7) );
  INVX0_RVT U17 ( .A(n7), .Y(n9) );
  NBUFFX2_RVT U18 ( .A(n9), .Y(n47) );
  AO22X1_RVT U19 ( .A1(n9), .A2(prdata[0]), .A3(n46), .A4(prdata_latched[0]), 
        .Y(n41) );
  AO22X1_RVT U20 ( .A1(n47), .A2(prdata[1]), .A3(n7), .A4(prdata_latched[1]), 
        .Y(n40) );
  AO22X1_RVT U21 ( .A1(n9), .A2(prdata[2]), .A3(n46), .A4(prdata_latched[2]), 
        .Y(n39) );
  AO22X1_RVT U22 ( .A1(n47), .A2(prdata[3]), .A3(n7), .A4(prdata_latched[3]), 
        .Y(n38) );
  AO22X1_RVT U23 ( .A1(n9), .A2(prdata[4]), .A3(n46), .A4(prdata_latched[4]), 
        .Y(n37) );
  AO22X1_RVT U24 ( .A1(n47), .A2(prdata[5]), .A3(n7), .A4(prdata_latched[5]), 
        .Y(n36) );
  AO22X1_RVT U25 ( .A1(n9), .A2(prdata[6]), .A3(n7), .A4(prdata_latched[6]), 
        .Y(n35) );
  AO22X1_RVT U26 ( .A1(n47), .A2(prdata[7]), .A3(n7), .A4(prdata_latched[7]), 
        .Y(n34) );
  AO22X1_RVT U27 ( .A1(n9), .A2(prdata[8]), .A3(n7), .A4(prdata_latched[8]), 
        .Y(n33) );
  AO22X1_RVT U28 ( .A1(n47), .A2(prdata[9]), .A3(n7), .A4(prdata_latched[9]), 
        .Y(n32) );
  AO22X1_RVT U29 ( .A1(n9), .A2(prdata[10]), .A3(n7), .A4(prdata_latched[10]), 
        .Y(n31) );
  AO22X1_RVT U30 ( .A1(n47), .A2(prdata[11]), .A3(n7), .A4(prdata_latched[11]), 
        .Y(n30) );
  AO22X1_RVT U31 ( .A1(n9), .A2(prdata[12]), .A3(n8), .A4(prdata_latched[12]), 
        .Y(n29) );
  AO22X1_RVT U32 ( .A1(n47), .A2(prdata[13]), .A3(n8), .A4(prdata_latched[13]), 
        .Y(n28) );
  AO22X1_RVT U33 ( .A1(n9), .A2(prdata[14]), .A3(n8), .A4(prdata_latched[14]), 
        .Y(n27) );
  AO22X1_RVT U34 ( .A1(n47), .A2(prdata[15]), .A3(n8), .A4(prdata_latched[15]), 
        .Y(n26) );
  AO22X1_RVT U35 ( .A1(n9), .A2(prdata[16]), .A3(n8), .A4(prdata_latched[16]), 
        .Y(n25) );
  AO22X1_RVT U36 ( .A1(n47), .A2(prdata[17]), .A3(n8), .A4(prdata_latched[17]), 
        .Y(n24) );
  AO22X1_RVT U37 ( .A1(n9), .A2(prdata[18]), .A3(n8), .A4(prdata_latched[18]), 
        .Y(n23) );
  AO22X1_RVT U38 ( .A1(n47), .A2(prdata[19]), .A3(n8), .A4(prdata_latched[19]), 
        .Y(n22) );
  AO22X1_RVT U39 ( .A1(n9), .A2(prdata[20]), .A3(n8), .A4(prdata_latched[20]), 
        .Y(n21) );
  AO22X1_RVT U40 ( .A1(n47), .A2(prdata[21]), .A3(n8), .A4(prdata_latched[21]), 
        .Y(n20) );
  AO22X1_RVT U41 ( .A1(n9), .A2(prdata[22]), .A3(n8), .A4(prdata_latched[22]), 
        .Y(n19) );
  AO22X1_RVT U42 ( .A1(n47), .A2(prdata[23]), .A3(n8), .A4(prdata_latched[23]), 
        .Y(n18) );
  AO22X1_RVT U43 ( .A1(n9), .A2(prdata[24]), .A3(n46), .A4(prdata_latched[24]), 
        .Y(n17) );
  AO22X1_RVT U44 ( .A1(n47), .A2(prdata[25]), .A3(n46), .A4(prdata_latched[25]), .Y(n16) );
  AO22X1_RVT U45 ( .A1(n9), .A2(prdata[26]), .A3(n46), .A4(prdata_latched[26]), 
        .Y(n15) );
  AO22X1_RVT U46 ( .A1(n47), .A2(prdata[27]), .A3(n46), .A4(prdata_latched[27]), .Y(n14) );
  AO22X1_RVT U47 ( .A1(n9), .A2(prdata[28]), .A3(n46), .A4(prdata_latched[28]), 
        .Y(n13) );
  AO22X1_RVT U48 ( .A1(n47), .A2(prdata[29]), .A3(n46), .A4(prdata_latched[29]), .Y(n12) );
  AO22X1_RVT U49 ( .A1(n9), .A2(prdata[30]), .A3(n46), .A4(prdata_latched[30]), 
        .Y(n11) );
  AO22X1_RVT U50 ( .A1(n47), .A2(prdata[31]), .A3(n46), .A4(prdata_latched[31]), .Y(n10) );
endmodule


module sync_2ff_0 ( clk, rstn, async_in, sync_out );
  input clk, rstn, async_in;
  output sync_out;
  wire   q1;

  DFFARX1_RVT q1_reg ( .D(async_in), .CLK(clk), .RSTB(rstn), .Q(q1) );
  DFFARX1_RVT sync_out_reg ( .D(q1), .CLK(clk), .RSTB(rstn), .Q(sync_out) );
endmodule


module dfs_top ( clk_in, hrstn, hwrite, htrans, haddr, hwdata, hreadyin, 
        prdata, pready, hrdata, hresp, hreadyout, activity_level, dfs_clk_out
 );
  input [1:0] htrans;
  input [31:0] haddr;
  input [31:0] hwdata;
  input [31:0] prdata;
  output [31:0] hrdata;
  output [1:0] hresp;
  output [7:0] activity_level;
  input clk_in, hrstn, hwrite, hreadyin, pready;
  output hreadyout, dfs_clk_out;
  wire   valid, hwritereg, apb_req_raw, apb_ack_sync, apb_req_sync,
         apb_ack_raw;
  wire   [31:0] prdata_latched;
  wire   SYNOPSYS_UNCONNECTED__0;
  assign hresp[0] = 1'b0;
  assign hresp[1] = 1'b0;
  assign activity_level[7] = 1'b0;

  AHB_slave u_ahb_slave ( .clk(clk_in), .hrstn(hrstn), .hwrite(hwrite), 
        .hreadyin(hreadyin), .htrans({htrans[1], net1060}), .haddr({
        haddr[31:26], net1061, net1062, net1063, net1064, net1065, net1066, 
        net1067, net1068, net1069, net1070, net1071, net1072, net1073, net1074, 
        net1075, net1076, net1077, net1078, net1079, net1080, net1081, net1082, 
        net1083, net1084, net1085, net1086}), .hwdata({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0}), .prdata({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0}), .prdata_latched(prdata_latched), .valid(valid), 
        .hwritereg(hwritereg), .ahb_req(apb_req_raw), .ahb_ack(apb_ack_sync), 
        .hreadyout(hreadyout), .hrdata(hrdata) );
  dfs_controller u_dfs_ctrl ( .clk_in(clk_in), .rstn(hrstn), .activity_level({
        1'b0, activity_level[6:0]}), .dfs_clk_out(dfs_clk_out) );
  activity_monitor u_act_mon ( .clk_in(clk_in), .rstn(hrstn), .valid(valid), 
        .hready(hreadyout), .activity_level({SYNOPSYS_UNCONNECTED__0, 
        activity_level[6:0]}) );
  sync_2ff_1 u_sync_req ( .clk(dfs_clk_out), .rstn(hrstn), .async_in(
        apb_req_raw), .sync_out(apb_req_sync) );
  sync_2ff_0 u_sync_ack ( .clk(clk_in), .rstn(hrstn), .async_in(apb_ack_raw), 
        .sync_out(apb_ack_sync) );
  APB_controller u_apb_ctrl ( .clk(dfs_clk_out), .hrstn(hrstn), .apb_req(
        apb_req_sync), .apb_ack(apb_ack_raw), .haddr1({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0}), .hwdata1({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0}), .hwritereg(hwritereg), .tempselx({1'b0, 1'b0, 1'b0}), 
        .prdata(prdata), .pready(pready), .prdata_latched(prdata_latched) );
endmodule

