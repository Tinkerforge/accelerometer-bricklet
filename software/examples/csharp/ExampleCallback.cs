using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "sad"; // Change to your UID

	// Callback function for acceleration callback
	static void AccelerationCB(BrickletAccelerometer sender, short x, short y, short z)
	{
		System.Console.WriteLine("Acceleration(X): " + x/1000.0 + "G");
		System.Console.WriteLine("Acceleration(Y): " + y/1000.0 + "G");
		System.Console.WriteLine("Acceleration(Z): " + z/1000.0 + "G");
		System.Console.WriteLine("");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer acc = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for acceleration callback to 1s (1000ms)
		// Note: The color callback is only called every second if the
		//       acceleration has changed since the last call!
		acc.SetAccelerationCallbackPeriod(1000);

		// Register color callback to function AccelerationCB
		acc.Acceleration += AccelerationCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
