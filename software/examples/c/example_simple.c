#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_accelerometer.h"

#define HOST "localhost"
#define PORT 4223
#define UID "sad" // Change to your UID

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

	// Get current acceleration
	int16_t x; int16_t y; int16_t z;
	if(accelerometer_get_acceleration(&acc, &x, &y, &z) < 0) {
		fprintf(stderr, "Could not get value, probably timeout\n");
		exit(1);
	}

	printf("Acceleration(X): %fG\n", x/1000.0);
	printf("Acceleration(Y): %fG\n", y/1000.0);
	printf("Acceleration(Z): %fG\n", z/1000.0);
	printf("\n");

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
