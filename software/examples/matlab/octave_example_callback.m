function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    a = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register acceleration callback to function cb_acceleration
    a.addAccelerationCallback(@cb_acceleration);

    % Set period for acceleration callback to 1s (1000ms)
    % Note: The acceleration callback is only called every second
    %       if the acceleration has changed since the last call!
    a.setAccelerationCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for acceleration callback (parameters have unit g/1000)
function cb_acceleration(e)
    fprintf("Acceleration[X]: %g g\n", java2int(e.x)/1000.0);
    fprintf("Acceleration[Y]: %g g\n", java2int(e.y)/1000.0);
    fprintf("Acceleration[Z]: %g g\n", java2int(e.z)/1000.0);
    fprintf("\n");
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
