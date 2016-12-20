// Electron based test harness for the Thermocouple PCB.

// Connect only when required.
SYSTEM_MODE(SEMI_AUTOMATIC);

// D0-D7 map to Photon D0-D7
// A0-A7 map to photon A0-A7

// C0 is C0-C5 option on test board.
int powerRelayPin = C1;
// Serial cable = C2 + C3
// C4 is unused.
int vinRelayPin = C5;


int passLedPin = B0;
int b1LedPin = B1; 
int extB2Pin = B2;
int extB3Pin = B3;
int extB4Pin = B4;
int extB5Pin = B5; // Shared with B0-B5 option on test board


void setup() {
    //RGB.control(true);
    RGB.color(255, 255, 255);
    
    pinMode(powerRelayPin, OUTPUT);
    digitalWrite(powerRelayPin, LOW);
    
    pinMode(vinRelayPin, OUTPUT);
    digitalWrite(vinRelayPin, LOW);
    
    pinMode(passLedPin, OUTPUT);
    digitalWrite(passLedPin, LOW);
    
    pinMode(b1LedPin, OUTPUT);
    digitalWrite(b1LedPin, HIGH);
    
    pinMode(extB2Pin, INPUT_PULLUP);
    pinMode(extB3Pin, INPUT_PULLUP);
    pinMode(extB4Pin, INPUT_PULLUP);
    pinMode(extB5Pin, INPUT_PULLUP);


    pinMode(D7, OUTPUT);
    
    Particle.connect();
    Particle.process();
    delay(2000);
    // Should force a connect.
    Particle.publish("status", "Test Harness online v0.3");

    // Indicate finished with B1 off.
    digitalWrite(b1LedPin, LOW);
}

bool isButtonPressed() {
    // Active low
    int b2Value = !digitalRead(extB2Pin);
    if (b2Value) {
        // Debounce.
        delay(250);
        b2Value = !digitalRead(extB2Pin);
    }
    return  b2Value;
}

int counter;
void loop() {
    if (isButtonPressed()) {
        beginTest();
    }
}

void beginTest() {
    digitalWrite(b1LedPin, HIGH);
    digitalWrite(passLedPin, LOW);
    Particle.publish("status", "Starting Board.T");
    digitalWrite(powerRelayPin, HIGH);
    

    RGB.color(0, 0, 255);
    
    // Do the test.
    bool passed = true;
    delay(2000);

    // OSH LED.	
    digitalWrite(D7, HIGH);
    delay(5000);
    digitalWrite(D7, LOW);

    endTest(passed);
}

void endTest(bool passed) {
    digitalWrite(powerRelayPin, LOW);
    digitalWrite(b1LedPin, LOW);
    if (passed) {
        digitalWrite(passLedPin, HIGH);
        RGB.color(0, 255, 0);
        Particle.publish("status", "BUT Passed");
    } else {
        digitalWrite(passLedPin, LOW);
        RGB.color(255, 0, 0);
        Particle.publish("status", "But Failed!");
    }
}