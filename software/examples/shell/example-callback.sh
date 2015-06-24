#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=sad

# set period for acceleration callback to 1s (1000ms)
# note: the acceleration callback is only called every second if the
#       acceleration has changed since the last call!
tinkerforge call accelerometer-bricklet $uid set-acceleration-callback-period 1000

# handle incoming acceleration callbacks (unit is g/1000)
tinkerforge dispatch accelerometer-bricklet $uid acceleration
