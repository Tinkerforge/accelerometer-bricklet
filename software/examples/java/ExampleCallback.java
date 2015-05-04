import com.tinkerforge.BrickletAccelerometer;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
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

		// Set Period for acceleration callback to 1s (1000ms)
		// Note: The acceleration callback is only called every second if the
		//       acceleration has changed since the last call!
		acc.setAccelerationCallbackPeriod(1000);

		// Add and implement acceleration listener (called if acceleration changes)
		acc.addAccelerationListener(new BrickletAccelerometer.AccelerationListener() {
			public void acceleration(short x, short y, short z) {
				System.out.println("Accelerometer(X): " + x/1000.0 + "G");
				System.out.println("Accelerometer(Y): " + y/1000.0 + "G");
				System.out.println("Accelerometer(Z): " + z/1000.0 + "G");
				System.out.println("");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
