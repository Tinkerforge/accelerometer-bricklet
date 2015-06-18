<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAccelerometer.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAccelerometer;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'sad'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$acc = new BrickletAccelerometer(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current acceleration
$acceleration = $acc->getAcceleration();

echo "Acceleration(X): " . $acceleration['x']/1000.0 . "G\n";
echo "Acceleration(Y): " . $acceleration['y']/1000.0 . "G\n";
echo "Acceleration(Z): " . $acceleration['z']/1000.0 . "G\n";
echo "\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
