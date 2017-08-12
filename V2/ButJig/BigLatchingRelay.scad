buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// Thermocouple PCB
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  8.3;
pcbPinOffset = 13.96;
pcbPin2Offset = 13.96;
pcbWidth = 31.31; //mm
pcbLength = 99.04;
pcbSupportBarLength = 20;
textLabel = "BL-Relay";

// TODO: Change this for the actual position.
oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 0;  // y axis.
oshLedWidth = 0; 
oshLedDepth = 0; 

showThermocouplePcb = true;
showQuadFetsPcb = false;
showEnvironmentV2Pcb = false;

include <ButJig.scad>;

module buildModel() {
    // Pcb
    cube([31.31,99.04,1.6]);
    
    // Move to the middle of the PCB.
    // Move down slightly to bring the markers though 
    // the 
    translate([31.31/2, 0, -4]) {
        // Mount pin 1
        translate([0,13.96,0]) {
            cylinder(d=3, h=20);
        }
        
        // Mount pin 2
        translate([0, 13.96,0]) {
            cylinder(d=3, h=20);
        }
        
        // Pin 1 marker.
        translate([8.89,8.3,0]) {
            cylinder(d=1, h=10);
        }
        
        // USB Plug
        // Z should be at the bottom of the PCB (1.6mm thick)
        // X is 1/2 width back from center
        // y is 15 back and 5 onto PCB
        translate([-(12/2),-15 + 5,4 - 1.6]) {
            cube([12, 20, 5]);
        }
    }
}