buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// Environment V2
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  8.57;
pcbPinOffset = 12.00;
pcbPin2Offset = 52.00;
pcbWidth = 32; // 31.75; //mm on X Axis.
pcbLength = 90; // on Y Axis.
// Lenfth of the middle bar with the pins on
pcbSupportBarLength = 55;
textLabel = "Current";

oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 11;  // y axis.
oshLedWidth = 7; 
oshLedDepth = 0; 

include <ButJig.scad>;


module buildModel() {
    // Pcb
    // Don't use variables above as they may need to be 
    // fudged to give suitable tollerances.
    cube([32,90,1.6]);
    
    // Move to the middle of the PCB.
    // Move down slightly to bring the markers though 
    // the 
    translate([32/2, 0,-4]) {
        // First mounting hole
        translate([0,12,0]) {
            cylinder(d=3, h=20);
        }
        
        // Second mounting hole
        translate([0, 12+40,0]) {
            cylinder(d=3, h=20);
        }
        
        // Pin 1 marker.
        translate([7,8.57,0]) {
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