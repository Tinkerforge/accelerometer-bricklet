var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'sad'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var acc = new Tinkerforge.BrickletAccelerometer(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set threshold callbacks with a debounce time of 10 seconds (10000ms)
        acc.setDebouncePeriod(10000);
        // Configure threshold for acceleration values X, Y or Z "greater than 2g" (unit is g/1000)
        acc.setAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);
    }
);

// Register threshold reached callback
acc.on(Tinkerforge.BrickletAccelerometer.CALLBACK_ACCELERATION_REACHED,
    // Callback for acceleration threshold reached
    function(x, y, z) {
        console.log('Acceleration(X): ' + x/1000.0 + ' g');
        console.log('Acceleration(Y): ' + y/1000.0 + ' g');
        console.log('Acceleration(Z): ' + z/1000.0 + ' g');
        console.log();
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

