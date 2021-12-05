#!/bin/sh 

verilator ../../Verilog/module/AXIMasterStreamTutorial_MasterStream.v --cc  --exe TestModule.cpp AXIMasterStreamVerification.cpp --build

