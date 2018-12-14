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

	// Get current acceleration.
	x, y, z, _ := a.GetAcceleration()

	fmt.Printf("Acceleration [X]: %f g\n", float64(x)/1000.0)
	fmt.Printf("Acceleration [Y]: %f g\n", float64(y)/1000.0)
	fmt.Printf("Acceleration [Z]: %f g\n", float64(z)/1000.0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
