#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_accelerometer'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'sad' # Change to your UID

ipcon = IPConnection.new # Create IP connection
acc = BrickletAccelerometer.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current acceleration (returned as array [x, y, z]) (unit is g/1000)
acceleration = acc.get_acceleration
puts "Acceleration(X): #{acceleration[0]/1000.0} g"
puts "Acceleration(Y): #{acceleration[1]/1000.0} g"
puts "Acceleration(Z): #{acceleration[2]/1000.0} g"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
