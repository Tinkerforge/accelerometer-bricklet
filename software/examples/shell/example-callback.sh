#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Accelerometer Bricklet

# Handle incoming acceleration callbacks
tinkerforge dispatch accelerometer-bricklet $uid acceleration &

# Set period for acceleration callback to 1s (1000ms)
# Note: The acceleration callback is only called every second
#       if the acceleration has changed since the last call!
tinkerforge call accelerometer-bricklet $uid set-acceleration-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
