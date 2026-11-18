`timescale 1ns / 1ps

module AHB_slave(
    input  wire        clk,          // CHANGED: Now runs on fast base clock
    input  wire        hrstn, hwrite, hreadyin,
    input  wire [1:0]  htrans,
    input  wire [31:0] haddr, hwdata,
    input  wire [31:0] prdata,       
    input  wire [31:0] prdata_latched,
    // Output control signals to APB Controller (Reduced pipelining needed)
    output reg  [31:0] haddr1, hwdata1,
    output reg  [2:0]  tempselx,
    output reg         valid, hwritereg,
    
    // New CDC Handshake Ports
    output reg         ahb_req,      // Tells APB domain that data/addr is ready
    input  wire        ahb_ack,      // Synchronized ACK from APB domain
    
    // AHB Master outputs
    output wire [1:0]  hresp,
    output reg         hreadyout,    // Controlled by FSM to stall AHB bus
    output wire [31:0] hrdata
);

    // FSM States
    localparam IDLE       = 2'b00;
    localparam WAIT_DATA  = 2'b01;
    localparam WAIT_ACK_H = 2'b10;
    localparam WAIT_ACK_L = 2'b11;

    reg [1:0] state;

    // Peripheral select logic
    always @(*) begin
        tempselx = 3'b000;
        if(haddr >= 32'h8000_0000 && haddr < 32'h8400_0000)
            tempselx = 3'b001;
        else if(haddr >= 32'h8400_0000 && haddr < 32'h8800_0000)
            tempselx = 3'b010;
        else if(haddr >= 32'h8800_0000 && haddr < 32'h8c00_0000)
            tempselx = 3'b100;
    end

    // Valid transaction detection for Address Phase
    always @(*) begin
        valid = 1'b0;
        if((haddr >= 32'h8000_0000 && haddr < 32'h8c00_0000) && 
           (hreadyin == 1'b1) && 
           (htrans == 2'b10 || htrans == 2'b11)) // NONSEQ or SEQ
            valid = 1'b1;
    end  

    // CDC FSM & Data Latching
    always @(posedge clk or negedge hrstn) begin
        if (!hrstn) begin
            state      <= IDLE;
            haddr1     <= 32'h0;
            hwdata1    <= 32'h0;
            hwritereg  <= 1'b0;
            ahb_req    <= 1'b0;
            hreadyout  <= 1'b1; // Default to ready
        end else begin
            case (state)
                IDLE: begin
                    if (valid) begin
                        // AHB Address Phase: Latch Address and Control
                        haddr1    <= haddr;
                        hwritereg <= hwrite;
                        hreadyout <= 1'b0;       // Pull low to stall AHB for the upcoming Data Phase
                        state     <= WAIT_DATA;
                    end else begin
                        hreadyout <= 1'b1;
                    end
                end

                WAIT_DATA: begin
                    // AHB Data Phase: Latch Write Data and Send Request to APB
                    if (hwritereg) hwdata1 <= hwdata; 
                    ahb_req <= 1'b1;             // Trigger transfer in APB domain
                    state   <= WAIT_ACK_H;
                end

                WAIT_ACK_H: begin
                    // Wait for APB to complete transfer and assert ACK
                    if (ahb_ack == 1'b1) begin
                        ahb_req   <= 1'b0;
                        hreadyout <= 1'b1;       // Data is read/written; release AHB Master stall
                        state     <= WAIT_ACK_L;
                    end
                end

                WAIT_ACK_L: begin
                    // Handshake recovery: wait for APB to drop ACK before accepting a new transfer
                    if (ahb_ack == 1'b0) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    assign hresp  = 2'b00; // OKAY response
    assign hrdata = prdata_latched; // Read data routes directly (latched by master when hreadyout goes high)

endmodule