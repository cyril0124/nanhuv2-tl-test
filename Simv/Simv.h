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
#include "../Cover/MesCollect.h"
#include "../Cover/MesCom.h"
#include "../Cover/Report.h"

class Simv {
private:
    typedef tl_agent::BaseAgent BaseAgent_t;
    typedef tl_agent::ULAgent ULAgent_t;
    typedef tl_agent::CAgent CAgent_t;
    typedef tl_monitor::Monitor Monitor_t;
    typedef DIR_monitor::DIR_Monitor DIR_Monitor_t;
    typedef DIR_monitor::Dir_key Dir_key_t;
    typedef DIR_monitor::Dir_Mes Dir_Mes_t;
    
    typedef fake_l1::FakeL1 FakeL1_t;
    typedef fake_ptw::FakePTW FakePTW_t;
    typedef fake_ptw::FakePTW FakeDMA_t;
    typedef sequencer::Sequencer Sequencer_t;

    typedef Cover::Mes_Collect Mes_Collect_t;
    typedef Cover::Mes_Com Mes_Com_t;
    typedef Cover::Report Report_t;

    const static int NR_AGENTS = NR_CAGENTS + NR_ULAGENTS;
    GlobalBoard<paddr_t>            *globalBoard;
    std::shared_ptr<FakeL1_t>       l1[NR_CAGENTS];
    std::shared_ptr<FakePTW_t>      ptw[NR_PTWAGT];
    std::shared_ptr<FakeDMA_t>      dma[NR_DMAAGT];
    std::shared_ptr<Sequencer_t>    sqr;
    // monitor
    std::shared_ptr<Monitor_t>      monitors[NR_TL_MONITOR];
    std::shared_ptr<DIR_Monitor_t>  dir_monitors[NR_DIR_MONITOR];
    ScoreBoard<Dir_key_t,Dir_Mes_t> selfDir[3];
    ScoreBoard<Dir_key_t,paddr_t>   selfTag[3];
    ScoreBoard<Dir_key_t,Dir_Mes_t> clientDir[3];
    ScoreBoard<Dir_key_t,paddr_t>   clientTag[3];
    // cover
    std::shared_ptr<Mes_Collect_t> mes_collect;
    Mes_Com_t *mes_com;
    Report_t *report;

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