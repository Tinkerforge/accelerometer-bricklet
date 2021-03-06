#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Accelerometer Bricklet

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call accelerometer-bricklet $uid set-debounce-period 10000

# Handle incoming acceleration reached callbacks
tinkerforge dispatch accelerometer-bricklet $uid acceleration-reached &

# Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
tinkerforge call accelerometer-bricklet $uid set-acceleration-callback-threshold threshold-option-greater 2000 0 2000 0 2000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
