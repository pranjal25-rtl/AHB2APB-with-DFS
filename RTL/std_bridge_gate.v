/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Tue Oct 20 19:14:08 2026
/////////////////////////////////////////////////////////////


module standard_bridge_top ( HCLK, HRESETn, HSEL, HADDR, HTRANS, HWRITE, HSIZE, 
        HBURST, HWDATA, HREADYIN, HRDATA, HREADYOUT, HRESP, PADDR, PSEL, 
        PENABLE, PWRITE, PWDATA, PRDATA, PREADY, PSLVERR );
  input [31:0] HADDR;
  input [1:0] HTRANS;
  input [2:0] HSIZE;
  input [2:0] HBURST;
  input [31:0] HWDATA;
  output [31:0] HRDATA;
  output [31:0] PADDR;
  output [3:0] PSEL;
  output [31:0] PWDATA;
  input [127:0] PRDATA;
  input [3:0] PREADY;
  input [3:0] PSLVERR;
  input HCLK, HRESETn, HSEL, HWRITE, HREADYIN;
  output HREADYOUT, HRESP, PENABLE, PWRITE;
  wire   n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285;
  wire   [2:0] state;
  assign PWDATA[31] = HWDATA[31];
  assign PWDATA[30] = HWDATA[30];
  assign PWDATA[29] = HWDATA[29];
  assign PWDATA[28] = HWDATA[28];
  assign PWDATA[27] = HWDATA[27];
  assign PWDATA[26] = HWDATA[26];
  assign PWDATA[25] = HWDATA[25];
  assign PWDATA[24] = HWDATA[24];
  assign PWDATA[23] = HWDATA[23];
  assign PWDATA[22] = HWDATA[22];
  assign PWDATA[21] = HWDATA[21];
  assign PWDATA[20] = HWDATA[20];
  assign PWDATA[19] = HWDATA[19];
  assign PWDATA[18] = HWDATA[18];
  assign PWDATA[17] = HWDATA[17];
  assign PWDATA[16] = HWDATA[16];
  assign PWDATA[15] = HWDATA[15];
  assign PWDATA[14] = HWDATA[14];
  assign PWDATA[13] = HWDATA[13];
  assign PWDATA[12] = HWDATA[12];
  assign PWDATA[11] = HWDATA[11];
  assign PWDATA[10] = HWDATA[10];
  assign PWDATA[9] = HWDATA[9];
  assign PWDATA[8] = HWDATA[8];
  assign PWDATA[7] = HWDATA[7];
  assign PWDATA[6] = HWDATA[6];
  assign PWDATA[5] = HWDATA[5];
  assign PWDATA[4] = HWDATA[4];
  assign PWDATA[3] = HWDATA[3];
  assign PWDATA[2] = HWDATA[2];
  assign PWDATA[1] = HWDATA[1];
  assign PWDATA[0] = HWDATA[0];

  DFFARX1_RVT \addr_q_reg[12]  ( .D(n121), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[12]), .QN(n281) );
  DFFARX1_RVT \addr_q_reg[31]  ( .D(n120), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[31]) );
  DFFARX1_RVT \addr_q_reg[30]  ( .D(n119), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[30]) );
  DFFARX1_RVT \addr_q_reg[29]  ( .D(n118), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[29]) );
  DFFARX1_RVT \addr_q_reg[28]  ( .D(n117), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[28]) );
  DFFARX1_RVT \addr_q_reg[27]  ( .D(n116), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[27]) );
  DFFARX1_RVT \addr_q_reg[26]  ( .D(n115), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[26]) );
  DFFARX1_RVT \addr_q_reg[25]  ( .D(n114), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[25]) );
  DFFARX1_RVT \addr_q_reg[24]  ( .D(n113), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[24]) );
  DFFARX1_RVT \addr_q_reg[23]  ( .D(n112), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[23]) );
  DFFARX1_RVT \addr_q_reg[22]  ( .D(n111), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[22]) );
  DFFARX1_RVT \addr_q_reg[21]  ( .D(n110), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[21]) );
  DFFARX1_RVT \addr_q_reg[20]  ( .D(n109), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[20]) );
  DFFARX1_RVT \addr_q_reg[19]  ( .D(n108), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[19]) );
  DFFARX1_RVT \addr_q_reg[18]  ( .D(n107), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[18]) );
  DFFARX1_RVT \addr_q_reg[17]  ( .D(n106), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[17]) );
  DFFARX1_RVT \addr_q_reg[16]  ( .D(n105), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[16]) );
  DFFARX1_RVT \addr_q_reg[15]  ( .D(n104), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[15]) );
  DFFARX1_RVT \addr_q_reg[14]  ( .D(n103), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[14]) );
  DFFARX1_RVT \addr_q_reg[13]  ( .D(n102), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[13]), .QN(n284) );
  DFFARX1_RVT \addr_q_reg[11]  ( .D(n101), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[11]) );
  DFFARX1_RVT \addr_q_reg[10]  ( .D(n100), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[10]) );
  DFFARX1_RVT \addr_q_reg[9]  ( .D(n99), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[9]) );
  DFFARX1_RVT \addr_q_reg[8]  ( .D(n98), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[8]) );
  DFFARX1_RVT \addr_q_reg[7]  ( .D(n97), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[7]) );
  DFFARX1_RVT \addr_q_reg[6]  ( .D(n96), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[6]) );
  DFFARX1_RVT \addr_q_reg[5]  ( .D(n95), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[5]) );
  DFFARX1_RVT \addr_q_reg[4]  ( .D(n94), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[4]) );
  DFFARX1_RVT \addr_q_reg[3]  ( .D(n93), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[3]) );
  DFFARX1_RVT \addr_q_reg[2]  ( .D(n92), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[2]) );
  DFFARX1_RVT \addr_q_reg[1]  ( .D(n91), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[1]) );
  DFFARX1_RVT \addr_q_reg[0]  ( .D(n90), .CLK(HCLK), .RSTB(HRESETn), .Q(
        PADDR[0]) );
  DFFARX1_RVT write_q_reg ( .D(n89), .CLK(HCLK), .RSTB(HRESETn), .Q(PWRITE) );
  DFFARX1_RVT \state_reg[0]  ( .D(n155), .CLK(HCLK), .RSTB(HRESETn), .Q(
        state[0]), .QN(n285) );
  DFFARX1_RVT \state_reg[1]  ( .D(n156), .CLK(HCLK), .RSTB(HRESETn), .Q(
        state[1]), .QN(n283) );
  DFFARX1_RVT \state_reg[2]  ( .D(n154), .CLK(HCLK), .RSTB(HRESETn), .Q(
        state[2]), .QN(n282) );
  DFFARX1_RVT \prdata_q_reg[9]  ( .D(n144), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[9]) );
  DFFARX1_RVT \prdata_q_reg[8]  ( .D(n145), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[8]) );
  DFFARX1_RVT \prdata_q_reg[7]  ( .D(n146), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[7]) );
  DFFARX1_RVT \prdata_q_reg[6]  ( .D(n147), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[6]) );
  DFFARX1_RVT \prdata_q_reg[5]  ( .D(n148), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[5]) );
  DFFARX1_RVT \prdata_q_reg[4]  ( .D(n149), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[4]) );
  DFFARX1_RVT \prdata_q_reg[3]  ( .D(n150), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[3]) );
  DFFARX1_RVT \prdata_q_reg[31]  ( .D(n122), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[31]) );
  DFFARX1_RVT \prdata_q_reg[30]  ( .D(n123), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[30]) );
  DFFARX1_RVT \prdata_q_reg[2]  ( .D(n151), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[2]) );
  DFFARX1_RVT \prdata_q_reg[29]  ( .D(n124), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[29]) );
  DFFARX1_RVT \prdata_q_reg[28]  ( .D(n125), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[28]) );
  DFFARX1_RVT \prdata_q_reg[27]  ( .D(n126), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[27]) );
  DFFARX1_RVT \prdata_q_reg[26]  ( .D(n127), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[26]) );
  DFFARX1_RVT \prdata_q_reg[25]  ( .D(n128), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[25]) );
  DFFARX1_RVT \prdata_q_reg[24]  ( .D(n129), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[24]) );
  DFFARX1_RVT \prdata_q_reg[23]  ( .D(n130), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[23]) );
  DFFARX1_RVT \prdata_q_reg[22]  ( .D(n131), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[22]) );
  DFFARX1_RVT \prdata_q_reg[21]  ( .D(n132), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[21]) );
  DFFARX1_RVT \prdata_q_reg[20]  ( .D(n133), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[20]) );
  DFFARX1_RVT \prdata_q_reg[1]  ( .D(n152), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[1]) );
  DFFARX1_RVT \prdata_q_reg[19]  ( .D(n134), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[19]) );
  DFFARX1_RVT \prdata_q_reg[18]  ( .D(n135), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[18]) );
  DFFARX1_RVT \prdata_q_reg[17]  ( .D(n136), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[17]) );
  DFFARX1_RVT \prdata_q_reg[16]  ( .D(n137), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[16]) );
  DFFARX1_RVT \prdata_q_reg[15]  ( .D(n138), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[15]) );
  DFFARX1_RVT \prdata_q_reg[14]  ( .D(n139), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[14]) );
  DFFARX1_RVT \prdata_q_reg[13]  ( .D(n140), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[13]) );
  DFFARX1_RVT \prdata_q_reg[12]  ( .D(n141), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[12]) );
  DFFARX1_RVT \prdata_q_reg[11]  ( .D(n142), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[11]) );
  DFFARX1_RVT \prdata_q_reg[10]  ( .D(n143), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[10]) );
  DFFARX1_RVT \prdata_q_reg[0]  ( .D(n153), .CLK(HCLK), .RSTB(HRESETn), .Q(
        HRDATA[0]) );
  AND2X1_RVT U166 ( .A1(PENABLE), .A2(n161), .Y(n167) );
  AND3X1_RVT U167 ( .A1(PADDR[12]), .A2(n167), .A3(n284), .Y(n267) );
  NAND3X0_RVT U168 ( .A1(state[1]), .A2(n282), .A3(n285), .Y(n272) );
  INVX1_RVT U169 ( .A(n272), .Y(PENABLE) );
  AND2X1_RVT U170 ( .A1(n284), .A2(n281), .Y(n274) );
  MUX41X1_RVT U171 ( .A1(PREADY[3]), .A3(PREADY[1]), .A2(PREADY[2]), .A4(
        PREADY[0]), .S0(n284), .S1(n281), .Y(n161) );
  AND2X1_RVT U172 ( .A1(n274), .A2(n167), .Y(n264) );
  NBUFFX2_RVT U173 ( .A(n264), .Y(n253) );
  AND3X1_RVT U174 ( .A1(PADDR[13]), .A2(PADDR[12]), .A3(n167), .Y(n263) );
  NBUFFX2_RVT U175 ( .A(n263), .Y(n252) );
  AOI22X1_RVT U176 ( .A1(n253), .A2(PRDATA[0]), .A3(n252), .A4(PRDATA[96]), 
        .Y(n160) );
  AND3X1_RVT U177 ( .A1(PADDR[13]), .A2(n167), .A3(n281), .Y(n266) );
  NBUFFX2_RVT U178 ( .A(n266), .Y(n254) );
  INVX0_RVT U179 ( .A(n167), .Y(n259) );
  AOI22X1_RVT U180 ( .A1(PRDATA[64]), .A2(n254), .A3(HRDATA[0]), .A4(n259), 
        .Y(n159) );
  NBUFFX2_RVT U181 ( .A(n267), .Y(n255) );
  NAND2X0_RVT U182 ( .A1(n255), .A2(PRDATA[32]), .Y(n158) );
  NAND3X0_RVT U183 ( .A1(n160), .A2(n159), .A3(n158), .Y(n153) );
  AND2X1_RVT U184 ( .A1(n285), .A2(n283), .Y(HREADYOUT) );
  INVX0_RVT U185 ( .A(n161), .Y(n164) );
  NAND3X0_RVT U186 ( .A1(HREADYIN), .A2(HSEL), .A3(HTRANS[1]), .Y(n275) );
  MUX41X1_RVT U187 ( .A1(PSLVERR[2]), .A3(PSLVERR[0]), .A2(PSLVERR[3]), .A4(
        PSLVERR[1]), .S0(n284), .S1(PADDR[12]), .Y(n162) );
  NAND2X0_RVT U188 ( .A1(PENABLE), .A2(n162), .Y(n166) );
  NAND2X0_RVT U189 ( .A1(HREADYOUT), .A2(n282), .Y(n276) );
  AO22X1_RVT U190 ( .A1(HREADYOUT), .A2(n275), .A3(n166), .A4(n276), .Y(n163)
         );
  AOI21X1_RVT U191 ( .A1(n164), .A2(PENABLE), .A3(n163), .Y(n155) );
  NAND2X0_RVT U192 ( .A1(PENABLE), .A2(n164), .Y(n165) );
  NAND3X0_RVT U193 ( .A1(state[0]), .A2(n282), .A3(n283), .Y(n271) );
  NAND3X0_RVT U194 ( .A1(n166), .A2(n165), .A3(n271), .Y(n156) );
  AOI22X1_RVT U195 ( .A1(n264), .A2(PRDATA[9]), .A3(n263), .A4(PRDATA[105]), 
        .Y(n170) );
  INVX0_RVT U196 ( .A(n167), .Y(n265) );
  AOI22X1_RVT U197 ( .A1(PRDATA[73]), .A2(n266), .A3(HRDATA[9]), .A4(n265), 
        .Y(n169) );
  NAND2X0_RVT U198 ( .A1(n267), .A2(PRDATA[41]), .Y(n168) );
  NAND3X0_RVT U199 ( .A1(n170), .A2(n169), .A3(n168), .Y(n144) );
  AOI22X1_RVT U200 ( .A1(n253), .A2(PRDATA[8]), .A3(n252), .A4(PRDATA[104]), 
        .Y(n173) );
  AOI22X1_RVT U201 ( .A1(PRDATA[72]), .A2(n254), .A3(HRDATA[8]), .A4(n265), 
        .Y(n172) );
  NAND2X0_RVT U202 ( .A1(n255), .A2(PRDATA[40]), .Y(n171) );
  NAND3X0_RVT U203 ( .A1(n173), .A2(n172), .A3(n171), .Y(n145) );
  AOI22X1_RVT U204 ( .A1(n264), .A2(PRDATA[7]), .A3(n263), .A4(PRDATA[103]), 
        .Y(n176) );
  AOI22X1_RVT U205 ( .A1(PRDATA[71]), .A2(n266), .A3(HRDATA[7]), .A4(n265), 
        .Y(n175) );
  NAND2X0_RVT U206 ( .A1(n267), .A2(PRDATA[39]), .Y(n174) );
  NAND3X0_RVT U207 ( .A1(n176), .A2(n175), .A3(n174), .Y(n146) );
  AOI22X1_RVT U208 ( .A1(n253), .A2(PRDATA[6]), .A3(n252), .A4(PRDATA[102]), 
        .Y(n179) );
  AOI22X1_RVT U209 ( .A1(PRDATA[70]), .A2(n254), .A3(HRDATA[6]), .A4(n259), 
        .Y(n178) );
  NAND2X0_RVT U210 ( .A1(n255), .A2(PRDATA[38]), .Y(n177) );
  NAND3X0_RVT U211 ( .A1(n179), .A2(n178), .A3(n177), .Y(n147) );
  AOI22X1_RVT U212 ( .A1(n264), .A2(PRDATA[5]), .A3(n263), .A4(PRDATA[101]), 
        .Y(n182) );
  AOI22X1_RVT U213 ( .A1(PRDATA[69]), .A2(n266), .A3(HRDATA[5]), .A4(n265), 
        .Y(n181) );
  NAND2X0_RVT U214 ( .A1(n267), .A2(PRDATA[37]), .Y(n180) );
  NAND3X0_RVT U215 ( .A1(n182), .A2(n181), .A3(n180), .Y(n148) );
  AOI22X1_RVT U216 ( .A1(n253), .A2(PRDATA[4]), .A3(n252), .A4(PRDATA[100]), 
        .Y(n185) );
  AOI22X1_RVT U217 ( .A1(PRDATA[68]), .A2(n254), .A3(HRDATA[4]), .A4(n259), 
        .Y(n184) );
  NAND2X0_RVT U218 ( .A1(n255), .A2(PRDATA[36]), .Y(n183) );
  NAND3X0_RVT U219 ( .A1(n185), .A2(n184), .A3(n183), .Y(n149) );
  AOI22X1_RVT U220 ( .A1(n264), .A2(PRDATA[3]), .A3(n263), .A4(PRDATA[99]), 
        .Y(n188) );
  AOI22X1_RVT U221 ( .A1(PRDATA[67]), .A2(n266), .A3(HRDATA[3]), .A4(n265), 
        .Y(n187) );
  NAND2X0_RVT U222 ( .A1(n267), .A2(PRDATA[35]), .Y(n186) );
  NAND3X0_RVT U223 ( .A1(n188), .A2(n187), .A3(n186), .Y(n150) );
  AOI22X1_RVT U224 ( .A1(n253), .A2(PRDATA[31]), .A3(n252), .A4(PRDATA[127]), 
        .Y(n191) );
  AOI22X1_RVT U225 ( .A1(PRDATA[95]), .A2(n254), .A3(HRDATA[31]), .A4(n265), 
        .Y(n190) );
  NAND2X0_RVT U226 ( .A1(n255), .A2(PRDATA[63]), .Y(n189) );
  NAND3X0_RVT U227 ( .A1(n191), .A2(n190), .A3(n189), .Y(n122) );
  AOI22X1_RVT U228 ( .A1(n253), .A2(PRDATA[30]), .A3(n252), .A4(PRDATA[126]), 
        .Y(n194) );
  AOI22X1_RVT U229 ( .A1(PRDATA[94]), .A2(n254), .A3(HRDATA[30]), .A4(n265), 
        .Y(n193) );
  NAND2X0_RVT U230 ( .A1(n255), .A2(PRDATA[62]), .Y(n192) );
  NAND3X0_RVT U231 ( .A1(n194), .A2(n193), .A3(n192), .Y(n123) );
  AOI22X1_RVT U232 ( .A1(n253), .A2(PRDATA[2]), .A3(n252), .A4(PRDATA[98]), 
        .Y(n197) );
  AOI22X1_RVT U233 ( .A1(PRDATA[66]), .A2(n254), .A3(HRDATA[2]), .A4(n259), 
        .Y(n196) );
  NAND2X0_RVT U234 ( .A1(n255), .A2(PRDATA[34]), .Y(n195) );
  NAND3X0_RVT U235 ( .A1(n197), .A2(n196), .A3(n195), .Y(n151) );
  AOI22X1_RVT U236 ( .A1(n253), .A2(PRDATA[29]), .A3(n252), .A4(PRDATA[125]), 
        .Y(n200) );
  AOI22X1_RVT U237 ( .A1(PRDATA[93]), .A2(n254), .A3(HRDATA[29]), .A4(n265), 
        .Y(n199) );
  NAND2X0_RVT U238 ( .A1(n255), .A2(PRDATA[61]), .Y(n198) );
  NAND3X0_RVT U239 ( .A1(n200), .A2(n199), .A3(n198), .Y(n124) );
  AOI22X1_RVT U240 ( .A1(n253), .A2(PRDATA[28]), .A3(n252), .A4(PRDATA[124]), 
        .Y(n203) );
  AOI22X1_RVT U241 ( .A1(PRDATA[92]), .A2(n254), .A3(HRDATA[28]), .A4(n265), 
        .Y(n202) );
  NAND2X0_RVT U242 ( .A1(n255), .A2(PRDATA[60]), .Y(n201) );
  NAND3X0_RVT U243 ( .A1(n203), .A2(n202), .A3(n201), .Y(n125) );
  AOI22X1_RVT U244 ( .A1(n253), .A2(PRDATA[27]), .A3(n252), .A4(PRDATA[123]), 
        .Y(n206) );
  AOI22X1_RVT U245 ( .A1(PRDATA[91]), .A2(n254), .A3(HRDATA[27]), .A4(n265), 
        .Y(n205) );
  NAND2X0_RVT U246 ( .A1(n255), .A2(PRDATA[59]), .Y(n204) );
  NAND3X0_RVT U247 ( .A1(n206), .A2(n205), .A3(n204), .Y(n126) );
  AOI22X1_RVT U248 ( .A1(n253), .A2(PRDATA[26]), .A3(n252), .A4(PRDATA[122]), 
        .Y(n209) );
  AOI22X1_RVT U249 ( .A1(PRDATA[90]), .A2(n254), .A3(HRDATA[26]), .A4(n265), 
        .Y(n208) );
  NAND2X0_RVT U250 ( .A1(n255), .A2(PRDATA[58]), .Y(n207) );
  NAND3X0_RVT U251 ( .A1(n209), .A2(n208), .A3(n207), .Y(n127) );
  AOI22X1_RVT U252 ( .A1(n253), .A2(PRDATA[25]), .A3(n252), .A4(PRDATA[121]), 
        .Y(n212) );
  AOI22X1_RVT U253 ( .A1(PRDATA[89]), .A2(n254), .A3(HRDATA[25]), .A4(n265), 
        .Y(n211) );
  NAND2X0_RVT U254 ( .A1(n255), .A2(PRDATA[57]), .Y(n210) );
  NAND3X0_RVT U255 ( .A1(n212), .A2(n211), .A3(n210), .Y(n128) );
  AOI22X1_RVT U256 ( .A1(n253), .A2(PRDATA[24]), .A3(n252), .A4(PRDATA[120]), 
        .Y(n215) );
  AOI22X1_RVT U257 ( .A1(PRDATA[88]), .A2(n254), .A3(HRDATA[24]), .A4(n265), 
        .Y(n214) );
  NAND2X0_RVT U258 ( .A1(n255), .A2(PRDATA[56]), .Y(n213) );
  NAND3X0_RVT U259 ( .A1(n215), .A2(n214), .A3(n213), .Y(n129) );
  AOI22X1_RVT U260 ( .A1(n264), .A2(PRDATA[23]), .A3(n263), .A4(PRDATA[119]), 
        .Y(n218) );
  AOI22X1_RVT U261 ( .A1(PRDATA[87]), .A2(n266), .A3(HRDATA[23]), .A4(n259), 
        .Y(n217) );
  NAND2X0_RVT U262 ( .A1(n267), .A2(PRDATA[55]), .Y(n216) );
  NAND3X0_RVT U263 ( .A1(n218), .A2(n217), .A3(n216), .Y(n130) );
  AOI22X1_RVT U264 ( .A1(n264), .A2(PRDATA[22]), .A3(n263), .A4(PRDATA[118]), 
        .Y(n221) );
  AOI22X1_RVT U265 ( .A1(PRDATA[86]), .A2(n266), .A3(HRDATA[22]), .A4(n259), 
        .Y(n220) );
  NAND2X0_RVT U266 ( .A1(n267), .A2(PRDATA[54]), .Y(n219) );
  NAND3X0_RVT U267 ( .A1(n221), .A2(n220), .A3(n219), .Y(n131) );
  AOI22X1_RVT U268 ( .A1(n264), .A2(PRDATA[21]), .A3(n263), .A4(PRDATA[117]), 
        .Y(n224) );
  AOI22X1_RVT U269 ( .A1(PRDATA[85]), .A2(n266), .A3(HRDATA[21]), .A4(n259), 
        .Y(n223) );
  NAND2X0_RVT U270 ( .A1(n267), .A2(PRDATA[53]), .Y(n222) );
  NAND3X0_RVT U271 ( .A1(n224), .A2(n223), .A3(n222), .Y(n132) );
  AOI22X1_RVT U272 ( .A1(n253), .A2(PRDATA[10]), .A3(n252), .A4(PRDATA[106]), 
        .Y(n227) );
  AOI22X1_RVT U273 ( .A1(PRDATA[74]), .A2(n254), .A3(HRDATA[10]), .A4(n265), 
        .Y(n226) );
  NAND2X0_RVT U274 ( .A1(n255), .A2(PRDATA[42]), .Y(n225) );
  NAND3X0_RVT U275 ( .A1(n227), .A2(n226), .A3(n225), .Y(n143) );
  AOI22X1_RVT U276 ( .A1(n264), .A2(PRDATA[20]), .A3(n263), .A4(PRDATA[116]), 
        .Y(n230) );
  AOI22X1_RVT U277 ( .A1(PRDATA[84]), .A2(n266), .A3(HRDATA[20]), .A4(n259), 
        .Y(n229) );
  NAND2X0_RVT U278 ( .A1(n267), .A2(PRDATA[52]), .Y(n228) );
  NAND3X0_RVT U279 ( .A1(n230), .A2(n229), .A3(n228), .Y(n133) );
  AOI22X1_RVT U280 ( .A1(n264), .A2(PRDATA[1]), .A3(n263), .A4(PRDATA[97]), 
        .Y(n233) );
  AOI22X1_RVT U281 ( .A1(PRDATA[65]), .A2(n266), .A3(HRDATA[1]), .A4(n265), 
        .Y(n232) );
  NAND2X0_RVT U282 ( .A1(n267), .A2(PRDATA[33]), .Y(n231) );
  NAND3X0_RVT U283 ( .A1(n233), .A2(n232), .A3(n231), .Y(n152) );
  AOI22X1_RVT U284 ( .A1(n264), .A2(PRDATA[19]), .A3(n263), .A4(PRDATA[115]), 
        .Y(n236) );
  AOI22X1_RVT U285 ( .A1(PRDATA[83]), .A2(n266), .A3(HRDATA[19]), .A4(n259), 
        .Y(n235) );
  NAND2X0_RVT U286 ( .A1(n267), .A2(PRDATA[51]), .Y(n234) );
  NAND3X0_RVT U287 ( .A1(n236), .A2(n235), .A3(n234), .Y(n134) );
  AOI22X1_RVT U288 ( .A1(n264), .A2(PRDATA[18]), .A3(n263), .A4(PRDATA[114]), 
        .Y(n239) );
  AOI22X1_RVT U289 ( .A1(PRDATA[82]), .A2(n266), .A3(HRDATA[18]), .A4(n259), 
        .Y(n238) );
  NAND2X0_RVT U290 ( .A1(n267), .A2(PRDATA[50]), .Y(n237) );
  NAND3X0_RVT U291 ( .A1(n239), .A2(n238), .A3(n237), .Y(n135) );
  AOI22X1_RVT U292 ( .A1(n253), .A2(PRDATA[17]), .A3(n252), .A4(PRDATA[113]), 
        .Y(n242) );
  AOI22X1_RVT U293 ( .A1(PRDATA[81]), .A2(n254), .A3(HRDATA[17]), .A4(n259), 
        .Y(n241) );
  NAND2X0_RVT U294 ( .A1(n255), .A2(PRDATA[49]), .Y(n240) );
  NAND3X0_RVT U295 ( .A1(n242), .A2(n241), .A3(n240), .Y(n136) );
  AOI22X1_RVT U296 ( .A1(n264), .A2(PRDATA[16]), .A3(n263), .A4(PRDATA[112]), 
        .Y(n245) );
  AOI22X1_RVT U297 ( .A1(PRDATA[80]), .A2(n266), .A3(HRDATA[16]), .A4(n259), 
        .Y(n244) );
  NAND2X0_RVT U298 ( .A1(n267), .A2(PRDATA[48]), .Y(n243) );
  NAND3X0_RVT U299 ( .A1(n245), .A2(n244), .A3(n243), .Y(n137) );
  AOI22X1_RVT U300 ( .A1(n253), .A2(PRDATA[15]), .A3(n252), .A4(PRDATA[111]), 
        .Y(n248) );
  AOI22X1_RVT U301 ( .A1(PRDATA[79]), .A2(n254), .A3(HRDATA[15]), .A4(n259), 
        .Y(n247) );
  NAND2X0_RVT U302 ( .A1(n255), .A2(PRDATA[47]), .Y(n246) );
  NAND3X0_RVT U303 ( .A1(n248), .A2(n247), .A3(n246), .Y(n138) );
  AOI22X1_RVT U304 ( .A1(n264), .A2(PRDATA[14]), .A3(n263), .A4(PRDATA[110]), 
        .Y(n251) );
  AOI22X1_RVT U305 ( .A1(PRDATA[78]), .A2(n266), .A3(HRDATA[14]), .A4(n259), 
        .Y(n250) );
  NAND2X0_RVT U306 ( .A1(n267), .A2(PRDATA[46]), .Y(n249) );
  NAND3X0_RVT U307 ( .A1(n251), .A2(n250), .A3(n249), .Y(n139) );
  AOI22X1_RVT U308 ( .A1(n253), .A2(PRDATA[13]), .A3(n252), .A4(PRDATA[109]), 
        .Y(n258) );
  AOI22X1_RVT U309 ( .A1(PRDATA[77]), .A2(n254), .A3(HRDATA[13]), .A4(n259), 
        .Y(n257) );
  NAND2X0_RVT U310 ( .A1(n255), .A2(PRDATA[45]), .Y(n256) );
  NAND3X0_RVT U311 ( .A1(n258), .A2(n257), .A3(n256), .Y(n140) );
  AOI22X1_RVT U312 ( .A1(n264), .A2(PRDATA[12]), .A3(n263), .A4(PRDATA[108]), 
        .Y(n262) );
  AOI22X1_RVT U313 ( .A1(PRDATA[76]), .A2(n266), .A3(HRDATA[12]), .A4(n259), 
        .Y(n261) );
  NAND2X0_RVT U314 ( .A1(n267), .A2(PRDATA[44]), .Y(n260) );
  NAND3X0_RVT U315 ( .A1(n262), .A2(n261), .A3(n260), .Y(n141) );
  AOI22X1_RVT U316 ( .A1(n264), .A2(PRDATA[11]), .A3(n263), .A4(PRDATA[107]), 
        .Y(n270) );
  AOI22X1_RVT U317 ( .A1(PRDATA[75]), .A2(n266), .A3(HRDATA[11]), .A4(n265), 
        .Y(n269) );
  NAND2X0_RVT U318 ( .A1(n267), .A2(PRDATA[43]), .Y(n268) );
  NAND3X0_RVT U319 ( .A1(n270), .A2(n269), .A3(n268), .Y(n142) );
  NAND2X0_RVT U320 ( .A1(n272), .A2(n271), .Y(n273) );
  AND3X1_RVT U321 ( .A1(PADDR[12]), .A2(n284), .A3(n273), .Y(PSEL[1]) );
  AND3X1_RVT U322 ( .A1(PADDR[13]), .A2(n281), .A3(n273), .Y(PSEL[2]) );
  AND3X1_RVT U323 ( .A1(PADDR[12]), .A2(PADDR[13]), .A3(n273), .Y(PSEL[3]) );
  AND3X1_RVT U324 ( .A1(state[0]), .A2(state[1]), .A3(n282), .Y(n154) );
  AO21X1_RVT U325 ( .A1(HREADYOUT), .A2(state[2]), .A3(n154), .Y(HRESP) );
  AND2X1_RVT U326 ( .A1(n274), .A2(n273), .Y(PSEL[0]) );
  NOR2X0_RVT U327 ( .A1(n276), .A2(n275), .Y(n278) );
  INVX0_RVT U328 ( .A(n278), .Y(n279) );
  AO22X1_RVT U329 ( .A1(n278), .A2(HADDR[12]), .A3(n279), .A4(PADDR[12]), .Y(
        n121) );
  NBUFFX2_RVT U330 ( .A(n278), .Y(n280) );
  INVX0_RVT U331 ( .A(n280), .Y(n277) );
  AO22X1_RVT U332 ( .A1(n278), .A2(HADDR[31]), .A3(n277), .A4(PADDR[31]), .Y(
        n120) );
  AO22X1_RVT U333 ( .A1(n278), .A2(HADDR[30]), .A3(n279), .A4(PADDR[30]), .Y(
        n119) );
  AO22X1_RVT U334 ( .A1(n278), .A2(HADDR[29]), .A3(n277), .A4(PADDR[29]), .Y(
        n118) );
  AO22X1_RVT U335 ( .A1(n278), .A2(HADDR[28]), .A3(n279), .A4(PADDR[28]), .Y(
        n117) );
  AO22X1_RVT U336 ( .A1(n278), .A2(HADDR[27]), .A3(n277), .A4(PADDR[27]), .Y(
        n116) );
  AO22X1_RVT U337 ( .A1(n278), .A2(HADDR[26]), .A3(n279), .A4(PADDR[26]), .Y(
        n115) );
  AO22X1_RVT U338 ( .A1(n280), .A2(HADDR[25]), .A3(n277), .A4(PADDR[25]), .Y(
        n114) );
  AO22X1_RVT U339 ( .A1(n278), .A2(HADDR[24]), .A3(n279), .A4(PADDR[24]), .Y(
        n113) );
  AO22X1_RVT U340 ( .A1(n280), .A2(HADDR[23]), .A3(n279), .A4(PADDR[23]), .Y(
        n112) );
  AO22X1_RVT U341 ( .A1(n278), .A2(HADDR[22]), .A3(n279), .A4(PADDR[22]), .Y(
        n111) );
  AO22X1_RVT U342 ( .A1(n280), .A2(HADDR[21]), .A3(n279), .A4(PADDR[21]), .Y(
        n110) );
  AO22X1_RVT U343 ( .A1(n280), .A2(HADDR[20]), .A3(n277), .A4(PADDR[20]), .Y(
        n109) );
  AO22X1_RVT U344 ( .A1(n280), .A2(HADDR[19]), .A3(n277), .A4(PADDR[19]), .Y(
        n108) );
  AO22X1_RVT U345 ( .A1(n280), .A2(HADDR[18]), .A3(n277), .A4(PADDR[18]), .Y(
        n107) );
  AO22X1_RVT U346 ( .A1(n280), .A2(HADDR[17]), .A3(n277), .A4(PADDR[17]), .Y(
        n106) );
  AO22X1_RVT U347 ( .A1(n280), .A2(HADDR[16]), .A3(n277), .A4(PADDR[16]), .Y(
        n105) );
  AO22X1_RVT U348 ( .A1(n280), .A2(HADDR[15]), .A3(n277), .A4(PADDR[15]), .Y(
        n104) );
  AO22X1_RVT U349 ( .A1(n278), .A2(HADDR[14]), .A3(n277), .A4(PADDR[14]), .Y(
        n103) );
  AO22X1_RVT U350 ( .A1(n278), .A2(HADDR[13]), .A3(n277), .A4(PADDR[13]), .Y(
        n102) );
  AO22X1_RVT U351 ( .A1(n278), .A2(HADDR[11]), .A3(n277), .A4(PADDR[11]), .Y(
        n101) );
  AO22X1_RVT U352 ( .A1(n278), .A2(HADDR[10]), .A3(n277), .A4(PADDR[10]), .Y(
        n100) );
  AO22X1_RVT U353 ( .A1(n278), .A2(HADDR[9]), .A3(n277), .A4(PADDR[9]), .Y(n99) );
  AO22X1_RVT U354 ( .A1(n278), .A2(HADDR[8]), .A3(n277), .A4(PADDR[8]), .Y(n98) );
  AO22X1_RVT U355 ( .A1(n280), .A2(HADDR[7]), .A3(n279), .A4(PADDR[7]), .Y(n97) );
  AO22X1_RVT U356 ( .A1(n280), .A2(HADDR[6]), .A3(n279), .A4(PADDR[6]), .Y(n96) );
  AO22X1_RVT U357 ( .A1(n280), .A2(HADDR[5]), .A3(n279), .A4(PADDR[5]), .Y(n95) );
  AO22X1_RVT U358 ( .A1(n280), .A2(HADDR[4]), .A3(n279), .A4(PADDR[4]), .Y(n94) );
  AO22X1_RVT U359 ( .A1(n280), .A2(HADDR[3]), .A3(n279), .A4(PADDR[3]), .Y(n93) );
  AO22X1_RVT U360 ( .A1(n280), .A2(HADDR[2]), .A3(n279), .A4(PADDR[2]), .Y(n92) );
  AO22X1_RVT U361 ( .A1(n280), .A2(HADDR[1]), .A3(n279), .A4(PADDR[1]), .Y(n91) );
  AO22X1_RVT U362 ( .A1(n280), .A2(HADDR[0]), .A3(n279), .A4(PADDR[0]), .Y(n90) );
  AO22X1_RVT U363 ( .A1(n280), .A2(HWRITE), .A3(n279), .A4(PWRITE), .Y(n89) );
endmodule

