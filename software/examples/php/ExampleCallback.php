<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAccelerometer.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAccelerometer;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'sad'; // Change to your UID

// Callback function for acceleration
function cb_acceleration($x, $y, $z)
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

// Set Period for acceleration callback to 1s (1000ms)
// Note: The callback is only called every second if the 
//       acceleration has changed since the last call!
$acc->setAccelerationCallbackPeriod(1000);

// Register acceleration callback to function cb_acceleration
$acc->registerCallback(BrickletAccelerometer::CALLBACK_ACCELERATION, 'cb_acceleration');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
