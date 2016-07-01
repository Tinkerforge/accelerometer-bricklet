Imports System
Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Accelerometer Bricklet

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim a As New BrickletAccelerometer(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get current acceleration (unit is g/1000)
        Dim x As Short
        Dim y As Short
        Dim z As Short

        a.GetAcceleration(x, y, z)

        Console.WriteLine("Acceleration[X]: " + (x/1000.0).ToString() + " g")
        Console.WriteLine("Acceleration[Y]: " + (y/1000.0).ToString() + " g")
        Console.WriteLine("Acceleration[Z]: " + (z/1000.0).ToString() + " g")

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
