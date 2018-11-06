use std::{error::Error, io, thread};
use tinkerforge::{accelerometer_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Accelerometer Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let accelerometer_bricklet = AccelerometerBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 10 seconds (10000ms)
    accelerometer_bricklet.set_debounce_period(10000);

    //Create listener for acceleration reached events.
    let acceleration_reached_listener = accelerometer_bricklet.get_acceleration_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the accelerometer_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in acceleration_reached_listener {
            println!("Acceleration [X]: {}{}", event.x as f32 / 1000.0, " g");
            println!("Acceleration [Y]: {}{}", event.y as f32 / 1000.0, " g");
            println!("Acceleration [Z]: {}{}", event.z as f32 / 1000.0, " g");
            println!();
        }
    });

    // Configure threshold for acceleration "greater than 2 g, 2 g, 2 g"
    accelerometer_bricklet.set_acceleration_callback_threshold('>', 2 * 1000, 0, 2 * 1000, 0, 2 * 1000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
