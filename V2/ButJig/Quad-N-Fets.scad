buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// QUAD N-Channel FETs PCB
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  10; //8.95mm from front edge.
pcbPinOffset = 14.4;
pcbPin2Offset = 14.4;
pcbWidth = 42; //mm on X Axis.
pcbLength = 99; // on Y Axis.
pcbSupportBarLength = 53;
textLabel = "N-FETs";

oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 11;  // y axis.
oshLedWidth = 7; 
oshLedDepth = 2; 

include <ButJig.scad>;


module buildModel() {
    // TODO
}