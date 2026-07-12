//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_sequencer.sv
// Author  : Bharath
// Description : PCIe Sequencer
//--------------------------------------------------------------

`ifndef PCIE_SEQUENCER_SV
`define PCIE_SEQUENCER_SV

class pcie_sequencer extends uvm_sequencer #(pcie_transaction);

    // Factory Registration
    `uvm_component_utils(pcie_sequencer)

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_sequencer",
                 uvm_component parent);

        super.new(name, parent);

    endfunction

endclass

`endif
