
module huancun_assert
(
    input wire clock,
    input wire reset
);

`define CORE0 tb_top.l_soc.moduleInstance
`define CORE1 tb_top.l_soc.auto_moduleInstance

// `define L2_0 tb_top.l_soc.moduleInstance.l2cache
// `define L2_1 tb_top.l_soc.auto_moduleInstance.l2cache

`define L3 tb_top.l_soc.l3cacheOpt

`define L2 tb_top.l_soc.moduleInstance.l2cache
`define slices_0 `L2.slices_0
`define slices_1 `L2.slices_1
`define slices_2 `L2.slices_2
`define slices_3 `L2.slices_3

`define probeHeler_0 `slices_0.probeHelperOpt
`define probeHeler_1 `slices_1.probeHelperOpt
`define probeHeler_2 `slices_2.probeHelperOpt
`define probeHeler_3 `slices_3.probeHelperOpt


// covergroup ProbeHelperCg;
//     coverpoint trigger {
//         bins `probeHeler_0.queue_io_enq_valid
//     }
// endgroup

// sequence p0;
//     $rose(`probeHeler_0.queue_io_enq_valid) |-> `probeHeler_0.queue_io_enq_ready;
// endsequence

// sequence p1;
//     $rose(`probeHeler_1.queue_io_enq_valid) |-> `probeHeler_1.queue_io_enq_ready;
// endsequence

// sequence p2;
//     $rose(`probeHeler_2.queue_io_enq_valid) |-> `probeHeler_2.queue_io_enq_ready;
// endsequence

// sequence p3;
//     $rose(`probeHeler_3.queue_io_enq_valid) |-> `probeHeler_3.queue_io_enq_ready;
// endsequence

property ProbeHelperTrig; 
    @(posedge clock) disable iff(reset)
    ($rose(`probeHeler_0.queue_io_enq_valid) |-> `probeHeler_0.queue_io_enq_ready) or 
    ($rose(`probeHeler_1.queue_io_enq_valid) |-> `probeHeler_1.queue_io_enq_ready) or
    ($rose(`probeHeler_2.queue_io_enq_valid) |-> `probeHeler_2.queue_io_enq_ready) or
    ($rose(`probeHeler_3.queue_io_enq_valid) |-> `probeHeler_3.queue_io_enq_ready);
endproperty


AssertionProbeHelper: 
assert property(ProbeHelperTrig) 
    else $warning("error!");

CoverProbeHelper:  
cover property(ProbeHelperTrig);

always@(posedge clock or negedge clock) begin

    // assert_test_label: assert (`L2_0.`ProbeHeler_0.queue) begin
    //     $display("Assertion Valid!\n");
    // end 
    // else begin
    //     $warning("Assertion assert_test_label failed!\n");
    // end

end


endmodule
