#!/usr/bin/env python3 
import sys
import os

os.environ["XILINX_XRT"] = "/usr"
sys.path.append('/usr/local/share/pynq-venv/lib/python3.10/site-packages')


from pynq import Overlay
from pynq import allocate

def compareLists(l1, l2):
   if len(l1) != len(l2):
      return False
   return sorted(l1)==sorted(l2)


def CaptureFramesAndTest(overlay):
  output_buffer    = allocate(shape=(8,),dtype='u4')
  output_buffer[:] = 0
  overlay.axi_dma_0.recvchannel.start()
  overlay.AXIMasterStreamTutor_0.write(0x4,0xDECADE00)
  # Start Transfer then immediately issue stop. When Burst ends the State Machine will stop. 
  overlay.AXIMasterStreamTutor_0.write(0x0,1)
  overlay.AXIMasterStreamTutor_0.write(0x0,0)
  # Capture Last Data Bus 
  overlay.axi_dma_0.recvchannel.transfer(output_buffer)
  goldenBuffer1 = [0xdecade00+x for x in range(1,9)]
  if not (compareLists(output_buffer,goldenBuffer1)):
      print ("Compare 1 FAILED")
      for item in output_buffer:
           print(hex(item))
      for item in goldenBuffer1:
           print(hex(item))
      exit(1); 
  else: 
     print ("PASS 1"); 
   
  output_buffer[:] = 0 
  overlay.AXIMasterStreamTutor_0.write(0x4,0xBEEF0000)
  overlay.AXIMasterStreamTutor_0.write(0x0,1) # Start and set to stop. 
  overlay.AXIMasterStreamTutor_0.write(0x0,0)
  overlay.axi_dma_0.recvchannel.transfer(output_buffer)
  goldenBuffer2 = [0xBEEF0000+x for x in range(1,9)]
  if not (compareLists(output_buffer,goldenBuffer2)):
      print ("Compare 2 FAILED")
      exit(1); 
  else: 
     print ("PASS 2"); 

  overlay.axi_dma_0.recvchannel.stop() 
  

overlay = Overlay("AXIMasterStreamTutorial.bit")
CaptureFramesAndTest(overlay)
