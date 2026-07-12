//------------------------------------------------------------
// File : pcie_transaction.sv
// Description : PCIe Transaction Class
//------------------------------------------------------------

class pcie_transaction extends uvm_sequence_item;

    // Transaction Fields

    rand bit [31:0] address;
    rand bit [31:0] data;

    rand bit        write;
    rand bit        read;

    // Constructor

    function new(string name = "pcie_transaction");
        super.new(name);
    endfunction

    // Register with Factory

    `uvm_object_utils(pcie_transaction)

endclass
