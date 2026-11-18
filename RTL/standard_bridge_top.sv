// -----------------------------------------------------------------------------
// AHB-Lite slave  ->  APB3 master bridge (multi-slave, PREADY/PSLVERR support)
//
//  - Single AHB-Lite slave port, single APB master port with one-hot PSEL.
//  - Address map: each APB slave owns 2**SLV_ADDR_BITS bytes, slave index is
//    HADDR[SLV_ADDR_BITS +: SEL_W]. Index >= NUM_SLAVES -> AHB ERROR response.
//  - PSLVERR from the APB slave -> AHB two-cycle ERROR response.
//  - Throughput: IDLE(addr) -> SETUP -> ACCESS(+waits) -> IDLE, i.e. a minimum
//    of 3 cycles per transfer. Back-to-back transfers are accepted in the
//    completion (IDLE) cycle.
//  - Only NONSEQ/SEQ transfers are handled; BUSY/IDLE are answered with OKAY.
//  - Bursts are serviced as a sequence of independent single APB transfers.
// -----------------------------------------------------------------------------
module standard_bridge_top #(
  parameter int ADDR_WIDTH    = 32,
  parameter int DATA_WIDTH    = 32,
  parameter int NUM_SLAVES    = 4,
  parameter int SLV_ADDR_BITS = 12     // 4 KB per APB slave
)(
  input  logic                              HCLK,
  input  logic                              HRESETn,

  // ---------------- AHB-Lite slave interface ----------------
  input  logic                              HSEL,
  input  logic [ADDR_WIDTH-1:0]             HADDR,
  input  logic [1:0]                        HTRANS,
  input  logic                              HWRITE,
  input  logic [2:0]                        HSIZE,      // unused (APB3 has no strobes)
  input  logic [2:0]                        HBURST,     // unused
  input  logic [DATA_WIDTH-1:0]             HWDATA,
  input  logic                              HREADYIN,   // bus-wide HREADY
  output logic [DATA_WIDTH-1:0]             HRDATA,
  output logic                              HREADYOUT,
  output logic                              HRESP,      // 0 = OKAY, 1 = ERROR

  // ---------------- APB master interface ----------------
  output logic [ADDR_WIDTH-1:0]             PADDR,
  output logic [NUM_SLAVES-1:0]             PSEL,
  output logic                              PENABLE,
  output logic                              PWRITE,
  output logic [DATA_WIDTH-1:0]             PWDATA,
  input  logic [NUM_SLAVES*DATA_WIDTH-1:0]  PRDATA,     // packed, slave i at [i*DW +: DW]
  input  logic [NUM_SLAVES-1:0]             PREADY,
  input  logic [NUM_SLAVES-1:0]             PSLVERR
);

  localparam int SEL_W = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1;

  typedef enum logic [2:0] {
    S_IDLE   = 3'd0,   // HREADYOUT=1, also the completion cycle of a transfer
    S_SETUP  = 3'd1,   // APB setup phase  (PSEL=1, PENABLE=0)
    S_ACCESS = 3'd2,   // APB access phase (PSEL=1, PENABLE=1)
    S_ERR1   = 3'd3,   // AHB error, first cycle  (HREADYOUT=0, HRESP=1)
    S_ERR2   = 3'd4    // AHB error, second cycle (HREADYOUT=1, HRESP=1)
  } state_t;

  state_t                  state, state_n;

  logic [ADDR_WIDTH-1:0]   addr_q;
  logic                    write_q;
  logic [SEL_W-1:0]        sel_q;
  logic [DATA_WIDTH-1:0]   prdata_q;

  // ---------------- Address-phase decode ----------------
  logic [SEL_W-1:0] haddr_idx;
  logic             slave_valid;
  logic             ahb_req;

  assign haddr_idx   = HADDR[SLV_ADDR_BITS +: SEL_W];
  assign slave_valid = (int'(haddr_idx) < NUM_SLAVES);
  assign ahb_req     = HSEL & HTRANS[1] & HREADYIN;

  // ---------------- APB response mux ----------------
  logic                  pready_sel, pslverr_sel;
  logic [DATA_WIDTH-1:0] prdata_sel;

  always_comb begin
    pready_sel  = PREADY[sel_q];
    pslverr_sel = PSLVERR[sel_q];
    prdata_sel  = PRDATA[int'(sel_q)*DATA_WIDTH +: DATA_WIDTH];
  end

  // ---------------- Next-state logic ----------------
  always_comb begin
    state_n = state;
    unique case (state)
      S_IDLE:   if (ahb_req) state_n = slave_valid ? S_SETUP : S_ERR1;
      S_SETUP:  state_n = S_ACCESS;
      S_ACCESS: if (pready_sel) state_n = pslverr_sel ? S_ERR1 : S_IDLE;
      S_ERR1:   state_n = S_ERR2;
      S_ERR2:   state_n = S_IDLE;     // master cancels any transfer during ERR1
      default:  state_n = S_IDLE;
    endcase
  end

  // ---------------- Registers ----------------
  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
      state    <= S_IDLE;
      addr_q   <= '0;
      write_q  <= 1'b0;
      sel_q    <= '0;
      prdata_q <= '0;
    end else begin
      state <= state_n;

      if (state == S_IDLE && ahb_req) begin
        addr_q  <= HADDR;
        write_q <= HWRITE;
        sel_q   <= haddr_idx;
      end

      if (state == S_ACCESS && pready_sel)
        prdata_q <= prdata_sel;
    end
  end

  // ---------------- Outputs ----------------
  // APB side
  always_comb begin
    PSEL = '0;
    if (state == S_SETUP || state == S_ACCESS)
      PSEL[sel_q] = 1'b1;
  end

  assign PENABLE = (state == S_ACCESS);
  assign PADDR   = addr_q;
  assign PWRITE  = write_q;
  // HWDATA is valid from the first data-phase cycle (= S_SETUP) and the master
  // must hold it while HREADYOUT is low, so it can be passed straight through.
  assign PWDATA  = HWDATA;

  // AHB side
  assign HREADYOUT = (state == S_IDLE) || (state == S_ERR2);
  assign HRESP     = (state == S_ERR1) || (state == S_ERR2);
  assign HRDATA    = prdata_q;

  // HSIZE / HBURST intentionally unused
  logic unused_ok;
  assign unused_ok = &{1'b0, HSIZE, HBURST};

endmodule