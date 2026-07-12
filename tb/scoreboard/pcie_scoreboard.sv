//--------------------------------------------------------------
// Project : PCIe Verification Project
// File    : pcie_scoreboard.sv
// Author  : Bharath
// Description : PCIe Scoreboard
//--------------------------------------------------------------

`ifndef PCIE_SCOREBOARD_SV
`define PCIE_SCOREBOARD_SV

class pcie_scoreboard extends uvm_scoreboard;

    //----------------------------------------------------------
    // Factory Registration
    //----------------------------------------------------------

    `uvm_component_utils(pcie_scoreboard)

    //----------------------------------------------------------
    // Analysis Implementation
    //----------------------------------------------------------

    uvm_analysis_imp #(pcie_transaction,
                       pcie_scoreboard) analysis_export;

    //----------------------------------------------------------
    // Constructor
    //----------------------------------------------------------

    function new(string name="pcie_scoreboard",
                 uvm_component parent);

        super.new(name,parent);

    endfunction

    //----------------------------------------------------------
    // Build Phase
    //----------------------------------------------------------

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        analysis_export =
            new("analysis_export", this);

    endfunction

    //----------------------------------------------------------
    // Write Method
    //----------------------------------------------------------

    function void write(pcie_transaction tr);

        `uvm_info(get_type_name(),
                  $sformatf("Received Transaction : %s",
                  tr.convert2string()),
                  UVM_MEDIUM)

        //---------------------------------------------
        // Simple Check
        //---------------------------------------------

        if(tr.read && tr.write) begin

            `uvm_error(get_type_name(),
                       "Invalid Transaction")

        end
        else begin

            `uvm_info(get_type_name(),
                      "Transaction PASSED",
                      UVM_LOW)

        end

    endfunction

endclass

`endif
