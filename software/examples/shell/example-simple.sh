#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current acceleration (unit is g/1000)
tinkerforge call accelerometer-bricklet $uid get-acceleration
