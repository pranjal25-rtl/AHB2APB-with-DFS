
module APB_controller (
    input  wire        clk,
    input  wire        hrstn,

    // CDC handshake
    input  wire        apb_req,
    output reg         apb_ack,

    // Stable transaction inputs from AHB domain
    input  wire [31:0] haddr1,
    input  wire [31:0] hwdata1,
    input  wire        hwritereg,
    input  wire [2:0]  tempselx,

    // APB peripheral inputs
    input  wire [31:0] prdata,
    input  wire        pready,

    // Latched read data
    output reg  [31:0] prdata_latched,

    // APB master outputs
    output reg         pwrite,
    output reg         penable,
    output reg  [2:0]  pselx,
    output reg  [31:0] pwdata,
    output reg  [31:0] paddr
);

    localparam IDLE          = 3'd0;
    localparam SETUP         = 3'd1;
    localparam ENABLE        = 3'd2;
    localparam WAIT_REQ_FALL = 3'd3;

    reg [2:0] state;

    always @(posedge clk or negedge hrstn) begin
        if (!hrstn) begin
            state          <= IDLE;
            apb_ack        <= 1'b0;
            penable        <= 1'b0;
            pselx          <= 3'b000;
            pwrite         <= 1'b0;
            paddr          <= 32'b0;
            pwdata         <= 32'b0;
            prdata_latched <= 32'b0;
        end else begin
            case (state)

                IDLE: begin
                    penable <= 1'b0;
                    pselx   <= 3'b000;
                    apb_ack <= 1'b0;

                    if (apb_req) begin
                        paddr  <= haddr1;
                        pwrite <= hwritereg;
                        pwdata <= hwdata1;
                        pselx  <= tempselx;
                        state  <= SETUP;
                    end
                end

                SETUP: begin
                    // PSEL is already asserted; PENABLE remains low
                    penable <= 1'b0;
                    state   <= ENABLE;
                end

                ENABLE: begin
                    penable <= 1'b1;

                    // Hold PSEL, PENABLE, address and control
                    // stable until the peripheral is ready.
                    if (pready) begin
                        if (!pwrite)
                            prdata_latched <= prdata;

                        penable <= 1'b0;
                        pselx   <= 3'b000;
                        apb_ack <= 1'b1;
                        state   <= WAIT_REQ_FALL;
                    end
                end

                WAIT_REQ_FALL: begin
                    penable <= 1'b0;
                    pselx   <= 3'b000;

                    if (!apb_req) begin
                        apb_ack <= 1'b0;
                        state   <= IDLE;
                    end
                end

                default: begin
                    state   <= IDLE;
                    apb_ack <= 1'b0;
                    penable <= 1'b0;
                    pselx   <= 3'b000;
                end

            endcase
        end
    end

endmodule
