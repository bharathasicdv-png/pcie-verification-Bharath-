//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_agent.sv
// Author  : Bharath
// Description : PCIe UVM Agent
//--------------------------------------------------------------

`ifndef PCIE_AGENT_SV
`define PCIE_AGENT_SV

class pcie_agent extends uvm_agent;

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_component_utils(pcie_agent)

    //----------------------------------------------------------
    // Components
    //----------------------------------------------------------

    pcie_sequencer sequencer;
    pcie_driver    driver;
    pcie_monitor   monitor;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name="pcie_agent",
                 uvm_component parent);

        super.new(name,parent);

    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        sequencer = pcie_sequencer::type_id::create(
                        "sequencer", this);

        driver = pcie_driver::type_id::create(
                        "driver", this);

        monitor = pcie_monitor::type_id::create(
                        "monitor", this);

    endfunction

    //----------------------------------------------------------
    // Connect Phase
    //----------------------------------------------------------

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        driver.seq_item_port.connect(
            sequencer.seq_item_export);

    endfunction

endclass

`endif
