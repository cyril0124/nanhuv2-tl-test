
#include "Simv.h"

Simv::Simv() {
    Cycles = 0;
    globalBoard = new GlobalBoard<paddr_t>(); // address indexed

    printf("[INFO] use seed: %ld\n", this->seed);
    srand(this->seed);
    
    for (int i = 0; i < NR_CAGENTS; i++) {
        l1[i].reset(new FakeL1_t(globalBoard, i, &Cycles, i / 2, i % 2));
    }
    
    for(int i = NR_CAGENTS; i < NR_CAGENTS + NR_PTWAGT; i++) {
        ptw[i-NR_CAGENTS].reset(new FakePTW_t(globalBoard, i, &Cycles, i % 2, PTW_BUS_TYPE));
    }

    for(int i = NR_CAGENTS + NR_PTWAGT; i < NR_CAGENTS + NR_PTWAGT + NR_DMAAGT; i++) {
        dma[i-NR_CAGENTS-NR_PTWAGT].reset(new FakeDMA_t(globalBoard, i, &Cycles, 0xffffffffffffffffL, DMA_BUS_TYPE));
    }

    sqr.reset(new Sequencer_t(&Cycles));

    if (random_mode == false)
    {
        sqr->init_testcase(); // Input file test.txt
    }
    

    if(this->en_monitor){
        for (int i = 0; i < NR_TILE_MONITOR; i++) {
        monitors[i].reset(new tl_monitor::Monitor(&Cycles, i, TILE_BUS_TYPE));
        }

        for (int i = NR_TILE_MONITOR; i < NR_TILE_MONITOR + NR_L3_MONITOR; i++) {
        monitors[i].reset(new tl_monitor::Monitor(&Cycles, i - NR_TILE_MONITOR, L3_BUS_TYPE));
        }

        for (int i = NR_TILE_MONITOR + NR_L3_MONITOR; i < NR_TL_MONITOR; i++) {
        monitors[i].reset(new tl_monitor::Monitor(&Cycles, i - NR_TILE_MONITOR - NR_L3_MONITOR, DMA_BUS_TYPE));
        }

        for (int i = 0; i < NR_DIR_MONITOR; i++) {
        dir_monitors[i].reset(new DIR_monitor::DIR_Monitor(&Cycles, i, DIR_BUS_TYPE));
        }
    }
}


void Simv::step() {
    if(this->en_monitor){
        for(int i = 0; i < NR_TL_MONITOR; i++){
            monitors[i]->print_info();
        }
        for(int i = 0; i < NR_DIR_MONITOR; i++){
            dir_monitors[i]->print_info();
        }
    }

    for (int i = 0; i < NR_CAGENTS; i++) {
        l1[i]->handle_channel();
    }
    for (int i = 0; i < NR_PTWAGT; i++) {
        ptw[i]->handle_channel();
    }
    for (int i = 0; i < NR_DMAAGT; i++) {
        dma[i]->handle_channel();
    }

    if(random_mode) {
        for (int i = 0; i < NR_CAGENTS; i++) {
            // tl_base_agent::TLCTransaction tr = randomTest2(false, l1[i]->bus_type, ptw, dma);
            tl_base_agent::TLCTransaction tr = sqr->random_test_fullsys(sequencer::TLC, false, l1[i]->bus_type, ptw, dma);
            l1[i]->transaction_input(tr);
        }
        for (int i = 0; i < NR_PTWAGT; i++) {
            // tl_base_agent::TLCTransaction tr = randomTest3(ptw, dma, l1, ptw[i]->bus_type);
            tl_base_agent::TLCTransaction tr = sqr->random_test_fullsys(sequencer::TLUL, false, ptw[i]->bus_type, ptw, dma);
            ptw[i]->transaction_input(tr);
        }
        for (int i = 0; i < NR_DMAAGT; i++) {
            // tl_base_agent::TLCTransaction tr = randomTest3(ptw, dma, l1, dma[i]->bus_type);
            tl_base_agent::TLCTransaction tr = sqr->random_test_fullsys(sequencer::TLUL, false, dma[i]->bus_type, ptw, dma);
            dma[i]->transaction_input(tr);
        }
        }else{
        for (int i = 0; i < NR_CAGENTS; i++) {
            tl_base_agent::TLCTransaction tr = sqr->case_test(sequencer::TLC, i);
            l1[i]->transaction_input(tr);
        }
        for (int i = NR_CAGENTS; i < NR_CAGENTS + NR_PTWAGT; i++) {
            tl_base_agent::TLCTransaction tr = sqr->case_test(sequencer::TLUL, i);
            ptw[i-NR_CAGENTS]->transaction_input(tr);
        }
        for (int i = NR_CAGENTS + NR_PTWAGT; i < NR_CAGENTS + NR_PTWAGT + NR_DMAAGT; i++) {
            tl_base_agent::TLCTransaction tr = sqr->case_test(sequencer::TLUL, i);
            dma[i-NR_CAGENTS-NR_PTWAGT]->transaction_input(tr);
        }
    }

    

    for (int i = 0; i < NR_CAGENTS; i++) {
        l1[i]->update_signal();
    }
    for (int i = 0; i < NR_PTWAGT; i++) {
        ptw[i]->update_signal();
    }
    for (int i = 0; i < NR_DMAAGT; i++) {
        dma[i]->update_signal();
    }

    this->update_cycles(1);
}

void Simv::update_cycles(uint64_t inc) {
    Cycles += inc;
    if (Cycles % 100000 == 0) {
        printf("%lu cycles have passed!\n", Cycles);
    }
}

void assert_error_handle(void) {

}