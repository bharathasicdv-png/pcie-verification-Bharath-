
//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_if.sv
// Author  : Bharath
// Description : PCIe Verification Interface
//--------------------------------------------------------------

`ifndef PCIE_IF_SV
`define PCIE_IF_SV

interface pcie_if(input logic clk);

    //----------------------------------------------------------
    // Reset
    //----------------------------------------------------------

    logic rst_n;

    //----------------------------------------------------------
    // TX Channel
    //----------------------------------------------------------

    logic        tx_valid;
    logic [31:0] tx_data;
    logic        tx_ready;

    //----------------------------------------------------------
    // RX Channel
    //----------------------------------------------------------

    logic        rx_valid;
    logic [31:0] rx_data;
    logic        rx_ready;

endinterface

`endif
