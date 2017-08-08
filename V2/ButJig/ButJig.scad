// Base class for all the test jigs

// Critical measurements:
// Top left mount hole (with DUT vertical) is key alignment hole.
// Pin 1 X Offset from key hole = 14.78mm
// Pin 1 Y offset from key hole = 5.25mm (towards 0)
 
$fn=80;
cubeWidth = 60;
// Max length to make the cube.
// PCB may go past the end of it.
cubeLength = 68; //68;
bodyHeight = 18;


// FIXED (due to Pogo pins height).
// PCB needs to be at 13.5mm high for the pogo pins to make best contact.
pcbZPosition = 13.8;

bodyHeight = 15.1; // pcbZPosition + 1.6; // PCB depth


// Fixed. the Y distance from pin 1 Pogo pin to the first 
// mounting hole for the jig.
// How far infront of Pin1 the mounting hole is.
// Thsi should never change (pin 1 and mounting block hole never move).
// How far infront of Pin1 the mounting hole is.
pin1ToMountingHoleDistance =  5.25;

usbPlugWidth = 15;

// Mounting holes for us are 47mm across.
// 60 - 47 = 13 
// 13/2 = 6.5
holesXOffset = (60-47) / 2;
// How far down the block the mounting holes for the block are.
// 16mm is about the maximum that can be used without modifying the mounting block.
holesYOffset = 16; // 16mm gap between ext test input and top hole.

// The position of pin one on the test fixture
// this is constant
pin1Position = holesYOffset - pin1ToMountingHoleDistance;  

////////////////////////////////////////////////////////////////////
// Test Fixture properties.
// Board specific
////////////////////////////////////////////////////////////////////
// Will be in subclass file

/////////////////////////////////////////////////////////////////////
// Position of the PCB front edge
// Computed from the specified distance of pin 1 to the pcb edge.
frontEdgePosition = pin1Position - pin1ToPcbEdge;
echo ("frontEdgePosition:", frontEdgePosition);

/////////////////////////////////////////////////////////////////////

// Cut out for the 3v3 resistor on the test rig PCB
module boardResistorCutout() {
    cube([4,4,2]);
}

// block mounting hole is holesYOffset mm from the front edge.
module pcbCutout() {
        
// Work back from the computed Pin 1 Position to find where the 
// edge of the PCB should be.
xOffset = (cubeWidth - pcbWidth)/2;

    // add 2mm tollerance to the front/rear position of the PCB
    // as the finish may be rough and mounting pins are the most critical
    translate([xOffset, frontEdgePosition -1 , pcbZPosition]) {
        cube([pcbWidth, pcbLength + 2, bodyHeight - pcbZPosition + 0.01]);
    }
    
    // OSH LED on Thermocouple PCB
    translate([xOffset + oshLedXCutout, 
    frontEdgePosition + oshLedYCutout, 
    pcbZPosition-oshLedDepth]) {
        cube([oshLedWidth, oshLedLength, oshLedDepth+0.1]);
    }
    
    // Cutout at the end
    leftCutout = (cubeWidth - 25)/2;
    translate([leftCutout, 55, pcbZPosition -4]) {
        cube([25, cubeLength-55+0.1, 4.1]);
    }
}

// block mounting hole is holesYOffset mm from the front edge.
module pcbPin(offset) {
    
xOffset = (cubeWidth /2);
yPosition = frontEdgePosition + offset;
    
echo ("Offset:", offset);
echo ("yPosition:",yPosition);
echo ("pcbZPosition:",pcbZPosition);
    
    translate([xOffset, yPosition, pcbZPosition]) {
        cylinder(d1=2.8, d2=2.4, h=4);
    }
}

// Cut out a section to allow for a USB plug to have
// been soldered to the PCB.
module usbConnectorCutout() {
    
echo("USB pcbPinOffset: ", pcbPinOffset);
pinPosition = frontEdgePosition + pcbPinOffset;
    
    translate([(cubeWidth - usbPlugWidth)/2, 0, pcbZPosition-4]) {
        // Go most of the way to the first PCB pin.
        #cube([usbPlugWidth, pinPosition -2, 8]);
    }
}

module pogoPinsCutout() {
    cube([25, 50, 20]);
}

module mountHole(x,y, nutUnder, nutOnTop, holeDiameter) {
nutHoleDiameter = 7;
    translate([x,y,0]) {
        
        // Hollow out the main screw thread all the way up.
        translate([0,0,-0.1]) {
            cylinder(d=holeDiameter, h=bodyHeight+2);
        }
            
        // If their is a nut underneath this (i.e. screw fixed to PCB)
        if (nutUnder) {
            cylinder(d=nutHoleDiameter, h=4);
        
            translate([0,0,4]) {
                #cylinder(d1=nutHoleDiameter,d2=holeDiameter, h=10);
            }
        }
        
        if (nutOnTop) {
            translate([0,0,bodyHeight - 4]) {
                // Make it hex to hold the nut
                cylinder(d=7, h=4 + 0.3, $fn=6);
            }
        }
    }
}

