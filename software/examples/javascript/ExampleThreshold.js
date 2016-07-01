var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Accelerometer Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var a = new Tinkerforge.BrickletAccelerometer(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        a.setDebouncePeriod(10000);

        // Configure threshold for acceleration "greater than 2 g, 2 g, 2 g" (unit is g/1000)
        a.setAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);
    }
);

// Register acceleration reached callback
a.on(Tinkerforge.BrickletAccelerometer.CALLBACK_ACCELERATION_REACHED,
    // Callback function for acceleration reached callback (parameters have unit g/1000)
    function (x, y, z) {
        console.log('Acceleration[X]: ' + x/1000.0 + ' g');
        console.log('Acceleration[Y]: ' + y/1000.0 + ' g');
        console.log('Acceleration[Z]: ' + z/1000.0 + ' g');
        console.log();
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
