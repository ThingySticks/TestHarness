    
 $fn=80;
cubeWidth = 60;
cubeLength = 68;
bodyHeight = 18;

// Test Fixture properties.
// How far infront of Pin1 the mounting hole is.
pin1ToMountingHoleDistance = 5.25;

// Board under test properties.
pin1ToPcbEdge =  9; //8.5; //mm from front edge.
pcbWidth = 34.5; //mm
pcbLength = 96;

// block mounting hole is holesYOffset mm from the front edge.
module thermocouplePcbCutout(holesYOffset) {

    
// The position of pin one on the test fixture
pin1Position = holesYOffset - pin1ToMountingHoleDistance;    
frontEdgePosition = pin1Position - pin1ToPcbEdge;
xOffset = (cubeWidth - pcbWidth)/2;

echo (frontEdgePosition);
zOffset = 14;
    
    translate([xOffset, frontEdgePosition, zOffset]) {
        cube([pcbWidth, pcbLength, 20]);
    }
}

// block mounting hole is holesYOffset mm from the front edge.
module thermocouplePin(holesYOffset) {
offset = 14.4; // mm from front edge.
    
pin1Position = holesYOffset - pin1ToMountingHoleDistance;    
pin1ToPcbEdge =   9; //mm from front edge.
frontEdgePosition = pin1Position - pin1ToPcbEdge;
    
xOffset = (cubeWidth /2);
yOffset = frontEdgePosition + offset;
echo (yOffset);
    
    translate([xOffset, yOffset, 14]) {
        cylinder(d1=3.0, d2=2.8, h=10);
    }
}

module pogoPinsCutout() {
    cube([25, 50, 20]);
}

module mountHole(x,y) {
nutHoleDiameter = 7;
    translate([x,y,0]) {
        #cylinder(d=nutHoleDiameter, h=4);
        translate([0,0,4]) {
            #cylinder(d1=nutHoleDiameter,d2=3.2, h=6);
            translate([0,0,6]) {
                #cylinder(d=3.2, h=bodyHeight - (6+4));
            }
        }
        
        translate([0,0,bodyHeight - 4]) {
            #cylinder(d=nutHoleDiameter, h=4 + 0.3);
        }
    }
}

module mountHoles() {
    // Across = 47mm.
    // Down = 46mm.
    
    mountHole(0,0);
    mountHole(47,0);
    mountHole(0,46);
    mountHole(47,46);
}



module body() {

// holes are 47mm across.
// 60 - 47 = 13 
// 13/2 = 6.5
holesXOffset = (60-47) / 2;
holesYOffset = 16; // 16mm gap between ext test input and top hole.

    
// Pin 1 is 5.25mm from 
    
    difference() {
        union() {
            cube([cubeWidth, cubeLength, bodyHeight]);
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
            
            thermocouplePcbCutout(holesYOffset);
        }
    }
    
    
    // Fill in the middle bit to allow for a support pin
    translate([(cubeWidth / 2) -4, 0, 0]) {
        cube([8, 20, 14]);
    }
    
    translate(0,0,14) {
        thermocouplePin(holesYOffset);
    }
}



body();

mountHole(0,0);