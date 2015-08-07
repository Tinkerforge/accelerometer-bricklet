#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_accelerometer import BrickletAccelerometer

# Callback function for acceleration callback (parameters have unit g/1000)
def cb_acceleration(x, y, z):
    print('Acceleration(X): ' + str(x/1000.0) + ' g')
    print('Acceleration(Y): ' + str(y/1000.0) + ' g')
    print('Acceleration(Z): ' + str(z/1000.0) + ' g')
    print('')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    a = BrickletAccelerometer(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected
    
    # Set Period for acceleration callback to 0.1s (100ms)
    # Note: The callback is only called every second if the 
    #       acceleration has changed since the last call!
    a.set_acceleration_callback_period(100)

    # Register acceleration callback to function cb_acceleration
    a.register_callback(a.CALLBACK_ACCELERATION, cb_acceleration)
    
    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
