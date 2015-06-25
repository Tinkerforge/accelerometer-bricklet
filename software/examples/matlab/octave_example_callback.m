function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "sad"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    acc = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for acceleration callback to 1s (1000ms)
    % Note: The acceleration callback is only called every second if the
    %       acceleration has changed since the last call!
    acc.setAccelerationCallbackPeriod(1000);

    % Register acceleration callback to function cb_acceleration
    acc.addAccelerationCallback(@cb_acceleration);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for acceleration callback (parameters have unit g/1000)
function cb_acceleration(e)
    fprintf("Acceleration(X): %g g\n", short2int(e.x)/1000.0);
    fprintf("Acceleration(Y): %g g\n", short2int(e.y)/1000.0);
    fprintf("Acceleration(Z): %g g\n", short2int(e.z)/1000.0);
    fprintf("\n");
end

function int = short2int(short)
    if compare_versions(version(), "3.8", "<=")
        int = short.intValue();
    else
        int = short;
    end
end
