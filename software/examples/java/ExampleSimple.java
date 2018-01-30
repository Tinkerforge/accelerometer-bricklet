import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAccelerometer;
import com.tinkerforge.BrickletAccelerometer.Acceleration;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Accelerometer Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer a = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current acceleration
		Acceleration acceleration = a.getAcceleration(); // Can throw com.tinkerforge.TimeoutException

		System.out.println("Acceleration [X]: " + acceleration.x/1000.0 + " g");
		System.out.println("Acceleration [Y]: " + acceleration.y/1000.0 + " g");
		System.out.println("Acceleration [Z]: " + acceleration.z/1000.0 + " g");

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
