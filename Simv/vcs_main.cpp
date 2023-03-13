

#include "Simv.h"
#include <iostream>

Simv *simv;

uint64_t Cycles = 0;
bool Verbose = false;

extern "C" void simv_init(void) {
    simv = new Simv();
    Verbose = true;
}


extern "C" int simv_step(void) {
    simv->step();
    return 0;
}

