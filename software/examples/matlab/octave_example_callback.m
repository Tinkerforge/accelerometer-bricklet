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

% Callback function for acceleration callback
function cb_acceleration(e)
    fprintf("Acceleration(X): %gG\n", (e.x.intValue()/1000.0));
    fprintf("Acceleration(Y): %gG\n", (e.y.intValue()/1000.0));
    fprintf("Acceleration(Z): %gG\n", (e.z.intValue()/1000.0));
end
