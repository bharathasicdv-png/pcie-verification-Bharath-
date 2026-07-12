//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_env.sv
// Author  : Bharath
// Description : PCIe UVM Environment
//--------------------------------------------------------------

`ifndef PCIE_ENV_SV
`define PCIE_ENV_SV

class pcie_env extends uvm_env;

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_component_utils(pcie_env)

    //----------------------------------------------------------
    // Components
    //----------------------------------------------------------

    pcie_agent      agent;
    pcie_scoreboard scoreboard;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name="pcie_env",
                 uvm_component parent);

        super.new(name,parent);

    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        agent = pcie_agent::type_id::create(
                    "agent",
                    this);

        scoreboard = pcie_scoreboard::type_id::create(
                        "scoreboard",
                        this);

    endfunction

    //----------------------------------------------------------
    // Connect Phase
    //----------------------------------------------------------

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        agent.monitor.item_collected_port.connect(
            scoreboard.analysis_export);

    endfunction

endclass

`endif
