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

    //Create listener for acceleration events.
    let acceleration_listener = accelerometer_bricklet.get_acceleration_receiver();
    // Spawn thread to handle received events. This thread ends when the accelerometer_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in acceleration_listener {
            println!("Acceleration [X]: {}{}", event.x as f32 / 1000.0, " g");
            println!("Acceleration [Y]: {}{}", event.y as f32 / 1000.0, " g");
            println!("Acceleration [Z]: {}{}", event.z as f32 / 1000.0, " g");
            println!();
        }
    });

    // Set period for acceleration listener to 1s (1000ms)
    // Note: The acceleration callback is only called every second
    //       if the acceleration has changed since the last call!
    accelerometer_bricklet.set_acceleration_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