module mountHoles() {
    // Across = 47mm.
    // Down = 46mm.
    
holeDiameter = 3.6;
    
    
    mountHole(0,0, true, false, holeDiameter);
    // This pin is key pin with 0 offset all around?
    mountHole(47,0, true, false, holeDiameter);
    mountHole(0,46, false, true, holeDiameter);
    mountHole(47,46, false, true, holeDiameter);
}


module addText(zPosition, height) {
    translate([8,18,zPosition]) {
        rotate([0,0,90]) {
            linear_extrude(h=height) {
                #text(textLabel, size=7);
            }
        }
    }
}

module mainBody(holesXOffset) {
    difference() {
        union() {
            color("blue") {
                cube([cubeWidth, cubeLength, bodyHeight]);
            }
        }
        union() {
            // Move 5 + (4/2) mm down for the hole.
            translate([holesXOffset,holesYOffset,-0.1]) {
                mountHoles();
            }
            
            // 14mm wide. so 7mm back from center.
            translate([30-(25/2),holesYOffset - 7,-0.1]) {
                pogoPinsCutout();
            }
            
            pcbCutout(holesYOffset);
            
            // 0,0 position their is a resistor on the main
            // PCB (for 3v3 LED), need to nibble out a little from that corner
            // to prevent it clashing
            boardResistorCutout();
            
            addText(bodyHeight-1, 1);            
        }
    }
}

module body() {
   
// Pin 1 is 5.25mm from (top hole?) - smaller y.
    // pin1ToMountingHoleDistance
    
    // show pin 1
    translate([47 + holesXOffset - 14.78 ,holesYOffset  - pin1ToMountingHoleDistance,0]) {
       // cylinder(d=1, h=15);
    }
    
    
    difference() {
        union() {
            mainBody(holesXOffset);
            // Fill in the middle bit to allow for a support pin
            translate([(cubeWidth / 2) -4, 0, 0]) {
                color("green") {
                    cube([8, pcbSupportBarLength, pcbZPosition]);
                }
            }
        } 
        union() {
            usbConnectorCutout();
        }
    }
    
    // Add a vertical pin to locate the PCB onto the jig.
    pcbPin(pcbPinOffset);
    // Some boards have a second pin.
    pcbPin(pcbPin2Offset);
    
    translate([0,0,0]) {
        // pin1Marker();
    }
}

module pressDownTool() {
    
height = 13; // Should just cover full height of the bolts
holesXOffset = (60-47) / 2;
// How far down the block the mounting holes for the block are.
// 16mm is about the maximum that can be used without modifying the mounting block.
holesYOffset = 16; // 16mm gap between ext test input and top hole.
holeDiameter = 4.2; // larger than the base
    
    difference() {
        union() {
            color("pink") {
                cube([cubeWidth, cubeLength, height]);
            }
        }
        union() {
            addText(height-1, 1);
            
            translate([holesXOffset,holesYOffset,-0.1]) {
                    mountHole(0,0, false, false, holeDiameter);
                    // This pin is key pin with 0 offset all around?
                    mountHole(47,0, false, false, holeDiameter);
                    mountHole(0,46, false, false, holeDiameter);
                    mountHole(47,46, false, false, holeDiameter);
            }
            
            // Cut out the entire inside for pcb - 5mm (2.5mm either size)
            
             
            // The position of pin one on the test fixture
            // this is constant
            pin1Position = holesYOffset - pin1ToMountingHoleDistance;    

            // Work back from the computed Pin 1 Position to find where the 
            // edge of the PCB should be.
            frontEdgePosition = pin1Position - pin1ToPcbEdge;
            xOffset = (cubeWidth - pcbWidth)/2;

            // PCB Cutout
            // add 2mm tollerance to the front/rear position of the PCB
            // as the finish may be rough and mounting pins are the most critical
            translate([xOffset+2.5, frontEdgePosition -2 ,- 0.1]) {
                cube([pcbWidth-5, pcbLength + 4, 4 + 0.2]);
            }
            
            // Bulk cutout.
            // Cut out more material to make printing faster
            // Ensure we have a bit at the front to keep the two together
            cutoutWidth = min(pcbWidth+4,42.5);
            translate([(cubeWidth-cutoutWidth)/2, 6 ,4]) {
                #cube([cutoutWidth, pcbLength + 4, height + 0.2]);
            }

            // Chop out a bit for the USB plug.

            translate([(cubeWidth - usbPlugWidth)/2, -5, 0]) {
                cube([usbPlugWidth, 8+5, 4]);
            }
                
        }
    }   
}

// The lower section
if (buildBase) {
    body();
}

if (buildPushDown) {
    //translate([0,0,20]) { // Debug
    translate([cubeWidth+5,0,0]) { // Export
            // block to help press down the PCB onto the Pogo pins
            // without touching the PCB by hand.
            pressDownTool();
    }
}

if (showModels) {
    // Test harness Pin 1 is .... mm in.
    translate([0,pin1ToMountingHoleDistance,0]) {
        // PCB.
        // Pin 1 is 3.81mm from front edge of the PCU (which is 0 
        // interms of the model)
        // 2mm off.......
        translate([(cubeWidth-31.75)/2,3.81-2,pcbZPosition]) {
    
            // Expected to exist in super class.
            %buildModel();
        }
    }
}

