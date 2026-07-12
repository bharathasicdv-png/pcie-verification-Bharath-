//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_agent_config.sv
// Author  : Bharath
// Description : PCIe Agent Configuration
//--------------------------------------------------------------

`ifndef PCIE_AGENT_CONFIG_SV
`define PCIE_AGENT_CONFIG_SV

class pcie_agent_config extends uvm_object;

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_object_utils(pcie_agent_config)

    //----------------------------------------------------------
    // Agent Mode
    //----------------------------------------------------------

    uvm_active_passive_enum is_active = UVM_ACTIVE;

    //----------------------------------------------------------
    // Virtual Interface
    //----------------------------------------------------------

    virtual pcie_if vif;

    //----------------------------------------------------------
    // Feature Control
    //----------------------------------------------------------

    bit coverage_enable = 1;

    bit checks_enable = 1;

    //----------------------------------------------------------
    // Timeout
    //----------------------------------------------------------

    int unsigned timeout = 1000;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name = "pcie_agent_config");
        super.new(name);
    endfunction

endclass

`endif
