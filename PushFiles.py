#!/usr/bin/env python3 
import os 

MYPYNQBOARD="xilinx@192.168.1.128"



os.system("ssh "+MYPYNQBOARD+" mkdir /home/xilinx/AXIMasterStreamTutorial")
os.system("scp ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hw_handoff/FPGABlockDesign.hwh "+MYPYNQBOARD+":/home/xilinx/AXIMasterStreamTutorial/AXIMasterStreamTutorial.hwh")
os.system("scp ./FPGAImageProject/FPGAImageProject.runs/impl_1/FPGABlockDesign_wrapper.bit "+MYPYNQBOARD+":/home/xilinx/AXIMasterStreamTutorial/AXIMasterStreamTutorial.bit")
os.system("scp RecvStream.py  "+MYPYNQBOARD+":/home/xilinx/AXIMasterStreamTutorial/RecvStream.py")
