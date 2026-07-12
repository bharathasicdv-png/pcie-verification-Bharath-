//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_controller_top.sv
// Author  : Bharath
// Description : Dummy PCIe Controller (Loopback)
//--------------------------------------------------------------

`timescale 1ns/1ps

module pcie_controller_top(

    input  logic        clk,
    input  logic        rst_n,

    // TX Interface
    input  logic        tx_valid,
    input  logic [31:0] tx_data,
    output logic        tx_ready,

    // RX Interface
    output logic        rx_valid,
    output logic [31:0] rx_data,
    input  logic        rx_ready

);

    //----------------------------------------------------------
    // Always Ready
    //----------------------------------------------------------

    assign tx_ready = 1'b1;

    //----------------------------------------------------------
    // Simple Loopback Logic
    //----------------------------------------------------------

    always_ff @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            rx_valid <= 1'b0;
            rx_data  <= '0;

        end
        else begin

            if(tx_valid && tx_ready) begin

                rx_valid <= 1'b1;
                rx_data  <= tx_data;

            end
            else begin

                rx_valid <= 1'b0;

            end

        end

    end

endmodule
