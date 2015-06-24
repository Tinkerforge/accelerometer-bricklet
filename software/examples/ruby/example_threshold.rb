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

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
acc.set_debounce_period 10000

# Register callback for acceleration reached threshold
acc.register_callback(BrickletAccelerometer::CALLBACK_ACCELERATION_REACHED) do |x, y, z|
  puts "Acceleration(X): #{x/1000.0} g"
  puts "Acceleration(Y): #{y/1000.0} g"
  puts "Acceleration(Z): #{z/1000.0} g"
  puts ''
end

# Configure threshold for acceleration values X, Y or Z "greater than 2g" (unit is g/1000)
acc.set_acceleration_callback_threshold '>', 2*1000, 0, 2*1000, 0, 2*1000, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
