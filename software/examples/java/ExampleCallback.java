import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAccelerometer;

public class ExampleCallback {
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

		// Add acceleration listener
		a.addAccelerationListener(new BrickletAccelerometer.AccelerationListener() {
			public void acceleration(short x, short y, short z) {
				System.out.println("Acceleration [X]: " + x/1000.0 + " g");
				System.out.println("Acceleration [Y]: " + y/1000.0 + " g");
				System.out.println("Acceleration [Z]: " + z/1000.0 + " g");
				System.out.println("");
			}
		});

		// Set period for acceleration callback to 1s (1000ms)
		// Note: The acceleration callback is only called every second
		//       if the acceleration has changed since the last call!
		a.setAccelerationCallbackPeriod(1000);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
