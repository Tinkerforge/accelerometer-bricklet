<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAccelerometer.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAccelerometer;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Accelerometer Bricklet

// Callback function for acceleration callback (parameters have unit g/1000)
function cb_acceleration($x, $y, $z)
{
    echo "Acceleration[X]: " . $x/1000.0 . " g\n";
    echo "Acceleration[Y]: " . $y/1000.0 . " g\n";
    echo "Acceleration[Z]: " . $z/1000.0 . " g\n";
    echo "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$a = new BrickletAccelerometer(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register acceleration callback to function cb_acceleration
$a->registerCallback(BrickletAccelerometer::CALLBACK_ACCELERATION, 'cb_acceleration');

// Set period for acceleration callback to 1s (1000ms)
// Note: The acceleration callback is only called every second
//       if the acceleration has changed since the last call!
$a->setAccelerationCallbackPeriod(1000);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
