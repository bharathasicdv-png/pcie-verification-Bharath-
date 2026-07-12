//---------------------------------------------------------
// Project : PCIe Verification Project
// File    : tb_top.sv
//---------------------------------------------------------

`timescale 1ns/1ps

module tb_top;

    //-----------------------------------------------------
    // Interface Instance
    //-----------------------------------------------------

    pcie_if pcie_if_inst();

    //-----------------------------------------------------
    // DUT Instance
    //-----------------------------------------------------

    pcie_controller_top dut
    (
        .clk   (pcie_if_inst.clk),
        .rst_n (pcie_if_inst.rst_n)
    );

    //-----------------------------------------------------
    // Clock Generation
    //-----------------------------------------------------

    initial begin
        pcie_if_inst.clk = 0;
        forever #5 pcie_if_inst.clk = ~pcie_if_inst.clk;
    end

    //-----------------------------------------------------
    // Reset Generation
    //-----------------------------------------------------

    initial begin
        pcie_if_inst.rst_n = 0;
        #50;
        pcie_if_inst.rst_n = 1;
    end

endmodule
