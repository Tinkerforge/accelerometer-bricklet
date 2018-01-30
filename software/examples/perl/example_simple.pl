#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Accelerometer Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $a = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current acceleration
my ($x, $y, $z) = $a->get_acceleration();

print "Acceleration [X]: " . $x/1000.0 . " g\n";
print "Acceleration [Y]: " . $y/1000.0 . " g\n";
print "Acceleration [Z]: " . $z/1000.0 . " g\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
