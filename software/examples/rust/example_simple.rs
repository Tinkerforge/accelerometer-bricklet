use std::{error::Error, io};

use tinkerforge::{accelerometer_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Accelerometer Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let accelerometer_bricklet = AccelerometerBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get current acceleration
    let get_acceleration_result = accelerometer_bricklet.get_acceleration().recv()?;

    println!("Acceleration [X]: {}{}", get_acceleration_result.x as f32 / 1000.0, " g");
    println!("Acceleration [Y]: {}{}", get_acceleration_result.y as f32 / 1000.0, " g");
    println!("Acceleration [Z]: {}{}", get_acceleration_result.z as f32 / 1000.0, " g");

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
