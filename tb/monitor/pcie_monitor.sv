//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_monitor.sv
// Author  : Bharath
// Description : PCIe Monitor
//--------------------------------------------------------------

`ifndef PCIE_MONITOR_SV
`define PCIE_MONITOR_SV

class pcie_monitor extends uvm_monitor;

    // Factory Registration
    `uvm_component_utils(pcie_monitor)

    //----------------------------------------------------------
    // Virtual Interface
    //----------------------------------------------------------

    virtual pcie_if vif;

    //----------------------------------------------------------
    // Analysis Port
    //----------------------------------------------------------

    uvm_analysis_port #(pcie_transaction) item_collected_port;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_monitor",
                 uvm_component parent);
        super.new(name, parent);
    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        // Create Analysis Port
        item_collected_port = new("item_collected_port", this);

        // Get Virtual Interface
        if(!uvm_config_db #(virtual pcie_if)::get(this,
                                                  "",
                                                  "vif",
                                                  vif))
        begin
            `uvm_fatal("MON", "Unable to get Virtual Interface")
        end

    endfunction

    //----------------------------------------------------------
    // Run Phase
    //----------------------------------------------------------

    task run_phase(uvm_phase phase);

        pcie_transaction tr;

        forever begin

            @(posedge vif.clk);

            if(vif.tx_valid) begin

                tr = pcie_transaction::type_id::create("tr", this);

                tr.data = vif.tx_data;

                `uvm_info(get_type_name(),
                          $sformatf("Captured Transaction : %s",
                          tr.convert2string()),
                          UVM_MEDIUM)

                // Send Transaction to Scoreboard/Coverage
                item_collected_port.write(tr);

            end

        end

    endtask

endclass

`endif
