#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'sad'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $acc = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current acceleration
my ($x, $y, $z) = $acc->get_acceleration();

print "Acceleration(X): " . $x/1000.0 . "G\n";
print "Acceleration(Y): " . $y/1000.0 . "G\n";
print "Acceleration(Z): " . $z/1000.0 . "G\n";
print "\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
