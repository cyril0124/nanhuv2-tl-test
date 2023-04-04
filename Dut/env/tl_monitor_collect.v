module tl_monitor_collect#(
  parameter SIZE_WD = 3,
  parameter ADDR_WD = 36,
  parameter DATA_WD = 256,
  parameter SOURCE_WD = 32,
  parameter SINK_WD = 32,
  parameter USER_WD = 32,
  parameter ECHO_WD = 32
)(
  input wire clock,
  input wire reset
);
//TL
`define CORE0 tb_top.l_soc.moduleInstance
`define CORE1 tb_top.l_soc.auto_moduleInstance
`define L3 tb_top.l_soc.l3cacheOpt
`define DMA tb_top.l_soc.misc.axi42tl
//DIR
`define L2DIR0 tb_top.l_soc.moduleInstance.l2cache.slices_0.directory//core0 L2 slice0
`define L2DIR1 tb_top.l_soc.moduleInstance.l2cache.slices_1.directory//core0 L2 slice1
`define L2DIR2 tb_top.l_soc.moduleInstance.l2cache.slices_2.directory//core0 L2 slice2
`define L2DIR3 tb_top.l_soc.moduleInstance.l2cache.slices_3.directory//core0 L2 slice3
`define L2DIR4 tb_top.l_soc.auto_moduleInstance.l2cache.slices_0.directory//core1 L2 slice0
`define L2DIR5 tb_top.l_soc.auto_moduleInstance.l2cache.slices_1.directory//core1 L2 slice1
`define L2DIR6 tb_top.l_soc.auto_moduleInstance.l2cache.slices_2.directory//core1 L2 slice2
`define L2DIR7 tb_top.l_soc.auto_moduleInstance.l2cache.slices_3.directory//core1 L2 slice3
`define L3DIR0 tb_top.l_soc.l3cacheOpt.slices_0.directory//L3 slice0
`define L3DIR1 tb_top.l_soc.l3cacheOpt.slices_1.directory//L3 slice1
`define L3DIR2 tb_top.l_soc.l3cacheOpt.slices_2.directory//L3 slice2
`define L3DIR3 tb_top.l_soc.l3cacheOpt.slices_3.directory//L3 slice3


