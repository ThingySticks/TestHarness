ThingySticks Test Harness
=========================

Particle Electron based test harness to test Photon based ThingyStick sticks.
Most pins of the Photon are taken to the Electron's matching pin (except VIn,  VBatt and RST).
e.g. D7 on Photon board Pogo Pins will connect to D7 on the Electron.

Board Under Test location is intended to be populated with Pogo pins or another connector system to match up with the Board Under Tests photon pads/socket.

Board under Test should not have a photon fitted.


Electron Pinout: https://docs.particle.io/assets/images/electron/illustrations/electron_pinout.pdf

Improvements for V2.1
---------------------

* 10k Pull down resistors for Q1 and Q2 relay drive FETs to prevent them oscilating when not connected.
* Add a button to start the test (e.g. Use C4).
* Add high side current monitor so PCB can be tested for shorts.
* Make use of I2C(2) on the Electrons C4/C5 pins (needs VIn relay to be driven from a different pin - maybe C0 - with a jumper so it can be disabled).
** Use full for current monitor
* B5,4 or 3 to measure voltage at VIn so that the USB power connection can be simulated (low priority).
* Diode on VIn from Electron so we don't try and power the relays and back feed the 5V regulator when running on USB or battery only. 
