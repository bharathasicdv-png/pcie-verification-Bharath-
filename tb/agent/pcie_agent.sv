//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_agent.sv
//--------------------------------------------------------------

`ifndef PCIE_AGENT_SV
`define PCIE_AGENT_SV

class pcie_agent extends uvm_agent;

    `uvm_component_utils(pcie_agent)

    //----------------------------------------------------------
    // Configuration Object
    //----------------------------------------------------------

    pcie_agent_config cfg;

    //----------------------------------------------------------
    // Components
    //----------------------------------------------------------

    pcie_driver     driver;
    pcie_monitor    monitor;
    pcie_sequencer  sequencer;

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

        //----------------------------------------------
        // Get Configuration
        //----------------------------------------------

        if(!uvm_config_db #(pcie_agent_config)::get(
                this,
                "",
                "cfg",
                cfg))
        begin
            `uvm_fatal(get_type_name(),
                       "Unable to get Agent Config")
        end

        //----------------------------------------------
        // Always create Monitor
        //----------------------------------------------

        monitor = pcie_monitor::type_id::create(
                    "monitor",
                    this);

        //----------------------------------------------
        // Active Agent
        //----------------------------------------------

        if(cfg.is_active == UVM_ACTIVE) begin

            driver = pcie_driver::type_id::create(
                        "driver",
                        this);

            sequencer = pcie_sequencer::type_id::create(
                        "sequencer",
                        this);

        end

    endfunction

    //----------------------------------------------------------
    // Connect Phase
    //----------------------------------------------------------

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        if(cfg.is_active == UVM_ACTIVE) begin

            driver.seq_item_port.connect(
                sequencer.seq_item_export);

        end

    endfunction

endclass

`endif
