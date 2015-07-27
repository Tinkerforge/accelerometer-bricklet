#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_accelerometer.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Accelerometer a;
	accelerometer_create(&a, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get current acceleration (unit is g/1000)
	int16_t x; int16_t y; int16_t z;
	if(accelerometer_get_acceleration(&a, &x, &y, &z) < 0) {
		fprintf(stderr, "Could not get value, probably timeout\n");
		exit(1);
	}

	printf("Acceleration(X): %f g\n", x/1000.0);
	printf("Acceleration(Y): %f g\n", y/1000.0);
	printf("Acceleration(Z): %f g\n", z/1000.0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
