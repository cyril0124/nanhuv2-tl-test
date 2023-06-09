cmake_minimum_required(VERSION 3.15)
project(tlc_test)

set(CMAKE_CXX_STANDARD 17)

set(DUT_DIR ../Dut)


if(DEFINED THREAD)
    add_definitions(-DVL_THREADED)
    find_package(Threads)
endif()

if(DEFINED TRACE)
    add_definitions(-DVM_TRACE=1)
endif()

if(DEFINED COV)
    add_definitions(-DVM_COV=1)
endif()

find_package(verilator)

add_subdirectory(Emu)
add_subdirectory(TLAgent)
add_subdirectory(Fuzzer)
add_subdirectory(Interface)
add_subdirectory(Monitor)
add_subdirectory(CacheModel)
add_subdirectory(Sequencer)

add_executable(tlc_test main.cpp vcs_main.cpp)
if(DEFINED THREAD)
    target_link_libraries(tlc_test Emu TLAgent Fuzzer Interface Monitor CacheModel Sequencer Threads::Threads)
else()
    target_link_libraries(tlc_test Emu TLAgent Fuzzer Interface Monitor CacheModel Sequencer)
endif()
