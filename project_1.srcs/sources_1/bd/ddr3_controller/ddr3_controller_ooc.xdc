################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name S00_ACLK_0 -period 50 [get_ports S00_ACLK_0]
create_clock -name sys_clk_i_0 -period 10 [get_ports sys_clk_i_0]

################################################################################