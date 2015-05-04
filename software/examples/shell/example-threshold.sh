#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=sad

# get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call accelerometer-bricklet $uid set-debounce-period 10000

# Configure threshold for acceleration values X, Y or Z greater than 2G
tinkerforge call accelerometer-bricklet $uid set-acceleration-callback-threshold greater 2000 0 2000 0 2000 0

# handle incoming acceleration-reached callbacks
tinkerforge dispatch accelerometer-bricklet $uid acceleration-reached\
 --execute "echo 'Acceleration(X): {x}';
            echo 'Acceleration(Y): {y}';
            echo 'Acceleration(Z): {z}';
            echo '';"
