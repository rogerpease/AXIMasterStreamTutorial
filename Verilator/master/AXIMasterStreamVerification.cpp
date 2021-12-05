#include <vector> 
#include <iostream> 
#include "AXIMasterStreamVerification.h" 
using namespace std; 


AXIMasterStreamVerification::AXIMasterStreamVerification()
{ 
   cycleCount = 0; 
   treadyDropPeriod = 7; 
}   

void AXIMasterStreamVerification::Initialize()
{
   *(this->M_AXIS_TREADY) = 1; // Can't do this before because we've not assigned. 
}
   
void AXIMasterStreamVerification::CaptureCycle()
{
  if (*(this->M_AXIS_TVALID) && *(this->M_AXIS_TREADY))
  { 
     unsigned long int data = *(this->M_AXIS_TDATA); 
     StreamCurrentPacket.push_back(data); 
     if (DEBUG) cout << hex << data << dec << endl; 
     if (*(this->M_AXIS_TLAST))
     {
       StreamCompletePackets.push_back(StreamCurrentPacket); 
       StreamCurrentPacket.clear(); 
     } 
   } 
   else
   {
      if (DEBUG) cout << "TValid " << ((*(this->M_AXIS_TVALID) == 1) ? '1' : '0') << "  TREADY " << ((*(this->M_AXIS_TREADY) == 1) ? '1' : '0') << endl; 
   } 
  
   // Drop TREADY every N treadyDropPeriod cycles (unless TREADY set to 0).
   *(this->M_AXIS_TREADY) = (treadyDropPeriod == 0) ? 1 : (cycleCount % treadyDropPeriod == 0) ? 0 : 1; 
   cycleCount ++; 
}  

void AXIMasterStreamVerification::ReportPipeStatus(ostringstream & ostream)
{
     ostream << "Current: ";
     for (auto a: this->StreamCurrentPacket)
        ostream << hex << a << dec << " ";
     ostream << endl;
     ostream << "Complete: ";
     for (auto a: this->StreamCompletePackets)
     {
       for (auto b: a)
         ostream << hex << b << dec << " ";
       ostream << endl;
     }

}
