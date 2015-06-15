function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "sad"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    acc = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current acceleration
    acceleration = acc.getAcceleration();
    fprintf("Acceleration(X): %gG\n", acceleration.x.intValue()/1000.0);
    fprintf("Acceleration(Y): %gG\n", acceleration.y.intValue()/1000.0);
    fprintf("Acceleration(Z): %gG\n", acceleration.z.intValue()/1000.0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
