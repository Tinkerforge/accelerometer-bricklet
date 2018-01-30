#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_accelerometer'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Accelerometer Bricklet

ipcon = IPConnection.new # Create IP connection
a = BrickletAccelerometer.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register acceleration callback
a.register_callback(BrickletAccelerometer::CALLBACK_ACCELERATION) do |x, y, z|
  puts "Acceleration [X]: #{x/1000.0} g"
  puts "Acceleration [Y]: #{y/1000.0} g"
  puts "Acceleration [Z]: #{z/1000.0} g"
  puts ''
end

# Set period for acceleration callback to 1s (1000ms)
# Note: The acceleration callback is only called every second
#       if the acceleration has changed since the last call!
a.set_acceleration_callback_period 1000

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
