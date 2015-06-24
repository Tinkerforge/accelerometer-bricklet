function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAccelerometer;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'sad'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    acc = BrickletAccelerometer(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for acceleration callback to 1s (1000ms)
    % Note: The acceleration is only called every second if the
    %       acceleration has changed since the last call!
    acc.setAccelerationCallbackPeriod(1000);

    % Register acceleration callback to function cb_acceleration
    set(acc, 'AccelerationCallback', @(h, e) cb_acceleration(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for acceleration callback (parameters have unit g/1000)
function cb_acceleration(e)
    fprintf('Acceleration(X): %g g\n', e.x/1000.0);
    fprintf('Acceleration(Y): %g g\n', e.y/1000.0);
    fprintf('Acceleration(Z): %g g\n', e.z/1000.0);
end
