use std::{error::Error, io, thread};
use tinkerforge::{accelerometer_bricklet::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Accelerometer Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let a = AccelerometerBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get threshold receivers with a debounce time of 10 seconds (10000ms).
    a.set_debounce_period(10000);

    let acceleration_reached_receiver = a.get_acceleration_reached_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `a` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for acceleration_reached in acceleration_reached_receiver {
            println!("Acceleration [X]: {} g", acceleration_reached.x as f32 / 1000.0);
            println!("Acceleration [Y]: {} g", acceleration_reached.y as f32 / 1000.0);
            println!("Acceleration [Z]: {} g", acceleration_reached.z as f32 / 1000.0);
            println!();
        }
    });

    // Configure threshold for acceleration "greater than 2 g, 2 g, 2 g".
    a.set_acceleration_callback_threshold('>', 2 * 1000, 0, 2 * 1000, 0, 2 * 1000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
