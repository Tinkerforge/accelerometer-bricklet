using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Accelerometer Bricklet

	// Callback function for acceleration reached callback
	static void AccelerationReachedCB(BrickletAccelerometer sender, short x, short y,
	                                  short z)
	{
		Console.WriteLine("Acceleration [X]: " + x/1000.0 + " g");
		Console.WriteLine("Acceleration [Y]: " + y/1000.0 + " g");
		Console.WriteLine("Acceleration [Z]: " + z/1000.0 + " g");
		Console.WriteLine("");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer a = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		a.SetDebouncePeriod(10000);

		// Register acceleration reached callback to function AccelerationReachedCB
		a.AccelerationReachedCallback += AccelerationReachedCB;

		// Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
		a.SetAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
