#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abc" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_accelerometer import Accelerometer

# Callback function for acceleration callback
def cb_acceleration(x, y, z):
    print('Acceleration: x -> {0}G, y -> {1}G, z -> {2}G'.format(x / 1000.0, 
                                                                 y / 1000.0, 
                                                                 z / 1000.0))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    acc = Accelerometer(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected
    
    # Set Period for acceleration callback to 0.1s (100ms)
    # Note: The callback is only called every second if the 
    #       acceleration has changed since the last call!
    acc.set_acceleration_callback_period(100)

    # Register acceleration callback to function cb_acceleration
    acc.register_callback(acc.CALLBACK_ACCELERATION, cb_acceleration)
    
    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
