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

    // Create receiver for acceleration events.
    let acceleration_receiver = a.get_acceleration_receiver();

    // Spawn thread to handle received events. This thread ends when the `a` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for acceleration in acceleration_receiver {
            println!("Acceleration [X]: {} g", acceleration.x as f32 / 1000.0);
            println!("Acceleration [Y]: {} g", acceleration.y as f32 / 1000.0);
            println!("Acceleration [Z]: {} g", acceleration.z as f32 / 1000.0);
            println!();
        }
    });

    // Set period for acceleration receiver to 1s (1000ms).
    // Note: The acceleration callback is only called every second
    //       if the acceleration has changed since the last call!
    a.set_acceleration_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
