using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "sad"; // Change to your UID

	static void Main()
	{
		IPConnection ipcon = new Tinkerforge.IPConnection(); // Create IP connection
		BrickletAccelerometer acc = new Tinkerforge.BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current acceleration
		short x; short y; short z;
		acc.GetAcceleration(out x, out y, out z);

		System.Console.WriteLine("Acceleration(X): " + x/1000.0 + "G");
		System.Console.WriteLine("Acceleration(Y): " + y/1000.0 + "G");
		System.Console.WriteLine("Acceleration(Z): " + z/1000.0 + "G");
		System.Console.WriteLine("");

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
