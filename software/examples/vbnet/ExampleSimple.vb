Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "sad" ' Change to your UID

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim acc As New BrickletAccelerometer(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get current acceleration (unit is g/1000)
        Dim x As Short
        Dim y As Short
        Dim z As Short

        acc.GetAcceleration(x, y, z)

        System.Console.WriteLine("Acceleration(X): " + (x/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Y): " + (y/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Z): " + (z/1000.0).ToString() + " g")

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
