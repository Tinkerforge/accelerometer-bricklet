<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAccelerometer.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAccelerometer;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Accelerometer Bricklet

// Callback function for acceleration reached callback
function cb_accelerationReached($x, $y, $z)
{
    echo "Acceleration [X]: " . $x/1000.0 . " g\n";
    echo "Acceleration [Y]: " . $y/1000.0 . " g\n";
    echo "Acceleration [Z]: " . $z/1000.0 . " g\n";
    echo "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$a = new BrickletAccelerometer(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$a->setDebouncePeriod(10000);

// Register acceleration reached callback to function cb_accelerationReached
$a->registerCallback(BrickletAccelerometer::CALLBACK_ACCELERATION_REACHED,
                     'cb_accelerationReached');

// Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
$a->setAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
