#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_accelerometer import Accelerometer

# Callback for acceleration threshold reached
def cb_reached(x, y, z):
    print('Acceleration(X): ' + str(x/1000.0) + ' g')
    print('Acceleration(Y): ' + str(y/1000.0) + ' g')
    print('Acceleration(Z): ' + str(z/1000.0) + ' g')
    print('')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    a = Accelerometer(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    a.set_debounce_period(1000)

    # Register threshold reached callback to function cb_reached
    a.register_callback(a.CALLBACK_ACCELERATION_REACHED, cb_reached)

    # Configure threshold for acceleration values X, Y or Z "greater than 2g" (unit is g/1000)
    a.set_acceleration_callback_threshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
