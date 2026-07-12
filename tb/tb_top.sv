//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : tb_top.sv
// Author  : Bharath
// Description : Top level Testbench
//--------------------------------------------------------------

`timescale 1ns/1ps

module tb_top;

    //----------------------------------------------------------
    // Import Packages
    //----------------------------------------------------------

    import uvm_pkg::*;
    import pcie_pkg::*;

    `include "uvm_macros.svh"

    //----------------------------------------------------------
    // Clock
    //----------------------------------------------------------

    logic clk;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //----------------------------------------------------------
    // Reset
    //----------------------------------------------------------

    initial begin
        p_if.rst_n = 0;
        repeat(5) @(posedge clk);
        p_if.rst_n = 1;
    end

    //----------------------------------------------------------
    // Interface
    //----------------------------------------------------------

    pcie_if p_if(clk);

    //----------------------------------------------------------
    // DUT
    //----------------------------------------------------------

    pcie_controller_top dut(

        .clk      (p_if.clk),
        .rst_n    (p_if.rst_n),

        .tx_valid (p_if.tx_valid),
        .tx_data  (p_if.tx_data),
        .tx_ready (p_if.tx_ready),

        .rx_valid (p_if.rx_valid),
        .rx_data  (p_if.rx_data),
        .rx_ready (p_if.rx_ready)

    );

    //----------------------------------------------------------
    // Start UVM
    //----------------------------------------------------------

    initial begin

        uvm_config_db #(virtual pcie_if)::set(
            null,
            "*",
            "vif",
            p_if
        );

        run_test("pcie_base_test");

    end

endmodule
