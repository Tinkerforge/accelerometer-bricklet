function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "sad"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    acc = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current acceleration (unit is g/1000)
    acceleration = acc.getAcceleration();

    fprintf("Acceleration(X): %g g\n", short2int(acceleration.x)/1000.0);
    fprintf("Acceleration(Y): %g g\n", short2int(acceleration.y)/1000.0);
    fprintf("Acceleration(Z): %g g\n", short2int(acceleration.z)/1000.0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

function int = short2int(short)
    if compare_versions(version(), "3.8", "<=")
        int = short.intValue();
    else
        int = short;
    end
end
