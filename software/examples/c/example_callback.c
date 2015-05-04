#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_accelerometer.h"

#define HOST "localhost"
#define PORT 4223
#define UID "sad" // Change to your UID

// Callback for acceleration
void cb_acceleration(int16_t x, int16_t y, int16_t z, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Acceleration(X): %fG\n", x/1000.0);
	printf("Acceleration(Y): %fG\n", y/1000.0);
	printf("Acceleration(Z): %fG\n", z/1000.0);
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

	// Set Period for acceleration callback to 1s (1000ms)
	// Note: The callback is only called every second if the
	//       acceleration has changed since the last call!
	accelerometer_set_acceleration_callback_period(&acc, 1000);

	// Register color callback to function cb_acceleration
	accelerometer_register_callback(&acc,
	                                ACCELEROMETER_CALLBACK_ACCELERATION,
	                                (void *)cb_acceleration/1000.0,
	                                NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
