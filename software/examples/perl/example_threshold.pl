#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Accelerometer Bricklet

# Callback subroutine for acceleration reached callback
sub cb_acceleration_reached
{
    my ($x, $y, $z) = @_;

    print "Acceleration [X]: " . $x/1000.0 . " g\n";
    print "Acceleration [Y]: " . $y/1000.0 . " g\n";
    print "Acceleration [Z]: " . $z/1000.0 . " g\n";
    print "\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $a = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$a->set_debounce_period(10000);

# Register acceleration reached callback to subroutine cb_acceleration_reached
$a->register_callback($a->CALLBACK_ACCELERATION_REACHED, 'cb_acceleration_reached');

# Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
$a->set_acceleration_callback_threshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
