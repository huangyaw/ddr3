 /*                                                                      
 Copyright 2017 Silicon Integrated Microelectronics, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
//--        _______   ___
//--       (   ____/ /__/
//--        \ \     __
//--     ____\ \   / /
//--    /_______\ /_/   MICROELECTRONICS
//--
//=====================================================================
//
// Designer   : Bob Hu
//
// Description:
//  The CPU-TOP module to implement CPU and SRAMs
//
// ====================================================================

`include "e203_defines.v"

module e203_cpu_top(

output axi_clk,
output axi_resetn,
output [3:0]s_axi_awid,
output [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_awaddr,
output [7:0]s_axi_awlen,
output [2:0]s_axi_awsize,
output [1:0]s_axi_awburst,
output s_axi_awlock,
output [3:0]s_axi_awcache,
output [2:0]s_axi_awprot,
output s_axi_awvalid,
input s_axi_awready,
output [31:0]s_axi_wdata,
output [3:0]s_axi_wstrb,
output s_axi_wlast,
output s_axi_wvalid,
input s_axi_wready,
input [3:0]s_axi_bid,
input [1:0]s_axi_bresp,
input s_axi_bvalid,
output s_axi_bready,
output [3:0]s_axi_arid,
output [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_araddr,
output [7:0]s_axi_arlen,
output [2:0]s_axi_arsize,
output [1:0]s_axi_arburst,
output s_axi_arlock,
output [3:0]s_axi_arcache,
output [2:0]s_axi_arprot,
output s_axi_arvalid,
input s_axi_arready,
input [3:0]s_axi_rid,
input [31:0]s_axi_rdata,
input [1:0]s_axi_rresp,
input s_axi_rlast,
input s_axi_rvalid,
output s_axi_rready,




  output [`E203_PC_SIZE-1:0] inspect_pc,
  output inspect_dbg_irq      ,
  output inspect_mem_cmd_valid,
  output inspect_mem_cmd_ready,
  output inspect_mem_rsp_valid,
  output inspect_mem_rsp_ready,
  output inspect_core_clk     ,

  output core_csr_clk         ,

    

    // If this signal is high, then indicate the Core have executed WFI instruction
    //   and entered into the sleep state
  output core_wfi,

    // This signal is from our self-defined COUNTERSTOP (0xBFF) CSR's TM field
    //   software can programe this CSR to turn off the MTIME timer to save power
    // If this signal is high, then the MTIME timer from CLINT module will stop counting
  output tm_stop,

    // This signal can be used to indicate the PC value for the core after reset
  input  [`E203_PC_SIZE-1:0] pc_rtvec,

  ///////////////////////////////////////
  // The interface to Debug Module: Begin
  //
    // The synced debug interrupt back to Debug module 
  output  dbg_irq_r,

    // The debug mode CSR registers control interface from/to Debug module
  output  [`E203_PC_SIZE-1:0] cmt_dpc,
  output  cmt_dpc_ena,
  output  [3-1:0] cmt_dcause,
  output  cmt_dcause_ena,
  output  wr_dcsr_ena    ,
  output  wr_dpc_ena     ,
  output  wr_dscratch_ena,
  output  [32-1:0] wr_csr_nxt    ,
  input  [32-1:0] dcsr_r    ,
  input  [`E203_PC_SIZE-1:0] dpc_r     ,
  input  [32-1:0] dscratch_r,

    // The debug mode control signals from Debug Module
  input  dbg_mode,
  input  dbg_halt_r,
  input  dbg_step_r,
  input  dbg_ebreakm_r,
  input  dbg_stopcycle,
  input  dbg_irq_a,
  // The interface to Debug Module: End


    // This signal can be used to indicate the HART ID for this core
  input  [`E203_HART_ID_W-1:0] core_mhartid,  

    // The External Interrupt signal from PLIC
  input  ext_irq_a,
    // The Software Interrupt signal from CLINT
  input  sft_irq_a,
    // The Timer Interrupt signal from CLINT
  input  tmr_irq_a,
  
  
    // The PMU control signal from PMU to control the TCM Shutdown
  input tcm_sd,
    // The PMU control signal from PMU to control the TCM Deep-Sleep
  input tcm_ds,
    
  `ifdef E203_HAS_ITCM_EXTITF //{
  //////////////////////////////////////////////////////////////
  // External interface (ICB) to access ITCM: Begin
  //    * Bus cmd channel
  input                          ext2itcm_icb_cmd_valid,
  output                         ext2itcm_icb_cmd_ready,
  input  [`E203_ITCM_ADDR_WIDTH-1:0]   ext2itcm_icb_cmd_addr, 
  input                          ext2itcm_icb_cmd_read, 
  input  [`E203_XLEN-1:0]        ext2itcm_icb_cmd_wdata,
  input  [`E203_XLEN/8-1:0]      ext2itcm_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  output                         ext2itcm_icb_rsp_valid,
  input                          ext2itcm_icb_rsp_ready,
  output                         ext2itcm_icb_rsp_err  ,
  output [`E203_XLEN-1:0]        ext2itcm_icb_rsp_rdata,
  // External interface (ICB) to access ITCM: End
  `endif//}

  `ifdef E203_HAS_DTCM_EXTITF //{
  //////////////////////////////////////////////////////////////
  // External interface (ICB) to access DTCM: Start
  //    * Bus cmd channel
  input                          ext2dtcm_icb_cmd_valid,
  output                         ext2dtcm_icb_cmd_ready,
  input  [`E203_DTCM_ADDR_WIDTH-1:0]   ext2dtcm_icb_cmd_addr, 
  input                          ext2dtcm_icb_cmd_read, 
  input  [`E203_XLEN-1:0]        ext2dtcm_icb_cmd_wdata,
  input  [`E203_XLEN/8-1:0]      ext2dtcm_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  output                         ext2dtcm_icb_rsp_valid,
  input                          ext2dtcm_icb_rsp_ready,
  output                         ext2dtcm_icb_rsp_err  ,
  output [`E203_XLEN-1:0]        ext2dtcm_icb_rsp_rdata,
  // External interface (ICB) to access DTCM: End
  `endif//}

  
  //////////////////////////////////////////////////////////////
  // The Private Peripheral Interface (ICB): Begin
  //
  //    * Bus cmd channel
  output                         ppi_icb_cmd_valid,
  input                          ppi_icb_cmd_ready,
  output [`E203_ADDR_SIZE-1:0]   ppi_icb_cmd_addr, 
  output                         ppi_icb_cmd_read, 
  output [`E203_XLEN-1:0]        ppi_icb_cmd_wdata,
  output [`E203_XLEN/8-1:0]      ppi_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  input                          ppi_icb_rsp_valid,
  output                         ppi_icb_rsp_ready,
  input                          ppi_icb_rsp_err  ,
  input  [`E203_XLEN-1:0]        ppi_icb_rsp_rdata,
  // The Private Peripheral Interface (ICB): End

  //////////////////////////////////////////////////////////////
  // The CLINT Interface (ICB): Begin
  output                         clint_icb_cmd_valid,
  input                          clint_icb_cmd_ready,
  output [`E203_ADDR_SIZE-1:0]   clint_icb_cmd_addr, 
  output                         clint_icb_cmd_read, 
  output [`E203_XLEN-1:0]        clint_icb_cmd_wdata,
  output [`E203_XLEN/8-1:0]      clint_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  input                          clint_icb_rsp_valid,
  output                         clint_icb_rsp_ready,
  input                          clint_icb_rsp_err  ,
  input  [`E203_XLEN-1:0]        clint_icb_rsp_rdata,
  // The CLINT Interface (ICB): End

  //////////////////////////////////////////////////////////////
  // The PLIC Interface (ICB): Begin
  output                         plic_icb_cmd_valid,
  input                          plic_icb_cmd_ready,
  output [`E203_ADDR_SIZE-1:0]   plic_icb_cmd_addr, 
  output                         plic_icb_cmd_read, 
  output [`E203_XLEN-1:0]        plic_icb_cmd_wdata,
  output [`E203_XLEN/8-1:0]      plic_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  input                          plic_icb_rsp_valid,
  output                         plic_icb_rsp_ready,
  input                          plic_icb_rsp_err  ,
  input  [`E203_XLEN-1:0]        plic_icb_rsp_rdata,
  // The PLIC Interface (ICB): End


  //////////////////////////////////////////////////////////////
  // The Fast IO Interface (ICB): Begin
  //
  //    * Bus cmd channel
  output                         fio_icb_cmd_valid,
  input                          fio_icb_cmd_ready,
  output [`E203_ADDR_SIZE-1:0]   fio_icb_cmd_addr, 
  output                         fio_icb_cmd_read, 
  output [`E203_XLEN-1:0]        fio_icb_cmd_wdata,
  output [`E203_XLEN/8-1:0]      fio_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  input                          fio_icb_rsp_valid,
  output                         fio_icb_rsp_ready,
  input                          fio_icb_rsp_err  ,
  input  [`E203_XLEN-1:0]        fio_icb_rsp_rdata,
  // The Fast IO Interface (ICB): End

  //////////////////////////////////////////////////////////////
  // The System Memory Interface (ICB): Begin
  //
  //    * Bus cmd channel
  output                         mem_icb_cmd_valid,
  input                          mem_icb_cmd_ready,
  output [`E203_ADDR_SIZE-1:0]   mem_icb_cmd_addr, 
  output                         mem_icb_cmd_read, 
  output [`E203_XLEN-1:0]        mem_icb_cmd_wdata,
  output [`E203_XLEN/8-1:0]      mem_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  input                          mem_icb_rsp_valid,
  output                         mem_icb_rsp_ready,
  input                          mem_icb_rsp_err  ,
  input  [`E203_XLEN-1:0]        mem_icb_rsp_rdata,
  // The System Memory Interface (ICB): End


  // The test mode signal
  input  test_mode,

  // The Clock
  input  clk,

  // The low-level active reset signal, treated as async
  input  rst_n
  );

  `ifdef E203_HAS_ITCM //{
  wire  itcm_ls;

  wire rst_itcm;

  wire                          itcm_ram_cs  ;
  wire                          itcm_ram_we  ;
  wire  [`E203_ITCM_RAM_AW-1:0] itcm_ram_addr;
  wire  [`E203_ITCM_RAM_MW-1:0] itcm_ram_wem ;
  wire  [`E203_ITCM_RAM_DW-1:0] itcm_ram_din ;
    `ifndef E203_HAS_LOCKSTEP//{
  wire  [`E203_ITCM_RAM_DW-1:0] itcm_ram_dout;
    `endif//}
  wire                          clk_itcm_ram ;
  `endif//}

  
  `ifdef E203_HAS_DTCM //{
  wire  dtcm_ls;

  wire rst_dtcm;
  wire                          dtcm_ram_cs  ;
  wire                          dtcm_ram_we  ;
  wire  [`E203_DTCM_RAM_AW-1:0] dtcm_ram_addr;
  wire  [`E203_DTCM_RAM_MW-1:0] dtcm_ram_wem ;
  wire  [`E203_DTCM_RAM_DW-1:0] dtcm_ram_din ;
    `ifndef E203_HAS_LOCKSTEP//{
  wire  [`E203_DTCM_RAM_DW-1:0] dtcm_ram_dout;
    `endif//}
  wire                          clk_dtcm_ram ;
  `endif//}


`ifndef E203_HAS_LOCKSTEP//{
  wire ppi_icb_rsp_excl_ok   ;
  wire fio_icb_rsp_excl_ok   ;
  wire plic_icb_rsp_excl_ok  ;
  wire clint_icb_rsp_excl_ok ;
  wire mem_icb_rsp_excl_ok   ;


    `ifdef E203_HAS_PPI
  wire ppi_icb_enable;
  wire [`E203_ADDR_SIZE-1:0] ppi_region_indic;
    `endif

    `ifdef E203_HAS_PLIC
  wire plic_icb_enable;
  wire [`E203_ADDR_SIZE-1:0] plic_region_indic;
    `endif

    `ifdef E203_HAS_CLINT
  wire clint_icb_enable;
  wire [`E203_ADDR_SIZE-1:0] clint_region_indic;
    `endif

    `ifdef E203_HAS_MEM_ITF
  wire mem_icb_enable;
    `endif

    `ifdef E203_HAS_FIO
  wire fio_icb_enable;
  wire [`E203_ADDR_SIZE-1:0] fio_region_indic;
    `endif

`endif//}

    assign ppi_icb_rsp_excl_ok   = 1'b0;
    assign fio_icb_rsp_excl_ok   = 1'b0;
    assign plic_icb_rsp_excl_ok  = 1'b0;
    assign clint_icb_rsp_excl_ok = 1'b0;
    assign mem_icb_rsp_excl_ok   = 1'b0;


    `ifdef E203_HAS_PPI
    assign ppi_icb_enable = 1'b1;
    assign ppi_region_indic = `E203_PPI_ADDR_BASE;
    `else
    assign ppi_icb_enable = 1'b0;
    `endif

    `ifdef E203_HAS_PLIC
    assign plic_icb_enable = 1'b1;
    assign plic_region_indic = `E203_PLIC_ADDR_BASE;
    `else
    assign plic_icb_enable = 1'b0;
    `endif

    `ifdef E203_HAS_CLINT
    assign clint_icb_enable = 1'b1;
    assign clint_region_indic = `E203_CLINT_ADDR_BASE;
    `else
    assign clint_icb_enable = 1'b0;
    `endif

    `ifdef E203_HAS_MEM_ITF
    assign mem_icb_enable = 1'b1;
    `else
    assign mem_icb_enable = 1'b0;
    `endif

    `ifdef E203_HAS_FIO
    assign fio_icb_enable = 1'b1;
    assign fio_region_indic = `E203_FIO_ADDR_BASE;
    `else
    assign fio_icb_enable = 1'b0;
    `endif

  e203_cpu #(.MASTER(1)) u_e203_cpu(
  .axi_clk(axi_clk),
  .axi_resetn(axi_resetn),
  .s_axi_awid(s_axi_awid),
  .s_axi_awaddr(s_axi_awaddr),
  .s_axi_awlen(s_axi_awlen),
  .s_axi_awsize(s_axi_awsize),
  .s_axi_awburst(s_axi_awburst),
  .s_axi_awlock(s_axi_awlock),
  .s_axi_awcache(s_axi_awcache),
  .s_axi_awprot(s_axi_awprot),
  .s_axi_awvalid(s_axi_awvalid),
  .s_axi_awready(s_axi_awready),
  .s_axi_wdata(s_axi_wdata),
  .s_axi_wstrb(s_axi_wstrb),
  .s_axi_wlast(s_axi_wlast),
  .s_axi_wvalid(s_axi_wvalid),
  .s_axi_wready(s_axi_wready),
  .s_axi_bid(s_axi_bid),
  .s_axi_bresp(s_axi_bresp),
  .s_axi_bvalid(s_axi_bvalid),
  .s_axi_bready(s_axi_bready),
  .s_axi_arid(s_axi_arid),
  .s_axi_araddr(s_axi_araddr),
  .s_axi_arlen(s_axi_arlen),
  .s_axi_arsize(s_axi_arsize),
  .s_axi_arburst(s_axi_arburst),
  .s_axi_arlock(s_axi_arlock),
  .s_axi_arcache(s_axi_arcache),
  .s_axi_arprot(s_axi_arprot),
  .s_axi_arvalid(s_axi_arvalid),
  .s_axi_arready(s_axi_arready),
  .s_axi_rid(s_axi_rid),
  .s_axi_rdata(s_axi_rdata),
  .s_axi_rresp(s_axi_rresp),
  .s_axi_rlast(s_axi_rlast),
  .s_axi_rvalid(s_axi_rvalid),
  .s_axi_rready(s_axi_rready),
  
  
    .inspect_pc               (inspect_pc), 
    .inspect_dbg_irq          (inspect_dbg_irq      ),
    .inspect_mem_cmd_valid    (inspect_mem_cmd_valid), 
    .inspect_mem_cmd_ready    (inspect_mem_cmd_ready), 
    .inspect_mem_rsp_valid    (inspect_mem_rsp_valid),
    .inspect_mem_rsp_ready    (inspect_mem_rsp_ready),
    .inspect_core_clk         (inspect_core_clk     ),


    .core_csr_clk          (core_csr_clk      ),


    .tm_stop (tm_stop),
    .pc_rtvec(pc_rtvec),
  `ifdef E203_HAS_ITCM //{
    .itcm_ls (itcm_ls),
  `endif//}
  `ifdef E203_HAS_DTCM //{
    .dtcm_ls (dtcm_ls),
  `endif//}
    .core_wfi        (core_wfi),
    .dbg_irq_r       (dbg_irq_r      ),

    .cmt_dpc         (cmt_dpc        ),
    .cmt_dpc_ena     (cmt_dpc_ena    ),
    .cmt_dcause      (cmt_dcause     ),
    .cmt_dcause_ena  (cmt_dcause_ena ),

    .wr_dcsr_ena     (wr_dcsr_ena    ),
    .wr_dpc_ena      (wr_dpc_ena     ),
    .wr_dscratch_ena (wr_dscratch_ena),


                                     
    .wr_csr_nxt      (wr_csr_nxt    ),
                                     
    .dcsr_r          (dcsr_r         ),
    .dpc_r           (dpc_r          ),
    .dscratch_r      (dscratch_r     ),

    .dbg_mode        (dbg_mode),
    .dbg_halt_r      (dbg_halt_r),
    .dbg_step_r      (dbg_step_r),
    .dbg_ebreakm_r   (dbg_ebreakm_r),
    .dbg_stopcycle   (dbg_stopcycle),

    .core_mhartid    (core_mhartid),  
    .dbg_irq_a       (dbg_irq_a),
    .ext_irq_a       (ext_irq_a),
    .sft_irq_a       (sft_irq_a),
    .tmr_irq_a       (tmr_irq_a),

  `ifdef E203_HAS_ITCM_EXTITF //{
    .ext2itcm_icb_cmd_valid  (ext2itcm_icb_cmd_valid),
    .ext2itcm_icb_cmd_ready  (ext2itcm_icb_cmd_ready),
    .ext2itcm_icb_cmd_addr   (ext2itcm_icb_cmd_addr ),
    .ext2itcm_icb_cmd_read   (ext2itcm_icb_cmd_read ),
    .ext2itcm_icb_cmd_wdata  (ext2itcm_icb_cmd_wdata),
    .ext2itcm_icb_cmd_wmask  (ext2itcm_icb_cmd_wmask),
    
    .ext2itcm_icb_rsp_valid  (ext2itcm_icb_rsp_valid),
    .ext2itcm_icb_rsp_ready  (ext2itcm_icb_rsp_ready),
    .ext2itcm_icb_rsp_err    (ext2itcm_icb_rsp_err  ),
    .ext2itcm_icb_rsp_rdata  (ext2itcm_icb_rsp_rdata),
  `endif//}

  `ifdef E203_HAS_DTCM_EXTITF //{
    .ext2dtcm_icb_cmd_valid  (ext2dtcm_icb_cmd_valid),
    .ext2dtcm_icb_cmd_ready  (ext2dtcm_icb_cmd_ready),
    .ext2dtcm_icb_cmd_addr   (ext2dtcm_icb_cmd_addr ),
    .ext2dtcm_icb_cmd_read   (ext2dtcm_icb_cmd_read ),
    .ext2dtcm_icb_cmd_wdata  (ext2dtcm_icb_cmd_wdata),
    .ext2dtcm_icb_cmd_wmask  (ext2dtcm_icb_cmd_wmask),
    
    .ext2dtcm_icb_rsp_valid  (ext2dtcm_icb_rsp_valid),
    .ext2dtcm_icb_rsp_ready  (ext2dtcm_icb_rsp_ready),
    .ext2dtcm_icb_rsp_err    (ext2dtcm_icb_rsp_err  ),
    .ext2dtcm_icb_rsp_rdata  (ext2dtcm_icb_rsp_rdata),
  `endif//}


    .ppi_region_indic      (ppi_region_indic),
    .ppi_icb_enable        (ppi_icb_enable),
    .ppi_icb_cmd_valid     (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready     (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr      (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_read      (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata     (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask     (ppi_icb_cmd_wmask),
    .ppi_icb_cmd_lock      (),
    .ppi_icb_cmd_excl      (),
    .ppi_icb_cmd_size      (),
    
    .ppi_icb_rsp_valid     (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready     (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err       (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_excl_ok   (ppi_icb_rsp_excl_ok  ),
    .ppi_icb_rsp_rdata     (ppi_icb_rsp_rdata),

    .clint_region_indic      (clint_region_indic),
    .clint_icb_enable        (clint_icb_enable),
    .clint_icb_cmd_valid     (clint_icb_cmd_valid),
    .clint_icb_cmd_ready     (clint_icb_cmd_ready),
    .clint_icb_cmd_addr      (clint_icb_cmd_addr ),
    .clint_icb_cmd_read      (clint_icb_cmd_read ),
    .clint_icb_cmd_wdata     (clint_icb_cmd_wdata),
    .clint_icb_cmd_wmask     (clint_icb_cmd_wmask),
    .clint_icb_cmd_lock      (),
    .clint_icb_cmd_excl      (),
    .clint_icb_cmd_size      (),
    
    .clint_icb_rsp_valid     (clint_icb_rsp_valid),
    .clint_icb_rsp_ready     (clint_icb_rsp_ready),
    .clint_icb_rsp_err       (clint_icb_rsp_err  ),
    .clint_icb_rsp_excl_ok   (clint_icb_rsp_excl_ok  ),
    .clint_icb_rsp_rdata     (clint_icb_rsp_rdata),

    .plic_region_indic      (plic_region_indic),
    .plic_icb_enable        (plic_icb_enable),
    .plic_icb_cmd_valid     (plic_icb_cmd_valid),
    .plic_icb_cmd_ready     (plic_icb_cmd_ready),
    .plic_icb_cmd_addr      (plic_icb_cmd_addr ),
    .plic_icb_cmd_read      (plic_icb_cmd_read ),
    .plic_icb_cmd_wdata     (plic_icb_cmd_wdata),
    .plic_icb_cmd_wmask     (plic_icb_cmd_wmask),
    .plic_icb_cmd_lock      (),
    .plic_icb_cmd_excl      (),
    .plic_icb_cmd_size      (),
    
    .plic_icb_rsp_valid     (plic_icb_rsp_valid),
    .plic_icb_rsp_ready     (plic_icb_rsp_ready),
    .plic_icb_rsp_err       (plic_icb_rsp_err  ),
    .plic_icb_rsp_excl_ok   (plic_icb_rsp_excl_ok  ),
    .plic_icb_rsp_rdata     (plic_icb_rsp_rdata),


  `ifdef E203_HAS_FIO //{
    .fio_icb_enable        (fio_icb_enable),
    .fio_region_indic      (fio_region_indic),
    .fio_icb_cmd_valid     (fio_icb_cmd_valid),
    .fio_icb_cmd_ready     (fio_icb_cmd_ready),
    .fio_icb_cmd_addr      (fio_icb_cmd_addr ),
    .fio_icb_cmd_read      (fio_icb_cmd_read ),
    .fio_icb_cmd_wdata     (fio_icb_cmd_wdata),
    .fio_icb_cmd_wmask     (fio_icb_cmd_wmask),
    .fio_icb_cmd_lock      (),
    .fio_icb_cmd_excl      (),
    .fio_icb_cmd_size      (),
    
    .fio_icb_rsp_valid     (fio_icb_rsp_valid),
    .fio_icb_rsp_ready     (fio_icb_rsp_ready),
    .fio_icb_rsp_err       (fio_icb_rsp_err  ),
    .fio_icb_rsp_excl_ok   (fio_icb_rsp_excl_ok  ),
    .fio_icb_rsp_rdata     (fio_icb_rsp_rdata),
  `endif//}

  `ifdef E203_HAS_MEM_ITF //{
    .mem_icb_enable     (mem_icb_enable),
    .mem_icb_cmd_valid  (mem_icb_cmd_valid),
    .mem_icb_cmd_ready  (mem_icb_cmd_ready),
    .mem_icb_cmd_addr   (mem_icb_cmd_addr ),
    .mem_icb_cmd_read   (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata  (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask  (mem_icb_cmd_wmask),
    .mem_icb_cmd_lock   (),
    .mem_icb_cmd_excl   (),
    .mem_icb_cmd_size   (),
    .mem_icb_cmd_burst  (),
    .mem_icb_cmd_beat   (),
    
    .mem_icb_rsp_valid  (mem_icb_rsp_valid),
    .mem_icb_rsp_ready  (mem_icb_rsp_ready),
    .mem_icb_rsp_err    (mem_icb_rsp_err  ),
    .mem_icb_rsp_excl_ok(mem_icb_rsp_excl_ok  ),
    .mem_icb_rsp_rdata  (mem_icb_rsp_rdata),
  `endif//}

  `ifdef E203_HAS_ITCM //{
    .itcm_ram_cs   (itcm_ram_cs  ),
    .itcm_ram_we   (itcm_ram_we  ),
    .itcm_ram_addr (itcm_ram_addr), 
    .itcm_ram_wem  (itcm_ram_wem ),
    .itcm_ram_din  (itcm_ram_din ),         
    .itcm_ram_dout (itcm_ram_dout),
    .clk_itcm_ram  (clk_itcm_ram ),  
    .rst_itcm(rst_itcm),
  `endif//}

  `ifdef E203_HAS_DTCM //{
    .dtcm_ram_cs   (dtcm_ram_cs  ),
    .dtcm_ram_we   (dtcm_ram_we  ),
    .dtcm_ram_addr (dtcm_ram_addr), 
    .dtcm_ram_wem  (dtcm_ram_wem ),
    .dtcm_ram_din  (dtcm_ram_din ),         
    .dtcm_ram_dout (dtcm_ram_dout),
    .clk_dtcm_ram  (clk_dtcm_ram ),  
    .rst_dtcm(rst_dtcm),
  `endif//}

    .test_mode     (test_mode), 
  `ifndef E203_HAS_LOCKSTEP//{
  `endif//}
    .rst_n         (rst_n),
    .clk           (clk  ) 

  );

  e203_srams u_e203_srams(
  `ifdef E203_HAS_DTCM //{
   .dtcm_ram_sd (tcm_sd),
   .dtcm_ram_ds (tcm_ds),
   .dtcm_ram_ls (dtcm_ls),

   .dtcm_ram_cs   (dtcm_ram_cs  ),
   .dtcm_ram_we   (dtcm_ram_we  ),
   .dtcm_ram_addr (dtcm_ram_addr), 
   .dtcm_ram_wem  (dtcm_ram_wem ),
   .dtcm_ram_din  (dtcm_ram_din ),         
   .dtcm_ram_dout (dtcm_ram_dout),
   .clk_dtcm_ram  (clk_dtcm_ram ),  
   .rst_dtcm(rst_dtcm),
  `endif//}

  `ifdef E203_HAS_ITCM //{
   .itcm_ram_sd (tcm_sd),
   .itcm_ram_ds (tcm_ds),
   .itcm_ram_ls (itcm_ls),

   .itcm_ram_cs   (itcm_ram_cs  ),
   .itcm_ram_we   (itcm_ram_we  ),
   .itcm_ram_addr (itcm_ram_addr), 
   .itcm_ram_wem  (itcm_ram_wem ),
   .itcm_ram_din  (itcm_ram_din ),         
   .itcm_ram_dout (itcm_ram_dout),
   .clk_itcm_ram  (clk_itcm_ram ),  
   .rst_itcm(rst_itcm),
  `endif//}
   .test_mode (test_mode) 
  );

  


endmodule
