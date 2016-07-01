function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAccelerometer;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Accelerometer Bricklet

    ipcon = IPConnection(); % Create IP connection
    a = handle(BrickletAccelerometer(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current acceleration (unit is g/1000)
    acceleration = a.getAcceleration();

    fprintf('Acceleration[X]: %g g\n', acceleration.x/1000.0);
    fprintf('Acceleration[Y]: %g g\n', acceleration.y/1000.0);
    fprintf('Acceleration[Z]: %g g\n', acceleration.z/1000.0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
