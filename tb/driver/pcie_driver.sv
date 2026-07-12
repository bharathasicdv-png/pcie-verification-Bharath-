//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_driver.sv
// Author  : Bharath
// Description : PCIe Driver
//--------------------------------------------------------------

`ifndef PCIE_DRIVER_SV
`define PCIE_DRIVER_SV

class pcie_driver extends uvm_driver #(pcie_transaction);

    // Factory Registration
    `uvm_component_utils(pcie_driver)

    // Virtual Interface
    virtual pcie_if vif;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_driver",
                 uvm_component parent);

        super.new(name,parent);

    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db #(virtual pcie_if)::get(this,"","vif",vif))
            `uvm_fatal("DRV","Unable to get Virtual Interface")

    endfunction

    //----------------------------------------------------------
    // Run Phase
    //----------------------------------------------------------

    task run_phase(uvm_phase phase);

        forever begin

            seq_item_port.get_next_item(req);

            drive_transaction(req);

            seq_item_port.item_done();

        end

    endtask

    //----------------------------------------------------------
    // Drive Task
    //----------------------------------------------------------

    task drive_transaction(pcie_transaction tr);

        @(posedge vif.clk);

        vif.tx_valid <= 1'b1;
        vif.tx_data  <= tr.data;

        @(posedge vif.clk);

        vif.tx_valid <= 1'b0;

        `uvm_info(get_type_name(),
                  $sformatf("Driving Transaction : %s",
                  tr.convert2string()),
                  UVM_MEDIUM)

    endtask

endclass

`endif
