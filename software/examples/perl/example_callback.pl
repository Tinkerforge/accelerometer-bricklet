#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'sad'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $acc = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

# Callback function for acceleration callback (parameters have unit g/1000)
sub cb_acceleration
{
    my ($x, $y, $z) = @_;

    print "Acceleration(X): " . $x/1000.0 . " g\n";
    print "Acceleration(Y): " . $y/1000.0 . " g\n";
    print "Acceleration(Z): " . $z/1000.0 . " g\n";
    print "\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for acceleration callback to 1s (1000ms)
# Note: The callback is only called every second if the 
#       acceleration has changed since the last call!
$acc->set_acceleration_callback_period(1000);

# Register acceleration callback to function cb_acceleration
$acc->register_callback($acc->CALLBACK_ACCELERATION, 'cb_acceleration');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
