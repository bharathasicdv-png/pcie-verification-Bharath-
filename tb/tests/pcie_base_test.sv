//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_base_test.sv
//--------------------------------------------------------------

`ifndef PCIE_BASE_TEST_SV
`define PCIE_BASE_TEST_SV

class pcie_base_test extends uvm_test;

    `uvm_component_utils(pcie_base_test)

    //----------------------------------------------------------
    // Environment
    //----------------------------------------------------------

    pcie_env env;

    //----------------------------------------------------------
    // Agent Configuration
    //----------------------------------------------------------

    pcie_agent_config agent_cfg;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name="pcie_base_test",
                 uvm_component parent);
        super.new(name,parent);
    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        //------------------------------------------
        // Create Configuration
        //------------------------------------------

        agent_cfg = pcie_agent_config::type_id::create("agent_cfg");

        //------------------------------------------
        // Default Configuration
        //------------------------------------------

        agent_cfg.is_active       = UVM_ACTIVE;
        agent_cfg.coverage_enable = 1;
        agent_cfg.checks_enable   = 1;
        agent_cfg.timeout         = 1000;

        //------------------------------------------
        // Get Virtual Interface
        //------------------------------------------

        if(!uvm_config_db #(virtual pcie_if)::get(
                this,
                "",
                "vif",
                agent_cfg.vif))
        begin
            `uvm_fatal("TEST","Virtual Interface not found")
        end

        //------------------------------------------
        // Pass Configuration to Agent
        //------------------------------------------

        uvm_config_db #(pcie_agent_config)::set(
                this,
                "env.agent",
                "cfg",
                agent_cfg);

        //------------------------------------------
        // Create Environment
        //------------------------------------------

        env = pcie_env::type_id::create("env", this);

    endfunction

    //----------------------------------------------------------
    // End of Elaboration
    //----------------------------------------------------------

    function void end_of_elaboration_phase(uvm_phase phase);

        super.end_of_elaboration_phase(phase);

        uvm_top.print_topology();

    endfunction

endclass

`endif
