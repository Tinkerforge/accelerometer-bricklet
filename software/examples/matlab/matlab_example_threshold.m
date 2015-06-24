function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAccelerometer;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'sad'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    acc = BrickletAccelerometer(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    acc.setDebouncePeriod(10000);

    % Register threshold reached callback to function cb_reached
    set(acc, 'AccelerationReachedCallback', @(h, e) cb_reached(e));

    % Configure threshold for acceleration values X, Y or Z "greater than 2g" (unit is g/1000)
    acc.setAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for acceleration callback
function cb_reached(e)
    fprintf('Acceleration(X): %g g\n', e.x/1000.0);
    fprintf('Acceleration(Y): %g g\n', e.y/1000.0);
    fprintf('Acceleration(Z): %g g\n', e.z/1000.0);
end