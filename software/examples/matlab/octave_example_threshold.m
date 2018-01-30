function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Accelerometer Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    a = javaObject("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    a.setDebouncePeriod(10000);

    % Register acceleration reached callback to function cb_acceleration_reached
    a.addAccelerationReachedCallback(@cb_acceleration_reached);

    % Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
    a.setAccelerationCallbackThreshold(">", 2*1000, 0, 2*1000, 0, 2*1000, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for acceleration reached callback
function cb_acceleration_reached(e)
    fprintf("Acceleration [X]: %g g\n", java2int(e.x)/1000.0);
    fprintf("Acceleration [Y]: %g g\n", java2int(e.y)/1000.0);
    fprintf("Acceleration [Z]: %g g\n", java2int(e.z)/1000.0);
    fprintf("\n");
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
