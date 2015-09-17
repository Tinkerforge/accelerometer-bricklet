#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAccelerometer;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

# Callback subroutine for acceleration callback (parameters have unit g/1000)
sub cb_acceleration
{
    my ($x, $y, $z) = @_;

    print "Acceleration[X]: " . $x/1000.0 . " g\n";
    print "Acceleration[Y]: " . $y/1000.0 . " g\n";
    print "Acceleration[Z]: " . $z/1000.0 . " g\n";
    print "\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $a = Tinkerforge::BrickletAccelerometer->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register acceleration callback to subroutine cb_acceleration
$a->register_callback($a->CALLBACK_ACCELERATION, 'cb_acceleration');

# Set period for acceleration callback to 1s (1000ms)
# Note: The acceleration callback is only called every second
#       if the acceleration has changed since the last call!
$a->set_acceleration_callback_period(1000);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
