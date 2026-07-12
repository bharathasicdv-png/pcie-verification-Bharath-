//------------------------------------------------------------
// File : pcie_base_sequence.sv
// Description : Base PCIe Sequence
//------------------------------------------------------------

class pcie_base_sequence extends uvm_sequence #(pcie_transaction);

    // Register with Factory
    `uvm_object_utils(pcie_base_sequence)

    //--------------------------------------------------------
    // Constructor
    //--------------------------------------------------------

    function new(string name = "pcie_base_sequence");
        super.new(name);
    endfunction

    //--------------------------------------------------------
    // Main Sequence
    //--------------------------------------------------------

    virtual task body();

        pcie_transaction tr;

        // Create Transaction
        tr = pcie_transaction::type_id::create("tr");

        // Start Transaction
        start_item(tr);

        // Randomize Transaction
        if(!tr.randomize())
            `uvm_error("SEQ", "Randomization Failed")

        // Print Transaction
        tr.print();

        // Finish Transaction
        finish_item(tr);

    endtask

endclass
