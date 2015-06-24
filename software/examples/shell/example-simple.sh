#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=sad

# get current acceleration (unit is g/1000)
tinkerforge call accelerometer-bricklet $uid get-acceleration
