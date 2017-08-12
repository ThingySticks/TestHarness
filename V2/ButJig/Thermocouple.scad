buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// Thermocouple PCB
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  8.26;
pcbPinOffset = 13.91;
pcbPin2Offset = 13.91;
pcbWidth = 33.5; //mm
pcbLength = 95.7;
pcbSupportBarLength = 20;
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
    // Pcb
    cube([33.5,95.7,1.6]);
    
    // Move to the middle of the PCB.
    // Move down slightly to bring the markers though 
    // the 
    translate([33.5/2, 0, -4]) {
        // Mount pin 1
        translate([0,13.91,0]) {
            cylinder(d=3, h=20);
        }
        
        // Mount pin 2
        translate([0, 13.91,0]) {
            cylinder(d=3, h=20);
        }
        
        // Pin 1 marker.
        translate([8.9,8.26,0]) {
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