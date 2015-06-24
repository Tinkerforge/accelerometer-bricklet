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

# Set Period for acceleration callback to 1s (1000ms)
# Note: The callback is only called every second if the
#       acceleration has changed since the last call!
acc.set_acceleration_callback_period 1000

# Register acceleration callback (parameters have unit g/1000)
acc.register_callback(BrickletAccelerometer::CALLBACK_ACCELERATION) do |x, y, z|
  puts "Acceleration(X): #{x/1000.0} g"
  puts "Acceleration(Y): #{y/1000.0} g"
  puts "Acceleration(Z): #{z/1000.0} g"
  puts ''
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
