using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer a = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current acceleration (unit is g/1000)
		short x; short y; short z;
		a.GetAcceleration(out x, out y, out z);

		System.Console.WriteLine("Acceleration(X): " + x/1000.0 + " g");
		System.Console.WriteLine("Acceleration(Y): " + y/1000.0 + " g");
		System.Console.WriteLine("Acceleration(Z): " + z/1000.0 + " g");

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
