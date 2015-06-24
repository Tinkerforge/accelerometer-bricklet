using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "sad"; // Change to your UID

	// Callback for acceleration threshold reached
	static void ReachedCB(BrickletAccelerometer sender, short x, short y, short z)
	{
		System.Console.WriteLine("Acceleration(X): " + x/1000.0 + " g");
		System.Console.WriteLine("Acceleration(Y): " + y/1000.0 + " g");
		System.Console.WriteLine("Acceleration(Z): " + z/1000.0 + " g");
		System.Console.WriteLine("");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer acc = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		acc.SetDebouncePeriod(10000);

		// Register threshold reached callback to function ReachedCB
		acc.AccelerationReached += ReachedCB;

		// Configure threshold for acceleration for X, Y or Z "greater than 2g" (unit is g/1000)
		acc.SetAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
