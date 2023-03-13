VCS_TARGET = simv

PRJ_DIR ?= ${abspath .}
DUT_DIR ?= ${PRJ_DIR}/Dut
BUILD_DIR ?= ${PRJ_DIR}/build
VCS_BUILD_DIR ?= ${BUILD_DIR}/vcs_build
THREADS ?= 200

# Log files
VCS_BUILD_LOG ?= ${PRJ_DIR}/vcs_build.log
SIMV_RUNTIME_LOG ?= ${PRJ_DIR}/tl_test.log

# CSRC_DIR += ${PRJ_DIR}/Emu
CSRC_DIR += ${PRJ_DIR}/Fuzzer
CSRC_DIR += ${PRJ_DIR}/Interface
CSRC_DIR += ${PRJ_DIR}/Monitor
CSRC_DIR += ${PRJ_DIR}/CacheModel
CSRC_DIR += ${PRJ_DIR}/Sequencer
CSRC_DIR += ${PRJ_DIR}/TLAgent
CSRC_DIR += ${PRJ_DIR}/Utils
CSRC_DIR += ${PRJ_DIR}/Simv

SIM_TOP = tb_top
SIM_TOP_V = ${DUT_DIR}/env/${SIM_TOP}.sv

# if fsdb is considered
CONSIDER_FSDB ?= 1
ifeq ($(CONSIDER_FSDB),1)
EXTRA = +define+CONSIDER_FSDB
# if VERDI_HOME is not set automatically after 'module load', please set manually.
ifndef VERDI_HOME
$(error VERDI_HOME is not set. Try whereis verdi, abandon /bin/verdi and set VERID_HOME manually)
else
NOVAS_HOME = $(VERDI_HOME)
NOVAS = $(NOVAS_HOME)/share/PLI/VCS/LINUX64
EXTRA += -P $(NOVAS)/novas.tab $(NOVAS)/pli.a
endif
endif

VCS_CXXFLAGS += -std=c++11 -static -Wall ${addprefix -I, ${CSRC_DIR}}
VCS_LDFLAGS  += -lpthread -lSDL2 -ldl -lz -lsqlite3

VCS_VFILES = $(shell find ${DUT_DIR} -name "*.v" -or -name "*.sv")
VCS_CXXFILES = $(shell find ${CSRC_DIR} -name "*.cpp")

VCS_FLAGS += -full64 +v2k -timescale=1ns/1ns -sverilog -debug_access+all +lint=TFIPC-L
# randomize all undefined signals (instead of using X)
VCS_FLAGS += +vcs+initreg+random
VCS_FLAGS += +define+RANDOMIZE_GARBAGE_ASSIGN
VCS_FLAGS += +define+RANDOMIZE_INVALID_ASSIGN
VCS_FLAGS += +define+RANDOMIZE_MEM_INIT
VCS_FLAGS += +define+RANDOMIZE_REG_INIT
# manually set RANDOMIZE_DELAY to avoid VCS from incorrect random initialize
# NOTE: RANDOMIZE_DELAY must NOT be rounded to 0
VCS_FLAGS += +define+RANDOMIZE_DELAY=1
# C++ flags
VCS_FLAGS += -CFLAGS "$(VCS_CXXFLAGS)" -LDFLAGS "$(VCS_LDFLAGS)" -j${THREADS}
# build files put into $(VCS_BUILD_DIR)
VCS_FLAGS += -Mdir=$(VCS_BUILD_DIR)
# top module to simlulate
VCS_FLAGS += -top ${SIM_TOP}
# enable fsdb dump
VCS_FLAGS += $(EXTRA)

default: ${VCS_TARGET}

${VCS_TARGET}: ${SIM_TOP_V} ${VCS_CXXFILES} ${VCS_VFILES}
	vcs ${VCS_FLAGS} ${SIM_TOP_V} ${VCS_CXXFILES} ${VCS_VFILES} | tee ${VCS_BUILD_LOG}

run: ${VCS_TARGET}
	./${VCS_TARGET} +vcs+initreg+0 +dump-wave=fsdb | tee ${SIMV_RUNTIME_LOG}

verdi:
	@echo ${VCS_VFILES} > vfiles.f
	verdi -f vfiles.f ${VCS_TARGET}.fsdb

clean:
	rm -rf simv csrc DVEfiles simv.daidir stack.info.* ucli.key \
			$(VCS_BUILD_DIR) ${SIMV_RUNTIME_LOG} ${VCS_BUILD_LOG} \
			simv.fsdb* novas* vfiles.f verdiLog simv.vdb

