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
        // Set Period for acceleration callback to 1s (1000ms)
        // Note: The callback is only called every second if the
        // acceleration has changed since the last call!
        acc.setAccelerationCallbackPeriod(1000);
    }
);

// Register temperature callback
acc.on(Tinkerforge.BrickletAccelerometer.CALLBACK_ACCELERATION,
    // Callback function for acceleration callback
    function(x, y, z) {
        console.log('Acceleration(X): ' + x/1000.0 + 'G');
        console.log('Acceleration(Y): ' + y/1000.0 + 'G');
        console.log('Acceleration(Z): ' + z/1000.0 + 'G');
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

