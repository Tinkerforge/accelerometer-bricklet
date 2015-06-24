#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_accelerometer.h"

#define HOST "localhost"
#define PORT 4223
#define UID "sad" // Change to your UID

// Callback for acceleration threshold reached
void cb_reached(int16_t x, int16_t y, int16_t z, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Acceleration(X): %f g\n", x/1000.0);
	printf("Acceleration(Y): %f g\n", y/1000.0);
	printf("Acceleration(Z): %f g\n", z/1000.0);
	printf("\n");
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Accelerometer acc;
	accelerometer_create(&acc, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	accelerometer_set_debounce_period(&acc, 10000);

	// Register threshold reached callback to function cb_reached
	accelerometer_register_callback(&acc,
	                                ACCELEROMETER_CALLBACK_ACCELERATION_REACHED,
	                                (void *)cb_reached,
	                                NULL);

	// Configure threshold for acceleration values X, Y or Z "greater than 2g" (unit is g/1000)
	accelerometer_set_acceleration_callback_threshold(&acc, '>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
