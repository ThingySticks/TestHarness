buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// Thermocouple PCB
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  9; //8.5; //mm from front edge.
pcbPinOffset = 14.4;
pcbPin2Offset = 14.4;
pcbWidth = 34.5; //mm
pcbLength = 96;
pcbSupportBarLength = 53;
textLabel = "Thermo";

// TODO: Change this for the actual position.
oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 11;  // y axis.
oshLedWidth = 7; 
oshLedDepth = 2; 

showThermocouplePcb = true;
showQuadFetsPcb = false;
showEnvironmentV2Pcb = false;

include <ButJig.scad>;

module buildModel() {
    // TODO: Model the PCB
}