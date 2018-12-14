package main

import (
	"fmt"
	"tinkerforge/accelerometer_bricklet"
	"tinkerforge/ipconnection"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Accelerometer Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	a, _ := accelerometer_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	a.SetDebouncePeriod(10000)

	a.RegisterAccelerationReachedCallback(func(x int16, y int16, z int16) {
		fmt.Printf("Acceleration [X]: %d g\n", float64(x)/1000.0)
		fmt.Printf("Acceleration [Y]: %d g\n", float64(y)/1000.0)
		fmt.Printf("Acceleration [Z]: %d g\n", float64(z)/1000.0)
		fmt.Println()
	})

	// Configure threshold for acceleration "greater than 2 g, 2 g, 2 g".
	a.SetAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
