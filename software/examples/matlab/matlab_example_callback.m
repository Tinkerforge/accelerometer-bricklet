function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAccelerometer;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Accelerometer Bricklet

    ipcon = IPConnection(); % Create IP connection
    a = handle(BrickletAccelerometer(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register acceleration callback to function cb_acceleration
    set(a, 'AccelerationCallback', @(h, e) cb_acceleration(e));

    % Set period for acceleration callback to 1s (1000ms)
    % Note: The acceleration callback is only called every second
    %       if the acceleration has changed since the last call!
    a.setAccelerationCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for acceleration callback
function cb_acceleration(e)
    fprintf('Acceleration [X]: %g g\n', e.x/1000.0);
    fprintf('Acceleration [Y]: %g g\n', e.y/1000.0);
    fprintf('Acceleration [Z]: %g g\n', e.z/1000.0);
    fprintf('\n');
end
