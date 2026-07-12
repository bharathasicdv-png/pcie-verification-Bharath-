#############################################################
# PCIe Verification Project
# Author : Bharath
#############################################################

SIM = questa

WORK = work

all: compile sim

#############################################################
# Create Work Library
#############################################################

compile:
	vlib $(WORK)
	vmap work $(WORK)

	vlog +acc \
	+incdir+./tb/pkg \
	+incdir+./tb/interface \
	+incdir+./tb/config \
	+incdir+./tb/seq_item \
	+incdir+./tb/sequences \
	+incdir+./tb/sequencer \
	+incdir+./tb/driver \
	+incdir+./tb/monitor \
	+incdir+./tb/agent \
	+incdir+./tb/scoreboard \
	+incdir+./tb/env \
	+incdir+./tb/tests \
	./tb/pkg/pcie_pkg.sv \
	./tb/interface/pcie_if.sv \
	./rtl/top/pcie_controller_top.sv \
	./tb/tb_top.sv

#############################################################
# Simulation
#############################################################

sim:
	vsim -c tb_top -do "run -all; quit"

#############################################################
# GUI Mode
#############################################################

wave:
	vsim tb_top

#############################################################
# Clean
#############################################################

clean:
	rm -rf work transcript vsim.wlf
