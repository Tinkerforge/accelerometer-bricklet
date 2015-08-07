#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_accelerometer import BrickletAccelerometer

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    a = BrickletAccelerometer(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current acceleration (unit is g/1000)
    acceleration = a.get_acceleration()

    print('Acceleration(X): ' + str(acceleration.x/1000.0) + ' g')
    print('Acceleration(Y): ' + str(acceleration.y/1000.0) + ' g')
    print('Acceleration(Z): ' + str(acceleration.z/1000.0) + ' g')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
