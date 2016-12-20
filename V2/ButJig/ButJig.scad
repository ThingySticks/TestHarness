    
 $fn=80;
cubeWidth = 60;
cubeLength = 64;

// Test Fixture properties.
// How far infront of Pin1 the mounting hole is.
pin1ToMountingHoleDistance = 5.25;

// Board under test properties.
pin1ToPcbEdge =  8.5; //mm from front edge.
pcbWidth = 35; //mm
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
pin1ToPcbEdge =   8.5; //mm from front edge.
frontEdgePosition = pin1Position - pin1ToPcbEdge;
    
xOffset = (cubeWidth /2);
yOffset = frontEdgePosition + offset;
echo (yOffset);
    
    translate([xOffset, yOffset, 0]) {
        cylinder(d1=3.2, d2=2.4, h=25);
    }
}

module pogoPinsCutout() {
    cube([25, 50, 20]);
}

module mountHoles() {
    // Across = 47mm.
    // Down = 46mm.
    
    translate([0,0,0]) {
        #cylinder(d=4, h=30);
    }
    
    translate([47,0,0]) {
        #cylinder(d=4, h=30);
    }
    
    translate([0,46,0]) {
        #cylinder(d=4, h=30);
    }
    
    translate([47,46,0]) {
        #cylinder(d=4, h=30);
    }
    
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
            cube([cubeWidth, cubeLength, 18]);
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
    translate([(cubeWidth / 2) -5, 0, 0]) {
        cube([10, cubeLength, 10]);
    }
    
    thermocouplePin(holesYOffset);
}



body();