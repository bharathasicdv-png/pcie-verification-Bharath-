//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_base_sequence.sv
// Author  : Bharath
// Description : Base Sequence for PCIe Verification
//--------------------------------------------------------------

`ifndef PCIE_BASE_SEQUENCE_SV
`define PCIE_BASE_SEQUENCE_SV

class pcie_base_sequence extends uvm_sequence #(pcie_transaction);

    // Register sequence with UVM Factory
    `uvm_object_utils(pcie_base_sequence)

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_base_sequence");
        super.new(name);
    endfunction

    //----------------------------------------------------------
    // Sequence Body
    //----------------------------------------------------------

    virtual task body();

        pcie_transaction tr;

        `uvm_info(get_type_name(),
                  "Starting PCIe Base Sequence",
                  UVM_MEDIUM)

        // Create Transaction
        tr = pcie_transaction::type_id::create("tr");

        // Start Item
        start_item(tr);

        // Randomize Transaction
        if(!tr.randomize()) begin
            `uvm_fatal(get_type_name(),
                       "Transaction Randomization Failed")
        end

        // Print Transaction
        tr.print();

        // Finish Item
        finish_item(tr);

        `uvm_info(get_type_name(),
                  "Completed PCIe Base Sequence",
                  UVM_MEDIUM)

    endtask

endclass

`endif
