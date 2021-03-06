buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// QUAD N-Channel FETs PCB
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  8.49;
pcbPinOffset = 14.5;
pcbPin2Offset = 14.5;
pcbWidth = 40; //mm on X Axis.
pcbLength = 99; // on Y Axis.
pcbSupportBarLength = 20;
textLabel = "N-FETs";

oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 11;  // y axis.
oshLedWidth = 7; 
oshLedDepth = 2; 

include <ButJig.scad>;


module buildModel() {
    // Pcb
    cube([40,99,1.6]);
    
    // Move to the middle of the PCB.
    // Move down slightly to bring the markers though 
    // the 
    translate([40/2, 0, -4]) {
        // First mounting pin
        translate([0, 14.5, 0]) {
            cylinder(d=3, h=20);
        }
        
        // No second pin
        
        // Pin 1 marker.
        translate([9.19,8.49,0]) {
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