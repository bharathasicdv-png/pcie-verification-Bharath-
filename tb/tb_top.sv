//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : tb_top.sv
// Author  : Bharath
// Description : Top Module
//--------------------------------------------------------------

`timescale 1ns/1ps

module tb_top;

    //----------------------------------------------------------
    // Import Package
    //----------------------------------------------------------

    import uvm_pkg::*;
    import pcie_pkg::*;

    `include "uvm_macros.svh"

    //----------------------------------------------------------
    // Clock
    //----------------------------------------------------------

    bit clk;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
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
        .tx_valid (p_if.tx_valid),
        .tx_data  (p_if.tx_data),
        .tx_ready (p_if.tx_ready)

    );

    //----------------------------------------------------------
    // UVM Configuration
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
