`timescale 1ns/1ps

import "DPI-C" function void simv_init();
import "DPI-C" function int simv_step();

module tb_top;

  reg           clock;
  reg           reset;

  wire          s_dma_aw_ready;
  wire          s_dma_aw_valid;
  wire  [13:0]  s_dma_aw_id;
  wire  [35:0]  s_dma_aw_addr;
  wire  [7:0]   s_dma_aw_len;
  wire  [2:0]   s_dma_aw_size;
  wire  [1:0]   s_dma_aw_burst;
  wire          s_dma_aw_lock;
  wire  [3:0]   s_dma_aw_cache;
  wire  [2:0]   s_dma_aw_prot;
  wire  [3:0]   s_dma_aw_qos;
  wire          s_dma_w_ready;
  wire          s_dma_w_valid;
  wire  [255:0] s_dma_w_data;
  wire  [31:0]  s_dma_w_strb;
  wire          s_dma_w_last;
  wire          s_dma_b_ready;
  wire          s_dma_b_valid;
  wire  [13:0]  s_dma_b_id;
  wire  [1:0]   s_dma_b_resp;
  wire          s_dma_ar_ready;
  wire          s_dma_ar_valid;
  wire  [13:0]  s_dma_ar_id;
  wire  [35:0]  s_dma_ar_addr;
  wire  [7:0]   s_dma_ar_len;
  wire  [2:0]   s_dma_ar_size;
  wire  [1:0]   s_dma_ar_burst;
  wire          s_dma_ar_lock;
  wire  [3:0]   s_dma_ar_cache;
  wire  [2:0]   s_dma_ar_prot;
  wire  [3:0]   s_dma_ar_qos;
  wire          s_dma_r_ready;
  wire          s_dma_r_valid;
  wire  [13:0]  s_dma_r_id;
  wire  [255:0] s_dma_r_data;
  wire  [1:0]   s_dma_r_resp;
  wire          s_dma_r_last;
  wire          m_peripheral_aw_ready;
  wire          m_peripheral_aw_valid;
  wire  [1:0]   m_peripheral_aw_id;
  wire  [30:0]  m_peripheral_aw_addr;
  wire  [7:0]   m_peripheral_aw_len;
  wire  [2:0]   m_peripheral_aw_size;
  wire  [1:0]   m_peripheral_aw_burst;
  wire          m_peripheral_aw_lock;
  wire  [3:0]   m_peripheral_aw_cache;
  wire  [2:0]   m_peripheral_aw_prot;
  wire  [3:0]   m_peripheral_aw_qos;
  wire          m_peripheral_w_ready;
  wire          m_peripheral_w_valid;
  wire  [63:0]  m_peripheral_w_data;
  wire  [7:0]   m_peripheral_w_strb;
  wire          m_peripheral_w_last;
  wire          m_peripheral_b_ready;
  wire          m_peripheral_b_valid;
  wire  [1:0]   m_peripheral_b_id;
  wire  [1:0]   m_peripheral_b_resp;
  wire          m_peripheral_ar_ready;
  wire          m_peripheral_ar_valid;
  wire  [1:0]   m_peripheral_ar_id;
  wire  [30:0]  m_peripheral_ar_addr;
  wire  [7:0]   m_peripheral_ar_len;
  wire  [2:0]   m_peripheral_ar_size;
  wire  [1:0]   m_peripheral_ar_burst;
  wire          m_peripheral_ar_lock;
  wire  [3:0]   m_peripheral_ar_cache;
  wire  [2:0]   m_peripheral_ar_prot;
  wire  [3:0]   m_peripheral_ar_qos;
  wire          m_peripheral_r_ready;
  wire          m_peripheral_r_valid;
  wire  [1:0]   m_peripheral_r_id;
  wire  [63:0]  m_peripheral_r_data;
  wire  [1:0]   m_peripheral_r_resp;
  wire          m_peripheral_r_last;
  wire          m_memory_aw_ready;
  wire          m_memory_aw_valid;
  wire  [13:0]  m_memory_aw_id;
  wire  [35:0]  m_memory_aw_addr;
  wire  [7:0]   m_memory_aw_len;
  wire  [2:0]   m_memory_aw_size;
  wire  [1:0]   m_memory_aw_burst;
  wire          m_memory_aw_lock;
  wire  [3:0]   m_memory_aw_cache;
  wire  [2:0]   m_memory_aw_prot;
  wire  [3:0]   m_memory_aw_qos;
  wire          m_memory_w_ready;
  wire          m_memory_w_valid;
  wire  [255:0] m_memory_w_data;
  wire  [31:0]  m_memory_w_strb;
  wire          m_memory_w_last;
  wire          m_memory_b_ready;
  wire          m_memory_b_valid;
  wire  [13:0]  m_memory_b_id;
  wire  [1:0]   m_memory_b_resp;
  wire          m_memory_ar_ready;
  wire          m_memory_ar_valid;
  wire  [13:0]  m_memory_ar_id;
  wire  [35:0]  m_memory_ar_addr;
  wire  [7:0]   m_memory_ar_len;
  wire  [2:0]   m_memory_ar_size;
  wire  [1:0]   m_memory_ar_burst;
  wire          m_memory_ar_lock;
  wire  [3:0]   m_memory_ar_cache;
  wire  [2:0]   m_memory_ar_prot;
  wire  [3:0]   m_memory_ar_qos;
  wire          m_memory_r_ready;
  wire          m_memory_r_valid;
  wire  [13:0]  m_memory_r_id;
  wire  [255:0] m_memory_r_data;
  wire  [1:0]   m_memory_r_resp;
  wire          m_memory_r_last;
  wire          io_clock;
  wire          io_reset;
  wire  [63:0]  io_extIntrs;
  wire          io_systemjtag_jtag_TCK;
  wire          io_systemjtag_jtag_TMS;
  wire          io_systemjtag_jtag_TDI;
  wire          io_systemjtag_jtag_TDO_data;
  wire          io_systemjtag_jtag_TDO_driven;
  wire          io_systemjtag_reset;
  wire  [10:0]  io_systemjtag_mfr_id;
  wire  [15:0]  io_systemjtag_part_number;
  wire  [3:0]   io_systemjtag_version;
  wire          io_debug_reset;
  wire          io_riscv_halt_0;
  wire          io_riscv_halt_1;
  wire          scan_mode;
  wire          dft_lgc_rst_n;
  wire          dft_mode;
  wire          dft_ram_hold;
  wire          dft_ram_bypass;
  wire          dft_ram_bp_clken;
  wire          dft_l3dataram_clk;
  wire          dft_l3dataramclk_bypass;
  wire          dft_cgen;

  assign s_dma_aw_valid = 0;
  assign s_dma_aw_id = 0;
  assign s_dma_aw_addr = 0;
  assign s_dma_aw_len = 0;
  assign s_dma_aw_size = 0;
  assign s_dma_aw_burst = 0;
  assign s_dma_aw_lock = 0;
  assign s_dma_aw_cache = 0;
  assign s_dma_aw_prot = 0;
  assign s_dma_aw_qos = 0;
  assign s_dma_w_valid = 0;
  assign s_dma_w_data = 0;
  assign s_dma_w_strb = 0;
  assign s_dma_w_last = 0;
  assign s_dma_b_ready = 0;
  assign s_dma_ar_valid = 0;
  assign s_dma_ar_id = 0;
  assign s_dma_ar_addr = 0;
  assign s_dma_ar_len = 0;
  assign s_dma_ar_size = 0;
  assign s_dma_ar_burst = 0;
  assign s_dma_ar_lock = 0;
  assign s_dma_ar_cache = 0;
  assign s_dma_ar_prot = 0;
  assign s_dma_ar_qos = 0;
  assign s_dma_r_ready = 0;
  assign m_peripheral_aw_ready = 0;
  assign m_peripheral_w_ready = 0;
  assign m_peripheral_b_valid = 0;
  assign m_peripheral_b_id = 0;
  assign m_peripheral_b_resp = 0;
  assign m_peripheral_ar_ready = 0;
  assign m_peripheral_r_valid = 0;
  assign m_peripheral_r_id = 0;
  assign m_peripheral_r_data = 0;
  assign m_peripheral_r_resp = 0;
  assign m_peripheral_r_last = 0;
  assign io_extIntrs = 0;
  assign io_systemjtag_jtag_TCK = 0;
  assign io_systemjtag_jtag_TMS = 0;
  assign io_systemjtag_jtag_TDI = 0;
  assign io_systemjtag_reset = 0;
  assign io_systemjtag_mfr_id = 0;
  assign io_systemjtag_part_number = 0;
  assign io_systemjtag_version = 0;
  assign scan_mode = 0;
  assign dft_lgc_rst_n = 0;
  assign dft_mode = 0;
  assign dft_ram_hold = 0;
  assign dft_ram_bypass = 0;
  assign dft_ram_bp_clken = 0;
  assign dft_l3dataram_clk = 0;
  assign dft_l3dataramclk_bypass = 0;
  assign dft_cgen = 0;

  assign io_clock = clock;
  assign io_reset = reset;
  XSTop l_soc(
    .s_dma_aw_ready(s_dma_aw_ready),
    .s_dma_aw_valid(s_dma_aw_valid),
    .s_dma_aw_id(s_dma_aw_id),
    .s_dma_aw_addr(s_dma_aw_addr),
    .s_dma_aw_len(s_dma_aw_len),
    .s_dma_aw_size(s_dma_aw_size),
    .s_dma_aw_burst(s_dma_aw_burst),
    .s_dma_aw_lock(s_dma_aw_lock),
    .s_dma_aw_cache(s_dma_aw_cache),
    .s_dma_aw_prot(s_dma_aw_prot),
    .s_dma_aw_qos(s_dma_aw_qos),
    .s_dma_w_ready(s_dma_w_ready),
    .s_dma_w_valid(s_dma_w_valid),
    .s_dma_w_data(s_dma_w_data),
    .s_dma_w_strb(s_dma_w_strb),
    .s_dma_w_last(s_dma_w_last),
    .s_dma_b_ready(s_dma_b_ready),
    .s_dma_b_valid(s_dma_b_valid),
    .s_dma_b_id(s_dma_b_id),
    .s_dma_b_resp(s_dma_b_resp),
    .s_dma_ar_ready(s_dma_ar_ready),
    .s_dma_ar_valid(s_dma_ar_valid),
    .s_dma_ar_id(s_dma_ar_id),
    .s_dma_ar_addr(s_dma_ar_addr),
    .s_dma_ar_len(s_dma_ar_len),
    .s_dma_ar_size(s_dma_ar_size),
    .s_dma_ar_burst(s_dma_ar_burst),
    .s_dma_ar_lock(s_dma_ar_lock),
    .s_dma_ar_cache(s_dma_ar_cache),
    .s_dma_ar_prot(s_dma_ar_prot),
    .s_dma_ar_qos(s_dma_ar_qos),
    .s_dma_r_ready(s_dma_r_ready),
    .s_dma_r_valid(s_dma_r_valid),
    .s_dma_r_id(s_dma_r_id),
    .s_dma_r_data(s_dma_r_data),
    .s_dma_r_resp(s_dma_r_resp),
    .s_dma_r_last(s_dma_r_last),
    .m_peripheral_aw_ready(m_peripheral_aw_ready),
    .m_peripheral_aw_valid(m_peripheral_aw_valid),
    .m_peripheral_aw_id(m_peripheral_aw_id),
    .m_peripheral_aw_addr(m_peripheral_aw_addr),
    .m_peripheral_aw_len(m_peripheral_aw_len),
    .m_peripheral_aw_size(m_peripheral_aw_size),
    .m_peripheral_aw_burst(m_peripheral_aw_burst),
    .m_peripheral_aw_lock(m_peripheral_aw_lock),
    .m_peripheral_aw_cache(m_peripheral_aw_cache),
    .m_peripheral_aw_prot(m_peripheral_aw_prot),
    .m_peripheral_aw_qos(m_peripheral_aw_qos),
    .m_peripheral_w_ready(m_peripheral_w_ready),
    .m_peripheral_w_valid(m_peripheral_w_valid),
    .m_peripheral_w_data(m_peripheral_w_data),
    .m_peripheral_w_strb(m_peripheral_w_strb),
    .m_peripheral_w_last(m_peripheral_w_last),
    .m_peripheral_b_ready(m_peripheral_b_ready),
    .m_peripheral_b_valid(m_peripheral_b_valid),
    .m_peripheral_b_id(m_peripheral_b_id),
    .m_peripheral_b_resp(m_peripheral_b_resp),
    .m_peripheral_ar_ready(m_peripheral_ar_ready),
    .m_peripheral_ar_valid(m_peripheral_ar_valid),
    .m_peripheral_ar_id(m_peripheral_ar_id),
    .m_peripheral_ar_addr(m_peripheral_ar_addr),
    .m_peripheral_ar_len(m_peripheral_ar_len),
    .m_peripheral_ar_size(m_peripheral_ar_size),
    .m_peripheral_ar_burst(m_peripheral_ar_burst),
    .m_peripheral_ar_lock(m_peripheral_ar_lock),
    .m_peripheral_ar_cache(m_peripheral_ar_cache),
    .m_peripheral_ar_prot(m_peripheral_ar_prot),
    .m_peripheral_ar_qos(m_peripheral_ar_qos),
    .m_peripheral_r_ready(m_peripheral_r_ready),
    .m_peripheral_r_valid(m_peripheral_r_valid),
    .m_peripheral_r_id(m_peripheral_r_id),
    .m_peripheral_r_data(m_peripheral_r_data),
    .m_peripheral_r_resp(m_peripheral_r_resp),
    .m_peripheral_r_last(m_peripheral_r_last),
    .m_memory_aw_ready(m_memory_aw_ready),
    .m_memory_aw_valid(m_memory_aw_valid),
    .m_memory_aw_id(m_memory_aw_id),
    .m_memory_aw_addr(m_memory_aw_addr),
    .m_memory_aw_len(m_memory_aw_len),
    .m_memory_aw_size(m_memory_aw_size),
    .m_memory_aw_burst(m_memory_aw_burst),
    .m_memory_aw_lock(m_memory_aw_lock),
    .m_memory_aw_cache(m_memory_aw_cache),
    .m_memory_aw_prot(m_memory_aw_prot),
    .m_memory_aw_qos(m_memory_aw_qos),
    .m_memory_w_ready(m_memory_w_ready),
    .m_memory_w_valid(m_memory_w_valid),
    .m_memory_w_data(m_memory_w_data),
    .m_memory_w_strb(m_memory_w_strb),
    .m_memory_w_last(m_memory_w_last),
    .m_memory_b_ready(m_memory_b_ready),
    .m_memory_b_valid(m_memory_b_valid),
    .m_memory_b_id(m_memory_b_id),
    .m_memory_b_resp(m_memory_b_resp),
    .m_memory_ar_ready(m_memory_ar_ready),
    .m_memory_ar_valid(m_memory_ar_valid),
    .m_memory_ar_id(m_memory_ar_id),
    .m_memory_ar_addr(m_memory_ar_addr),
    .m_memory_ar_len(m_memory_ar_len),
    .m_memory_ar_size(m_memory_ar_size),
    .m_memory_ar_burst(m_memory_ar_burst),
    .m_memory_ar_lock(m_memory_ar_lock),
    .m_memory_ar_cache(m_memory_ar_cache),
    .m_memory_ar_prot(m_memory_ar_prot),
    .m_memory_ar_qos(m_memory_ar_qos),
    .m_memory_r_ready(m_memory_r_ready),
    .m_memory_r_valid(m_memory_r_valid),
    .m_memory_r_id(m_memory_r_id),
    .m_memory_r_data(m_memory_r_data),
    .m_memory_r_resp(m_memory_r_resp),
    .m_memory_r_last(m_memory_r_last),
    .io_clock(io_clock),
    .io_reset(io_reset),
    .io_extIntrs(io_extIntrs),
    .io_systemjtag_jtag_TCK(io_systemjtag_jtag_TCK),
    .io_systemjtag_jtag_TMS(io_systemjtag_jtag_TMS),
    .io_systemjtag_jtag_TDI(io_systemjtag_jtag_TDI),
    .io_systemjtag_jtag_TDO_data(io_systemjtag_jtag_TDO_data),
    .io_systemjtag_jtag_TDO_driven(io_systemjtag_jtag_TDO_driven),
    .io_systemjtag_reset(io_systemjtag_reset),
    .io_systemjtag_mfr_id(io_systemjtag_mfr_id),
    .io_systemjtag_part_number(io_systemjtag_part_number),
    .io_systemjtag_version(io_systemjtag_version),
    .io_debug_reset(io_debug_reset),
    .io_riscv_halt_0(io_riscv_halt_0),
    .io_riscv_halt_1(io_riscv_halt_1),
    .scan_mode(scan_mode),
    .dft_lgc_rst_n(dft_lgc_rst_n),
    .dft_mode(dft_mode),
    .dft_ram_hold(dft_ram_hold),
    .dft_ram_bypass(dft_ram_bypass),
    .dft_ram_bp_clken(dft_ram_bp_clken),
    .dft_l3dataram_clk(dft_l3dataram_clk),
    .dft_l3dataramclk_bypass(dft_l3dataramclk_bypass),
    .dft_cgen(dft_cgen)
);

axi_mem #(.DATA_WD(256), .ID_WD(14),.ADDR_WD(36),.LEN_WD(8), .MEM_SIZE(64),.BASE_ADDR(36'h0_8000_0000))main_memory(
    .ACLK(io_clock),
    .ARESETn(!io_reset),

    .AWID(m_memory_aw_id),
    .AWADDR(m_memory_aw_addr),
    .AWREGION(4'b0000),
    .AWLEN(m_memory_aw_len),
    .AWSIZE(m_memory_aw_size),
    .AWBURST(m_memory_aw_burst),
    .AWLOCK(m_memory_aw_lock),
    .AWCACHE(m_memory_aw_cache),
    .AWPROT(m_memory_aw_prot),
    .AWQOS(m_memory_aw_qos),
    .AWVALID(m_memory_aw_valid),
    .AWREADY(m_memory_aw_ready),

    .WDATA(m_memory_w_data),
    .WSTRB(m_memory_w_strb),
    .WLAST(m_memory_w_last),
    .WVALID(m_memory_w_valid),
    .WREADY(m_memory_w_ready),

    .BID(m_memory_b_id),
    .BRESP(m_memory_b_resp),
    .BVALID(m_memory_b_valid),
    .BREADY(m_memory_b_ready),

    .ARID(m_memory_ar_id),
    .ARADDR(m_memory_ar_addr),
    .ARREGION(4'b0000), // no use
    .ARLEN(m_memory_ar_len),
    .ARSIZE(m_memory_ar_size),
    .ARBURST(m_memory_ar_burst), // no use, process as INCR(01b)
    .ARLOCK(m_memory_ar_lock), // no use
    .ARCACHE(m_memory_ar_cache), // no use
    .ARPROT(m_memory_ar_prot), // no use
    .ARQOS(m_memory_ar_qos), // no use
    .ARVALID(m_memory_ar_valid),
    .ARREADY(m_memory_ar_ready),

    .RID(m_memory_r_id),
    .RDATA(m_memory_r_data),
    .RRESP(m_memory_r_resp),
    .RLAST(m_memory_r_last),
    .RVALID(m_memory_r_valid),
    .RREADY(m_memory_r_ready)
);

  tl_monitor_collect#(.SIZE_WD(3),.ADDR_WD(36),.DATA_WD(256),
  .SOURCE_WD(9),.SINK_WD(6),.USER_WD(8),.ECHO_WD(8)
  )tl_monitor_set(
    .clock(io_clock),
    .reset(io_reset)
  );

  huancun_assert huancun_assert_inst(.clock(io_clock), .reset(io_reset));


  reg has_init;

  string wave_type;

  initial begin
    reset = 1;
    clock = 0;
    has_init = 0;

    // init code
    simv_init();
    
    // enable waveform
    if ($test$plusargs("dump-wave")) begin
      $value$plusargs("dump-wave=%s", wave_type);
      if (wave_type == "vpd") begin
        $vcdplusfile("simv.vpd");
        $vcdpluson;
      end
`ifdef CONSIDER_FSDB
      else if (wave_type == "fsdb") begin
        $fsdbDumpfile("simv.fsdb");
        $fsdbDumpvars(0, l_soc);
      end
`endif
      else begin
        $display("unknown wave file format, want [vpd, fsdb] but:%s\n", wave_type);
        $finish();
      end
    end
    

    has_init = 1;
    #100 reset = 0;
  end

  always #1 clock <= ~clock;

  parameter N = 100000;
  reg [23:0] n = 0;

  always @(posedge clock) begin
      if(reset == 1'b1) begin
        has_init <= 1'b1;
        n <= 0;
      end

      if(!reset && has_init) begin
        if(simv_step() || n >= N) begin
          $finish();
        end
        n <= n + 1;
      end
  end

endmodule

