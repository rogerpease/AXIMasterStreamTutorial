#!/usr/bin/env python3 
import os 

MYPYNQBOARD="xilinx@10.0.0.151"
PROJECTNAME="AXIMasterStreamTutorial"



os.system("ssh "+MYPYNQBOARD+" mkdir /home/xilinx/AXIMasterStreamTutorial")
os.system("scp ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hw_handoff/FPGABlockDesign.hwh "+MYPYNQBOARD+":/home/xilinx/"+PROJECTNAME+"/"+PROJECTNAME+".hwh")
os.system("scp ./FPGAImageProject/FPGAImageProject.runs/impl_1/FPGABlockDesign_wrapper.bit "+MYPYNQBOARD+":/home/xilinx/"+PROJECTNAME+"/"+PROJECTNAME+".bit")
os.system("scp RecvStream.py  "+MYPYNQBOARD+":/home/xilinx/"+PROJECTNAME+"/RecvStream.py")
