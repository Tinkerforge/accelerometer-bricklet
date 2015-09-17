function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    a = java_new("com.tinkerforge.BrickletAccelerometer", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current acceleration (unit is g/1000)
    acceleration = a.getAcceleration();

    fprintf("Acceleration[X]: %g g\n", java2int(acceleration.x)/1000.0);
    fprintf("Acceleration[Y]: %g g\n", java2int(acceleration.y)/1000.0);
    fprintf("Acceleration[Z]: %g g\n", java2int(acceleration.z)/1000.0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
