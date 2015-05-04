#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=sad

# get current acceleration
tinkerforge call accelerometer-bricklet $uid get-acceleration
