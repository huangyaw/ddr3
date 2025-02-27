# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tftg256-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/nikihuang/Documents/lab/project/project_1.cache/wt [current_project]
set_property parent.project_path /home/nikihuang/Documents/lab/project/project_1.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/nikihuang/Documents/lab/project/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog {
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/config.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_defines.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/i2c_master_defines.v
}
set_property file_type "Verilog Header" [get_files /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/config.v]
set_property file_type "Verilog Header" [get_files /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_defines.v]
set_property file_type "Verilog Header" [get_files /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/i2c_master_defines.v]
read_verilog -library xil_defaultlib {
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/new/axi_wrapper.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/src/clkdivider.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_biu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_clk_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_clkgate.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_core.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_cpu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_cpu_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_dtcm_ram.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_extend_csr.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_bjp.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_csrctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_dpath.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_lsuagu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_muldiv.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_alu_rglr.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_branchslv.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_commit.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_csr.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_decode.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_disp.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_excp.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_longpwbck.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_oitf.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_regfile.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_exu_wbck.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_ifu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_ifu_ifetch.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_ifu_ift2icb.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_ifu_litebpu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_ifu_minidec.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_irq_sync.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_itcm_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_itcm_ram.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_lsu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_lsu_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_reset_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/soc/e203_soc_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/core/e203_srams.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_clint.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_gfcm.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_hclkgen.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_hclkgen_rstsync.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_main.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_mems.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_perips.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_plic.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_pll.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_pllclkdiv.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/subsys/e203_subsys_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/i2c_master_bit_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/i2c_master_byte_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/i2c_master_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/new/lab3_ddr_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_1cyc_sram_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetReg.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetRegVec.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetRegVec_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetRegVec_129.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetRegVec_36.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_AsyncResetRegVec_67.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_DeglitchShiftRegister.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_LevelGateway.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_ResetCatchAndSync.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_ResetCatchAndSync_2.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_aon.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_aon_lclkgen_regs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_aon_porrst.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_aon_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_aon_wrapper.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_clint.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_clint_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/debug/sirv_debug_csr.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/debug/sirv_debug_module.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/debug/sirv_debug_ram.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/debug/sirv_debug_rom.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_expl_apb_slv.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_expl_axi_slv.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_flash_qspi.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_flash_qspi_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_gnrl_bufs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_gnrl_dffs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_gnrl_icbs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_gnrl_ram.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_gpio.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_gpio_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_hclkgen_regs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/fab/sirv_icb1to16_bus.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/fab/sirv_icb1to2_bus.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/fab/sirv_icb1to8_bus.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/debug/sirv_jtag_dtm.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_jtaggpioport.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/mems/sirv_mrom.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/mems/sirv_mrom_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_otp_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_plic_man.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_plic_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pmu.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pmu_core.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm16.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm16_core.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm16_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm8.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm8_core.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwm8_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_pwmgpioport.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_1cs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_1cs_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_4cs.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_4cs_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_arbiter.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_fifo.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_media.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_media_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_media_2.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_physical.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_physical_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_qspi_physical_2.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_queue.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_queue_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_repeater_6.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_rtc.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_sim_ram.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_spi_flashmap.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_spigpioport.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_spigpioport_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_spigpioport_2.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/general/sirv_sram_icb_ctrl.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_tl_repeater_5.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_tlfragmenter_qspi_1.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_tlwidthwidget_qspi.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_uart.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_uart_top.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_uartgpioport.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_uartrx.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_uarttx.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/perips/sirv_wdog.v
  /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/imports/rtl/system.v
}
read_ip -quiet /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/reset_sys_1/reset_sys.xci
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/reset_sys_1/reset_sys_board.xdc]
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/reset_sys_1/reset_sys.xdc]
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/reset_sys_1/reset_sys_ooc.xdc]

read_ip -quiet /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/mmcm_1/mmcm.xci
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/mmcm_1/mmcm_board.xdc]
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/mmcm_1/mmcm.xdc]
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/mmcm_1/mmcm_ooc.xdc]

read_ip -quiet /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/axi_bram_ctrl_0/axi_bram_ctrl_0.xci
set_property used_in_implementation false [get_files -all /home/nikihuang/Documents/lab/project/project_1.srcs/sources_1/ip/axi_bram_ctrl_0/axi_bram_ctrl_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/nikihuang/Documents/lab/project/project_1.srcs/constrs_1/new/e203_0408.xdc
set_property used_in_implementation false [get_files /home/nikihuang/Documents/lab/project/project_1.srcs/constrs_1/new/e203_0408.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top system -part xc7a35tftg256-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef system.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file system_utilization_synth.rpt -pb system_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
