<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAccelerometer.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAccelerometer;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'sad'; // Change to your UID

// Callback for acceleration threshold reached
function cb_reached($x, $y, $z)
{
    echo "Acceleration(X): " . $x/1000.0 ."\n";
    echo "Acceleration(Y): " . $y/1000.0 ."\n";
    echo "Acceleration(Z): " . $z/1000.0 ."\n";
    echo "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$acc = new BrickletAccelerometer(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$acc->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$acc->registerCallback(BrickletAccelerometer::CALLBACK_ACCELERATION_REACHED, 'cb_reached');

// Configure threshold for acceleration values X, Y or Z greater than 2G
$acc->setAccelerationCallbackThreshold('>', 2000, 0, 2000, 0, 2000, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
