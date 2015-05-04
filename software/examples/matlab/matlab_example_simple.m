function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAccelerometer;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'sad'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    acc = BrickletAccelerometer(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current acceleration
    acceleration = acc.getAcceleration();
    fprintf('Acceleration(X): %gG\n', acceleration.x/1000.0);
    fprintf('Acceleration(Y): %gG\n', acceleration.y/1000.0);
    fprintf('Acceleration(Z): %gG\n', acceleration.z/1000.0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
