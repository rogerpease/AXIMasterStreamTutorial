#!/bin/sh 

set -e 
verilator ../../Verilog/module/AXIMasterStreamTutorial_MasterStream.v --cc  --exe TestModule.cpp AXIMasterStreamVerification.cpp --build
./obj_dir/VAXIMasterStreamTutorial_MasterStream
exit 0
