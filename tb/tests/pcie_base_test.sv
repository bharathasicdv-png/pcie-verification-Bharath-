//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_base_test.sv
// Author  : Bharath
// Description : PCIe Base Test
//--------------------------------------------------------------

`ifndef PCIE_BASE_TEST_SV
`define PCIE_BASE_TEST_SV

class pcie_base_test extends uvm_test;

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_component_utils(pcie_base_test)

    //----------------------------------------------------------
    // Environment
    //----------------------------------------------------------

    pcie_env env;

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
