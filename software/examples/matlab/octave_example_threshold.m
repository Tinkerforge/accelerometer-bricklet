function octave_example_threshold()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "sad"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    acc = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    acc.setDebouncePeriod(10000);

    % Configure threshold for acceleration values X, Y or Z greater than 2G
    acc.setAccelerationCallbackThreshold(acc.THRESHOLD_OPTION_GREATER, 2000, 0, 2000, 0, 2000, 0);
    
    % Register threshold reached callback to function cb_reached
    acc.addAccelerationReachedCallback(@cb_reached);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for acceleration callback
function cb_reached(e)
    fprintf("Acceleration(X): %gG\n", e.x.intValue()/1000.0);
    fprintf("Acceleration(Y): %gG\n", e.y.intValue()/1000.0);
    fprintf("Acceleration(Z): %gG\n", e.z.intValue()/1000.0);
end
