#!/usr/bin/env python3 

#
# NOTE: This script is my own, but most of the verilog code is from auto-generated from an AXI Peripheral TB which I adapted to my needs. 
# NOTE: Normally I'd do this with a makefile but this is more for notes/education purposes so drawing out the steps makes more sense. 
#
# Quick script to capture how to compile verilog for simulation on the command line with Vivado. 
#
#

import os
import subprocess 
os.environ["LD_LIBRARY_PATH"] = "/tools/Xilinx/.xinstall/Vivado_2022.1/lib/lnx64.o:/tools/Xilinx/Vivado/2022.1/lib/lnx64.o:/tools/Xilinx/.xinstall/Vivado_2022.1/lib/lnx64.o/SuSE/"

VIVADO_BIN="/tools/Xilinx/Vivado/2022.1/bin"

def Run(commandString):
  print("Running: "," ".join(commandString))
  result = subprocess.Popen(commandString)
  text = result.communicate()[0]
  return_code = result.returncode
  print("Returning ",return_code)
  if (return_code != 0):
    exit(1)


Run([VIVADO_BIN+"/vivado","-mode","batch","-source","scripts/packageip.tcl"]) 
