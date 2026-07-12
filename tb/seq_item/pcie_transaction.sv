//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_transaction.sv
// Author  : Bharath
// Description : PCIe Transaction Class
//--------------------------------------------------------------

`ifndef PCIE_TRANSACTION_SV
`define PCIE_TRANSACTION_SV

class pcie_transaction extends uvm_sequence_item;

    //----------------------------------------------------------
    // Transaction Fields
    //----------------------------------------------------------

    rand bit [31:0] address;
    rand bit [31:0] data;

    rand bit        read;
    rand bit        write;

    //----------------------------------------------------------
    // Constraints
    //----------------------------------------------------------

    // Read and Write cannot be asserted together
    constraint rw_c {
        !(read && write);
    }

    // At least one operation should be selected
    constraint valid_op_c {
        read || write;
    }

    // Address should be 4-byte aligned
    constraint addr_align_c {
        address[1:0] == 2'b00;
    }

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_object_utils_begin(pcie_transaction)

        `uvm_field_int(address, UVM_ALL_ON)
        `uvm_field_int(data,    UVM_ALL_ON)
        `uvm_field_int(read,    UVM_ALL_ON)
        `uvm_field_int(write,   UVM_ALL_ON)

    `uvm_object_utils_end

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_transaction");
        super.new(name);
    endfunction

    //----------------------------------------------------------
    // Convert to String
    //----------------------------------------------------------

    function string convert2string();

        return $sformatf(
            "ADDR = 0x%08h DATA = 0x%08h READ = %0d WRITE = %0d",
            address,
            data,
            read,
            write
        );

    endfunction

endclass

`endif
