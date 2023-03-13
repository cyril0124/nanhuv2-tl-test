#!/bin/bash
# Build
mkdir build
cd build
# cmake .. -DCOV=1 -DTRACE=1 -DTHREAD=16 -DCMAKE_BUILD_TYPE=Debug
cmake .. -DTRACE=1 -DTHREAD=16 -DCMAKE_BUILD_TYPE=Debug
make -j 16
# Run
./tlc_test -v | tee ../out.log
# Parse Coverage
mkdir coverage_out
verilator_coverage --rank --write vlt_coverage.dat --annotate coverage_out
