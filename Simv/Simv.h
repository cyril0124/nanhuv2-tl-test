//
// Created by zcy on 03/12/23.
//

#ifndef SIMV_H
#define SIMV_H



#include "../Fuzzer/Fuzzer.h"
#include "../TLAgent/CAgent.h"
#include "../TLAgent/ULAgent.h"
#include "../Utils/Common.h"
#include "../Utils/ScoreBoard.h"
#include "../Monitor/Monitor.h"
#include "../CacheModel/FakeL1/fake_l1.h"
#include "../CacheModel/FakePTW/fake_ptw.h"
#include "../Sequencer/sequencer.h"
#include "../Monitor/DIR_Monitor.h"


class Simv {
private:
    typedef tl_agent::BaseAgent BaseAgent_t;
    typedef tl_agent::ULAgent ULAgent_t;
    typedef tl_agent::CAgent CAgent_t;
    typedef tl_monitor::Monitor Monitor_t;
    typedef DIR_monitor::DIR_Monitor DIR_Monitor_t;
    
    typedef fake_l1::FakeL1 FakeL1_t;
    typedef fake_ptw::FakePTW FakePTW_t;
    typedef fake_ptw::FakePTW FakeDMA_t;
    typedef sequencer::Sequencer Sequencer_t;

    const static int NR_AGENTS = NR_CAGENTS + NR_ULAGENTS;
    GlobalBoard<paddr_t>            *globalBoard;
    std::shared_ptr<Monitor_t>      monitors[NR_TL_MONITOR];
    std::shared_ptr<DIR_Monitor_t>  dir_monitors[NR_DIR_MONITOR];
    std::shared_ptr<FakeL1_t>       l1[NR_CAGENTS];
    std::shared_ptr<FakePTW_t>      ptw[NR_PTWAGT];
    std::shared_ptr<FakeDMA_t>      dma[NR_DMAAGT];
    std::shared_ptr<Sequencer_t>    sqr;

    // uint64_t Cycles;
    uint64_t seed = 0;
    bool en_monitor = false;
    bool random_mode = true;
    

public:
    Simv();
    ~Simv();
    void step(void);
    void update_cycles(uint64_t inc);
    


};




#endif // VCS_H