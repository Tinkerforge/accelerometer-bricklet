#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abc" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_accelerometer import Accelerometer

# Callback function for acceleration callback
# Turn LED on if acceleration goes above 3G
def cb_reached(acc, x, y, z):
    acc.led_on()

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    acc = Accelerometer(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    acc.set_debounce_period(1000)

    # Register threshold reached callback to function cb_reached
    func = lambda x, y, z: cb_reached(acc, x, y, z)
    acc.register_callback(acc.CALLBACK_ACCELERATION_REACHED, func)

    # Configure threshold for acceleration values,
    # Trigger callback if one of the accelerations goes above 3G
    acc.set_acceleration_callback_threshold('>', 3000, 0, 3000, 0, 3000, 0)
    
    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
