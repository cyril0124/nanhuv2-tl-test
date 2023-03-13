#!/bin/bash
# Build
cd build
make -j 16
# Run
./tlc_test -v | tee ../out.log
# Parse Coverage
mkdir coverage_out
verilator_coverage --rank --write vlt_coverage.dat --annotate coverage_out
