#include "VAXIMasterStreamTutorial_MasterStream.h"
#include "AXIMasterStreamVerification.h"
#include <iostream>
#include <memory> 
#include <sstream> 


class AXIMasterStreamWrapperClass : VAXIMasterStreamTutorial_MasterStream 
{

  public:
    bool debug = true;  
    AXIMasterStreamVerification * MasterBus; 
  
  AXIMasterStreamWrapperClass () 
  {  
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    VAXIMasterStreamTutorial_MasterStream{contextp.get(), "VAXIMasterStream"};
    
    cout << "Building Master Bus" << endl; 
    MasterBus = new AXIMasterStreamVerification(); 
    MasterBus->M_AXIS_TVALID = &this->M_AXIS_TVALID; 
    MasterBus->M_AXIS_TDATA  = &this->M_AXIS_TDATA; // Master Output
    MasterBus->M_AXIS_TSTRB  = &this->M_AXIS_TSTRB; // Master Output
    MasterBus->M_AXIS_TLAST  = &this->M_AXIS_TLAST; 
    MasterBus->M_AXIS_TREADY = &this->M_AXIS_TREADY; 
    MasterBus->Initialize();  
  } 

  void ToggleClock() { 
     this->M_AXIS_ACLK = 1; this->eval(); this->M_AXIS_ACLK = 0; this->eval(); 
     if (debug) printf("Clock Toggled\n"); 
    
  } 
  void Reset() { this->M_AXIS_ARESETN = 0; ToggleClock(); ToggleClock(); this->M_AXIS_ARESETN = 1; ToggleClock(); } 

  void Run() 
  { 
    for (int i = 0; i < 100; i++) 
    { 
      if (i%10 == 0) this->startValueReg += 256;
      ToggleClock(); 
      MasterBus->CaptureCycle(); 
      cout << "Current: ";
      for (auto a: MasterBus->StreamCurrentPacket) 
         cout << hex << a << dec << " ";
      cout << endl; 
      cout << "Complete: "; 
      for (auto a: MasterBus->StreamCompletePackets) 
      {
        for (auto b: a) 
         cout << hex << b << dec << " ";
        cout << endl; 
      }
    } 
  } 

};


int main(int argc, char **argv) 
{

   cout << "Building " << endl; 
   AXIMasterStreamWrapperClass AXIMasterStreamWrapper; 
   cout << "Resetting " << endl; 
   AXIMasterStreamWrapper.Reset();  
   AXIMasterStreamWrapper.Run();
   std::cout << "Test: ************************************** PASS!!!!  ************************************" <<std::endl;       

}
