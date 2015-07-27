import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAccelerometer;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAccelerometer a = new BrickletAccelerometer(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		a.setDebouncePeriod(10000);

		// Add and implement acceleration reached listener
		// Configure threshold for acceleration values X, Y or Z greater than 2g (unit is g/1000)
		a.setAccelerationCallbackThreshold('>',
		                                   (short)(2*1000), (short)0,
		                                   (short)(2*1000), (short)0,
		                                   (short)(2*1000), (short)0);

		a.addAccelerationReachedListener(
		new BrickletAccelerometer.AccelerationReachedListener() {
			public void accelerationReached(short x, short y, short z) {
				System.out.println("Acceleration(X): " + x/1000.0 + " g");
				System.out.println("Acceleration(Y): " + y/1000.0 + " g");
				System.out.println("Acceleration(Z): " + z/1000.0 + " g");
				System.out.println("");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
