import com.tinkerforge.BrickletAccelerometer;
import com.tinkerforge.BrickletAccelerometer.Acceleration;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "sad"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer acc = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current acceleration
		Acceleration a = acc.getAcceleration(); // Can throw com.tinkerforge.TimeoutException

		System.out.println("Acceleration(X): " + a.x / 1000.0 + "G");
		System.out.println("Acceleration(Y): " + a.y / 1000.0 + "G");
		System.out.println("Acceleration(Z): " + a.z / 1000.0 + "G");
		System.out.println("");

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