`define DCACHE_BUS_TYPE 8'h0
`define ICACHE_BUS_TYPE 8'h1
`define TILE_BUS_TYPE 8'h2
`define L3_BUS_TYPE 8'h3
`define DMA_BUS_TYPE 8'h4
`define PTW_BUS_TYPE 8'h5
`define DIR_BUS_TYPE 8'h6 
  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )core0_monitor(
    .clock(clock),.reset(reset),.id(64'd0),.bus_type(`TILE_BUS_TYPE),
    //Channel A
    .a_opcode(`CORE0.auto_misc_memory_port_out_a_bits_opcode),
    .a_param(`CORE0.auto_misc_memory_port_out_a_bits_param),
    .a_size(`CORE0.auto_misc_memory_port_out_a_bits_size),
    .a_source({3'd0, `CORE0.auto_misc_memory_port_out_a_bits_source}),
    .a_address(`CORE0.auto_misc_memory_port_out_a_bits_address),
    .a_user({7'd0, `CORE0.auto_misc_memory_port_out_a_bits_user_preferCache}),
    .a_echo(8'b0),
    .a_mask(`CORE0.auto_misc_memory_port_out_a_bits_mask),
    .a_data(`CORE0.auto_misc_memory_port_out_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`CORE0.auto_misc_memory_port_out_a_valid),
    .a_ready(`CORE0.auto_misc_memory_port_out_a_ready),

    //Channel B
    .b_opcode(`CORE0.auto_misc_memory_port_out_b_bits_opcode),
    .b_param(`CORE0.auto_misc_memory_port_out_b_bits_param),
    .b_size(`CORE0.auto_misc_memory_port_out_b_bits_size),
    .b_source(9'b0),
    .b_address(`CORE0.auto_misc_memory_port_out_b_bits_address),
    .b_mask(`CORE0.auto_misc_memory_port_out_b_bits_mask),
    .b_data(`CORE0.auto_misc_memory_port_out_b_bits_data),
    .b_corrupt(1'b0),
    .b_valid(`CORE0.auto_misc_memory_port_out_b_valid),
    .b_ready(`CORE0.auto_misc_memory_port_out_b_ready),

    //Channel C
    .c_opcode(`CORE0.auto_misc_memory_port_out_c_bits_opcode),
    .c_param(`CORE0.auto_misc_memory_port_out_c_bits_param),
    .c_size(`CORE0.auto_misc_memory_port_out_c_bits_size),
    .c_source({3'd0, `CORE0.auto_misc_memory_port_out_c_bits_source}),
    .c_address(`CORE0.auto_misc_memory_port_out_c_bits_address),
    .c_user(8'b0),
    .c_echo({7'd0, `CORE0.auto_misc_memory_port_out_c_bits_echo_blockisdirty}),
    .c_data(`CORE0.auto_misc_memory_port_out_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`CORE0.auto_misc_memory_port_out_c_valid),
    .c_ready(`CORE0.auto_misc_memory_port_out_c_ready),

    //Channel D
    .d_opcode(`CORE0.auto_misc_memory_port_out_d_bits_opcode),
    .d_param(`CORE0.auto_misc_memory_port_out_d_bits_param),
    .d_size(`CORE0.auto_misc_memory_port_out_d_bits_size),
    .d_source({3'd0, `CORE0.auto_misc_memory_port_out_d_bits_source}),
    .d_sink(`CORE0.auto_misc_memory_port_out_d_bits_sink),
    .d_denied(`CORE0.auto_misc_memory_port_out_d_bits_denied),
    .d_user(8'b0),
    .d_echo({7'd0, `CORE0.auto_misc_memory_port_out_d_bits_echo_blockisdirty}),
    .d_data(`CORE0.auto_misc_memory_port_out_d_bits_data),
    .d_corrupt(`CORE0.auto_misc_memory_port_out_d_bits_corrupt),
    .d_valid(`CORE0.auto_misc_memory_port_out_d_valid),
    .d_ready(`CORE0.auto_misc_memory_port_out_d_ready),

    //Channel E
    .e_sink(`CORE0.auto_misc_memory_port_out_e_bits_sink),
    .e_valid(`CORE0.auto_misc_memory_port_out_e_valid),
    .e_ready(`CORE0.auto_misc_memory_port_out_e_ready)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )core1_monitor(
    .clock(clock),.reset(reset),.id(64'd1),.bus_type(`TILE_BUS_TYPE),
    //Channel A
    .a_opcode(`CORE1.auto_misc_memory_port_out_a_bits_opcode),
    .a_param(`CORE1.auto_misc_memory_port_out_a_bits_param),
    .a_size(`CORE1.auto_misc_memory_port_out_a_bits_size),
    .a_source({3'd0, `CORE1.auto_misc_memory_port_out_a_bits_source}),
    .a_address(`CORE1.auto_misc_memory_port_out_a_bits_address),
    .a_user({7'd0, `CORE1.auto_misc_memory_port_out_a_bits_user_preferCache}),
    .a_echo(8'b0),
    .a_mask(`CORE1.auto_misc_memory_port_out_a_bits_mask),
    .a_data(`CORE1.auto_misc_memory_port_out_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`CORE1.auto_misc_memory_port_out_a_valid),
    .a_ready(`CORE1.auto_misc_memory_port_out_a_ready),

    //Channel B
    .b_opcode(`CORE1.auto_misc_memory_port_out_b_bits_opcode),
    .b_param(`CORE1.auto_misc_memory_port_out_b_bits_param),
    .b_size(`CORE1.auto_misc_memory_port_out_b_bits_size),
    .b_source(9'b0),
    .b_address(`CORE1.auto_misc_memory_port_out_b_bits_address),
    .b_mask(`CORE1.auto_misc_memory_port_out_b_bits_mask),
    .b_data(`CORE1.auto_misc_memory_port_out_b_bits_data),
    .b_corrupt(1'b0),
    .b_valid(`CORE1.auto_misc_memory_port_out_b_valid),
    .b_ready(`CORE1.auto_misc_memory_port_out_b_ready),

    //Channel C
    .c_opcode(`CORE1.auto_misc_memory_port_out_c_bits_opcode),
    .c_param(`CORE1.auto_misc_memory_port_out_c_bits_param),
    .c_size(`CORE1.auto_misc_memory_port_out_c_bits_size),
    .c_source({3'd0, `CORE1.auto_misc_memory_port_out_c_bits_source}),
    .c_address(`CORE1.auto_misc_memory_port_out_c_bits_address),
    .c_user(8'b0),
    .c_echo({7'd0, `CORE1.auto_misc_memory_port_out_c_bits_echo_blockisdirty}),
    .c_data(`CORE1.auto_misc_memory_port_out_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`CORE1.auto_misc_memory_port_out_c_valid),
    .c_ready(`CORE1.auto_misc_memory_port_out_c_ready),

    //Channel D
    .d_opcode(`CORE1.auto_misc_memory_port_out_d_bits_opcode),
    .d_param(`CORE1.auto_misc_memory_port_out_d_bits_param),
    .d_size(`CORE1.auto_misc_memory_port_out_d_bits_size),
    .d_source({3'd0, `CORE1.auto_misc_memory_port_out_d_bits_source}),
    .d_sink(`CORE1.auto_misc_memory_port_out_d_bits_sink),
    .d_denied(`CORE1.auto_misc_memory_port_out_d_bits_denied),
    .d_user(8'b0),
    .d_echo({7'd0, `CORE1.auto_misc_memory_port_out_d_bits_echo_blockisdirty}),
    .d_data(`CORE1.auto_misc_memory_port_out_d_bits_data),
    .d_corrupt(`CORE1.auto_misc_memory_port_out_d_bits_corrupt),
    .d_valid(`CORE1.auto_misc_memory_port_out_d_valid),
    .d_ready(`CORE1.auto_misc_memory_port_out_d_ready),

    //Channel E
    .e_sink(`CORE1.auto_misc_memory_port_out_e_bits_sink),
    .e_valid(`CORE1.auto_misc_memory_port_out_e_valid),
    .e_ready(`CORE1.auto_misc_memory_port_out_e_ready)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )l3b0_monitor(
    .clock(clock),.reset(reset),.id(64'd0),.bus_type(`L3_BUS_TYPE),
    //Channel A
    .a_opcode(`L3.auto_out_0_a_bits_opcode),
    .a_param(`L3.auto_out_0_a_bits_param),
    .a_size(`L3.auto_out_0_a_bits_size),
    .a_source({5'd0, `L3.auto_out_0_a_bits_source}),
    .a_address(`L3.auto_out_0_a_bits_address),
    .a_user(8'b0),
    .a_echo(8'b0),
    .a_mask(`L3.auto_out_0_a_bits_mask),
    .a_data(`L3.auto_out_0_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`L3.auto_out_0_a_valid),
    .a_ready(`L3.auto_out_0_a_ready),

    //Channel B
    .b_opcode(3'b0),.b_param(2'b0),.b_size(3'b0),.b_source(9'b0),
    .b_address(36'b0),.b_mask(32'b0),.b_data(256'b0),.b_corrupt(1'b0),
    .b_valid(1'b0),.b_ready(1'b0),

    //Channel C
    .c_opcode(`L3.auto_out_0_c_bits_opcode),
    .c_param(3'b0),
    .c_size(`L3.auto_out_0_c_bits_size),
    .c_source({5'd0, `L3.auto_out_0_c_bits_source}),
    .c_address(`L3.auto_out_0_c_bits_address),
    .c_user(8'b0),
    .c_echo(8'b0),
    .c_data(`L3.auto_out_0_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`L3.auto_out_0_c_valid),
    .c_ready(`L3.auto_out_0_c_ready),

    //Channel D
    .d_opcode(`L3.auto_out_0_d_bits_opcode),
    .d_param(`L3.auto_out_0_d_bits_param),
    .d_size(`L3.auto_out_0_d_bits_size),
    .d_source({5'd0, `L3.auto_out_0_d_bits_source}),
    .d_sink({3'd0, `L3.auto_out_0_d_bits_sink}),
    .d_denied(`L3.auto_out_0_d_bits_denied),
    .d_user(8'b0),
    .d_echo(8'b0),
    .d_data(`L3.auto_out_0_d_bits_data),
    .d_corrupt(1'b0),
    .d_valid(`L3.auto_out_0_d_valid),
    .d_ready(`L3.auto_out_0_d_ready),

    //Channel E
    .e_sink({3'd0, `L3.auto_out_0_e_bits_sink}),
    .e_valid(`L3.auto_out_0_e_valid),
    .e_ready(1'b1)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )l3b1_monitor(
    .clock(clock),.reset(reset),.id(64'd1),.bus_type(`L3_BUS_TYPE),
    //Channel A
    .a_opcode(`L3.auto_out_1_a_bits_opcode),
    .a_param(`L3.auto_out_1_a_bits_param),
    .a_size(`L3.auto_out_1_a_bits_size),
    .a_source({5'd0, `L3.auto_out_1_a_bits_source}),
    .a_address(`L3.auto_out_1_a_bits_address),
    .a_user(8'b0),
    .a_echo(8'b0),
    .a_mask(`L3.auto_out_1_a_bits_mask),
    .a_data(`L3.auto_out_1_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`L3.auto_out_1_a_valid),
    .a_ready(`L3.auto_out_1_a_ready),

    //Channel B
    .b_opcode(3'b0),.b_param(2'b0),.b_size(3'b0),.b_source(9'b0),
    .b_address(36'b0),.b_mask(32'b0),.b_data(256'b0),.b_corrupt(1'b0),
    .b_valid(1'b0),.b_ready(1'b0),

    //Channel C
    .c_opcode(`L3.auto_out_1_c_bits_opcode),
    .c_param(3'b0),
    .c_size(`L3.auto_out_1_c_bits_size),
    .c_source({5'd0, `L3.auto_out_1_c_bits_source}),
    .c_address(`L3.auto_out_1_c_bits_address),
    .c_user(8'b0),
    .c_echo(8'b0),
    .c_data(`L3.auto_out_1_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`L3.auto_out_1_c_valid),
    .c_ready(`L3.auto_out_1_c_ready),

    //Channel D
    .d_opcode(`L3.auto_out_1_d_bits_opcode),
    .d_param(`L3.auto_out_1_d_bits_param),
    .d_size(`L3.auto_out_1_d_bits_size),
    .d_source({5'd0, `L3.auto_out_1_d_bits_source}),
    .d_sink({3'd0, `L3.auto_out_1_d_bits_sink}),
    .d_denied(`L3.auto_out_1_d_bits_denied),
    .d_user(8'b0),
    .d_echo(8'b0),
    .d_data(`L3.auto_out_1_d_bits_data),
    .d_corrupt(1'b0),
    .d_valid(`L3.auto_out_1_d_valid),
    .d_ready(`L3.auto_out_1_d_ready),

    //Channel E
    .e_sink({3'd0, `L3.auto_out_1_e_bits_sink}),
    .e_valid(`L3.auto_out_1_e_valid),
    .e_ready(1'b1)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )l3b2_monitor(
    .clock(clock),.reset(reset),.id(64'd2),.bus_type(`L3_BUS_TYPE),
    //Channel A
    .a_opcode(`L3.auto_out_2_a_bits_opcode),
    .a_param(`L3.auto_out_2_a_bits_param),
    .a_size(`L3.auto_out_2_a_bits_size),
    .a_source({5'd0, `L3.auto_out_2_a_bits_source}),
    .a_address(`L3.auto_out_2_a_bits_address),
    .a_user(8'b0),
    .a_echo(8'b0),
    .a_mask(`L3.auto_out_2_a_bits_mask),
    .a_data(`L3.auto_out_2_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`L3.auto_out_2_a_valid),
    .a_ready(`L3.auto_out_2_a_ready),

    //Channel B
    .b_opcode(3'b0),.b_param(2'b0),.b_size(3'b0),.b_source(9'b0),
    .b_address(36'b0),.b_mask(32'b0),.b_data(256'b0),.b_corrupt(1'b0),
    .b_valid(1'b0),.b_ready(1'b0),

    //Channel C
    .c_opcode(`L3.auto_out_2_c_bits_opcode),
    .c_param(3'b0),
    .c_size(`L3.auto_out_2_c_bits_size),
    .c_source({5'd0, `L3.auto_out_2_c_bits_source}),
    .c_address(`L3.auto_out_2_c_bits_address),
    .c_user(8'b0),
    .c_echo(8'b0),
    .c_data(`L3.auto_out_2_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`L3.auto_out_2_c_valid),
    .c_ready(`L3.auto_out_2_c_ready),

    //Channel D
    .d_opcode(`L3.auto_out_2_d_bits_opcode),
    .d_param(`L3.auto_out_2_d_bits_param),
    .d_size(`L3.auto_out_2_d_bits_size),
    .d_source({5'd0, `L3.auto_out_2_d_bits_source}),
    .d_sink({3'd0, `L3.auto_out_2_d_bits_sink}),
    .d_denied(`L3.auto_out_2_d_bits_denied),
    .d_user(8'b0),
    .d_echo(8'b0),
    .d_data(`L3.auto_out_2_d_bits_data),
    .d_corrupt(1'b0),
    .d_valid(`L3.auto_out_2_d_valid),
    .d_ready(`L3.auto_out_2_d_ready),

    //Channel E
    .e_sink({3'd0, `L3.auto_out_2_e_bits_sink}),
    .e_valid(`L3.auto_out_2_e_valid),
    .e_ready(1'b1)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )l3b3_monitor(
    .clock(clock),.reset(reset),.id(64'd3),.bus_type(`L3_BUS_TYPE),
    //Channel A
    .a_opcode(`L3.auto_out_3_a_bits_opcode),
    .a_param(`L3.auto_out_3_a_bits_param),
    .a_size(`L3.auto_out_3_a_bits_size),
    .a_source({5'd0, `L3.auto_out_3_a_bits_source}),
    .a_address(`L3.auto_out_3_a_bits_address),
    .a_user(8'b0),
    .a_echo(8'b0),
    .a_mask(`L3.auto_out_3_a_bits_mask),
    .a_data(`L3.auto_out_3_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`L3.auto_out_3_a_valid),
    .a_ready(`L3.auto_out_3_a_ready),

    //Channel B
    .b_opcode(3'b0),.b_param(2'b0),.b_size(3'b0),.b_source(9'b0),
    .b_address(36'b0),.b_mask(32'b0),.b_data(256'b0),.b_corrupt(1'b0),
    .b_valid(1'b0),.b_ready(1'b0),

    //Channel C
    .c_opcode(`L3.auto_out_3_c_bits_opcode),
    .c_param(3'b0),
    .c_size(`L3.auto_out_3_c_bits_size),
    .c_source({5'd0, `L3.auto_out_3_c_bits_source}),
    .c_address(`L3.auto_out_3_c_bits_address),
    .c_user(8'b0),
    .c_echo(8'b0),
    .c_data(`L3.auto_out_3_c_bits_data),
    .c_corrupt(1'b0),
    .c_valid(`L3.auto_out_3_c_valid),
    .c_ready(`L3.auto_out_3_c_ready),

    //Channel D
    .d_opcode(`L3.auto_out_3_d_bits_opcode),
    .d_param(`L3.auto_out_3_d_bits_param),
    .d_size(`L3.auto_out_3_d_bits_size),
    .d_source({5'd0, `L3.auto_out_3_d_bits_source}),
    .d_sink({3'd0, `L3.auto_out_3_d_bits_sink}),
    .d_denied(`L3.auto_out_3_d_bits_denied),
    .d_user(8'b0),
    .d_echo(8'b0),
    .d_data(`L3.auto_out_3_d_bits_data),
    .d_corrupt(1'b0),
    .d_valid(`L3.auto_out_3_d_valid),
    .d_ready(`L3.auto_out_3_d_ready),

    //Channel E
    .e_sink({3'd0, `L3.auto_out_3_e_bits_sink}),
    .e_valid(`L3.auto_out_3_e_valid),
    .e_ready(1'b1)
  );

  tl_monitor#(.SIZE_WD(SIZE_WD),.ADDR_WD(ADDR_WD),.DATA_WD(DATA_WD),
    .SOURCE_WD(SOURCE_WD),.SINK_WD(SINK_WD),.USER_WD(USER_WD),.ECHO_WD(ECHO_WD)
    )dma_monitor(
    .clock(clock),.reset(reset),.id(64'd0),.bus_type(`DMA_BUS_TYPE),
    //Channel A
    .a_opcode(`DMA.auto_out_a_bits_opcode),
    .a_param(3'b0),
    .a_size(`DMA.auto_out_a_bits_size),
    .a_source(`DMA.auto_out_a_bits_source),
    .a_address(`DMA.auto_out_a_bits_address),
    .a_user(8'b0),
    .a_echo(8'b0),
    .a_mask(`DMA.auto_out_a_bits_mask),
    .a_data(`DMA.auto_out_a_bits_data),
    .a_corrupt(1'b0),
    .a_valid(`DMA.auto_out_a_valid),
    .a_ready(`DMA.auto_out_a_ready),

    //Channel B
    .b_opcode(3'b0),.b_param(2'b0),.b_size(3'b0),.b_source(9'b0),
    .b_address(36'b0),.b_mask(32'b0),.b_data(256'b0),.b_corrupt(1'b0),
    .b_valid(1'b0),.b_ready(1'b0),

    //Channel C
    .c_opcode(3'b0),.c_param(3'b0),.c_size(3'b0),.c_source(9'b0),
    .c_address(36'b0),.c_user(8'b0),.c_echo(8'b0),.c_data(256'b0),
    .c_corrupt(1'b0),.c_valid(1'b0),.c_ready(1'b0),

    //Channel D
    .d_opcode(`DMA.auto_out_d_bits_opcode),
    .d_param(2'b0),
    .d_size(`DMA.auto_out_d_bits_size),
    .d_source(`DMA.auto_out_d_bits_source),
    .d_sink(6'b0),
    .d_denied(`DMA.auto_out_d_bits_denied),
    .d_user(8'b0),
    .d_echo(8'b0),
    .d_data(`DMA.auto_out_d_bits_data),
    .d_corrupt(`DMA.auto_out_d_bits_corrupt),
    .d_valid(`DMA.auto_out_d_valid),
    .d_ready(`DMA.auto_out_d_ready),

    //Channel E
    .e_sink(6'b0),.e_valid(1'b0),.e_ready(1'b0)
  );

  //L2DIR0
  dir_monitor#(
    )dir_monitor_0(
    .clock(clock),.reset(reset),.id(64'd0),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR0.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR0.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR0.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR0.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR0.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR0.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR0.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR0.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR0.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR0.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR0.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR0.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR0.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR0.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR0.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR0.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR0.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR0.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR0.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR0.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR0.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR0.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR0.io_clientTagWreq_bits_tag)
  );
  //L2DIR1
  dir_monitor#(
    )dir_monitor_1(
    .clock(clock),.reset(reset),.id(64'd1),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR1.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR1.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR1.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR1.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR1.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR1.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR1.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR1.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR1.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR1.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR1.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR1.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR1.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR1.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR1.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR1.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR1.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR1.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR1.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR1.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR1.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR1.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR1.io_clientTagWreq_bits_tag)
  );
  //L2DIR2
  dir_monitor#(
    )dir_monitor_2(
    .clock(clock),.reset(reset),.id(64'd2),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR2.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR2.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR2.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR2.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR2.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR2.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR2.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR2.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR2.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR2.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR2.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR2.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR2.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR2.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR2.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR2.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR2.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR2.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR2.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR2.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR2.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR2.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR2.io_clientTagWreq_bits_tag)
  );
  //L2DIR3
  dir_monitor#(
    )dir_monitor_3(
    .clock(clock),.reset(reset),.id(64'd3),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR3.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR3.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR3.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR3.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR3.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR3.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR3.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR3.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR3.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR3.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR3.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR3.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR3.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR3.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR3.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR3.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR3.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR3.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR3.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR3.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR3.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR3.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR3.io_clientTagWreq_bits_tag)
  );
  //L2DIR4
  dir_monitor#(
    )dir_monitor_4(
    .clock(clock),.reset(reset),.id(64'd4),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR4.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR4.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR4.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR4.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR4.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR4.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR4.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR4.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR4.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR4.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR4.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR4.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR4.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR4.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR4.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR4.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR4.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR4.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR4.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR4.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR4.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR4.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR4.io_clientTagWreq_bits_tag)
  );
  //L2DIR5
  dir_monitor#(
    )dir_monitor_5(
    .clock(clock),.reset(reset),.id(64'd5),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR5.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR5.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR5.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR5.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR5.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR5.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR5.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR5.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR5.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR5.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR5.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR5.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR5.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR5.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR5.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR5.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR5.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR5.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR5.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR5.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR5.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR5.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR5.io_clientTagWreq_bits_tag)
  );
  //L2DIR6
  dir_monitor#(
    )dir_monitor_6(
    .clock(clock),.reset(reset),.id(64'd6),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR6.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR6.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR6.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR6.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR6.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR6.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR6.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR6.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR6.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR6.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR6.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR6.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR6.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR6.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR6.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR6.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR6.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR6.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR6.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR6.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR6.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR6.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR6.io_clientTagWreq_bits_tag)
  );
  //L2DIR7
  dir_monitor#(
    )dir_monitor_7(
    .clock(clock),.reset(reset),.id(64'd7),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(1'b1),
    .io_tagWReq_ready(1'b1),
    .io_clientDirWReq_ready(1'b1),
    .io_clientTagWreq_ready(1'b1),

    .io_dirWReq_valid(`L2DIR7.io_dirWReq_valid),
    .io_dirWReq_bits_set({3'b0,`L2DIR7.io_dirWReq_bits_set}),
    .io_dirWReq_bits_way(`L2DIR7.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L2DIR7.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L2DIR7.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L2DIR7.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L2DIR7.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(`L2DIR7.io_dirWReq_bits_data_prefetch),
    .io_tagWReq_valid(`L2DIR7.io_tagWReq_valid),
    .io_tagWReq_bits_set({3'b0,`L2DIR7.io_tagWReq_bits_set}),
    .io_tagWReq_bits_way(`L2DIR7.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag(`L2DIR7.io_tagWReq_bits_tag),
    .io_clientDirWReq_valid(`L2DIR7.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set({4'b0,`L2DIR7.io_clientDirWReq_bits_set}),
    .io_clientDirWReq_bits_way(`L2DIR7.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L2DIR7.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(`L2DIR7.io_clientDirWReq_bits_data_0_alias),
    .io_clientDirWReq_bits_data_1_state(`L2DIR7.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(`L2DIR7.io_clientDirWReq_bits_data_1_alias),
    .io_clientTagWreq_valid(`L2DIR7.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set({4'b0,`L2DIR7.io_clientTagWreq_bits_set}),
    .io_clientTagWreq_bits_way(`L2DIR7.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag(`L2DIR7.io_clientTagWreq_bits_tag)
  );
  //L3DIR0
  dir_monitor_L3#(
    )dir_monitor_8(
    .clock(clock),.reset(reset),.id(64'd8),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(`L3DIR0.io_dirWReq_ready),
    .io_tagWReq_ready(`L3DIR0.io_tagWReq_ready),
    .io_clientDirWReq_ready(`L3DIR0.io_clientDirWReq_ready),
    .io_clientTagWreq_ready(`L3DIR0.io_clientTagWreq_ready),

    .io_dirWReq_valid(`L3DIR0.io_dirWReq_valid),
    .io_dirWReq_bits_set(`L3DIR0.io_dirWReq_bits_set),
    .io_dirWReq_bits_way(`L3DIR0.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L3DIR0.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L3DIR0.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L3DIR0.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L3DIR0.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(1'd0),
    .io_tagWReq_valid(`L3DIR0.io_tagWReq_valid),
    .io_tagWReq_bits_set(`L3DIR0.io_tagWReq_bits_set),
    .io_tagWReq_bits_way(`L3DIR0.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag({3'b0,`L3DIR0.io_tagWReq_bits_tag}),
    .io_clientDirWReq_valid(`L3DIR0.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set(`L3DIR0.io_clientDirWReq_bits_set),
    .io_clientDirWReq_bits_way(`L3DIR0.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L3DIR0.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(2'd0),
    .io_clientDirWReq_bits_data_1_state(`L3DIR0.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(2'd0),
    .io_clientTagWreq_valid(`L3DIR0.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set(`L3DIR0.io_clientTagWreq_bits_set),
    .io_clientTagWreq_bits_way(`L3DIR0.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag({4'b0,`L3DIR0.io_clientTagWreq_bits_tag})
  );
  //L3DIR1
  dir_monitor_L3#(
    )dir_monitor_9(
    .clock(clock),.reset(reset),.id(64'd9),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(`L3DIR1.io_dirWReq_ready),
    .io_tagWReq_ready(`L3DIR1.io_tagWReq_ready),
    .io_clientDirWReq_ready(`L3DIR1.io_clientDirWReq_ready),
    .io_clientTagWreq_ready(`L3DIR1.io_clientTagWreq_ready),

    .io_dirWReq_valid(`L3DIR1.io_dirWReq_valid),
    .io_dirWReq_bits_set(`L3DIR1.io_dirWReq_bits_set),
    .io_dirWReq_bits_way(`L3DIR1.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L3DIR1.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L3DIR1.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L3DIR1.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L3DIR1.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(1'd0),
    .io_tagWReq_valid(`L3DIR1.io_tagWReq_valid),
    .io_tagWReq_bits_set(`L3DIR1.io_tagWReq_bits_set),
    .io_tagWReq_bits_way(`L3DIR1.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag({3'b0,`L3DIR1.io_tagWReq_bits_tag}),
    .io_clientDirWReq_valid(`L3DIR1.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set(`L3DIR1.io_clientDirWReq_bits_set),
    .io_clientDirWReq_bits_way(`L3DIR1.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L3DIR1.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(2'd0),
    .io_clientDirWReq_bits_data_1_state(`L3DIR1.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(2'd0),
    .io_clientTagWreq_valid(`L3DIR1.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set(`L3DIR1.io_clientTagWreq_bits_set),
    .io_clientTagWreq_bits_way(`L3DIR1.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag({4'b0,`L3DIR1.io_clientTagWreq_bits_tag})
  );
  //L3DIR2
  dir_monitor_L3#(
    )dir_monitor_10(
    .clock(clock),.reset(reset),.id(64'd10),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(`L3DIR2.io_dirWReq_ready),
    .io_tagWReq_ready(`L3DIR2.io_tagWReq_ready),
    .io_clientDirWReq_ready(`L3DIR2.io_clientDirWReq_ready),
    .io_clientTagWreq_ready(`L3DIR2.io_clientTagWreq_ready),

    .io_dirWReq_valid(`L3DIR2.io_dirWReq_valid),
    .io_dirWReq_bits_set(`L3DIR2.io_dirWReq_bits_set),
    .io_dirWReq_bits_way(`L3DIR2.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L3DIR2.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L3DIR2.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L3DIR2.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L3DIR2.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(1'd0),
    .io_tagWReq_valid(`L3DIR2.io_tagWReq_valid),
    .io_tagWReq_bits_set(`L3DIR2.io_tagWReq_bits_set),
    .io_tagWReq_bits_way(`L3DIR2.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag({3'b0,`L3DIR2.io_tagWReq_bits_tag}),
    .io_clientDirWReq_valid(`L3DIR2.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set(`L3DIR2.io_clientDirWReq_bits_set),
    .io_clientDirWReq_bits_way(`L3DIR2.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L3DIR2.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(2'd0),
    .io_clientDirWReq_bits_data_1_state(`L3DIR2.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(2'd0),
    .io_clientTagWreq_valid(`L3DIR2.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set(`L3DIR2.io_clientTagWreq_bits_set),
    .io_clientTagWreq_bits_way(`L3DIR2.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag({4'b0,`L3DIR2.io_clientTagWreq_bits_tag})
  );
  //L3DIR3
  dir_monitor_L3#(
    )dir_monitor_11(
    .clock(clock),.reset(reset),.id(64'd11),.bus_type(`DIR_BUS_TYPE),

    .io_dirWReq_ready(`L3DIR3.io_dirWReq_ready),
    .io_tagWReq_ready(`L3DIR3.io_tagWReq_ready),
    .io_clientDirWReq_ready(`L3DIR3.io_clientDirWReq_ready),
    .io_clientTagWreq_ready(`L3DIR3.io_clientTagWreq_ready),

    .io_dirWReq_valid(`L3DIR3.io_dirWReq_valid),
    .io_dirWReq_bits_set(`L3DIR3.io_dirWReq_bits_set),
    .io_dirWReq_bits_way(`L3DIR3.io_dirWReq_bits_way),
    .io_dirWReq_bits_data_dirty(`L3DIR3.io_dirWReq_bits_data_dirty),
    .io_dirWReq_bits_data_state(`L3DIR3.io_dirWReq_bits_data_state),
    .io_dirWReq_bits_data_clientStates_0(`L3DIR3.io_dirWReq_bits_data_clientStates_0),
    .io_dirWReq_bits_data_clientStates_1(`L3DIR3.io_dirWReq_bits_data_clientStates_1),
    .io_dirWReq_bits_data_prefetch(1'd0),
    .io_tagWReq_valid(`L3DIR3.io_tagWReq_valid),
    .io_tagWReq_bits_set(`L3DIR3.io_tagWReq_bits_set),
    .io_tagWReq_bits_way(`L3DIR3.io_tagWReq_bits_way),
    .io_tagWReq_bits_tag({3'b0,`L3DIR3.io_tagWReq_bits_tag}),
    .io_clientDirWReq_valid(`L3DIR3.io_clientDirWReq_valid),
    .io_clientDirWReq_bits_set(`L3DIR3.io_clientDirWReq_bits_set),
    .io_clientDirWReq_bits_way(`L3DIR3.io_clientDirWReq_bits_way),
    .io_clientDirWReq_bits_data_0_state(`L3DIR3.io_clientDirWReq_bits_data_0_state),
    .io_clientDirWReq_bits_data_0_alias(2'd0),
    .io_clientDirWReq_bits_data_1_state(`L3DIR3.io_clientDirWReq_bits_data_1_state),
    .io_clientDirWReq_bits_data_1_alias(2'd0),
    .io_clientTagWreq_valid(`L3DIR3.io_clientTagWreq_valid),
    .io_clientTagWreq_bits_set(`L3DIR3.io_clientTagWreq_bits_set),
    .io_clientTagWreq_bits_way(`L3DIR3.io_clientTagWreq_bits_way),
    .io_clientTagWreq_bits_tag({4'b0,`L3DIR3.io_clientTagWreq_bits_tag})
  );


`undef CORE0
`undef CORE1
`undef L3
`undef DMA
`undef L2DIR0
`undef L2DIR1
`undef L2DIR2
`undef L2DIR3
`undef L2DIR4
`undef L2DIR5
`undef L2DIR6
`undef L2DIR7
`undef L3DIR0
`undef L3DIR1
`undef L3DIR2
`undef L3DIR3

`undef DCACHE_BUS_TYPE
`undef ICACHE_BUS_TYPE
`undef TILE_BUS_TYPE
`undef L3_BUS_TYPE
`undef DMA_BUS_TYPE
`undef PTW_BUS_TYPE
`undef DIR_BUS_TYPE
endmodule