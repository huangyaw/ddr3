set_property SRC_FILE_INFO {cfile:F:/software/xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:F:/software/xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:1 order:LATE scoped_inst:U0/gint_inst.xpm_tdpram_mem_gen.xpm_memory_inst unmanaged:yes} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:3 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -hier  -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
