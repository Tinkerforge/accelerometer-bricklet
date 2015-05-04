#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'sad'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $acc = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

# Callback function for acceleration callback
sub cb_reached
{
    my ($x, $y, $z) = @_;

    print "Acceleration(X): " . $x/1000.0 . "G\n";
    print "Acceleration(Y): " . $y/1000.0 . "G\n";
    print "Acceleration(Z): " . $z/1000.0 . "G\n";
    print "\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$acc->set_debounce_period(10000);

# Register threshold reached callback to function cb_reached
$acc->register_callback($acc->CALLBACK_ACCELERATION_REACHED, 'cb_reached');

# Configure threshold for acceleration values X, Y or Z greater than 2G
$acc->set_acceleration_callback_threshold('>', 2000, 0, 2000, 0, 2000, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
