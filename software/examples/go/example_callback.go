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

	a.RegisterAccelerationCallback(func(x int16, y int16, z int16) {
		fmt.Printf("Acceleration [X]: %d g\n", float64(x)/1000.0)
		fmt.Printf("Acceleration [Y]: %d g\n", float64(y)/1000.0)
		fmt.Printf("Acceleration [Z]: %d g\n", float64(z)/1000.0)
		fmt.Println()
	})

	// Set period for acceleration receiver to 1s (1000ms).
	// Note: The acceleration callback is only called every second
	//       if the acceleration has changed since the last call!
	a.SetAccelerationCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
