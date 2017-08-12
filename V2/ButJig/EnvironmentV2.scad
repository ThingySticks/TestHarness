buildBase = true;
buildPushDown = true;
showModels = true;

////////////////////////////////////////////////////////////////////
// Environment V2
// -----------------------------------------------------------------
// Device under test properties.
pin1ToPcbEdge =  3.8;
pcbPinOffset = 13.97;
pcbPin2Offset = 46.36;
pcbWidth = 31.75; //mm on X Axis.
pcbLength = 98.98; // on Y Axis.
// Lenfth of the middle bar with the pins on
pcbSupportBarLength = 55;
textLabel = "Env. V2";

oshLedXCutout = 0;
oshLedYCutout = 0; 
oshLedLength = 11;  // y axis.
oshLedWidth = 7; 
oshLedDepth = 0; 

include <ButJig.scad>;


module buildModel() {
    // Pcb
    cube([31.75,94,1.6]);
    
    // Move to the middle of the PCB.
    // Move down slightly to bring the markers though 
    // the 
    translate([31.75/2, 0, -4]) {
    //translate([31.75/2,0,-4]) {
        translate([0,13.97,0]) {
            cylinder(d=3, h=20);
        }
        
        translate([0, 13.97+32.39,0]) {
            cylinder(d=3, h=20);
        }
        
        // Pin 1 marker.
        translate([8.89,3.81,0]) {
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